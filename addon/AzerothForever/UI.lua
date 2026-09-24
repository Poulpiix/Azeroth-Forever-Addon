-- Azeroth Forever : interface (/af).
--
-- Deux modes, pas cinq onglets : Build de classe (par défaut) et Build
-- héritage, choisis par deux boutons en haut du panneau droit. Tout ce dont
-- le joueur a besoin pour un build de classe (prochain point, modes,
-- code AF1-, QR, plan niveau par niveau) est dans LE MÊME panneau, compact.
-- Fenêtre 1100x720. GAUCHE ~70% (les arbres), DROITE ~30% (le panneau du
-- mode courant). Le panneau droit ancre son bord gauche sur le bord droit
-- du panneau gauche : le non-chevauchement est garanti par construction.
local ADDON_NAME, AF = ...

local UI = {}
AF.UI = UI

local BP = AF.BuildPath
local Talents = AF.Talents

-- ---------- Layout ----------

local WIN_W, WIN_H = 1100, 720
local TITLE_H, CLASS_BAR_H, HEADER_H = 34, 28, 40
local HEADER_ICON = 32
local MARGIN, PANEL_GAP = 10, 10
local LEFT_RATIO = 0.68
local ACTION_H, FRISE_H = 26, 54
local MODE_BAR_H = 24
local ICON, RANK_H, ROW_GAP = 36, 14, 8
local TALENT_COLS = 4
local QR_SIDE = 130

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
local CADRE_BG = { 0.05, 0.08, 0.13, 0.82 } -- alpha < 1 : laisse transparaître un fond d'arbre
local PANEL_BG_ACTIVE = { 0.10, 0.14, 0.22, 1 }
local PANEL_BG_INACTIVE = { 0.20, 0.07, 0.07, 1 } -- rouge sombre : onglet inactif
local GOLD = hex(0xc9a227)
local GOLD_DIM = { 0.50, 0.41, 0.15, 1 }
local TEXT = hex(0xe8e0d0)
local TEXT_DIM = { 0.58, 0.56, 0.52 }
local TEXT_OK = { 0.45, 0.85, 0.45 }

-- Alliance/Horde : uniquement pour la bascule de thème (icône + fond de
-- fenêtre) — jamais pour les boutons Appliquer.
local ALLIANCE_BG = { 0.06, 0.09, 0.16, 1 }
local HORDE_BG = { 0.16, 0.07, 0.06, 1 }
local FACTION_VEIL = { 0.05, 0.08, 0.18, 0.55 } -- voile bleu par-dessus une bannière perso

local WHITE = "Interface\\Buttons\\WHITE8X8"

