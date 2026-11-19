-- (c) Poulpix, Azeroth Forever. All rights reserved. Text and data mining and AI training prohibited (noai, noimageai, EU Directive 2019/790 art. 4). See LICENSE.md.
-- Display names for data that ships in French (Data/*.lua).
-- Rule: when the addon language is frFR, the shipped data is used as is. In any other language the client
-- API is asked first (spell and class names), then the French data.
-- Exception: talent descriptions and icons ask the client first in every language, frFR included.
-- The Classic talent wording only exists in the data and has no client equivalent, it is translated by hand in
-- Locale/enUS_Content.lua (AF.Content.enUS) and the other *_Content.lua files.
local ADDON_NAME, AF = ...

local N = {}
AF.Names = N

local function useClient()
  return AF:GetActiveLocale() ~= "frFR"
end
N.UseClient = useClient

local function call(fn, ...)
  if type(fn) ~= "function" then return nil end
  local ok, a = pcall(fn, ...)
  if ok then return a end
  return nil
end

local nameCache, iconCache = {}, {}

local function spellName(id)
  if nameCache[id] then return nameCache[id] end
  local name = call(C_Spell and C_Spell.GetSpellName, id)
  if type(name) ~= "string" or name == "" then name = call(GetSpellInfo, id) end
  if type(name) == "string" and name ~= "" then
    nameCache[id] = name
    return name
  end
  return nil
end

-- The client loads spell data lazily: the first read of a description returns nothing, the next one works.
-- A request is made once per spell (again after 3 s if it never answered) and N.onDescLoaded is called when
-- the data arrives, so the tooltip that fell back to the data text can be drawn again with the client text.
N.onDescLoaded = nil

local requested = {}

local function notifyLoaded()
  if N.onDescLoaded then N.onDescLoaded() end
end

local function requestSpell(id)
  if not id or id <= 0 then return end
  local now = type(GetTime) == "function" and GetTime() or 0
  if requested[id] and now - requested[id] < 3 then return end
  requested[id] = now
  call(C_Spell and C_Spell.RequestLoadSpellData, id)
  if Spell and Spell.CreateFromSpellID then
    pcall(function() Spell:CreateFromSpellID(id):ContinueOnSpellLoad(notifyLoaded) end)
  elseif C_Timer and C_Timer.After then
    C_Timer.After(0.3, notifyLoaded)
  end
end

-- Talents ------------------------------------------------------------------

function N:TalentName(talent)
  if useClient() then
    local r1 = talent.ranks and talent.ranks[1]
    local id = r1 and r1.spellId
    if id and id > 0 then
      local name = spellName(id)
      if name then return name end
    end
  end
  return talent.name
end

-- Talent descriptions ------------------------------------------------------

-- Every language, frFR included: the text of the client first, the data text (French) only as the last resort.
-- Sources, first non empty wins (N.lastDescSource tells which one, for tests and /af debug):
--   "trait"  C_Traits.GetTraitDescription(entryID, rank): any rank, any class (entry found by the rank 1 spell id)
--   "data"   Data/Talents.lua
-- The legacy talent API (GetTalentInfo, GameTooltip:SetTalent) does not exist in Forever (see /af diag).
-- Nothing is translated here, a missing source just falls through to the data.

local function traitDesc(talent, rankIndex, classId, entryIndex)
  if not (C_Traits and C_Traits.GetTraitDescription and AF.Talents) then return nil end
  local entryID, spellID
  -- Own class: the entry found by the game map. Any class: the entry found by the rank 1 spell id.
  if classId and entryIndex and AF.Talents.GetTraitEntryID then
    local ok, e, s = pcall(AF.Talents.GetTraitEntryID, AF.Talents, classId, entryIndex)
    if ok then entryID, spellID = e, s end
  end
  if not entryID and AF.Talents.GetTraitEntryBySpell then
    local r1 = talent.ranks and talent.ranks[1]
    spellID = r1 and r1.spellId
    local ok, e = pcall(AF.Talents.GetTraitEntryBySpell, AF.Talents, spellID)
    if ok then entryID = e end
  end
  if not entryID then return nil end
  local text = call(C_Traits.GetTraitDescription, entryID, rankIndex)
  if type(text) == "string" and text ~= "" then return text end
  -- Empty: the spell behind the entry is probably not loaded yet.
  requestSpell(spellID)
  return nil
end

-- classId and entryIndex (catalog index of the talent) are only needed for the client sources of the own class.
function N:TalentDesc(talent, rankIndex, classId, entryIndex)
  local r = talent.ranks and talent.ranks[rankIndex]
  if not r then return "" end
  local text = traitDesc(talent, rankIndex, classId, entryIndex)
  if text then N.lastDescSource = "trait"; return text end
  N.lastDescSource = "data"
  return r.desc or ""
end

-- Talent icon: the icon of the rank 1 spell given by the client (C_Spell.GetSpellTexture), else the data icon.
function N:TalentIcon(talent)
  local r1 = talent.ranks and talent.ranks[1]
  local id = r1 and r1.spellId
  if id and id > 0 then
    local icon = iconCache[id]
    if not icon then
      icon = call(C_Spell and C_Spell.GetSpellTexture, id)
      if (type(icon) == "number" and icon > 0) or (type(icon) == "string" and icon ~= "") then iconCache[id] = icon end
    end
    if iconCache[id] then return iconCache[id] end
  end
  return "Interface\\Icons\\" .. (talent.icon or "INV_Misc_QuestionMark")
end

-- Classes ------------------------------------------------------------------

local CLASS_FILE_BY_ID = {
  [1] = "WARRIOR", [2] = "PALADIN", [3] = "HUNTER", [4] = "ROGUE", [5] = "PRIEST",
  [7] = "SHAMAN", [8] = "MAGE", [9] = "WARLOCK", [11] = "DRUID"
}

function N:ClassName(cls)
  if not cls then return "" end
  if useClient() and type(LOCALIZED_CLASS_NAMES_MALE) == "table" then
    local name = LOCALIZED_CLASS_NAMES_MALE[CLASS_FILE_BY_ID[cls.id]]
    if type(name) == "string" and name ~= "" then return name end
  end
  return cls.name
end

-- Classic wording of a talent rank (Data/Talents.lua talent.classic), by talent id and rank.
function N:ClassicRank(talent, rankIndex)
  local c = talent and talent.classic
  if not c then return nil end
  if useClient() then
    local C = AF.Content
    local code = AF:GetActiveLocale()
    local e = C and C[code] and C[code].classic and C[code].classic[talent.id]
    if not e and C and C.enUS and C.enUS.classic then e = C.enUS.classic[talent.id] end
    if e and e[rankIndex] then return e[rankIndex] end
  end
  return c.ranks and c.ranks[rankIndex]
end

-- Talent trees of the classes ----------------------------------------------

-- Keyed by the tree id of Data/Talents.lua (unique across classes). Every name comes from Locale, the data name
-- is only the fallback for a tree that has no key.
local TREE_KEYS = {
  [161] = "tree.warrior.arms", [164] = "tree.warrior.fury", [163] = "tree.warrior.protection",
  [382] = "tree.paladin.holy", [383] = "tree.paladin.protection", [381] = "tree.paladin.retribution",
  [361] = "tree.hunter.beast_mastery", [363] = "tree.hunter.marksmanship", [362] = "tree.hunter.survival",
  [182] = "tree.rogue.assassination", [181] = "tree.rogue.combat", [183] = "tree.rogue.subtlety",
  [201] = "tree.priest.discipline", [202] = "tree.priest.holy", [203] = "tree.priest.shadow",
  [261] = "tree.shaman.elemental", [263] = "tree.shaman.enhancement", [262] = "tree.shaman.restoration",
  [81] = "tree.mage.arcane", [41] = "tree.mage.fire", [61] = "tree.mage.frost",
  [302] = "tree.warlock.affliction", [303] = "tree.warlock.demonology", [301] = "tree.warlock.destruction",
  [283] = "tree.druid.balance", [281] = "tree.druid.feral", [282] = "tree.druid.restoration"
}

function N:TreeName(tree)
  local key = tree and TREE_KEYS[tree.id]
  return (key and AF.Lopt(key)) or (tree and tree.name) or ""
end

-- Legacy tree (Data/Heritage.lua) ------------------------------------------

-- Tree ids are French slugs in the data, the keys use English words.
local HERITAGE_TREE_SLUGS = { metiers = "professions", aventure = "adventure", ingeniosite = "ingenuity" }

function N:HeritageTreeName(tree)
  local slug = HERITAGE_TREE_SLUGS[tree.id]
  return (slug and AF.Lopt("heritage.tree." .. slug)) or tree.name
end

function N:HeritageTreeDesc(tree)
  local slug = HERITAGE_TREE_SLUGS[tree.id]
  return (slug and AF.Lopt("heritage.col." .. slug .. ".sub")) or tree.desc or ""
end

-- Node keys are "heritage.node.<node id>.name|desc|meta", the node ids come from the data.
function N:HeritageNodeName(node)
  return AF.Lopt("heritage.node." .. node.id .. ".name") or node.name
end

function N:HeritageNodeDesc(node)
  return AF.Lopt("heritage.node." .. node.id .. ".desc") or node.desc or ""
end

function N:HeritageNodeMeta(node)
  if not node.meta then return nil end
  return AF.Lopt("heritage.node." .. node.id .. ".meta") or node.meta
end
