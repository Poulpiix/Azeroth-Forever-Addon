-- Azeroth Forever : interface (/af). Un seul mode (build de classe, plus
-- d'Héritage dans l'UI). Fenêtre 1100x720 : titre, bandeau de 9 icônes de
-- classe centré, bannière de classe (image non déformée, cover-fit),
-- GAUCHE ~70% (les 3 arbres), DROITE ~30% (un seul panneau, compact), frise
-- 10-60 en bas. Le panneau droit ancre son bord gauche sur le bord droit du
-- panneau gauche : le non-chevauchement est garanti par construction.
local ADDON_NAME, AF = ...

local UI = {}
AF.UI = UI

local BP = AF.BuildPath
local Talents = AF.Talents

-- ---------- Layout ----------

local WIN_W, WIN_H = 1100, 720
local TITLE_H, CLASS_BAR_H, BANNER_GAP, BANNER_H = 34, 28, 6, 80
local MARGIN, PANEL_GAP = 10, 10
local LEFT_RATIO = 0.68
local ACTION_H, FRISE_H = 26, 54
local ICON, RANK_H, ROW_GAP = 36, 14, 8
local TALENT_COLS = 4

-- Aspect connu des bannières (1400x292, voir tools/convert-textures.py) :
-- WoW n'a pas d'API pour lire les dimensions réelles d'une texture en jeu,
-- donc ce ratio est câblé en dur. Si une bannière a un autre format, le
-- cover-fit sera simplement un peu décalé, jamais cassé (SetTexCoord ne
-- plante pas).
local BANNER_SRC_W, BANNER_SRC_H = 1400, 292

-- Fond d'arbre de talent (tools/convert-textures.py, clé "tree_" .. tree.id) :
-- toutes les images exportées du site font 300x331 (portrait, comme une
-- colonne d'arbre). Même logique de câblage en dur que BANNER_SRC_W/H.
local TREE_BG_SRC_W, TREE_BG_SRC_H = 300, 331

-- Toutes les classes ont exactement 7 rangées de talents (vérifié dans
-- data/talents-data.js) : sert à calculer un pas de grille qui tient
-- toujours dans la hauteur réelle du cadre, sans dépasser (pas de
-- SetClipsChildren fiable sur ce client).
local TREE_ROWS = 7

-- Classes jouables (mêmes id que AF.Data.Constants.CLASS_SLUGS), dans l'ordre
-- des id WoW standard.
local CLASS_ORDER = { 1, 2, 3, 4, 5, 7, 8, 9, 11 }

-- ---------- Thème (site Azeroth Forever) ----------

local function hex(h, a)
  local r = math.floor(h / 0x10000) % 0x100
  local g = math.floor(h / 0x100) % 0x100
  local b = h % 0x100
  return { r / 255, g / 255, b / 255, a or 1 }
end

local BG = hex(0x0b1220)
local PANEL_BG = { 0.07, 0.10, 0.16, 1 }
local PANEL_BG_SOFT = { 0.07, 0.10, 0.16, 0.5 } -- panneau droit + frise : plus transparents
local CADRE_BG = { 0.05, 0.08, 0.13, 0.82 } -- alpha < 1 : laisse transparaître un fond d'arbre
local TREE_ART_VEIL = { 0.02, 0.03, 0.05, 0.55 } -- voile sombre sur les fonds d'arbre persos (lisibilité des icônes)
local GOLD = hex(0xc9a227)
local GOLD_DIM = { 0.50, 0.41, 0.15, 1 }
local TEXT = hex(0xe8e0d0)
local TEXT_DIM = { 0.58, 0.56, 0.52 }
local TEXT_OK = { 0.45, 0.85, 0.45 }

-- Voile de fond de fenêtre teinté par faction (comme le site) : bleu plus
-- foncé pour Alliance, rouge plus foncé pour Horde, jamais le même bleu
-- neutre pour les deux.
local FACTION_VEIL_COLORS = {
  alliance = { 0.04, 0.07, 0.15, 0.82 },
  horde = { 0.18, 0.03, 0.03, 0.82 }
}

local WHITE = "Interface\\Buttons\\WHITE8X8"

-- ---------- Résolution des textures : client d'abord, notre TGA ensuite ----------
--
-- WoW n'a pas d'API pour tester si un fichier existe : SetTexture sur un
-- chemin absent ne plante jamais, mais reste invisible sans qu'on puisse le
-- distinguer d'une vraie image transparente. Le manifeste généré par
-- tools/convert-textures.py (AF.Data.TextureManifest) lève cette ambiguïté
-- pour NOS textures.
--
-- Extension : nos fichiers sont de vrais .tga sur disque (pas des .blp) ;
-- contrairement aux textures Blizzard, le chemin doit inclure l'extension
-- pour être trouvé de façon fiable. On la garde ici pour toute texture
-- perso, et pour le fond de fenêtre spécifiquement on log aussi le chemin
-- essayé (cf. ApplyFactionBackground) pour pouvoir vérifier en jeu.
local ADDON_TEXTURE_DIR = "Interface\\AddOns\\AzerothForever\\Textures\\"

local function HasCustomTexture(key)
  return AF.Data.TextureManifest ~= nil and AF.Data.TextureManifest[key] == true
end

local function CustomTexturePath(key)
  return ADDON_TEXTURE_DIR .. key .. ".tga"
end

local CLASS_FILE_BY_ID = {
  [1] = "WARRIOR", [2] = "PALADIN", [3] = "HUNTER", [4] = "ROGUE", [5] = "PRIEST",
  [7] = "SHAMAN", [8] = "MAGE", [9] = "WARLOCK", [11] = "DRUID"
}

local function ResolveClassIcon(cls)
  if not cls then return "Interface\\Icons\\INV_Misc_QuestionMark" end
  local classFile = CLASS_FILE_BY_ID[cls.id]
  local key = classFile and ("class_" .. classFile:lower())
  if key and HasCustomTexture(key) then
    return CustomTexturePath(key)
  end
  if cls.icon then
    return "Interface\\Icons\\" .. cls.icon
  end
  return "Interface\\Icons\\INV_Misc_QuestionMark"
end

-- Fond opaque uni (pas de SetBackdrop : absent sur ce client).
local function Fill(frame, color)
  if not frame.afBg then
    local bg = frame:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints(frame)
    bg:SetTexture(WHITE)
    frame.afBg = bg
  end
  frame.afBg:SetVertexColor(unpack(color or PANEL_BG))
  if frame.SetClipsChildren then pcall(frame.SetClipsChildren, frame, true) end
end

-- Filet or 2px sur les 4 bords (pas de texture DialogFrame à 9-cases : sans
-- SetBackdrop il n'y a pas de tuilage fiable, un simple filet est robuste à
-- n'importe quelle taille de cadre).
local function GoldEdge(frame, thickness, color)
  thickness = thickness or 2
  color = color or GOLD
  local function strip()
    local t = frame:CreateTexture(nil, "BORDER")
    t:SetTexture(WHITE)
    t:SetVertexColor(unpack(color))
    return t
  end
  local top, bottom, left, right = strip(), strip(), strip(), strip()
  top:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
  top:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 0)
  top:SetHeight(thickness)
  bottom:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 0, 0)
  bottom:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 0)
  bottom:SetHeight(thickness)
  left:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
  left:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 0, 0)
  left:SetWidth(thickness)
  right:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 0)
  right:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 0)
  right:SetWidth(thickness)
  return { top, bottom, left, right }
end

local function GoldText(fontString)
  fontString:SetTextColor(unpack(GOLD))
  return fontString
end

