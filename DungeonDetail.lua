-- (c) Poulpix, Azeroth Forever. All rights reserved. Text and data mining and AI training prohibited (noai, noimageai, EU Directive 2019/790 art. 4). See LICENSE.md.
local ADDON_NAME, AF = ...

local DT = AF.DungeonsTab
local L, Lf, Lp = AF.L, AF.Lf, AF.Lp
local N = AF.Names
local T = AF.Theme
local W = AF.Widgets
local J = AF.Journal
local U = DT.util

local LIST_W, ACCESS_H, TOP = 300, 30, 108
local BOSS_ROW, QUEST_ROW, LOOT_ROW = 44, 46, 32

local STATE = {
  done = { labelKey = "state.done", capsKey = "state.done_caps", token = "good" },
  log = { labelKey = "state.log", capsKey = "state.log_caps", token = "gold" },
  avail = { labelKey = "state.avail", capsKey = "state.avail_caps", token = "accentText" },
  locked = { labelKey = "state.locked", capsKey = "state.locked_caps", token = "inkMuted" }
}
local ICON_AVAIL = "Interface\\GossipFrame\\AvailableQuestIcon"
local ICON_ACTIVE = "Interface\\GossipFrame\\ActiveQuestIcon"
local FACTION_ICON = { alliance = "Interface\\FriendsFrame\\PlusManz-Alliance", horde = "Interface\\FriendsFrame\\PlusManz-Horde" }
local SKULL = "Interface\\Icons\\INV_Misc_Bone_HumanSkull_01"

local function Opposite(faction) return faction == "alliance" and "horde" or "alliance" end

function DT.NewBossPin(parent, size)
  local b = CreateFrame("Button", nil, parent)
  b:SetSize(size, size)
  b.glow = W.Image(b, "BACKGROUND", "ui_glow", "goldHi", 0.9, -7)
  b.glow:SetPoint("CENTER", 0, 0)
  b.glow:SetSize(size * 1.9, size * 1.9)
  b.glow:Hide()
  b.bg = W.Image(b, "BACKGROUND", "ui_circle", "bg0", 1)
  b.bg:SetAllPoints()
  b.portrait = b:CreateTexture(nil, "ARTWORK")
  b.portrait:SetPoint("TOPLEFT", 2, -2)
  b.portrait:SetPoint("BOTTOMRIGHT", -2, 2)
  b.ring = W.Image(b, "OVERLAY", "ui_ring", "gold", 1, 1)
  b.ring:SetAllPoints()
  local bs = math.max(14, math.floor(size * 0.52))
  local bf = CreateFrame("Frame", nil, b)
  bf:SetSize(bs, bs)
  bf:SetPoint("CENTER", b, "BOTTOMRIGHT", -3, 3)
  b.badgeFrame = bf
  b.badgeBg = W.Image(bf, "ARTWORK", "ui_circle", "accentFill", 1)
  b.badgeBg:SetAllPoints()
  b.badgeRing = W.Image(bf, "OVERLAY", "ui_ring", "goldHi", 1)
  b.badgeRing:SetAllPoints()
  b.badge = W.Text(bf, "AF_Mono10", "white", "CENTER", "OVERLAY")
  b.badge:SetPoint("CENTER", 0, 0)
  function b:SetBoss(boss, label, _, warn)
    self.warn = warn
    self.badgeFrame:SetFrameLevel(self:GetFrameLevel() + 2)
    J:SetBossPortrait(self.portrait, boss)
    self.badge:SetText(label or "?")
    T:PaintTex(self.ring, warn and "changed" or "gold")
    T:PaintTex(self.badgeBg, warn and "changed" or "accentFill")
    self:SetSelected(false)
  end
  function b:SetSelected(on)
    if on then self.glow:Show() else self.glow:Hide() end
    T:PaintTex(self.ring, on and "goldHi" or (self.warn and "changed" or "gold"))
  end
  b:SetScript("OnEnter", function(s)
    if not s.label then return end
    GameTooltip:SetOwner(s, "ANCHOR_RIGHT")
    GameTooltip:SetText(s.label)
    if s.hint then GameTooltip:AddLine(s.hint, 0.7, 0.75, 0.8, true) end
    GameTooltip:Show()
  end)
  b:SetScript("OnLeave", function() GameTooltip:Hide() end)
  return b
end

function DT:BuildDetail(page, y)
  local d = CreateFrame("Frame", nil, page)
  d:SetPoint("TOPLEFT", 0, -y)
  d:SetPoint("BOTTOMRIGHT", 0, 0)
  d:Hide()
  self.detail = d
  self.pools, self.used = {}, {}

  local back = W.Button(d, { text = L["detail.back"], variant = "ghost", icon = "ui_arrow_left", iconSize = 12, height = 24,
    onClick = function() self:CloseDetail() end })
  back:SetPoint("TOPLEFT", 0, 0)
  d.badgeHost = CreateFrame("Frame", nil, d)
  d.badgeHost:SetSize(1, 18)
  d.badgeHost:SetPoint("TOPRIGHT", 0, -3)
  d.badges = {}

  d.title = W.Text(d, "AF_Bold16", "ink")
  d.title:SetPoint("TOPLEFT", 0, -34)
  d.sub = W.Text(d, "AF_Body12", "inkMuted")
  d.sub:SetPoint("TOPLEFT", d.title, "BOTTOMLEFT", 0, -5)
  d.entrance = W.Button(d, { text = L["detail.show_entrance"], variant = "standard", height = 24, padding = 10,
    onClick = function() self:ShowPoint(d.entrancePoint) end })
  d.entrance:SetPoint("TOPRIGHT", 0, -34)
  d.levels = W.Text(d, "AF_Semi12", "ink", "RIGHT")
  d.levels:SetPoint("RIGHT", d.entrance, "LEFT", -12, 0)

  d.tabs = W.Segmented(d, {
    { key = "quests", label = L["detail.tab_quests"], width = 110 },
    { key = "boss", label = L["detail.tab_boss"], width = 110 }
  }, function(key)
    self.tab = key
    self:RenderDetail()
  end, 26)
  d.tabs:SetPoint("TOPLEFT", 0, -76)

  local list = W.Card(d, "bg1")
  list:SetPoint("TOPLEFT", 0, -TOP)
  list:SetPoint("BOTTOMLEFT", 0, ACCESS_H + 8)
  list:SetWidth(LIST_W)
  list.scroll = W.Scroll(list)
  list.scroll:SetPoint("TOPLEFT", 4, -4)
  list.scroll:SetPoint("BOTTOMRIGHT", -4, 4)
  d.list = list

  local main = W.Card(d, "panel")
  main:SetPoint("TOPLEFT", list, "TOPRIGHT", 8, 0)
  main:SetPoint("BOTTOMRIGHT", 0, ACCESS_H + 8)
  main.scroll = W.Scroll(main)
  main.scroll:SetPoint("TOPLEFT", 14, -12)
  main.scroll:SetPoint("BOTTOMRIGHT", -8, 8)
  d.main = main

  local map = W.Card(d, "bg0")
  map:SetPoint("TOPLEFT", 0, -TOP)
  map:SetPoint("BOTTOMLEFT", 0, ACCESS_H + 8)
  map:SetWidth(LIST_W)
  map.canvas = CreateFrame("Frame", nil, map)
  map:Hide()
  d.map = map

  local access = W.Card(d, "bg1")
  access:SetPoint("BOTTOMLEFT", 0, 0)
  access:SetPoint("BOTTOMRIGHT", 0, 0)
  access:SetHeight(ACCESS_H)
  access.text = W.Text(access, "AF_Body12", "inkMuted")
  access.text:SetPoint("LEFT", 12, 0)
  access.text:SetPoint("RIGHT", -12, 0)
  d.access = access
