-- (c) Poulpix, Azeroth Forever. All rights reserved. Text and data mining and AI training prohibited (noai, noimageai, EU Directive 2019/790 art. 4). See LICENSE.md.
local ADDON_NAME, AF = ...

local J = {}
AF.Journal = J

local function call(fn, ...)
  if type(fn) ~= "function" then return nil end
  local r = { pcall(fn, ...) }
  if not r[1] then return nil end
  return unpack(r, 2)
end

local function norm(s)
  return (tostring(s or ""):lower():gsub("[%s%p]", ""))
end
J.norm = norm

function J:Pack(inst)
  local pack = AF.Data.Journal and AF.Data.Journal.instances
  return pack and pack[inst.packId or inst.id] or {}
end

local instanceList

function J:InstanceList()
  if instanceList then return instanceList end
  local wings = AF.Data.Wings or {}
  instanceList = {}
  for _, inst in ipairs((AF.Data.Instances and AF.Data.Instances.list) or {}) do
    local split = wings[inst.id]
    if split and inst.wings then
      for i, w in ipairs(split) do
        local range
        for _, r in ipairs(inst.wings) do if r.name == w.wing then range = r end end
        local v = setmetatable({}, { __index = inst })
        v.id, v.packId, v.parent, v.wing = w.id, inst.id, inst, w.wing
        v.name = inst.name .. " : " .. w.wing
        v.nameEn = inst.nameEn and (inst.nameEn .. " : " .. w.en)
        v.order = (inst.order or 0) + i / 100
        v.wings = false
        v.note = nil
        if range then v.levels = { min = range.min, max = range.max } end
        v.bosses = {}
        for _, b in ipairs(inst.bosses or {}) do
          if b.wing == w.wing then v.bosses[#v.bosses + 1] = b end
        end
        v.bossCount = #v.bosses
        v.questFilter = {}
        for _, id in ipairs(w.quests or {}) do v.questFilter[id] = true end
        instanceList[#instanceList + 1] = v
      end
    else
      instanceList[#instanceList + 1] = inst
    end
  end
  return instanceList
end

local ejIndex, ejEncounters, ejLoot = nil, {}, {}

local function ScanInstances()
  ejIndex = {}
  if type(EJ_GetInstanceByIndex) ~= "function" then return end
  local isLoaded = (C_AddOns and C_AddOns.IsAddOnLoaded) or IsAddOnLoaded
  if not call(isLoaded, "Blizzard_EncounterJournal") then
    call((C_AddOns and C_AddOns.LoadAddOn) or LoadAddOn, "Blizzard_EncounterJournal")
  end
  local tiers = call(EJ_GetNumTiers) or 0
  for tier = 1, math.max(tiers, 1) do
    if tiers > 0 then call(EJ_SelectTier, tier) end
    for _, isRaid in ipairs({ false, true }) do
      for index = 1, 100 do
        local id, name = call(EJ_GetInstanceByIndex, index, isRaid)
        if not id then break end
        local _, _, _, _, _, _, areaMapID = call(EJ_GetInstanceInfo, id)
        local entry = { id = id, name = name, raid = isRaid, tier = tier, areaMapID = areaMapID }
        ejIndex[id] = entry
        if name then ejIndex[norm(name)] = entry end
      end
    end
  end
end

function J:EJInstance(inst)
  if not ejIndex then ScanInstances() end
  local pack = self:Pack(inst)
  return (pack.ej and ejIndex[pack.ej]) or ejIndex[norm(inst.name)] or (inst.nameEn and ejIndex[norm(inst.nameEn)])
end

local function SelectEJ(entry)
  if (call(EJ_GetNumTiers) or 0) > 0 then call(EJ_SelectTier, entry.tier) end
  call(EJ_SelectInstance, entry.id)
end

function J:EJEncounters(entry)
  if ejEncounters[entry.id] then return ejEncounters[entry.id] end
  local list = {}
  SelectEJ(entry)
  for i = 1, 40 do
    local name, description, encounterID = call(EJ_GetEncounterInfoByIndex, i, entry.id)
    if not name then name, description, encounterID = call(EJ_GetEncounterInfoByIndex, i) end
    if not name then break end
    local creatureID, _, _, displayInfo, icon = call(EJ_GetCreatureInfo, 1, encounterID)
    list[#list + 1] = { name = name, description = description, ej = encounterID, npc = creatureID, display = displayInfo, icon = icon }
  end
  ejEncounters[entry.id] = list
  return list
end

function J:EJLoot(entry, encounterID)
  local key = entry.id .. ":" .. encounterID
  if ejLoot[key] then return ejLoot[key] end
  SelectEJ(entry)
  call(EJ_SetLootFilter, 0, 0)
  if Enum and Enum.ItemSlotFilterType and C_EncounterJournal then
    call(C_EncounterJournal.SetSlotFilter, Enum.ItemSlotFilterType.NoFilter)
  end
  call(EJ_SelectEncounter, encounterID)
  local items = {}
  for i = 1, call(EJ_GetNumLoot) or 0 do
    local info = C_EncounterJournal and call(C_EncounterJournal.GetLootInfoByIndex, i)
    local itemID = type(info) == "table" and info.itemID or call(EJ_GetLootInfoByIndex, i)
    if itemID then items[#items + 1] = itemID end
  end
  if #items > 0 then ejLoot[key] = items end
  return items
end

function J:Bosses(inst)
  local pack = self:Pack(inst)
  local byKey = {}
  for _, b in ipairs(pack.bosses or {}) do
    byKey[norm(b.name)] = b
    if b.en then byKey[norm(b.en)] = b end
    if b.npc then byKey[b.npc] = b end
  end
  local lootByNpc = pack.lootByNpc or {}
  local entry = self:EJInstance(inst)
  local out = {}
  if entry then
    for _, e in ipairs(self:EJEncounters(entry)) do
      local p = (e.npc and byKey[e.npc]) or byKey[norm(e.name)] or {}
      local loot = p.loot or (e.npc and lootByNpc[e.npc])
      out[#out + 1] = {
        name = e.name, description = e.description, ej = e.ej, npc = e.npc or p.npc,
        display = e.display or p.display, icon = e.icon, level = p.level, pin = p.pin,
        loot = loot, lootSource = loot and (p.src or "questie") or nil, seen = p.seen, instance = entry, source = "client"
      }
    end
  end
  if #out == 0 then
    for _, b in ipairs(pack.bosses or {}) do
      out[#out + 1] = { name = b.name, en = b.en, npc = b.npc, display = b.display, level = b.level, pin = b.pin, rare = b.rare, quest = b.quest,
        loot = b.loot, lootSource = b.loot and b.src or nil, seen = b.seen, kills = b.kills, met = b.met, source = "pack" }
    end
  end
  if #out == 0 then
    for _, b in ipairs(inst.bosses or {}) do out[#out + 1] = { name = b.name, en = b.nameEn, source = "site" } end
  end
  if inst.parent then
    local keep = {}
    for _, b in ipairs(inst.bosses) do keep[norm(b.name)] = true end
    local wing = {}
    for _, b in ipairs(out) do if keep[norm(b.name)] then wing[#wing + 1] = b end end
    out = wing
  end
  out = self:OrderBosses(inst, out)
  local por = AF.Data.BossPortraits and AF.Data.BossPortraits[inst.id]
  if por then
    for _, b in ipairs(out) do b.portrait = b.portrait or por[b.name] end
  end
  return out
end

function J:OrderBosses(inst, base)
  local order = AF.Data.BossLists and AF.Data.BossLists[inst.id]
  if not order then return base end
  local out, used = {}, {}
  for _, o in ipairs(order) do
    local keys = { [norm(o.name)] = true }
    for _, a in ipairs(o.aka or {}) do keys[norm(a)] = true end
    local hit
    for i, b in ipairs(base) do
      if not used[i] and (keys[norm(b.name)] or (b.en and keys[norm(b.en)])) then hit = i break end
    end
    local b
    if hit then
      used[hit] = true
      b = base[hit]
      b.level = b.level or o.level
      if o.rename then b.name = o.name end
    else
      b = { name = o.name, level = o.level, source = "liste", fcOnly = true }
    end
    b.aka = o.aka
    b.icon = b.icon or o.icon
    b.rare = o.rare or b.rare
    b.with = o.with
    b.portrait = o.portrait
    out[#out + 1] = b
  end
  for i, b in ipairs(base) do
    if not used[i] then
      b.outside = true
      out[#out + 1] = b
    end
  end
  return out
end

local PLACEHOLDER = "Interface\\Icons\\INV_Misc_Bone_HumanSkull_01"

local function IconOf(tex)
  local ic = tex._afIcon
  if not ic then
    local layer, sub = tex:GetDrawLayer()
    ic = tex:GetParent():CreateTexture(nil, layer or "ARTWORK", nil, sub)
    ic:SetAllPoints(tex)
    ic._afMask = pcall(ic.SetMask, ic, AF.Theme:Tex("ui_circle")) and true or false
    if not ic._afMask then ic:SetTexCoord(0.08, 0.92, 0.08, 0.92) end
    tex._afIcon = ic
  end
  return ic
end

local function ShowIcon(tex, path)
  local ic = IconOf(tex)
  tex:Hide()
  ic:SetTexture(path)
  ic:Show()
end

function J:SetBossPortrait(tex, boss)
  local ok, kind = pcall(function()
    if boss and boss.portrait then
      ShowIcon(tex, AF.Theme:Tex(boss.portrait))
      return "fourni"
    end
    if boss and boss.display and SetPortraitTextureFromCreatureDisplayID then
      if tex._afIcon then tex._afIcon:Hide() end
      tex:Show()
      if pcall(SetPortraitTextureFromCreatureDisplayID, tex, boss.display) then return "portrait" end
    end
    local icon = boss and boss.icon
    if type(icon) == "string" and not icon:find("\\") then icon = "Interface\\Icons\\" .. icon end
    ShowIcon(tex, icon or PLACEHOLDER)
    return icon and "icone" or "generique"
  end)
  if ok then return kind end
  pcall(ShowIcon, tex, PLACEHOLDER)
  return "generique"
end

J.missingItems = {}

function J:BossLoot(boss)
  if boss.instance and boss.ej then
    local items = self:EJLoot(boss.instance, boss.ej)
    if #items > 0 then return items, "client" end
  end
  local out = {}
  for _, id in ipairs(boss.loot or {}) do
    if not J.missingItems[id] then out[#out + 1] = id end
  end
  return out, boss.lootSource
end

function J:MapName(mapID)
  local info = mapID and call(C_Map and C_Map.GetMapInfo, mapID)
  return info and info.name
end

function J:Maps(inst)
  local pack = self:Pack(inst)
  local entry = self:EJInstance(inst)
  local maps = {}
  local root = entry and entry.areaMapID
  if root and root > 0 then
    local group = call(C_Map and C_Map.GetMapGroupID, root)
    local members = group and call(C_Map.GetMapGroupMembersInfo, group)
    if type(members) == "table" and #members > 0 then
      for _, m in ipairs(members) do maps[#maps + 1] = { id = m.mapID, name = m.name } end
    else
      local info = call(C_Map and C_Map.GetMapInfo, root)
      maps[1] = { id = root, name = info and info.name }
    end
  elseif pack.maps then
    for _, m in ipairs(pack.maps) do maps[#maps + 1] = { id = m.id, name = m.name } end
  end
  for _, m in ipairs(maps) do
    m.pins = {}
    local onMap = call(C_EncounterJournal and C_EncounterJournal.GetEncountersOnMap, m.id)
    for _, p in ipairs(type(onMap) == "table" and onMap or {}) do
      m.pins[#m.pins + 1] = { ej = p.encounterID, x = p.mapX, y = p.mapY }
    end
    if #m.pins == 0 then
      for _, b in ipairs(pack.bosses or {}) do
        if b.pin and b.pin.map == m.id then m.pins[#m.pins + 1] = { name = b.name, x = b.pin.x, y = b.pin.y, unverified = true } end
      end
    end
  end
  return maps
end

function J:MapArt(mapID)
  local layers = call(C_Map and C_Map.GetMapArtLayers, mapID)
  local layer = type(layers) == "table" and layers[1]
  if not layer then return nil end
  local textures = call(C_Map.GetMapArtLayerTextures, mapID, 1)
  if type(textures) ~= "table" or #textures == 0 then return nil end
  return {
    width = layer.layerWidth, height = layer.layerHeight,
    tileW = layer.tileWidth, tileH = layer.tileHeight,
    cols = math.ceil(layer.layerWidth / layer.tileWidth), rows = math.ceil(layer.layerHeight / layer.tileHeight),
    textures = textures
  }
end

local itemCache = {}

function J:Item(id)
  local c = itemCache[id]
  if c and c.name then return c end
  local getInfo = (C_Item and C_Item.GetItemInfo) or GetItemInfo
  local name, link, quality, _, _, _, subType, _, equipLoc, icon = call(getInfo, id)
  if not icon then
    local _, _, _, loc, ic = call((C_Item and C_Item.GetItemInfoInstant) or GetItemInfoInstant, id)
    icon, equipLoc = ic, equipLoc or loc
  end
  if name and AF.Names then name = AF.Names:ItemName(id) or name end
  c = { id = id, name = name, link = link, quality = quality, icon = icon, equipLoc = equipLoc, subType = subType }
  if not name then call(C_Item and C_Item.RequestLoadItemDataByID, id) end
  itemCache[id] = c
  return c
end

function J:QualityHex(quality)
  local c = ITEM_QUALITY_COLORS and quality and ITEM_QUALITY_COLORS[quality]
  if c and c.hex then return c.hex end
  local _, _, _, hex = call(C_Item and C_Item.GetItemQualityColor or GetItemQualityColor, quality or 1)
  return hex and ("|c" .. hex) or "|cffffffff"
end

function J:SlotText(item)
  local slot = item.equipLoc and item.equipLoc ~= "" and _G[item.equipLoc]
  if slot and item.subType and item.subType ~= "" and item.subType ~= slot then
    return slot .. ", " .. item.subType
  end
  return slot or item.subType or ""
end

function J:ShowItemTooltip(owner, id)
  if not GameTooltip then return end
  local item = self:Item(id)
  GameTooltip:SetOwner(owner, "ANCHOR_RIGHT")
  GameTooltip:SetHyperlink(item.link or ("item:" .. id))
  GameTooltip:Show()
  if IsShiftKeyDown and IsShiftKeyDown() and GameTooltip_ShowCompareItem then
    call(GameTooltip_ShowCompareItem, GameTooltip)
  end
end

function J:ItemClick(id)
  local item = self:Item(id)
  local link = item.link or select(2, call((C_Item and C_Item.GetItemInfo) or GetItemInfo, id))
  if not link then return end
  if IsModifiedClick and HandleModifiedItemClick and HandleModifiedItemClick(link) then return end
  if IsShiftKeyDown and IsShiftKeyDown() and ChatEdit_InsertLink then ChatEdit_InsertLink(link) end
end

local titleCache, requested, missing = {}, {}, {}
local views = {}

function J:Quests(inst)
  if views[inst] then return views[inst] end
  local pack = self:Pack(inst)
  local hidden = {}
  for _, i in ipairs(pack.hide or {}) do hidden[i] = true end
  local out = {}
  for i, q in ipairs(inst.quests or {}) do
    local id = q.id or (pack.fixIds and pack.fixIds[i])
    if not hidden[i] and (not inst.questFilter or (id and inst.questFilter[id])) then
      local v = setmetatable({}, { __index = q })
      v.id = q.id or (pack.fixIds and pack.fixIds[i])
      v.info = (v.id and pack.quests and pack.quests[v.id]) or {}
      v.level = v.info.level or q.level
      v.minLevel = v.info.minLevel or q.minLevel
      out[#out + 1] = v
    end
  end
  views[inst] = out
  return out
end

function J:Unconfirmed(q)
  return (q.id and missing[q.id]) or q.info.confirmed == false or (not q.id)
end

function J:QuestTitle(id, fallback)
  if titleCache[id] then return titleCache[id], true end
  local title = call(C_QuestLog and C_QuestLog.GetTitleForQuestID, id)
  if title and title ~= "" then
    titleCache[id] = title
    return title, true
  end
  local steps = AF.Data.Journal and AF.Data.Journal.steps
  fallback = fallback or (steps and steps[id] and steps[id].name)
  if not requested[id] then
    requested[id] = true
    call(C_QuestLog and C_QuestLog.RequestLoadQuestByID, id)
  end
  return fallback, false
end

-- Official text of a quest for the addon language (Data/QuestText.lua, generated from Wowhead by
-- tools/fetch-wowhead-quests.py). Nil when the file has no entry: the French data is used then.
local function Official(id)
  local T = id and AF.Data and AF.Data.QuestText
  if type(T) ~= "table" then return nil end
  local code = AF.GetActiveLocale and AF:GetActiveLocale() or nil
  local t = code and (T[code] or (code == "esMX" and T.esES) or nil)
  local base = t and t[id] or nil
  -- Wowhead puts untranslated text between brackets ("[Crest of Lordaeron]"): those fields come from
  -- AF.Content[locale].questText (hand translation) when present, otherwise they are dropped.
  local C = AF.Content and (AF.Content[code] or (code == "esMX" and AF.Content.esES))
  local fix = C and C.questText and C.questText[id]
  if not base then return fix end
  local function bracketed(s) return type(s) == "string" and s:match("^%[.*%]") ~= nil end
  local bad = bracketed(base.title) or bracketed(base.summary) or bracketed(base.desc)
  for _, o in ipairs(base.objectives or {}) do if bracketed(o) then bad = true end end
  if not bad and not fix then return base end
  local out = {}
  for _, k in ipairs({ "title", "summary", "desc" }) do
    local v = fix and fix[k] or base[k]
    if not bracketed(v) then out[k] = v end
  end
  local objs = fix and fix.objectives or base.objectives
  if objs then
    local clean = {}
    for _, o in ipairs(objs) do if not bracketed(o) then clean[#clean + 1] = o end end
    if #clean > 0 then out.objectives = clean end
  end
  return out
end

-- Wowhead writes <name>, <race>, <class> (deDE: <Name>, <Volk>, <Klasse>) where the game puts the character's
-- own words, and <male/female> for gendered words (UnitSex: 2 male, 3 female).
local PLACEHOLDERS = {
  name = { "<[Nn]ame>", "<[Nn]ombre>" },
  race = { "<[Rr]ace>", "<Volk>", "<[Rr]aza>" },
  class = { "<[Cc]lass>", "<Klasse>", "<[Cc]lase>" },
}
local function Player(text)
  if type(text) ~= "string" then return text end
  local words = { name = call(UnitName, "player"), race = call(UnitRace, "player"), class = call(UnitClass, "player") }
  for kind, patterns in pairs(PLACEHOLDERS) do
    local word = words[kind]
    if type(word) == "string" and word ~= "" then
      for _, pat in ipairs(patterns) do text = text:gsub(pat, (word:gsub("%%", "%%%%"))) end
    end
  end
  local sex = call(UnitSex, "player")
  if sex == 2 or sex == 3 then
    text = text:gsub("<([^<>/]+)/([^<>/]+)>", function(male, female) return sex == 3 and female or male end)
  end
  -- Game form $gmale:female; (one esES text has no closing ";": the female part then takes as many words as the male one).
  local female = sex == 3
  text = text:gsub("%$[gG]([^:;$]+):([^;$]+);", function(m, f) return female and f or m end)
  text = text:gsub("%$[gG]([^:;$]+):(.*)", function(m, rest)
    local n = select(2, m:gsub("%S+", "")) or 1
    local words, cut = 0, #rest
    for s, e in rest:gmatch("()%S+()") do
      words = words + 1
      if words == n then cut = e - 1 break end
    end
    return (female and rest:sub(1, cut) or m) .. rest:sub(cut + 1)
  end)
  return text
end

-- Quest texts shown by the addon, one place for every screen. First non empty source wins:
--   title       C_QuestLog.GetTitleForQuestID (J:QuestTitle), Data/QuestText, journal title, q.name
--   text        in the quest log: GetQuestLogQuestText (objective text), else Data/QuestText summary, else q.summary
--   desc        in the quest log: GetQuestLogQuestText (description), else Data/QuestText desc, else none
--   objectives  C_QuestLog.GetQuestObjectives when it gives readable lines, Data/QuestText, q.objectives
--               (through Locale/*_Content.lua objective outside frFR)
-- Nothing is translated. NPC names, places and the icon stay as they are (data and client textures).
-- q is a quest of J:Quests (or any table with the data fields), id its quest id (nil: data only).
-- Returns { title, text, desc, objectives = { lines }, src = { ... = "client" | "wowhead" | "data" } }.
function J:QuestView(id, q)
  q = q or {}
  local info = q.info or {}
  local o = Official(id) or {}
  local v = { src = {} }
  local dataTitle = info.title or q.name
  if id then
    local title, fromClient = self:QuestTitle(id, o.title or dataTitle)
    v.title, v.src.title = title, fromClient and "client" or (o.title and "wowhead" or "data")
  else
    -- no quest id (beta quest): the name in the addon language, French data only in frFR
    local N = AF.Names
    local t = N and N.UseClient and N.UseClient() and q.name and N:QuestName(q, info) or dataTitle
    v.title, v.src.title = t, "data"
  end
  if id and self:InLog(id) and type(GetQuestLogQuestText) == "function" then
    local idx = call(C_QuestLog and C_QuestLog.GetLogIndexForQuestID, id)
    local desc, objText
    if idx then desc, objText = call(GetQuestLogQuestText, idx) end
    if type(objText) == "string" and objText ~= "" then v.text, v.src.text = objText, "client" end
    if type(desc) == "string" and desc ~= "" then v.desc, v.src.desc = desc, "client" end
  end
  if not v.text and o.summary then v.text, v.src.text = Player(o.summary), "wowhead" end
  if not v.text then v.text, v.src.text = q.summary, "data" end
  if not v.desc and o.desc then v.desc, v.src.desc = Player(o.desc), "wowhead" end
  if id then
    local list = call(C_QuestLog and C_QuestLog.GetQuestObjectives, id)
    -- Out of the quest log the client can answer a bare counter ("0/1  ", no item name, seen on quest 2040).
    -- A line with nothing but digits, spaces and punctuation makes the whole client list unusable.
    local lines, usable = {}, true
    for _, obj in ipairs(type(list) == "table" and list or {}) do
      local text = type(obj) == "table" and obj.text
      if type(text) == "string" and text ~= "" then
        if text:gsub("[%d%s%p]", "") == "" then usable = false end
        lines[#lines + 1] = text
      end
    end
    if usable and #lines > 0 then v.objectives, v.src.objectives = lines, "client" end
  end
  if not v.objectives and o.objectives then v.objectives, v.src.objectives = o.objectives, "wowhead" end
  if not v.objectives and q.objectives then
    -- Last resort: the data objectives, through the hand written text of the addon language (Locale/*_Content.lua,
    -- objective table) for the few quests Wowhead has no objective text for. frFR shows the data as it is.
    local N, list = AF.Names, {}
    for i, o in ipairs(q.objectives) do list[i] = (N and N.QuestObjective) and N:QuestObjective(o) or o end
    v.objectives, v.src.objectives = list, "data"
  end
  return v
end

local bulkDone
local laterSteps

function J:CharKey()
  local name = UnitName and UnitName("player") or "?"
  local realm = GetRealmName and GetRealmName() or ""
  return (name or "?") .. "-" .. (realm or "")
end

function J:CharName()
  return UnitName and UnitName("player") or nil
end

local function Remembered()
  AzerothForeverDB = AzerothForeverDB or {}
  AzerothForeverDB.questsDone = AzerothForeverDB.questsDone or {}
  local key = J:CharKey()
  AzerothForeverDB.questsDone[key] = AzerothForeverDB.questsDone[key] or {}
  return AzerothForeverDB.questsDone[key]
end

function J:LoadCompleted()
  local set = {}
  local ids = call(C_QuestLog and C_QuestLog.GetAllCompletedQuestIDs)
  if type(ids) == "table" then for _, id in ipairs(ids) do set[id] = true end end
  local t = call(GetQuestsCompleted)
  if type(t) == "table" then for id, v in pairs(t) do if v then set[id] = true end end end
  bulkDone = set
end

function J:MarkDone(id)
  if not id then return end
  Remembered()[id] = true
  if bulkDone then bulkDone[id] = true end
end

local function FlaggedDone(id)
  if call(C_QuestLog and C_QuestLog.IsQuestFlaggedCompleted, id) then return true end
  if IsQuestFlaggedCompleted and call(IsQuestFlaggedCompleted, id) then return true end
  if bulkDone and bulkDone[id] then return true end
  return Remembered()[id] == true
end

local function LaterSteps()
  if laterSteps then return laterSteps end
  laterSteps = {}
  for _, pack in pairs((AF.Data.Journal and AF.Data.Journal.instances) or {}) do
    for qid, info in pairs(pack.quests or {}) do
      for _, prev in ipairs(info.chain or {}) do
        laterSteps[prev] = laterSteps[prev] or {}
        table.insert(laterSteps[prev], qid)
      end
    end
  end
  return laterSteps
end

function J:IsDone(id)
  if FlaggedDone(id) then return true end
  for _, later in ipairs(LaterSteps()[id] or {}) do
    if FlaggedDone(later) then
      Remembered()[id] = true
      return true
    end
  end
  return false
end

function J:InLog(id)
  local idx = call(C_QuestLog and C_QuestLog.GetLogIndexForQuestID, id)
  return idx ~= nil and idx ~= 0
end

function J:QuestState(id, chain)
  if self:IsDone(id) then return "done" end
  if self:InLog(id) then return "log" end
  for _, prev in ipairs(chain or {}) do
    if not self:IsDone(prev) then return "locked" end
  end
  return "avail"
end

local mapPin

local function WorldMapPin(map, x, y, label)
  if not WorldMapFrame or (InCombatLockdown and InCombatLockdown()) then return false end
  if C_Map and C_Map.OpenWorldMap then call(C_Map.OpenWorldMap, map) else ShowUIPanel(WorldMapFrame) end
  if WorldMapFrame.SetMapID then call(WorldMapFrame.SetMapID, WorldMapFrame, map) end
  local canvas = WorldMapFrame.GetCanvas and WorldMapFrame:GetCanvas()
  if not canvas then return false end
  if not mapPin then
    mapPin = CreateFrame("Frame", nil, canvas)
    mapPin:SetSize(28, 28)
    mapPin.tex = mapPin:CreateTexture(nil, "OVERLAY")
    mapPin.tex:SetAllPoints()
    mapPin.tex:SetTexture(AF.Theme:Tex("ui_ring"))
    mapPin.dot = mapPin:CreateTexture(nil, "OVERLAY")
    mapPin.dot:SetSize(10, 10)
    mapPin.dot:SetPoint("CENTER")
    mapPin.dot:SetTexture(AF.Theme:Tex("ui_circle"))
    AF.Theme:PaintTex(mapPin.tex, "gold")
    AF.Theme:PaintTex(mapPin.dot, "gold")
    mapPin:EnableMouse(true)
    mapPin:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
      GameTooltip:SetText(self.label or "")
      GameTooltip:Show()
    end)
    mapPin:SetScript("OnLeave", function() GameTooltip:Hide() end)
    if hooksecurefunc and WorldMapFrame.OnMapChanged then
      hooksecurefunc(WorldMapFrame, "OnMapChanged", function(frame)
        if mapPin.map and frame:GetMapID() ~= mapPin.map then mapPin:Hide() elseif mapPin.map then mapPin:Show() end
      end)
    end
  end
  mapPin:SetParent(canvas)
  mapPin:SetFrameLevel(canvas:GetFrameLevel() + 50)
  mapPin.map, mapPin.label = map, label
  mapPin:ClearAllPoints()
  mapPin:SetPoint("CENTER", canvas, "TOPLEFT", x * canvas:GetWidth(), -y * canvas:GetHeight())
  mapPin:Show()
  return true
end

function J:ShowPoint(p)
  if not p or not p.map or not p.x then return nil end
  local label = (p.name or "") .. (p.zone and (" · " .. p.zone) or "")
  if TomTom and TomTom.AddWaypoint then
    call(TomTom.AddWaypoint, TomTom, p.map, p.x, p.y, { title = label, persistent = false })
    return "tomtom"
  end
  if C_Map and C_Map.CanSetUserWaypointOnMap and call(C_Map.CanSetUserWaypointOnMap, p.map)
    and UiMapPoint and UiMapPoint.CreateFromCoordinates then
    local point = call(UiMapPoint.CreateFromCoordinates, p.map, p.x, p.y)
    if point and call(C_Map.SetUserWaypoint, point) ~= false then
      if C_SuperTrack then call(C_SuperTrack.SetSuperTrackedUserWaypoint, true) end
      WorldMapPin(p.map, p.x, p.y, label)
      return "waypoint"
    end
  end
  if WorldMapPin(p.map, p.x, p.y, label) then return "carte" end
  return nil
end

local refresh = CreateFrame("Frame")
refresh:Hide()
refresh:SetScript("OnUpdate", function(self)
  self:Hide()
  if AF.DungeonsTab and AF.DungeonsTab.OnJournalData then AF.DungeonsTab:OnJournalData() end
end)

local events = CreateFrame("Frame")
for _, ev in ipairs({ "PLAYER_LOGIN", "ITEM_DATA_LOAD_RESULT", "GET_ITEM_INFO_RECEIVED", "QUEST_DATA_LOAD_RESULT", "QUEST_LOG_UPDATE", "QUEST_TURNED_IN", "QUEST_ACCEPTED", "QUEST_REMOVED" }) do
  pcall(events.RegisterEvent, events, ev)
end
events:SetScript("OnEvent", function(_, event, id, success)
  if event == "QUEST_TURNED_IN" then J:MarkDone(id) end
  if event == "PLAYER_LOGIN" or (event == "QUEST_LOG_UPDATE" and not bulkDone) then J:LoadCompleted() end
  if event == "ITEM_DATA_LOAD_RESULT" and id then
    if success == false then J.missingItems[id] = true else J.missingItems[id] = nil end
    itemCache[id] = nil
  end
  if event == "GET_ITEM_INFO_RECEIVED" and id and itemCache[id] then itemCache[id] = nil end
  if event == "QUEST_DATA_LOAD_RESULT" and id then
    titleCache[id] = nil
    missing[id] = (success == false) or nil
  end
  refresh:Show()
end)
