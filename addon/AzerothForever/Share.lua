-- Azeroth Forever : code de partage « AF1- » (build de classe).
-- Portage Lua de data/share-code.js. Voir docs/BUILD_CODEC.md §9.
local ADDON_NAME, AF = ...

local SC = {}
AF.ShareCode = SC

local Bit = AF.Bit
local C = AF.Data.Constants
local BP = AF.BuildPath

local PREFIX = C.PREFIX_CLASS         -- "AF1-"
local PREFIX_HERITAGE = C.PREFIX_HERITAGE -- "AF1H-"
local KIND_CLASS = C.KIND_CLASS       -- "C"
local CLASS_SLUGS = C.CLASS_SLUGS

local function crc8(text) return Bit.crc8(text) end
local function hex2(n) return Bit.hex2(n) end

local function classChar(cls)
  return C.ALPHABET:sub(cls.id + 1, cls.id + 1)
end

-- Contrôle rapide d'un code collé, sans données de jeu : préfixe, checksum, type.
-- Renvoie { ok, kind = "C"|"H", code (forme canonique), slug (classe si C) }
-- ou { ok = false, error }.
function SC.inspect(input)
  local code = tostring(input or ""):gsub("%s+", "")
  if code == "" then
    return { ok = false, error = "Collez un code qui commence par AF1- (classe) ou AF1H- (héritage)." }
  end
  local kind, rest
  if code:sub(1, #PREFIX_HERITAGE):upper() == PREFIX_HERITAGE then
    kind = "H"
    rest = code:sub(#PREFIX_HERITAGE + 1)
  elseif code:sub(1, #PREFIX):upper() == PREFIX then
    kind = "C"
    rest = code:sub(#PREFIX + 1)
  else
    return { ok = false, error = "Ce n'est pas un code Azeroth Forever : il doit commencer par AF1- ou AF1H-." }
  end
  local payload, crcPart = rest:match("^(.+)%-([0-9A-Fa-f][0-9A-Fa-f])$")
  if not payload then
    return { ok = false, error = "Code incomplet : recopiez-le en entier, jusqu'aux 2 derniers caractères." }
  end
  if hex2(crc8(payload)) ~= crcPart:upper() then
    return { ok = false, error = "Code abîmé (somme de contrôle fausse) : recopiez-le en entier." }
  end
  local out = {
    ok = true,
    kind = kind,
    code = (kind == "H" and PREFIX_HERITAGE or PREFIX) .. payload .. "-" .. crcPart:upper(),
    payload = payload
  }
  if kind == "C" then
    if payload:sub(1, 1) ~= KIND_CLASS then
      return { ok = false, error = "Type de code inconnu." }
    end
    local classId = C.ALPHABET:find(payload:sub(2, 2), 1, true)
    classId = classId and (classId - 1) or nil
    out.slug = classId and CLASS_SLUGS[classId] or nil
    if not out.slug then
      return { ok = false, error = "Classe inconnue dans ce code." }
    end
  end
  return out
end

-- cls : entrée de AF.Data.Talents ; path : valeur de ?path= (déjà validée).
function SC.encode(cls, path)
  local payload = KIND_CLASS .. classChar(cls) .. path
  return PREFIX .. payload .. "-" .. hex2(crc8(payload))
end

-- Relit un code AF1- collé. Renvoie { ok, slug, cls, path, build, talented }
-- ou { ok = false, error } (message en français).
function SC.decode(input)
  local code = tostring(input or ""):gsub("%s+", "")
  if code == "" then
    return { ok = false, error = "Collez un code qui commence par AF1-." }
  end
  if code:sub(1, #PREFIX_HERITAGE):upper() == PREFIX_HERITAGE then
    return { ok = false, error = "C'est un code d'Héritage : utilisez l'onglet Héritage pour le lire." }
  end
  if code:sub(1, #PREFIX):upper() ~= PREFIX then
    return { ok = false, error = "Ce n'est pas un code Azeroth Forever : il doit commencer par AF1-." }
  end
  local rest = code:sub(#PREFIX + 1)
  local payload, crcPart = rest:match("^(.+)%-([0-9A-Fa-f][0-9A-Fa-f])$")
  if not payload then
    return { ok = false, error = "Code incomplet : recopiez-le en entier, jusqu'aux 2 derniers caractères." }
  end
  if hex2(crc8(payload)) ~= crcPart:upper() then
    return { ok = false, error = "Code abîmé (somme de contrôle fausse) : recopiez-le en entier." }
  end
  if payload:sub(1, 1) ~= KIND_CLASS then
    return { ok = false, error = "Type de code inconnu." }
  end
  local classIdx = C.ALPHABET:find(payload:sub(2, 2), 1, true)
  local classId = classIdx and (classIdx - 1) or nil
  local cls = classId and AF:GetClassData(classId) or nil
  if not cls then
    return { ok = false, error = "Classe inconnue dans ce code (ou catalogue de talents différent : mets à jour l'addon)." }
  end
  local path = payload:sub(3)
  local cat = BP.catalog(cls)
  local decoded = BP.decodePath(cat, path)
  if not decoded.ok then
    return { ok = false, error = "Le catalogue de talents a changé : mets à jour l'addon (" .. decoded.error .. ")" }
  end
  local check = BP.validateOrder(cat, decoded.order)
  if not check.ok then
    return { ok = false, error = "Ce code décrit un ordre impossible (étape " .. (check.step + 1) .. ") : " .. check.message }
  end
  return {
    ok = true,
    slug = cls.slug,
    cls = cls,
    path = path,
    build = BP.serializeBuild(cat, BP.ranksFromOrder(cat, decoded.order)),
    order = decoded.order,
    talented = decoded.talented
  }
end