-- Véritable bordure en 4 filets fins autour d'un bouton (icône), pas un
-- rectangle plein en surimpression : c'est ce dernier qui donnait l'effet
-- "glow" moche (toute l'icône teintée) au lieu d'un simple bord propre.
local function MakeIconBorder(btn, thickness)
  thickness = thickness or 2
  local function strip()
    local t = btn:CreateTexture(nil, "OVERLAY")
    t:SetTexture(WHITE)
    return t
  end
  local top, bottom, left, right = strip(), strip(), strip(), strip()
  top:SetPoint("TOPLEFT", btn, "TOPLEFT", -thickness, thickness)
  top:SetPoint("TOPRIGHT", btn, "TOPRIGHT", thickness, thickness)
  top:SetHeight(thickness)
  bottom:SetPoint("BOTTOMLEFT", btn, "BOTTOMLEFT", -thickness, -thickness)
  bottom:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", thickness, -thickness)
  bottom:SetHeight(thickness)
  left:SetPoint("TOPLEFT", btn, "TOPLEFT", -thickness, thickness)
  left:SetPoint("BOTTOMLEFT", btn, "BOTTOMLEFT", -thickness, -thickness)
  left:SetWidth(thickness)
  right:SetPoint("TOPRIGHT", btn, "TOPRIGHT", thickness, thickness)
  right:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", thickness, -thickness)
  right:SetWidth(thickness)
  local strips = { top, bottom, left, right }
  return {
    SetColor = function(_, r, g, b, a)
      for _, s in ipairs(strips) do s:SetVertexColor(r, g, b, a) end
    end,
    Hide = function() for _, s in ipairs(strips) do s:Hide() end end,
    Show = function() for _, s in ipairs(strips) do s:Show() end end
  }
end

-- Ancre le GameTooltip juste à côté de l'élément survolé (jamais collé au
-- bord de l'écran) : à droite si la moitié gauche de l'écran a plus de
-- place, à gauche sinon. Un simple ANCHOR_RIGHT/ANCHOR_LEFT fixe pousse la
-- pastille de frise ou une ligne du panneau droit (déjà proche du bord
-- droit de l'écran) hors champ ; ceci choisit toujours le côté qui a de la
-- place.
local function AnchorTooltipNear(owner)
  GameTooltip:SetOwner(owner, "ANCHOR_NONE")
  local x = owner:GetCenter()
  local screenW = UIParent:GetWidth()
  if x and screenW and x > screenW / 2 then
    GameTooltip:SetPoint("TOPRIGHT", owner, "TOPLEFT", -6, 0)
  else
    GameTooltip:SetPoint("TOPLEFT", owner, "TOPRIGHT", 6, 0)
  end
end

-- Cover-fit (comme CSS background-size:cover) via SetTexCoord : l'image
-- remplit tout le cadre sans être déformée, en rognant le surplus (haut/bas
-- ou côtés selon le cas) plutôt que de l'étirer.
local function ApplyCoverFit(texture, frameW, frameH, srcW, srcH)
  if frameW <= 0 or frameH <= 0 or srcW <= 0 or srcH <= 0 then
    texture:SetTexCoord(0, 1, 0, 1)
    return
  end
  local scale = math.max(frameW / srcW, frameH / srcH)
  local scaledW, scaledH = srcW * scale, srcH * scale
  local cropX = math.max(0, (1 - frameW / scaledW) / 2)
  local cropY = math.max(0, (1 - frameH / scaledH) / 2)
  texture:SetTexCoord(cropX, 1 - cropX, cropY, 1 - cropY)
end

-- ---------- Fenêtre ----------

function UI:OnFrameLoad(frame)
  self.frame = frame
  frame:SetSize(WIN_W, WIN_H)
  frame:SetFrameStrata("DIALOG")
  frame:ClearAllPoints()
  frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
  frame:RegisterForDrag("LeftButton")
  GoldEdge(frame, 2)

  if frame.Title then GoldText(frame.Title) end

  local sections = {
    { "BuildClassBar", self.BuildClassBar },
    { "BuildBannerRow", self.BuildBannerRow },
    { "BuildMainArea", self.BuildMainArea },
    { "BuildBottomBlock", self.BuildBottomBlock }
  }
  for _, section in ipairs(sections) do
    local name, fn = section[1], section[2]
    local ok, err = pcall(fn, self)
    if not ok then
      AF:Print("Erreur d'interface (" .. name .. ") : " .. tostring(err))
    end
  end

  self:ApplyFactionBackground()
end

function UI:OnFrameShow()
  AF.classId = AF.classId or AF:GetPlayerClassId()
  self.selectedClassId = self.selectedClassId or AF.classId or CLASS_ORDER[1]
  self:UpdateClassBarStyles()
  self:RefreshAll()
end

function UI:Toggle()
  if not self.frame then return end
  if self.frame:IsShown() then self.frame:Hide() else self.frame:Show() end
end

function UI:Hide()
  if self.frame then self.frame:Hide() end
end

-- Classe actuellement affichée/éditée dans l'UI (peut différer de la classe
-- réelle du personnage : bandeau de classes en haut, comme le site). Seules
-- Appliquer suivant/tout agissent toujours sur AF.classId (la vraie classe).
function UI:GetDisplayClassId()
  return self.selectedClassId or AF.classId
end

function UI:SelectClass(classId)
  self.selectedClassId = classId
  self:UpdateClassBarStyles()
  self:RefreshAll()
end

-- « Appris en jeu » n'a de sens que pour la classe réellement jouée : lire
-- GetTalentInfo pour une autre classe renverrait l'état des arbres du
-- personnage réel, pas des rangs vides comme on pourrait le croire.
function UI:IsDisplayingOwnClass()
  return self:GetDisplayClassId() == AF.classId
end

function UI:GetActualRanksForDisplay(classId)
  if classId and classId == AF.classId then
    return Talents:GetActualRanks(classId)
  end
  return {}
end

-- ---------- Noms / icônes / tooltips = jeu ----------
--
-- Pour un talent affiché (arbre, plan, prochain point, frise) : si c'est la
-- classe réellement jouée, on retrouve son vrai emplacement client
-- (Talents:FindGameSlot, déjà utilisé par Appliquer) et on prend son icône
-- ET son tooltip directement du jeu (GameTooltip:SetTalent). Sinon, repli
-- sur les données de l'addon — jamais inventées, telles quelles depuis
-- data/talents-data.js.
function UI:GetTalentDisplay(entry)
  if self:IsDisplayingOwnClass() and type(GetTalentInfo) == "function" then
    local tabIndex, talentIndex = Talents:FindGameSlot(entry)
    if tabIndex then
      local name, icon = GetTalentInfo(tabIndex, talentIndex)
      if icon then
        return { icon = icon, name = name or entry.talent.name, tabIndex = tabIndex, talentIndex = talentIndex }
      end
    end
  end
  return { icon = "Interface\\Icons\\" .. (entry.talent.icon or "INV_Misc_QuestionMark"), name = entry.talent.name }
end

function UI:ShowTalentTooltip(owner, entry)
  AnchorTooltipNear(owner)
  if self:IsDisplayingOwnClass() and type(GetTalentInfo) == "function" and GameTooltip.SetTalent then
    local tabIndex, talentIndex = Talents:FindGameSlot(entry)
    if tabIndex then
      local ok = pcall(GameTooltip.SetTalent, GameTooltip, tabIndex, talentIndex)
      if ok then
        GameTooltip:Show()
        return
      end
    end
  end
  -- Repli : notre propre texte, tel quel depuis les données (rien d'inventé).
  GameTooltip:SetText(entry.talent.name, 1, 1, 1)
  for i = 1, entry.talent.maxRank do
    local r = entry.talent.ranks[i]
    if r and r.desc and r.desc ~= "" then
      GameTooltip:AddLine("Rang " .. i .. " : " .. r.desc, 0.9, 0.9, 0.9, true)
    end
  end
  GameTooltip:Show()
end

-- ---------- Bandeau de classes (comme le site), CENTRÉ ----------

function UI:BuildClassBar()
  local bar = CreateFrame("Frame", nil, self.frame)
  bar:SetPoint("TOPLEFT", self.frame, "TOPLEFT", MARGIN, -TITLE_H)
  bar:SetPoint("TOPRIGHT", self.frame, "TOPRIGHT", -MARGIN, -TITLE_H)
  bar:SetHeight(CLASS_BAR_H)
  self.classBar = bar
  self.classBarButtons = {}

  local size = 24
  local gap = 6
  local n = #CLASS_ORDER
  local cluster = CreateFrame("Frame", nil, bar)
  cluster:SetSize(n * size + (n - 1) * gap, CLASS_BAR_H)
  cluster:SetPoint("TOP", bar, "TOP", 0, 0) -- centré horizontalement

  local prevBtn
  for _, classId in ipairs(CLASS_ORDER) do
    local cls = AF:GetClassData(classId)
    if cls then
      local btn = CreateFrame("Button", nil, cluster)
      btn:SetSize(size, size)
      if prevBtn then
        btn:SetPoint("LEFT", prevBtn, "RIGHT", gap, 0)
      else
        btn:SetPoint("LEFT", cluster, "LEFT", 0, 0)
      end

      local icon = btn:CreateTexture(nil, "ARTWORK")
      icon:SetAllPoints()
      icon:SetTexture(ResolveClassIcon(cls))
      btn.icon = icon
      btn.border = MakeIconBorder(btn, 2)
      btn.border:Hide()

      btn:SetScript("OnClick", function() UI:SelectClass(classId) end)
      btn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(cls.name, 1, 1, 1)
        GameTooltip:Show()
      end)
      btn:SetScript("OnLeave", function() GameTooltip:Hide() end)

      self.classBarButtons[classId] = btn
      prevBtn = btn
    end
  end

  -- Bouton Alliance/Horde : coin haut-droit de la fenêtre, séparé du
  -- cluster centré pour qu'il reste toujours atteignable.
  local factionBtn = CreateFrame("Button", nil, bar)
  factionBtn:SetSize(size, size)
  factionBtn:SetPoint("RIGHT", bar, "RIGHT", -2, 0)
  local factionIcon = factionBtn:CreateTexture(nil, "ARTWORK")
  factionIcon:SetAllPoints()
  factionBtn.icon = factionIcon
  factionBtn:SetScript("OnClick", function()
    local current = AzerothForeverDB.options.faction or "alliance"
    AzerothForeverDB.options.faction = (current == "alliance") and "horde" or "alliance"
    UI:RefreshFactionButton()
    UI:ApplyFactionBackground()
  end)
  factionBtn:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_LEFT")
    GameTooltip:SetText("Alliance / Horde : change le fond de la fenêtre", 1, 1, 1)
    GameTooltip:Show()
  end)
  factionBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)
  self.factionBtn = factionBtn
  self:RefreshFactionButton()