-- ---------- Résolution des textures : client d'abord, notre TGA ensuite ----------
--
-- WoW n'a pas d'API pour tester si un fichier existe : SetTexture sur un
-- chemin absent ne plante jamais, mais reste invisible sans qu'on puisse
-- distinguer ce cas d'une vraie image transparente. Le manifeste généré par
-- tools/convert-textures.py (AF.Data.TextureManifest) lève cette ambiguïté
-- pour NOS textures.
--
-- Répartition des rôles (demandée) :
--   - icônes de talents/sorts  : API client UNIQUEMENT (jamais nos TGA)
--   - icônes de classe          : notre TGA (confirmé par le manifeste) en
--                                  priorité, sinon le champ client donné par
--                                  data/talents-data.js
--   - bannière de classe        : EN-TÊTE de classe seulement (pas fond d'arbre)
--   - fond des arbres           : GetTalentTabInfo (background) du client,
--                                  uniquement pour la classe réellement jouée
--   - fond de fenêtre           : bannière de faction + voile, sinon teinte plate
local ADDON_TEXTURE_DIR = "Interface\\AddOns\\AzerothForever\\Textures\\"

local function HasCustomTexture(key)
  return AF.Data.TextureManifest ~= nil and AF.Data.TextureManifest[key] == true
end

local function CustomTexturePath(key)
  return ADDON_TEXTURE_DIR .. key
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
-- n'importe quelle taille de cadre). Renvoie les 4 textures (pour pouvoir
-- les Show/Hide/recolorer ensuite, ex. état actif/inactif d'un bouton).
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

local function SetEdgeColor(edge, color)
  for _, s in ipairs(edge) do s:SetVertexColor(unpack(color)) end
end

local function SetEdgeShown(edge, shown)
  for _, s in ipairs(edge) do s:SetShown(shown) end
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

-- ---------- Fenêtre ----------

function UI:OnFrameLoad(frame)
  self.frame = frame
  self.mode = "class"
  frame:SetSize(WIN_W, WIN_H)
  frame:SetFrameStrata("DIALOG")
  frame:ClearAllPoints()
  frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
  frame:RegisterForDrag("LeftButton")
  Fill(frame, BG)
  GoldEdge(frame, 2)

  if frame.Title then GoldText(frame.Title) end

  local sections = {
    { "BuildClassBar", self.BuildClassBar },
    { "BuildHeaderRow", self.BuildHeaderRow },
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

  self:ApplyMode()
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

-- ---------- Mode : Build de classe / Build héritage (remplace les 5 onglets) ----------

function UI:SetMode(mode)
  self.mode = mode
  self:ApplyMode()
  self:RefreshAll()
end

function UI:ApplyMode()
  local isClass = (self.mode == "class")

  if self.classBar then self.classBar:SetShown(isClass) end
  if self.headerRow then
    self.headerRow:ClearAllPoints()
    local topOffset = TITLE_H + (isClass and CLASS_BAR_H or 0)
    self.headerRow:SetPoint("TOPLEFT", self.frame, "TOPLEFT", MARGIN, -topOffset)
    self.headerRow:SetPoint("TOPRIGHT", self.frame, "TOPRIGHT", -MARGIN, -topOffset)
  end
  if self.classTreesHolder then self.classTreesHolder:SetShown(isClass) end
  if self.heritageTreesHolder then self.heritageTreesHolder:SetShown(not isClass) end
  if self.classPanel then self.classPanel:SetShown(isClass) end
  if self.heritagePanel then self.heritagePanel:SetShown(not isClass) end
  if self.friseBlock then self.friseBlock:SetShown(isClass) end
  if self.applyNextBtn then self.applyNextBtn:SetShown(isClass) end
  if self.applyAllBtn then self.applyAllBtn:SetShown(isClass) end

  if self.modeButtons then
    for key, btn in pairs(self.modeButtons) do
      if key == self.mode then
        Fill(btn, PANEL_BG_ACTIVE)
        SetEdgeShown(btn.edge, true)
        SetEdgeColor(btn.edge, GOLD)
        GoldText(btn.text)
      else
        Fill(btn, PANEL_BG_INACTIVE)
        SetEdgeShown(btn.edge, false)
        btn.text:SetTextColor(unpack(TEXT_DIM))
      end
    end
  end
end

-- ---------- Bandeau de classes (comme le site) + bascule Alliance/Horde ----------
-- Visible uniquement en Build de classe (ApplyMode le cache en Héritage).

local FACTION_ICONS = {
  alliance = "Interface\\TargetingFrame\\UI-PVP-Alliance",
  horde = "Interface\\TargetingFrame\\UI-PVP-Horde"
}

function UI:BuildClassBar()
  local bar = CreateFrame("Frame", nil, self.frame)
  bar:SetPoint("TOPLEFT", self.frame, "TOPLEFT", MARGIN, -TITLE_H)
  bar:SetPoint("TOPRIGHT", self.frame, "TOPRIGHT", -MARGIN, -TITLE_H)
  bar:SetHeight(CLASS_BAR_H)
  self.classBar = bar
  self.classBarButtons = {}

  local size = 24
  local prevBtn
  for _, classId in ipairs(CLASS_ORDER) do
    local cls = AF:GetClassData(classId)
    if cls then
      local btn = CreateFrame("Button", nil, bar)
      btn:SetSize(size, size)
      if prevBtn then
        btn:SetPoint("LEFT", prevBtn, "RIGHT", 6, 0)
      else
        btn:SetPoint("LEFT", bar, "LEFT", 2, 0)
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

  -- Bascule Alliance/Horde : change le fond de FENÊTRE, jamais les boutons
  -- Appliquer (ceux-là restent en chrome or partout).
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
  self:ApplyFactionBackground()
end

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

-- Fond de FENÊTRE uniquement : bannière de faction + voile bleu, sinon une
-- teinte plate. Les boutons Appliquer ne sont jamais concernés.
function UI:ApplyFactionBackground()
  if not self.frame then return end
  local faction = (AzerothForeverDB and AzerothForeverDB.options.faction) or "alliance"
  local key = "banner_" .. faction
  if HasCustomTexture(key) then
    if not self.frame.factionArt then
      local art = self.frame:CreateTexture(nil, "BACKGROUND")
      art:SetPoint("TOPLEFT", self.frame, "TOPLEFT", 2, -2)
      art:SetPoint("BOTTOMRIGHT", self.frame, "BOTTOMRIGHT", -2, 2)
      self.frame.factionArt = art
      local veil = self.frame:CreateTexture(nil, "BACKGROUND")
      veil:SetAllPoints(art)
      veil:SetTexture(WHITE)
      self.frame.factionVeil = veil
    end
    self.frame.factionArt:SetTexture(CustomTexturePath(key))
    self.frame.factionArt:Show()
    self.frame.factionVeil:SetVertexColor(unpack(FACTION_VEIL))
    self.frame.factionVeil:Show()
    self.frame.afBg:SetVertexColor(0, 0, 0, 0)
  else
    if self.frame.factionArt then self.frame.factionArt:Hide() end
    if self.frame.factionVeil then self.frame.factionVeil:Hide() end
    Fill(self.frame, faction == "horde" and HORDE_BG or ALLIANCE_BG)
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

-- ---------- Ligne résumé (bannière classe = EN-TÊTE, icône, nom, points) ----------

function UI:BuildHeaderRow()
  local row = CreateFrame("Frame", nil, self.frame)
  row:SetPoint("TOPLEFT", self.frame, "TOPLEFT", MARGIN, -TITLE_H - CLASS_BAR_H)
  row:SetPoint("TOPRIGHT", self.frame, "TOPRIGHT", -MARGIN, -TITLE_H - CLASS_BAR_H)
  row:SetHeight(HEADER_H)
  self.headerRow = row

  -- Bannière de classe en fond d'en-tête (pas fond d'arbre) + voile pour
  -- garder le texte lisible quelle que soit l'image.
  local art = row:CreateTexture(nil, "BACKGROUND")
  art:SetAllPoints(row)
  row.artTexture = art
  local dim = row:CreateTexture(nil, "BACKGROUND")
  dim:SetAllPoints(row)
  dim:SetTexture(WHITE)
  dim:SetVertexColor(0.02, 0.03, 0.05, 0.45)
  row.dimTexture = dim

  local icon = row:CreateTexture(nil, "ARTWORK")
  icon:SetSize(HEADER_ICON, HEADER_ICON)
  icon:SetPoint("LEFT", row, "LEFT", 4, 0)
  self.headerIcon = icon

  local summary = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  summary:SetPoint("LEFT", icon, "RIGHT", 8, 0)
  summary:SetPoint("RIGHT", row, "RIGHT", -4, 0)
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
    self.headerRow.artTexture:SetTexture(nil)
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

  if self.headerRow.artClassId ~= classId then
    self.headerRow.artClassId = classId
    local key = "banner_" .. cls.slug
    if HasCustomTexture(key) then
      self.headerRow.artTexture:SetTexture(CustomTexturePath(key))
    else
      self.headerRow.artTexture:SetTexture(nil)
    end
  end
end

-- ---------- Zone principale : gauche (arbres) + droite (panneau du mode) ----------

function UI:BuildMainArea()
  local area = CreateFrame("Frame", nil, self.frame)
  area:SetPoint("TOPLEFT", self.headerRow, "BOTTOMLEFT", 0, -MARGIN)
  area:SetPoint("TOPRIGHT", self.headerRow, "BOTTOMRIGHT", 0, -MARGIN)
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
  Fill(right, PANEL_BG)
  GoldEdge(right, 1, GOLD_DIM)
  self.rightArea = right

  self:BuildClassTrees(left)
  self:BuildHeritageTrees(left)
  self:BuildModeBar(right)
  self:BuildClassPanel(right)
  self:BuildHeritagePanel(right)
end

-- ---------- Gauche : arbres de talents de classe ----------

-- Un pas de grille (icône + rang dessous) qui tient toujours dans la largeur
-- du cadre, quel que soit le nombre de colonnes de l'arbre (<=4 pour toutes
-- les classes du jeu de données actuel).
local function GridStep(cadreWidth, cols)
  local innerWidth = cadreWidth - 8
  return math.max(ICON + ROW_GAP, math.floor(innerWidth / cols))
