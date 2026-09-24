-- Azeroth Forever : interface (/af). Thème sombre Azeroth Forever (pas le
-- skin doré « Talents Forever »).
--
-- Layout obligatoire (voir demande) : bandeau titre 36px, bandeau actions
-- 32px, puis DEUX panneaux qui ne se chevauchent JAMAIS — gauche (talents de
-- classe, masqué entièrement sous l'onglet Héritage) et droite (les 5
-- onglets, un seul visible à la fois) — et une frise 8px en bas. Le panneau
-- droit ancre son bord gauche sur le bord droit du panneau gauche : le
-- non-chevauchement est garanti par construction, pas par des nombres
-- magiques qui doivent rester synchronisés à la main.
local ADDON_NAME, AF = ...

local UI = {}
AF.UI = UI

local BP = AF.BuildPath
local Talents = AF.Talents

-- ---------- Constantes de layout ----------

local WIN_W, WIN_H = 920, 620
local TOP_H, ACTION_H, FRISE_H = 36, 32, 28 -- frise : 8px de barre + place pour le texte "Niv. X"
local MARGIN = 8
local LEFT_W = 430
local PANEL_GAP = 8
local ICON, RANK_H, ROW_GAP = 32, 14, 6
local TALENT_COLS, TALENT_ROWS = 4, 7 -- toutes les classes tiennent dans cette grille (voir data)
local HERITAGE_COLS, HERITAGE_ROWS = 4, 4

-- ---------- Thème ----------
--
-- Pas de SetBackdrop / BackdropTemplate : absent sur ce client. Fond et
-- bordure sont deux textures colorées, opaques (alpha 1 partout : plus rien
-- ne doit laisser voir le monde à travers un panneau).

local BG = { 0.05, 0.07, 0.10, 1 }
local BORDER = { 0.35, 0.30, 0.20, 1 }
local ACCENT = { 0.70, 0.55, 0.30 } -- or discret, pas doré massif
local ACCENT_BRIGHT = { 0.95, 0.80, 0.45 }
local TEXT_DIM = { 0.60, 0.60, 0.65 }
local TEXT_BRIGHT = { 1, 1, 1 }
local TEXT_OK = { 0.40, 0.85, 0.40 }

local WHITE = "Interface\\Buttons\\WHITE8X8"

-- Fond opaque + bordure de 2px sur un frame existant (pas un nouveau frame :
-- pas de SetBackdrop nulle part sur ce client).
local function Paint(frame, bgColor)
  if not frame.afBackground then
    local border = frame:CreateTexture(nil, "BACKGROUND")
    border:SetAllPoints(frame)
    border:SetTexture(WHITE)
    border:SetDrawLayer("BACKGROUND", 0)
    frame.afBorder = border

    local bg = frame:CreateTexture(nil, "BACKGROUND")
    bg:SetPoint("TOPLEFT", frame, "TOPLEFT", 2, -2)
    bg:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -2, 2)
    bg:SetTexture(WHITE)
    bg:SetDrawLayer("BACKGROUND", 1)
    frame.afBackground = bg
  end
  frame.afBorder:SetVertexColor(unpack(BORDER))
  frame.afBackground:SetVertexColor(unpack(bgColor or BG))
  if frame.SetClipsChildren then pcall(frame.SetClipsChildren, frame, true) end
end

-- ---------- Fenêtre ----------

-- Construction défensive : chaque section est isolée par pcall pour qu'une
-- erreur dans l'une n'empêche pas les autres de s'afficher (plus de fenêtre
-- à moitié construite).
function UI:OnFrameLoad(frame)
  self.frame = frame
  frame:SetSize(WIN_W, WIN_H)
  frame:SetFrameStrata("DIALOG")
  frame:ClearAllPoints()
  frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
  frame:RegisterForDrag("LeftButton")
  Paint(frame)

  local sections = {
    { "BuildActionBar", self.BuildActionBar },
    { "BuildLeftPanel", self.BuildLeftPanel },
    { "BuildRightPanel", self.BuildRightPanel },
    { "BuildFrise", self.BuildFrise }
  }
  for _, section in ipairs(sections) do
    local name, fn = section[1], section[2]
    local ok, err = pcall(fn, self)
    if not ok then
      AF:Print("Erreur d'interface (" .. name .. ") : " .. tostring(err))
    end
  end
end

function UI:OnFrameShow()
  AF.classId = AF.classId or AF:GetPlayerClassId()
  self:RefreshAll()
end

function UI:Toggle()
  if not self.frame then return end
  if self.frame:IsShown() then self.frame:Hide() else self.frame:Show() end
end

function UI:Hide()
  if self.frame then self.frame:Hide() end
end

-- ---------- Bandeau actions (32px, juste sous le titre) ----------

local ACTION_BUTTONS = {
  { key = "applyNext", label = "Appliquer suivant" },
  { key = "applyAll", label = "Appliquer tout" },
  { key = "reset", label = "Reset" },
  { key = "undo", label = "Undo" },
  { key = "import", label = "Import" },
  { key = "share", label = "Partager" },
  { key = "qr", label = "QR" },
  { key = "site", label = "Site" }
}