end

local FACTION_ICONS = {
  alliance = "Interface\\TargetingFrame\\UI-PVP-Alliance",
  horde = "Interface\\TargetingFrame\\UI-PVP-Horde"
}

function UI:RefreshFactionButton()
  if not self.factionBtn then return end
  local faction = (AzerothForeverDB and AzerothForeverDB.options.faction) or "alliance"
  local key = "banner_" .. faction
  if HasCustomTexture(key) then
    self.factionBtn.icon:SetTexture(CustomTexturePath(key))
  else
    self.factionBtn.icon:SetTexture(FACTION_ICONS[faction])
  end
end

-- Fond de FENÊTRE, pleine fenêtre (SetAllPoints sur le frame racine, couche
-- BACKGROUND) : bannière de faction (Alliance = banner_alliance.tga,
-- Horde = banner_horde.tga) + voile bleu #0b1220 par-dessus pour rester
-- lisible ; à défaut, une teinte plate. WoW n'a pas d'API pour confirmer
-- qu'un fichier existe : on affiche dans le chat le chemin exact essayé
-- pour pouvoir vérifier en jeu, plutôt que de laisser un noir uni muet.
function UI:ApplyFactionBackground()
  if not self.frame then return end
  local faction = (AzerothForeverDB and AzerothForeverDB.options.faction) or "alliance"
  local key = "banner_" .. faction

  if not self.frame.factionArt then
    local art = self.frame:CreateTexture(nil, "BACKGROUND")
    art:SetAllPoints(self.frame)
    self.frame.factionArt = art
    local veil = self.frame:CreateTexture(nil, "BACKGROUND")
    veil:SetAllPoints(self.frame)
    veil:SetTexture(WHITE)
    self.frame.factionVeil = veil
  end

  self.frame.factionVeil:SetVertexColor(unpack(FACTION_VEIL_COLORS[faction] or FACTION_VEIL_COLORS.alliance))

  if HasCustomTexture(key) then
    local path = CustomTexturePath(key)
    self.frame.factionArt:SetTexture(path)
    self.frame.factionArt:Show()
    self.frame.factionVeil:Show()
    if self.frame.factionBgKey ~= key then
      self.frame.factionBgKey = key
      AF:Print("[Fond] " .. faction .. " : " .. path
        .. " (variante sans extension si besoin de vérifier : " .. ADDON_TEXTURE_DIR .. key .. ")")
    end
  else
    self.frame.factionArt:Hide()
    self.frame.factionVeil:Hide()
    if self.frame.factionBgKey ~= key then
      self.frame.factionBgKey = key
      AF:Print("[Fond] Aucun fichier '" .. key .. "' listé dans le manifeste (Textures/" .. key .. ".tga introuvable) : fond uni à la place.")
    end
    Fill(self.frame, BG)
  end
end

function UI:UpdateClassBarStyles()
  local display = self:GetDisplayClassId()
  for classId, btn in pairs(self.classBarButtons or {}) do
    if classId == display then
      btn.border:SetColor(unpack(GOLD))
      btn.border:Show()
    else
      btn.border:Hide()
    end
  end
end

