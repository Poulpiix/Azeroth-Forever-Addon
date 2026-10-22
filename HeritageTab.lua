-- (c) Poulpix, Azeroth Forever. All rights reserved. Text and data mining and AI training prohibited (noai, noimageai, EU Directive 2019/790 art. 4). See LICENSE.md.
local ADDON_NAME, AF = ...

local HT = {}
AF.HeritageTab = HT

local L, Lf = AF.L, AF.Lf
local T = AF.Theme
local W = AF.Widgets
local HP = AF.HeritagePath
local Heritage = AF.Heritage
local N = AF.Names

local MAX = 16
local HEAD_H, BAR_H, PLAN_H = 56, 54, 48

local PRESET_LABEL_KEYS = { leveling = "preset.leveling", metiers = "preset.metiers", qdv60 = "preset.qdv60" }
local function PresetLabel(preset)
  local key = PRESET_LABEL_KEYS[preset.id]
  return key and L[key] or preset.name
end
local Y_HEAD = 0
local Y_BAR = Y_HEAD + HEAD_H + 8
local Y_PLAN = Y_BAR + BAR_H + 8
local Y_TREES = Y_PLAN + PLAN_H + 8
local TREE_HEAD_H, DESC_H = 34, 26
local NODE, COL_PITCH, ROW_PITCH, GRID_TOP = 44, 68, 64, 22

function HT:Build(page, foot)
  self.page = page
  self.viewPoints = nil
  self:BuildHead(page)
  self:BuildToolbar(page)
  self:BuildPlanner(page)
  self:BuildTrees(page)
  local talented = W.Text(foot, "AF_Body12", "goldHi")
  talented:SetPoint("LEFT", 0, 0)
  self.talentedNote = talented
end

function HT:BuildHead(page)
  local head = W.Card(page, "panel")
  head:SetPoint("TOPLEFT", 0, -Y_HEAD)
  head:SetPoint("TOPRIGHT", 0, -Y_HEAD)
  head:SetHeight(HEAD_H)
  local iconHolder = CreateFrame("Frame", nil, head)
  iconHolder:SetSize(40, 40)
  iconHolder:SetPoint("LEFT", 12, 0)
  local icon = iconHolder:CreateTexture(nil, "ARTWORK")
  icon:SetPoint("TOPLEFT", 1, -1)
  icon:SetPoint("BOTTOMRIGHT", -1, 1)
  icon:SetTexture("Interface\\Icons\\INV_Misc_Note_06")
  icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
  W.Border(iconHolder, "gold")
  local title = W.Text(head, "AF_Display20", "ink")
  title:SetPoint("TOPLEFT", iconHolder, "TOPRIGHT", 12, -1)
  title:SetText(L["heritage.title"])
  local sub = W.Text(head, "AF_Body12", "inkMuted")
  sub:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -5)
  self.headSub = sub
  local function texts()
    sub:SetText(Lf("heritage.sub", T:Wrap(Lf("heritage.total_points", MAX), "ink")))
  end
  texts()
  T:OnChange(texts)
end

function HT:BuildToolbar(page)
  local bar = W.Card(page, "bg1")
  bar:SetPoint("TOPLEFT", 0, -Y_BAR)
  bar:SetPoint("TOPRIGHT", 0, -Y_BAR)
  bar:SetHeight(BAR_H)
  self.bar = bar
  self.statSpent = W.Stat(bar, L["heritage.stat.spent_caps"], { pips = MAX })
  self.statLeft = W.Stat(bar, L["heritage.stat.left_caps"])
  self.statsRow = { self.statSpent, self.statLeft }
  W.LayoutStats(bar, self.statsRow, 14, 16)

  local share = W.Button(bar, { text = L["btn.share"], variant = "primary", caret = true, onClick = function(b) self:OpenShareMenu(b) end })
  share:SetPoint("RIGHT", -9, 0)
  local reset = W.Button(bar, { text = L["btn.reset"], variant = "ghost", onClick = function()
    Heritage:Reset()
    self:Refresh()
    W.Toast(L["heritage.reset_done"])
  end })
  reset:SetPoint("RIGHT", share, "LEFT", -6, 0)
end

