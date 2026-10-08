-- (c) Poulpix, Azeroth Forever. All rights reserved. Text and data mining and AI training prohibited (noai, noimageai, EU Directive 2019/790 art. 4). See LICENSE.md.
-- Search field of the Dungeons & Raids tab, and of this tab only: dungeon or raid, boss, or loot name.
--
-- Index, built the first time the field gets the focus, from what the tab already shows:
--   instances  J:InstanceList() (the cards, Scarlet Monastery wings included)
--   bosses     J:Bosses(inst) (the Boss sub tab list, same order, so the same boss gets selected)
--   loot       boss.loot of that list (Data/Journal.lua): an item id that is not in a boss loot table is never a result
-- Names searched, every supported language at once (enUS, frFR, deDE, esES), whatever the addon language is:
--   the French data, the English fields of the data (nameEn, en), AF.Content[enUS|deDE|esES].npc / .where
--   and AF.Content[enUS|frFR|deDE|esES].itemName, plus what the client gives in its own language (encounter
--   journal instance and boss names, GetItemInfo item names). Nothing is translated or guessed here.
-- Matching ignores case, accents and punctuation; every word typed must appear in the name ("griffe loup" finds
-- "Gants griffe de loup").
local ADDON_NAME, AF = ...

local DT = AF.DungeonsTab
local L, Lf = AF.L, AF.Lf
local N = AF.Names
local T = AF.Theme
local W = AF.Widgets
local J = AF.Journal

local S = {}
DT.search = S

local MAX_RESULTS = 8
local MIN_CHARS = 2
local BOX_W, BOX_H = 340, 26
local DROP_W, ROW_H, NONE_H, ICON = 400, 40, 32, 28
local SKULL = "Interface\\Icons\\INV_Misc_Bone_HumanSkull_01"
local SEARCH_LOCALES = { "enUS", "frFR", "deDE", "esES" }
local KIND_RANK = { instance = 3, boss = 2, item = 1 }

local function call(fn, ...)
  if type(fn) ~= "function" then return nil end
  local r = { pcall(fn, ...) }
  if not r[1] then return nil end
  return unpack(r, 2)
end

-- Normalization -----------------------------------------------------------------

-- UTF-8 letters folded to their ASCII base, typographic punctuation folded to a space.
local FOLD = {}
local function foldGroup(to, chars)
  for ch in chars:gmatch("[\192-\244][\128-\191]*") do FOLD[ch] = to end
end
foldGroup("a", "àáâãäåāăąÀÁÂÃÄÅĀĂĄ")
foldGroup("ae", "æÆ")
foldGroup("c", "çćĉċčÇĆĈĊČ")
foldGroup("e", "èéêëēĕėęěÈÉÊËĒĔĖĘĚ")
foldGroup("i", "ìíîïĩīĭįıÌÍÎÏĨĪĬĮİ")
foldGroup("n", "ñńņňÑŃŅŇ")
foldGroup("o", "òóôõöøōŏőÒÓÔÕÖØŌŎŐ")
foldGroup("oe", "œŒ")
foldGroup("u", "ùúûüũūŭůűųÙÚÛÜŨŪŬŮŰŲ")
foldGroup("y", "ýÿÝŸ")
foldGroup("ss", "ß")
foldGroup(" ", "’‘‚“”„«»‹›–—…·¡¿\194\160\226\128\175")

local function fold(s)
  s = tostring(s or "")
  s = s:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
  s = s:gsub("[\192-\244][\128-\191]*", FOLD)
  s = s:lower():gsub("[%s%p]+", " ")
  return (s:gsub("^ +", ""):gsub(" +$", ""))
end
S.fold = fold

