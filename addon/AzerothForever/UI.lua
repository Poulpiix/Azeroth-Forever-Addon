-- Azeroth Forever : interface (/af).
--
-- Structure calquée sur Talents Forever (voir captures), habillée au thème
-- du site (fond #0b1220, filets or #c9a227) plutôt que le skin doré massif.
-- Fenêtre 1100x720 : titre, ligne résumé, GAUCHE ~70% (les arbres — classe,
-- ou Héritage plein cadre selon l'onglet), DROITE ~30% (onglets, un seul
-- contenu affiché), frise de niveaux (masquée sous Héritage) puis barre
-- d'actions. Le panneau droit ancre son bord gauche sur le bord droit du
-- panneau gauche : le non-chevauchement est garanti par construction.
local ADDON_NAME, AF = ...

local UI = {}
AF.UI = UI

local BP = AF.BuildPath
local Talents = AF.Talents

-- ---------- Layout ----------

local WIN_W, WIN_H = 1100, 720
local TITLE_H, HEADER_H = 34, 30
local MARGIN, PANEL_GAP = 10, 10
local LEFT_RATIO = 0.68
local ACTION_H, FRISE_H = 26, 54
local ICON, RANK_H, ROW_GAP = 36, 14, 8
local TALENT_COLS = 4

-- ---------- Thème (site Azeroth Forever) ----------

local function hex(h, a)
  local r = math.floor(h / 0x10000) % 0x100
  local g = math.floor(h / 0x100) % 0x100
  local b = h % 0x100
  return { r / 255, g / 255, b / 255, a or 1 }
end

local BG = hex(0x0b1220)
local PANEL_BG = { 0.07, 0.10, 0.16, 1 }
local CADRE_BG = { 0.05, 0.08, 0.13, 1 }
local GOLD = hex(0xc9a227)
local GOLD_DIM = { 0.50, 0.41, 0.15, 1 }
local TEXT = hex(0xe8e0d0)
local TEXT_DIM = { 0.58, 0.56, 0.52 }
local TEXT_OK = { 0.45, 0.85, 0.45 }
local ALLIANCE = hex(0x2a4a8c)
local HORDE = hex(0x8c2a2a)

local function FactionColor()
  local faction = AzerothForeverDB and AzerothForeverDB.options and AzerothForeverDB.options.faction
  return faction == "horde" and HORDE or ALLIANCE
end

local WHITE = "Interface\\Buttons\\WHITE8X8"

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

-- ---------- Fenêtre ----------

function UI:OnFrameLoad(frame)
  self.frame = frame
  frame:SetSize(WIN_W, WIN_H)
  frame:SetFrameStrata("DIALOG")
  frame:ClearAllPoints()
  frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
  frame:RegisterForDrag("LeftButton")
  Fill(frame, BG)
  GoldEdge(frame, 2)

  if frame.Title then GoldText(frame.Title) end

  local sections = {
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

-- ---------- Ligne résumé (classe, points par arbre, niveau) ----------

function UI:BuildHeaderRow()
  local row = CreateFrame("Frame", nil, self.frame)
  row:SetPoint("TOPLEFT", self.frame, "TOPLEFT", MARGIN, -TITLE_H)
  row:SetPoint("TOPRIGHT", self.frame, "TOPRIGHT", -MARGIN, -TITLE_H)
  row:SetHeight(HEADER_H)
  self.headerRow = row

  local summary = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  summary:SetPoint("LEFT", row, "LEFT", 4, 0)
  summary:SetPoint("RIGHT", row, "CENTER", 0, 0)
  summary:SetJustifyH("LEFT")
  summary:SetTextColor(unpack(TEXT))
  self.headerSummary = summary

  local stats = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  stats:SetPoint("RIGHT", row, "RIGHT", -4, 0)
  stats:SetPoint("LEFT", row, "CENTER", 0, 0)
  stats:SetJustifyH("RIGHT")
  stats:SetTextColor(unpack(TEXT))
  self.headerStats = stats
end

function UI:RefreshHeaderRow()
  if not self.headerSummary then return end
  local classId = AF.classId
  if not classId then
    self.headerSummary:SetText("Connectez-vous en jeu pour voir vos talents.")
    self.headerStats:SetText("")
    return
  end
  local cls = AF:GetClassData(classId)
  local planned = Talents:GetPlannedRanks(classId)
  local actual = Talents:GetActualRanks(classId)
  local plan = Talents:GetPlan(classId)

  local parts = {}
  for _, tree in ipairs(cls.trees) do
    local n = 0
    for _, t in ipairs(tree.talents) do n = n + (planned[t.id] or 0) end
    parts[#parts + 1] = n
  end
  self.headerSummary:SetText("|cffc9a227" .. cls.name .. "|r   " .. table.concat(parts, " / "))

  local level = (UnitLevel and UnitLevel("player")) or 60
  local totalPlanned = BP.totalOf(planned)
  local totalActual = BP.totalOf(actual)
  local maxPoints = AF.Data.Constants.MAX_POINTS
  self.headerStats:SetText("Niveau " .. level .. "   Planifiés " .. totalPlanned .. "/" .. maxPoints
    .. "   Appris " .. totalActual .. "/" .. maxPoints)
end

-- ---------- Zone principale : gauche (arbres) + droite (onglets) ----------

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
  self:BuildTabBar(right)
  self:BuildTabContent(right)
end

-- ---------- Gauche : arbres de talents de classe ----------

-- Un pas de grille (icône + rang dessous) qui tient toujours dans la largeur
-- du cadre, quel que soit le nombre de colonnes de l'arbre (<=4 pour toutes
-- les classes du jeu de données actuel).
local function GridStep(cadreWidth, cols)
  local innerWidth = cadreWidth - 8
  return math.max(ICON + ROW_GAP, math.floor(innerWidth / cols))
end

local function BuildTreeCadres(parent, count, labelGetter)
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

function UI:RefreshClassTrees()
  local classId = AF.classId
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

  local planned = Talents:GetPlannedRanks(classId)
  local actual = Talents:GetActualRanks(classId)

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

      if aRank >= entry.talent.maxRank and entry.talent.maxRank > 0 then
        GoldText(btn.rankText)
        btn.rankBg:SetVertexColor(GOLD[1], GOLD[2], GOLD[3], 0.35)
      elseif pRank > aRank then
        btn.rankText:SetTextColor(unpack(TEXT_OK))
        btn.rankBg:SetVertexColor(0.2, 0.5, 0.2, 0.45)
      elseif pRank > 0 then
        btn.rankText:SetTextColor(unpack(TEXT))
        btn.rankBg:SetVertexColor(0.15, 0.15, 0.18, 0.6)
      else
        btn.rankText:SetTextColor(unpack(TEXT_DIM))
        btn.rankBg:SetVertexColor(0, 0, 0, 0.4)
      end

      if aRank > 0 then
        btn.border:SetVertexColor(GOLD[1], GOLD[2], GOLD[3], 0.9)
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

-- ---------- Droite : onglets ----------

local TABS = { "home", "plan", "heritage", "spells", "builds" }
local TAB_LABELS = { home = "Accueil", plan = "Plan", heritage = "Héritage", spells = "Sorts", builds = "Builds" }

function UI:BuildTabBar(parent)
  local bar = CreateFrame("Frame", nil, parent)
  bar:SetPoint("TOPLEFT", parent, "TOPLEFT", 6, -6)
  bar:SetPoint("TOPRIGHT", parent, "TOPRIGHT", -6, -6)
  bar:SetHeight(24)
  self.tabBar = bar
  self.tabButtons = {}

  local n = #TABS
  local btnWidth = math.floor((parent:GetWidth() - 12 - (n - 1) * 2) / n)
  if btnWidth <= 0 then btnWidth = 60 end
  local prevBtn
  for _, tab in ipairs(TABS) do
    local btn = CreateFrame("Button", nil, bar, "UIPanelButtonTemplate")
    btn:SetSize(btnWidth, 22)
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

-- Bouton actif = or (pas gris) : on garde les boutons cliquables et on
-- teinte nous-mêmes, plutôt que Disable() qui grise le texte sur ce client.
function UI:UpdateTabButtonStyles()
  for key, btn in pairs(self.tabButtons or {}) do
    btn:Enable()
    local fontString = btn.GetFontString and btn:GetFontString()
    if key == self.currentTab then
      if fontString then GoldText(fontString) end
      if not btn.afHighlight then
        local hl = btn:CreateTexture(nil, "BACKGROUND")
        hl:SetAllPoints()
        hl:SetTexture(WHITE)
        btn.afHighlight = hl
      end
      btn.afHighlight:SetVertexColor(GOLD[1], GOLD[2], GOLD[3], 0.30)
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

  -- Héritage : plein cadre à gauche à la place des arbres de classe, pas de
  -- frise 10-60.
  local isHeritage = (tab == "heritage")
  if self.classTreesHolder then self.classTreesHolder:SetShown(not isHeritage) end
  if self.heritageTreesHolder then self.heritageTreesHolder:SetShown(isHeritage) end
  if self.friseBlock then self.friseBlock:SetShown(not isHeritage) end

  self:RefreshAll()
end

function UI:BuildTabContent(parent)
  local content = CreateFrame("Frame", nil, parent)
  content:SetPoint("TOPLEFT", self.tabBar, "BOTTOMLEFT", 2, -8)
  content:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -6, 6)
  if content.SetClipsChildren then pcall(content.SetClipsChildren, content, true) end
  self.tabContent = content

  self.tabPages = {}
  self.tabPages.home = self:BuildHomeTab(content)
  self.tabPages.plan = self:BuildPlanTab(content)
  self.tabPages.heritage = self:BuildHeritageSideTab(content)
  self.tabPages.spells = self:BuildSpellsTab(content)
  self.tabPages.builds = self:BuildBuildsTab(content)

  self.currentTab = "home"
  for key, page in pairs(self.tabPages) do page:SetShown(key == "home") end
  self:UpdateTabButtonStyles()
end

-- ----- Accueil : texte seul -----

function UI:BuildHomeTab(parent)
  local page = CreateFrame("Frame", nil, parent)
  page:SetAllPoints()

  local lines = {}
  for i = 1, 8 do
    local fs = page:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    fs:SetPoint("TOPLEFT", 4, -4 - (i - 1) * 24)
    fs:SetPoint("RIGHT", -4, 0)
    fs:SetJustifyH("LEFT")
    fs:SetWordWrap(true)
    fs:SetTextColor(unpack(TEXT))
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
  local plan = Talents:GetPlan(classId)

  page.lines[1]:SetText("|cffc9a227" .. cls.name .. "|r")

  local next_ = Talents:NextPendingStep(classId)
  if next_ then
    page.lines[2]:SetText("Prochain point à apprendre :")
    page.lines[3]:SetText(next_.talent.name .. "  (" .. next_.tree.name .. ")")
  else
    page.lines[2]:SetText("Plan à jour : rien à apprendre.")
    page.lines[3]:SetText("")
  end

  page.lines[5]:SetText("Mode : " .. (Talents:GetMode() == "path" and "Build niveau par niveau" or "Build au niveau 60"))
  page.lines[6]:SetText("Clic gauche : ajouter/planifier.")
  page.lines[7]:SetText("Clic droit : retirer.")
  page.lines[8]:SetText("Rien n'est appris sans clic sur Appliquer.")
end

-- ----- Plan : liste à droite seulement, 12 lignes max + scroll -----

function UI:BuildPlanTab(parent)
  local page = CreateFrame("Frame", nil, parent)
  page:SetAllPoints()

  local btn60 = CreateFrame("CheckButton", "AzerothForeverModeFinal", page, "UIRadioButtonTemplate")
  btn60:SetPoint("TOPLEFT", 4, -4)
  btn60.text = _G[btn60:GetName() .. "Text"]
  if btn60.text then btn60.text:SetText("Build au niveau 60"); btn60.text:SetTextColor(unpack(TEXT)) end
  btn60:SetScript("OnClick", function() Talents:SetMode("final"); UI:RefreshAll() end)
  page.btn60 = btn60

  local btnLevel = CreateFrame("CheckButton", "AzerothForeverModePath", page, "UIRadioButtonTemplate")
  btnLevel:SetPoint("TOPLEFT", btn60, "BOTTOMLEFT", 0, -22)
  btnLevel.text = _G[btnLevel:GetName() .. "Text"]
  if btnLevel.text then btnLevel.text:SetText("Build niveau par niveau"); btnLevel.text:SetTextColor(unpack(TEXT)) end
  btnLevel:SetScript("OnClick", function() Talents:SetMode("path"); UI:RefreshAll() end)
  page.btnLevel = btnLevel

  local autoApply = CreateFrame("CheckButton", "AzerothForeverAutoApply", page, "UICheckButtonTemplate")
  autoApply:SetPoint("TOPLEFT", btnLevel, "BOTTOMLEFT", 0, -22)
  autoApply.text = _G[autoApply:GetName() .. "Text"]
  if autoApply.text then
    autoApply.text:SetFontObject("GameFontHighlightSmall")
    autoApply.text:SetText("Auto à la montée de niveau (off par défaut)")
    autoApply.text:SetTextColor(unpack(TEXT_DIM))
  end
  autoApply:SetScript("OnClick", function(self) AzerothForeverDB.options.autoApply = self:GetChecked() and true or false end)
  page.autoApply = autoApply

  local header = page:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  header:SetPoint("TOPLEFT", autoApply, "BOTTOMLEFT", 4, -14)
  header:SetText("Un point par niveau, dans l'ordre")
  GoldText(header)

  -- Liste scrollable (12 lignes visibles max).
  local scroll = CreateFrame("ScrollFrame", "AzerothForeverPlanScroll", page, "UIPanelScrollFrameTemplate")
  scroll:SetPoint("TOPLEFT", header, "BOTTOMLEFT", 0, -6)
  scroll:SetPoint("BOTTOMRIGHT", page, "BOTTOMRIGHT", -22, 4)
  local content = CreateFrame("Frame", nil, scroll)
  content:SetSize(1, 1)
  scroll:SetScrollChild(content)
  page.scroll = scroll
  page.content = content
  page.rows = {}

  return page
end

function UI:RefreshPlanTab()
  local page = self.tabPages and self.tabPages.plan
  if not page then return end
  local classId = AF.classId
  local mode = Talents:GetMode()
  page.btn60:SetChecked(mode == "final")
  page.btnLevel:SetChecked(mode == "path")
  page.autoApply:SetChecked(AzerothForeverDB and AzerothForeverDB.options.autoApply or false)

  for _, row in ipairs(page.rows) do row:Hide() end
  if not classId then
    page.content:SetHeight(1)
    return
  end
  local cat = Talents:GetCatalog(classId)
  local plan = Talents:GetPlan(classId)
  local steps = BP.steps(cat, plan.order, plan.talented)

  local rowH = 18
  local y = 0
  for i, step in ipairs(steps) do
    local row = page.rows[i]
    if not row then
      row = CreateFrame("Frame", nil, page.content)
      row:SetHeight(rowH)
      local level = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
      level:SetPoint("LEFT", 0, 0)
      level:SetWidth(30)
      level:SetJustifyH("LEFT")
      GoldText(level)
      row.level = level
      local name = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
      name:SetPoint("LEFT", level, "RIGHT", 4, 0)
      name:SetPoint("RIGHT", -4, 0)
      name:SetJustifyH("LEFT")
      name:SetTextColor(unpack(TEXT))
      row.name = name
      page.rows[i] = row
    end
    row:ClearAllPoints()
    row:SetPoint("TOPLEFT", page.content, "TOPLEFT", 0, -y)
    row:SetPoint("RIGHT", page.content, "RIGHT", 0, 0)
    row.level:SetText(step.level)
    row.name:SetText(step.talentName .. "  " .. step.rank .. "/" .. step.maxRank)
    row:Show()
    y = y + rowH
  end
  page.content:SetHeight(math.max(1, y))
  page.content:SetWidth(page.scroll:GetWidth())
end

-- ----- Héritage (colonne droite) : compteur + préréglages -----
-- Les 3 arbres eux-mêmes sont affichés plein cadre à GAUCHE (voir
-- BuildHeritageTrees) : ce panneau ne montre que les actions.

function UI:BuildHeritageSideTab(parent)
  local page = CreateFrame("Frame", nil, parent)
  page:SetAllPoints()

  local counter = page:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  counter:SetPoint("TOPLEFT", 4, -4)
  GoldText(counter)
  page.counter = counter

  local presetsLabel = page:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  presetsLabel:SetPoint("TOPLEFT", counter, "BOTTOMLEFT", 0, -14)
  presetsLabel:SetText("Préréglages :")
  presetsLabel:SetTextColor(unpack(TEXT_DIM))

  local prevBtn
  for _, preset in ipairs(AF.Data.Heritage.presets) do
    local btn = CreateFrame("Button", nil, page, "UIPanelButtonTemplate")
    btn:SetSize(160, 20)
    if prevBtn then
      btn:SetPoint("TOPLEFT", prevBtn, "BOTTOMLEFT", 0, -4)
    else
      btn:SetPoint("TOPLEFT", presetsLabel, "BOTTOMLEFT", 0, -6)
    end
    btn:SetText(preset.name)
    btn:SetScript("OnClick", function()
      local ok, err = AF.Heritage:ApplyPreset(preset.id)
      if not ok and err then AF:Print(err) end
      UI:RefreshAll()
    end)
    prevBtn = btn
  end

  local hint = page:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  hint:SetPoint("TOPLEFT", prevBtn, "BOTTOMLEFT", 0, -16)
  hint:SetPoint("RIGHT", -4, 0)
  hint:SetJustifyH("LEFT")
  hint:SetWordWrap(true)
  hint:SetTextColor(unpack(TEXT_DIM))
  hint:SetText("Les 3 arbres sont affichés à gauche. Clic gauche : +1, clic droit : -1. Export/Import : onglet Builds.")

  return page
end

function UI:RefreshHeritageSideTab()
  local page = self.tabPages and self.tabPages.heritage
  if not page then return end
  local ranks = AF.Heritage:GetRanks()
  local total = AF.HeritagePath.totalOf(ranks)
  page.counter:SetText(total .. " / " .. AF.Data.Constants.HERITAGE_MAX_POINTS .. " points")
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
      name:SetTextColor(unpack(TEXT))
      row.name = name
      local desc = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
      desc:SetPoint("TOPLEFT", icon, "BOTTOMLEFT", 0, -2)
      desc:SetPoint("RIGHT", 0, 0)
      desc:SetJustifyH("LEFT")
      desc:SetWordWrap(true)
      desc:SetDrawLayer("OVERLAY", 1)
      desc:SetTextColor(unpack(TEXT_DIM))
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

-- ----- Builds : import, export, lien du site, QR grand fond clair -----

function UI:BuildBuildsTab(parent)
  local page = CreateFrame("Frame", nil, parent)
  page:SetAllPoints()

  local siteLabel = page:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  siteLabel:SetPoint("TOPLEFT", 4, -4)
  siteLabel:SetText("Site :")
  GoldText(siteLabel)

  local siteBg = CreateFrame("Frame", nil, page)
  siteBg:SetPoint("TOPLEFT", siteLabel, "BOTTOMLEFT", 0, -4)
  siteBg:SetPoint("RIGHT", -4, 0)
  siteBg:SetHeight(20)
  Fill(siteBg, CADRE_BG)
  local siteEdit = CreateFrame("EditBox", nil, siteBg, "InputBoxTemplate")
  siteEdit:SetPoint("TOPLEFT", 6, -3)
  siteEdit:SetPoint("BOTTOMRIGHT", -6, 3)
  siteEdit:SetAutoFocus(false)
  siteEdit:SetText(AF.SITE_URL)
  siteEdit:SetCursorPosition(0)
  siteEdit:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
  siteEdit:SetScript("OnEditFocusGained", function(self) self:HighlightText() end)
  page.siteEdit = siteEdit

  local header = page:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  header:SetPoint("TOPLEFT", siteBg, "BOTTOMLEFT", 0, -10)
  header:SetText("Coller un code AF1- / AF1H- :")
  GoldText(header)

  local editBg = CreateFrame("Frame", nil, page)
  editBg:SetPoint("TOPLEFT", header, "BOTTOMLEFT", 0, -4)
  editBg:SetPoint("RIGHT", -4, 0)
  editBg:SetHeight(20)
  Fill(editBg, CADRE_BG)
  local edit = CreateFrame("EditBox", nil, editBg, "InputBoxTemplate")
  edit:SetPoint("TOPLEFT", 6, -3)
  edit:SetPoint("BOTTOMRIGHT", -6, 3)
  edit:SetAutoFocus(false)
  edit:SetMaxLetters(400)
  page.editBox = edit

  local importBtn = CreateFrame("Button", nil, page, "UIPanelButtonTemplate")
  importBtn:SetPoint("TOPLEFT", editBg, "BOTTOMLEFT", 0, -6)
  importBtn:SetSize(120, 20)
  importBtn:SetText("Importer")
  importBtn:SetScript("OnClick", function() UI:DoImport() end)

  local exportClassBtn = CreateFrame("Button", nil, page, "UIPanelButtonTemplate")
  exportClassBtn:SetPoint("LEFT", importBtn, "RIGHT", 4, 0)
  exportClassBtn:SetSize(120, 20)
  exportClassBtn:SetText("Copier classe")
  exportClassBtn:SetScript("OnClick", function() UI:FillShareCode() end)

  local statusText = page:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  statusText:SetPoint("TOPLEFT", importBtn, "BOTTOMLEFT", 0, -6)
  statusText:SetPoint("RIGHT", -4, 0)
  statusText:SetJustifyH("LEFT")
  statusText:SetWordWrap(true)
  statusText:SetTextColor(unpack(TEXT_DIM))
  page.statusText = statusText

  local exportHeritageBtn = CreateFrame("Button", nil, page, "UIPanelButtonTemplate")
  exportHeritageBtn:SetPoint("TOPLEFT", statusText, "BOTTOMLEFT", 0, -8)
  exportHeritageBtn:SetSize(160, 20)
  exportHeritageBtn:SetText("Copier héritage")
  exportHeritageBtn:SetScript("OnClick", function() UI:FillHeritageCode() end)

  -- QR : grand, fond clair, dans la colonne droite (uniquement ici).
  local qrLabel = page:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  qrLabel:SetPoint("TOPLEFT", exportHeritageBtn, "BOTTOMLEFT", 0, -14)
  qrLabel:SetText("QR du build (bouton Site pour le lien, QR ci-dessous) :")
  GoldText(qrLabel)

  local qrFrame = CreateFrame("Frame", nil, page)
  qrFrame:SetPoint("TOPLEFT", qrLabel, "BOTTOMLEFT", 0, -6)
  qrFrame:SetPoint("BOTTOMRIGHT", page, "BOTTOMRIGHT", -4, 4)
  Fill(qrFrame, { 0.94, 0.91, 0.82, 1 })
  GoldEdge(qrFrame, 2)
  page.qrFrame = qrFrame
  qrFrame.qrTextures = {}
  local qrHint = qrFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  qrHint:SetPoint("CENTER")
  qrHint:SetPoint("LEFT", 4, 0)
  qrHint:SetPoint("RIGHT", -4, 0)
  qrHint:SetJustifyH("CENTER")
  qrHint:SetWordWrap(true)
  qrHint:SetTextColor(0.15, 0.12, 0.05)
  qrHint:SetText("Bouton QR (barre du bas) pour générer le lien du build courant.")
  qrFrame.qrHint = qrHint

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

-- ----- QR : uniquement dans Builds -----

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
  local side = math.min(frame:GetWidth(), frame:GetHeight())
  if side <= 0 then side = 220 end
  local avail = side - 12
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

-- ---------- Bas : frise (masquée sous Héritage) + barre d'actions ----------

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

  local cursorLabel = block:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
  cursorLabel:SetPoint("BOTTOM", block, "TOP", 0, -14)
  GoldText(cursorLabel)
  self.friseCursorLabel = cursorLabel
end

function UI:RefreshFrise()
  if not self.friseTicks then return end
  local classId = AF.classId
  local level = (UnitLevel and UnitLevel("player")) or 60
  self.friseCursorLabel:SetText("Niv. " .. level)

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

local ACTION_BUTTONS = {
  { key = "applyNext", label = "Appliquer suivant" },
  { key = "applyAll", label = "Appliquer tout" },
  { key = "reset", label = "Reset" },
  { key = "undo", label = "Undo" },
  { key = "import", label = "Import" },
  { key = "share", label = "Partager" },
  { key = "site", label = "Site" }
}

function UI:BuildActionBar()
  local bar = CreateFrame("Frame", nil, self.frame)
  bar:SetPoint("BOTTOMLEFT", self.frame, "BOTTOMLEFT", MARGIN, MARGIN)
  bar:SetPoint("BOTTOMRIGHT", self.frame, "BOTTOMRIGHT", -MARGIN, MARGIN)
  bar:SetHeight(ACTION_H)
  self.actionBar = bar

  local n = #ACTION_BUTTONS
  local btnWidth = math.floor((WIN_W - 2 * MARGIN - (n - 1) * 4) / n)
  local prevBtn
  for _, def in ipairs(ACTION_BUTTONS) do
    local btn = CreateFrame("Button", nil, bar, "UIPanelButtonTemplate")
    btn:SetSize(btnWidth, ACTION_H)
    if prevBtn then
      btn:SetPoint("LEFT", prevBtn, "RIGHT", 4, 0)
    else
      btn:SetPoint("LEFT", bar, "LEFT", 0, 0)
    end
    btn:SetText(def.label)
    if def.key == "applyNext" or def.key == "applyAll" then
      local fontString = btn.GetFontString and btn:GetFontString()
      if fontString then fontString:SetTextColor(unpack(FactionColor())) end
    end
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
  elseif key == "site" then
    self:ShowTab("builds")
    self:FocusSiteLink()
  end
end

-- ---------- Rafraîchissement global ----------

function UI:RefreshAll()
  if not self.frame or not self.frame:IsShown() then return end
  self:RefreshHeaderRow()
  if self.currentTab == "heritage" then
    self:RefreshHeritageTrees()
  else
    self:RefreshClassTrees()
  end
  self:RefreshFrise()
  if self.currentTab == "home" then self:RefreshHomeTab()
  elseif self.currentTab == "plan" then self:RefreshPlanTab()
  elseif self.currentTab == "heritage" then self:RefreshHeritageSideTab()
  elseif self.currentTab == "spells" then self:RefreshSpellsTab()
  end
end

function UI:RefreshTalents()
  self:RefreshAll()
end