end

function DT:Acquire(kind, factory)
  self.pools[kind] = self.pools[kind] or {}
  self.used[kind] = (self.used[kind] or 0) + 1
  local obj = self.pools[kind][self.used[kind]]
  if not obj then
    obj = factory()
    self.pools[kind][self.used[kind]] = obj
  end
  obj:Show()
  return obj
end

function DT:ReleaseAll()
  for kind, list in pairs(self.pools) do
    for _, obj in ipairs(list) do obj:Hide() end
    self.used[kind] = 0
  end
end

function DT:Text(parent, font, token, x, y, width, text)
  local fs = self:Acquire("text:" .. tostring(parent), function()
    local f = W.Paragraph(parent, font, token, width)
    return f
  end)
  fs:SetFontObject(T:Font(font))
  T:PaintText(fs, token)
  fs:ClearAllPoints()
  fs:SetPoint("TOPLEFT", parent, "TOPLEFT", x, -y)
  fs:SetWidth(width)
  fs:SetText(text or "")
  return math.ceil(W.WrappedHeight(fs, width))
end

function DT:SmallButton(parent, text, onClick)
  local b = self:Acquire("button:" .. tostring(parent), function()
    return W.Button(parent, { text = "", variant = "ghost", height = 22, padding = 8 })
  end)
  b:SetLabel(text)
  b:SetScript("OnClick", function() onClick() end)
  b:ClearAllPoints()
  return b
end

-- focus (optional, search field): { boss = index in J:Bosses(inst) } opens the Boss sub tab on that boss.
function DT:OpenDetail(inst, focus)
  if self.current ~= inst then
    self.sel = { boss = 1, quest = nil, floor = 1 }
    self.tab = #self:QuestsFor(inst) > 0 and "quests" or "boss"
  end
  self.current = inst
  if focus and focus.boss then
    self.tab = "boss"
    self.sel.boss = focus.boss
  end
  if self.tab ~= "quests" then self.tab = "boss" end
  for _, c in ipairs(self.cards) do
    c.selected = (c.inst == inst)
    c.border:SetToken(c.selected and "gold" or "line")
  end
  self.listScroll:Hide()
  self.detail:Show()
  self.detail.list.scroll:SetOffset(0)
  self.detail.main.scroll:SetOffset(0)
  self:RenderDetail()
  if focus and focus.boss then self:FocusBoss() end
end

-- Brings the selected boss into view the way a click does: its map level on a map, its row in the boss list.
function DT:FocusBoss()
  local i = self.sel.boss
  if self.mapLevels then
    local floor = self.bossFloor and self.bossFloor[i]
    if floor and floor ~= self.sel.floor then
      self.sel.floor = floor
      self:RenderDetail(true)
    end
  else
    local scroll = self.detail.list.scroll
    scroll:SetOffset((i - 1) * (BOSS_ROW + 2) - (scroll:ViewHeight() - BOSS_ROW) / 2)
  end
end

function DT:CloseDetail()
  self.current = nil
  if self.detail then self.detail:Hide() end
  if self.listScroll then self.listScroll:Show() end
  for _, c in ipairs(self.cards or {}) do
    c.selected = false
    c.border:SetToken("line")
  end
  if GameTooltip then GameTooltip:Hide() end
end

function DT:OnJournalData()
  if self.current and self.detail:IsShown() then self:RenderDetail(true) end
end

function DT:ShowPoint(p)
  if not p then return end
  local how = J:ShowPoint(p)
  if how == "tomtom" then
    W.Toast(Lf("toast.point_tomtom", p.name or ""))
  elseif how then
    W.Toast(Lf("toast.point_map", p.name or ""))
  else
    W.Toast(Lf("toast.point_unknown", p.name or L["point.this"]), true)
  end
end