function UI:BuildActionBar()
  local bar = CreateFrame("Frame", nil, self.frame)
  bar:SetPoint("TOPLEFT", self.frame, "TOPLEFT", MARGIN, -TOP_H)
  bar:SetPoint("TOPRIGHT", self.frame, "TOPRIGHT", -MARGIN, -TOP_H)
  bar:SetHeight(ACTION_H)
  self.actionBar = bar

  local n = #ACTION_BUTTONS
  local btnWidth = math.floor((WIN_W - 2 * MARGIN - (n - 1) * 4) / n)
  local prevBtn
  for _, def in ipairs(ACTION_BUTTONS) do
    local btn = CreateFrame("Button", nil, bar, "UIPanelButtonTemplate")
    btn:SetSize(btnWidth, 24)
    if prevBtn then
      btn:SetPoint("LEFT", prevBtn, "RIGHT", 4, 0)
    else
      btn:SetPoint("LEFT", bar, "LEFT", 0, 0)
    end
    btn:SetText(def.label)
    btn:SetScript("OnClick", function() UI:OnToolbarClick(def.key) end)
    prevBtn = btn
  end
end

function UI:OnToolbarClick(key)
  local classId = AF.classId
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
    if self.currentTab == "heritage" then
      AF.Heritage:Reset()
    elseif classId then
      Talents:SyncPlanFromGame(classId)
    end
    self:RefreshAll()
  elseif key == "undo" then
    if classId then Talents:UndoLastPoint(classId) end
    self:RefreshAll()
  elseif key == "import" then
    self:ShowTab("builds")
  elseif key == "share" then
    self:ShowTab("builds")
    self:FillShareCode()
  elseif key == "qr" then
    self:ShowTab("builds")
    self:ShowQR()
  elseif key == "site" then
    self:ShowTab("builds")
    self:FocusSiteLink()
  end
end

-- ---------- Panneau gauche : talents de classe (masqué sous Héritage) ----------

function UI:BuildLeftPanel()
  local panel = CreateFrame("Frame", nil, self.frame)
  panel:SetPoint("TOPLEFT", self.actionBar, "BOTTOMLEFT", 0, -MARGIN)
  panel:SetWidth(LEFT_W)
  panel:SetPoint("BOTTOM", self.frame, "BOTTOM", 0, MARGIN + FRISE_H + MARGIN)
  Paint(panel)
  self.leftPanel = panel

  local title = panel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  title:SetPoint("TOPLEFT", 8, -6)
  title:SetPoint("TOPRIGHT", -8, -6)
  title:SetJustifyH("LEFT")
  title:SetText("Talents")
  self.leftTitle = title

  local treesArea = CreateFrame("Frame", nil, panel)
  treesArea:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -6)
  treesArea:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", -4, 4)
  self.treesArea = treesArea

  self.treeCadres = {}   -- 1..3 : { frame, header }
  self.talentButtons = {} -- [classId][catalogIndex] = { icon, rankText, rankBg }

  local cadreWidth = math.floor((LEFT_W - 8 - 2 * 4) / 3) -- 2 gaps de 4px entre les 3 cadres
  for i = 1, 3 do
    local cadre = CreateFrame("Frame", nil, treesArea)
    cadre:SetPoint("TOP", treesArea, "TOP", 0, 0)
    cadre:SetPoint("BOTTOM", treesArea, "BOTTOM", 0, 0)
    cadre:SetWidth(cadreWidth)
    if i == 1 then
      cadre:SetPoint("LEFT", treesArea, "LEFT", 0, 0)
    else
      cadre:SetPoint("LEFT", self.treeCadres[i - 1].frame, "RIGHT", 4, 0)
    end
    Paint(cadre, { 0.04, 0.05, 0.08, 1 })

    local header = cadre:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    header:SetPoint("TOPLEFT", 4, -4)
    header:SetPoint("TOPRIGHT", -4, -4)
    header:SetJustifyH("CENTER")
    header:SetTextColor(unpack(ACCENT))

    local grid = CreateFrame("Frame", nil, cadre)
    grid:SetPoint("TOPLEFT", header, "BOTTOMLEFT", 2, -6)
    grid:SetPoint("BOTTOMRIGHT", -2, 2)

    self.treeCadres[i] = { frame = cadre, header = header, grid = grid, width = cadreWidth }
  end
end

-- Calcule un pas de grille (icône + rang dessous) qui tient toujours dans la
-- largeur du cadre, quel que soit le nombre de colonnes de l'arbre (<=4 pour
-- toutes les classes du jeu de données actuel).
local function GridStep(cadreWidth)
  local innerWidth = cadreWidth - 4
  local cellW = math.floor(innerWidth / TALENT_COLS)
  return math.max(ICON + 2, cellW)
end

function UI:GetOrCreateTalentButtons(classId)
  if self.talentButtons[classId] then return self.talentButtons[classId] end
  local cat = Talents:GetCatalog(classId)
  if not cat then return nil end
  local buttons = {}

  for _, entry in ipairs(cat.entries) do
    local cadre = self.treeCadres[entry.treeIdx]
    if cadre then
      local step = GridStep(cadre.width)
      local cellH = ICON + ROW_GAP + RANK_H

      local btn = CreateFrame("Button", nil, cadre.grid)
      btn:SetSize(ICON, ICON)
      btn:SetPoint("TOPLEFT", cadre.grid, "TOPLEFT", entry.talent.col * step, -entry.talent.row * cellH)

      local icon = btn:CreateTexture(nil, "ARTWORK")
      icon:SetAllPoints()
      icon:SetDrawLayer("ARTWORK", 0)
      icon:SetTexture("Interface\\Icons\\" .. (entry.talent.icon or "INV_Misc_QuestionMark"))
      btn.icon = icon

      local border = btn:CreateTexture(nil, "OVERLAY")
      border:SetPoint("TOPLEFT", -2, 2)
      border:SetPoint("BOTTOMRIGHT", 2, -2)
      border:SetTexture(WHITE)
      border:SetDrawLayer("OVERLAY", 0)
      border:SetVertexColor(0, 0, 0, 0)
      btn.border = border

      -- Le rang est SOUS l'icône, jamais dessus : aucune ambiguïté d'ordre
      -- d'affichage possible entre icône et texte.
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
  local classId = AF.classId
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