end

-- Fond d'un cadre d'arbre via GetTalentTabInfo (4 quadrants) : créés ICI
-- (au build, juste après Fill) pour être garantis DERRIÈRE le voile sombre
-- semi-transparent du cadre, quel que soit le moment où SetTexture est
-- appelé plus tard.
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
end

local function ApplyCadreArt(cadre, background)
  if not cadre.quadTL then return end
  if not background then
    cadre.quadTL:Hide(); cadre.quadTR:Hide(); cadre.quadBL:Hide(); cadre.quadBR:Hide()
    return
  end
  cadre.quadTL:SetTexture("Interface\\TalentFrame\\" .. background .. "-TopLeft")
  cadre.quadTR:SetTexture("Interface\\TalentFrame\\" .. background .. "-TopRight")
  -- Convention client (vanilla) : suffixes abrégés "-BotLeft"/"-BotRight",
  -- pas "-BottomLeft"/"-BottomRight". SetTexture reste sans risque si ce
  -- n'est pas le bon nom sur ce fork précis : au pire rien ne s'affiche.
  cadre.quadBL:SetTexture("Interface\\TalentFrame\\" .. background .. "-BotLeft")
  cadre.quadBR:SetTexture("Interface\\TalentFrame\\" .. background .. "-BotRight")
  cadre.quadTL:Show(); cadre.quadTR:Show(); cadre.quadBL:Show(); cadre.quadBR:Show()
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

    local header = cadre:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    header:SetPoint("TOPLEFT", 8, -8)
    header:SetPoint("TOPRIGHT", -8, -8)
    header:SetJustifyH("LEFT")
    GoldText(header)

    local points = cadre:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    points:SetPoint("TOPLEFT", header, "BOTTOMLEFT", 0, -2)
    points:SetTextColor(unpack(TEXT_DIM))

    local grid = CreateFrame("Frame", nil, cadre)
    grid:SetPoint("TOPLEFT", points, "BOTTOMLEFT", 2, -10)
    grid:SetPoint("BOTTOMRIGHT", -2, 6)

    cadres[i] = { frame = cadre, header = header, points = points, grid = grid, width = cadreWidth }
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
      local cellH = ICON + ROW_GAP + RANK_H + 4

      local btn = CreateFrame("Button", nil, cadre.grid)
      btn:SetSize(ICON, ICON)
      btn:SetPoint("TOPLEFT", cadre.grid, "TOPLEFT", entry.talent.col * step, -entry.talent.row * cellH)

      -- Icônes de talents : API client uniquement.
      local icon = btn:CreateTexture(nil, "ARTWORK")
      icon:SetAllPoints()
      icon:SetDrawLayer("ARTWORK", 0)
      icon:SetTexture("Interface\\Icons\\" .. (entry.talent.icon or "INV_Misc_QuestionMark"))
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

      btn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(entry.talent.name, 1, 1, 1)
        for i = 1, entry.talent.maxRank do
          local r = entry.talent.ranks[i]
          if r and r.desc and r.desc ~= "" then
            GameTooltip:AddLine("Rang " .. i .. " : " .. r.desc, 0.9, 0.9, 0.9, true)
          end
        end
        GameTooltip:Show()
      end)
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
    end
    return
  end
  local cls = AF:GetClassData(classId)
  local cat = Talents:GetCatalog(classId)
  if not cls or not cat then return end

  -- Fond d'arbre par GetTalentTabInfo : uniquement pour la classe RÉELLEMENT
  -- jouée (c'est la seule dont les onglets de talent du client reflètent
  -- vraiment l'arbre affiché ici). Pour une classe consultée ou si l'API
  -- est absente, pas de fond : les cartes restent simplement sombres.
  local ownClass = self:IsDisplayingOwnClass()
  for _, tree in ipairs(cls.trees) do
    local cadre = self.classTreeCadres[tree.order + 1]
    if cadre then
      local background = nil
      if ownClass and type(GetTalentTabInfo) == "function" then
        local ok, _, _, _, bg = pcall(GetTalentTabInfo, tree.order + 1)
        if ok then background = bg end
      end
      ApplyCadreArt(cadre, background)
    end
  end

  local planned = Talents:GetPlannedRanks(classId)
  local actual = self:GetActualRanksForDisplay(classId)

  for _, tree in ipairs(cls.trees) do
    local cadre = self.classTreeCadres[tree.order + 1]
    if cadre then
      cadre.header:SetText(tree.name)
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

-- ---------- Gauche (Héritage) : plein cadre, à la place des arbres de classe ----------

local HERITAGE_COLS = 4

function UI:BuildHeritageTrees(parent)
  local holder = CreateFrame("Frame", nil, parent)
  holder:SetAllPoints(parent)
  holder:Hide()
  self.heritageTreesHolder = holder
  self.heritageCadres = BuildTreeCadres(holder, 3)
  self.heritageButtons = {}

  local cat = AF.Heritage:GetCatalog()
  for _, entry in ipairs(cat.entries) do
    local cadre = self.heritageCadres[entry.treeIdx]
    if cadre then
      local step = GridStep(cadre.width, HERITAGE_COLS)
      local cellH = ICON + ROW_GAP + RANK_H + 4

      local btn = CreateFrame("Button", nil, cadre.grid)
      btn:SetSize(ICON, ICON)
      btn:SetPoint("TOPLEFT", cadre.grid, "TOPLEFT", entry.node.col * step, -entry.node.row * cellH)

      local icon = btn:CreateTexture(nil, "ARTWORK")
      icon:SetAllPoints()
      icon:SetDrawLayer("ARTWORK", 0)
      icon:SetTexture("Interface\\Icons\\" .. (entry.node.icon or "INV_Misc_QuestionMark"))
      btn.icon = icon

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

      btn.border = MakeIconBorder(btn, 2)
      btn.border:Hide()

      btn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(entry.node.name, 1, 1, 1)
        if entry.node.desc and entry.node.desc ~= "" then
          GameTooltip:AddLine(entry.node.desc, 0.9, 0.9, 0.9, true)
        end
        GameTooltip:Show()
      end)
      btn:SetScript("OnLeave", function() GameTooltip:Hide() end)

      btn:RegisterForClicks("LeftButtonUp", "RightButtonUp")
      btn:SetScript("OnClick", function(self, mouseButton)
        local delta = (mouseButton == "RightButton") and -1 or 1
        local ok, err = AF.Heritage:ChangeRank(entry.key, delta)
        if not ok and err then AF:Print(err) end
        UI:RefreshAll()
      end)

      self.heritageButtons[entry.key] = { btn = btn, entry = entry }
    end
  end

  for treeIdx, tree in ipairs(cat.trees) do
    local cadre = self.heritageCadres[treeIdx]
    if cadre then cadre.header:SetText(tree.name) end
  end