function HT:BuildPlanner(page)
  local card = W.Card(page, "panel")
  card:SetPoint("TOPLEFT", 0, -Y_PLAN)
  card:SetPoint("TOPRIGHT", 0, -Y_PLAN)
  card:SetHeight(PLAN_H)
  local l1 = W.Text(card, "AF_Body12", "inkMuted")
  l1:SetPoint("LEFT", card, "LEFT", 12, 0)
  local pre, post = AF.Lsplit("heritage.view_at")
  l1:SetText(pre)
  local value = W.Text(card, "AF_Mono17", "gold")
  value:SetPoint("LEFT", l1, "RIGHT", 6, 0)
  local l2 = W.Text(card, "AF_Body12", "inkMuted")
  l2:SetPoint("LEFT", value, "RIGHT", 6, 0)
  l2:SetText(post)
  self.viewValue = value
  local slider = W.Slider(card, 0, MAX, function(v)
    self.viewPoints = v
    self:RefreshTrees()
  end, "gold")
  slider:SetPoint("LEFT", l2, "RIGHT", 12, 0)
  slider:SetWidth(330)
  self.slider = slider

  local x = -12
  local presets = AF.Data.Heritage.presets or {}
  local lastBtn
  for i = #presets, 1, -1 do
    local preset = presets[i]
    local label = PresetLabel(preset)
    local b = W.Button(card, { text = label, variant = "ghost", onClick = function()
      local ok, err = Heritage:ApplyPreset(preset.id)
      if ok then
        self.viewPoints = nil
        self:Refresh()
        W.Toast(Lf("preset.applied", label, HP.totalOf(Heritage:GetRanks())))
      else
        W.Toast(err or L["preset.err"], true)
      end
    end })
    if lastBtn then
      b:SetPoint("RIGHT", lastBtn, "LEFT", -6, 0)
    else
      b:SetPoint("RIGHT", card, "RIGHT", x, 0)
    end
    lastBtn = b
  end
  local k = W.Text(card, "AF_Kicker10", "inkMuted")
  if lastBtn then k:SetPoint("RIGHT", lastBtn, "LEFT", -10, 0) end
  k:SetText("PRESETS")
end

local function NodeXY(treeWidth, col, row)
  local gridW = 3 * COL_PITCH + NODE
  local left = math.floor((treeWidth - gridW) / 2)
  return left + col * COL_PITCH, -(row * ROW_PITCH)
end

