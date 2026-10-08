-- (c) Poulpix, Azeroth Forever. All rights reserved. Text and data mining and AI training prohibited (noai, noimageai, EU Directive 2019/790 art. 4). See LICENSE.md.
local ADDON_NAME, AF = ...

local Audit = {}
AF.Audit = Audit
local L, Lf = AF.L, AF.Lf

local function call(fn, ...)
  if type(fn) ~= "function" then return nil end
  local r = { pcall(fn, ...) }
  if not r[1] then return nil end
  return unpack(r, 2)
end

local function has(path)
  local t = _G
  for part in path:gmatch("[^%.]+") do
    if type(t) ~= "table" then return false end
    t = t[part]
  end
  return t ~= nil
end

local function Apis()
  local names = {
    "EJ_GetNumTiers", "EJ_SelectTier", "EJ_GetInstanceByIndex", "EJ_SelectInstance", "EJ_GetInstanceInfo",
    "EJ_GetEncounterInfoByIndex", "EJ_GetCreatureInfo", "EJ_SelectEncounter", "EJ_GetNumLoot",
    "EJ_GetLootInfoByIndex", "EJ_SetLootFilter", "EJ_SetDifficulty",
    "C_EncounterJournal.GetLootInfoByIndex", "C_EncounterJournal.GetEncountersOnMap",
    "C_EncounterJournal.GetDungeonEntrancesForMap", "C_EncounterJournal.SetSlotFilter",
    "C_Map.GetMapInfo", "C_Map.GetMapArtLayers", "C_Map.GetMapArtLayerTextures", "C_Map.GetMapGroupID",
    "C_Map.GetMapGroupMembersInfo", "C_Map.SetUserWaypoint", "C_Map.CanSetUserWaypointOnMap",
    "C_Map.OpenWorldMap", "C_SuperTrack.SetSuperTrackedUserWaypoint", "UiMapPoint.CreateFromCoordinates",
    "C_QuestLog.RequestLoadQuestByID", "C_QuestLog.GetTitleForQuestID", "C_QuestLog.IsQuestFlaggedCompleted",
    "C_QuestLog.GetLogIndexForQuestID", "C_QuestLog.IsOnQuest", "C_QuestLog.GetQuestObjectives",
    "C_Item.GetItemInfo", "C_Item.RequestLoadItemDataByID", "C_Item.GetItemStatDelta", "C_Item.GetItemQualityByID",
    "C_TooltipInfo.GetItemByID", "GameTooltip.SetItemByID", "GameTooltip.SetHyperlink", "GameTooltip_ShowCompareItem",
    "HandleModifiedItemClick", "ChatEdit_InsertLink", "SetPortraitTextureFromCreatureDisplayID",
    "WorldMapFrame.GetCanvas", "C_Timer.After", "TomTom", "HandyNotes"
  }
  local out = {}
  for _, n in ipairs(names) do out[n] = has(n) end
  out.userWaypointElwynn = call(C_Map and C_Map.CanSetUserWaypointOnMap, 1429)
  return out
end