end

function UI:RefreshHeritageTrees()
  if not self.heritageButtons then return end
  local ranks = AF.Heritage:GetRanks()
  local cat = AF.Heritage:GetCatalog()

  for treeIdx, tree in ipairs(cat.trees) do
    local cadre = self.heritageCadres[treeIdx]
    if cadre then
      local n = 0
      for _, node in ipairs(tree.nodes) do n = n + (ranks[tree.id .. "__" .. node.id] or 0) end
      cadre.points:SetText(n .. " points")
    end
  end

  for key, data in pairs(self.heritageButtons) do
    local rank = ranks[key] or 0
    data.btn.rankText:SetText(rank .. "/" .. data.entry.node.maxRank)
    if rank >= data.entry.node.maxRank and data.entry.node.maxRank > 0 then
      data.btn.icon:SetDesaturated(false)
      data.btn.icon:SetAlpha(1)
      GoldText(data.btn.rankText)
      data.btn.rankBg:SetVertexColor(GOLD[1], GOLD[2], GOLD[3], 0.35)
      data.btn.border:SetColor(unpack(GOLD))
      data.btn.border:Show()
    elseif rank > 0 then
      data.btn.icon:SetDesaturated(false)
      data.btn.icon:SetAlpha(1)
      data.btn.rankText:SetTextColor(unpack(TEXT_OK))
      data.btn.rankBg:SetVertexColor(0.2, 0.5, 0.2, 0.45)
      data.btn.border:Hide()
    else
      data.btn.icon:SetDesaturated(true)
      data.btn.icon:SetAlpha(0.55)
      data.btn.rankText:SetTextColor(unpack(TEXT_DIM))
      data.btn.rankBg:SetVertexColor(0, 0, 0, 0.4)
      data.btn.border:Hide()
    end
  end
end

-- ---------- Droite : bascule Build de classe / Build héritage ----------

function UI:CreateModeButton(parent, label)
  local btn = CreateFrame("Button", nil, parent)
  Fill(btn, PANEL_BG_INACTIVE)
  btn.edge = GoldEdge(btn, 1, GOLD)
  SetEdgeShown(btn.edge, false)
  local text = btn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  text:SetAllPoints()
  text:SetJustifyH("CENTER")
  text:SetText(label)
  btn.text = text
  return btn
end

function UI:BuildModeBar(parent)
  local bar = CreateFrame("Frame", nil, parent)
  bar:SetPoint("TOPLEFT", parent, "TOPLEFT", 6, -6)
  bar:SetPoint("TOPRIGHT", parent, "TOPRIGHT", -6, -6)
  bar:SetHeight(MODE_BAR_H)
  self.modeBar = bar

  local btnClass = self:CreateModeButton(bar, "Build de classe")
  local btnHeritage = self:CreateModeButton(bar, "Build héritage")
  local btnWidth = math.floor(((parent:GetWidth() > 0 and parent:GetWidth() or 320) - 12 - 4) / 2)
  btnClass:SetSize(math.max(100, btnWidth), MODE_BAR_H)
  btnHeritage:SetSize(math.max(100, btnWidth), MODE_BAR_H)
  btnClass:SetPoint("LEFT", bar, "LEFT", 0, 0)
  btnHeritage:SetPoint("LEFT", btnClass, "RIGHT", 4, 0)
  btnClass:SetScript("OnClick", function() UI:SetMode("class") end)
  btnHeritage:SetScript("OnClick", function() UI:SetMode("heritage") end)
  self.modeButtons = { class = btnClass, heritage = btnHeritage }

  self.rightContentTop = bar
