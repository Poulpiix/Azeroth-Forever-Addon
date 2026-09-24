-- Azeroth Forever : initialisation de l'addon, utilitaires bas niveau, slash /af.
local ADDON_NAME, AF = ...
_G.AzerothForever = AF

AF.SITE_URL = "https://azerothforever.info/"

-- ---------------------------------------------------------------------
-- Bit utils (Lua 5.1 n'a pas d'opérateurs binaires natifs). Réimplémentés
-- en arithmétique pure pour ne dépendre d'aucune lib "bit" non confirmée
-- sur ce client. Utilisés par le CRC-8 (Share.lua) et l'encodeur QR (QR.lua).
-- ---------------------------------------------------------------------
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

function Bit.bor(a, b)
  local result, bitval = 0, 1
  while a > 0 or b > 0 do
    if a % 2 == 1 or b % 2 == 1 then result = result + bitval end
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

function Bit.rshift(a, n)
  return math.floor(a / (2 ^ n))
end

-- CRC-8/SMBUS (polynôme 0x07, init 0x00, sans réflexion). Voir docs/BUILD_CODEC.md §9.
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

-- ---------------------------------------------------------------------
-- Classe du joueur : id WoW standard (identique à data/share-code.js CLASS_SLUGS).
-- ---------------------------------------------------------------------
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

-- ---------------------------------------------------------------------
-- SavedVariables (voir AzerothForever.toc). Une entrée de plan par classe
-- jouée sur ce compte, pour ne pas mélanger les builds de deux persos différents.
-- ---------------------------------------------------------------------
local function EnsureDB()
  AzerothForeverDB = AzerothForeverDB or {}
  AzerothForeverDB.plans = AzerothForeverDB.plans or {}
  AzerothForeverDB.options = AzerothForeverDB.options or {
    autoApply = false,
    mode = "level60" -- "level60" ou "levelByLevel"
  }
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

-- ---------------------------------------------------------------------
-- Chargement, slash command, évènements.
-- ---------------------------------------------------------------------
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:RegisterEvent("PLAYER_TALENT_UPDATE")
eventFrame:RegisterEvent("CHARACTER_POINTS_CHANGED")
eventFrame:RegisterEvent("PLAYER_LEVEL_UP")

eventFrame:SetScript("OnEvent", function(self, event, ...)
  if event == "ADDON_LOADED" then
    local name = ...
    if name == ADDON_NAME then
      EnsureDB()
    end
  elseif event == "PLAYER_LOGIN" then
    AF.classId = AF:GetPlayerClassId()
  elseif event == "PLAYER_TALENT_UPDATE" or event == "CHARACTER_POINTS_CHANGED" then
    if AF.Talents and AF.Talents.OnGameTalentsChanged then
      AF.Talents:OnGameTalentsChanged()
    end
  elseif event == "PLAYER_LEVEL_UP" then
    -- OFF par défaut (voir AzerothForeverDB.options.autoApply, case à cocher
    -- dans l'onglet Plan). Même quand activé, ça reste un choix du joueur :
    -- Apply next/all n'agissent jamais sans qu'il ait cliqué quelque part.
    if AzerothForeverDB and AzerothForeverDB.options.autoApply and AF.Talents then
      AF.Talents:ApplyNext()
    end
  end
end)

SLASH_AZEROTHFOREVER1 = "/af"
SlashCmdList["AZEROTHFOREVER"] = function(msg)
  if AF.UI and AF.UI.Toggle then
    AF.UI:Toggle()
  else
    AF:Print("Interface non chargée.")
  end
end
