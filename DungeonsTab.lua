-- (c) Poulpix, Azeroth Forever. All rights reserved. Text and data mining and AI training prohibited (noai, noimageai, EU Directive 2019/790 art. 4). See LICENSE.md.
local ADDON_NAME, AF = ...

local DT = {}
AF.DungeonsTab = DT

local L, Lf, Lp = AF.L, AF.Lf, AF.Lp
local N = AF.Names
local T = AF.Theme
local W = AF.Widgets

local HEAD_H = 56
local Y_HEAD, Y_CHIPS = 0, 64
local Y_LIST = 98
local CARD_H, MEDIA_H, SECTION_H, CARD_GAP = 234, 98, 34, 12
local THUMB_W, THUMB_H = 256, 128

local TYPE_KEYS = {
  dungeon = { new = "type.dungeon_new", classic = "type.dungeon_classic" },
  raid = { new = "type.raid_new", classic = "type.raid_classic" },
  other = { new = "type.instance_new", classic = "type.instance_classic" }
}
local FACTION_KEYS = { alliance = "faction.alliance", horde = "faction.horde", both = "faction.both" }
local FACTION_TOKENS = { alliance = "accentText", horde = "changed", both = "inkMuted" }
local NA = "–"

local REP_KEYS = {
  ["Orgrimmar"] = "rep.orgrimmar", ["Thunder Bluff"] = "rep.thunder_bluff", ["Undercity"] = "rep.undercity",
  ["Ironforge"] = "rep.ironforge", ["Stormwind"] = "rep.stormwind", ["Darnassus"] = "rep.darnassus",
  ["Gnomeregan Exiles"] = "rep.gnomeregan_exiles", ["Ratchet"] = "rep.ratchet", ["Gadgetzan"] = "rep.gadgetzan",
  ["Argent Dawn"] = "rep.argent_dawn", ["Cenarion Circle"] = "rep.cenarion_circle"
}
local CHAIN_WORD_KEYS = {
  oui = "chain.part",
  suite = "chain.next",
  ["téléporteur"] = "chain.teleporter"
}

local function TypeLabel(inst)
  local keys = TYPE_KEYS[inst.type] or TYPE_KEYS.other
  return L[keys[inst.origin == "new" and "new" or "classic"]]
end

local function FactionLabel(key)
  return L[FACTION_KEYS[key] or "faction.both"]
end

local function RepName(name)
  local key = REP_KEYS[name]
  return key and L[key] or N:RepName(name)
end

local function ChainWord(word)
  local key = CHAIN_WORD_KEYS[word]
  return key and L[key] or nil
end

local FILTERS = {
  { key = "tous", labelKey = "filter.all", test = function() return true end },
  { key = "classic", labelKey = "origin.classic", test = function(i) return i.origin == "classic" end },
  { key = "new", labelKey = "filter.new", test = function(i) return i.origin == "new" end },
  { key = "raid", labelKey = "filter.raids", test = function(i) return i.type == "raid" end }
}

local SECTIONS = {
  { key = "13-20", min = 13, max = 20, unit = "unit.dungeon" },
  { key = "20-30", min = 20, max = 30, unit = "unit.dungeon" },
  { key = "30-40", min = 30, max = 40, unit = "unit.dungeon" },
  { key = "40-50", min = 40, max = 50, unit = "unit.dungeon" },
  { key = "50-60", min = 50, max = 60, unit = "unit.dungeon" },
  { key = "raid", titleKey = "section.raids", unit = "unit.raid" }
}

local function SectionOf(inst)
  if inst.type == "raid" then return "raid" end
  local min = inst.levels and inst.levels.min or 60
  if min < 20 then return "13-20" end
  if min < 30 then return "20-30" end
  if min < 40 then return "30-40" end
  if min < 50 then return "40-50" end
  return "50-60"
end

local function Num(n)
  local sign, int, rest = tostring(n):match("^(-?)(%d+)(.*)$")
  if not int then return tostring(n) end
  local sep = L["fmt.thousands_sep"]
  local out = ""
  while #int > 3 do
    out = sep .. int:sub(-3) .. out
    int = int:sub(1, -4)
  end
  return sign .. int .. out .. rest
end