end

-- ---------- Panneau "Build de classe" : tout au même endroit, compact ----------

function UI:BuildClassPanel(parent)
  local panel = CreateFrame("Frame", nil, parent)
  panel:SetPoint("TOPLEFT", self.rightContentTop, "BOTTOMLEFT", 2, -8)
  panel:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -6, 6)
  self.classPanel = panel

  -- 1) Titre : nom de classe + points par arbre (réutilise la ligne résumé
  -- déjà affichée en haut de fenêtre : ici on ne remet qu'un rappel court).
  local title = panel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  title:SetPoint("TOPLEFT", 0, 0)
  title:SetPoint("RIGHT", 0, 0)
  title:SetJustifyH("LEFT")
  GoldText(title)
  panel.title = title

  -- 2) Prochain point : icône + nom + arbre.
  local nextIcon = panel:CreateTexture(nil, "ARTWORK")
  nextIcon:SetSize(22, 22)
  nextIcon:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -6)
  panel.nextIcon = nextIcon
  local nextText = panel:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  nextText:SetPoint("LEFT", nextIcon, "RIGHT", 6, 0)
  nextText:SetPoint("RIGHT", 0, 0)
  nextText:SetJustifyH("LEFT")
  nextText:SetTextColor(unpack(TEXT))
  panel.nextText = nextText

  -- 3) Modes, l'un sous l'autre, 4px d'écart.
  local btn60 = CreateFrame("CheckButton", "AzerothForeverModeFinal", panel, "UIRadioButtonTemplate")
  btn60:SetPoint("TOPLEFT", nextIcon, "BOTTOMLEFT", -2, -8)
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

  -- 4) Case à cocher, une seule ligne claire.
  local autoApply = CreateFrame("CheckButton", "AzerothForeverAutoApply", panel, "UICheckButtonTemplate")
  autoApply:SetPoint("TOPLEFT", btnLevel, "BOTTOMLEFT", 0, -6)
  autoApply.text = _G[autoApply:GetName() .. "Text"]
  if autoApply.text then
    autoApply.text:SetFontObject("GameFontHighlightSmall")
    autoApply.text:SetText("Apprendre le prochain point tout seul quand je monte de niveau")
    autoApply.text:SetTextColor(unpack(TEXT_DIM))
    autoApply.text:SetWidth(230)
    autoApply.text:SetWordWrap(true)
    autoApply.text:SetJustifyH("LEFT")
  end
  autoApply:SetScript("OnClick", function(self) AzerothForeverDB.options.autoApply = self:GetChecked() and true or false end)
  panel.autoApply = autoApply

  -- 5) Phrase unique, "Appliquer" en or/gras.
  local hint = panel:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  hint:SetPoint("TOPLEFT", autoApply, "BOTTOMLEFT", 0, -30)
  hint:SetPoint("RIGHT", 0, 0)
  hint:SetJustifyH("LEFT")
  hint:SetWordWrap(true)
  hint:SetTextColor(unpack(TEXT))
  hint:SetText("Clic gauche : ajouter/planifier. Clic droit : retirer. Rien n'est appris tant que vous n'avez pas cliqué sur |cffc9a227Appliquer|r.")
  panel.hint = hint

  -- 6) Bloc code : champ AF1- + Exporter/Importer + QR (fond blanc).
  local codeLabel = panel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  codeLabel:SetPoint("TOPLEFT", hint, "BOTTOMLEFT", 0, -10)
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

  local exportBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
  exportBtn:SetPoint("TOPLEFT", codeBg, "BOTTOMLEFT", 0, -4)
  exportBtn:SetSize(110, 20)
  exportBtn:SetText("Exporter")
  exportBtn:SetScript("OnClick", function() UI:FillShareCode() end)

  local importBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
  importBtn:SetPoint("LEFT", exportBtn, "RIGHT", 4, 0)
  importBtn:SetSize(110, 20)
  importBtn:SetText("Importer")
  importBtn:SetScript("OnClick", function() UI:DoImportClass() end)

  local qrBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
  qrBtn:SetPoint("TOPLEFT", exportBtn, "BOTTOMLEFT", 0, -4)
  qrBtn:SetPoint("RIGHT", 0, 0)
  qrBtn:SetHeight(20)
  qrBtn:SetText("Afficher le QR")
  qrBtn:SetScript("OnClick", function() UI:ShowQR() end)
  panel.qrBtn = qrBtn

  local statusText = panel:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  statusText:SetPoint("TOPLEFT", qrBtn, "BOTTOMLEFT", 0, -4)
  statusText:SetPoint("RIGHT", 0, 0)
  statusText:SetJustifyH("LEFT")
  statusText:SetWordWrap(true)
  statusText:SetTextColor(unpack(TEXT_DIM))
  panel.statusText = statusText

  -- Zone QR : masquée (hauteur 0) tant qu'aucun QR n'a été demandé, pour ne
  -- pas garder un trou vide ; s'ouvre à la taille voulue au clic.
  local qrFrame = CreateFrame("Frame", nil, panel)
  qrFrame:SetPoint("TOPLEFT", statusText, "BOTTOMLEFT", 0, -4)
  qrFrame:SetSize(QR_SIDE, 0)
  Fill(qrFrame, { 1, 1, 1, 1 })
  qrFrame.qrTextures = {}
  local qrHint = qrFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  qrHint:SetAllPoints()
  qrHint:SetJustifyH("CENTER")
  qrHint:SetTextColor(0.15, 0.12, 0.05)
  qrFrame.qrHint = qrHint
  panel.qrFrame = qrFrame

  -- 7) Plan : titre + liste scroll (12 lignes visibles), plus "Voir les
  -- sorts" replié en bas de la même liste.
  local planLabel = panel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  planLabel:SetPoint("TOPLEFT", qrFrame, "BOTTOMLEFT", 0, -10)
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
    panel.title:SetText("Connectez-vous en jeu pour voir vos talents.")
    panel.nextText:SetText("")
    panel.nextIcon:SetTexture(nil)
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
  panel.title:SetText(cls.name .. "  " .. table.concat(parts, " / "))

  if self:IsDisplayingOwnClass() then
    local next_ = Talents:NextPendingStep(classId)
    if next_ then
      panel.nextIcon:SetTexture("Interface\\Icons\\" .. (next_.talent.icon or "INV_Misc_QuestionMark"))
      panel.nextText:SetText(next_.talent.name .. "  (" .. next_.tree.name .. ")")
    else
      panel.nextIcon:SetTexture(nil)
      panel.nextText:SetText("Plan à jour : rien à apprendre.")
    end
  else
    panel.nextIcon:SetTexture(ResolveClassIcon(cls))
    panel.nextText:SetText("Vous consultez " .. cls.name .. " (pas votre classe active).")
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
      local level = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
      level:SetPoint("LEFT", 0, 0)
      level:SetWidth(24)
      level:SetJustifyH("LEFT")
      GoldText(level)
      row.level = level
      local icon = row:CreateTexture(nil, "ARTWORK")
      icon:SetSize(16, 16)
      icon:SetPoint("LEFT", level, "RIGHT", 2, 0)
      row.icon = icon
      local name = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
      name:SetPoint("LEFT", icon, "RIGHT", 4, 0)
      name:SetPoint("RIGHT", -4, 0)
      name:SetJustifyH("LEFT")
      name:SetTextColor(unpack(TEXT))
      row.name = name
      panel.planRows[i] = row
    end
    row:ClearAllPoints()
    row:SetPoint("TOPLEFT", panel.planContent, "TOPLEFT", 0, -y)
    row:SetPoint("RIGHT", panel.planContent, "RIGHT", 0, 0)
    row.level:SetText(step.level)
    local entry = cat.byId[step.talentId]
    row.icon:SetTexture("Interface\\Icons\\" .. (entry and entry.talent.icon or "INV_Misc_QuestionMark"))
    row.name:SetText(step.talentName .. "  " .. step.rank .. "/" .. step.maxRank)
    row:Show()
    y = y + rowH
  end

  y = self:RefreshSortsSection(panel, y)

  panel.planContent:SetHeight(math.max(1, y))
  panel.planContent:SetWidth(panel.scroll:GetWidth())
