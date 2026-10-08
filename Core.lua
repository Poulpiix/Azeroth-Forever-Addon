-- (c) Poulpix, Azeroth Forever. All rights reserved. Text and data mining and AI training prohibited (noai, noimageai, EU Directive 2019/790 art. 4). See LICENSE.md.
local ADDON_NAME, AF = ...
_G.AzerothForever = AF
local L, Lf = AF.L, AF.Lf

AF.SITE_URL = "https://azerothforever.info/"

local Bit = {}
AF.Bit = Bit

function Bit.band(a, b)
  local result, bitval = 0, 1
  while a > 0 and b > 0 do
    if a % 2 == 1 and b % 2 == 1 then result = result + bitval end
    bitval = bitval * 2
    a = math.floor(a / 2)
    b = math.floor(b / 2)
  end
  return result
end

function Bit.bxor(a, b)
  local result, bitval = 0, 1
  while a > 0 or b > 0 do
    if (a % 2) ~= (b % 2) then result = result + bitval end
    bitval = bitval * 2
    a = math.floor(a / 2)
    b = math.floor(b / 2)
  end
  return result
end

function Bit.lshift(a, n)
  return math.floor(a * (2 ^ n))
end

function Bit.crc8(text)
  local crc = 0
  for i = 1, #text do
    crc = Bit.bxor(crc, Bit.band(string.byte(text, i), 0xFF))
    for _ = 1, 8 do
      if Bit.band(crc, 0x80) ~= 0 then
        crc = Bit.band(Bit.bxor(Bit.lshift(crc, 1), 0x07), 0xFF)
      else
        crc = Bit.band(Bit.lshift(crc, 1), 0xFF)
      end
    end
  end
  return crc
end

function Bit.hex2(n)
  return string.format("%02X", n)
end

local CLASS_FILE_TO_ID = {
  WARRIOR = 1, PALADIN = 2, HUNTER = 3, ROGUE = 4, PRIEST = 5,
  SHAMAN = 7, MAGE = 8, WARLOCK = 9, DRUID = 11
}

function AF:GetPlayerClassId()
  local _, classFile = UnitClass("player")
  return CLASS_FILE_TO_ID[classFile]
end

function AF:GetClassData(classId)
  for _, cls in ipairs(AF.Data.Talents) do
    if cls.id == classId then return cls end
  end
  return nil
end

function AF:Print(msg)
  local prefix = "|cffb08d57Azeroth Forever|r: "
  if DEFAULT_CHAT_FRAME then
    DEFAULT_CHAT_FRAME:AddMessage(prefix .. tostring(msg))
  end
end

local function EnsureDB()
  AzerothForeverDB = AzerothForeverDB or {}
  AzerothForeverDB.plans = AzerothForeverDB.plans or {}
  AzerothForeverDB.options = AzerothForeverDB.options or { autoApply = false, mode = "final" }
  return AzerothForeverDB
end

function AF:GetPlanFor(classId)
  local db = EnsureDB()
  local key = tostring(classId)
  if not db.plans[key] then
    db.plans[key] = { ranks = {}, order = {}, talented = 0 }
  end
  return db.plans[key]
end

local talentsChanged = CreateFrame("Frame")
talentsChanged:Hide()
talentsChanged:SetScript("OnUpdate", function(self)
  self:Hide()
  if AF.Talents then AF.Talents:OnGameTalentsChanged() end
end)

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("PLAYER_LOGIN")
local TALENT_EVENTS = {
  "PLAYER_TALENT_UPDATE", "CHARACTER_POINTS_CHANGED", "TRAIT_CONFIG_UPDATED",
  "TRAIT_TREE_CURRENCY_INFO_UPDATED", "ACTIVE_COMBAT_CONFIG_CHANGED"
}
local isTalentEvent = {}
for _, ev in ipairs(TALENT_EVENTS) do
  if pcall(eventFrame.RegisterEvent, eventFrame, ev) then isTalentEvent[ev] = true end
end
eventFrame:RegisterEvent("PLAYER_LEVEL_UP")

eventFrame:SetScript("OnEvent", function(self, event, ...)
  if event == "ADDON_LOADED" then
    local name = ...
    if name == ADDON_NAME then
      EnsureDB()
      AF:ApplyLocaleOverride()
      self:UnregisterEvent("ADDON_LOADED")
    end
  elseif event == "PLAYER_LOGIN" then
    AF.classId = AF:GetPlayerClassId()
    if AF.Minimap then AF.Minimap:Init() end
    local meta = (C_AddOns and C_AddOns.GetAddOnMetadata) or GetAddOnMetadata
    local version = meta and meta(ADDON_NAME, "Version")
    AF:Print(Lf("core.loaded", version and (" (v" .. version .. ")") or ""))
  elseif isTalentEvent[event] then
    talentsChanged:Show()
  elseif event == "PLAYER_LEVEL_UP" then
    if AzerothForeverDB and AzerothForeverDB.options.autoApply and AF.Talents then
      AF.Talents:OnLevelUp()
    end
  end
end)

SLASH_AZEROTHFOREVER1 = "/af"
SlashCmdList["AZEROTHFOREVER"] = function(msg)
  if AF.UI then
    AF.UI:HandleSlash(msg)
  else
    AF:Print(L["core.ui_missing"])
  end
end