-- ---------- Bannière de classe (en-tête, sous le bandeau de classes) ----------
-- Image NON déformée (cover-fit, SetTexCoord) : jamais un étirement plein
-- large x 40px. Icône + nom + points par-dessus, à gauche, une seule fois
-- (le panneau droit n'a plus de titre en double).

function UI:BuildBannerRow()
  local row = CreateFrame("Frame", nil, self.frame)
  row:SetPoint("TOPLEFT", self.classBar, "BOTTOMLEFT", 0, -BANNER_GAP)
  row:SetPoint("TOPRIGHT", self.classBar, "BOTTOMRIGHT", 0, -BANNER_GAP)
  row:SetHeight(BANNER_H)
  Fill(row, PANEL_BG)
  GoldEdge(row, 1, GOLD_DIM)
  self.bannerRow = row

  local art = row:CreateTexture(nil, "ARTWORK")
  art:SetPoint("TOPLEFT", row, "TOPLEFT", 1, -1)
  art:SetPoint("BOTTOMRIGHT", row, "BOTTOMRIGHT", -1, 1)
  row.artTexture = art

  local veil = row:CreateTexture(nil, "ARTWORK")
  veil:SetAllPoints(art)
  veil:SetTexture(WHITE)
  veil:SetVertexColor(0.02, 0.03, 0.05, 0.45)
  veil:SetDrawLayer("ARTWORK", 1)
  row.veilTexture = veil

  local icon = row:CreateTexture(nil, "OVERLAY")
  icon:SetSize(40, 40)
  icon:SetPoint("LEFT", row, "LEFT", 10, 0)
  self.headerIcon = icon

  local summary = row:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
  summary:SetPoint("LEFT", icon, "RIGHT", 10, 0)
  summary:SetPoint("RIGHT", row, "RIGHT", -10, 0)
  summary:SetJustifyH("LEFT")
  summary:SetTextColor(unpack(TEXT))
  self.headerSummary = summary
end

function UI:RefreshHeaderRow()
  if not self.headerSummary then return end
  local classId = self:GetDisplayClassId()
  if not classId then
    self.headerSummary:SetText("Connectez-vous en jeu pour voir vos talents.")
    self.headerIcon:SetTexture(nil)
    self.bannerRow.artTexture:SetTexture(nil)
    return
  end
  local cls = AF:GetClassData(classId)
  local planned = Talents:GetPlannedRanks(classId)

  local parts = {}
  for _, tree in ipairs(cls.trees) do
    local n = 0
    for _, t in ipairs(tree.talents) do n = n + (planned[t.id] or 0) end
    parts[#parts + 1] = n
  end
  self.headerIcon:SetTexture(ResolveClassIcon(cls))
  self.headerSummary:SetText("|cffc9a227" .. cls.name .. "|r   " .. table.concat(parts, " / "))

  if self.bannerRow.artClassId ~= classId then
    self.bannerRow.artClassId = classId
    local key = "banner_" .. cls.slug
    if HasCustomTexture(key) then
      self.bannerRow.artTexture:SetTexture(CustomTexturePath(key))
      local frameW, frameH = self.bannerRow:GetWidth(), self.bannerRow:GetHeight()
      ApplyCoverFit(self.bannerRow.artTexture, frameW > 0 and frameW or (WIN_W - 2 * MARGIN), frameH > 0 and frameH or BANNER_H, BANNER_SRC_W, BANNER_SRC_H)
    else
      self.bannerRow.artTexture:SetTexture(nil)
    end
  end
end

-- ---------- Zone principale : gauche (arbres) + droite (panneau unique) ----------

function UI:BuildMainArea()
  local area = CreateFrame("Frame", nil, self.frame)
  area:SetPoint("TOPLEFT", self.bannerRow, "BOTTOMLEFT", 0, -MARGIN)
  area:SetPoint("TOPRIGHT", self.bannerRow, "BOTTOMRIGHT", 0, -MARGIN)
  area:SetPoint("BOTTOM", self.frame, "BOTTOM", 0, MARGIN + ACTION_H + 4 + FRISE_H + MARGIN)
  self.mainArea = area

  local leftWidth = math.floor((WIN_W - 2 * MARGIN - PANEL_GAP) * LEFT_RATIO)

  local left = CreateFrame("Frame", nil, area)
  left:SetPoint("TOPLEFT", area, "TOPLEFT", 0, 0)
  left:SetPoint("BOTTOM", area, "BOTTOM", 0, 0)
  left:SetWidth(leftWidth)
  Fill(left, PANEL_BG)
  GoldEdge(left, 1, GOLD_DIM)
  self.leftArea = left

  -- Le panneau droit ancre son bord gauche sur le bord droit du panneau
  -- gauche + un écart fixe : chevauchement impossible par construction.
  local right = CreateFrame("Frame", nil, area)
  right:SetPoint("TOPLEFT", left, "TOPRIGHT", PANEL_GAP, 0)
  right:SetPoint("TOPRIGHT", area, "TOPRIGHT", 0, 0)
  right:SetPoint("BOTTOM", left, "BOTTOM", 0, 0)
  Fill(right, PANEL_BG_SOFT)
  GoldEdge(right, 1, GOLD_DIM)
  self.rightArea = right

  self:BuildClassTrees(left)
  self:BuildClassPanel(right)
end

-- ---------- Gauche : arbres de talents de classe ----------

-- Un pas de grille (icône + rang dessous) qui tient toujours dans la largeur
-- du cadre, quel que soit le nombre de colonnes de l'arbre (<=4 pour toutes
-- les classes du jeu de données actuel).
local function GridStep(cadreWidth, cols)
  local innerWidth = cadreWidth - 8
  return math.max(ICON + ROW_GAP, math.floor(innerWidth / cols))
end

-- Pas vertical (icône + rang) qui tient toujours dans la hauteur RÉELLE du
-- cadre (grid:GetHeight(), mesurée après layout) pour TREE_ROWS rangées :
-- sans ça, les dernières rangées débordent en bas du cadre (pas de
-- SetClipsChildren fiable sur ce client pour les rattraper).
local function GridRowHeight(grid)
  local minH = ICON + RANK_H + 6
  local h = grid and grid:GetHeight()
  if not h or h <= 0 then
    return math.max(minH, ICON + ROW_GAP + RANK_H + 4)
  end
  return math.max(minH, math.floor(h / TREE_ROWS))
end

-- Fond d'un cadre d'arbre : soit les 4 quadrants GetTalentTabInfo (classe
-- réellement jouée), soit notre propre image pleine (tree_<id>.tga, cover-fit
-- + voile sombre) en repli. Créés ICI (au build) pour être garantis DERRIÈRE
-- le voile semi-transparent du cadre, quel que soit le moment où SetTexture
-- est appelé plus tard. Un seul des deux est visible à la fois.
local function AddCadreArt(cadre)
  local f = cadre.frame
  local function q()
    local t = f:CreateTexture(nil, "BACKGROUND")
    t:Hide()
    return t
  end
  cadre.quadTL, cadre.quadTR, cadre.quadBL, cadre.quadBR = q(), q(), q(), q()
  cadre.quadTL:SetPoint("TOPLEFT", f, "TOPLEFT", 0, 0)
  cadre.quadTL:SetPoint("BOTTOMRIGHT", f, "CENTER", 0, 0)
  cadre.quadTR:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, 0)
  cadre.quadTR:SetPoint("BOTTOMLEFT", f, "CENTER", 0, 0)
  cadre.quadBL:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 0, 0)
  cadre.quadBL:SetPoint("TOPRIGHT", f, "CENTER", 0, 0)
  cadre.quadBR:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, 0)
  cadre.quadBR:SetPoint("TOPLEFT", f, "CENTER", 0, 0)

  local art = f:CreateTexture(nil, "BACKGROUND")
  art:SetAllPoints(f)
  art:Hide()
  cadre.customArt = art
  local veil = f:CreateTexture(nil, "BACKGROUND")
  veil:SetAllPoints(f)
  veil:SetTexture(WHITE)
  veil:SetVertexColor(unpack(TREE_ART_VEIL))
  veil:Hide()
  cadre.customVeil = veil
end

local function ApplyCadreArt(cadre, background)
  if not cadre.quadTL then return end
  if not background then
    cadre.quadTL:Hide(); cadre.quadTR:Hide(); cadre.quadBL:Hide(); cadre.quadBR:Hide()
    return
  end
  cadre.quadTL:SetTexture("Interface\\TalentFrame\\" .. background .. "-TopLeft")
  cadre.quadTR:SetTexture("Interface\\TalentFrame\\" .. background .. "-TopRight")
  -- Convention client (vanilla) : suffixes abrégés "-BotLeft"/"-BotRight".
  cadre.quadBL:SetTexture("Interface\\TalentFrame\\" .. background .. "-BotLeft")
  cadre.quadBR:SetTexture("Interface\\TalentFrame\\" .. background .. "-BotRight")
  cadre.quadTL:Show(); cadre.quadTR:Show(); cadre.quadBL:Show(); cadre.quadBR:Show()
end

-- Notre propre fond (tree_<id>.tga) : uniquement utilisé quand
-- GetTalentTabInfo n'a rien donné (classe consultée différente de la classe
-- jouée, ou fond vide côté client).
local function ApplyCustomTreeArt(cadre, treeId)
  if not cadre.customArt then return end
  local key = treeId and ("tree_" .. treeId)
  if key and HasCustomTexture(key) then
    cadre.customArt:SetTexture(CustomTexturePath(key))
    ApplyCoverFit(cadre.customArt, cadre.frame:GetWidth(), cadre.frame:GetHeight(), TREE_BG_SRC_W, TREE_BG_SRC_H)
    cadre.customArt:Show()
    cadre.customVeil:Show()
  else
    cadre.customArt:Hide()
    cadre.customVeil:Hide()
  end
end

