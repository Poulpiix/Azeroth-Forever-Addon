-- Azeroth Forever : interface (/af). Thème sombre Azeroth Forever (pas le
-- skin doré « Talents Forever »). Fenêtre unique : arbres à gauche, onglets
-- à droite (Accueil / Plan / Héritage / Sorts / Builds), frise en bas.
local ADDON_NAME, AF = ...

local UI = {}
AF.UI = UI

local BP = AF.BuildPath
local Talents = AF.Talents

-- ---------- Thème ----------

local BG = { 0.05, 0.05, 0.08, 0.95 }
local BORDER = { 0.35, 0.30, 0.20, 1 }
local ACCENT = { 0.70, 0.55, 0.30 } -- or discret, pas doré massif
local TEXT_DIM = { 0.65, 0.65, 0.70 }
local TEXT_OK = { 0.40, 0.80, 0.40 }
local TEXT_WARN = { 0.85, 0.35, 0.30 }

local BACKDROP = {
  bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
  edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
  tile = true, tileSize = 16, edgeSize = 16,
  insets = { left = 4, right = 4, top = 4, bottom = 4 }
}

local function Dark(frame)
  frame:SetBackdrop(BACKDROP)
  frame:SetBackdropColor(unpack(BG))
  frame:SetBackdropBorderColor(unpack(BORDER))
end

local WHITE = "Interface\\Buttons\\WHITE8X8"

-- ---------- Fenêtre ----------

function UI:OnFrameLoad(frame)
  self.frame = frame
  frame:RegisterForDrag("LeftButton")
  Dark(frame)
  self:BuildToolbar()
  self:BuildTabBar()
  self:BuildLeftPanel()
  self:BuildRightPanel()
  self:BuildFrise()
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

-- ---------- Barre d'outils ----------

local TOOLBAR_BUTTONS = {
  { key = "applyNext", label = "Appliquer suivant" },
  { key = "applyAll", label = "Appliquer tout" },
  { key = "reset", label = "Reset" },
  { key = "undo", label = "Undo" },
  { key = "import", label = "Import" },
  { key = "share", label = "Partager" },
  { key = "qr", label = "QR" },
  { key = "site", label = "Site" }
}

function UI:BuildToolbar()
  local bar = CreateFrame("Frame", nil, self.frame)
  bar:SetPoint("TOPLEFT", 12, -34)
  bar:SetPoint("TOPRIGHT", -12, -34)
  bar:SetHeight(26)
  self.toolbar = bar

  local prevBtn
  for _, def in ipairs(TOOLBAR_BUTTONS) do
    local btn = CreateFrame("Button", nil, bar, "UIPanelButtonTemplate")
    btn:SetSize(104, 22)
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
    self:ShowQR()
  elseif key == "site" then
    self:ShowCopyPopup("Site Azeroth Forever", AF.SITE_URL)
  end
end

-- ---------- Onglets ----------

local TABS = { "home", "plan", "heritage", "spells", "builds" }
local TAB_LABELS = { home = "Accueil", plan = "Plan", heritage = "Héritage", spells = "Sorts", builds = "Builds" }

function UI:BuildTabBar()
  local bar = CreateFrame("Frame", nil, self.frame)
  bar:SetPoint("TOPRIGHT", self.toolbar, "BOTTOMRIGHT", 0, -6)
  bar:SetPoint("LEFT", self.frame, "LEFT", 386, 0)
  bar:SetHeight(24)
  self.tabBar = bar
  self.tabButtons = {}

  local prevBtn
  for _, tab in ipairs(TABS) do
    local btn = CreateFrame("Button", nil, bar, "UIPanelButtonTemplate")
    btn:SetSize(96, 22)
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

function UI:ShowTab(tab)
  self.currentTab = tab
  for key, page in pairs(self.tabPages) do
    page:SetShown(key == tab)
  end
  for key, btn in pairs(self.tabButtons) do
    if key == tab then
      btn:Disable()
    else
      btn:Enable()
    end
  end
  self:RefreshAll()
end

-- ---------- Panneau gauche : 3 arbres de talents ----------

local CELL = 30
local ICON_SIZE = 26

