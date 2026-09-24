-- Azeroth Forever : constantes du codec, partagées avec le site (docs/BUILD_CODEC.md).
-- Généré par tools/export-lua.mjs. Ne pas éditer à la main (sauf SITE_URL).
local ADDON_NAME, AF = ...

AF.Data = AF.Data or {}
AF.Data.Constants = {
  ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_",
  PATH_VERSION = "1",
  MAX_POINTS = 51,
  MAX_LEVEL = 60,
  MIN_LEVEL = 10,
  TALENTED_KNOWN_MAX = 1,
  TALENTED_MAX_STORED = 7,
  HERITAGE_MAX_POINTS = 16,
  HERITAGE_CODE_VERSION = "1",
  DATA_BUILD = "1.60.1.69893",
  TALENT_COUNT = 469,
  PREFIX_CLASS = "AF1-",
  PREFIX_HERITAGE = "AF1H-",
  KIND_CLASS = "C",
  SITE_URL = "https://azerothforever.info/",
  CLASS_SLUGS = {
    [1] = "guerrier",
    [2] = "paladin",
    [3] = "chasseur",
    [4] = "voleur",
    [5] = "pretre",
    [7] = "chaman",
    [8] = "mage",
    [9] = "demoniste",
    [11] = "druide"
  }
}