-- A set of searchable names: { s = folded words, c = folded without spaces }.
local function Keys()
  local k = { list = {}, seen = {} }
  function k:add(text)
    if type(text) ~= "string" or text == "" then return end
    local s = fold(text)
    if s == "" or self.seen[s] then return end
    self.seen[s] = true
    self.list[#self.list + 1] = { s = s, c = (s:gsub(" ", "")) }
  end
  return k
end

-- Hand translations of a data string (AF.Content[locale][kind][french string]) in every supported language.
local function contentAll(kind, key)
  local out = {}
  local C = AF.Content
  if type(C) ~= "table" or type(key) ~= "string" then return out end
  for _, code in ipairs(SEARCH_LOCALES) do
    local t = C[code] and C[code][kind]
    local v = t and t[key]
    if type(v) == "string" and v ~= "" then out[#out + 1] = v end
  end
  return out
end

local function norm(s) return s and J.norm(s) or nil end

-- Index ---------------------------------------------------------------------------

local function instanceKeys(inst)
  local k = Keys()
  k:add(N:InstanceName(inst))
  k:add(inst.name)
  k:add(inst.nameEn)
  for _, v in ipairs(contentAll("where", inst.name)) do k:add(v) end
  local ej = call(J.EJInstance, J, inst)
  if type(ej) == "table" then k:add(ej.name) end
  return k.list
end

local function bossKeys(inst, b)
  local k = Keys()
  local french = {}
  local function data(name)
    if type(name) ~= "string" then return end
    french[#french + 1] = name
    k:add(name)
  end
  k:add(N:BossName(b))
  data(b.name)
  k:add(b.en)
  for _, a in ipairs(b.aka or {}) do data(a) end
  local nb, ne = norm(b.name), norm(b.en)
  local function same(name)
    local n = norm(name)
    return n and n ~= "" and (n == nb or n == ne)
  end
  for _, p in ipairs(J:Pack(inst).bosses or {}) do
    if (b.npc and p.npc == b.npc) or same(p.name) or same(p.en) then
      data(p.name)
      k:add(p.en)
    end
  end
  for _, s in ipairs(inst.bosses or {}) do
    if same(s.name) or same(s.nameEn) then
      data(s.name)
      k:add(s.nameEn)
    end
  end
  for _, name in ipairs(french) do
    for _, v in ipairs(contentAll("npc", name)) do k:add(v) end
  end
  return k.list
end

local function clientItemName(id)
  local name = call((C_Item and C_Item.GetItemInfo) or GetItemInfo, id)
  if type(name) == "string" and name ~= "" then return name end
  return nil
end

-- Item names: the client name (client language, once the item is loaded) and the hand written names of
-- every supported language. Cached once the client name is known.
local itemKeys = {}
local function ItemKeys(id)
  local cached = itemKeys[id]
  if cached and cached.complete then return cached.list end
  local k = Keys()
  local client = clientItemName(id)
  k:add(client)
  local C = AF.Content
  for _, code in ipairs(SEARCH_LOCALES) do
    local t = type(C) == "table" and C[code] and C[code].itemName
    k:add(t and t[id])
  end
  k.complete = client ~= nil
  itemKeys[id] = k
  return k.list
end

function S:Build()
  if self.index then return self.index end
  local idx, seq = {}, 0
  local function push(e)
    seq = seq + 1
    e.seq = seq
    idx[#idx + 1] = e
  end
  local items = {}
  for _, inst in ipairs(DT.list or J:InstanceList()) do
    push({ kind = "instance", inst = inst, keys = instanceKeys(inst) })
    local bosses = call(J.Bosses, J, inst) or {}
    local byItem, order, n = {}, {}, 0
    for i, b in ipairs(bosses) do
      local badge
      if b.rare then badge = "R" else n = n + 1; badge = tostring(n) end
      local ref = { boss = b, pos = i, npc = b.npc, norm = norm(b.name), badge = badge }
      push({ kind = "boss", inst = inst, ref = ref, keys = bossKeys(inst, b) })
      for _, id in ipairs(b.loot or {}) do
        if not byItem[id] then
          byItem[id] = {}
          order[#order + 1] = id
        end
        local refs = byItem[id]
        if refs[#refs] ~= ref then refs[#refs + 1] = ref end
      end
    end
    for _, id in ipairs(order) do
      push({ kind = "item", inst = inst, id = id, refs = byItem[id] })
      items[id] = true
    end
  end
  self.index = idx
  -- Ask the client for the loot names it has not loaded yet (GET_ITEM_INFO_RECEIVED refreshes the list).
  for id in pairs(items) do
    if not clientItemName(id) then call(C_Item and C_Item.RequestLoadItemDataByID, id) end
  end
  return idx
end

-- Matching ------------------------------------------------------------------------

local function parse(text)
  local s = fold(text)
  local c = s:gsub(" ", "")
  if #c < MIN_CHARS then return nil end
  local tokens = {}
  for tok in s:gmatch("%S+") do tokens[#tokens + 1] = tok end
  return { s = s, c = c, tokens = tokens }
end

local function score(keys, q)
  local best = 0
  for _, key in ipairs(keys) do
    local sc = 0
    if key.s == q.s or key.c == q.c then
      sc = 100
    elseif key.s:sub(1, #q.s) == q.s then
      sc = 80
    else
      local all, starts = true, true
      local padded = " " .. key.s
      for _, tok in ipairs(q.tokens) do
        if not key.s:find(tok, 1, true) then all = false break end
        if not padded:find(" " .. tok, 1, true) then starts = false end
      end
      if all then
        sc = starts and 60 or 40
      elseif #q.c >= 3 and key.c:find(q.c, 1, true) then
        sc = 30
      end
    end
    if sc > best then best = sc end
  end
  return best
end

-- Returns at most MAX_RESULTS entries, best first, or nil when the text is too short to search.
function S:Query(text)
  local q = parse(text)
  if not q then return nil end
  local hits = {}
  for _, e in ipairs(self:Build()) do
    local keys
    if e.kind == "item" then
      if not J.missingItems[e.id] then keys = ItemKeys(e.id) end
    else
      keys = e.keys
    end
    local sc = keys and score(keys, q) or 0
    if sc > 0 then
      e.score = sc
      hits[#hits + 1] = e
    end
  end
  table.sort(hits, function(a, b)
    if a.score ~= b.score then return a.score > b.score end
    if a.kind ~= b.kind then return KIND_RANK[a.kind] > KIND_RANK[b.kind] end
    return a.seq < b.seq
  end)
  local out = {}
  for i = 1, math.min(MAX_RESULTS, #hits) do out[i] = hits[i] end
  return out
end

-- Opening a result ------------------------------------------------------------------

-- Position of the boss in the list the Boss sub tab will show (same J:Bosses call as DungeonDetail).
local function BossIndex(inst, ref)
  local bosses = J:Bosses(inst)
  if ref.npc then
    for i, b in ipairs(bosses) do if b.npc == ref.npc then return i end end
  end
  for i, b in ipairs(bosses) do if norm(b.name) == ref.norm then return i end end
  return math.max(1, math.min(ref.pos, #bosses))
end

function S:Open(e)
  if not e then return end
  self:HideDrop()
  self.focused = false
  self.edit:ClearFocus()
  if e.kind == "instance" then
    DT:OpenDetail(e.inst)
    return
  end
  -- A boss, or an item: the first boss of the list that drops it. The other ones stay in the list.
  local ref = (e.kind == "boss") and e.ref or e.refs[1]
  DT:OpenDetail(e.inst, { boss = BossIndex(e.inst, ref) })
end

-- Suggestions -----------------------------------------------------------------------

local function ItemTitle(id)
  local item = J:Item(id)
  if item.name then return J:QualityHex(item.quality) .. item.name .. "|r" end
  return T:Wrap(Lf("item.loading", id), "inkMuted")
end

local function NewRow(drop)
  local r = CreateFrame("Button", nil, drop)
  r:SetHeight(ROW_H)
  r:RegisterForClicks("LeftButtonUp", "RightButtonUp")
  r.fill = W.Fill(r, "panel2", 0)
  r.iconHolder = CreateFrame("Frame", nil, r)
  r.iconHolder:SetSize(ICON, ICON)
  r.iconHolder:SetPoint("LEFT", 8, 0)
  r.icon = r.iconHolder:CreateTexture(nil, "ARTWORK")
  r.icon:SetPoint("TOPLEFT", 1, -1)
  r.icon:SetPoint("BOTTOMRIGHT", -1, 1)
  r.iconBorder = W.Border(r.iconHolder, "lineStrong")
  r.pin = DT.NewBossPin(r, ICON)
  r.pin:SetPoint("LEFT", 8, 0)
  r.pin:EnableMouse(false)
  r.pin:Hide()
  r.title = W.Text(r, "AF_Semi12", "ink")
  r.title:SetPoint("TOPLEFT", r.iconHolder, "TOPRIGHT", 10, -1)
  r.title:SetPoint("RIGHT", -10, 0)
  r.sub = W.Text(r, "AF_Body12", "inkMuted")
  r.sub:SetPoint("BOTTOMLEFT", r.iconHolder, "BOTTOMRIGHT", 10, 1)
  r.sub:SetPoint("RIGHT", -10, 0)
  r:SetScript("OnEnter", function(self)
    S:SetActive(self.n)
    if self.entry and self.entry.kind == "item" then J:ShowItemTooltip(self, self.entry.id) end
  end)
  r:SetScript("OnLeave", function()
    if GameTooltip then GameTooltip:Hide() end
  end)
  r:SetScript("OnClick", function(self) S:Open(self.entry) end)
  return r
end

local function FillRow(r, e)
  local inst = e.inst
  r.entry = e
  r.pin:Hide()
  r.iconHolder:Show()
  r.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
  if e.kind == "instance" then
    local key = inst.packId or inst.id
    if AF.Data.InstanceMedia and AF.Data.InstanceMedia[key] == true then
      r.icon:SetTexture(T:Tex("inst_" .. key))
      r.icon:SetTexCoord(0.25, 0.75, 0, 1)
    else
      r.icon:SetTexture(SKULL)
    end
    r.title:SetText(N:InstanceName(inst))
    r.sub:SetText(DT.util.TypeLabel(inst))
  elseif e.kind == "boss" then
    r.iconHolder:Hide()
    r.pin:Show()
    r.pin:SetBoss(e.ref.boss, e.ref.badge)
    r.title:SetText(N:BossName(e.ref.boss))
    r.sub:SetText(N:InstanceName(inst))
  else
    local item = J:Item(e.id)
    r.icon:SetTexture(item.icon or "Interface\\Icons\\INV_Misc_QuestionMark")
    r.title:SetText(ItemTitle(e.id))
    local first = N:BossName(e.refs[1].boss)
    if #e.refs > 1 then first = first .. " +" .. (#e.refs - 1) end
    r.sub:SetText(N:InstanceName(inst) .. "  ·  " .. first)
  end
end

function S:SetActive(n)
  self.active = n
  for i, r in ipairs(self.rows) do
    T:PaintTex(r.fill, "panel2", (r:IsShown() and i == n) and 1 or 0)
  end
end

function S:HideDrop()
  if self.drop then self.drop:Hide() end
  if GameTooltip then GameTooltip:Hide() end
end

-- keepActive: results refreshed by a client data event, the highlighted row stays where it is.
function S:Update(keepActive)
  local text = self.edit:GetText() or ""
  self.placeholder:SetShown(text == "")
  local results = self:Query(text)
  self.results = results
  if not results or not self.focused then
    self:HideDrop()
    return
  end
  local drop = self.drop
  for _, r in ipairs(self.rows) do r:Hide() end
  local y = 4
  if #results == 0 then
    self.none:Show()
    y = y + NONE_H
  else
    self.none:Hide()
    for i, e in ipairs(results) do
      local r = self.rows[i]
      if not r then
        r = NewRow(drop)
        r.n = i
        self.rows[i] = r
      end
      r:ClearAllPoints()
      r:SetPoint("TOPLEFT", drop, "TOPLEFT", 4, -y)
      r:SetPoint("TOPRIGHT", drop, "TOPRIGHT", -4, -y)
      FillRow(r, e)
      r:Show()
      y = y + ROW_H
    end
  end
  drop:SetHeight(y + 4)
  drop:Show()
  local active = keepActive and self.active or 1
  if #results == 0 then active = nil elseif active and active > #results then active = #results end
  self:SetActive(active)
end

function S:Move(delta)
  local n = self.results and #self.results or 0
  if n == 0 or not (self.drop and self.drop:IsShown()) then return end
  local a = ((self.active or 0) + delta - 1) % n + 1
  self:SetActive(a)
end

function DT:BuildSearch(head)
  local box = W.EditBox(head, BOX_H, "AF_Body12")
  box:SetWidth(BOX_W)
  box:SetPoint("RIGHT", head, "RIGHT", -12, 0)
  local eb = box.edit
  eb:SetMaxLetters(60)
  S.box, S.edit, S.rows = box, eb, {}

  local ph = W.Text(box, "AF_Body12", "inkMuted")
  ph:SetPoint("LEFT", 8, 0)
  ph:SetPoint("RIGHT", -8, 0)
  ph:SetText(L["search.placeholder"])
  S.placeholder = ph

  local drop = CreateFrame("Frame", nil, box)
  drop:SetFrameStrata("FULLSCREEN")
  drop:SetWidth(DROP_W)
  drop:SetPoint("TOPRIGHT", box, "BOTTOMRIGHT", 0, -4)
  W.Fill(drop, "panel")
  W.Border(drop, "line")
  drop:EnableMouse(true)
  drop:Hide()
  S.drop = drop
  local none = W.Text(drop, "AF_Body12", "inkMuted")
  none:SetPoint("TOPLEFT", 14, -4)
  none:SetPoint("RIGHT", -14, 0)
  none:SetHeight(NONE_H)
  none:SetText(L["search.none"])
  S.none = none

  eb:SetScript("OnTextChanged", function() S:Update() end)
  eb:SetScript("OnEnterPressed", function()
    if S.results and S.active then S:Open(S.results[S.active]) end
  end)
  eb:SetScript("OnArrowPressed", function(_, key)
    if key == "DOWN" then S:Move(1) elseif key == "UP" then S:Move(-1) end
  end)
  eb:HookScript("OnEditFocusGained", function()
    S.focused = true
    S:Update()
  end)
  eb:HookScript("OnEditFocusLost", function()
    S.focused = false
    -- A click on a suggestion takes the focus first: keep the list until that click lands.
    if not drop:IsMouseOver() then S:HideDrop() end
  end)
  eb:HookScript("OnEscapePressed", function() S:HideDrop() end)
  box:SetScript("OnHide", function() S:HideDrop() end)
  return box
end

-- Loot names arrive later from the client: refresh the open list once per frame at most.
local refresh = CreateFrame("Frame")
refresh:Hide()
refresh:SetScript("OnUpdate", function(self)
  self:Hide()
  if S.drop and S.drop:IsShown() then S:Update(true) end
end)
local events = CreateFrame("Frame")
for _, ev in ipairs({ "GET_ITEM_INFO_RECEIVED", "ITEM_DATA_LOAD_RESULT" }) do
  pcall(events.RegisterEvent, events, ev)
end
events:SetScript("OnEvent", function() refresh:Show() end)