end

-- ----- "Voir les sorts", replié, groupé par niveau d'apprentissage -----
-- (Pas un 5e onglet : un petit lien sous le plan, dans la même liste.)

function UI:RefreshSortsSection(panel, y)
  local classId = self:GetDisplayClassId()
  if not panel.sortsToggle then
    local toggle = CreateFrame("Button", nil, panel.planContent)
    toggle:SetHeight(18)
    local text = toggle:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    text:SetAllPoints()
    text:SetJustifyH("LEFT")
    text:SetTextColor(unpack(TEXT_DIM))
    toggle.text = text
    toggle:SetScript("OnClick", function()
      self.sortsExpanded = not self.sortsExpanded
      self:RefreshPlanList()
    end)
    panel.sortsToggle = toggle
    panel.sortsRows = {}
  end

  y = y + 6
  panel.sortsToggle:ClearAllPoints()
  panel.sortsToggle:SetPoint("TOPLEFT", panel.planContent, "TOPLEFT", 0, -y)
  panel.sortsToggle:SetPoint("RIGHT", panel.planContent, "RIGHT", 0, 0)
  panel.sortsToggle.text:SetText(self.sortsExpanded and "▾ Masquer les sorts" or "▸ Voir les sorts")
  panel.sortsToggle:Show()
  y = y + 18

  for _, row in ipairs(panel.sortsRows) do row:Hide() end
  if not self.sortsExpanded or not classId then
    return y
  end

  -- Groupé par niveau d'apprentissage : le niveau où chaque talent planifié
  -- reçoit son premier point (donnée qu'on a vraiment, via le parcours
  -- planifié ; on n'invente pas de niveau de sort qui n'existe pas dans les
  -- données).
  local cat = Talents:GetCatalog(classId)
  local plan = Talents:GetPlan(classId)
  local steps = BP.steps(cat, plan.order, plan.talented)
  local firstLevel, finalRank = {}, {}
  for _, step in ipairs(steps) do
    if not firstLevel[step.talentId] then firstLevel[step.talentId] = step.level end
    finalRank[step.talentId] = step.rank
  end
  local levels = {}
  for talentId, lvl in pairs(firstLevel) do levels[#levels + 1] = { talentId = talentId, level = lvl } end
  table.sort(levels, function(a, b) return a.level < b.level end)

  local rowH = 20
  local i = 0
  local lastLevel = nil
  local function getRow()
    i = i + 1
    local row = panel.sortsRows[i]
    if not row then
      row = CreateFrame("Frame", nil, panel.planContent)
      row:SetHeight(rowH)
      local text = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
      text:SetAllPoints()
      text:SetJustifyH("LEFT")
      row.text = text
      panel.sortsRows[i] = row
    end
    row:ClearAllPoints()
    row:SetPoint("TOPLEFT", panel.planContent, "TOPLEFT", 0, -y)
    row:SetPoint("RIGHT", panel.planContent, "RIGHT", 0, 0)
    row:Show()
    y = y + rowH
    return row
  end

  if #levels == 0 then
    local row = getRow()
    row.text:SetTextColor(unpack(TEXT_DIM))
    row.text:SetText("Aucun point planifié pour l'instant.")
  end

  for _, item in ipairs(levels) do
    if item.level ~= lastLevel then
      lastLevel = item.level
      local header = getRow()
      header.text:SetTextColor(unpack(GOLD))
      header.text:SetText("Niv. " .. item.level)
    end
    local entry = cat.byId[item.talentId]
    if entry then
      local row = getRow()
      row.text:SetTextColor(unpack(TEXT))
      row.text:SetText("   |T Interface\\Icons\\" .. entry.talent.icon .. ":14|t  " .. entry.talent.name
        .. "  " .. finalRank[item.talentId] .. "/" .. entry.talent.maxRank)
    end
  end

  return y
end

-- ---------- Panneau "Build héritage" : compteur + phrase + code ----------

function UI:BuildHeritagePanel(parent)
  local panel = CreateFrame("Frame", nil, parent)
  panel:SetPoint("TOPLEFT", self.rightContentTop, "BOTTOMLEFT", 2, -8)
  panel:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -6, 6)
  panel:Hide()
  self.heritagePanel = panel

  local counter = panel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  counter:SetPoint("TOPLEFT", 0, 0)
  GoldText(counter)
  panel.counter = counter

  local hint = panel:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  hint:SetPoint("TOPLEFT", counter, "BOTTOMLEFT", 0, -8)
  hint:SetPoint("RIGHT", 0, 0)
  hint:SetJustifyH("LEFT")
  hint:SetWordWrap(true)
  hint:SetTextColor(unpack(TEXT_DIM))
  hint:SetText("Les 3 arbres sont affichés à gauche : clic gauche +1, clic droit -1.")

  local codeLabel = panel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  codeLabel:SetPoint("TOPLEFT", hint, "BOTTOMLEFT", 0, -14)
  codeLabel:SetText("Code AF1H-")
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

  local exportBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
  exportBtn:SetPoint("TOPLEFT", codeBg, "BOTTOMLEFT", 0, -4)
  exportBtn:SetSize(110, 20)
  exportBtn:SetText("Exporter")
  exportBtn:SetScript("OnClick", function() UI:FillHeritageCode() end)

  local importBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
  importBtn:SetPoint("LEFT", exportBtn, "RIGHT", 4, 0)
  importBtn:SetSize(110, 20)
  importBtn:SetText("Importer")
  importBtn:SetScript("OnClick", function() UI:DoImportHeritage() end)

  local statusText = panel:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  statusText:SetPoint("TOPLEFT", exportBtn, "BOTTOMLEFT", 0, -6)
  statusText:SetPoint("RIGHT", 0, 0)
  statusText:SetJustifyH("LEFT")
  statusText:SetWordWrap(true)
  statusText:SetTextColor(unpack(TEXT_DIM))
  panel.statusText = statusText