local function Money(m)
  local out = {}
  for n, u in tostring(m):gmatch("(%d+)%s*([gsc])") do
    out[#out + 1] = n .. " " .. L[({ g = "money.g", s = "money.s", c = "money.c" })[u]]
  end
  if #out == 0 then return nil end
  return table.concat(out, " ")
end

local function PlayersText(p)
  if not p then return nil end
  return Lf("card.players", p)
end

local function CountFor(inst, faction)
  local opposite = (faction == "alliance") and "horde" or "alliance"
  local n = 0
  for _, q in ipairs(AF.Journal:Quests(inst)) do
    if q.faction ~= opposite then n = n + 1 end
  end
  return n
end

DT.util = {
  TypeLabel = TypeLabel, FactionLabel = FactionLabel, FACTION_TOKENS = FACTION_TOKENS, NA = NA, RepName = RepName,
  ChainWord = ChainWord, Num = Num, Money = Money, PlayersText = PlayersText,
  CountFor = CountFor
}

local function HasThumb(inst)
  return AF.Data.InstanceMedia and AF.Data.InstanceMedia[inst.packId or inst.id] == true
end

function DT:Build(page, foot)
  self.page = page
  self.list = AF.Journal:InstanceList()
  self:BuildHead(page)
  self:BuildChips(page)

  local listScroll = W.Scroll(page)
  listScroll:SetPoint("TOPLEFT", 0, -Y_LIST)
  listScroll:SetPoint("BOTTOMRIGHT", 0, 0)
  self.listScroll = listScroll
  self:BuildCards()

  self:BuildDetail(page, Y_LIST)

  local note = W.Text(foot, "AF_Body12", "inkMuted")
  note:SetPoint("LEFT", 0, 0)
  local date = AF.Data.Instances and AF.Data.Instances.date or ""
  local y, m, d = date:match("^(%d+)%-(%d+)%-(%d+)$")
  if d then
    note:SetText(Lf("dungeons.footer", Lf("fmt.date", d, m, y), #self.list))
  else
    note:SetText(Lf("dungeons.footer_nodate", #self.list))
  end
end

function DT:BuildHead(page)
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
  icon:SetTexture("Interface\\Icons\\INV_Misc_Bone_HumanSkull_01")
  icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
  W.Border(iconHolder, "lineStrong")
  local title = W.Text(head, "AF_Display20", "ink")
  title:SetPoint("TOPLEFT", iconHolder, "TOPRIGHT", 12, -1)
  title:SetText(L["dungeons.title"])
  local n = 0
  for _, inst in ipairs(self.list) do if inst.type == "dungeon" then n = n + 1 end end
  local sub = W.Text(head, "AF_Body12", "inkMuted")
  sub:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -5)
  sub:SetText(Lf("dungeons.sub", n))
  if self.BuildSearch then
    local box = self:BuildSearch(head)
    title:SetPoint("RIGHT", box, "LEFT", -16, 0)
    sub:SetPoint("RIGHT", box, "LEFT", -16, 0)
  end
end

function DT:BuildChips(page)
  self.chips = {}
  local prev
  for _, f in ipairs(FILTERS) do
    local count = 0
    for _, inst in ipairs(self.list) do if f.test(inst) then count = count + 1 end end
    local chip = W.Chip(page, L[f.labelKey], count, function() self:SetFilter(f.key) end)
    if prev then chip:SetPoint("LEFT", prev, "RIGHT", 6, 0) else chip:SetPoint("TOPLEFT", 0, -Y_CHIPS) end
    chip.key = f.key
    self.chips[#self.chips + 1] = chip
    prev = chip
  end
end

function DT:BuildCards()
  local content = self.listScroll.content
  self.cards = {}
  self.sectionHeads = {}
  for _, s in ipairs(SECTIONS) do
    local h = CreateFrame("Frame", nil, content)
    h:SetHeight(SECTION_H)
    h.title = W.Text(h, "AF_Display15", "ink")
    h.title:SetPoint("TOPLEFT", 0, -6)
    h.title:SetText(s.titleKey and L[s.titleKey] or Lf("section.levels", s.min, s.max))
    h.count = W.Text(h, "AF_Body12", "inkMuted")
    h.count:SetPoint("BOTTOMLEFT", h.title, "BOTTOMRIGHT", 8, 1)
    h.def = s
    self.sectionHeads[s.key] = h
  end
  for _, inst in ipairs(self.list) do
    self.cards[#self.cards + 1] = self:BuildCard(content, inst)
  end
end

function DT:BuildCard(parent, inst)
  local c = CreateFrame("Button", nil, parent)
  c:SetHeight(CARD_H)
  W.Fill(c, "panel")
  c.border = W.Border(c, "line", 1, 1, "OVERLAY")
  c.inst = inst
  c.section = SectionOf(inst)

  local media = CreateFrame("Frame", nil, c)
  media:SetPoint("TOPLEFT", 1, -1)
  media:SetPoint("TOPRIGHT", -1, -1)
  media:SetHeight(MEDIA_H)
  W.Fill(media, "bg0")
  local ml = W.Tex(media, "BORDER", "line")
  ml:SetPoint("BOTTOMLEFT", 0, 0); ml:SetPoint("BOTTOMRIGHT", 0, 0); ml:SetHeight(1)
  if HasThumb(inst) then
    local img = media:CreateTexture(nil, "ARTWORK")
    img:SetPoint("TOPLEFT", 0, 0)
    img:SetPoint("BOTTOMRIGHT", 0, 1)
    img:SetTexture(T:Tex("inst_" .. (inst.packId or inst.id)))
    c.img = img
  else
    local hatch = W.Image(media, "ARTWORK", "ui_hatch", "panel", 0.6)
    hatch:SetAllPoints(media)
    local skull = media:CreateTexture(nil, "OVERLAY")
    skull:SetSize(30, 30)
    skull:SetPoint("CENTER", 0, 8)
    skull:SetTexture("Interface\\Icons\\INV_Misc_Bone_HumanSkull_01")
    local ph = W.Text(media, "AF_Kicker9", "inkMuted", "CENTER")
    ph:SetPoint("TOP", skull, "BOTTOM", 0, -6)
    ph:SetText(L["card.visual_soon_caps"])
  end
  local shade = W.Image(media, "OVERLAY", "ui_vgrad", "black", 0.45)
  shade:SetPoint("TOPLEFT", 0, 0)
  shade:SetPoint("TOPRIGHT", 0, 0)
  shade:SetHeight(40)

  local badges = {}
  if inst.origin == "new" then
    badges[#badges + 1] = { L["status.new"], "new", "star" }
  else
    badges[#badges + 1] = { L["origin.classic"], "same" }
    if inst.groupChange then badges[#badges + 1] = { L["status.changed"], "changed", "diamond" } end
  end
  local prev
  for _, b in ipairs(badges) do
    local badge = W.Badge(media, b[1], b[2], b[3], "AF_Semi12")
    badge.fill:SetVertexColor(0, 0, 0, 0.6)
    if prev then badge:SetPoint("LEFT", prev, "RIGHT", 5, 0) else badge:SetPoint("TOPLEFT", 7, -7) end
    prev = badge
  end

  local name = W.Text(c, "AF_Bold13", "ink")
  name:SetPoint("TOPLEFT", 12, -(MEDIA_H + 10))
  name:SetPoint("RIGHT", -10, 0)
  name:SetText(N:InstanceName(inst))
  c.name = name
  local en = W.Text(c, "AF_Body12", "inkMuted")
  en:SetPoint("TOPLEFT", 12, -(MEDIA_H + 29))
  local alt = N:InstanceAlt(inst)
  en:SetText(alt and ("(" .. alt .. ")") or "")

  local lvl = W.Text(c, "AF_Body12", "inkMuted")
  lvl:SetPoint("TOPLEFT", 12, -(MEDIA_H + 53))
  c.lvl = lvl
  if inst.levels then
    local rail = W.Tex(c, "ARTWORK", "bg0")
    rail:SetSize(70, 3)
    rail:SetPoint("TOPRIGHT", c, "TOPRIGHT", -12, -(MEDIA_H + 60))
    local seg = W.Tex(c, "ARTWORK", inst.origin == "new" and "new" or "same", 1, 1)
    local x0 = math.floor(70 * (inst.levels.min - 1) / 59 + 0.5)
    local x1 = math.floor(70 * (inst.levels.max - 1) / 59 + 0.5)
    seg:SetSize(math.max(3, x1 - x0), 3)
    seg:SetPoint("LEFT", rail, "LEFT", x0, 0)
  end
  local info = W.Text(c, "AF_Body12", "inkMuted")
  info:SetPoint("TOPLEFT", 12, -(MEDIA_H + 74))
  info:SetPoint("RIGHT", -10, 0)
  local parts = {}
  local players = PlayersText(inst.players)
  if players then parts[#parts + 1] = players end
  if inst.zone or inst.entry then parts[#parts + 1] = N:ZoneName(inst) or inst.entry end
  info:SetText(#parts > 0 and table.concat(parts, "  ·  ") or NA)
  local fac = W.Text(c, "AF_Body12", "inkMuted")
  fac:SetPoint("TOPLEFT", 12, -(MEDIA_H + 94))
  fac:SetText(Lf("card.faction", N:InstanceFaction(inst) or NA))
  local count = W.Text(c, "AF_Semi12", "ink")
  count:SetPoint("TOPLEFT", 12, -(MEDIA_H + 116))
  count:SetPoint("RIGHT", -10, 0)
  c.count = count

  c:SetScript("OnEnter", function(self) self.border:SetToken("gold") end)
  c:SetScript("OnLeave", function(self) self.border:SetToken(self.selected and "gold" or "line") end)
  c:SetScript("OnClick", function() self:OpenDetail(inst) end)
  return c
end

function DT:RefreshCardTexts()
  local faction = AF.UI:GetFaction()
  for _, c in ipairs(self.cards) do
    local inst = c.inst
    if inst.levels then
      c.lvl:SetText(Lf("card.level_recommended", T:Wrap(inst.levels.min .. "–" .. inst.levels.max, "ink")))
    elseif inst.availability then
      c.lvl:SetText(T:Wrap(N:Availability(inst), "goldHi"))
    else
      c.lvl:SetText(Lf("card.level_max", AF.Data.Constants.MAX_LEVEL))
    end
    local bosses = #(inst.bosses or {})
    if bosses == 0 then bosses = inst.bossCount or 0 end
    local parts = {}
    if bosses > 0 then parts[#parts + 1] = Lp("unit.boss", bosses, bosses) end
    if #(inst.quests or {}) == 0 then
      parts[#parts + 1] = T:Wrap(L["card.quests_todo"], "inkMuted")
    else
      local nq = CountFor(inst, faction)
      parts[#parts + 1] = Lf("card.quests_side", Lp("unit.quest", nq, nq), FactionLabel(faction))
    end
    c.count:SetText(table.concat(parts, "  ·  "))
  end
end

function DT:Layout()
  local width = self.listScroll:ContentWidth()
  local cols = 4
  local cw = math.floor((width - (cols - 1) * CARD_GAP) / cols)
  local test = FILTERS[1].test
  for _, f in ipairs(FILTERS) do if f.key == self.filter then test = f.test end end
  for _, c in ipairs(self.cards) do c:Hide() end
  local y = 0
  for _, s in ipairs(SECTIONS) do
    local items = {}
    for _, c in ipairs(self.cards) do
      if c.section == s.key and test(c.inst) then items[#items + 1] = c end
    end
    local h = self.sectionHeads[s.key]
    if #items == 0 then
      h:Hide()
    else
      h:ClearAllPoints()
      h:SetPoint("TOPLEFT", 0, -y)
      h:SetPoint("RIGHT", self.listScroll.content, "RIGHT", 0, 0)
      h.count:SetText(Lp(s.unit, #items, #items))
      h:Show()
      y = y + SECTION_H
      for i, c in ipairs(items) do
        local col = (i - 1) % cols
        local row = math.floor((i - 1) / cols)
        c:ClearAllPoints()
        c:SetWidth(cw)
        c:SetPoint("TOPLEFT", col * (cw + CARD_GAP), -(y + row * (CARD_H + CARD_GAP)))
        if c.img then
          local fw, fh = cw - 2, MEDIA_H - 1
          local scale = math.max(fw / THUMB_W, fh / THUMB_H)
          local cx = math.max(0, (1 - fw / (THUMB_W * scale)) / 2)
          local cy = math.max(0, (1 - fh / (THUMB_H * scale)) / 2)
          c.img:SetTexCoord(cx, 1 - cx, cy, 1 - cy)
        end
        c:Show()
      end
      local rows = math.ceil(#items / cols)
      y = y + rows * (CARD_H + CARD_GAP) + 10
    end
  end
  self.listScroll:SetContentHeight(y)
end

function DT:SetFilter(key)
  self.filter = key
  AF.UI:Options().dungeonFilter = key
  for _, chip in ipairs(self.chips) do chip:SetActive(chip.key == key) end
  self:CloseDetail()
  self.listScroll:SetOffset(0)
  self:Layout()
end

function DT:OnShow()
  if not self.filter then
    local saved = AF.UI:Options().dungeonFilter
    self.filter = "tous"
    for _, f in ipairs(FILTERS) do
      if f.key == saved then self.filter = saved end
    end
    for _, chip in ipairs(self.chips) do chip:SetActive(chip.key == self.filter) end
  end
  self:Refresh()
end

function DT:Refresh()
  if not self.page then return end
  self:RefreshCardTexts()
  self:Layout()
  if self.current then self:RenderDetail() end
end

function DT:OnFactionChanged()
  if self.page then self:Refresh() end
end
