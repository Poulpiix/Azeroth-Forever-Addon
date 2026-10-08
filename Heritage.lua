-- (c) Poulpix, Azeroth Forever. All rights reserved. Text and data mining and AI training prohibited (noai, noimageai, EU Directive 2019/790 art. 4). See LICENSE.md.
local ADDON_NAME, AF = ...

local HP = {}
AF.HeritagePath = HP

local L, Lf = AF.L, AF.Lf
local N = AF.Names
local Bit = AF.Bit
local C = AF.Data.Constants

local MAX_POINTS = C.HERITAGE_MAX_POINTS
local CODE_VERSION = C.HERITAGE_CODE_VERSION
local PREFIX = C.PREFIX_HERITAGE

function HP.catalog(trees)
  local entries = {}
  local byKey = {}
  for treeIdx, tree in ipairs(trees) do
    for _, node in ipairs(tree.nodes) do
      local key = tree.id .. "__" .. node.id
      local entry = { index = #entries, treeIdx = treeIdx, tree = tree, node = node, key = key }
      entries[#entries + 1] = entry
      byKey[key] = entry
    end
  end
  return { trees = trees, entries = entries, byKey = byKey }
end

function HP.emptyRanks(cat)
  local ranks = {}
  for _, e in ipairs(cat.entries) do ranks[e.key] = 0 end
  return ranks
end

function HP.totalOf(ranks)
  local sum = 0
  for _, v in pairs(ranks) do sum = sum + (v or 0) end
  return sum
end

function HP.serializeHbuild(cat, ranks)
  local blocks = {}
  for _, tree in ipairs(cat.trees) do
    local chars = {}
    for _, node in ipairs(tree.nodes) do
      chars[#chars + 1] = tostring(ranks[tree.id .. "__" .. node.id] or 0)
    end
    blocks[#blocks + 1] = table.concat(chars)
  end
  return table.concat(blocks, "-")
end

function HP.autoOrder(cat, ranks)
  local order = {}
  local acquirable = true
  for treeIdx, tree in ipairs(cat.trees) do
    local todo = {}
    for _, e in ipairs(cat.entries) do
      if e.treeIdx == treeIdx and (ranks[e.key] or 0) > 0 then todo[#todo + 1] = e end
    end
    table.sort(todo, function(a, b)
      if (a.node.tier or 0) ~= (b.node.tier or 0) then return (a.node.tier or 0) < (b.node.tier or 0) end
      if a.node.row ~= b.node.row then return a.node.row < b.node.row end
      if a.node.col ~= b.node.col then return a.node.col < b.node.col end
      return a.index < b.index
    end)
    local spent = 0
    while #todo > 0 do
      local pick = nil
      for i, e in ipairs(todo) do
        if not e.node.tier or e.node.tier == 0 or spent >= e.node.tier then pick = i; break end
      end
      if not pick then
        acquirable = false
        pick = 1
      end
      local entry = table.remove(todo, pick)
      for _ = 1, ranks[entry.key] do
        order[#order + 1] = entry.index
        spent = spent + 1
      end
    end
  end
  return { order = order, acquirable = acquirable and #order <= MAX_POINTS }
end

function HP.ranksAt(cat, order, count)
  local ranks = HP.emptyRanks(cat)
  local n = count
  if n == nil or n > #order then n = #order end
  if n < 0 then n = 0 end
  for i = 1, n do
    ranks[cat.entries[order[i] + 1].key] = ranks[cat.entries[order[i] + 1].key] + 1
  end
  return ranks
end

local function crc(text) return Bit.hex2(Bit.crc8(text)) end

function HP.encode(cat, ranks)
  local digits = {}
  for _, e in ipairs(cat.entries) do digits[#digits + 1] = tostring(ranks[e.key] or 0) end
  local payload = CODE_VERSION .. table.concat(digits)
  return PREFIX .. payload .. "-" .. crc(payload)
end

function HP.decode(input, cat)
  local info = AF.ShareCode.inspect(input)
  if not info.ok then return info end
  if info.kind ~= "H" then
    return { ok = false, error = L["heritage.err.is_class"] }
  end
  local payload = info.payload
  if payload:sub(1, 1) ~= CODE_VERSION then
    return { ok = false, error = L["heritage.err.version"] }
  end
  local digits = payload:sub(2)
  if #digits ~= #cat.entries or digits:match("[^0-9]") then
    return { ok = false, error = Lf("heritage.err.unreadable", #digits, #cat.entries) }
  end
  local ranks = HP.emptyRanks(cat)
  for i, entry in ipairs(cat.entries) do
    local rank = tonumber(digits:sub(i, i))
    if rank > entry.node.maxRank then
      return { ok = false, error = Lf("heritage.err.rank_max", N:HeritageNodeName(entry.node), entry.node.maxRank) }
    end
    ranks[entry.key] = rank
  end
  if HP.totalOf(ranks) > MAX_POINTS then
    return { ok = false, error = Lf("heritage.err.too_many", MAX_POINTS) }
  end
  if not HP.autoOrder(cat, ranks).acquirable then
    return { ok = false, error = L["heritage.err.tiers"] }
  end
  return { ok = true, ranks = ranks }
end

local Heritage = {}
AF.Heritage = Heritage

local heritageCat

function Heritage:GetCatalog()
  if not heritageCat then heritageCat = HP.catalog(AF.Data.Heritage.trees) end
  return heritageCat
end

local function EnsureHeritagePlan()
  AzerothForeverDB.heritagePlan = AzerothForeverDB.heritagePlan or { ranks = {} }
  return AzerothForeverDB.heritagePlan
end

function Heritage:GetRanks()
  local cat = self:GetCatalog()
  local plan = EnsureHeritagePlan()
  local ranks = HP.emptyRanks(cat)
  for k, v in pairs(plan.ranks) do ranks[k] = v end
  return ranks
end

function Heritage:SetRanks(ranks)
  local plan = EnsureHeritagePlan()
  plan.ranks = ranks
end

function Heritage:ChangeRank(key, delta)
  local cat = self:GetCatalog()
  local ranks = self:GetRanks()
  local entry = cat.byKey[key]
  if not entry then return false, L["heritage.err.node_unknown"] end
  local newRank = math.max(0, math.min(entry.node.maxRank, (ranks[key] or 0) + delta))
  if newRank == ranks[key] then return true end
  local total = HP.totalOf(ranks) - (ranks[key] or 0) + newRank
  if total > MAX_POINTS then
    return false, Lf("heritage.err.cap", MAX_POINTS)
  end
  local tryRanks = {}
  for k, v in pairs(ranks) do tryRanks[k] = v end
  tryRanks[key] = newRank
  local order = HP.autoOrder(cat, tryRanks)
  if not order.acquirable then
    return false, Lf("heritage.err.tier_locked", N:HeritageNodeName(entry.node))
  end
  self:SetRanks(tryRanks)
  return true
end

function Heritage:ApplyPreset(presetId)
  local cat = self:GetCatalog()
  for _, preset in ipairs(AF.Data.Heritage.presets) do
    if preset.id == presetId then
      local ranks = HP.emptyRanks(cat)
      for k, v in pairs(preset.ranks) do ranks[k] = v end
      if HP.autoOrder(cat, ranks).acquirable and HP.totalOf(ranks) <= MAX_POINTS then
        self:SetRanks(ranks)
        return true
      end
      return false, L["heritage.err.preset_invalid"]
    end
  end
  return false, L["heritage.err.preset_unknown"]
end

function Heritage:Reset()
  self:SetRanks({})
end

function Heritage:ResetTree(treeId)
  local ranks = self:GetRanks()
  for _, e in ipairs(self:GetCatalog().entries) do
    if e.tree.id == treeId then ranks[e.key] = 0 end
  end
  self:SetRanks(ranks)
end

function Heritage:RanksAt(count)
  local cat = self:GetCatalog()
  local order = HP.autoOrder(cat, self:GetRanks()).order
  return HP.ranksAt(cat, order, count)
end

function Heritage:ExportCode()
  local cat = self:GetCatalog()
  local ranks = self:GetRanks()
  return HP.encode(cat, ranks)
end

function Heritage:ImportCode(code)
  local cat = self:GetCatalog()
  local res = HP.decode(code, cat)
  if not res.ok then return false, res.error end
  self:SetRanks(res.ranks)
  return true
end