local function LootOf(encounterID)
  local items = {}
  call(EJ_SelectEncounter, encounterID)
  local n = call(EJ_GetNumLoot) or 0
  for i = 1, n do
    local info = C_EncounterJournal and call(C_EncounterJournal.GetLootInfoByIndex, i)
    if type(info) == "table" then
      items[#items + 1] = { id = info.itemID, name = info.name, q = info.itemQuality, slot = info.slot, armor = info.armorType }
    else
      local itemID, _, name, _, slot, armor = call(EJ_GetLootInfoByIndex, i)
      if itemID then items[#items + 1] = { id = itemID, name = name, slot = slot, armor = armor } end
    end
  end
  return items
end

local function MapFloors(mapID)
  local floors = { mapID }
  local group = call(C_Map and C_Map.GetMapGroupID, mapID)
  local members = group and call(C_Map.GetMapGroupMembersInfo, group)
  if type(members) == "table" and #members > 0 then
    floors = {}
    for _, m in ipairs(members) do floors[#floors + 1] = m.mapID end
  end
  return floors
end

local function LoadEJ()
  local loaded = call(C_AddOns and C_AddOns.IsAddOnLoaded or IsAddOnLoaded, "Blizzard_EncounterJournal")
  if not loaded then call(C_AddOns and C_AddOns.LoadAddOn or LoadAddOn, "Blizzard_EncounterJournal") end
  return call(C_AddOns and C_AddOns.IsAddOnLoaded or IsAddOnLoaded, "Blizzard_EncounterJournal")
end

local function Journal()
  local out = { tiers = {} }
  if not has("EJ_GetInstanceByIndex") then return out end
  out.addonLoaded = LoadEJ()
  call(EJ_SetLootFilter, 0, 0)
  if Enum and Enum.ItemSlotFilterType then call(C_EncounterJournal and C_EncounterJournal.SetSlotFilter, Enum.ItemSlotFilterType.NoFilter) end
  out.numTiers = call(EJ_GetNumTiers)
  for tier = 1, math.max(out.numTiers or 0, 1) do
    if (out.numTiers or 0) > 0 then call(EJ_SelectTier, tier) end
    local t = { tier = tier, instances = {} }
    for _, isRaid in ipairs({ false, true }) do
      for index = 1, 100 do
        local instanceID, name = call(EJ_GetInstanceByIndex, index, isRaid)
        if not instanceID then break end
        call(EJ_SelectInstance, instanceID)
        local _, _, _, _, _, _, areaMapID, _, _, mapID = call(EJ_GetInstanceInfo, instanceID)
        local inst = { id = instanceID, name = name, raid = isRaid, areaMapID = areaMapID, mapID = mapID, encounters = {}, floors = {} }
        for e = 1, 40 do
          local ename, _, encounterID, _, _, _, dungeonEncounterID = call(EJ_GetEncounterInfoByIndex, e, instanceID)
          if not ename then ename, _, encounterID, _, _, _, dungeonEncounterID = call(EJ_GetEncounterInfoByIndex, e) end
          if not ename then break end
          local creatureID, cname, _, displayInfo, iconImage = call(EJ_GetCreatureInfo, 1, encounterID)
          inst.encounters[#inst.encounters + 1] = {
            name = ename, id = encounterID, dungeonEncounterID = dungeonEncounterID,
            creatureID = creatureID, creatureName = cname, displayInfo = displayInfo, icon = iconImage,
            loot = LootOf(encounterID)
          }
        end
        if areaMapID and areaMapID > 0 then
          for _, floor in ipairs(MapFloors(areaMapID)) do
            local info = call(C_Map.GetMapInfo, floor)
            local layers = call(C_Map.GetMapArtLayers, floor)
            local pins = {}
            local onMap = call(C_EncounterJournal and C_EncounterJournal.GetEncountersOnMap, floor)
            for _, p in ipairs(type(onMap) == "table" and onMap or {}) do
              pins[#pins + 1] = { enc = p.encounterID, x = p.mapX, y = p.mapY }
            end
            inst.floors[#inst.floors + 1] = { mapID = floor, name = info and info.name, layers = type(layers) == "table" and #layers or 0, pins = pins }
          end
        end
        t.instances[#t.instances + 1] = inst
      end
    end
    out.tiers[#out.tiers + 1] = t
  end
  return out
end

local function Maps()
  local out = {}
  if not has("C_Map.GetMapInfo") then return out end
  for id = 1, 2600 do
    local info = call(C_Map.GetMapInfo, id)
    if type(info) == "table" and info.name and info.name ~= "" then
      out[#out + 1] = { id = id, name = info.name, type = info.mapType, parent = info.parentMapID }
    end
  end
  return out
end

local function Entrances(maps)
  local out = {}
  if not has("C_EncounterJournal.GetDungeonEntrancesForMap") then return out end
  for _, m in ipairs(maps) do
    if m.type == 3 then
      local list = call(C_EncounterJournal.GetDungeonEntrancesForMap, m.id)
      for _, e in ipairs(type(list) == "table" and list or {}) do
        out[#out + 1] = { mapID = m.id, instance = e.journalInstanceID, name = e.name,
          x = e.position and e.position.x, y = e.position and e.position.y }
      end
    end
  end
  return out
end

local function QuestIDs()
  local ids, seen = {}, {}
  local function add(id) if id and not seen[id] then seen[id] = true; ids[#ids + 1] = id end end
  local pack = AF.Data.Journal or {}
  for _, inst in ipairs((AF.Data.Instances and AF.Data.Instances.list) or {}) do
    for _, q in ipairs(inst.quests or {}) do add(q.id) end
    local p = pack.instances and pack.instances[inst.id]
    for _, id in pairs(p and p.fixIds or {}) do add(id) end
  end
  for id in pairs(pack.steps or {}) do add(id) end
  return ids
end

local answers, itemAnswers = {}, {}

local function ReadQuests(ids)
  local out = {}
  for _, id in ipairs(ids) do
    out[id] = {
      ok = answers[id],
      title = call(C_QuestLog and C_QuestLog.GetTitleForQuestID, id),
      done = call(C_QuestLog and C_QuestLog.IsQuestFlaggedCompleted, id),
      log = call(C_QuestLog and C_QuestLog.GetLogIndexForQuestID, id)
    }
  end
  return out
end

local function ItemIDs()
  local ids, seen = {}, {}
  local function add(id) if id and not seen[id] then seen[id] = true; ids[#ids + 1] = id end end
  for _, inst in pairs((AF.Data.Journal and AF.Data.Journal.instances) or {}) do
    for _, b in ipairs(inst.bosses or {}) do for _, id in ipairs(b.loot or {}) do add(id) end end
    for _, list in pairs(inst.lootByNpc or {}) do for _, id in ipairs(list) do add(id) end end
    for _, q in pairs(inst.quests or {}) do for _, id in ipairs(q.rewards or {}) do add(id) end end
  end
  return ids
end

local function getItem(id)
  local fn = (C_Item and C_Item.GetItemInfo) or GetItemInfo
  if fn then return fn(id) end
end

local function ReadItems(ids)
  local out = {}
  for _, id in ipairs(ids) do
    local name, _, quality, ilvl, req, _, _, _, loc = call(getItem, id)
    out[id] = { ok = itemAnswers[id], name = name, q = quality, ilvl = ilvl, req = req, loc = loc }
  end
  return out
end

local listener = CreateFrame("Frame")
listener:SetScript("OnEvent", function(_, event, id, success)
  if not id then return end
  if event == "QUEST_DATA_LOAD_RESULT" then answers[id] = success and true or false
  else itemAnswers[id] = success ~= false end
end)

local function after(delay, fn)
  if C_Timer and C_Timer.After then C_Timer.After(delay, fn) else fn() end
end

local function Paced(ids, perTick, maxTime, request, answered, done)
  local index, elapsed = 1, 0
  local function step()
    for _ = 1, perTick do
      local id = ids[index]
      if not id then break end
      if not answered(id) then request(id) end
      index = index + 1
    end
    elapsed = elapsed + 0.5
    if index > #ids then
      local left = 0
      for _, id in ipairs(ids) do if not answered(id) then left = left + 1 end end
      if left == 0 or elapsed >= maxTime then return done() end
      if elapsed % 15 == 0 then index = 1 end
    end
    after(0.5, step)
  end
  step()
end

local function Finish(self, ids, items)
  listener:UnregisterAllEvents()
  local maps = Maps()
  local build, _, _, iface = GetBuildInfo()
  local journal = Journal()
  AzerothForeverDB.releve = {
    build = build, interface = iface,
    faction = UnitFactionGroup and UnitFactionGroup("player"), level = UnitLevel and UnitLevel("player"),
    apis = Apis(), journal = journal, maps = maps, entrances = Entrances(maps), quests = ReadQuests(ids),
    items = ReadItems(items)
  }
  local nQ, nT, nNo = 0, 0, 0
  for _, q in pairs(AzerothForeverDB.releve.quests) do
    nQ = nQ + 1
    if q.title and q.title ~= "" then nT = nT + 1 end
    if q.ok == false then nNo = nNo + 1 end
  end
  local nOk, nMissing = 0, 0
  for _, it in pairs(AzerothForeverDB.releve.items) do
    if it.name then nOk = nOk + 1 elseif it.ok == false then nMissing = nMissing + 1 end
  end
  local nI = 0
  for _, t in ipairs(journal.tiers) do nI = nI + #t.instances end
  self.running = false
  AF:Print(Lf("audit.done", nT, nQ, nNo, nOk, #items, nMissing, nI))
end

function Audit:Run()
  if self.running then AF:Print(L["audit.running"]) return end
  self.running = true
  local ids, items = QuestIDs(), ItemIDs()
  AF:Print(Lf("audit.started", #ids, #items))
  pcall(listener.RegisterEvent, listener, "QUEST_DATA_LOAD_RESULT")
  pcall(listener.RegisterEvent, listener, "GET_ITEM_INFO_RECEIVED")
  Paced(ids, 10, 90,
    function(id) call(C_QuestLog and C_QuestLog.RequestLoadQuestByID, id) end,
    function(id) return answers[id] ~= nil or call(C_QuestLog and C_QuestLog.GetTitleForQuestID, id) ~= nil end,
    function()
      Paced(items, 20, 90,
        function(id)
          if C_Item and C_Item.RequestLoadItemDataByID then call(C_Item.RequestLoadItemDataByID, id) else call(getItem, id) end
        end,
        function(id) return itemAnswers[id] ~= nil or call(getItem, id) ~= nil end,
        function() Finish(self, ids, items) end)
    end)
end

local Loot = CreateFrame("Frame")

local function NpcID(guid)
  if type(guid) ~= "string" then return nil end
  local kind, _, _, _, _, id = strsplit("-", guid)
  if kind == "Creature" or kind == "Vehicle" then return tonumber(id) end
end

local function ItemIDFromLink(link)
  return link and tonumber(link:match("item:(%d+)"))
end

local function InDungeon()
  local _, kind = call(IsInInstance)
  return kind == "party" or kind == "raid"
end

local function Entry(npc, name)
  local db = AzerothForeverDB.butin or {}
  AzerothForeverDB.butin = db
  local name_, _, _, _, _, _, _, instanceID = call(GetInstanceInfo)
  local e = db[npc]
  if not e then
    e = { items = {}, kills = 0 }
    db[npc] = e
  end
  e.name = name or e.name
  e.instance = name_ or e.instance
  e.instanceID = instanceID or e.instanceID
  return e
end

local function OnLootOpened()
  if not InDungeon() then return end
  local n = call(GetNumLootItems) or 0
  local counted = {}
  local targetGUID = call(UnitGUID, "target")
  for slot = 1, n do
    local _, _, _, _, quality = call(GetLootSlotInfo, slot)
    local itemID = ItemIDFromLink(call(GetLootSlotLink, slot))
    if itemID and (quality or 0) >= 2 then
      local guid = call(GetLootSourceInfo, slot)
      local npc = NpcID(guid)
      if npc then
        local e = Entry(npc, guid == targetGUID and call(UnitName, "target") or nil)
        if not counted[guid] then counted[guid] = true; e.kills = e.kills + 1 end
        e.items[itemID] = (e.items[itemID] or 0) + 1
      end
    end
  end
end

local function OnEncounter(event, encounterID, name, _, _, success)
  if not encounterID or not InDungeon() then return end
  local db = AzerothForeverDB.rencontres or {}
  AzerothForeverDB.rencontres = db
  local e = db[encounterID] or { kills = 0 }
  db[encounterID] = e
  e.name = name or e.name
  e.instance = call(GetInstanceInfo) or e.instance
  if call(UnitExists, "boss1") then
    e.npc = NpcID(call(UnitGUID, "boss1")) or e.npc
    local level = call(UnitLevel, "boss1")
    if level and level > 0 then e.level = level end
  end
  if event == "ENCOUNTER_END" and success == 1 then e.kills = e.kills + 1 end
end

local function OnForbidden(addon, fn)
  if addon ~= ADDON_NAME then return end
  local db = AzerothForeverDB.bloque or {}
  AzerothForeverDB.bloque = db
  db[#db + 1] = { fn = tostring(fn), when = call(date, "%d/%m %H:%M") }
  while #db > 10 do table.remove(db, 1) end
  AF:Print(Lf("audit.forbidden", tostring(fn)))
end

Loot:SetScript("OnEvent", function(_, event, ...)
  if event == "LOOT_OPENED" then
    OnLootOpened()
  elseif event == "ENCOUNTER_START" or event == "ENCOUNTER_END" then
    OnEncounter(event, ...)
  elseif event == "ADDON_ACTION_FORBIDDEN" or event == "ADDON_ACTION_BLOCKED" then
    OnForbidden(...)
  end
end)
for _, ev in ipairs({ "LOOT_OPENED", "ENCOUNTER_START", "ENCOUNTER_END", "ADDON_ACTION_FORBIDDEN", "ADDON_ACTION_BLOCKED" }) do
  pcall(Loot.RegisterEvent, Loot, ev)
end

function Audit:LootSummary()
  local nNpc, nItems = 0, 0
  for _, e in pairs(AzerothForeverDB.butin or {}) do
    nNpc = nNpc + 1
    for _ in pairs(e.items) do nItems = nItems + 1 end
  end
  local nEnc = 0
  for _ in pairs(AzerothForeverDB.rencontres or {}) do nEnc = nEnc + 1 end
  AF:Print(Lf("audit.loot_summary", nEnc, nItems, nNpc))
end
