-- (c) Poulpix, Azeroth Forever. All rights reserved. Text and data mining and AI training prohibited (noai, noimageai, EU Directive 2019/790 art. 4). See LICENSE.md.
local ADDON_NAME, AF = ...

local BP = {}
AF.BuildPath = BP
local L, Lf, Lp = AF.L, AF.Lf, AF.Lp
local N = AF.Names

local C = AF.Data.Constants
local ALPHABET = C.ALPHABET
local PATH_VERSION = C.PATH_VERSION
local MAX_POINTS = C.MAX_POINTS
local MAX_LEVEL = C.MAX_LEVEL
local TALENTED_KNOWN_MAX = C.TALENTED_KNOWN_MAX
local TALENTED_MAX_STORED = C.TALENTED_MAX_STORED

local ALPHABET_INDEX = {}
for i = 1, #ALPHABET do
  ALPHABET_INDEX[ALPHABET:sub(i, i)] = i - 1
end

function BP.catalog(cls)
  local entries = {}
  local byId = {}
  for treeIdx, tree in ipairs(cls.trees) do
    for talentIdx, talent in ipairs(tree.talents) do
      local entry = {
        index = #entries,
        treeIdx = treeIdx,
        talentIdx = talentIdx,
        tree = tree,
        talent = talent
      }
      entries[#entries + 1] = entry
      byId[talent.id] = entry
    end
  end
  if #entries > #ALPHABET then
    error("Catalogue too large for ?path= : " .. #entries .. " talents")
  end
  return { cls = cls, entries = entries, byId = byId }
end

function BP.emptyRanks(cat)
  local ranks = {}
  for _, e in ipairs(cat.entries) do ranks[e.talent.id] = 0 end
  return ranks
end

function BP.serializeBuild(cat, ranks)
  local blocks = {}
  for _, tree in ipairs(cat.cls.trees) do
    local chars = {}
    for _, t in ipairs(tree.talents) do
      chars[#chars + 1] = tostring(ranks[t.id] or 0)
    end
    blocks[#blocks + 1] = table.concat(chars)
  end
  return table.concat(blocks, "-")
end

function BP.totalOf(ranks)
  local sum = 0
  for _, v in pairs(ranks) do sum = sum + (v or 0) end
  return sum
end

function BP.effectiveTalented(talented)
  local t = tonumber(talented) or 0
  return math.max(0, math.min(TALENTED_KNOWN_MAX, t))
end

function BP.firstLevel(talented)
  return 10 - BP.effectiveTalented(talented)
end

function BP.pointsAvailable(level, talented)
  local lvl = tonumber(level) or 0
  local pts = lvl - (BP.firstLevel(talented) - 1)
  return math.max(0, math.min(MAX_POINTS, pts))
end

function BP.levelOfPoint(n, talented)
  return math.min(MAX_LEVEL, BP.firstLevel(talented) - 1 + n)
end

function BP.encodePath(cat, order, talented)
  local t = math.max(0, math.min(TALENTED_MAX_STORED, tonumber(talented) or 0))
  local chars = { PATH_VERSION, tostring(t) }
  for _, idx in ipairs(order) do
    chars[#chars + 1] = ALPHABET:sub(idx + 1, idx + 1)
  end
  return table.concat(chars)
end

function BP.decodePath(cat, str)
  local result = { ok = false, talented = 0, order = {}, error = "" }
  if type(str) ~= "string" or #str < 2 then
    result.error = L["path.err.empty"]
    return result
  end
  if str:sub(1, 1) ~= PATH_VERSION then
    result.error = L["path.err.version"]
    return result
  end
  local t = str:sub(2, 2)
  if not t:match("^[0-7]$") then
    result.error = L["path.err.header"]
    return result
  end
  result.talented = tonumber(t)
  local body = str:sub(3)
  if #body > MAX_POINTS then
    result.error = Lf("path.err.too_long", MAX_POINTS)
    return result
  end
  for i = 1, #body do
    local ch = body:sub(i, i)
    local idx = ALPHABET_INDEX[ch]
    if idx == nil or idx >= #cat.entries then
      result.error = L["path.err.char"]
      result.order = {}
      return result
    end
    result.order[#result.order + 1] = idx
  end
  result.ok = true
  return result
end

local function tierNeeded(talent)
  return 5 * talent.row
end

local function findInTree(tree, id)
  for _, t in ipairs(tree.talents) do
    if t.id == id then return t end
  end
  return nil
end

function BP.checkStep(cat, entry, ranks, treePts, total)
  if not entry then
    return { ok = false, code = "unknown", message = L["path.err.unknown_talent"] }
  end
  local talent = entry.talent
  local current = ranks[talent.id] or 0
  if current >= talent.maxRank then
    return { ok = false, code = "maxed", message = Lf("path.err.maxed", N:TalentName(talent), talent.maxRank) }
  end
  if total >= MAX_POINTS then
    return { ok = false, code = "cap", message = Lf("path.err.cap", MAX_POINTS) }
  end
  for _, req in ipairs(talent.requires or {}) do
    if (ranks[req.id] or 0) < req.qty then
      local reqTalent = findInTree(entry.tree, req.id)
      return {
        ok = false,
        code = "prereq",
        message = Lf("path.err.prereq", N:TalentName(talent), reqTalent and N:TalentName(reqTalent) or L["path.err.other_talent"], req.qty)
      }
    end
  end
  local need = tierNeeded(talent)
  local have = treePts[entry.treeIdx] or 0
  if have < need then
    return {
      ok = false,
      code = "tier",
      message = Lf("path.err.tier", N:TalentName(talent), need, N:TreeName(entry.tree), have)
    }
  end
  return { ok = true }
end

function BP.validateOrder(cat, order)
  local ranks = BP.emptyRanks(cat)
  local treePts = {}
  for i = 1, #cat.cls.trees do treePts[i] = 0 end
  local total = 0
  for i, idx in ipairs(order) do
    local entry = cat.entries[idx + 1]
    local check = BP.checkStep(cat, entry, ranks, treePts, total)
    if not check.ok then
      return { ok = false, step = i - 1, code = check.code, message = check.message, level = i }
    end
    ranks[entry.talent.id] = ranks[entry.talent.id] + 1
    treePts[entry.treeIdx] = treePts[entry.treeIdx] + 1
    total = total + 1
  end
  return { ok = true, step = -1 }
end

function BP.ranksFromOrder(cat, order, count)
  local ranks = BP.emptyRanks(cat)
  local n = count
  if n == nil or n > #order then n = #order end
  if n < 0 then n = 0 end
  for i = 1, n do
    local entry = cat.entries[order[i] + 1]
    if entry then ranks[entry.talent.id] = ranks[entry.talent.id] + 1 end
  end
  return ranks
end

function BP.autoOrder(cat, ranks)
  local order = {}
  local placed = {}

  local function place(entry, guard)
    local talent = entry.talent
    if placed[talent.id] or guard[talent.id] then return end
    local target = ranks[talent.id] or 0
    if target <= 0 then return end
    guard[talent.id] = true
    for _, req in ipairs(talent.requires or {}) do
      local reqEntry = cat.byId[req.id]
      if reqEntry and reqEntry.treeIdx == entry.treeIdx then place(reqEntry, guard) end
    end
    placed[talent.id] = true
    for _ = 1, target do order[#order + 1] = entry.index end
  end

  for _, entry in ipairs(cat.entries) do place(entry, {}) end
  return order
end

function BP.append(cat, order, index)
  local entry = cat.entries[index + 1]
  local ranks = BP.ranksFromOrder(cat, order)
  local treePts = {}
  for i = 1, #cat.cls.trees do treePts[i] = 0 end
  for _, idx in ipairs(order) do
    local e = cat.entries[idx + 1]
    treePts[e.treeIdx] = treePts[e.treeIdx] + 1
  end
  local check = BP.checkStep(cat, entry, ranks, treePts, #order)
  if not check.ok then
    return { ok = false, order = order, code = check.code, message = check.message }
  end
  local next_ = {}
  for _, v in ipairs(order) do next_[#next_ + 1] = v end
  next_[#next_ + 1] = index
  return { ok = true, order = next_ }
end

local function lowerFirst(s)
  if not s or s == "" then return s end
  return s:sub(1, 1):lower() .. s:sub(2)
end

function BP.removeLastOf(cat, order, index)
  local pos = nil
  for i = #order, 1, -1 do
    if order[i] == index then pos = i; break end
  end
  if not pos then
    return { ok = false, order = order, code = "empty", message = "" }
  end
  local next_ = {}
  for i, v in ipairs(order) do
    if i ~= pos then next_[#next_ + 1] = v end
  end
  local wasValid = BP.validateOrder(cat, order).ok
  local check = BP.validateOrder(cat, next_)
  if wasValid and not check.ok then
    local talent = cat.entries[index + 1].talent
    return {
      ok = false,
      order = order,
      code = check.code,
      message = Lf("path.err.cannot_remove", N:TalentName(talent), lowerFirst(check.message))
    }
  end
  return { ok = true, order = next_ }
end

function BP.withoutTree(cat, order, treeIdx)
  local out = {}
  for _, idx in ipairs(order) do
    if cat.entries[idx + 1].treeIdx ~= treeIdx then out[#out + 1] = idx end
  end
  return out
end

function BP.steps(cat, order, talented)
  local ranks = BP.emptyRanks(cat)
  local out = {}
  for i, idx in ipairs(order) do
    local entry = cat.entries[idx + 1]
    ranks[entry.talent.id] = ranks[entry.talent.id] + 1
    out[#out + 1] = {
      n = i,
      level = BP.levelOfPoint(i, talented),
      treeIdx = entry.treeIdx,
      treeName = N:TreeName(entry.tree),
      talentId = entry.talent.id,
      talentName = N:TalentName(entry.talent),
      rank = ranks[entry.talent.id],
      maxRank = entry.talent.maxRank
    }
  end
  return out
end

local Talents = {}
AF.Talents = Talents

local catalogCache = {}

function Talents:GetCatalog(classId)
  if not catalogCache[classId] then
    local cls = AF:GetClassData(classId)
    if cls then catalogCache[classId] = BP.catalog(cls) end
  end
  return catalogCache[classId]
end

function Talents:GetPlan(classId)
  return AF:GetPlanFor(classId)
end

function Talents:GetPlannedRanks(classId)
  local cat = self:GetCatalog(classId)
  local plan = self:GetPlan(classId)
  if not cat then return {} end
  return BP.ranksFromOrder(cat, plan.order)
end

function Talents:GetMode()
  local mode = AzerothForeverDB and AzerothForeverDB.options and AzerothForeverDB.options.mode
  if mode == "path" or mode == "levelByLevel" then return "path" end
  return "final"
end

function Talents:SetMode(mode)
  AzerothForeverDB.options.mode = mode
end

function Talents:SetFinalRank(classId, index, newRank)
  local cat = self:GetCatalog(classId)
  if not cat then return false, L["talents.err.class_unknown"] end
  local plan = self:GetPlan(classId)
  local ranks = BP.ranksFromOrder(cat, plan.order)
  local entry = cat.entries[index + 1]
  if not entry then return false, L["talents.err.talent_unknown"] end
  newRank = math.max(0, math.min(entry.talent.maxRank, newRank))
  ranks[entry.talent.id] = newRank
  local newOrder = BP.autoOrder(cat, ranks)
  local check = BP.validateOrder(cat, newOrder)
  if not check.ok then
    return false, check.message
  end
  plan.order = newOrder
  return true
end

function Talents:AppendPoint(classId, index)
  local cat = self:GetCatalog(classId)
  if not cat then return false, L["talents.err.class_unknown"] end
  local plan = self:GetPlan(classId)
  local res = BP.append(cat, plan.order, index)
  if not res.ok then return false, res.message end
  plan.order = res.order
  return true
end

function Talents:RemoveLastPoint(classId, index)
  local cat = self:GetCatalog(classId)
  if not cat then return false, L["talents.err.class_unknown"] end
  local plan = self:GetPlan(classId)
  local res = BP.removeLastOf(cat, plan.order, index)
  if not res.ok then return false, res.message end
  plan.order = res.order
  return true
end

function Talents:ResetPlan(classId)
  local plan = self:GetPlan(classId)
  plan.order = {}
  plan.talented = 0
end

function Talents:ResetTree(classId, treeIdx)
  local cat = self:GetCatalog(classId)
  if not cat then return false end
  local plan = self:GetPlan(classId)
  plan.order = BP.withoutTree(cat, plan.order, treeIdx)
  return true
end

function Talents:LoadOrder(classId, order, talented)
  local plan = self:GetPlan(classId)
  plan.order = order
  plan.talented = talented or 0
end

local function norm(s)
  return (tostring(s or ""):lower():gsub("[%s%p]", ""))
end

local function Debug(msg)
  if AF.debugMode then AF:Print("[debug] " .. msg) end
end

local function Notify(msg, isError)
  if AF.UI and AF.UI.frame and AF.UI.frame:IsShown() then
    AF.Widgets.Toast(msg, isError)
  else
    AF:Print(msg)
  end
end

local function HasTraits()
  return type(C_ClassTalents) == "table" and type(C_Traits) == "table" and C_ClassTalents.GetActiveConfigID ~= nil
end

local function ActiveConfig()
  if not HasTraits() then return nil end
  local ok, configID = pcall(C_ClassTalents.GetActiveConfigID)
  if not ok or not configID then return nil end
  local info = C_Traits.GetConfigInfo(configID)
  return configID, info and info.treeIDs and info.treeIDs[1]
end

local function NodeInfo(configID, nodeID)
  local ok, node = pcall(C_Traits.GetNodeInfo, configID, nodeID)
  if ok and type(node) == "table" and node.ID and node.ID ~= 0 then return node end
  return nil
end

local function NodeSpellName(configID, node)
  local entryID = node.activeEntry and node.activeEntry.entryID or (node.entryIDs and node.entryIDs[1])
  local entry = entryID and C_Traits.GetEntryInfo(configID, entryID)
  local def = entry and entry.definitionID and C_Traits.GetDefinitionInfo(entry.definitionID)
  local spellID = def and def.spellID
  local name = def and def.overrideName
  if spellID and (not name or name == "") then
    if C_Spell and C_Spell.GetSpellName then name = C_Spell.GetSpellName(spellID)
    elseif GetSpellInfo then name = GetSpellInfo(spellID) end
  end
  return spellID, name
end

local function LearnedRank(node)
  return node.activeRank or node.ranksPurchased or node.currentRank or 0
end

local function UnspentPoints()
  local configID, treeID = ActiveConfig()
  if not configID or not treeID or not C_Traits.GetTreeCurrencyInfo then return nil end
  local ok, list = pcall(C_Traits.GetTreeCurrencyInfo, configID, treeID, false)
  local cur = ok and type(list) == "table" and list[1]
  return cur and cur.quantity or nil
end

local gameMaps = {}

function Talents:GetGameMap(classId)
  if not classId or classId ~= AF.classId then return nil end
  if gameMaps[classId] then return gameMaps[classId] end
  local configID, treeID = ActiveConfig()
  local cat = self:GetCatalog(classId)
  if not configID or not treeID or not cat then return nil end
  local byNode, bySpell, byName = {}, {}, {}
  local nodes = C_Traits.GetTreeNodes(treeID) or {}
  for _, nodeID in ipairs(nodes) do
    local node = NodeInfo(configID, nodeID)
    if node then
      byNode[nodeID] = true
      local spellID, name = NodeSpellName(configID, node)
      if spellID then bySpell[spellID] = nodeID end
      if name then byName[norm(name)] = nodeID end
    end
  end
  local map = { byIndex = {}, missing = {}, found = 0, treeID = treeID }
  for _, entry in ipairs(cat.entries) do
    local t = entry.talent
    if not t.removed and (t.maxRank or 0) > 0 then
      local r1 = t.ranks and t.ranks[1]
      local nodeID = (byNode[t.id] and t.id) or (r1 and bySpell[r1.spellId]) or byName[norm(t.name)] or byName[norm(N:TalentName(t))]
      if nodeID then
        map.byIndex[entry.index] = nodeID
        map.found = map.found + 1
      else
        map.missing[#map.missing + 1] = t.name
        Debug("talent missing from client: " .. t.name)
      end
    end
  end
  if #nodes > 0 then gameMaps[classId] = map end
  return map
end

-- Client trait entry and its spell id behind a catalog talent (entry.index). Only the player's own class can be read, nil otherwise.
function Talents:GetTraitEntryID(classId, catalogIndex)
  local map = self:GetGameMap(classId)
  local nodeID = map and map.byIndex[catalogIndex]
  local configID = ActiveConfig()
  local node = nodeID and configID and NodeInfo(configID, nodeID)
  if not node then return nil end
  local entryID = (node.entryIDs and node.entryIDs[1]) or (node.activeEntry and node.activeEntry.entryID)
  local spellID = NodeSpellName(configID, node)
  return entryID, spellID
end

-- Entries of every class tree, found by the spell id behind them (the data rank 1 spell id is the definition spell id).
-- The nodes of another class can be read with the active config (checked with /af diag), only their
-- descriptions need the spell data to be loaded. Built once, on the first use.
local spellIndex
local function BuildSpellIndex()
  local configID = ActiveConfig()
  if not configID or not (C_Traits and C_Traits.GetTreeNodes) then return nil end
  local index, count = {}, 0
  for treeID = 900, 1300 do
    local ok, nodes = pcall(C_Traits.GetTreeNodes, treeID)
    if ok and type(nodes) == "table" and #nodes > 0 then
      for _, nodeID in ipairs(nodes) do
        local node = NodeInfo(configID, nodeID)
        local entryID = node and node.entryIDs and node.entryIDs[1]
        if entryID then
          local entry = C_Traits.GetEntryInfo(configID, entryID)
          local def = entry and entry.definitionID and C_Traits.GetDefinitionInfo(entry.definitionID)
          local spellID = def and def.spellID
          if spellID and not index[spellID] then index[spellID] = entryID; count = count + 1 end
        end
      end
    end
  end
  if count == 0 then return nil end
  return index
end

-- entryID of the client talent whose spell is spellID, any class. Nil when unknown.
function Talents:GetTraitEntryBySpell(spellID)
  if not spellID or spellID <= 0 then return nil end
  if not spellIndex then
    local ok, index = pcall(BuildSpellIndex)
    spellIndex = ok and index or nil
  end
  return spellIndex and spellIndex[spellID] or nil
end

function Talents:GetActualRanks(classId, staged)
  local cat = self:GetCatalog(classId)
  local map = self:GetGameMap(classId)
  local configID = ActiveConfig()
  if not cat or not map or not configID then return nil end
  local ranks = BP.emptyRanks(cat)
  for _, entry in ipairs(cat.entries) do
    local nodeID = map.byIndex[entry.index]
    local node = nodeID and NodeInfo(configID, nodeID)
    if node then
      ranks[entry.talent.id] = staged and (node.currentRank or LearnedRank(node)) or LearnedRank(node)
    end
  end
  return ranks
end

function Talents:NextPendingStep(classId)
  local cat = self:GetCatalog(classId)
  local actual = self:GetActualRanks(classId, true)
  if not cat or not actual then return nil, L["apply.err.unreadable"] end
  local map = self:GetGameMap(classId)
  local configID = ActiveConfig()
  local plan = self:GetPlan(classId)
  local seen, pending, blocked = {}, 0, nil
  for _, idx in ipairs(plan.order) do
    local entry = cat.entries[idx + 1]
    local id = entry.talent.id
    seen[id] = (seen[id] or 0) + 1
    if seen[id] > (actual[id] or 0) then
      pending = pending + 1
      local nodeID = map.byIndex[entry.index]
      local node = nodeID and NodeInfo(configID, nodeID)
      if not node then
        blocked = blocked or Lf("apply.err.not_found", N:TalentName(entry.talent))
      elseif node.canPurchaseRank then
        return entry
      else
        blocked = blocked or Lf("apply.err.not_learnable", N:TalentName(entry.talent))
      end
    end
  end
  if pending == 0 then return nil, L["apply.info.nothing_to_apply_learned"], true end
  return nil, blocked
end

function Talents:SyncPlanFromGame(classId)
  local cat = self:GetCatalog(classId)
  local ranks = self:GetActualRanks(classId)
  if not cat or not ranks then return false, L["apply.err.unreadable"] end
  local plan = self:GetPlan(classId)
  plan.order = BP.autoOrder(cat, ranks)
  return true, BP.totalOf(ranks)
end

function Talents:CanUnlearn()
  local configID, treeID = ActiveConfig()
  if configID and treeID then
    local info = C_Traits.GetTreeInfo(configID, treeID)
    if info and not info.cannotRefund and C_Traits.RefundRank then return true end
  end
  return false, L["apply.err.cannot_unlearn"]
end

local function CanChange()
  if C_ClassTalents.CanChangeTalents then
    local ok, can, _, err = pcall(C_ClassTalents.CanChangeTalents)
    if ok and can == false then return false, err end
  end
  if InCombatLockdown and InCombatLockdown() then return false, L["apply.err.combat"] end
  return true
end

local function Commit(configID)
  if C_ClassTalents.CommitConfig then
    local ok, res = pcall(C_ClassTalents.CommitConfig)
    if ok and res ~= false then return true end
  end
  local ok, res = pcall(C_Traits.CommitConfig, configID)
  return ok and res ~= false
end

local waitFrame = CreateFrame("Frame")
waitFrame:Hide()
waitFrame:SetScript("OnUpdate", function(self, elapsed)
  self.t = (self.t or 0) + elapsed
  if self.t > 5 then
    self:Hide()
    Talents:OnLearnTimeout()
  end
end)

function Talents:StopApply(msg, isError, silent)
  if msg and not silent then Notify(msg, isError) end
  return false
end

function Talents:Apply(all, mode)
  local classId = AF.classId
  if not classId or self.awaiting then return false end
  local silent = mode == "auto"
  local configID = ActiveConfig()
  if not configID then return self:StopApply(L["apply.err.unreadable"], true, silent) end
  local can, err = CanChange()
  if not can then return self:StopApply(err or L["apply.err.locked"], true, silent) end
  local map = self:GetGameMap(classId)
  local before = self:GetActualRanks(classId) or {}
  local staged, refusal, firstName = 0, nil, nil
  while true do
    local entry, reason, done = self:NextPendingStep(classId)
    if not entry then
      if staged == 0 then
        if not done and (UnspentPoints() or 0) <= 0 then
          return self:StopApply(L["apply.err.no_points"], true, silent)
        end
        return self:StopApply(reason, not done, silent)
      end
      if not done then
        refusal = (UnspentPoints() or 0) > 0 and reason or L["apply.err.no_more_points"]
      end
      break
    end
    local ok, res = pcall(C_Traits.PurchaseRank, configID, map.byIndex[entry.index])
    if not ok or res == false then
      refusal = Lf("apply.err.refused", N:TalentName(entry.talent))
      break
    end
    staged = staged + 1
    firstName = firstName or N:TalentName(entry.talent)
    if not all then break end
  end
  if staged == 0 then
    if C_Traits.RollbackConfig then pcall(C_Traits.RollbackConfig, configID) end
    return self:StopApply(refusal or L["apply.err.nothing"], true, silent)
  end
  if not Commit(configID) then
    if C_Traits.RollbackConfig then pcall(C_Traits.RollbackConfig, configID) end
    return self:StopApply(L["apply.err.not_validated"], true, silent)
  end
  self.awaiting = { before = BP.totalOf(before), count = staged, refusal = refusal, silent = silent, name = firstName }
  waitFrame.t = 0
  waitFrame:Show()
  return true
end

function Talents:ApplyNext(mode) return self:Apply(false, mode) end

function Talents:UndoLast()
  local classId = AF.classId
  local configID = ActiveConfig()
  local cat = self:GetCatalog(classId)
  local actual = self:GetActualRanks(classId)
  if not configID or not cat or not actual or self.awaiting then return false end
  local map = self:GetGameMap(classId)
  local plan = self:GetPlan(classId)
  local seen, last = {}, nil
  for _, idx in ipairs(plan.order) do
    local entry = cat.entries[idx + 1]
    local id = entry.talent.id
    seen[id] = (seen[id] or 0) + 1
    if seen[id] <= (actual[id] or 0) then last = entry end
  end
  if not last then return self:StopApply(L["apply.err.none_learned"], true) end
  local ok, res = pcall(C_Traits.RefundRank, configID, map.byIndex[last.index])
  if not ok or res == false or not Commit(configID) then
    if C_Traits.RollbackConfig then pcall(C_Traits.RollbackConfig, configID) end
    return self:StopApply(Lf("apply.err.refused_remove", N:TalentName(last.talent)), true)
  end
  Notify(Lf("apply.ok.removed", N:TalentName(last.talent)))
  return true
end
function Talents:ApplyAll() return self:Apply(true) end

function Talents:OnLearnTimeout()
  local w = self.awaiting
  self.awaiting = nil
  if w and not w.silent then Notify(L["apply.err.timeout"], true) end
end

function Talents:OnLevelUp()
  self.autoPending = true
  if (UnspentPoints() or 0) > 0 then
    self.autoPending = false
    self:ApplyNext("auto")
  end
end

function Talents:OnGameTalentsChanged()
  local w = self.awaiting
  if w then
    local actual = self:GetActualRanks(AF.classId) or {}
    local learned = BP.totalOf(actual) - w.before
    if learned >= w.count then
      self.awaiting = nil
      waitFrame:Hide()
      if not w.silent then
        if w.refusal then
          Notify(Lp("apply.warn.learned", learned, learned, w.refusal), true)
        elseif w.count > 1 then
          Notify(Lf("apply.ok.build_applied", learned))
        else
          Notify(Lf("apply.ok.learned", w.name))
        end
      end
    end
  elseif self.autoPending and (UnspentPoints() or 0) > 0 then
    self.autoPending = false
    self:ApplyNext("auto")
  end
  if AF.UI and AF.UI.RefreshTalents then AF.UI:RefreshTalents() end
end

function Talents:Diagnose()
  local out = {}
  local function add(line) out[#out + 1] = line end
  local function has(name) return type(_G[name]) == "function" and "yes" or "no" end
  local function str(v)
    if type(v) ~= "table" then return tostring(v) end
    local parts = {}
    for k, x in pairs(v) do
      if type(x) ~= "table" then parts[#parts + 1] = tostring(k) .. "=" .. tostring(x) end
    end
    for k, x in pairs(v) do
      if type(x) == "table" then
        local sub = {}
        for sk, sx in pairs(x) do sub[#sub + 1] = (type(sk) == "number" and "" or (tostring(sk) .. "=")) .. (type(sx) == "table" and "{..}" or tostring(sx)) end
        parts[#parts + 1] = tostring(k) .. "={" .. table.concat(sub, ",") .. "}"
      end
    end
    table.sort(parts)
    return "{" .. table.concat(parts, " ") .. "}"
  end
  local function call(fn, ...)
    local r = { pcall(fn, ...) }
    if not r[1] then return nil, "ERROR " .. tostring(r[2]) end
    return unpack(r, 2)
  end
  local function keys(t)
    local list = {}
    for k, v in pairs(t or {}) do if type(v) == "function" then list[#list + 1] = k end end
    table.sort(list)
    return table.concat(list, ", ")
  end

  if type(GetBuildInfo) == "function" then
    local v, b, d, i = GetBuildInfo()
    add("Client: " .. tostring(v) .. " build " .. tostring(b) .. " (" .. tostring(d) .. "), interface " .. tostring(i))
  end
  add("API 1.x : GetNumTalentTabs=" .. has("GetNumTalentTabs") .. " GetTalentTabInfo=" .. has("GetTalentTabInfo") ..
    " GetNumTalents=" .. has("GetNumTalents") .. " GetTalentInfo=" .. has("GetTalentInfo") ..
    " GetTalentInfoByID=" .. has("GetTalentInfoByID") .. " LearnTalent=" .. has("LearnTalent") ..
    " RemoveTalent=" .. has("RemoveTalent") .. " GetTalentLink=" .. has("GetTalentLink") ..
    " UnitCharacterPoints=" .. has("UnitCharacterPoints") .. " GetUnspentTalentPoints=" .. has("GetUnspentTalentPoints"))
  local unlearn = {}
  for k, v in pairs(_G) do
    if type(k) == "string" and type(v) == "function" and k:find("Talent") and
      (k:find("Unlearn") or k:find("Remove") or k:find("Wipe") or k:find("Reset") or k:find("Refund")) then
      unlearn[#unlearn + 1] = k
    end
  end
  table.sort(unlearn)
  add("Removal: " .. (#unlearn > 0 and table.concat(unlearn, ", ") or "no function"))
  local function hasIn(tbl, name) return type(tbl) == "table" and type(tbl[name]) == "function" and "yes" or "no" end
  add("Descriptions: C_Spell.GetSpellDescription=" .. hasIn(C_Spell, "GetSpellDescription") ..
    " GetSpellDescription=" .. has("GetSpellDescription") ..
    " C_Spell.RequestLoadSpellData=" .. hasIn(C_Spell, "RequestLoadSpellData") ..
    " C_Spell.GetSpellName=" .. hasIn(C_Spell, "GetSpellName") ..
    " Spell.CreateFromSpellID=" .. hasIn(Spell, "CreateFromSpellID") ..
    " C_Traits.GetTraitDescription=" .. hasIn(C_Traits, "GetTraitDescription") ..
    " InitializeViewLoadout=" .. hasIn(C_ClassTalents, "InitializeViewLoadout") ..
    " VIEW_TRAIT_CONFIG_ID=" .. tostring(Constants and Constants.TraitConsts and Constants.TraitConsts.VIEW_TRAIT_CONFIG_ID))
  -- Other classes: the class has no spec ids (GetSpecIDs is empty), so scan the tree ids around the player's one.
  local okView, errView = pcall(function()
    if not (C_Traits and C_ClassTalents) then return end
    local active = C_ClassTalents.GetActiveConfigID and call(C_ClassTalents.GetActiveConfigID)
    local CSI = C_SpecializationInfo
    for cid = 1, 11 do
      local numSpecs = CSI and CSI.GetNumSpecializationsForClassID and call(CSI.GetNumSpecializationsForClassID, cid)
      local viaSpec = C_ClassTalents.GetTraitTreeForSpec and call(C_ClassTalents.GetTraitTreeForSpec, cid)
      add("View: class " .. cid .. " numSpecs=" .. tostring(numSpecs) .. " GetTraitTreeForSpec(classId)=" .. tostring(viaSpec))
    end
    local function cut(v) v = tostring(v); return #v > 60 and (v:sub(1, 60) .. "...") or v end
    for treeID = 1060, 1110 do
      local nodes = call(C_Traits.GetTreeNodes, treeID)
      if type(nodes) == "table" and #nodes > 0 then
        local cfg = C_Traits.GetConfigIDByTreeID and call(C_Traits.GetConfigIDByTreeID, treeID)
        local line = "View: tree " .. treeID .. " nodes " .. #nodes .. " config " .. tostring(cfg)
        for _, nodeID in ipairs(nodes) do
          local node = active and call(C_Traits.GetNodeInfo, active, nodeID)
          local entryID = type(node) == "table" and node.entryIDs and node.entryIDs[1]
          if entryID then
            local entry = call(C_Traits.GetEntryInfo, active, entryID)
            local def = type(entry) == "table" and entry.definitionID and call(C_Traits.GetDefinitionInfo, entry.definitionID)
            local spell = type(def) == "table" and def.spellID
            local top = node.maxRanks or 1
            line = line .. " | node " .. nodeID .. " entry " .. entryID .. " spell " .. tostring(spell) ..
              " " .. tostring(spell and C_Spell and C_Spell.GetSpellName and call(C_Spell.GetSpellName, spell)) ..
              " max " .. top .. " r1: " .. cut(call(C_Traits.GetTraitDescription, entryID, 1)) ..
              " rTop: " .. cut(call(C_Traits.GetTraitDescription, entryID, top))
            break
          end
        end
        add(line)
      end
    end
  end)
  if not okView then add("View: ERROR " .. tostring(errView)) end
  add("C_ClassTalents: " .. keys(C_ClassTalents))
  add("C_Traits: " .. keys(C_Traits))
  add("C_SpecializationInfo: " .. keys(C_SpecializationInfo))

  local classId = AF.classId or AF:GetPlayerClassId()
  local cls = classId and AF:GetClassData(classId)
  add("Class: " .. tostring(cls and cls.name) .. " (" .. tostring(classId) .. "), level " .. tostring(UnitLevel and UnitLevel("player")))

  if C_ClassTalents and C_Traits then
    local configID = C_ClassTalents.GetActiveConfigID and call(C_ClassTalents.GetActiveConfigID)
    add("Active config: " .. tostring(configID))
    if C_ClassTalents.GetConfigIDsBySpecID then add("Spec configs: " .. str({ call(C_ClassTalents.GetConfigIDsBySpecID) })) end
    if C_ClassTalents.GetLastSelectedSavedConfigID then add("Last config: " .. str({ call(C_ClassTalents.GetLastSelectedSavedConfigID) })) end
    local info = configID and call(C_Traits.GetConfigInfo, configID)
    add("GetConfigInfo: " .. str(info))
    local cat = classId and self:GetCatalog(classId)
    local ids, spells = {}, {}
    if cat then
      for _, e in ipairs(cat.entries) do
        ids[e.talent.id] = e.talent.name
        local r1 = e.talent.ranks and e.talent.ranks[1]
        if r1 and r1.spellId and r1.spellId > 0 then spells[r1.spellId] = e.talent.name end
      end
    end
    local hit = { node = 0, entry = 0, def = 0, spell = 0, nodes = 0 }
    for _, treeID in ipairs(type(info) == "table" and info.treeIDs or {}) do
      add("Tree " .. tostring(treeID) .. ": " .. str(call(C_Traits.GetTreeInfo, configID, treeID)))
      if C_Traits.GetTreeCurrencyInfo then
        local cur = call(C_Traits.GetTreeCurrencyInfo, configID, treeID, false)
        for _, c in ipairs(type(cur) == "table" and cur or {}) do add("  currency: " .. str(c)) end
        if type(cur) ~= "table" then add("  currency: " .. tostring(cur)) end
      end
      local nodes = call(C_Traits.GetTreeNodes, treeID) or {}
      add("  " .. #nodes .. " nodes")
      for n, nodeID in ipairs(nodes) do
        local node = call(C_Traits.GetNodeInfo, configID, nodeID)
        if type(node) == "table" and node.ID and node.ID ~= 0 then
          hit.nodes = hit.nodes + 1
          if ids[nodeID] then hit.node = hit.node + 1 end
          local entryID = node.entryIDs and node.entryIDs[1]
          local entry = entryID and call(C_Traits.GetEntryInfo, configID, entryID)
          local defID = type(entry) == "table" and entry.definitionID
          local def = defID and call(C_Traits.GetDefinitionInfo, defID)
          local spellID = type(def) == "table" and def.spellID
          local spellName = spellID and ((C_Spell and C_Spell.GetSpellName and call(C_Spell.GetSpellName, spellID)) or (GetSpellInfo and call(GetSpellInfo, spellID)))
          if entryID and ids[entryID] then hit.entry = hit.entry + 1 end
          if defID and ids[defID] then hit.def = hit.def + 1 end
          if spellID and spells[spellID] then hit.spell = hit.spell + 1 end
          if n <= 80 then
            add("  node " .. nodeID .. " pos " .. tostring(node.posX) .. "," .. tostring(node.posY) ..
              " rank " .. tostring(node.currentRank) .. "/" .. tostring(node.maxRanks) ..
              " bought " .. tostring(node.ranksPurchased) .. " canBuy " .. tostring(node.canPurchaseRank) ..
              " canRefund " .. tostring(node.canRefundRank) .. " avail " .. tostring(node.isAvailable) ..
              " type " .. tostring(node.type) .. " entry " .. tostring(entryID) .. " def " .. tostring(defID) ..
              " spell " .. tostring(spellID) .. " " .. tostring(spellName) ..
              " edges " .. str(node.visibleEdges and #node.visibleEdges or nil) ..
              (ids[nodeID] and (" = data " .. ids[nodeID]) or ""))
          end
          if n <= 3 and entryID then
            local function cut(v) v = tostring(v); return #v > 90 and (v:sub(1, 90) .. "...") or v end
            local mr = node.maxRanks or 1
            local dfn = (C_Spell and C_Spell.GetSpellDescription) or GetSpellDescription
            add("  desc rank 1 trait: " .. cut(select(1, call(C_Traits.GetTraitDescription, entryID, 1))) ..
              " | rank " .. mr .. " trait: " .. cut(select(1, call(C_Traits.GetTraitDescription, entryID, mr))) ..
              " | spell: " .. cut(spellID and dfn and select(1, call(dfn, spellID)) or nil))
          end
          if n == 1 then add("  full node: " .. str(node)) end
          if n == 1 and type(entry) == "table" then add("  full entry: " .. str(entry)) end
          if n == 1 and type(def) == "table" then add("  full definition: " .. str(def)) end
        end
      end
    end
    add("Data matches: nodes " .. hit.node .. ", entries " .. hit.entry ..
      ", definitions " .. hit.def .. ", rank 1 spells " .. hit.spell .. " (out of " .. hit.nodes .. " client nodes, " ..
      (cat and #cat.entries or 0) .. " talents in data)")
  end
  if AzerothForeverDB then AzerothForeverDB.diag = out end
  return out
end