end

function UI:RefreshHeritagePanel()
  local panel = self.heritagePanel
  if not panel then return end
  local ranks = AF.Heritage:GetRanks()
  local total = AF.HeritagePath.totalOf(ranks)
  panel.counter:SetText(total .. " / " .. AF.Data.Constants.HERITAGE_MAX_POINTS .. " points")
end

-- ---------- Code AF1- / AF1H- : export, import (scopés à chaque panneau) ----------

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
    panel.statusText:SetText("C'est un code d'Héritage : collez-le dans le panneau Build héritage.")
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

function UI:FillHeritageCode()
  local panel = self.heritagePanel
  if not panel then return end
  local code = AF.Heritage:ExportCode()
  panel.codeEdit:SetText(code)
  panel.codeEdit:SetFocus()
  panel.codeEdit:HighlightText()
  panel.statusText:SetText("Code copié dans le champ (Ctrl+C).")
end

function UI:DoImportHeritage()
  local panel = self.heritagePanel
  if not panel then return end
  local text = panel.codeEdit:GetText()
  local info = AF.ShareCode.inspect(text)
  if not info.ok then
    panel.statusText:SetText(info.error)
    return
  end
  if info.kind ~= "H" then
    panel.statusText:SetText("Ce n'est pas un code d'Héritage : collez-le dans le panneau Build de classe.")
    return
  end
  local ok, err = AF.Heritage:ImportCode(text)
  panel.statusText:SetText(ok and "Héritage importé." or err)
  self:RefreshAll()
end

-- ----- QR : uniquement dans le panneau Build de classe -----

function UI:ShowQRUnavailable(panel, reason)
  AF:Print("[QR] indisponible : " .. tostring(reason))
  local frame = panel.qrFrame
  for _, tex in ipairs(frame.qrTextures) do tex:Hide() end
  frame:SetHeight(30)
  frame.qrHint:SetText("QR indisponible")
  frame.qrHint:Show()
  panel.statusText:SetText("QR indisponible : " .. tostring(reason))
  self:RefreshPlanList()
end