function HT:BuildTrees(page)
  local holder = CreateFrame("Frame", nil, page)
  holder:SetPoint("TOPLEFT", 0, -Y_TREES)
  holder:SetPoint("BOTTOMRIGHT", 0, 0)
  local total = page:GetWidth()
  if not total or total <= 0 then total = AF.UI.WIN_W - 2 * AF.UI.PAD end
  local gap = 8
  local tw = math.floor((total - 2 * gap) / 3)
  self.treeFrames = {}
  self.nodes = {}
  local cat = Heritage:GetCatalog()
  for i, treeData in ipairs(AF.Data.Heritage.trees) do
    local tree = W.Card(holder, "bg1")
    tree:SetPoint("TOPLEFT", (i - 1) * (tw + gap), 0)
    tree:SetPoint("BOTTOM", holder, "BOTTOM", 0, 0)
    tree:SetWidth(tw)
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
    icon:SetTexture("Interface\\Icons\\" .. (treeData.icon or "INV_Misc_QuestionMark"))
    icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    W.Border(iconHolder, "lineStrong")
    local title = W.Text(head, "AF_Display15", "ink")
    title:SetPoint("LEFT", iconHolder, "RIGHT", 10, 0)
    title:SetText(N:HeritageTreeName(treeData))
    local count = CreateFrame("Frame", nil, head)
    count:SetHeight(20)
    count:SetPoint("LEFT", title, "RIGHT", 10, 0)
    W.Fill(count, "bg0")
    W.Border(count, "lineSoft")
    count.text = W.Text(count, "AF_Mono12", "gold", "CENTER")
    count.text:SetPoint("CENTER", 0, 0)
    tree.count = count
    local treeId = treeData.id
    local reset = W.IconButton(head, "ui_reset", 26, function()
      Heritage:ResetTree(treeId)
      self:Refresh()
    end, L["tree.reset_tip"])
    reset:SetPoint("RIGHT", -8, 0)
    local rail = W.Tex(tree, "ARTWORK", "bg0")
    rail:SetPoint("TOPLEFT", head, "BOTTOMLEFT", 0, 0)
    rail:SetPoint("TOPRIGHT", head, "BOTTOMRIGHT", 0, 0)
    rail:SetHeight(3)
    local fillBase = W.Tex(tree, "ARTWORK", "accent", 1, 1)
    fillBase:SetPoint("TOPLEFT", rail, "TOPLEFT", 0, 0)
    fillBase:SetHeight(3)
    local fill = W.Image(tree, "ARTWORK", "ui_hgrad", "gold", 1, 2)
    fill:SetPoint("TOPLEFT", rail, "TOPLEFT", 0, 0)
    fill:SetHeight(3)
    tree.fill, tree.fillBase = fill, fillBase
    local desc = W.Text(tree, "AF_Body12", "inkMuted")
    desc:SetPoint("TOPLEFT", rail, "BOTTOMLEFT", 13, -8)
    desc:SetText(N:HeritageTreeDesc(treeData))
    local grid = CreateFrame("Frame", nil, tree)
    grid:SetPoint("TOPLEFT", rail, "BOTTOMLEFT", 0, -(DESC_H + GRID_TOP))
    grid:SetPoint("BOTTOMRIGHT", -1, 1)
    tree.grid = grid
    tree.data = treeData
    self.treeFrames[i] = tree

    for _, entry in ipairs(cat.entries) do
      if entry.treeIdx == i then
        local n = W.Node(grid, NODE)
        local x, y = NodeXY(tw, entry.node.col, entry.node.row)
        n:SetPoint("TOPLEFT", x, y)
        n.icon:SetTexture("Interface\\Icons\\" .. (entry.node.icon or "INV_Misc_QuestionMark"))
        n.entry = entry
        n.onEnter = function(btn) self:ShowTooltip(btn, entry) end
        n.onLeave = function() W.Tip:Hide() end
        n:SetScript("OnClick", function(_, mouseButton) self:OnNodeClick(entry, mouseButton) end)
        self.nodes[#self.nodes + 1] = n
      end
    end
    for _, slot in ipairs(treeData.locked or {}) do
      local n = W.Node(grid, NODE)
      local x, y = NodeXY(tw, slot.col, slot.row)
      n:SetPoint("TOPLEFT", x, y)
      n:SetState({ kind = "empty" })
      n.onEnter = function(btn)
        W.Tip:Start(btn)
        W.Tip:Title(L["heritage.unknown_skill"], "inkMuted")
        W.Tip:Line(L["heritage.unknown_skill_hint"], "inkMuted")
        W.Tip:Finish()
      end
      n.onLeave = function() W.Tip:Hide() end
    end
  end
end

function HT:OnNodeClick(entry, mouseButton)
  local ok, err = Heritage:ChangeRank(entry.key, mouseButton == "RightButton" and -1 or 1)
  if not ok and err then W.Toast(err, true) end
  self.viewPoints = nil
  self:Refresh()
  if W.Tip:IsShown() and W.Tip.owner and W.Tip.owner.entry == entry then self:ShowTooltip(W.Tip.owner, entry) end
end

local function TreeSpent(cat, ranks, treeIdx)
  local n = 0
  for _, e in ipairs(cat.entries) do
    if e.treeIdx == treeIdx then n = n + (ranks[e.key] or 0) end
  end
  return n
end

function HT:ShowTooltip(owner, entry)
  local cat = Heritage:GetCatalog()
  local ranks = Heritage:GetRanks()
  local node = entry.node
  local rank = ranks[entry.key] or 0
  local total = HP.totalOf(ranks)
  local view = self.viewPoints or total
  local tip = W.Tip
  tip:Start(owner)
  tip:Title(N:HeritageNodeName(node), "new")
  tip:Line(Lf("heritage.tip.rank_meta", rank, node.maxRank, N:HeritageNodeMeta(node) or L["heritage.tip.passive"]), "inkMuted", "AF_Body12", 3)
  local nodeDesc = N:HeritageNodeDesc(node)
  if nodeDesc ~= "" then tip:Line(nodeDesc, "goldHi", "AF_Body12", 6) end
  if view < total then
    local at = Heritage:RanksAt(view)[entry.key] or 0
    if at ~= rank then tip:Line(Lf("heritage.tip.at_points", view, at, node.maxRank), "goldHi", "AF_Body12", 6) end
  end
  if (node.tier or 0) > 0 and TreeSpent(cat, ranks, entry.treeIdx) < node.tier then
    tip:Line(Lf("heritage.tip.requires", node.tier, N:HeritageTreeName(entry.tree)), "badText", "AF_Body12", 6)
  end
  tip:Line(L["tip.click_learn"], "inkMuted", "AF_Body12", 8)
  tip:Finish()
end

function HT:ExportLink()
  local cat = Heritage:GetCatalog()
  local ranks = Heritage:GetRanks()
  if HP.totalOf(ranks) == 0 then return AF.SITE_URL .. "arbre-heritage" end
  return AF.SITE_URL .. "arbre-heritage?hbuild=" .. HP.serializeHbuild(cat, ranks)
end

function HT:ImportCode(text)
  local ok, err = Heritage:ImportCode(text)
  if not ok then return false, err end
  self.viewPoints = nil
  self:Refresh()
  W.Toast(Lf("heritage.imported", HP.totalOf(Heritage:GetRanks())))
  return true
end

function HT:OpenShareMenu(anchor)
  W.ShowMenu(anchor, {
    { title = L["share.copy_link"], help = L["heritage.link_help"],
      onClick = function() W.ShowCopy(L["share.copy_link"], self:ExportLink()) end },
    { title = L["share.copy_code"], help = L["heritage.code_help"],
      onClick = function() W.ShowCopy(L["share.code_title"], Heritage:ExportCode()) end },
    { title = L["share.paste"], help = L["share.paste_menu_help"],
      onClick = function()
        W.ShowPaste(L["share.paste"], L["share.paste_popup_help"], function(t) return AF.UI:ImportAnyCode(t) end)
      end }
  })
end

function HT:OnShow()
  self:Refresh()
end

function HT:Refresh()
  if not self.page then return end
  local ranks = Heritage:GetRanks()
  local total = HP.totalOf(ranks)
  self.statSpent:Set(total, "/ " .. MAX)
  self.statSpent:SetPips(total)
  self.statLeft:Set(MAX - total)
  W.LayoutStats(self.bar, self.statsRow, 14, 16)
  local talented = ranks["aventure__talentueux"] or 0
  self.talentedNote:SetText(talented > 0 and L["heritage.talented_note"] or "")
  if not self.viewPoints or self.viewPoints > total then self.viewPoints = nil end
  self.slider:SetValue(self.viewPoints or total)
  self:RefreshTrees()
end

function HT:RefreshTrees()
  local cat = Heritage:GetCatalog()
  local ranks = Heritage:GetRanks()
  local total = HP.totalOf(ranks)
  local view = self.viewPoints or total
  if view > total then view = total end
  self.viewValue:SetText(tostring(view))
  local at = (view < total) and Heritage:RanksAt(view) or ranks
  local treeSpent = {}
  for i, tree in ipairs(self.treeFrames) do
    treeSpent[i] = TreeSpent(cat, ranks, i)
    local spentAt = TreeSpent(cat, at, i)
    tree.count.text:SetText(spentAt .. " / " .. MAX)
    tree.count:SetWidth(math.floor(W.TextWidth(tree.count.text, 50) + 14))
    local w = math.floor(((tree:GetWidth() or 360) - 2) * math.min(1, spentAt / MAX) + 0.5)
    if w < 1 then
      tree.fill:Hide(); tree.fillBase:Hide()
    else
      tree.fill:Show(); tree.fillBase:Show()
      tree.fill:SetWidth(w); tree.fillBase:SetWidth(w)
    end
  end
  for _, n in ipairs(self.nodes) do
    local e = n.entry
    local node = e.node
    local fin = ranks[e.key] or 0
    local rank = at[e.key] or 0
    local available = (node.tier or 0) == 0 or treeSpent[e.treeIdx] >= node.tier
    local kind
    if rank >= node.maxRank then kind = "max"
    elseif rank > 0 then kind = "points"
    elseif fin == 0 and not available then kind = "locked"
    else kind = "idle" end
    n:SetState({
      kind = kind,
      rankText = rank .. "/" .. node.maxRank,
      future = fin > rank and rank == 0,
      planText = (fin > rank) and tostring(fin) or nil
    })
  end
end
