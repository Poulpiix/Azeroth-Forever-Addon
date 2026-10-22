-- (c) Poulpix, Azeroth Forever. All rights reserved. Text and data mining and AI training prohibited (noai, noimageai, EU Directive 2019/790 art. 4). See LICENSE.md.
local ADDON_NAME, AF = ...

local TT = {}
AF.TalentsTab = TT

local L, Lf, Lp = AF.L, AF.Lf, AF.Lp
local N = AF.Names
local T = AF.Theme
local W = AF.Widgets
local BP = AF.BuildPath
local Talents = AF.Talents

local CLASS_ORDER = { 1, 2, 3, 4, 5, 7, 8, 9, 11 }
local CLASS_FILE_BY_ID = {
  [1] = "WARRIOR", [2] = "PALADIN", [3] = "HUNTER", [4] = "ROGUE", [5] = "PRIEST",
  [7] = "SHAMAN", [8] = "MAGE", [9] = "WARLOCK", [11] = "DRUID"
}

local STRIP_H, HEAD_H, BAR_H, PLAN_H = 34, 52, 50, 84
local Y_STRIP = 0
local Y_HEAD = Y_STRIP + STRIP_H + 8
local Y_BAR = Y_HEAD + HEAD_H + 8
local Y_PLAN = Y_BAR + BAR_H + 8
local Y_TREES = Y_PLAN + PLAN_H + 8
local TREE_HEAD_H = 34
local NODE, COL_PITCH, ROW_PITCH, GRID_TOP = 36, 62, 47, 12
local TREE_ROWS_MAX = 7

local BANNER_SRC_W, BANNER_SRC_H = 1400, 292
local TREE_BG_SRC_W, TREE_BG_SRC_H = 300, 331

local STATUS_LABEL_KEYS = { new = "status.new", changed = "status.changed", unchanged = "status.unchanged" }
local STATUS_TOKENS = { new = "new", changed = "changed", unchanged = "same" }

local MODE_HINT_KEYS = { final = "mode.final_hint", path = "mode.path_hint" }

local function HasCustomTexture(key)
  return AF.Data.TextureManifest ~= nil and AF.Data.TextureManifest[key] == true
end

local function ResolveClassIcon(cls)
  if not cls then return "Interface\\Icons\\INV_Misc_QuestionMark" end
  local classFile = CLASS_FILE_BY_ID[cls.id]
  local key = classFile and ("class_" .. classFile:lower())
  if key and HasCustomTexture(key) then return T:Tex(key) end
  if cls.icon then return "Interface\\Icons\\" .. cls.icon end
  return "Interface\\Icons\\INV_Misc_QuestionMark"
end

local function ApplyCoverFit(texture, frameW, frameH, srcW, srcH)
  if frameW <= 0 or frameH <= 0 then texture:SetTexCoord(0, 1, 0, 1); return end
  local scale = math.max(frameW / srcW, frameH / srcH)
  local cropX = math.max(0, (1 - frameW / (srcW * scale)) / 2)
  local cropY = math.max(0, (1 - frameH / (srcH * scale)) / 2)
  texture:SetTexCoord(cropX, 1 - cropX, cropY, 1 - cropY)
end