function UI:RefreshLeftPanel()
  if not self.leftPanel or not self.leftTitle then return end
  local classId = AF.classId
  if not classId then
    self.leftTitle:SetText("Talents (connectez-vous en jeu)")
    for _, cadre in ipairs(self.treeCadres) do cadre.header:SetText("") end
    return
  end
  local cls = AF:GetClassData(classId)
  local cat = Talents:GetCatalog(classId)
  if not cls or not cat then
    self.leftTitle:SetText("Talents : classe non reconnue")
    return
  end
  self.leftTitle:SetText(cls.name)

  for _, tree in ipairs(cls.trees) do
    local cadre = self.treeCadres[tree.order + 1]
    if cadre then cadre.header:SetText(tree.name) end
  end

  local buttons = self:GetOrCreateTalentButtons(classId)
  if not buttons then return end
  for otherClassId, other in pairs(self.talentButtons) do
    if otherClassId ~= classId then
      for _, b in pairs(other) do b:Hide() end
    end
  end

  local planned = Talents:GetPlannedRanks(classId)
  local actual = Talents:GetActualRanks(classId)

  for _, entry in ipairs(cat.entries) do
    local btn = buttons[entry.index]
    if btn then
      btn:Show()
      local pRank = planned[entry.talent.id] or 0
      local aRank = actual[entry.talent.id] or 0
      btn.rankText:SetText(pRank .. "/" .. entry.talent.maxRank)

      if aRank >= entry.talent.maxRank and entry.talent.maxRank > 0 then
        btn.rankText:SetTextColor(unpack(ACCENT_BRIGHT))
        btn.rankBg:SetVertexColor(ACCENT[1], ACCENT[2], ACCENT[3], 0.45)
      elseif pRank > aRank then
        btn.rankText:SetTextColor(unpack(TEXT_OK))
        btn.rankBg:SetVertexColor(0.2, 0.5, 0.2, 0.45)
      elseif pRank > 0 then
        btn.rankText:SetTextColor(unpack(TEXT_BRIGHT))
        btn.rankBg:SetVertexColor(0.15, 0.15, 0.18, 0.6)
      else
        btn.rankText:SetTextColor(unpack(TEXT_DIM))
        btn.rankBg:SetVertexColor(0, 0, 0, 0.4)
      end

      if aRank > 0 then
        btn.border:SetVertexColor(ACCENT[1], ACCENT[2], ACCENT[3], 0.9)
      elseif pRank > 0 then
        btn.border:SetVertexColor(0.3, 0.6, 0.9, 0.7)
      else
        btn.border:SetVertexColor(0, 0, 0, 0)
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