function UI:ShowQR()
  local panel = self.classPanel
  if not panel then return end
  local classId = self:GetDisplayClassId()
  if not classId then
    self:ShowQRUnavailable(panel, "connectez-vous en jeu pour générer un QR.")
    return
  end
  local ok, url = pcall(function() return self:BuildUrlForClass(classId) end)
  if not ok or not url then
    self:ShowQRUnavailable(panel, url or "impossible de construire le lien du build.")
    return
  end
  local qr, err = AF.QR.Generate(url)
  if not qr then
    self:ShowQRUnavailable(panel, err or "génération du QR impossible.")
    return
  end
  panel.qrFrame:SetHeight(QR_SIDE)
  self:DrawQR(panel.qrFrame, qr)
  panel.statusText:SetText("QR généré (" .. #url .. " caractères, version " .. qr.version .. ").")
  self:RefreshPlanList()
end

function UI:DrawQR(frame, qr)
  local side = math.min(frame:GetWidth(), frame:GetHeight())
  if side <= 0 then side = QR_SIDE end
  local avail = side - 8
  local pixel = math.max(1, math.floor(avail / qr.size))
  local totalSize = pixel * qr.size

  frame.qrHint:Hide()
  local pool = frame.qrTextures
  local used = 0

  for row = 0, qr.size - 1 do
    for col = 0, qr.size - 1 do
      used = used + 1
      local tex = pool[used]
      if not tex then
        tex = frame:CreateTexture(nil, "ARTWORK")
        tex:SetTexture(WHITE)
        pool[used] = tex
      end
      tex:ClearAllPoints()
      tex:SetPoint("TOPLEFT", frame, "TOPLEFT", (frame:GetWidth() - totalSize) / 2 + col * pixel, -((frame:GetHeight() - totalSize) / 2 + row * pixel))
      tex:SetSize(pixel, pixel)
      if qr.isDark(row, col) then
        tex:SetVertexColor(0.10, 0.08, 0.04)
      else
        tex:SetVertexColor(0.97, 0.95, 0.88)
      end
      tex:Show()
    end
  end
  for i = used + 1, #pool do pool[i]:Hide() end
end

-- ---------- Bas : frise (Build de classe uniquement) + barre d'actions ----------

function UI:BuildBottomBlock()
  self:BuildFrise()
  self:BuildActionBar()
end

function UI:BuildFrise()
  local block = CreateFrame("Frame", nil, self.frame)
  block:SetPoint("BOTTOMLEFT", self.frame, "BOTTOMLEFT", MARGIN, MARGIN + ACTION_H + 4)
  block:SetPoint("BOTTOMRIGHT", self.frame, "BOTTOMRIGHT", -MARGIN, MARGIN + ACTION_H + 4)
  block:SetHeight(FRISE_H)
  Fill(block, PANEL_BG)
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
  for lvl = 10, 60 do
    local x = (lvl - 10) * (usableWidth / 50)
    local tick = bar:CreateTexture(nil, "ARTWORK")
    tick:SetTexture(WHITE)
    tick:SetSize(2, 6)
    tick:SetPoint("LEFT", bar, "LEFT", x, 0)
    self.friseTicks[lvl] = tick

    local pip = block:CreateTexture(nil, "OVERLAY")
    pip:SetSize(14, 14)
    pip:SetPoint("BOTTOM", bar, "LEFT", x, 10)
    pip:Hide()
    self.frisePips[lvl] = pip
  end

  local label10 = block:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  label10:SetPoint("RIGHT", bar, "LEFT", -4, 0)
  label10:SetText("10")
  label10:SetTextColor(unpack(TEXT_DIM))
  local label60 = block:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  label60:SetPoint("LEFT", bar, "RIGHT", 4, 0)
  label60:SetText("60")
  label60:SetTextColor(unpack(TEXT_DIM))

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

  local pipIcon = {}
  if classId then
    local cat = Talents:GetCatalog(classId)
    local plan = Talents:GetPlan(classId)
    if cat then
      for _, step in ipairs(BP.steps(cat, plan.order, plan.talented)) do
        if not pipIcon[step.level] then
          local entry = cat.byId[step.talentId]
          pipIcon[step.level] = entry and entry.talent.icon
        end
      end
    end
  end

  for lvl, tick in pairs(self.friseTicks) do
    if lvl == level then
      tick:SetVertexColor(unpack(GOLD))
    else
      tick:SetVertexColor(0.35, 0.35, 0.4)
    end
    local pip = self.frisePips[lvl]
    local icon = pipIcon[lvl]
    if icon then
      pip:SetTexture("Interface\\Icons\\" .. icon)
      pip:Show()
    else
      pip:Hide()
    end
  end
end

-- ---------- Barre d'actions (sous la frise) ----------
-- 5 boutons seulement : Import/Partager ont un point d'entrée direct dans
-- chaque panneau maintenant (Exporter/Importer), plus besoin de les
-- dupliquer ici.

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
    { key = "site", label = "azerothforever.info" }
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
    if self.mode == "heritage" then
      AF.Heritage:Reset()
    elseif classId then
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
    if self.mode == "heritage" then
      -- Pas d'historique dédié pour l'Héritage en V1 : Undo n'agit que sur
      -- le plan de talents (comme avant).
    elseif classId then
      Talents:UndoLastPoint(classId)
    end
    self:RefreshAll()
  elseif key == "site" then
    StaticPopupDialogs["AZEROTHFOREVER_SITE_LINK"] = StaticPopupDialogs["AZEROTHFOREVER_SITE_LINK"] or {
      text = "Site Azeroth Forever",
      button1 = "Fermer",
      hasEditBox = true,
      editBoxWidth = 280,
      OnShow = function(self)
        self.editBox:SetText(AF.SITE_URL)
        self.editBox:HighlightText()
        self.editBox:SetFocus()
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
  if self.mode == "heritage" then
    self:RefreshHeritageTrees()
    self:RefreshHeritagePanel()
  else
    self:RefreshClassTrees()
    self:RefreshClassPanel()
  end
  self:RefreshFrise()
end

function UI:RefreshTalents()
  self:RefreshAll()
end