function DT:QuestsFor(inst)
  local faction = AF.UI:GetFaction()
  local out = {}
  for _, q in ipairs(J:Quests(inst)) do
    if q.faction ~= Opposite(faction) then out[#out + 1] = q end
  end
  table.sort(out, function(a, b)
    if (a.level or 0) ~= (b.level or 0) then return (a.level or 0) < (b.level or 0) end
    return (a.name or "") < (b.name or "")
  end)
  return out
end

function DT:RenderDetail(keepScroll)
  local inst = self.current
  if not inst then return end
  local d = self.detail
  local listOffset, mainOffset = d.list.scroll.offset, d.main.scroll.offset
  self:ReleaseAll()
  self:RenderHeader(inst)
  self.bosses = J:Bosses(inst)
  local quests = self:QuestsFor(inst)
  d.tabs.buttons[1].label:SetText(Lf("detail.tab_quests_count", #quests))
  d.tabs.buttons[2].label:SetText(Lf("detail.tab_boss_count", #self.bosses))
  d.tabs:SetValue(self.tab)
  local levels = self.tab == "boss" and self:MapLevels(inst) or nil
  d.main:ClearAllPoints()
  if levels then
    d.list:Hide()
    d.map:Show()
    local H = d.map:GetHeight()
    if not H or H <= 0 then H = 342 end
    d.map:SetWidth(math.floor((H - 24) * 1.5 + 24))
    d.main:SetPoint("TOPLEFT", d.map, "TOPRIGHT", 8, 0)
  else
    d.map:Hide()
    d.list:Show()
    d.main:SetPoint("TOPLEFT", d.list, "TOPRIGHT", 8, 0)
  end
  d.main:SetPoint("BOTTOMRIGHT", 0, ACCESS_H + 8)
  d.main:Show()
  self.pinned, self.bossFloor, self.mapLevels = nil, nil, levels
  if self.tab == "boss" then
    if levels then self:RenderMapCard(levels) else self:RenderBossList() end
    self:RenderBoss(self.bosses[self.sel.boss])
  elseif self.tab == "quests" then
    self:RenderQuestList(quests)
    local sel
    for _, q in ipairs(quests) do if q.id == self.sel.quest or (not self.sel.quest and not sel) then sel = q end end
    self.sel.quest = sel and sel.id
    self:RenderQuest(sel)
  end
  if keepScroll then
    d.list.scroll:SetOffset(listOffset)
    d.main.scroll:SetOffset(mainOffset)
  end
end

function DT:RenderHeader(inst)
  local d = self.detail
  local alt = N:InstanceAlt(inst)
  d.title:SetText(N:InstanceName(inst) .. (alt and T:Wrap("  (" .. alt .. ")", "inkMuted") or ""))
  local sub = { U.TypeLabel(inst) }
  if inst.entry or inst.zone then sub[#sub + 1] = N:InstanceEntry(inst) or N:ZoneName(inst) end
  if inst.faction then sub[#sub + 1] = N:InstanceFaction(inst) end
  if inst.availability then sub[#sub + 1] = T:Wrap(N:Availability(inst), "goldHi") end
  d.sub:SetText(table.concat(sub, "  ·  "))
  local lv = {}
  if inst.levels then lv[#lv + 1] = Lf("common.lvl", inst.levels.min .. "–" .. inst.levels.max) end
  if inst.players then lv[#lv + 1] = U.PlayersText(inst.players) end
  d.levels:SetText(table.concat(lv, "  ·  "))
  local pack = J:Pack(inst)
  d.entrancePoint = pack.entrance and { map = pack.entrance.map, x = pack.entrance.x, y = pack.entrance.y, name = Lf("point.entrance", N:InstanceName(inst)), zone = N:ZoneName(inst) }
  if d.entrancePoint then d.entrance:Show() else d.entrance:Hide() end

  local defs = {}
  if inst.origin == "new" then
    defs[#defs + 1] = { L["status.new"], "new", "star" }
  else
    defs[#defs + 1] = { L["origin.classic"], "same" }
    if inst.groupChange then defs[#defs + 1] = { L["status.changed"], "changed", "diamond", N:GroupChange(inst) } end
  end
  for _, b in ipairs(d.badges) do b:Hide() end
  local prev
  for i = #defs, 1, -1 do
    local def = defs[#defs - i + 1]
    local b = d.badges[i] or W.Badge(d, "", "same")
    d.badges[i] = b
    b:SetBadge(def[1], def[2], def[3])
    b.tip = def[4]
    if not b.hooked then
      b.hooked = true
      b:EnableMouse(true)
      b:SetScript("OnEnter", function(s)
        if not s.tip then return end
        W.Tip:Start(s, true)
        W.Tip:Line(s.tip, "ink")
        W.Tip:Finish()
      end)
      b:SetScript("OnLeave", function() W.Tip:Hide() end)
    end
    b:ClearAllPoints()
    if prev then b:SetPoint("RIGHT", prev, "LEFT", -6, 0) else b:SetPoint("TOPRIGHT", d, "TOPRIGHT", 0, -3) end
    b:Show()
    prev = b
  end

  local facts = {}
  local function add(label, value) if value and value ~= "" then facts[#facts + 1] = T:Wrap(label .. " ", "inkMuted") .. T:Wrap(value, "ink") end end
  add(L["fact.zone"], N:ZoneName(inst))
  add(L["fact.entry"], N:InstanceEntry(inst))
  add(L["fact.faction"], N:InstanceFaction(inst))
  add(L["fact.level_required"], inst.levelEntry and tostring(inst.levelEntry))
  add(L["fact.group_finder"], inst.levelFinder and Lf("common.lvl_lower", inst.levelFinder))
  add(L["fact.players"], inst.players)
  d.access.text:SetText(#facts > 0 and table.concat(facts, "    ") or L["fact.access_todo"])
end

function DT:RenderBossList()
  local scroll = self.detail.list.scroll
  local content = scroll.content
  local y = 0
  for i, boss in ipairs(self.bosses) do
    local r = self:Acquire("bossRow", function()
      local b = CreateFrame("Button", nil, content)
      b:SetHeight(BOSS_ROW)
      b.fill = W.Fill(b, "panel", 0)
      b.border = W.Border(b, "gold", 0)
      b.pin = DT.NewBossPin(b, 34)
      b.pin:SetPoint("LEFT", 6, 0)
      b.pin:EnableMouse(false)
      b.name = W.Text(b, "AF_Semi13", "ink")
      b.name:SetPoint("LEFT", b.pin, "RIGHT", 12, 0)
      b.name:SetPoint("RIGHT", -52, 0)
      b.level = W.Text(b, "AF_Mono10", "inkMuted", "RIGHT")
      b.level:SetPoint("RIGHT", -8, 0)
      b:SetScript("OnEnter", function(s) if not s.selected then T:PaintTex(s.fill, "panel", 1) end end)
      b:SetScript("OnLeave", function(s) if not s.selected then T:PaintTex(s.fill, "panel", 0) end end)
      return b
    end)
    r:ClearAllPoints()
    r:SetPoint("TOPLEFT", 0, -y)
    r:SetPoint("RIGHT", content, "RIGHT", 0, 0)
    r.pin:SetBoss(boss, self:BossBadge(i))
    local extra = boss.rare and ("  " .. L["boss.rare"]) or boss.quest and ("  " .. L["boss.quest"]) or (boss.with and ("  " .. Lf("boss.with", table.concat(boss.with, ", ")))) or ""
    r.name:SetText(N:BossName(boss) .. (extra ~= "" and T:Wrap(extra, "inkMuted") or ""))
    r.level:SetText(boss.level and Lf("common.lvl_lower", boss.level) or "")
    r.selected = (i == self.sel.boss)
    T:PaintTex(r.fill, "panel", r.selected and 1 or 0)
    r.border:SetToken("gold", r.selected and 1 or 0)
    r:SetScript("OnClick", function()
      self.sel.boss = i
      self:RenderDetail(true)
    end)
    y = y + BOSS_ROW + 2
  end
  if #self.bosses == 0 then
    local h = self:Text(content, "AF_Body12", "inkMuted", 8, 8, LIST_W - 30, L["boss.none"])
    y = h + 16
  end
  scroll:SetContentHeight(y)
end

function DT:LootRow(parent, itemID, x, y, width)
  local r = self:Acquire("lootRow", function()
    local b = CreateFrame("Button", nil, parent)
    b:SetHeight(LOOT_ROW - 2)
    b:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    b.fill = W.Fill(b, "bg1", 0)
    b.icon = b:CreateTexture(nil, "ARTWORK")
    b.icon:SetSize(24, 24)
    b.icon:SetPoint("LEFT", 4, 0)
    b.iconBorder = W.Border(CreateFrame("Frame", nil, b), "lineStrong")
    b.name = W.Text(b, "AF_Semi12", "ink")
    b.name:SetPoint("LEFT", b.icon, "RIGHT", 10, 0)
    b.slot = W.Text(b, "AF_Body12", "inkMuted", "RIGHT")
    b.slot:SetPoint("RIGHT", -8, 0)
    b:SetScript("OnEnter", function(s)
      T:PaintTex(s.fill, "bg1", 1)
      J:ShowItemTooltip(s, s.itemID)
      s:RegisterEvent("MODIFIER_STATE_CHANGED")
    end)
    b:SetScript("OnLeave", function(s)
      T:PaintTex(s.fill, "bg1", 0)
      s:UnregisterEvent("MODIFIER_STATE_CHANGED")
      GameTooltip:Hide()
      if ShoppingTooltip1 then ShoppingTooltip1:Hide() end
      if ShoppingTooltip2 then ShoppingTooltip2:Hide() end
    end)
    b:SetScript("OnEvent", function(s)
      if ShoppingTooltip1 then ShoppingTooltip1:Hide() end
      if ShoppingTooltip2 then ShoppingTooltip2:Hide() end
      J:ShowItemTooltip(s, s.itemID)
    end)
    b:SetScript("OnClick", function(s) J:ItemClick(s.itemID) end)
    return b
  end)
  r:SetParent(parent)
  r.itemID = itemID
  r:ClearAllPoints()
  r:SetPoint("TOPLEFT", parent, "TOPLEFT", x, -y)
  r:SetWidth(width)
  local item = J:Item(itemID)
  r.icon:SetTexture(item.icon or "Interface\\Icons\\INV_Misc_QuestionMark")
  r.name:SetText(item.name and (J:QualityHex(item.quality) .. item.name .. "|r") or T:Wrap(Lf("item.loading", itemID), "inkMuted"))
  r.slot:SetText(J:SlotText(item))
  return LOOT_ROW
end

function DT:RenderBoss(boss)
  local main = self.detail.main
  local content = main.scroll.content
  local width = main.scroll:ContentWidth() - 8
  if not boss then
    local h = self:Text(content, "AF_Body12", "inkMuted", 0, 0, width, L["boss.select"])
    main.scroll:SetContentHeight(h)
    return
  end
  local y = 0
  if self.mapLevels then y = self:MapStrip(content, width) end
  local head = self:Acquire("bossHead", function()
    local f = CreateFrame("Frame", nil, content)
    f:SetHeight(64)
    f.pin = DT.NewBossPin(f, 56)
    f.pin:SetPoint("LEFT", 2, 0)
    f.pin:EnableMouse(false)
    f.name = W.Text(f, "AF_Display15", "ink")
    f.name:SetPoint("TOPLEFT", f.pin, "TOPRIGHT", 16, -8)
    f.meta = W.Text(f, "AF_Body12", "inkMuted")
    f.meta:SetPoint("TOPLEFT", f.name, "BOTTOMLEFT", 0, -6)
    return f
  end)
  head:ClearAllPoints()
  head:SetPoint("TOPLEFT", 0, -y)
  head:SetPoint("RIGHT", content, "RIGHT", 0, 0)
  local bi = self.sel.boss or 1
  head.pin:SetBoss(boss, self:BossBadge(bi))
  head.name:SetText(N:BossName(boss) .. (boss.rare and T:Wrap("  " .. L["boss.rare"], "inkMuted") or boss.quest and T:Wrap("  " .. L["boss.quest"], "inkMuted") or ""))
  local meta = {}
  if boss.level then meta[#meta + 1] = Lf("common.level_n", boss.level) end
  if boss.with then meta[#meta + 1] = Lf("boss.with", table.concat(boss.with, ", ")) end
  if boss.met then
    meta[#meta + 1] = T:Wrap(L["boss.met"], "good")
  end
  if self.pinned and not self.pinned[bi] then meta[#meta + 1] = L["boss.no_pin"] end
  head.meta:SetText(table.concat(meta, "  ·  "))
  y = y + 76
  if boss.description and boss.description ~= "" then
    y = y + self:Text(content, "AF_Body12", "ink", 0, y, width, boss.description) + 12
  end
  y = y + self:Text(content, "AF_Kicker10", "gold", 0, y, width, L["loot.caps"]) + 6
  local loot, src = J:BossLoot(boss)
  if #loot == 0 then
    y = y + self:Text(content, "AF_Body12", "inkMuted", 0, y, width, L["loot.none"]) + 6
  else
    local seen = (src ~= "client" and boss.seen) or 0
    for i, itemID in ipairs(loot) do
      if seen > 0 and i == seen + 1 then
        local note = src == "questie" and L["loot.verify_classic_caps"] or L["loot.verify_external_caps"]
        y = y + 8 + self:Text(content, "AF_Kicker10", "changed", 0, y + 8, width, note) + 6
      end
      y = y + self:LootRow(content, itemID, 0, y, width)
    end
    if seen > 0 then
      y = y + 6 + self:Text(content, "AF_Body12", "inkMuted", 0, y + 6, width,
        Lf("loot.seen", Lp("loot.items_seen", seen, seen), Lp("loot.kills_noted", boss.kills or 1, boss.kills or 1)))
    elseif src ~= "client" then
      y = y + 6 + self:Text(content, "AF_Body12", "inkMuted", 0, y + 6, width, L["loot.disclaimer"])
    end
  end
  main.scroll:SetContentHeight(y + 10)
end

local function StateIcon(tex, state)
  tex:SetVertexColor(1, 1, 1)
  if tex.SetDesaturated then tex:SetDesaturated(false) end
  if state == "done" then
    tex:SetTexture(T:Tex("ui_check"))
    T:PaintTex(tex, "good")
  elseif state == "log" then
    tex:SetTexture(ICON_ACTIVE)
  else
    tex:SetTexture(ICON_AVAIL)
    if state == "locked" and tex.SetDesaturated then tex:SetDesaturated(true) end
    if state == "locked" then tex:SetVertexColor(0.6, 0.6, 0.6) end
  end
end

function DT:RenderQuestList(quests)
  local inst = self.current
  local scroll = self.detail.list.scroll
  local content = scroll.content
  local y = 0
  for _, q in ipairs(quests) do
    local info = q.info
    local state = q.id and J:QuestState(q.id, info.chain) or "avail"
    local r = self:Acquire("questRow", function()
      local b = CreateFrame("Button", nil, content)
      b:SetHeight(QUEST_ROW)
      b.fill = W.Fill(b, "panel", 0)
      b.border = W.Border(b, "gold", 0)
      b.icon = b:CreateTexture(nil, "ARTWORK")
      b.icon:SetSize(16, 16)
      b.icon:SetPoint("TOPLEFT", 8, -8)
      b.title = W.Text(b, "AF_Semi12", "ink")
      b.title:SetPoint("TOPLEFT", 32, -7)
      b.title:SetPoint("RIGHT", -30, 0)
      b.meta = W.Text(b, "AF_Body12", "inkMuted")
      b.meta:SetPoint("TOPLEFT", b.title, "BOTTOMLEFT", 0, -4)
      b.fac1 = b:CreateTexture(nil, "ARTWORK")
      b.fac1:SetSize(14, 14)
      b.fac1:SetPoint("TOPRIGHT", -8, -7)
      b.fac2 = b:CreateTexture(nil, "ARTWORK")
      b.fac2:SetSize(14, 14)
      b.fac2:SetPoint("RIGHT", b.fac1, "LEFT", -2, 0)
      b:SetScript("OnEnter", function(s) if not s.selected then T:PaintTex(s.fill, "panel", 1) end end)
      b:SetScript("OnLeave", function(s) if not s.selected then T:PaintTex(s.fill, "panel", 0) end end)
      return b
    end)
    r:ClearAllPoints()
    r:SetPoint("TOPLEFT", 0, -y)
    r:SetPoint("RIGHT", content, "RIGHT", 0, 0)
    StateIcon(r.icon, state)
    r.title:SetText(J:QuestView(q.id, q).title)
    T:PaintText(r.title, state == "locked" and "inkMuted" or "ink")
    local meta = {}
    if q.level then meta[#meta + 1] = Lf("common.lvl", q.level) end
    if q.minLevel then meta[#meta + 1] = Lf("common.required_n", q.minLevel) end
    if info.chain and #info.chain > 0 then meta[#meta + 1] = T:Wrap(L["quest.meta_chain"], "gold") end
    if state == "log" then meta[#meta + 1] = T:Wrap(L["quest.meta_in_log"], "gold") end
    if J:Unconfirmed(q) then meta[#meta + 1] = T:Wrap(L["quest.meta_unconfirmed"], "changed") end
    r.meta:SetText(table.concat(meta, " · "))
    local f1, f2 = q.faction == "both" and "alliance" or q.faction, q.faction == "both" and "horde" or nil
    r.fac1:SetTexture(FACTION_ICON[f2 or f1])
    r.fac1:SetShown(FACTION_ICON[f2 or f1] ~= nil)
    r.fac2:SetTexture(f2 and FACTION_ICON[f1] or nil)
    r.fac2:SetShown(f2 ~= nil)
    r.selected = (q.id == self.sel.quest)
    T:PaintTex(r.fill, "panel", r.selected and 1 or 0)
    r.border:SetToken("gold", r.selected and 1 or 0)
    r:SetScript("OnClick", function()
      self.sel.quest = q.id
      self:RenderDetail(true)
    end)
    y = y + QUEST_ROW + 2
  end
  if #quests == 0 then
    local h = self:Text(content, "AF_Body12", "inkMuted", 8, 8, LIST_W - 30,
      #J:Quests(inst) == 0 and L["quest.none_instance"] or L["quest.none_faction"])
    y = h + 16
  end
  scroll:SetContentHeight(y)
end

local function PointFrom(place, info)
  if not place and not info then return nil end
  local p = {}
  if info then for k, v in pairs(info) do p[k] = v end end
  p.zone = J:MapName(p.map)
  if place then
    p.name = place.name or p.name
    p.zone = place.where and N:PlaceName(place.where) or p.zone
    if not p.x and place.coords then
      local x, y = place.coords:match("([%d%.]+)%s*,%s*([%d%.]+)")
      if x then p.x, p.y = tonumber(x) / 100, tonumber(y) / 100 end
    end
  end
  p.name = N:NpcName(p.name)
  return p
end

function DT:PlaceBlock(content, label, p, y, width)
  y = y + self:Text(content, "AF_Kicker10", "gold", 0, y, width, label) + 4
  local lines = { T:Wrap(p.name or L["place.unknown"], "ink") }
  local where = {}
  if p.zone then where[#where + 1] = p.zone end
  if p.x then where[#where + 1] = string.format("%.1f, %.1f", p.x * 100, p.y * 100) end
  if #where > 0 then lines[#lines + 1] = table.concat(where, " · ") end
  local h = self:Text(content, "AF_Body12", "inkMuted", 0, y, width - 150, table.concat(lines, "\n"))
  if p.map and p.x then
    local b = self:SmallButton(content, L["common.show"], function() self:ShowPoint(p) end)
    b:SetPoint("TOPRIGHT", content, "TOPRIGHT", -4, -y)
  end
  return y + math.max(h, 24) + 14
end

function DT:RenderChain(content, info, y, width)
  local chain = info.chain or {}
  if #chain == 0 then return y end
  local steps = AF.Data.Journal and AF.Data.Journal.steps or {}
  y = y + 6 + self:Text(content, "AF_Kicker10", "gold", 0, y + 6, width, L["chain.title_caps"]) + 6
  local first = steps[chain[1]]
  local fg = first and first.giver
  if fg and (fg.name or fg.map) then
    local zone = J:MapName(fg.map)
    local where = {}
    if zone then where[#where + 1] = Lf("chain.at_zone", zone) end
    if fg.name then where[#where + 1] = Lf("chain.from_npc", N:NpcName(fg.name)) end
    y = y + self:Text(content, "AF_Body12", "ink", 0, y, width, Lf("chain.start_outside", table.concat(where, ", "))) + 6
  elseif first and first.fromItem then
    y = y + self:Text(content, "AF_Body12", "ink", 0, y, width, L["chain.start_item"]) + 6
  end
  local current
  for _, id in ipairs(chain) do
    if not J:IsDone(id) then current = id break end
  end
  for n, id in ipairs(chain) do
    local s = steps[id] or {}
    local prevDone = n == 1 or J:IsDone(chain[n - 1])
    local state = J:IsDone(id) and "done" or (J:InLog(id) and "log") or (prevDone and "avail") or "locked"
    local row = self:Acquire("step", function()
      local f = CreateFrame("Frame", nil, content)
      f.fill = W.Fill(f, "bg1", 1)
      f.border = W.Border(f, "line")
      f.icon = f:CreateTexture(nil, "ARTWORK")
      f.icon:SetSize(14, 14)
      f.icon:SetPoint("TOPLEFT", 8, -9)
      f.title = W.Text(f, "AF_Semi12", "ink")
      f.title:SetPoint("TOPLEFT", 30, -8)
      f.title:SetPoint("RIGHT", -90, 0)
      f.state = W.Text(f, "AF_Kicker9", "inkMuted", "RIGHT")
      f.state:SetPoint("TOPRIGHT", -8, -10)
      f.meta = W.Text(f, "AF_Body12", "inkMuted")
      f.meta:SetPoint("TOPLEFT", f.title, "BOTTOMLEFT", 0, -3)
      f.meta:SetPoint("RIGHT", -90, 0)
      f.show = W.Button(f, { text = L["common.show"], variant = "ghost", height = 20, padding = 6 })
      f.show:SetPoint("BOTTOMRIGHT", -6, 5)
      return f
    end)
    row:ClearAllPoints()
    row:SetPoint("TOPLEFT", content, "TOPLEFT", 0, -y)
    row:SetWidth(width)
    row:SetHeight(46)
    StateIcon(row.icon, state)
    row.title:SetText(n .. ". " .. J:QuestView(id, { name = s.name or Lf("quest.fallback_name", id) }).title .. (s.level and T:Wrap("  " .. Lf("common.lvl_lower", s.level), "inkMuted") or ""))
    row.state:SetText(L[STATE[state].capsKey])
    T:PaintText(row.state, STATE[state].token)
    local g = s.giver or {}
    local zone = J:MapName(g.map)
    local meta = {}
    if zone then meta[#meta + 1] = zone end
    if g.name then meta[#meta + 1] = N:NpcName(g.name) end
    if s.src ~= "client" and s.src then meta[#meta + 1] = T:Wrap(L["chain.to_verify"], "changed") end
    row.meta:SetText(table.concat(meta, " · "))
    local isCurrent = id == current
    row.border:SetToken(isCurrent and "gold" or "line")
    T:PaintTex(row.fill, isCurrent and "panel2" or "bg1", 1)
    if g.map and g.x then
      row.show:Show()
      row.show:SetScript("OnClick", function() self:ShowPoint({ map = g.map, x = g.x, y = g.y, name = N:NpcName(g.name), zone = zone }) end)
    else
      row.show:Hide()
    end
    y = y + 50
  end
  return y
end

function DT:RenderQuest(q)
  local inst = self.current
  local main = self.detail.main
  local content = main.scroll.content
  local width = main.scroll:ContentWidth() - 8
  if not q then
    main.scroll:SetContentHeight(self:Text(content, "AF_Body12", "inkMuted", 0, 0, width, L["quest.select"]))
    return
  end
  local info = q.info
  local state = q.id and J:QuestState(q.id, info.chain) or "avail"
  local view = J:QuestView(q.id, q)
  local y = 0
  y = y + self:Text(content, "AF_Bold16", "ink", 0, y, width, view.title) + 6
  local who = J:CharName()
  local tags = { T:Wrap(who and Lf("quest.state_for", L[STATE[state].labelKey], who) or L[STATE[state].labelKey], STATE[state].token) }
  if q.level then tags[#tags + 1] = Lf("quest.tag_level", q.level) end
  if q.minLevel then tags[#tags + 1] = Lf("common.required_n", q.minLevel) end
  tags[#tags + 1] = U.FactionLabel(q.faction)
  if info.chain and #info.chain > 0 then tags[#tags + 1] = T:Wrap(L["quest.tag_chain"], "gold") end
  if q.isNew then tags[#tags + 1] = T:Wrap(L["status.new"], "new") end
  if J:Unconfirmed(q) then tags[#tags + 1] = T:Wrap(L["quest.tag_unconfirmed"], "changed") end
  y = y + self:Text(content, "AF_Body12", "inkMuted", 0, y, width, table.concat(tags, "  ·  ")) + 12
  if state == "locked" then
    y = y + self:Text(content, "AF_Body12", "badText", 0, y, width, L["quest.locked_hint"]) + 10
  end
  if view.text then y = y + self:Text(content, "AF_Body12", "ink", 0, y, width, view.text) + 10 end
  if view.desc then y = y + self:Text(content, "AF_Body12", "inkMuted", 0, y, width, view.desc) + 10 end
  if view.objectives then
    y = y + self:Text(content, "AF_Kicker10", "gold", 0, y, width, L["quest.objectives_caps"]) + 4
    for _, o in ipairs(view.objectives) do y = y + self:Text(content, "AF_Body12", "ink", 8, y, width - 8, "• " .. o) + 3 end
    y = y + 8
  end
  y = self:RenderChain(content, info, y, width)
  local giver = PointFrom(q.giver, info.giver)
  if giver then
    y = self:PlaceBlock(content, L["quest.giver_caps"], giver, y + 6, width)
  elseif q.fromItem then
    y = y + 6 + self:Text(content, "AF_Kicker10", "gold", 0, y + 6, width, L["quest.start_caps"]) + 4
    y = y + self:Text(content, "AF_Body12", "ink", 0, y, width, N:QuestItem(q.fromItem)) + 8
  end
  local turnIn = PointFrom(q.turnIn, info.turnIn)
  if turnIn and not (q.giver and q.turnIn and q.giver.name == q.turnIn.name) then
    y = self:PlaceBlock(content, L["quest.turnin_caps"], turnIn, y, width)
  end
  local rewards = info.rewards or {}
  local kicker = L["quest.rewards_caps"]
  if info.choice and info.choice > 1 then kicker = L["quest.rewards_choice_caps"] end
  y = y + self:Text(content, "AF_Kicker10", "gold", 0, y, width, kicker) + 6
  for _, itemID in ipairs(rewards) do y = y + self:LootRow(content, itemID, 0, y, width) end
  if #rewards == 0 and q.items then
    y = y + self:Text(content, "AF_Body12", "ink", 0, y, width, table.concat(q.items, ", ")) + 4
  end
  local extra = {}
  if q.xp then extra[#extra + 1] = Lf("quest.xp", U.Num(q.xp)) end
  local money = q.money and U.Money(q.money)
  if money then extra[#extra + 1] = money end
  if q.reputation then
    for _, r in ipairs(q.reputation) do extra[#extra + 1] = "+" .. U.Num(r.amount or 0) .. " " .. U.RepName(r.faction) end
  elseif q.reputationText then
    extra[#extra + 1] = q.reputationText
  end
  if #extra > 0 then y = y + self:Text(content, "AF_Body12", "ink", 0, y + 2, width, table.concat(extra, "  ·  ")) + 6 end
  if info.rewardsSrc == "fdj" and #rewards > 0 then
    y = y + self:Text(content, "AF_Body12", "inkMuted", 0, y + 2, width, L["quest.rewards_external"]) + 6
  end
  if #rewards == 0 and not q.items and #extra == 0 then
    y = y + self:Text(content, "AF_Body12", "inkMuted", 0, y, width, L["quest.rewards_none"]) + 6
  end
  main.scroll:SetContentHeight(y + 12)
end

function DT:MapLevels(inst)
  local maps = J:Maps(inst)
  if #maps > 0 and J:MapArt(maps[1].id) then
    local out = {}
    for i, m in ipairs(maps) do
      out[i] = { name = m.name or Lf("map.floor_n", i), art = J:MapArt(m.id), clientPins = m.pins }
    end
    return out
  end
  local own = AF.Data.InstanceMaps and AF.Data.InstanceMaps[inst.id]
  if own and #own > 0 then return own end
end

local function PinsOf(m)
  if not m.art then return m.pins or {} end
  local out = {}
  for _, p in ipairs(m.clientPins or {}) do
    out[#out + 1] = { p.name or "", p.x, p.y, p.unverified and "verifier" or nil, p.ej }
  end
  return out
end

-- Badge of a boss: "R" for a rare, otherwise its number among the non-rare bosses (list, header, strip and map agree).
function DT:BossBadge(i)
  local list = self.bosses or {}
  if list[i] and list[i].rare then return "R" end
  if list[i] and list[i].quest then return "Q" end
  local n = 0
  for k = 1, i do
    if list[k] and not list[k].rare and not list[k].quest then n = n + 1 end
  end
  return tostring(n)
end

function DT:PinIndex()
  local index, byEJ = {}, {}
  for i, b in ipairs(self.bosses) do
    index[J.norm(b.name)] = index[J.norm(b.name)] or i
    if b.en then index[J.norm(b.en)] = index[J.norm(b.en)] or i end
    for _, a in ipairs(b.aka or {}) do index[J.norm(a)] = index[J.norm(a)] or i end
    if b.ej then byEJ[b.ej] = i end
  end
  return function(p)
    if p[4] then return nil end
    return (p[5] and byEJ[p[5]]) or index[J.norm(p[1])]
  end
end

function DT:MapStrip(content, width)
  local levels = self.mapLevels
  local y = 0
  if #levels > 1 then
    y = y + self:Text(content, "AF_Kicker10", "gold", 0, y, width, L["map.levels_caps"]) + 6
    local bx = 0
    for i, m in ipairs(levels) do
      local b = self:SmallButton(content, m.name or Lf("map.floor_n", i), function()
        self.sel.floor = i
        self:RenderDetail(true)
      end)
      b:SetVariant(i == self.sel.floor and "standard" or "ghost")
      local bw = b:GetWidth() or 0
      if bx > 0 and bx + bw > width then
        bx = 0
        y = y + 28
      end
      b:SetPoint("TOPLEFT", content, "TOPLEFT", bx, -y)
      bx = bx + bw + 6
    end
    y = y + 22 + 16
  end
  if #self.bosses > 0 then
    y = y + self:Text(content, "AF_Kicker10", "gold", 0, y, width, L["boss.caps"]) + 8
    local size, gap = 30, 12
    local bx = 0
    for i, boss in ipairs(self.bosses) do
      if bx > 0 and bx + size + 6 > width then
        bx = 0
        y = y + size + gap
      end
      local pin = self:Acquire("stripPin", function() return DT.NewBossPin(content, size) end)
      pin:SetParent(content)
      pin:ClearAllPoints()
      pin:SetPoint("TOPLEFT", content, "TOPLEFT", bx + 2, -(y + 2))
      pin:SetBoss(boss, self:BossBadge(i))
      pin:SetSelected(i == self.sel.boss)
      pin.label = boss.with and Lf("boss.pin_with", N:BossName(boss), table.concat(boss.with, ", ")) or N:BossName(boss)
      pin.hint = not self.pinned[i] and L["pin.no_position"] or nil
      pin:SetScript("OnClick", function()
        self.sel.boss = i
        if self.bossFloor[i] then self.sel.floor = self.bossFloor[i] end
        self:RenderDetail(true)
      end)
      bx = bx + size + gap
    end
    y = y + size + 22
  end
  return y
end

function DT:RenderMapCard(levels)
  local card = self.detail.map
  local H = card:GetHeight()
  if not H or H <= 0 then H = 342 end
  local h = H - 24
  local w = h * 1.5
  local level = math.min(self.sel.floor or 1, #levels)
  self.sel.floor = level
  local map = levels[level]
  local indexOf = self:PinIndex()

  self.pinned, self.bossFloor = {}, {}
  for li, m in ipairs(levels) do
    for _, p in ipairs(PinsOf(m)) do
      local i = indexOf(p)
      if i then
        self.pinned[i] = true
        self.bossFloor[i] = self.bossFloor[i] or li
      end
    end
  end

  local img = self:Acquire("ownMap", function()
    local f = CreateFrame("Frame", nil, card)
    f.tex = f:CreateTexture(nil, "ARTWORK")
    f.tex:SetAllPoints()
    f.border = W.Border(f, "lineStrong")
    return f
  end)
  img:ClearAllPoints()
  img:SetSize(w, h)
  img:SetPoint("TOPLEFT", card, "TOPLEFT", 12, -12)
  local pw, ph = w, h
  if map.art then
    local art = map.art
    img.tex:Hide()
    local scale = math.min(w / art.width, h / art.height)
    pw, ph = art.width * scale, art.height * scale
    local n = 0
    for row = 1, art.rows do
      for col = 1, art.cols do
        n = n + 1
        local tile = self:Acquire("tile", function() return img:CreateTexture(nil, "ARTWORK") end)
        tile:SetTexture(art.textures[n])
        tile:SetSize(art.tileW * scale, art.tileH * scale)
        tile:ClearAllPoints()
        tile:SetPoint("TOPLEFT", img, "TOPLEFT", (col - 1) * art.tileW * scale, -(row - 1) * art.tileH * scale)
      end
    end
  else
    img.tex:Show()
    img.tex:SetTexture(T:Tex(map.tex))
    img.tex:SetTexCoord(0, 0.75, 0, 1)
  end

  local pins = PinsOf(map)
  local raw, root = {}, {}
  for n, p in ipairs(pins) do
    raw[n] = { p[2] * pw, -p[3] * ph }
    root[n] = n
  end
  local function find(n) while root[n] ~= n do n = root[n] end return n end
  for n = 1, #pins do
    for m = n + 1, #pins do
      local dx, dy = raw[n][1] - raw[m][1], raw[n][2] - raw[m][2]
      if dx * dx + dy * dy < 30 * 30 then root[find(m)] = find(n) end
    end
  end
  local groups = {}
  for n = 1, #pins do
    local r = find(n)
    groups[r] = groups[r] or {}
    table.insert(groups[r], n)
  end
  local placed = {}
  for _, g in pairs(groups) do
    if #g == 1 then
      placed[g[1]] = raw[g[1]]
    else
      local cx, cy, spread = 0, 0, 0
      for _, n in ipairs(g) do cx, cy = cx + raw[n][1], cy + raw[n][2] end
      cx, cy = cx / #g, cy / #g
      for _, n in ipairs(g) do
        spread = math.max(spread, math.abs(raw[n][1] - cx) + math.abs(raw[n][2] - cy))
      end
      for k, n in ipairs(g) do
        local dx, dy = raw[n][1] - cx, raw[n][2] - cy
        local d = math.sqrt(dx * dx + dy * dy)
        if spread < 3 or d < 1 then
          local a = (k - 1) / #g * 2 * math.pi - math.pi / 2
          dx, dy, d = math.cos(a), -math.sin(a), 1
        end
        local r = math.max(22, d)
        placed[n] = { cx + dx / d * r, cy + dy / d * r }
      end
    end
  end
  local count = {}
  for _, p in ipairs(pins) do
    local i = indexOf(p)
    if i then count[i] = (count[i] or 0) + 1 end
  end
  for n, p in ipairs(pins) do
    local name, kind = p[1], p[4]
    local idx = indexOf(p)
    local pin = self:Acquire("bossPin", function() return DT.NewBossPin(img, 34) end)
    pin:SetParent(img)
    pin:SetFrameLevel(img:GetFrameLevel() + 5 + n)
    pin:ClearAllPoints()
    pin:SetPoint("CENTER", img, "TOPLEFT", placed[n][1], placed[n][2])
    if idx then
      local boss = self.bosses[idx]
      pin:SetBoss(boss, self:BossBadge(idx))
      pin:SetSelected(idx == self.sel.boss)
      pin.label, pin.hint = N:BossName(boss), L["pin.click_loot"]
      if boss.rare then pin.hint = Lf("pin.rare_prefix", pin.hint) end
      if boss.quest then pin.hint = Lf("pin.quest_boss_prefix", pin.hint) end
      if (count[idx] or 0) > 1 then pin.hint = Lf("pin.variable", count[idx], pin.hint) end
    else
      local badge = (kind == "objet" and "!") or (kind == "rare" and "R") or "?"
      pin:SetBoss({ icon = kind == "objet" and "INV_Box_02" or "INV_Misc_QuestionMark", portrait = p.portrait }, badge, false, kind ~= "rare" and kind ~= "objet")
      -- Pin names are French data ("Mineur Johnson (rare)"): drop the marker, the badge already says rare, then translate.
      pin.label = N:BossName({ name = (name:gsub("%s*%(rare%)$", "")) })
      pin.hint = (kind == "objet" and L["pin.quest_item"]) or (kind == "rare" and L["pin.rare_off_list"]) or L["pin.to_verify"]
    end
    pin:SetScript("OnClick", function()
      if idx then
        self.sel.boss = idx
        self:RenderDetail(true)
      end
    end)
  end
end
