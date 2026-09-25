-- Azeroth Forever : manifeste des textures personnalisées réellement
-- présentes dans Textures/ (généré par tools/convert-textures.py).
-- WoW n'a pas d'API pour tester si un fichier existe : ce manifeste
-- permet à UI.lua de savoir AVANT d'essayer, plutôt que de deviner.
local ADDON_NAME, AF = ...

AF.Data = AF.Data or {}
AF.Data.TextureManifest = {
  ["banner_alliance"] = true,
  ["banner_chaman"] = true,
  ["banner_chasseur"] = true,
  ["banner_demoniste"] = true,
  ["banner_druide"] = true,
  ["banner_guerrier"] = true,
  ["banner_horde"] = true,
  ["banner_mage"] = true,
  ["banner_paladin"] = true,
  ["banner_pretre"] = true,
  ["banner_voleur"] = true,
  ["class_druid"] = true,
  ["class_hunter"] = true,
  ["class_mage"] = true,
  ["class_paladin"] = true,
  ["class_priest"] = true,
  ["class_rogue"] = true,
  ["class_shaman"] = true,
  ["class_warlock"] = true,
  ["class_warrior"] = true,
  ["inv_banner_02"] = true,
  ["inv_bannerpvp_01"] = true,
}