function UI:BuildLeftPanel()
  local panel = CreateFrame("Frame", nil, self.frame)
  panel:SetPoint("TOPLEFT", self.toolbar, "BOTTOMLEFT", 0, -34)
  panel:SetPoint("BOTTOMLEFT", self.frame, "BOTTOMLEFT", 12, 48)
  panel:SetWidth(360)
  Dark(panel)
  self.leftPanel = panel

  local title = panel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  title:SetPoint("TOPLEFT", 6, -6)
  title:SetText("Talents")
  self.leftTitle = title

  self.treeHeaders = {}
  self.talentButtons = {} -- [classId][catalogIndex] = button
end

function UI:GetOrCreateTalentButtons(classId)
  if self.talentButtons[classId] then return self.talentButtons[classId] end
  local cat = Talents:GetCatalog(classId)
  if not cat then return nil end
  local buttons = {}
  local panel = self.leftPanel

  for _, entry in ipairs(cat.entries) do
    local treeX = entry.treeIdx * 118
    local btn = CreateFrame("Button", nil, panel)
    btn:SetSize(ICON_SIZE, ICON_SIZE)
    btn:SetPoint("TOPLEFT", panel, "TOPLEFT", 6 + treeX + entry.talent.col * CELL, -24 - entry.talent.row * CELL)

    local icon = btn:CreateTexture(nil, "ARTWORK")
    icon:SetAllPoints()
    icon:SetTexture("Interface\\Icons\\" .. (entry.talent.icon or "INV_Misc_QuestionMark"))
    btn.icon = icon

    local border = btn:CreateTexture(nil, "OVERLAY")
    border:SetPoint("TOPLEFT", -2, 2)
    border:SetPoint("BOTTOMRIGHT", 2, -2)
    border:SetTexture(WHITE)
    border:SetVertexColor(0, 0, 0, 0)
    btn.border = border

    local rankText = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    rankText:SetPoint("BOTTOMRIGHT", 1, -1)
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
  local classId = AF.classId
  local panel = self.leftPanel
  if not classId then
    self.leftTitle:SetText("Talents (connectez-vous en jeu)")
    return
  end
  local cls = AF:GetClassData(classId)
  local cat = Talents:GetCatalog(classId)
  if not cls or not cat then
    self.leftTitle:SetText("Talents : classe non reconnue")
    return
  end
  self.leftTitle:SetText(cls.name)

  for _, header in ipairs(self.treeHeaders) do header:Hide() end
  wipe(self.treeHeaders)
  for _, tree in ipairs(cls.trees) do
    local header = panel:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    header:SetPoint("TOPLEFT", panel, "TOPLEFT", 6 + tree.order * 118, -14)
    header:SetText(tree.name)
    header:SetTextColor(unpack(ACCENT))
    self.treeHeaders[#self.treeHeaders + 1] = header
  end

  local buttons = self:GetOrCreateTalentButtons(classId)
  if not buttons then return end
  for _, other in pairs(self.talentButtons) do
    if other ~= buttons then
      for _, b in pairs(other) do b:Hide() end
    end
  end

  local planned = Talents:GetPlannedRanks(classId)
  local actual = Talents:GetActualRanks(classId)

  for _, entry in ipairs(cat.entries) do
    local btn = buttons[entry.index]
    btn:Show()
    local pRank = planned[entry.talent.id] or 0
    local aRank = actual[entry.talent.id] or 0
    btn.rankText:SetText(pRank .. "/" .. entry.talent.maxRank)
    if aRank >= entry.talent.maxRank and entry.talent.maxRank > 0 then
      btn.rankText:SetTextColor(unpack(ACCENT))
    elseif pRank > aRank then
      btn.rankText:SetTextColor(unpack(TEXT_OK))
    else
      btn.rankText:SetTextColor(1, 1, 1)
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

-- ---------- Panneau droit : onglets ----------

function UI:BuildRightPanel()
  local container = CreateFrame("Frame", nil, self.frame)
  container:SetPoint("TOPLEFT", self.tabBar, "BOTTOMLEFT", 0, -6)
  container:SetPoint("BOTTOMRIGHT", self.frame, "BOTTOMRIGHT", -12, 48)
  Dark(container)
  self.rightPanel = container

  self.tabPages = {}
  self.tabPages.home = self:BuildHomeTab(container)
  self.tabPages.plan = self:BuildPlanTab(container)
  self.tabPages.heritage = self:BuildHeritageTab(container)
  self.tabPages.spells = self:BuildSpellsTab(container)
  self.tabPages.builds = self:BuildBuildsTab(container)

  self.currentTab = "home"
  for key, page in pairs(self.tabPages) do page:SetShown(key == "home") end
  self.tabButtons.home:Disable()
end

-- ----- Accueil -----

function UI:BuildHomeTab(parent)
  local page = CreateFrame("Frame", nil, parent)
  page:SetAllPoints()

  local lines = {}
  for i = 1, 6 do
    local fs = page:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    fs:SetPoint("TOPLEFT", 10, -10 - (i - 1) * 20)
    fs:SetPoint("RIGHT", -10, 0)
    fs:SetJustifyH("LEFT")
    lines[i] = fs
  end
  page.lines = lines
  return page
end

function UI:RefreshHomeTab()
  local page = self.tabPages.home
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

-- ----- Plan -----

function UI:BuildPlanTab(parent)
  local page = CreateFrame("Frame", nil, parent)
  page:SetAllPoints()

  local modeLabel = page:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  modeLabel:SetPoint("TOPLEFT", 10, -10)
  modeLabel:SetText("Mode de plan")
  page.modeLabel = modeLabel

  local btn60 = CreateFrame("CheckButton", "AzerothForeverModeFinal", page, "UIRadioButtonTemplate")
  btn60:SetPoint("TOPLEFT", 10, -30)
  btn60.text = _G[btn60:GetName() .. "Text"]
  if btn60.text then btn60.text:SetText("Build au niveau 60") end
  btn60:SetScript("OnClick", function() Talents:SetMode("final"); UI:RefreshAll() end)
  page.btn60 = btn60

  local btnLevel = CreateFrame("CheckButton", "AzerothForeverModePath", page, "UIRadioButtonTemplate")
  btnLevel:SetPoint("TOPLEFT", btn60, "BOTTOMLEFT", 0, -26)
  btnLevel.text = _G[btnLevel:GetName() .. "Text"]
  if btnLevel.text then btnLevel.text:SetText("Build niveau par niveau") end
  btnLevel:SetScript("OnClick", function() Talents:SetMode("path"); UI:RefreshAll() end)
  page.btnLevel = btnLevel

  local slider = CreateFrame("Slider", "AzerothForeverLevelSlider", page, "OptionsSliderTemplate")
  slider:SetPoint("TOPLEFT", btnLevel, "BOTTOMLEFT", 4, -34)
  slider:SetWidth(240)
  slider:SetMinMaxValues(10, 60)
  slider:SetValueStep(1)
  if _G[slider:GetName() .. "Low"] then _G[slider:GetName() .. "Low"]:SetText("10") end
  if _G[slider:GetName() .. "High"] then _G[slider:GetName() .. "High"]:SetText("60") end
  if _G[slider:GetName() .. "Text"] then _G[slider:GetName() .. "Text"]:SetText("Niveau") end
  slider:SetScript("OnValueChanged", function(self, value)
    value = math.floor(value + 0.5)
    AzerothForeverDB.options.levelCursor = value
    UI:RefreshPlanTab()
  end)
  page.slider = slider

  local cursorLabel = page:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
  cursorLabel:SetPoint("TOPLEFT", slider, "BOTTOMLEFT", -4, -12)
  page.cursorLabel = cursorLabel

  local autoApply = CreateFrame("CheckButton", "AzerothForeverAutoApply", page, "UICheckButtonTemplate")
  autoApply:SetPoint("TOPLEFT", cursorLabel, "BOTTOMLEFT", -4, -10)
  autoApply.text = _G[autoApply:GetName() .. "Text"]
  if autoApply.text then autoApply.text:SetText("Appliquer automatiquement le prochain point à la montée de niveau (désactivé par défaut)") end
  autoApply:SetScript("OnClick", function(self) AzerothForeverDB.options.autoApply = self:GetChecked() and true or false end)
  page.autoApply = autoApply

  local stepsHeader = page:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  stepsHeader:SetPoint("TOPLEFT", autoApply, "BOTTOMLEFT", 4, -10)
  stepsHeader:SetText("Prochains points")
  page.stepsHeader = stepsHeader

  local stepLines = {}
  for i = 1, 10 do
    local fs = page:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    fs:SetPoint("TOPLEFT", stepsHeader, "BOTTOMLEFT", 0, -4 - (i - 1) * 16)
    stepLines[i] = fs
  end
  page.stepLines = stepLines

  return page
end

function UI:RefreshPlanTab()
  local page = self.tabPages.plan
  local classId = AF.classId
  local mode = Talents:GetMode()
  page.btn60:SetChecked(mode == "final")
  page.btnLevel:SetChecked(mode == "path")

  local cursor = (AzerothForeverDB and AzerothForeverDB.options.levelCursor) or 60
  page.slider:SetValue(cursor)
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

-- ----- Héritage -----

local HERITAGE_CELL = 34

function UI:BuildHeritageTab(parent)
  local page = CreateFrame("Frame", nil, parent)
  page:SetAllPoints()

  local header = page:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  header:SetPoint("TOPLEFT", 10, -10)
  page.header = header

  local presetsLabel = page:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  presetsLabel:SetPoint("TOPLEFT", header, "BOTTOMLEFT", 0, -6)
  presetsLabel:SetText("Préréglages :")

  local prevBtn
  page.presetButtons = {}
  for _, preset in ipairs(AF.Data.Heritage.presets) do
    local btn = CreateFrame("Button", nil, page, "UIPanelButtonTemplate")
    btn:SetSize(150, 20)
    if prevBtn then
      btn:SetPoint("LEFT", prevBtn, "RIGHT", 4, 0)
    else
      btn:SetPoint("LEFT", presetsLabel, "RIGHT", 6, 0)
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
  grid:SetPoint("TOPLEFT", presetsLabel, "BOTTOMLEFT", 0, -14)
  grid:SetPoint("BOTTOMRIGHT", -10, 10)
  page.grid = grid
  page.nodeButtons = {}

  local cat = AF.Heritage:GetCatalog()
  for _, entry in ipairs(cat.entries) do
    local x = entry.treeIdx * 150 + entry.node.col * HERITAGE_CELL
    local y = entry.node.row * HERITAGE_CELL
    local btn = CreateFrame("Button", nil, grid)
    btn:SetSize(28, 28)
    btn:SetPoint("TOPLEFT", grid, "TOPLEFT", x, -y)

    local icon = btn:CreateTexture(nil, "ARTWORK")
    icon:SetAllPoints()
    icon:SetTexture("Interface\\Icons\\" .. (entry.node.icon or "INV_Misc_QuestionMark"))
    btn.icon = icon

    local rankText = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    rankText:SetPoint("BOTTOMRIGHT", 1, -1)
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

  for treeIdx, tree in ipairs(cat.trees) do
    local label = grid:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    label:SetPoint("BOTTOMLEFT", grid, "TOPLEFT", (treeIdx - 1) * 150, 4)
    label:SetText(tree.name)
    label:SetTextColor(unpack(ACCENT))
  end

  return page
end

function UI:RefreshHeritageTab()
  local page = self.tabPages.heritage
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
    else
      data.btn.icon:SetDesaturated(true)
      data.btn.icon:SetAlpha(0.55)
    end
  end
end

-- ----- Sorts -----

function UI:BuildSpellsTab(parent)
  local page = CreateFrame("Frame", nil, parent)
  page:SetAllPoints()

  local scroll = CreateFrame("ScrollFrame", "AzerothForeverSpellScroll", page, "UIPanelScrollFrameTemplate")
  scroll:SetPoint("TOPLEFT", 10, -10)
  scroll:SetPoint("BOTTOMRIGHT", -30, 10)
  local content = CreateFrame("Frame", nil, scroll)
  content:SetSize(1, 1)
  scroll:SetScrollChild(content)
  page.scroll = scroll
  page.content = content
  page.rows = {}
  return page
end

function UI:RefreshSpellsTab()
  local page = self.tabPages.spells
  local classId = AF.classId
  if not classId then return end
  local entries = AF.Spellbook:GetEntries(classId)

  for _, row in ipairs(page.rows) do row:Hide() end

  local y = 0
  for i, entry in ipairs(entries) do
    local row = page.rows[i]
    if not row then
      row = CreateFrame("Frame", nil, page.content)
      row:SetSize(1, 34)
      local icon = row:CreateTexture(nil, "ARTWORK")
      icon:SetSize(24, 24)
      icon:SetPoint("TOPLEFT", 0, 0)
      row.icon = icon
      local name = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
      name:SetPoint("TOPLEFT", icon, "TOPRIGHT", 6, 0)
      row.name = name
      local desc = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
      desc:SetPoint("TOPLEFT", name, "BOTTOMLEFT", 0, -2)
      desc:SetPoint("RIGHT", -6, 0)
      desc:SetJustifyH("LEFT")
      desc:SetWordWrap(true)
      row.desc = desc
      page.rows[i] = row
    end
    row:SetPoint("TOPLEFT", page.content, "TOPLEFT", 0, -y)
    row:SetPoint("RIGHT", page.content, "RIGHT", 0, 0)
    row.icon:SetTexture("Interface\\Icons\\" .. (entry.icon or "INV_Misc_QuestionMark"))
    row.name:SetText(entry.name .. "  (" .. entry.treeName .. ", rang max " .. entry.maxRank .. ")")
    row.desc:SetText(AF.Spellbook:GetRankDescription(entry, entry.maxRank))
    row:Show()
    y = y + 46
  end
  page.content:SetHeight(math.max(1, y))
  page.content:SetWidth(page.scroll:GetWidth())
end

-- ----- Builds (import/export, lien site, QR) -----

function UI:BuildBuildsTab(parent)
  local page = CreateFrame("Frame", nil, parent)
  page:SetAllPoints()

  local header = page:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  header:SetPoint("TOPLEFT", 10, -10)
  header:SetText("Coller un code AF1- (classe) ou AF1H- (héritage) :")

  local editBg = CreateFrame("Frame", nil, page)
  editBg:SetPoint("TOPLEFT", header, "BOTTOMLEFT", 0, -6)
  editBg:SetPoint("RIGHT", -10, 0)
  editBg:SetHeight(56)
  Dark(editBg)

  local edit = CreateFrame("EditBox", nil, editBg, "InputBoxTemplate")
  edit:SetPoint("TOPLEFT", 8, -8)
  edit:SetPoint("BOTTOMRIGHT", -8, 8)
  edit:SetAutoFocus(false)
  edit:SetMultiLine(false)
  edit:SetMaxLetters(400)
  page.editBox = edit

  local importBtn = CreateFrame("Button", nil, page, "UIPanelButtonTemplate")
  importBtn:SetPoint("TOPLEFT", editBg, "BOTTOMLEFT", 0, -8)
  importBtn:SetSize(140, 22)
  importBtn:SetText("Importer le code")
  importBtn:SetScript("OnClick", function() UI:DoImport() end)

  local statusText = page:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  statusText:SetPoint("LEFT", importBtn, "RIGHT", 10, 0)
  statusText:SetPoint("RIGHT", -10, 0)
  statusText:SetJustifyH("LEFT")
  statusText:SetWordWrap(true)
  page.statusText = statusText

  local exportHeader = page:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  exportHeader:SetPoint("TOPLEFT", importBtn, "BOTTOMLEFT", 0, -20)
  exportHeader:SetText("Exporter le plan actuel :")

  local exportClassBtn = CreateFrame("Button", nil, page, "UIPanelButtonTemplate")
  exportClassBtn:SetPoint("TOPLEFT", exportHeader, "BOTTOMLEFT", 0, -6)
  exportClassBtn:SetSize(160, 22)
  exportClassBtn:SetText("Copier le code (classe)")
  exportClassBtn:SetScript("OnClick", function() UI:FillShareCode() end)

  local exportHeritageBtn = CreateFrame("Button", nil, page, "UIPanelButtonTemplate")
  exportHeritageBtn:SetPoint("LEFT", exportClassBtn, "RIGHT", 6, 0)
  exportHeritageBtn:SetSize(160, 22)
  exportHeritageBtn:SetText("Copier le code (héritage)")
  exportHeritageBtn:SetScript("OnClick", function() UI:FillHeritageCode() end)

  local siteBtn = CreateFrame("Button", nil, page, "UIPanelButtonTemplate")
  siteBtn:SetPoint("TOPLEFT", exportClassBtn, "BOTTOMLEFT", 0, -14)
  siteBtn:SetSize(200, 22)
  siteBtn:SetText("azerothforever.info")
  siteBtn:SetScript("OnClick", function() UI:ShowCopyPopup("Site Azeroth Forever", AF.SITE_URL) end)

  local qrBtn = CreateFrame("Button", nil, page, "UIPanelButtonTemplate")
  qrBtn:SetPoint("LEFT", siteBtn, "RIGHT", 6, 0)
  qrBtn:SetSize(140, 22)
  qrBtn:SetText("Afficher le QR")
  qrBtn:SetScript("OnClick", function() UI:ShowQR() end)

  local qrFrame = CreateFrame("Frame", nil, page)
  qrFrame:SetPoint("TOPLEFT", siteBtn, "BOTTOMLEFT", 0, -14)
  qrFrame:SetPoint("BOTTOMRIGHT", -10, 10)
  Dark(qrFrame)
  page.qrFrame = qrFrame
  qrFrame.qrTextures = {}
  local qrHint = qrFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  qrHint:SetPoint("CENTER")
  qrHint:SetText("Cliquez sur « Afficher le QR » pour générer le lien du build actuel.")
  qrFrame.qrHint = qrHint

  return page
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
  if not classId then return end
  local cat = Talents:GetCatalog(classId)
  local cls = AF:GetClassData(classId)
  local plan = Talents:GetPlan(classId)
  local check = BP.validateOrder(cat, plan.order)
  if not check.ok then
    self.tabPages.builds.statusText:SetText("Impossible d'exporter : " .. check.message)
    return
  end
  local path = BP.encodePath(cat, plan.order, plan.talented)
  local code = AF.ShareCode.encode(cls, path)
  self:ShowTab("builds")
  self.tabPages.builds.editBox:SetText(code)
  self.tabPages.builds.editBox:HighlightText()
  self.tabPages.builds.editBox:SetFocus()
  self.tabPages.builds.statusText:SetText("Code copié dans le champ ci-dessus (Ctrl+C).")
end

function UI:FillHeritageCode()
  local code = AF.Heritage:ExportCode()
  self:ShowTab("builds")
  self.tabPages.builds.editBox:SetText(code)
  self.tabPages.builds.editBox:HighlightText()
  self.tabPages.builds.editBox:SetFocus()
  self.tabPages.builds.statusText:SetText("Code d'Héritage copié dans le champ ci-dessus (Ctrl+C).")
end

function UI:DoImport()
  local page = self.tabPages.builds
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

-- ----- Popup de copie (pas de navigateur en jeu : Ctrl+C dans un champ) -----

function UI:ShowCopyPopup(title, text)
  StaticPopupDialogs["AZEROTHFOREVER_COPY"] = {
    text = "%s",
    button1 = "Fermer",
    hasEditBox = true,
    editBoxWidth = 320,
    OnShow = function(self)
      self.editBox:SetText(text)
      self.editBox:HighlightText()
      self.editBox:SetFocus()
    end,
    EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
    timeout = 0, whileDead = true, hideOnEscape = true
  }
  StaticPopup_Show("AZEROTHFOREVER_COPY", title)
end

-- ----- QR -----

function UI:ShowQR()
  self:ShowTab("builds")
  local page = self.tabPages.builds
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
  local avail = math.min(frame:GetWidth(), frame:GetHeight())
  if avail <= 0 then avail = 220 end
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
  frise:SetPoint("BOTTOMLEFT", self.frame, "BOTTOMLEFT", 12, 12)
  frise:SetPoint("BOTTOMRIGHT", self.frame, "BOTTOMRIGHT", -12, 12)
  frise:SetHeight(30)
  Dark(frise)
  self.frise = frise

  self.friseTicks = {}
  for lvl = 10, 60 do
    local tick = frise:CreateTexture(nil, "ARTWORK")
    tick:SetTexture(WHITE)
    tick:SetSize(3, 14)
    tick:SetPoint("LEFT", frise, "LEFT", 6 + (lvl - 10) * ((900 - 24 - 12) / 50), 0)
    self.friseTicks[lvl] = tick
  end

  local label10 = frise:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  label10:SetPoint("BOTTOMLEFT", frise, "TOPLEFT", 4, 2)
  label10:SetText("10")
  local label60 = frise:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  label60:SetPoint("BOTTOMRIGHT", frise, "TOPRIGHT", -4, 2)
  label60:SetText("60")
end

function UI:RefreshFrise()
  local classId = AF.classId
  local cursor = (AzerothForeverDB and AzerothForeverDB.options.levelCursor) or 60
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
      tick:SetVertexColor(unpack(ACCENT))
    elseif levelsWithSteps[lvl] then
      tick:SetVertexColor(0.5, 0.5, 0.55)
    else
      tick:SetVertexColor(0.25, 0.25, 0.28)
    end
  end
end

-- ---------- Rafraîchissement global ----------

function UI:RefreshAll()
  if not self.frame or not self.frame:IsShown() then return end
  self:RefreshLeftPanel()
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