local function CompactBuild(build)
  local blocks = {}
  for block in (build .. "-"):gmatch("([^%-]*)%-") do
    blocks[#blocks + 1] = (block:gsub("0+$", ""))
  end
  while #blocks > 0 and blocks[#blocks] == "" do blocks[#blocks] = nil end
  return table.concat(blocks, "-")
end

local function SameOrder(a, b)
  if #a ~= #b then return false end
  for i = 1, #a do if a[i] ~= b[i] then return false end end
  return true
end

local function CopyList(t)
  local out = {}
  for i, v in ipairs(t or {}) do out[i] = v end
  return out
end

local function RequiredLevel(spent)
  if spent <= 0 then return 1 end
  return 9 + spent
end

function TT:GetDisplayClassId()
  return self.selectedClassId or AF.classId or CLASS_ORDER[1]
end

function TT:IsDisplayingOwnClass()
  return AF.classId ~= nil and self:GetDisplayClassId() == AF.classId
end

function TT:GetViewLevel()
  return self.viewLevel or 60
end

function TT:RanksAtLevel(classId, level)
  local cat = Talents:GetCatalog(classId)
  if not cat then return {} end
  local plan = Talents:GetPlan(classId)
  local ranks = BP.emptyRanks(cat)
  for _, step in ipairs(BP.steps(cat, plan.order, plan.talented)) do
    if step.level <= level then ranks[step.talentId] = step.rank end
  end
  return ranks
end

function TT:GetTalentIcon(entry)
  return N:TalentIcon(entry.talent)
end

function TT:SelectClass(classId)
  self.selectedClassId = classId
  self.viewLevel = nil
  if self.slider then self.slider:SetValue(60) end
  self:Refresh()
end

function TT:Build(page, foot)
  self.page = page
  self.nodes = {}
  self.lines = {}
  self:BuildClassStrip(page)
  self:BuildHead(page)
  self:BuildToolbar(page)
  self:BuildPlanner(page)
  self:BuildTrees(page)
  self:BuildOrderPanel(page)
  self:BuildFooter(foot)
end

function TT:BuildClassStrip(page)
  local strip = CreateFrame("Frame", nil, page)
  strip:SetPoint("TOPLEFT", 0, -Y_STRIP)
  strip:SetPoint("TOPRIGHT", 0, -Y_STRIP)
  strip:SetHeight(STRIP_H)
  self.classButtons = {}
  local n = #CLASS_ORDER
  local total = page:GetWidth()
  if not total or total <= 0 then total = AF.UI.WIN_W - 2 * AF.UI.PAD end
  local gap = 6
  local bw = math.floor((total - (n - 1) * gap) / n)
  for i, classId in ipairs(CLASS_ORDER) do
    local cls = AF:GetClassData(classId)
    if cls then
      local b = CreateFrame("Button", nil, strip)
      b:SetSize(bw, STRIP_H)
      b:SetPoint("TOPLEFT", (i - 1) * (bw + gap), 0)
      b.fill = W.Fill(b, "bg1")
      b.border = W.Border(b, "line")
      local iconHolder = CreateFrame("Frame", nil, b)
      iconHolder:SetSize(22, 22)
      local icon = iconHolder:CreateTexture(nil, "ARTWORK")
      icon:SetPoint("TOPLEFT", 1, -1)
      icon:SetPoint("BOTTOMRIGHT", -1, 1)
      icon:SetTexture(ResolveClassIcon(cls))
      W.Border(iconHolder, "class:" .. classId)
      local label = W.Text(b, "AF_Semi12", "ink")
      label:SetText(N:ClassName(cls))
      local content = 22 + 7 + W.TextWidth(label, 60)
      iconHolder:SetPoint("LEFT", b, "CENTER", -math.floor(content / 2), 0)
      label:SetPoint("LEFT", iconHolder, "RIGHT", 7, 0)
      b.classId = classId
      b:SetScript("OnClick", function() self:SelectClass(classId) end)
      b:SetScript("OnEnter", function(btn)
        btn.hover = true
        self:RefreshClassStrip()
      end)
      b:SetScript("OnLeave", function(btn)
        btn.hover = false
        self:RefreshClassStrip()
      end)
      self.classButtons[classId] = b
    end
  end
end

function TT:RefreshClassStrip()
  local display = self:GetDisplayClassId()
  for classId, b in pairs(self.classButtons or {}) do
    if classId == display then
      T:PaintTex(b.fill, "panel2")
      b.border:SetToken("class:" .. classId)
    else
      T:PaintTex(b.fill, "bg1")
      b.border:SetToken(b.hover and "accent" or "line")
    end
  end
end

function TT:BuildHead(page)
  local head = W.Card(page, "panel")
  head:SetPoint("TOPLEFT", 0, -Y_HEAD)
  head:SetPoint("TOPRIGHT", 0, -Y_HEAD)
  head:SetHeight(HEAD_H)
  self.head = head

  local art = head:CreateTexture(nil, "BACKGROUND")
  if art.SetDrawLayer then art:SetDrawLayer("BACKGROUND", -5) end
  art:SetPoint("TOPLEFT", 1, -1)
  art:SetPoint("BOTTOMRIGHT", -1, 1)
  head.art = art
  local veil = W.Tex(head, "BACKGROUND", "bg0", 0.4, -4)
  veil:SetAllPoints(art)
  local veilGrad = W.Image(head, "BACKGROUND", "ui_hgrad", "bg0", 0.9, -3)
  veilGrad:SetAllPoints(art)

  local iconHolder = CreateFrame("Frame", nil, head)
  iconHolder:SetSize(40, 40)
  iconHolder:SetPoint("LEFT", 12, 0)
  local icon = iconHolder:CreateTexture(nil, "ARTWORK")
  icon:SetPoint("TOPLEFT", 2, -2)
  icon:SetPoint("BOTTOMRIGHT", -2, 2)
  head.icon = icon
  head.iconBorder = W.Border(iconHolder, "class:2", 1, 2)

  local name = W.Text(head, "AF_Display20", "ink")
  name:SetPoint("TOPLEFT", iconHolder, "TOPRIGHT", 12, -1)
  head.name = name
  local sub = W.Text(head, "AF_Body12", "inkMuted")
  sub:SetPoint("TOPLEFT", name, "BOTTOMLEFT", 0, -4)
  head.sub = sub

  local changed = W.Badge(head, L["badge.changed_from_classic"], "changed", "star")
  changed:SetPoint("TOPRIGHT", -12, -8)
  local new = W.Badge(head, L["badge.new_in_forever"], "new", "star")
  new:SetPoint("RIGHT", changed, "LEFT", -8, 0)
  local version = W.Text(head, "AF_Body12", "inkMuted", "RIGHT")
  version:SetPoint("BOTTOMRIGHT", -12, 8)
  head.version = version
end

function TT:BuildToolbar(page)
  local bar = W.Card(page, "bg1")
  bar:SetPoint("TOPLEFT", 0, -Y_BAR)
  bar:SetPoint("TOPRIGHT", 0, -Y_BAR)
  bar:SetHeight(BAR_H)
  self.toolbar = bar

  self.statSpent = W.Stat(bar, L["stat.spent_caps"], { bar = true })
  self.statLeft = W.Stat(bar, L["stat.left_caps"])
  self.statLevel = W.Stat(bar, L["stat.level_required_caps"])
  self.statsRow = { self.statSpent, self.statLeft, self.statLevel }
  W.LayoutStats(bar, self.statsRow, 14, 32)

  self.btnPublic = W.Button(bar, { text = L["btn.public_builds"], variant = "standard", onClick = function() self:ShowPublicBuilds() end })
  self.btnPublic:SetPoint("RIGHT", -9, 0)
  self.btnShare = W.Button(bar, { text = L["btn.share"], variant = "primary", caret = true, onClick = function(b) self:OpenShareMenu(b) end })
  self.btnShare:SetPoint("RIGHT", self.btnPublic, "LEFT", -6, 0)
  self.btnSave = W.Button(bar, { text = L["btn.save"], variant = "standard", onClick = function() self:OpenSaveDialog() end })
  self.btnSave:SetPoint("RIGHT", self.btnShare, "LEFT", -6, 0)
  self.btnReset = W.Button(bar, { text = L["btn.reset"], variant = "ghost", onClick = function() self:ResetAll() end })
  self.btnReset:SetPoint("RIGHT", self.btnSave, "LEFT", -6, 0)
  self.switchClassic = W.Switch(bar, L["toggle.classic_version"], function(on)
    AF.UI:Options().showClassic = on
  end)
  self.switchClassic:SetPoint("RIGHT", self.btnReset, "LEFT", -6, 0)
end

function TT:BuildPlanner(page)
  local card = W.Card(page, "panel")
  card:SetPoint("TOPLEFT", 0, -Y_PLAN)
  card:SetPoint("TOPRIGHT", 0, -Y_PLAN)
  card:SetHeight(PLAN_H)
  self.planner = card

  local label = W.Text(card, "AF_Body12", "inkMuted")
  label:SetPoint("TOPLEFT", 12, -12)
  local pre, post = AF.Lsplit("planner.view_at_level")
  label:SetText(pre)
  local value = W.Text(card, "AF_Mono17", "gold")
  value:SetPoint("LEFT", label, "RIGHT", 6, 1)
  self.levelValue = value
  if post ~= "" then
    local after = W.Text(card, "AF_Body12", "inkMuted")
    after:SetPoint("LEFT", value, "RIGHT", 6, -1)
    after:SetText(post)
  end

  local slider = W.Slider(card, 10, 60, function(v)
    self.viewLevel = v
    self:RefreshView()
  end, "class:2")
  slider:SetPoint("TOPLEFT", 214, -6)
  slider:SetPoint("TOPRIGHT", -300, -6)
  self.slider = slider

  self.statAvail = W.Stat(card, L["stat.available_caps"], { width = 80 })
  self.statAvail:SetPoint("TOPRIGHT", -196, -14)
  self.statSpentAt = W.Stat(card, L["stat.spent_short_caps"], { width = 80 })
  self.statSpentAt:SetPoint("TOPLEFT", self.statAvail, "TOPRIGHT", 12, 0)
  self.statLeftAt = W.Stat(card, L["stat.left_caps"], { width = 80 })
  self.statLeftAt:SetPoint("TOPLEFT", self.statSpentAt, "TOPRIGHT", 12, 0)

  local modes = W.Segmented(card, {
    { key = "final", label = L["mode.final"] },
    { key = "path", label = L["mode.path"] }
  }, function(key)
    Talents:SetMode(key)
    self:Refresh()
  end, 24)
  modes:SetPoint("TOPLEFT", 12, -38)
  self.modes = modes

  local orderLink = W.Button(card, { text = L["btn.view_order"], variant = "link", height = 20, padding = 4,
    onClick = function() self:ToggleOrderPanel() end })
  orderLink:SetPoint("LEFT", modes, "RIGHT", 12, 0)
  self.orderLink = orderLink

  local hint = W.Text(card, "AF_Body12", "inkMuted")
  hint:SetPoint("TOPLEFT", modes, "BOTTOMLEFT", 0, -6)
  self.modeHint = hint
end

function TT:BuildTrees(page)
  local holder = CreateFrame("Frame", nil, page)
  holder:SetPoint("TOPLEFT", 0, -Y_TREES)
  holder:SetPoint("BOTTOMRIGHT", 0, 0)
  self.treesHolder = holder
  local total = page:GetWidth()
  if not total or total <= 0 then total = AF.UI.WIN_W - 2 * AF.UI.PAD end
  local gap = 8
  local tw = math.floor((total - 2 * gap) / 3)
  self.treeWidth = tw
  self.treeFrames = {}
  for i = 1, 3 do
    local tree = W.Card(holder, "bg1")
    tree:SetPoint("TOPLEFT", (i - 1) * (tw + gap), 0)
    tree:SetPoint("BOTTOM", holder, "BOTTOM", 0, 0)
    tree:SetWidth(tw)

    local art = tree:CreateTexture(nil, "BACKGROUND")
    if art.SetDrawLayer then art:SetDrawLayer("BACKGROUND", -5) end
    art:SetPoint("TOPLEFT", 1, -TREE_HEAD_H - 3)
    art:SetPoint("BOTTOMRIGHT", -1, 1)
    art:SetVertexColor(0.42, 0.42, 0.42, 0.5)
    tree.art = art
    local veil = W.Image(tree, "BACKGROUND", "ui_vgrad", "bg0", 0.8, -4)
    veil:SetTexCoord(0, 1, 1, 0)
    veil:SetAllPoints(art)
    local veil2 = W.Tex(tree, "BACKGROUND", "bg0", 0.35, -4)
    veil2:SetAllPoints(art)

    local head = CreateFrame("Frame", nil, tree)
    head:SetPoint("TOPLEFT", 1, -1)
    head:SetPoint("TOPRIGHT", -1, -1)
    head:SetHeight(TREE_HEAD_H)
    W.Fill(head, "panel")
    local hl = W.Tex(head, "BORDER", "line")
    hl:SetPoint("BOTTOMLEFT", 0, 0); hl:SetPoint("BOTTOMRIGHT", 0, 0); hl:SetHeight(1)
    local iconHolder = CreateFrame("Frame", nil, head)
    iconHolder:SetSize(24, 24)
    iconHolder:SetPoint("LEFT", 10, 0)
    local icon = iconHolder:CreateTexture(nil, "ARTWORK")
    icon:SetPoint("TOPLEFT", 1, -1)
    icon:SetPoint("BOTTOMRIGHT", -1, 1)
    icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    W.Border(iconHolder, "lineStrong")
    tree.icon = icon
    local title = W.Text(head, "AF_Display15", "ink")
    title:SetPoint("LEFT", iconHolder, "RIGHT", 10, 0)
    tree.title = title
    local count = CreateFrame("Frame", nil, head)
    count:SetHeight(20)
    count:SetPoint("LEFT", title, "RIGHT", 10, 0)
    W.Fill(count, "bg0")
    W.Border(count, "lineSoft")
    count.text = W.Text(count, "AF_Mono12", "gold", "CENTER")
    count.text:SetPoint("CENTER", 0, 0)
    tree.count = count
    local treeIdx = i
    local reset = W.IconButton(head, "ui_reset", 26, function() self:ResetTree(treeIdx) end, L["tree.reset_tip"])
    reset:SetPoint("RIGHT", -8, 0)

    local rail = W.Tex(tree, "ARTWORK", "bg0")
    rail:SetPoint("TOPLEFT", head, "BOTTOMLEFT", 0, 0)
    rail:SetPoint("TOPRIGHT", head, "BOTTOMRIGHT", 0, 0)
    rail:SetHeight(3)
    local fill = W.Tex(tree, "ARTWORK", "class:2", 1, 1)
    fill:SetPoint("TOPLEFT", rail, "TOPLEFT", 0, 0)
    fill:SetHeight(3)
    fill:SetWidth(1)
    tree.barFill = fill

    local grid = CreateFrame("Frame", nil, tree)
    grid:SetPoint("TOPLEFT", rail, "BOTTOMLEFT", 0, -GRID_TOP)
    grid:SetPoint("BOTTOMRIGHT", -1, 1)
    tree.grid = grid
    self.treeFrames[i] = tree
  end
end

local function NodeXY(treeWidth, col, row)
  local gridW = 3 * COL_PITCH + NODE
  local left = math.floor((treeWidth - gridW) / 2)
  return left + col * COL_PITCH, -(row * ROW_PITCH)
end

function TT:GetNodes(classId)
  if self.nodes[classId] then return self.nodes[classId] end
  local cat = Talents:GetCatalog(classId)
  if not cat then return nil end
  local nodes = {}
  local lines = {}
  for _, entry in ipairs(cat.entries) do
    local tree = self.treeFrames[entry.treeIdx]
    if tree and not entry.talent.removed and (entry.talent.maxRank or 0) > 0 then
      local n = W.Node(tree.grid, NODE)
      local x, y = NodeXY(self.treeWidth, entry.talent.col, entry.talent.row)
      n:SetPoint("TOPLEFT", x, y)
      n.icon:SetTexture(self:GetTalentIcon(entry))
      n.onEnter = function(btn) self:ShowTalentTooltip(btn, entry) end
      n.onLeave = function() W.Tip:Hide() end
      n:SetScript("OnClick", function(_, mouseButton) self:OnTalentClick(entry, mouseButton) end)
      n.entry = entry
      nodes[entry.index] = n
    end
  end
  for _, entry in ipairs(cat.entries) do
    for _, req in ipairs(entry.talent.requires or {}) do
      local reqEntry = cat.byId[req.id]
      local tree = self.treeFrames[entry.treeIdx]
      if reqEntry and tree and reqEntry.treeIdx == entry.treeIdx and nodes[entry.index] and nodes[reqEntry.index] then
        local ax, ay = NodeXY(self.treeWidth, reqEntry.talent.col, reqEntry.talent.row)
        local bx, by = NodeXY(self.treeWidth, entry.talent.col, entry.talent.row)
        local segs = {}
        local half = NODE / 2
        if reqEntry.talent.col == entry.talent.col then
          local s = W.Tex(tree.grid, "BORDER", "connector")
          s:SetWidth(3)
          s:SetPoint("TOPLEFT", ax + half - 1, ay - NODE)
          s:SetHeight(math.max(1, (ay - NODE) - by))
          segs[#segs + 1] = s
        else
          local h = W.Tex(tree.grid, "BORDER", "connector")
          h:SetHeight(3)
          local x1 = (bx > ax) and (ax + NODE) or (bx + half - 1)
          local x2 = (bx > ax) and (bx + half + 2) or ax
          h:SetPoint("TOPLEFT", x1, ay - half + 1)
          h:SetWidth(math.max(1, x2 - x1))
          segs[#segs + 1] = h
          if entry.talent.row > reqEntry.talent.row then
            local v = W.Tex(tree.grid, "BORDER", "connector")
            v:SetWidth(3)
            v:SetPoint("TOPLEFT", bx + half - 1, ay - half + 1)
            v:SetHeight(math.max(1, (ay - half) - by))
            segs[#segs + 1] = v
          end
        end
        lines[#lines + 1] = { segs = segs, reqId = req.id, qty = req.qty }
      end
    end
  end
  self.nodes[classId] = nodes
  self.lines[classId] = lines
  return nodes
end

function TT:BuildOrderPanel(page)
  local panel = W.Card(page, "panel")
  panel.afBorder:SetToken("gold")
  panel:SetPoint("TOPRIGHT", self.treesHolder, "TOPRIGHT", 0, 0)
  panel:SetPoint("BOTTOMRIGHT", self.treesHolder, "BOTTOMRIGHT", 0, 0)
  panel:SetWidth(300)
  panel:SetFrameLevel(self.treesHolder:GetFrameLevel() + 20)
  panel:EnableMouse(true)
  panel:Hide()
  local title = W.Text(panel, "AF_Display15", "ink")
  title:SetPoint("TOPLEFT", 14, -12)
  title:SetText(L["order.title"])
  local close = W.IconButton(panel, "ui_close", 24, function() panel:Hide() end, L["common.close"])
  close:SetPoint("TOPRIGHT", -8, -8)
  local scroll = W.Scroll(panel)
  scroll:SetPoint("TOPLEFT", 12, -42)
  scroll:SetPoint("BOTTOMRIGHT", -8, 10)
  panel.scroll = scroll
  panel.rows = {}
  panel.empty = W.Paragraph(panel, "AF_Body12", "inkMuted", 260)
  panel.empty:SetPoint("TOPLEFT", 14, -48)
  panel.empty:SetText(L["order.empty"])
  self.orderPanel = panel
end

function TT:ToggleOrderPanel()
  if self.orderPanel:IsShown() then
    self.orderPanel:Hide()
  else
    self.orderPanel:Show()
    self:RefreshOrderPanel()
  end
end

function TT:BuildFooter(foot)
  self.foot = foot
  local kicker = W.Text(foot, "AF_Kicker10", "gold")
  kicker:SetPoint("LEFT", 0, 0)
  kicker:SetText(L["footer.in_game_caps"])
  local icon = foot:CreateTexture(nil, "ARTWORK")
  icon:SetSize(18, 18)
  icon:SetPoint("LEFT", kicker, "RIGHT", 10, 0)
  self.classIcon = icon

  local auto = W.Checkbox(foot, L["btn.automatic"], function(on)
    AF.UI:Options().autoApply = on
  end, L["btn.automatic_tip"])
  auto:SetHeight(22)
  auto:SetPoint("RIGHT", 0, 0)
  self.autoApply = auto
  local sync = W.Button(foot, { text = L["btn.sync"], variant = "ghost", height = 22, padding = 9,
    tooltip = L["btn.sync_tip"],
    onClick = function() self:OnGameAction("sync") end })
  sync:SetPoint("RIGHT", auto, "LEFT", -12, 0)
  local canUnlearn, unlearnReason = Talents:CanUnlearn()
  local undo = W.Button(foot, { text = L["btn.undo"], variant = "ghost", height = 22, padding = 9,
    tooltip = canUnlearn and L["btn.undo_tip"] or unlearnReason,
    onClick = function() self:OnGameAction("undo") end })
  undo:SetDisabled(not canUnlearn)
  undo:SetPoint("RIGHT", sync, "LEFT", -6, 0)
  local all = W.Button(foot, { text = L["btn.apply_all"], variant = "ghost", height = 22, padding = 9,
    tooltip = L["btn.apply_all_tip"], onClick = function() self:OnGameAction("applyAll") end })
  all:SetPoint("RIGHT", undo, "LEFT", -6, 0)
  local nextBtn = W.Button(foot, { text = L["btn.apply_next"], variant = "standard", height = 22, padding = 9,
    tooltip = L["btn.apply_next_tip"], onClick = function() self:OnGameAction("applyNext") end })
  nextBtn:SetPoint("RIGHT", all, "LEFT", -6, 0)
  self.gameButtons = { nextBtn, all, sync }
end

function TT:OnTalentClick(entry, mouseButton)
  local classId = self:GetDisplayClassId()
  local ok, err
  if Talents:GetMode() == "path" then
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
  if not ok and err and err ~= "" then W.Toast(err, true) end
  self:Refresh()
  if W.Tip:IsShown() and W.Tip.owner and W.Tip.owner.entry == entry then
    self:ShowTalentTooltip(W.Tip.owner, entry)
  end
end

function TT:ResetAll()
  local classId = self:GetDisplayClassId()
  Talents:ResetPlan(classId)
  self:Refresh()
  W.Toast(Lf("toast.build_cleared", N:ClassName(AF:GetClassData(classId)) ~= "" and N:ClassName(AF:GetClassData(classId)) or L["toast.this_class"]))
end

function TT:ResetTree(treeIdx)
  local classId = self:GetDisplayClassId()
  Talents:ResetTree(classId, treeIdx)
  self:Refresh()
end

function TT:OnGameAction(key)
  local classId = self:GetDisplayClassId()
  if (key == "applyNext" or key == "applyAll" or key == "sync") and not self:IsDisplayingOwnClass() then
    W.Toast(L["toast.other_class"], true)
    return
  end
  if key == "applyNext" then
    Talents:ApplyNext()
  elseif key == "applyAll" then
    W.Confirm(L["confirm.apply_all"], L["btn.apply"], function()
      Talents:ApplyAll()
    end)
  elseif key == "sync" then
    local ok, result = Talents:SyncPlanFromGame(classId)
    if ok then
      self.viewLevel = nil
      W.Toast(Lp("toast.synced", result, result))
    else
      W.Toast(result, true)
    end
  elseif key == "undo" then
    Talents:UndoLast()
  end
  self:Refresh()
end

function TT:BuildUrlForClass(classId)
  local cat = Talents:GetCatalog(classId)
  local cls = AF:GetClassData(classId)
  if not cat or not cls or not cls.slug then return AF.SITE_URL end
  local url = AF.SITE_URL .. cls.slug
  local plan = Talents:GetPlan(classId)
  local order = plan.order or {}
  if #order == 0 then return url end
  local ranks = BP.ranksFromOrder(cat, order)
  local build = CompactBuild(BP.serializeBuild(cat, ranks))
  if build == "" then return url end
  url = url .. "?build=" .. build
  if BP.validateOrder(cat, order).ok and not SameOrder(order, BP.autoOrder(cat, ranks)) then
    url = url .. "&path=" .. BP.encodePath(cat, order, plan.talented)
  end
  return url
end

function TT:GetShareCode(classId)
  local cat = Talents:GetCatalog(classId)
  local cls = AF:GetClassData(classId)
  local plan = Talents:GetPlan(classId)
  local check = BP.validateOrder(cat, plan.order)
  if not check.ok then return nil, Lf("share.export_error", check.message) end
  return AF.ShareCode.encode(cls, BP.encodePath(cat, plan.order, plan.talented))
end

function TT:ImportCode(text)
  local decoded = AF.ShareCode.decode(text)
  if not decoded.ok then return false, decoded.error end
  Talents:LoadOrder(decoded.cls.id, decoded.order, decoded.talented)
  self.selectedClassId = decoded.cls.id
  self.viewLevel = nil
  if self.slider then self.slider:SetValue(60) end
  self:Refresh()
  W.Toast(Lf("toast.build_imported", N:ClassName(decoded.cls)))
  return true
end

function TT:OpenShareMenu(anchor)
  local classId = self:GetDisplayClassId()
  W.ShowMenu(anchor, {
    { title = L["share.copy_link"], help = L["share.link_help_build"],
      onClick = function() W.ShowCopy(L["share.copy_link"], self:BuildUrlForClass(classId)) end },
    { title = L["share.copy_code"], help = L["share.code_help_class"],
      onClick = function()
        local code, err = self:GetShareCode(classId)
        if code then W.ShowCopy(L["share.code_title"], code) else W.Toast(err, true) end
      end },
    { title = L["share.paste"], help = L["share.paste_menu_help"],
      onClick = function()
        W.ShowPaste(L["share.paste"], L["share.paste_popup_help"], function(t) return AF.UI:ImportAnyCode(t) end)
      end }
  })
end

function TT:ShowPublicBuilds()
  local cls = AF:GetClassData(self:GetDisplayClassId())
  local url = AF.SITE_URL .. "builds" .. (cls and cls.slug and ("?classe=" .. cls.slug) or "")
  W.ShowCopy(Lf("share.public_title", cls and N:ClassName(cls) or ""), url, L["share.public_help"])
end

local function SavedList(classId)
  AzerothForeverDB.savedBuilds = AzerothForeverDB.savedBuilds or {}
  local key = tostring(classId)
  AzerothForeverDB.savedBuilds[key] = AzerothForeverDB.savedBuilds[key] or {}
  return AzerothForeverDB.savedBuilds[key]
end

function TT:OpenSaveDialog()
  if not self.saveDialog then
    local p = W.Popup(480, 360)
    p.title:SetText(L["save.title"])
    local field = W.EditBox(p, 28, "AF_Body13")
    field:SetPoint("TOPLEFT", 16, -48)
    field:SetPoint("TOPRIGHT", -140, -48)
    p.field = field
    local saveBtn = W.Button(p, { text = L["btn.save"], variant = "primary", width = 114, height = 28, onClick = function() self:SaveCurrent() end })
    saveBtn:SetPoint("LEFT", field, "RIGHT", 8, 0)
    field.edit:SetScript("OnEnterPressed", function() self:SaveCurrent() end)
    field.edit:SetScript("OnEscapePressed", function(eb) eb:ClearFocus(); p:Close() end)
    local k = W.Text(p, "AF_Kicker10", "inkMuted")
    k:SetPoint("TOPLEFT", field, "BOTTOMLEFT", 0, -16)
    k:SetText(L["save.list_caps"])
    local scroll = W.Scroll(p)
    scroll:SetPoint("TOPLEFT", k, "BOTTOMLEFT", 0, -8)
    scroll:SetPoint("BOTTOMRIGHT", -12, 14)
    p.scroll = scroll
    p.rows = {}
    p.empty = W.Text(p, "AF_Body12", "inkMuted")
    p.empty:SetPoint("TOPLEFT", k, "BOTTOMLEFT", 0, -14)
    p.empty:SetText(L["save.empty"])
    self.saveDialog = p
  end
  local cls = AF:GetClassData(self:GetDisplayClassId())
  local p = self.saveDialog
  p:Open()
  p.field.edit:SetText(N:ClassName(cls) .. " " .. date("%d/%m"))
  p.field.edit:SetFocus()
  p.field.edit:HighlightText()
  self:RefreshSaveDialog()
end

function TT:SaveCurrent()
  local classId = self:GetDisplayClassId()
  local plan = Talents:GetPlan(classId)
  local name = (self.saveDialog.field.edit:GetText() or ""):gsub("^%s+", ""):gsub("%s+$", "")
  if name == "" then W.Toast(L["save.err.name"], true); return end
  if #plan.order == 0 then W.Toast(L["save.err.empty"], true); return end
  local list = SavedList(classId)
  for i = #list, 1, -1 do
    if list[i].name == name then table.remove(list, i) end
  end
  table.insert(list, 1, { name = name, order = CopyList(plan.order), talented = plan.talented or 0, date = date("%d/%m/%Y %H:%M") })
  self:RefreshSaveDialog()
  W.Toast(Lf("save.ok", name))
end

function TT:RefreshSaveDialog()
  local p = self.saveDialog
  if not p then return end
  local classId = self:GetDisplayClassId()
  local cat = Talents:GetCatalog(classId)
  local list = SavedList(classId)
  for _, r in ipairs(p.rows) do r:Hide() end
  local content = p.scroll.content
  local y = 0
  for i, item in ipairs(list) do
    local r = p.rows[i]
    if not r then
      r = CreateFrame("Frame", nil, content)
      r:SetHeight(40)
      W.Fill(r, "bg1")
      W.Border(r, "line")
      r.name = W.Text(r, "AF_Semi13", "ink")
      r.name:SetPoint("TOPLEFT", 10, -6)
      r.meta = W.Text(r, "AF_Body12", "inkMuted")
      r.meta:SetPoint("TOPLEFT", r.name, "BOTTOMLEFT", 0, -2)
      r.del = W.Button(r, { text = L["save.btn_delete"], variant = "ghost", height = 22, padding = 8 })
      r.del:SetPoint("RIGHT", -8, 0)
      r.load = W.Button(r, { text = L["save.btn_load"], variant = "standard", height = 22, padding = 8 })
      r.load:SetPoint("RIGHT", r.del, "LEFT", -6, 0)
      p.rows[i] = r
    end
    r:ClearAllPoints()
    r:SetPoint("TOPLEFT", 0, -y)
    r:SetPoint("RIGHT", content, "RIGHT", 0, 0)
    r.name:SetText(item.name)
    r.meta:SetText(Lf("save.row_meta", #item.order, item.date or ""))
    r.load:SetScript("OnClick", function()
      local check = BP.validateOrder(cat, item.order)
      if not check.ok then W.Toast(Lf("save.err.unreadable", check.message), true); return end
      Talents:LoadOrder(classId, CopyList(item.order), item.talented)
      p:Close()
      self:Refresh()
      W.Toast(Lf("save.loaded", item.name))
    end)
    r.del:SetScript("OnClick", function()
      table.remove(list, i)
      self:RefreshSaveDialog()
    end)
    r:Show()
    y = y + 46
  end
  p.scroll:SetContentHeight(y)
  if #list == 0 then p.empty:Show() else p.empty:Hide() end
end

function TT:ShowTalentTooltip(owner, entry)
  local classId = self:GetDisplayClassId()
  local cat = Talents:GetCatalog(classId)
  local talent = entry.talent
  local final = Talents:GetPlannedRanks(classId)
  local rank = final[talent.id] or 0
  local atRank = self:RanksAtLevel(classId, self:GetViewLevel())[talent.id] or 0
  local shownIdx = rank > 0 and rank or 1
  local tip = W.Tip
  tip:Start(owner)
  self.tipOwner, self.tipEntry = owner, entry
  tip:Title(N:TalentName(talent), "new")
  local st = talent.status or "unchanged"
  tip:Meta(Lf("tip.rank", rank, talent.maxRank), L[STATUS_LABEL_KEYS[st]], STATUS_TOKENS[st])
  local desc = N:TalentDesc(talent, talent.ranks[shownIdx] and shownIdx or 1, classId, entry.index)
  if desc ~= "" then tip:Line(desc, "goldHi", "AF_Body12", 6) end
  if rank > 0 and rank < talent.maxRank and talent.ranks[rank + 1] then
    tip:Line(L["tip.next_rank_caps"], "inkMuted", "AF_Kicker9", 8)
    tip:Line(N:TalentDesc(talent, rank + 1, classId, entry.index), "ink", "AF_Body12", 2)
  end
  if atRank ~= rank then
    tip:Line(Lf("tip.at_level", self:GetViewLevel(), atRank, talent.maxRank), "goldHi", "AF_Body12", 6)
  end
  if AF.UI:Options().showClassic and talent.classic then
    local c = talent.classic
    local idx = rank > 0 and rank or 1
    local cur = N:ClassicRank(talent, idx)
    local nxt = (rank > 0 and rank < (c.maxRank or #c.ranks)) and N:ClassicRank(talent, rank + 1) or nil
    if cur or nxt then
      tip:Sep()
      tip:Line(L["tip.classic_caps"], "same", "AF_Kicker9", 0)
      if cur then tip:Line(cur, "inkMuted", "AF_Body12", 3) end
      if nxt then tip:Line(Lf("tip.next_rank_classic", nxt), "inkMuted", "AF_Body12", 4) end
    end
  end
  local treePts = 0
  for _, e in ipairs(cat.entries) do
    if e.treeIdx == entry.treeIdx then treePts = treePts + (final[e.talent.id] or 0) end
  end
  if talent.row > 0 and treePts < 5 * talent.row then
    tip:Line(Lf("tip.requires_tree_points", 5 * talent.row), "badText", "AF_Body12", 6)
  end
  local missing = {}
  for _, req in ipairs(talent.requires or {}) do
    if (final[req.id] or 0) < req.qty then
      local re = cat.byId[req.id]
      missing[#missing + 1] = Lf("tip.requires_rank", re and N:TalentName(re.talent) or "?", req.qty)
    end
  end
  if #missing > 0 then tip:Line(Lf("tip.requires_list", table.concat(missing, ", ")), "badText", "AF_Body12", 4) end
  if self:IsDisplayingOwnClass() then
    local actualRanks = Talents:GetActualRanks(classId)
    if actualRanks then
      tip:Line(Lf("tip.learned_in_game", actualRanks[talent.id] or 0, talent.maxRank), "accentText", "AF_Body12", 6)
    end
  end
  tip:Line(L["tip.click_learn"], "inkMuted", "AF_Body12", 8)
  tip:Finish()
end

-- Client descriptions load lazily: draw the talent tooltip again once the data has arrived.
N.onDescLoaded = function()
  local owner = TT.tipOwner
  if owner and TT.tipEntry and W.Tip:IsShown() and W.Tip.owner == owner then
    TT:ShowTalentTooltip(owner, TT.tipEntry)
  end
end

function TT:OnShow()
  AF.classId = AF.classId or AF:GetPlayerClassId()
  self:Refresh()
end

function TT:OnFactionChanged()
  if self.page and self.page:IsShown() then self:Refresh() end
end

function TT:Refresh()
  if not self.page then return end
  local classId = self:GetDisplayClassId()
  local cls = AF:GetClassData(classId)
  local cat = Talents:GetCatalog(classId)
  if not cls or not cat then return end
  local options = AF.UI:Options()

  self:RefreshClassStrip()

  local head = self.head
  head.icon:SetTexture(ResolveClassIcon(cls))
  head.iconBorder:SetToken("class:" .. classId)
  head.name:SetText(N:ClassName(cls))
  local specs, total, nNew, nChanged = {}, 0, 0, 0
  for _, tree in ipairs(cls.trees) do
    specs[#specs + 1] = N:TreeName(tree)
    for _, t in ipairs(tree.talents) do
      if not t.removed and (t.maxRank or 0) > 0 then
        total = total + 1
        if t.status == "new" then nNew = nNew + 1 elseif t.status == "changed" then nChanged = nChanged + 1 end
      end
    end
  end
  head.sub:SetText(Lf("talents.head_sub", table.concat(specs, " · "), T:Wrap(Lf("talents.count", total), "ink"), nNew, nChanged))
  head.version:SetText(Lf("talents.client_data", AF.Data.Constants.DATA_BUILD or ""))
  if head.artClassId ~= classId then
    head.artClassId = classId
    local key = "banner_" .. (cls.slug or "")
    if HasCustomTexture(key) then
      head.art:SetTexture(T:Tex(key))
      local w = head:GetWidth()
      ApplyCoverFit(head.art, (w and w > 0) and w or 1096, HEAD_H, BANNER_SRC_W, BANNER_SRC_H)
      head.art:Show()
    else
      head.art:Hide()
    end
    for _, tree in ipairs(cls.trees) do
      local tf = self.treeFrames[tree.order + 1]
      if tf then
        local tkey = "tree_" .. tree.id
        if HasCustomTexture(tkey) then
          tf.art:SetTexture(T:Tex(tkey))
          local aw, ah = self.treeWidth - 2, (tf:GetHeight() or 400) - TREE_HEAD_H - 4
          ApplyCoverFit(tf.art, aw, ah > 0 and ah or 360, TREE_BG_SRC_W, TREE_BG_SRC_H)
          tf.art:Show()
        else
          tf.art:Hide()
        end
      end
    end
  end

  local final = Talents:GetPlannedRanks(classId)
  local spent = BP.totalOf(final)
  self.statSpent:Set(spent, "/ 51")
  self.statSpent:SetBar(spent / 51)
  self.statLeft:Set(51 - spent)
  self.statLevel:Set(RequiredLevel(spent))
  W.LayoutStats(self.toolbar, self.statsRow, 14, 32)
  self.switchClassic:SetChecked(options.showClassic and true or false)
  self.btnPublic:SetLabel(Lf("btn.public_builds_class", N:ClassName(cls)))

  local mode = Talents:GetMode()
  self.modes:SetValue(mode)
  self.modeHint:SetText(MODE_HINT_KEYS[mode] and L[MODE_HINT_KEYS[mode]] or "")
  if mode == "path" then self.orderLink:Show() else self.orderLink:Hide() end
  -- The level slider only makes sense for a level by level build: the final build is always seen at level 60.
  if mode ~= "path" then self.viewLevel = nil end
  self.slider:SetEnabled(mode == "path")
  self.slider:SetFillToken("class:" .. classId)
  self.slider:SetValue(self:GetViewLevel())

  self:RefreshView()
  self:RefreshFooter()
end

function TT:RefreshView()
  local classId = self:GetDisplayClassId()
  local cls = AF:GetClassData(classId)
  local cat = Talents:GetCatalog(classId)
  if not cls or not cat then return end
  local level = self:GetViewLevel()
  local plan = Talents:GetPlan(classId)
  local final = Talents:GetPlannedRanks(classId)
  local at = self:RanksAtLevel(classId, level)
  local spentAt = BP.totalOf(at)
  local avail = BP.pointsAvailable(level, plan.talented)
  self.levelValue:SetText(tostring(level))
  self.statAvail:Set(avail)
  self.statSpentAt:Set(spentAt)
  self.statLeftAt:Set(math.max(0, avail - spentAt))

  local nodes = self:GetNodes(classId)
  for otherId, other in pairs(self.nodes) do
    if otherId ~= classId then
      for _, n in pairs(other) do n:Hide() end
      for _, l in ipairs(self.lines[otherId] or {}) do for _, s in ipairs(l.segs) do s:Hide() end end
    end
  end
  local treeFinal, treeAt = {}, {}
  for _, e in ipairs(cat.entries) do
    treeFinal[e.treeIdx] = (treeFinal[e.treeIdx] or 0) + (final[e.talent.id] or 0)
    treeAt[e.treeIdx] = (treeAt[e.treeIdx] or 0) + (at[e.talent.id] or 0)
  end
  for _, tree in ipairs(cls.trees) do
    local idx = tree.order + 1
    local tf = self.treeFrames[idx]
    if tf then
      tf.title:SetText(N:TreeName(tree))
      tf.icon:SetTexture("Interface\\Icons\\" .. (tree.icon or "INV_Misc_QuestionMark"))
      local pts, ptsAt = treeFinal[idx] or 0, treeAt[idx] or 0
      tf.count.text:SetText(ptsAt == pts and Lf("tree.pts", pts) or Lf("tree.pts_at", ptsAt, pts))
      tf.count:SetWidth(math.floor(W.TextWidth(tf.count.text, 40) + 14))
      local w = math.floor((self.treeWidth - 2) * math.min(1, ptsAt / 51) + 0.5)
      if w < 1 then tf.barFill:Hide() else tf.barFill:Show(); tf.barFill:SetWidth(w) end
      T:PaintTex(tf.barFill, "class:" .. classId)
    end
  end

  if nodes then
    for _, entry in ipairs(cat.entries) do
      local n = nodes[entry.index]
      if n then
        n:Show()
        n.icon:SetTexture(self:GetTalentIcon(entry))
        local t = entry.talent
        local fin = final[t.id] or 0
        local rank = at[t.id] or 0
        local available = (t.row == 0 or (treeFinal[entry.treeIdx] or 0) >= 5 * t.row)
        for _, req in ipairs(t.requires or {}) do
          if (final[req.id] or 0) < req.qty then available = false end
        end
        local kind
        if rank >= t.maxRank then kind = "max"
        elseif rank > 0 then kind = "points"
        elseif fin == 0 and not available then kind = "locked"
        else kind = "idle" end
        n:SetState({
          kind = kind,
          rankText = rank .. "/" .. t.maxRank,
          future = fin > rank and rank == 0,
          planText = (fin > rank) and tostring(fin) or nil,
          status = t.status
        })
      end
    end
  end
  for _, l in ipairs(self.lines[classId] or {}) do
    local met = (final[l.reqId] or 0) >= l.qty
    for _, s in ipairs(l.segs) do
      s:Show()
      T:PaintTex(s, met and "new" or "connector")
    end
  end

  if self.orderPanel and self.orderPanel:IsShown() then self:RefreshOrderPanel() end
end

function TT:RefreshOrderPanel()
  local panel = self.orderPanel
  local classId = self:GetDisplayClassId()
  local cat = Talents:GetCatalog(classId)
  local plan = Talents:GetPlan(classId)
  local steps = BP.steps(cat, plan.order, plan.talented)
  local level = self:GetViewLevel()
  local content = panel.scroll.content
  for _, r in ipairs(panel.rows) do r:Hide() end
  local rowH = 22
  for i, step in ipairs(steps) do
    local r = panel.rows[i]
    if not r then
      r = CreateFrame("Frame", nil, content)
      r:SetHeight(rowH)
      r:EnableMouse(true)
      r.level = W.Text(r, "AF_Mono12", "gold")
      r.level:SetPoint("LEFT", 0, 0)
      r.level:SetWidth(26)
      r.icon = r:CreateTexture(nil, "ARTWORK")
      r.icon:SetSize(16, 16)
      r.icon:SetPoint("LEFT", 28, 0)
      r.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
      r.name = W.Text(r, "AF_Body12", "ink")
      r.name:SetPoint("LEFT", r.icon, "RIGHT", 6, 0)
      r.name:SetPoint("RIGHT", -40, 0)
      r.rank = W.Text(r, "AF_Mono10", "inkMuted", "RIGHT")
      r.rank:SetPoint("RIGHT", -2, 0)
      r:SetScript("OnEnter", function(f) if f.entry then self:ShowTalentTooltip(f, f.entry) end end)
      r:SetScript("OnLeave", function() W.Tip:Hide() end)
      panel.rows[i] = r
    end
    r:ClearAllPoints()
    r:SetPoint("TOPLEFT", 0, -(i - 1) * rowH)
    r:SetPoint("RIGHT", content, "RIGHT", 0, 0)
    local entry = cat.byId[step.talentId]
    r.entry = entry
    r.level:SetText(step.level)
    r.icon:SetTexture(entry and self:GetTalentIcon(entry) or "Interface\\Icons\\INV_Misc_QuestionMark")
    r.name:SetText(step.talentName)
    r.rank:SetText(step.rank .. "/" .. step.maxRank)
    r:SetAlpha(step.level <= level and 1 or 0.45)
    r:Show()
  end
  panel.scroll:SetContentHeight(#steps * rowH)
  if #steps == 0 then panel.empty:Show() else panel.empty:Hide() end
end

function TT:RefreshFooter()
  local options = AF.UI:Options()
  self.autoApply:SetChecked(options.autoApply and true or false)
  local own = self:IsDisplayingOwnClass()
  for _, b in ipairs(self.gameButtons or {}) do b:SetDisabled(not own) end
  self.classIcon:SetTexture(ResolveClassIcon(AF:GetClassData(AF.classId or self:GetDisplayClassId())))
end
