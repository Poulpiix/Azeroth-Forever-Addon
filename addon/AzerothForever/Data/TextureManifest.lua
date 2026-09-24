-- Azeroth Forever : manifeste des textures personnalisées réellement
-- présentes dans Textures/ (généré par tools/convert-textures.py).
-- WoW n'a pas d'API pour tester si un fichier existe : ce manifeste
-- permet à UI.lua de savoir AVANT d'essayer, plutôt que de deviner.
local ADDON_NAME, AF = ...

AF.Data = AF.Data or {}
AF.Data.TextureManifest = {
}