-- ---------- Panneau droit : bord gauche = bord droit du panneau gauche + gap ----------
-- (garantit géométriquement l'absence de chevauchement, sans nombre magique)

function UI:BuildRightPanel()
  local panel = CreateFrame("Frame", nil, self.frame)
  panel:SetPoint("TOPLEFT", self.leftPanel, "TOPRIGHT", PANEL_GAP, 0)
  panel:SetPoint("TOPRIGHT", self.frame, "TOPRIGHT", -MARGIN, 0)
  panel:SetPoint("BOTTOM", self.leftPanel, "BOTTOM", 0, 0)
  Paint(panel)
  self.rightPanel = panel

  self:BuildTabBar(panel)

  local content = CreateFrame("Frame", nil, panel)
  content:SetPoint("TOPLEFT", self.tabBar, "BOTTOMLEFT", 4, -6)
  content:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", -4, 4)
  if content.SetClipsChildren then pcall(content.SetClipsChildren, content, true) end
  self.tabContent = content

  self.tabPages = {}
  self.tabPages.home = self:BuildHomeTab(content)
  self.tabPages.plan = self:BuildPlanTab(content)
  self.tabPages.heritage = self:BuildHeritageTab(content)
  self.tabPages.spells = self:BuildSpellsTab(content)
  self.tabPages.builds = self:BuildBuildsTab(content)

  self.currentTab = "home"
  for key, page in pairs(self.tabPages) do page:SetShown(key == "home") end
  self:UpdateTabButtonStyles()
end

-- ---------- Onglets (bande fine en haut du panneau droit) ----------

local TABS = { "home", "plan", "heritage", "spells", "builds" }
local TAB_LABELS = { home = "Accueil", plan = "Plan", heritage = "Héritage", spells = "Sorts", builds = "Builds" }

function UI:BuildTabBar(parent)
  local bar = CreateFrame("Frame", nil, parent)
  bar:SetPoint("TOPLEFT", parent, "TOPLEFT", 4, -4)
  bar:SetPoint("TOPRIGHT", parent, "TOPRIGHT", -4, -4)
  bar:SetHeight(24)
  self.tabBar = bar
  self.tabButtons = {}

  local n = #TABS
  local btnWidth = math.floor((LEFT_W + PANEL_GAP - 8) / n) -- largeur approx. du panneau droit
  local prevBtn
  for _, tab in ipairs(TABS) do
    local btn = CreateFrame("Button", nil, bar, "UIPanelButtonTemplate")
    btn:SetSize(math.max(70, btnWidth - 2), 22)
    if prevBtn then
      btn:SetPoint("LEFT", prevBtn, "RIGHT", 2, 0)
    else
      btn:SetPoint("LEFT", bar, "LEFT", 0, 0)
    end
    btn:SetText(TAB_LABELS[tab])
    btn:SetScript("OnClick", function() UI:ShowTab(tab) end)
    self.tabButtons[tab] = btn
    prevBtn = btn
  end
end

-- Bouton actif = plus clair (texte blanc + halo), au lieu d'un simple
-- Disable() qui grise le texte sur ce client (l'inverse de ce qu'on veut).
function UI:UpdateTabButtonStyles()
  for key, btn in pairs(self.tabButtons or {}) do
    btn:Enable()
    local fontString = btn.GetFontString and btn:GetFontString()
    if key == self.currentTab then
      if fontString then fontString:SetTextColor(unpack(TEXT_BRIGHT)) end
      if not btn.afHighlight then
        local hl = btn:CreateTexture(nil, "BACKGROUND")
        hl:SetAllPoints()
        hl:SetTexture(WHITE)
        btn.afHighlight = hl
      end
      btn.afHighlight:SetVertexColor(ACCENT[1], ACCENT[2], ACCENT[3], 0.35)
      btn.afHighlight:Show()
    else
      if fontString then fontString:SetTextColor(unpack(TEXT_DIM)) end
      if btn.afHighlight then btn.afHighlight:Hide() end
    end
  end
end

function UI:ShowTab(tab)
  self.currentTab = tab
  for key, page in pairs(self.tabPages or {}) do
    page:SetShown(key == tab)
  end
  self:UpdateTabButtonStyles()
  -- Le panneau gauche (talents de classe) n'a rien à faire sous Héritage.
  if self.leftPanel then
    self.leftPanel:SetShown(tab ~= "heritage")
  end
  self:RefreshAll()
end

-- ----- Accueil : texte seul, zéro icône -----

function UI:BuildHomeTab(parent)
  local page = CreateFrame("Frame", nil, parent)
  page:SetAllPoints()

  local lines = {}
  for i = 1, 6 do
    local fs = page:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    fs:SetPoint("TOPLEFT", 4, -4 - (i - 1) * 22)
    fs:SetPoint("RIGHT", -4, 0)
    fs:SetJustifyH("LEFT")
    fs:SetWordWrap(true)
    lines[i] = fs
  end
  page.lines = lines
  return page
end

function UI:RefreshHomeTab()
  local page = self.tabPages and self.tabPages.home
  if not page then return end
  local classId = AF.classId
  if not classId then
    page.lines[1]:SetText("Connectez-vous avec un personnage pour voir vos talents.")
    for i = 2, #page.lines do page.lines[i]:SetText("") end
    return
  end
  local cls = AF:GetClassData(classId)
  local cat = Talents:GetCatalog(classId)
  local planned = Talents:GetPlannedRanks(classId)
  local actual = Talents:GetActualRanks(classId)
  local plan = Talents:GetPlan(classId)

  local parts = {}
  for _, tree in ipairs(cls.trees) do
    local n = 0
    for _, t in ipairs(tree.talents) do n = n + (planned[t.id] or 0) end
    parts[#parts + 1] = tree.name .. " " .. n
  end
  page.lines[1]:SetText("|cffb08d57" .. cls.name .. "|r  —  " .. table.concat(parts, " / "))

  local totalPlanned = BP.totalOf(planned)
  local totalActual = BP.totalOf(actual)
  page.lines[2]:SetText("Points planifiés : " .. totalPlanned .. " / 51    Points appris en jeu : " .. totalActual .. " / 51")

  local level = (UnitLevel and UnitLevel("player")) or 60
  local available = BP.pointsAvailable(level, plan.talented)
  local unspent = math.max(0, available - totalActual)
  page.lines[3]:SetText("Niveau " .. level .. "  —  Points non dépensés : " .. unspent)

  local next_ = Talents:NextPendingStep(classId)
  if next_ then
    page.lines[4]:SetText("Prochain point à appliquer : " .. next_.talent.name .. " (" .. next_.tree.name .. ")")
  else
    page.lines[4]:SetText("Prochain point à appliquer : plan à jour, rien à apprendre.")
  end

  page.lines[5]:SetText("Mode : " .. (Talents:GetMode() == "path" and "Build niveau par niveau" or "Build au niveau 60"))
  page.lines[6]:SetText("Clic gauche : ajouter/planifier — clic droit : retirer. Rien n'est appris sans clic sur Appliquer.")
end

-- ----- Plan : modes + slider + prochains points, zéro icône -----

function UI:BuildPlanTab(parent)
  local page = CreateFrame("Frame", nil, parent)
  page:SetAllPoints()

  local modeLabel = page:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  modeLabel:SetPoint("TOPLEFT", 4, -4)
  modeLabel:SetText("Mode de plan")
  page.modeLabel = modeLabel

  local btn60 = CreateFrame("CheckButton", "AzerothForeverModeFinal", page, "UIRadioButtonTemplate")
  btn60:SetPoint("TOPLEFT", modeLabel, "BOTTOMLEFT", 0, -6)
  btn60.text = _G[btn60:GetName() .. "Text"]
  if btn60.text then btn60.text:SetText("Build au niveau 60") end
  btn60:SetScript("OnClick", function() Talents:SetMode("final"); UI:RefreshAll() end)
  page.btn60 = btn60

  local btnLevel = CreateFrame("CheckButton", "AzerothForeverModePath", page, "UIRadioButtonTemplate")
  btnLevel:SetPoint("TOPLEFT", btn60, "BOTTOMLEFT", 0, -22)
  btnLevel.text = _G[btnLevel:GetName() .. "Text"]
  if btnLevel.text then btnLevel.text:SetText("Build niveau par niveau") end
  btnLevel:SetScript("OnClick", function() Talents:SetMode("path"); UI:RefreshAll() end)
  page.btnLevel = btnLevel

  local slider = CreateFrame("Slider", "AzerothForeverLevelSlider", page, "OptionsSliderTemplate")
  slider:SetPoint("TOPLEFT", btnLevel, "BOTTOMLEFT", 4, -30)
  slider:SetWidth(200)
  slider:SetMinMaxValues(10, 60)
  slider:SetValueStep(1)
  if _G[slider:GetName() .. "Low"] then _G[slider:GetName() .. "Low"]:SetText("10") end
  if _G[slider:GetName() .. "High"] then _G[slider:GetName() .. "High"]:SetText("60") end
  if _G[slider:GetName() .. "Text"] then _G[slider:GetName() .. "Text"]:SetText("Niveau") end
  slider:SetScript("OnValueChanged", function(self, value)
    if UI._suppressSliderCallback then return end
    value = math.floor(value + 0.5)
    AzerothForeverDB.options.levelCursor = value
    UI:RefreshPlanTab()
  end)
  page.slider = slider

  local cursorLabel = page:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
  cursorLabel:SetPoint("TOPLEFT", slider, "BOTTOMLEFT", -4, -10)
  page.cursorLabel = cursorLabel

  local autoApply = CreateFrame("CheckButton", "AzerothForeverAutoApply", page, "UICheckButtonTemplate")
  autoApply:SetPoint("TOPLEFT", cursorLabel, "BOTTOMLEFT", -4, -8)
  autoApply.text = _G[autoApply:GetName() .. "Text"]
  if autoApply.text then
    autoApply.text:SetText("Appliquer auto. à la montée de niveau (désactivé par défaut)")
    autoApply.text:SetFontObject("GameFontHighlightSmall")
  end
  autoApply:SetScript("OnClick", function(self) AzerothForeverDB.options.autoApply = self:GetChecked() and true or false end)
  page.autoApply = autoApply

  local stepsHeader = page:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  stepsHeader:SetPoint("TOPLEFT", autoApply, "BOTTOMLEFT", 4, -10)
  stepsHeader:SetText("Prochains points")
  page.stepsHeader = stepsHeader

  local stepLines = {}
  for i = 1, 8 do
    local fs = page:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    fs:SetPoint("TOPLEFT", stepsHeader, "BOTTOMLEFT", 0, -4 - (i - 1) * 16)
    fs:SetPoint("RIGHT", -4, 0)
    fs:SetJustifyH("LEFT")
    stepLines[i] = fs
  end
  page.stepLines = stepLines

  return page
end

function UI:RefreshPlanTab()
  local page = self.tabPages and self.tabPages.plan
  if not page then return end
  local classId = AF.classId
  local mode = Talents:GetMode()
  page.btn60:SetChecked(mode == "final")
  page.btnLevel:SetChecked(mode == "path")

  local cursor = (AzerothForeverDB and AzerothForeverDB.options.levelCursor) or 60
  self._suppressSliderCallback = true
  page.slider:SetValue(cursor)
  self._suppressSliderCallback = false
  page.cursorLabel:SetText("Curseur : niveau " .. cursor)
  page.autoApply:SetChecked(AzerothForeverDB and AzerothForeverDB.options.autoApply or false)

  if not classId then
    for _, fs in ipairs(page.stepLines) do fs:SetText("") end
    return
  end
  local cat = Talents:GetCatalog(classId)
  local plan = Talents:GetPlan(classId)
  local steps = BP.steps(cat, plan.order, plan.talented)

  local shown = 0
  for _, step in ipairs(steps) do
    if step.level >= cursor and shown < #page.stepLines then
      shown = shown + 1
      page.stepLines[shown]:SetText(string.format("Niv. %d — %s (%s) rang %d/%d", step.level, step.talentName, step.treeName, step.rank, step.maxRank))
    end
  end
  for i = shown + 1, #page.stepLines do page.stepLines[i]:SetText("") end
end

-- ----- Héritage : les 3 arbres ICI uniquement -----

function UI:BuildHeritageTab(parent)
  local page = CreateFrame("Frame", nil, parent)
  page:SetAllPoints()

  local header = page:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  header:SetPoint("TOPLEFT", 4, -4)
  page.header = header

  local presetsLabel = page:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  presetsLabel:SetPoint("TOPLEFT", header, "BOTTOMLEFT", 0, -8)
  presetsLabel:SetText("Préréglages :")

  local prevBtn
  page.presetButtons = {}
  for _, preset in ipairs(AF.Data.Heritage.presets) do
    local btn = CreateFrame("Button", nil, page, "UIPanelButtonTemplate")
    btn:SetSize(120, 20)
    if prevBtn then
      btn:SetPoint("TOPLEFT", prevBtn, "BOTTOMLEFT", 0, -4)
    else
      btn:SetPoint("TOPLEFT", presetsLabel, "BOTTOMLEFT", 0, -4)
    end
    btn:SetText(preset.name)
    btn:SetScript("OnClick", function()
      local ok, err = AF.Heritage:ApplyPreset(preset.id)
      if not ok and err then AF:Print(err) end
      UI:RefreshAll()
    end)
    prevBtn = btn
  end

  local grid = CreateFrame("Frame", nil, page)
  grid:SetPoint("TOPLEFT", presetsLabel, "TOPRIGHT", 130, 0)
  grid:SetPoint("BOTTOMRIGHT", -4, 4)
  page.grid = grid
  page.nodeButtons = {}
  page.treeLabels = {}

  local cat = AF.Heritage:GetCatalog()
  local treeCount = #cat.trees
  local treeWidth = 138
  local cellH = ICON + ROW_GAP + RANK_H

  for treeIdx, tree in ipairs(cat.trees) do
    local label = grid:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    label:SetPoint("TOPLEFT", grid, "TOPLEFT", (treeIdx - 1) * treeWidth, 0)
    label:SetText(tree.name)
    label:SetTextColor(unpack(ACCENT))
    page.treeLabels[treeIdx] = label
  end

  local step = math.floor((treeWidth - 4) / HERITAGE_COLS)
  for _, entry in ipairs(cat.entries) do
    local x = (entry.treeIdx - 1) * treeWidth + entry.node.col * step
    local y = 20 + entry.node.row * cellH
    local btn = CreateFrame("Button", nil, grid)
    btn:SetSize(ICON, ICON)
    btn:SetPoint("TOPLEFT", grid, "TOPLEFT", x, -y)

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

    page.nodeButtons[entry.key] = { btn = btn, entry = entry }
  end

  return page
end

function UI:RefreshHeritageTab()
  local page = self.tabPages and self.tabPages.heritage
  if not page then return end
  local cat = AF.Heritage:GetCatalog()
  local ranks = AF.Heritage:GetRanks()
  local total = AF.HeritagePath.totalOf(ranks)
  page.header:SetText("Héritage — " .. total .. " / " .. AF.Data.Constants.HERITAGE_MAX_POINTS .. " points")

  for key, data in pairs(page.nodeButtons) do
    local rank = ranks[key] or 0
    data.btn.rankText:SetText(rank .. "/" .. data.entry.node.maxRank)
    if rank > 0 then
      data.btn.icon:SetDesaturated(false)
      data.btn.icon:SetAlpha(1)
      data.btn.rankText:SetTextColor(unpack(TEXT_OK))
      data.btn.rankBg:SetVertexColor(0.2, 0.5, 0.2, 0.45)
    else
      data.btn.icon:SetDesaturated(true)
      data.btn.icon:SetAlpha(0.55)
      data.btn.rankText:SetTextColor(unpack(TEXT_DIM))
      data.btn.rankBg:SetVertexColor(0, 0, 0, 0.4)
    end
  end
end

-- ----- Sorts : liste texte -----

function UI:BuildSpellsTab(parent)
  local page = CreateFrame("Frame", nil, parent)
  page:SetAllPoints()

  local scroll = CreateFrame("ScrollFrame", "AzerothForeverSpellScroll", page, "UIPanelScrollFrameTemplate")
  scroll:SetPoint("TOPLEFT", 4, -4)
  scroll:SetPoint("BOTTOMRIGHT", -26, 4)
  local content = CreateFrame("Frame", nil, scroll)
  content:SetSize(1, 1)
  scroll:SetScrollChild(content)
  page.scroll = scroll
  page.content = content
  page.rows = {}
  return page
end

function UI:RefreshSpellsTab()
  local page = self.tabPages and self.tabPages.spells
  if not page then return end
  local classId = AF.classId
  if not classId then return end
  local entries = AF.Spellbook:GetEntries(classId)

  for _, row in ipairs(page.rows) do row:Hide() end

  local rowH = 40
  local y = 0
  for i, entry in ipairs(entries) do
    local row = page.rows[i]
    if not row then
      row = CreateFrame("Frame", nil, page.content)
      row:SetHeight(rowH)
      local icon = row:CreateTexture(nil, "ARTWORK")
      icon:SetSize(24, 24)
      icon:SetPoint("TOPLEFT", 0, 0)
      icon:SetDrawLayer("ARTWORK", 0)
      row.icon = icon
      local name = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
      name:SetPoint("TOPLEFT", icon, "TOPRIGHT", 6, 0)
      name:SetPoint("RIGHT", 0, 0)
      name:SetJustifyH("LEFT")
      name:SetDrawLayer("OVERLAY", 1)
      row.name = name
      local desc = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
      desc:SetPoint("TOPLEFT", icon, "BOTTOMLEFT", 0, -2)
      desc:SetPoint("RIGHT", 0, 0)
      desc:SetJustifyH("LEFT")
      desc:SetWordWrap(true)
      desc:SetDrawLayer("OVERLAY", 1)
      row.desc = desc
      page.rows[i] = row
    end
    row:ClearAllPoints()
    row:SetPoint("TOPLEFT", page.content, "TOPLEFT", 0, -y)
    row:SetPoint("RIGHT", page.content, "RIGHT", 0, 0)
    row.icon:SetTexture("Interface\\Icons\\" .. (entry.icon or "INV_Misc_QuestionMark"))
    row.name:SetText(entry.name .. "  (" .. entry.treeName .. ", rang max " .. entry.maxRank .. ")")
    row.desc:SetText(AF.Spellbook:GetRankDescription(entry, entry.maxRank))
    row:Show()
    y = y + rowH + 6
  end
  page.content:SetHeight(math.max(1, y))
  page.content:SetWidth(page.scroll:GetWidth())
end

-- ----- Builds : import, export, lien du site, QR (180x180 max, bas droite) -----

local QR_MAX = 180

function UI:BuildBuildsTab(parent)
  local page = CreateFrame("Frame", nil, parent)
  page:SetAllPoints()

  -- Lien du site : toujours visible, toujours prérempli (pas de popup).
  local siteLabel = page:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  siteLabel:SetPoint("TOPLEFT", 4, -4)
  siteLabel:SetText("Site Azeroth Forever :")

  local siteBg = CreateFrame("Frame", nil, page)
  siteBg:SetPoint("TOPLEFT", siteLabel, "BOTTOMLEFT", 0, -4)
  siteBg:SetPoint("RIGHT", -4, 0)
  siteBg:SetHeight(22)
  Paint(siteBg, { 0.03, 0.04, 0.06, 1 })
  local siteEdit = CreateFrame("EditBox", nil, siteBg, "InputBoxTemplate")
  siteEdit:SetPoint("TOPLEFT", 6, -3)
  siteEdit:SetPoint("BOTTOMRIGHT", -6, 3)
  siteEdit:SetAutoFocus(false)
  siteEdit:SetText(AF.SITE_URL)
  siteEdit:SetCursorPosition(0)
  siteEdit:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
  siteEdit:SetScript("OnEditFocusGained", function(self) self:HighlightText() end)
  page.siteEdit = siteEdit

  -- Import / export
  local header = page:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  header:SetPoint("TOPLEFT", siteBg, "BOTTOMLEFT", 0, -12)
  header:SetText("Coller un code AF1- (classe) ou AF1H- (héritage) :")

  local editBg = CreateFrame("Frame", nil, page)
  editBg:SetPoint("TOPLEFT", header, "BOTTOMLEFT", 0, -4)
  editBg:SetPoint("RIGHT", -4, 0)
  editBg:SetHeight(22)
  Paint(editBg, { 0.03, 0.04, 0.06, 1 })
  local edit = CreateFrame("EditBox", nil, editBg, "InputBoxTemplate")
  edit:SetPoint("TOPLEFT", 6, -3)
  edit:SetPoint("BOTTOMRIGHT", -6, 3)
  edit:SetAutoFocus(false)
  edit:SetMaxLetters(400)
  page.editBox = edit

  local importBtn = CreateFrame("Button", nil, page, "UIPanelButtonTemplate")
  importBtn:SetPoint("TOPLEFT", editBg, "BOTTOMLEFT", 0, -6)
  importBtn:SetSize(130, 20)
  importBtn:SetText("Importer le code")
  importBtn:SetScript("OnClick", function() UI:DoImport() end)

  local statusText = page:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  statusText:SetPoint("TOPLEFT", importBtn, "BOTTOMLEFT", 0, -6)
  statusText:SetPoint("RIGHT", -4, 0)
  statusText:SetJustifyH("LEFT")
  statusText:SetWordWrap(true)
  page.statusText = statusText

  local exportClassBtn = CreateFrame("Button", nil, page, "UIPanelButtonTemplate")
  exportClassBtn:SetPoint("TOPLEFT", statusText, "BOTTOMLEFT", 0, -10)
  exportClassBtn:SetSize(150, 20)
  exportClassBtn:SetText("Copier (classe)")
  exportClassBtn:SetScript("OnClick", function() UI:FillShareCode() end)

  local exportHeritageBtn = CreateFrame("Button", nil, page, "UIPanelButtonTemplate")
  exportHeritageBtn:SetPoint("TOPLEFT", exportClassBtn, "BOTTOMLEFT", 0, -4)
  exportHeritageBtn:SetSize(150, 20)
  exportHeritageBtn:SetText("Copier (héritage)")
  exportHeritageBtn:SetScript("OnClick", function() UI:FillHeritageCode() end)

  -- Zone QR : cadre fixe 180x180 max, ancré en bas à droite, jamais ailleurs.
  local qrFrame = CreateFrame("Frame", nil, page)
  qrFrame:SetSize(QR_MAX, QR_MAX)
  qrFrame:SetPoint("BOTTOMRIGHT", page, "BOTTOMRIGHT", -4, 4)
  Paint(qrFrame, { 1, 1, 1, 1 })
  page.qrFrame = qrFrame
  qrFrame.qrTextures = {}
  local qrHint = qrFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  qrHint:SetPoint("CENTER")
  qrHint:SetPoint("LEFT", 4, 0)
  qrHint:SetPoint("RIGHT", -4, 0)
  qrHint:SetJustifyH("CENTER")
  qrHint:SetWordWrap(true)
  qrHint:SetTextColor(0, 0, 0)
  qrHint:SetText("QR")
  qrFrame.qrHint = qrHint

  local qrLabel = page:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  qrLabel:SetPoint("BOTTOM", qrFrame, "TOP", 0, 4)
  qrLabel:SetText("QR du build (bouton QR)")

  return page
end

function UI:FocusSiteLink()
  local page = self.tabPages and self.tabPages.builds
  if not page then return end
  page.siteEdit:SetFocus()
  page.siteEdit:HighlightText()
end

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
  local classId = AF.classId
  local page = self.tabPages and self.tabPages.builds
  if not classId or not page then return end
  local cat = Talents:GetCatalog(classId)
  local cls = AF:GetClassData(classId)
  local plan = Talents:GetPlan(classId)
  local check = BP.validateOrder(cat, plan.order)
  if not check.ok then
    page.statusText:SetText("Impossible d'exporter : " .. check.message)
    return
  end
  local path = BP.encodePath(cat, plan.order, plan.talented)
  local code = AF.ShareCode.encode(cls, path)
  self:ShowTab("builds")
  page.editBox:SetText(code)
  page.editBox:SetFocus()
  page.editBox:HighlightText()
  page.statusText:SetText("Code copié dans le champ (Ctrl+C).")
end

function UI:FillHeritageCode()
  local page = self.tabPages and self.tabPages.builds
  if not page then return end
  local code = AF.Heritage:ExportCode()
  self:ShowTab("builds")
  page.editBox:SetText(code)
  page.editBox:SetFocus()
  page.editBox:HighlightText()
  page.statusText:SetText("Code d'Héritage copié dans le champ (Ctrl+C).")
end

function UI:DoImport()
  local page = self.tabPages and self.tabPages.builds
  if not page then return end
  local text = page.editBox:GetText()
  local info = AF.ShareCode.inspect(text)
  if not info.ok then
    page.statusText:SetText(info.error)
    return
  end
  if info.kind == "H" then
    local ok, err = AF.Heritage:ImportCode(text)
    page.statusText:SetText(ok and "Héritage importé." or err)
    if ok then self:ShowTab("heritage") end
  else
    local decoded = AF.ShareCode.decode(text)
    if not decoded.ok then
      page.statusText:SetText(decoded.error)
      return
    end
    if decoded.cls.id ~= AF.classId then
      page.statusText:SetText("Ce code est pour " .. decoded.cls.name .. ", pas votre classe actuelle.")
      return
    end
    Talents:LoadOrder(decoded.cls.id, decoded.order, decoded.talented)
    page.statusText:SetText("Build importé : " .. decoded.cls.name .. ".")
  end
  self:RefreshAll()
end

-- ----- QR : uniquement dans l'onglet Builds, cadre fixe 180x180 -----

function UI:ShowQR()
  self:ShowTab("builds")
  local page = self.tabPages and self.tabPages.builds
  if not page then return end
  local url
  if AF.classId then
    url = self:BuildUrlForClass(AF.classId)
  end
  if not url then
    page.statusText:SetText("Connectez-vous en jeu pour générer un QR.")
    return
  end
  local qr, err = AF.QR.Generate(url)
  if not qr then
    page.statusText:SetText(err)
    return
  end
  self:DrawQR(page.qrFrame, qr)
  page.statusText:SetText("QR généré (" .. #url .. " caractères, version " .. qr.version .. ").")
end

function UI:DrawQR(frame, qr)
  local avail = QR_MAX - 8
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
      tex:SetPoint("TOPLEFT", frame, "TOPLEFT", (QR_MAX - totalSize) / 2 + col * pixel, -((QR_MAX - totalSize) / 2 + row * pixel))
      tex:SetSize(pixel, pixel)
      if qr.isDark(row, col) then
        tex:SetVertexColor(0.05, 0.05, 0.05)
      else
        tex:SetVertexColor(1, 1, 1)
      end
      tex:Show()
    end
  end
  for i = used + 1, #pool do pool[i]:Hide() end
end

-- ---------- Frise de niveaux (10 à 60, même ordre que le site) ----------

function UI:BuildFrise()
  local frise = CreateFrame("Frame", nil, self.frame)
  frise:SetPoint("BOTTOMLEFT", self.frame, "BOTTOMLEFT", MARGIN, MARGIN)
  frise:SetPoint("BOTTOMRIGHT", self.frame, "BOTTOMRIGHT", -MARGIN, MARGIN)
  frise:SetHeight(FRISE_H)
  self.frise = frise

  local label = frise:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  label:SetPoint("BOTTOM", frise, "TOP", 0, 10)
  label:SetTextColor(unpack(ACCENT_BRIGHT))
  self.friseLabel = label

  local bar = CreateFrame("Frame", nil, frise)
  bar:SetPoint("BOTTOMLEFT", frise, "BOTTOMLEFT", 16, 0)
  bar:SetPoint("BOTTOMRIGHT", frise, "BOTTOMRIGHT", -16, 0)
  bar:SetHeight(8)
  Paint(bar, { 0.15, 0.15, 0.18, 1 })
  self.friseBar = bar

  local usableWidth = self.frame:GetWidth() - 2 * MARGIN - 2 * 16
  self.friseTicks = {}
  for lvl = 10, 60 do
    local tick = bar:CreateTexture(nil, "ARTWORK")
    tick:SetTexture(WHITE)
    tick:SetSize(2, 8)
    tick:SetPoint("LEFT", bar, "LEFT", (lvl - 10) * (usableWidth / 50), 0)
    self.friseTicks[lvl] = tick
  end

  local label10 = frise:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  label10:SetPoint("RIGHT", bar, "LEFT", -2, 0)
  label10:SetText("10")
  local label60 = frise:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  label60:SetPoint("LEFT", bar, "RIGHT", 2, 0)
  label60:SetText("60")
end

function UI:RefreshFrise()
  if not self.friseTicks then return end
  local classId = AF.classId
  local cursor = (AzerothForeverDB and AzerothForeverDB.options.levelCursor) or 60
  self.friseLabel:SetText("Niv. " .. cursor)

  local levelsWithSteps = {}
  if classId then
    local cat = Talents:GetCatalog(classId)
    local plan = Talents:GetPlan(classId)
    if cat then
      for _, step in ipairs(BP.steps(cat, plan.order, plan.talented)) do
        levelsWithSteps[step.level] = true
      end
    end
  end
  for lvl, tick in pairs(self.friseTicks) do
    if lvl == cursor then
      tick:SetVertexColor(unpack(ACCENT_BRIGHT))
    elseif levelsWithSteps[lvl] then
      tick:SetVertexColor(0.6, 0.6, 0.65)
    else
      tick:SetVertexColor(0.35, 0.35, 0.4)
    end
  end
end

-- ---------- Rafraîchissement global ----------

function UI:RefreshAll()
  if not self.frame or not self.frame:IsShown() then return end
  if self.leftPanel then
    self.leftPanel:SetShown(self.currentTab ~= "heritage")
  end
  if self.currentTab ~= "heritage" then
    self:RefreshLeftPanel()
  end
  self:RefreshFrise()
  if self.currentTab == "home" then self:RefreshHomeTab()
  elseif self.currentTab == "plan" then self:RefreshPlanTab()
  elseif self.currentTab == "heritage" then self:RefreshHeritageTab()
  elseif self.currentTab == "spells" then self:RefreshSpellsTab()
  end
end

function UI:RefreshTalents()
  self:RefreshAll()
end