local function BuildTreeCadres(parent, count)
  local cadres = {}
  local gap = PANEL_GAP
  local totalGaps = gap * (count - 1)
  local cadreWidth = math.floor((parent:GetWidth() - 2 * MARGIN - totalGaps) / count)
  if cadreWidth <= 0 then cadreWidth = 180 end -- avant que la largeur réelle soit connue (premier layout)

  for i = 1, count do
    local cadre = CreateFrame("Frame", nil, parent)
    cadre:SetPoint("TOP", parent, "TOP", 0, -MARGIN)
    cadre:SetPoint("BOTTOM", parent, "BOTTOM", 0, MARGIN)
    cadre:SetWidth(cadreWidth)
    if i == 1 then
      cadre:SetPoint("LEFT", parent, "LEFT", MARGIN, 0)
    else
      cadre:SetPoint("LEFT", cadres[i - 1].frame, "RIGHT", gap, 0)
    end
    Fill(cadre, CADRE_BG)
    GoldEdge(cadre, 1, GOLD_DIM)

    -- Icône de spec à gauche du nom d'arbre, puis "0 points / 13 points"
    -- UNIQUEMENT ici, dans l'en-tête de l'arbre (pas ailleurs dans l'UI).
    local headerIcon = cadre:CreateTexture(nil, "OVERLAY")
    headerIcon:SetSize(16, 16)
    headerIcon:SetPoint("TOPLEFT", cadre, "TOPLEFT", 8, -8)

    local header = cadre:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    header:SetPoint("TOPLEFT", headerIcon, "TOPRIGHT", 4, 0)
    header:SetPoint("TOPRIGHT", cadre, "TOPRIGHT", -8, -8)
    header:SetJustifyH("LEFT")
    GoldText(header)

    local points = cadre:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    points:SetPoint("TOPLEFT", headerIcon, "BOTTOMLEFT", 0, -6)
    points:SetTextColor(unpack(TEXT_DIM))

    local grid = CreateFrame("Frame", nil, cadre)
    grid:SetPoint("TOPLEFT", points, "BOTTOMLEFT", 2, -10)
    grid:SetPoint("BOTTOMRIGHT", -2, 6)

    cadres[i] = { frame = cadre, header = header, headerIcon = headerIcon, points = points, grid = grid, width = cadreWidth }
    AddCadreArt(cadres[i])
  end
  return cadres
end

function UI:BuildClassTrees(parent)
  local holder = CreateFrame("Frame", nil, parent)
  holder:SetAllPoints(parent)
  self.classTreesHolder = holder
  self.classTreeCadres = BuildTreeCadres(holder, 3)
  self.talentButtons = {} -- [classId][catalogIndex] = button
end

function UI:GetOrCreateTalentButtons(classId)
  if self.talentButtons[classId] then return self.talentButtons[classId] end
  local cat = Talents:GetCatalog(classId)
  if not cat then return nil end
  local buttons = {}

  for _, entry in ipairs(cat.entries) do
    local cadre = self.classTreeCadres[entry.treeIdx]
    if cadre then
      local step = GridStep(cadre.width, TALENT_COLS)
      local cellH = GridRowHeight(cadre.grid)

      local btn = CreateFrame("Button", nil, cadre.grid)
      btn:SetSize(ICON, ICON)
      btn:SetPoint("TOPLEFT", cadre.grid, "TOPLEFT", entry.talent.col * step, -entry.talent.row * cellH)

      local icon = btn:CreateTexture(nil, "ARTWORK")
      icon:SetAllPoints()
      icon:SetDrawLayer("ARTWORK", 0)
      btn.icon = icon

      btn.border = MakeIconBorder(btn, 2)
      btn.border:Hide()

      -- Rang SOUS l'icône, jamais dessus : pas d'ambiguïté d'ordre d'affichage.
      local rankBg = btn:CreateTexture(nil, "ARTWORK")
      rankBg:SetPoint("TOP", btn, "BOTTOM", 0, -1)
      rankBg:SetSize(ICON, RANK_H)
      rankBg:SetTexture(WHITE)
      rankBg:SetDrawLayer("ARTWORK", 0)
      btn.rankBg = rankBg

      local rankText = btn:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
      rankText:SetPoint("TOP", btn, "BOTTOM", 0, -1)
      rankText:SetSize(ICON, RANK_H)
      rankText:SetJustifyH("CENTER")
      rankText:SetDrawLayer("OVERLAY", 1)
      btn.rankText = rankText

      btn:SetScript("OnEnter", function(self) UI:ShowTalentTooltip(self, entry) end)
      btn:SetScript("OnLeave", function() GameTooltip:Hide() end)

      btn:RegisterForClicks("LeftButtonUp", "RightButtonUp")
      btn:SetScript("OnClick", function(self, mouseButton)
        UI:OnTalentClick(entry, mouseButton)
      end)

      buttons[entry.index] = btn
    end
  end

  self.talentButtons[classId] = buttons
  return buttons
end

function UI:OnTalentClick(entry, mouseButton)
  local classId = self:GetDisplayClassId()
  if not classId then return end
  local mode = Talents:GetMode()
  local ok, err
  if mode == "path" then
    if mouseButton == "RightButton" then
      ok, err = Talents:RemoveLastPoint(classId, entry.index)
    else
      ok, err = Talents:AppendPoint(classId, entry.index)
    end
  else
    local ranks = Talents:GetPlannedRanks(classId)
    local current = ranks[entry.talent.id] or 0
    local delta = (mouseButton == "RightButton") and -1 or 1
    ok, err = Talents:SetFinalRank(classId, entry.index, current + delta)
  end
  if not ok and err and err ~= "" then AF:Print(err) end
  self:RefreshAll()
end

function UI:RefreshClassTrees()
  local classId = self:GetDisplayClassId()
  if not classId then
    for _, cadre in ipairs(self.classTreeCadres) do
      cadre.header:SetText("")
      cadre.points:SetText("")
      cadre.headerIcon:SetTexture(nil)
      ApplyCadreArt(cadre, nil)
      ApplyCustomTreeArt(cadre, nil)
    end
    return
  end
  local cls = AF:GetClassData(classId)
  local cat = Talents:GetCatalog(classId)
  if not cls or not cat then return end

  -- Fond d'arbre par GetTalentTabInfo : uniquement pour la classe RÉELLEMENT
  -- jouée (c'est la seule dont les onglets de talent du client reflètent
  -- vraiment l'arbre affiché ici).
  local ownClass = self:IsDisplayingOwnClass()
  for _, tree in ipairs(cls.trees) do
    local cadre = self.classTreeCadres[tree.order + 1]
    if cadre then
      local background = nil
      if ownClass and type(GetTalentTabInfo) == "function" then
        local ok, _, _, _, bg = pcall(GetTalentTabInfo, tree.order + 1)
        if ok then background = bg end
      end
      -- Le client d'abord (fond réel de l'arbre joué) ; à défaut notre TGA
      -- (tree_<id>) : jamais les deux en même temps.
      ApplyCadreArt(cadre, background)
      ApplyCustomTreeArt(cadre, not background and tree.id or nil)
    end
  end

  local planned = Talents:GetPlannedRanks(classId)
  local actual = self:GetActualRanksForDisplay(classId)

  for _, tree in ipairs(cls.trees) do
    local cadre = self.classTreeCadres[tree.order + 1]
    if cadre then
      cadre.header:SetText(tree.name)
      cadre.headerIcon:SetTexture("Interface\\Icons\\" .. (tree.icon or "INV_Misc_QuestionMark"))
      local n = 0
      for _, t in ipairs(tree.talents) do n = n + (planned[t.id] or 0) end
      cadre.points:SetText(n .. " points")
    end
  end

  local buttons = self:GetOrCreateTalentButtons(classId)
  if not buttons then return end
  for otherClassId, other in pairs(self.talentButtons) do
    if otherClassId ~= classId then
      for _, b in pairs(other) do b:Hide() end
    end
  end

  for _, entry in ipairs(cat.entries) do
    local btn = buttons[entry.index]
    if btn then
      btn:Show()
      local display = self:GetTalentDisplay(entry)
      btn.icon:SetTexture(display.icon)
      local pRank = planned[entry.talent.id] or 0
      local aRank = actual[entry.talent.id] or 0
      btn.rankText:SetText(pRank .. "/" .. entry.talent.maxRank)

      -- Pas de glow bleu ni d'effet "spell alert" : seul le rang max reçoit
      -- une bordure (or, propre, 2px).
      if aRank >= entry.talent.maxRank and entry.talent.maxRank > 0 then
        GoldText(btn.rankText)
        btn.rankBg:SetVertexColor(GOLD[1], GOLD[2], GOLD[3], 0.35)
        btn.border:SetColor(unpack(GOLD))
        btn.border:Show()
      else
        btn.border:Hide()
        if pRank > aRank then
          btn.rankText:SetTextColor(unpack(TEXT_OK))
          btn.rankBg:SetVertexColor(0.2, 0.5, 0.2, 0.45)
        elseif pRank > 0 then
          btn.rankText:SetTextColor(unpack(TEXT))
          btn.rankBg:SetVertexColor(0.15, 0.15, 0.18, 0.6)
        else
          btn.rankText:SetTextColor(unpack(TEXT_DIM))
          btn.rankBg:SetVertexColor(0, 0, 0, 0.4)
        end
      end

      if pRank <= 0 then
        btn.icon:SetDesaturated(true)
        btn.icon:SetAlpha(0.55)
      else
        btn.icon:SetDesaturated(false)
        btn.icon:SetAlpha(1)
      end
    end
  end
end

-- ---------- Droite : panneau unique (plus de titre en double, plus de QR) ----------

function UI:BuildClassPanel(parent)
  local panel = CreateFrame("Frame", nil, parent)
  panel:SetPoint("TOPLEFT", parent, "TOPLEFT", 8, -8)
  panel:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -6, 6)
  self.classPanel = panel

  -- Prochain point : icône + nom (rien d'autre - pas de ligne de texte seule).
  local nextIcon = panel:CreateTexture(nil, "ARTWORK")
  nextIcon:SetSize(22, 22)
  nextIcon:SetPoint("TOPLEFT", 0, 0)
  panel.nextIcon = nextIcon
  local nextText = panel:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
  nextText:SetPoint("LEFT", nextIcon, "RIGHT", 6, 0)
  nextText:SetPoint("RIGHT", 0, 0)
  nextText:SetJustifyH("LEFT")
  nextText:SetTextColor(unpack(TEXT))
  panel.nextText = nextText

  nextIcon:EnableMouse(true)
  nextIcon:SetScript("OnEnter", function(self)
    if panel.nextEntry then UI:ShowTalentTooltip(self, panel.nextEntry) end
  end)
  nextIcon:SetScript("OnLeave", function() GameTooltip:Hide() end)

  -- Modes, l'un sous l'autre, 4px d'écart.
  local btn60 = CreateFrame("CheckButton", "AzerothForeverModeFinal", panel, "UIRadioButtonTemplate")
  btn60:SetPoint("TOPLEFT", nextIcon, "BOTTOMLEFT", -2, -10)
  btn60.text = _G[btn60:GetName() .. "Text"]
  if btn60.text then btn60.text:SetText("Build au niveau 60"); btn60.text:SetTextColor(unpack(TEXT)) end
  btn60:SetScript("OnClick", function() Talents:SetMode("final"); UI:RefreshAll() end)
  panel.btn60 = btn60

  local btnLevel = CreateFrame("CheckButton", "AzerothForeverModePath", panel, "UIRadioButtonTemplate")
  btnLevel:SetPoint("TOPLEFT", btn60, "BOTTOMLEFT", 0, -4)
  btnLevel.text = _G[btnLevel:GetName() .. "Text"]
  if btnLevel.text then btnLevel.text:SetText("Build niveau par niveau"); btnLevel.text:SetTextColor(unpack(TEXT)) end
  btnLevel:SetScript("OnClick", function() Talents:SetMode("path"); UI:RefreshAll() end)
  panel.btnLevel = btnLevel

  -- Case à cocher.
  local autoApply = CreateFrame("CheckButton", "AzerothForeverAutoApply", panel, "UICheckButtonTemplate")
  autoApply:SetPoint("TOPLEFT", btnLevel, "BOTTOMLEFT", 0, -6)
  autoApply.text = _G[autoApply:GetName() .. "Text"]
  if autoApply.text then
    autoApply.text:SetFontObject("GameFontHighlightSmall")
    autoApply.text:SetText("Apprendre le prochain point quand je monte de niveau")
    autoApply.text:SetTextColor(unpack(TEXT_DIM))
    autoApply.text:SetWidth(230)
    autoApply.text:SetWordWrap(true)
    autoApply.text:SetJustifyH("LEFT")
  end
  autoApply:SetScript("OnClick", function(self) AzerothForeverDB.options.autoApply = self:GetChecked() and true or false end)
  panel.autoApply = autoApply

  -- Bloc code : champ AF1- + Exporter/Importer.
  local codeLabel = panel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  codeLabel:SetPoint("TOPLEFT", autoApply, "BOTTOMLEFT", 0, -14)
  codeLabel:SetText("Code AF1-")
  GoldText(codeLabel)

  local codeBg = CreateFrame("Frame", nil, panel)
  codeBg:SetPoint("TOPLEFT", codeLabel, "BOTTOMLEFT", 0, -4)
  codeBg:SetPoint("RIGHT", 0, 0)
  codeBg:SetHeight(20)
  Fill(codeBg, CADRE_BG)
  local codeEdit = CreateFrame("EditBox", nil, codeBg, "InputBoxTemplate")
  codeEdit:SetPoint("TOPLEFT", 6, -3)
  codeEdit:SetPoint("BOTTOMRIGHT", -6, 3)
  codeEdit:SetAutoFocus(false)
  codeEdit:SetMaxLetters(400)
  panel.codeEdit = codeEdit

  -- Centrés sous le champ de code : le point d'ancrage (TOP) est décalé de
  -- moitié de la largeur combinée des 2 boutons + l'écart, pas collés à gauche.
  local exportBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
  exportBtn:SetPoint("TOP", codeBg, "BOTTOM", -57, -4)
  exportBtn:SetSize(110, 20)
  exportBtn:SetText("Exporter")
  exportBtn:SetScript("OnClick", function() UI:FillShareCode() end)

  local importBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
  importBtn:SetPoint("LEFT", exportBtn, "RIGHT", 4, 0)
  importBtn:SetSize(110, 20)
  importBtn:SetText("Importer")
  importBtn:SetScript("OnClick", function() UI:DoImportClass() end)

  local statusText = panel:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  statusText:SetPoint("TOPLEFT", exportBtn, "BOTTOMLEFT", 0, -4)
  statusText:SetPoint("RIGHT", 0, 0)
  statusText:SetJustifyH("LEFT")
  statusText:SetWordWrap(true)
  statusText:SetTextColor(unpack(TEXT_DIM))
  panel.statusText = statusText

  -- Plan : titre + liste scroll (icône + niveau + nom + rang).
  local planLabel = panel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  planLabel:SetPoint("TOPLEFT", statusText, "BOTTOMLEFT", 0, -10)
  planLabel:SetText("Un point par niveau")
  GoldText(planLabel)
  panel.planLabel = planLabel

  local scroll = CreateFrame("ScrollFrame", "AzerothForeverPlanScroll", panel, "UIPanelScrollFrameTemplate")
  scroll:SetPoint("TOPLEFT", planLabel, "BOTTOMLEFT", 0, -6)
  scroll:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", -22, 0)
  local content = CreateFrame("Frame", nil, scroll)
  content:SetSize(1, 1)
  scroll:SetScrollChild(content)
  panel.scroll = scroll
  panel.planContent = content
  panel.planRows = {}
end

function UI:RefreshClassPanel()
  local panel = self.classPanel
  if not panel then return end
  local classId = self:GetDisplayClassId()
  if not classId then
    panel.nextText:SetText("Connectez-vous en jeu pour voir vos talents.")
    panel.nextIcon:SetTexture(nil)
    panel.nextEntry = nil
    return
  end
  local cls = AF:GetClassData(classId)
  local cat = Talents:GetCatalog(classId)

  if self:IsDisplayingOwnClass() then
    local next_ = Talents:NextPendingStep(classId)
    if next_ then
      local entry = cat.byId[next_.talentId]
      panel.nextEntry = entry
      local display = entry and self:GetTalentDisplay(entry)
      panel.nextIcon:SetTexture(display and display.icon or ("Interface\\Icons\\" .. next_.talent.icon))
      panel.nextText:SetText(display and display.name or next_.talent.name)
    else
      panel.nextEntry = nil
      panel.nextIcon:SetTexture(nil)
      panel.nextText:SetText("Plan à jour : rien à apprendre.")
    end
  else
    panel.nextEntry = nil
    panel.nextIcon:SetTexture(ResolveClassIcon(cls))
    panel.nextText:SetText("Classe consultée : " .. cls.name .. " (pas votre classe active).")
  end

  local mode = Talents:GetMode()
  panel.btn60:SetChecked(mode == "final")
  panel.btnLevel:SetChecked(mode == "path")
  panel.autoApply:SetChecked(AzerothForeverDB and AzerothForeverDB.options.autoApply or false)

  self:RefreshPlanList()
end

function UI:RefreshPlanList()
  local panel = self.classPanel
  if not panel then return end
  local classId = self:GetDisplayClassId()

  for _, row in ipairs(panel.planRows) do row:Hide() end
  if not classId then
    panel.planContent:SetHeight(1)
    return
  end
  local cat = Talents:GetCatalog(classId)
  local plan = Talents:GetPlan(classId)
  local steps = BP.steps(cat, plan.order, plan.talented)

  local rowH = 20
  local y = 0
  for i, step in ipairs(steps) do
    local row = panel.planRows[i]
    if not row then
      row = CreateFrame("Frame", nil, panel.planContent)
      row:SetHeight(rowH)
      row:EnableMouse(true)
      local icon = row:CreateTexture(nil, "ARTWORK")
      icon:SetSize(16, 16)
      icon:SetPoint("LEFT", 0, 0)
      row.icon = icon
      local level = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
      level:SetPoint("LEFT", icon, "RIGHT", 4, 0)
      level:SetWidth(24)
      level:SetJustifyH("LEFT")
      GoldText(level)
      row.level = level
      local name = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
      name:SetPoint("LEFT", level, "RIGHT", 4, 0)
      name:SetPoint("RIGHT", -4, 0)
      name:SetJustifyH("LEFT")
      name:SetTextColor(unpack(TEXT))
      row.name = name
      row:SetScript("OnEnter", function(self)
        if row.entry then UI:ShowTalentTooltip(self, row.entry) end
      end)
      row:SetScript("OnLeave", function() GameTooltip:Hide() end)
      panel.planRows[i] = row
    end
    row:ClearAllPoints()
    row:SetPoint("TOPLEFT", panel.planContent, "TOPLEFT", 0, -y)
    row:SetPoint("RIGHT", panel.planContent, "RIGHT", 0, 0)
    local entry = cat.byId[step.talentId]
    row.entry = entry
    local display = entry and self:GetTalentDisplay(entry)
    row.icon:SetTexture(display and display.icon or "Interface\\Icons\\INV_Misc_QuestionMark")
    row.level:SetText(step.level)
    row.name:SetText(step.talentName .. "  " .. step.rank .. "/" .. step.maxRank)
    row:Show()
    y = y + rowH
  end

  panel.planContent:SetHeight(math.max(1, y))
  panel.planContent:SetWidth(panel.scroll:GetWidth())
end

-- ---------- Code AF1- : export, import ----------

function UI:BuildUrlForClass(classId)
  local cat = Talents:GetCatalog(classId)
  local cls = AF:GetClassData(classId)
  local plan = Talents:GetPlan(classId)
  local ranks = BP.ranksFromOrder(cat, plan.order)
  local build = BP.serializeBuild(cat, ranks)
  local path = BP.encodePath(cat, plan.order, plan.talented)
  return AF.SITE_URL .. cls.slug .. "?build=" .. build .. "&path=" .. path
end

function UI:FillShareCode()
  local classId = self:GetDisplayClassId()
  local panel = self.classPanel
  if not classId or not panel then return end
  local cat = Talents:GetCatalog(classId)
  local cls = AF:GetClassData(classId)
  local plan = Talents:GetPlan(classId)
  local check = BP.validateOrder(cat, plan.order)
  if not check.ok then
    panel.statusText:SetText("Impossible d'exporter : " .. check.message)
    return
  end
  local path = BP.encodePath(cat, plan.order, plan.talented)
  local code = AF.ShareCode.encode(cls, path)
  panel.codeEdit:SetText(code)
  panel.codeEdit:SetFocus()
  panel.codeEdit:HighlightText()
  panel.statusText:SetText("Code copié dans le champ (Ctrl+C).")
end

function UI:DoImportClass()
  local panel = self.classPanel
  if not panel then return end
  local text = panel.codeEdit:GetText()
  local info = AF.ShareCode.inspect(text)
  if not info.ok then
    panel.statusText:SetText(info.error)
    return
  end
  if info.kind == "H" then
    panel.statusText:SetText("Les codes d'Héritage (AF1H-) ne sont pas pris en charge ici.")
    return
  end
  local decoded = AF.ShareCode.decode(text)
  if not decoded.ok then
    panel.statusText:SetText(decoded.error)
    return
  end
  Talents:LoadOrder(decoded.cls.id, decoded.order, decoded.talented)
  self:SelectClass(decoded.cls.id)
  panel.statusText:SetText("Build importé : " .. decoded.cls.name .. ".")
  self:RefreshAll()
end

-- ---------- Bas : frise (icônes des points du plan, tooltip complet) + barre d'actions ----------

function UI:BuildBottomBlock()
  self:BuildFrise()
  self:BuildActionBar()
end

function UI:BuildFrise()
  local block = CreateFrame("Frame", nil, self.frame)
  block:SetPoint("BOTTOMLEFT", self.frame, "BOTTOMLEFT", MARGIN, MARGIN + ACTION_H + 4)
  block:SetPoint("BOTTOMRIGHT", self.frame, "BOTTOMRIGHT", -MARGIN, MARGIN + ACTION_H + 4)
  block:SetHeight(FRISE_H)
  Fill(block, PANEL_BG_SOFT)
  GoldEdge(block, 1, GOLD_DIM)
  self.friseBlock = block

  local bar = CreateFrame("Frame", nil, block)
  bar:SetPoint("BOTTOMLEFT", block, "BOTTOMLEFT", 20, 14)
  bar:SetPoint("BOTTOMRIGHT", block, "BOTTOMRIGHT", -20, 14)
  bar:SetHeight(6)
  Fill(bar, { 0.18, 0.16, 0.10, 1 })
  self.friseBar = bar

  local usableWidth = (WIN_W - 2 * MARGIN) - 40
  self.friseTicks = {}
  self.frisePips = {}
  self.frisePipEntry = {}
  for lvl = 10, 60 do
    local x = (lvl - 10) * (usableWidth / 50)
    local tick = bar:CreateTexture(nil, "ARTWORK")
    tick:SetTexture(WHITE)
    tick:SetSize(2, 6)
    tick:SetPoint("LEFT", bar, "LEFT", x, 0)
    self.friseTicks[lvl] = tick

    -- Bouton (pas une simple texture) pour pouvoir afficher un tooltip au survol.
    local pip = CreateFrame("Button", nil, block)
    pip:SetSize(14, 14)
    pip:SetPoint("BOTTOM", bar, "LEFT", x, 10)
    local pipIcon = pip:CreateTexture(nil, "ARTWORK")
    pipIcon:SetAllPoints()
    pip.icon = pipIcon
    pip:Hide()
    pip:SetScript("OnEnter", function(self)
      local entry = UI.frisePipEntry[lvl]
      if entry then UI:ShowTalentTooltip(self, entry) end
    end)
    pip:SetScript("OnLeave", function() GameTooltip:Hide() end)
    -- Fade-in court quand une pastille apparaît (voir RefreshFrise) : montée
    -- d'alpha manuelle, sans dépendre d'UIFrameFadeIn (pas garanti sur ce client).
    pip:SetScript("OnUpdate", function(self, elapsed)
      if self.fadeT then
        self.fadeT = self.fadeT + elapsed
        local a = math.min(1, self.fadeT / 0.25)
        self:SetAlpha(a)
        if a >= 1 then self.fadeT = nil end
      end
    end)
    self.frisePips[lvl] = pip
  end

  -- Labels 10/20/30/40/50/60, sous la barre, à l'aplomb de chaque graduation.
  for lvl = 10, 60, 10 do
    local x = (lvl - 10) * (usableWidth / 50)
    local label = block:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    label:SetPoint("TOP", bar, "LEFT", x, -6)
    label:SetText(tostring(lvl))
    label:SetTextColor(unpack(TEXT_DIM))
  end

  -- Ancré nettement AU-DESSUS du bloc (offset positif) : un offset négatif
  -- ici le faisait retomber DANS le bloc, par-dessus la rangée de pastilles.
  local cursorLabel = block:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
  cursorLabel:SetPoint("BOTTOM", block, "TOP", 0, 6)
  GoldText(cursorLabel)
  self.friseCursorLabel = cursorLabel
end

function UI:RefreshFrise()
  if not self.friseTicks then return end
  local classId = self:GetDisplayClassId()
  local level = (UnitLevel and UnitLevel("player")) or 60
  self.friseCursorLabel:SetText("Votre niveau : " .. level)

  local pipIcon, pipEntry = {}, {}
  if classId then
    local cat = Talents:GetCatalog(classId)
    local plan = Talents:GetPlan(classId)
    if cat then
      for _, step in ipairs(BP.steps(cat, plan.order, plan.talented)) do
        if not pipIcon[step.level] then
          local entry = cat.byId[step.talentId]
          if entry then
            local display = self:GetTalentDisplay(entry)
            pipIcon[step.level] = display.icon
            pipEntry[step.level] = entry
          end
        end
      end
    end
  end
  self.frisePipEntry = pipEntry

  for lvl, tick in pairs(self.friseTicks) do
    if lvl == level then
      tick:SetVertexColor(unpack(GOLD))
    else
      tick:SetVertexColor(0.35, 0.35, 0.4)
    end
    local pip = self.frisePips[lvl]
    local icon = pipIcon[lvl]
    if icon then
      pip.icon:SetTexture(icon)
      if not pip:IsShown() then
        pip.fadeT = 0
        pip:SetAlpha(0)
      end
      pip:Show()
    else
      pip:Hide()
      pip.fadeT = nil
    end
  end
end

-- ---------- Barre d'actions (sous la frise) ----------

function UI:BuildActionBar()
  local bar = CreateFrame("Frame", nil, self.frame)
  bar:SetPoint("BOTTOMLEFT", self.frame, "BOTTOMLEFT", MARGIN, MARGIN)
  bar:SetPoint("BOTTOMRIGHT", self.frame, "BOTTOMRIGHT", -MARGIN, MARGIN)
  bar:SetHeight(ACTION_H)
  self.actionBar = bar

  local defs = {
    { key = "applyNext", label = "Appliquer suivant" },
    { key = "applyAll", label = "Appliquer tout" },
    { key = "reset", label = "Réinitialiser" },
    { key = "undo", label = "Annuler" },
    { key = "site", label = "Azerothforever.info" }
  }
  local n = #defs
  local btnWidth = math.floor((WIN_W - 2 * MARGIN - (n - 1) * 4) / n)
  local prevBtn
  for _, def in ipairs(defs) do
    local btn = CreateFrame("Button", nil, bar, "UIPanelButtonTemplate")
    btn:SetSize(btnWidth, ACTION_H)
    if prevBtn then
      btn:SetPoint("LEFT", prevBtn, "RIGHT", 4, 0)
    else
      btn:SetPoint("LEFT", bar, "LEFT", 0, 0)
    end
    btn:SetText(def.label)
    local fontString = btn.GetFontString and btn:GetFontString()
    if fontString then GoldText(fontString) end
    btn:SetScript("OnClick", function() UI:OnToolbarClick(def.key) end)
    if def.key == "applyNext" then self.applyNextBtn = btn end
    if def.key == "applyAll" then self.applyAllBtn = btn end
    prevBtn = btn
  end
end

function UI:OnToolbarClick(key)
  local classId = self:GetDisplayClassId()
  if key == "applyNext" or key == "applyAll" then
    if not self:IsDisplayingOwnClass() then
      local cls = classId and AF:GetClassData(classId)
      AF:Print("Vous consultez " .. (cls and cls.name or "une autre classe") .. " : rebasculez sur votre classe pour appliquer.")
      return
    end
  end
  if key == "applyNext" then
    Talents:ApplyNext()
  elseif key == "applyAll" then
    StaticPopupDialogs["AZEROTHFOREVER_APPLY_ALL"] = StaticPopupDialogs["AZEROTHFOREVER_APPLY_ALL"] or {
      text = "Appliquer tous les points de talent planifiés maintenant ?",
      button1 = "Appliquer",
      button2 = "Annuler",
      OnAccept = function() Talents:ApplyAll() end,
      timeout = 0, whileDead = true, hideOnEscape = true
    }
    StaticPopup_Show("AZEROTHFOREVER_APPLY_ALL")
  elseif key == "reset" then
    if classId then
      -- Ne resynchronise depuis le jeu que pour la classe réellement jouée :
      -- pour une classe consultée, GetTalentInfo ne renverrait que l'état
      -- (sans rapport) de la vraie classe du personnage.
      if self:IsDisplayingOwnClass() then
        Talents:SyncPlanFromGame(classId)
      else
        Talents:ResetPlan(classId)
      end
    end
    self:RefreshAll()
  elseif key == "undo" then
    if classId then Talents:UndoLastPoint(classId) end
    self:RefreshAll()
  elseif key == "site" then
    StaticPopupDialogs["AZEROTHFOREVER_SITE_LINK"] = StaticPopupDialogs["AZEROTHFOREVER_SITE_LINK"] or {
      text = "Site Azeroth Forever",
      button1 = "Fermer",
      hasEditBox = true,
      editBoxWidth = 360,
      OnShow = function(self)
        -- Nom du champ selon le client : self.editBox (moderne), self.EditBox,
        -- ou _G[nom.."EditBox"] (convention vanilla). On essaie les trois
        -- plutôt que de deviner, pour ne jamais laisser le champ vide.
        local editBox = self.editBox or self.EditBox or _G[self:GetName() .. "EditBox"]
        if not editBox then return end
        -- Le build actuel si on peut le construire (classe affichée, plan
        -- valide) ; sinon juste l'URL du site.
        local url = AF.SITE_URL
        local classId = UI:GetDisplayClassId()
        if classId then
          local ok, built = pcall(function() return UI:BuildUrlForClass(classId) end)
          if ok and built then url = built end
        end
        editBox:SetText(url)
        editBox:HighlightText()
        editBox:SetFocus()
      end,
      EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
      timeout = 0, whileDead = true, hideOnEscape = true
    }
    StaticPopup_Show("AZEROTHFOREVER_SITE_LINK")
  end
end

-- ---------- Rafraîchissement global ----------

function UI:RefreshAll()
  if not self.frame or not self.frame:IsShown() then return end
  self:RefreshHeaderRow()
  self:RefreshClassTrees()
  self:RefreshClassPanel()
  self:RefreshFrise()
end

function UI:RefreshTalents()
  self:RefreshAll()
end
