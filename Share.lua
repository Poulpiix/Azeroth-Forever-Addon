-- (c) Poulpix, Azeroth Forever. All rights reserved. Text and data mining and AI training prohibited (noai, noimageai, EU Directive 2019/790 art. 4). See LICENSE.md.
local ADDON_NAME, AF = ...

local SC = {}
AF.ShareCode = SC

local L, Lf = AF.L, AF.Lf
local Bit = AF.Bit
local C = AF.Data.Constants
local BP = AF.BuildPath

local PREFIX = C.PREFIX_CLASS
local PREFIX_HERITAGE = C.PREFIX_HERITAGE
local KIND_CLASS = C.KIND_CLASS
local CLASS_SLUGS = C.CLASS_SLUGS

local function crc8(text) return Bit.crc8(text) end
local function hex2(n) return Bit.hex2(n) end

local function classChar(cls)
  return C.ALPHABET:sub(cls.id + 1, cls.id + 1)
end

function SC.inspect(input)
  local code = tostring(input or ""):gsub("%s+", "")
  if code == "" then
    return { ok = false, error = L["share.err.empty_any"] }
  end
  local kind, rest
  if code:sub(1, #PREFIX_HERITAGE):upper() == PREFIX_HERITAGE then
    kind = "H"
    rest = code:sub(#PREFIX_HERITAGE + 1)
  elseif code:sub(1, #PREFIX):upper() == PREFIX then
    kind = "C"
    rest = code:sub(#PREFIX + 1)
  else
    return { ok = false, error = L["share.err.not_af_any"] }
  end
  local payload, crcPart = rest:match("^(.+)%-([0-9A-Fa-f][0-9A-Fa-f])$")
  if not payload then
    return { ok = false, error = L["share.err.incomplete"] }
  end
  if hex2(crc8(payload)) ~= crcPart:upper() then
    return { ok = false, error = L["share.err.corrupt"] }
  end
  local out = {
    ok = true,
    kind = kind,
    code = (kind == "H" and PREFIX_HERITAGE or PREFIX) .. payload .. "-" .. crcPart:upper(),
    payload = payload
  }
  if kind == "C" then
    if payload:sub(1, 1) ~= KIND_CLASS then
      return { ok = false, error = L["share.err.kind"] }
    end
    local classId = C.ALPHABET:find(payload:sub(2, 2), 1, true)
    classId = classId and (classId - 1) or nil
    out.slug = classId and CLASS_SLUGS[classId] or nil
    if not out.slug then
      return { ok = false, error = L["share.err.class_in_code"] }
    end
  end
  return out
end

function SC.encode(cls, path)
  local payload = KIND_CLASS .. classChar(cls) .. path
  return PREFIX .. payload .. "-" .. hex2(crc8(payload))
end

function SC.decode(input)
  local code = tostring(input or ""):gsub("%s+", "")
  if code == "" then
    return { ok = false, error = L["share.err.empty_class"] }
  end
  if code:sub(1, #PREFIX_HERITAGE):upper() == PREFIX_HERITAGE then
    return { ok = false, error = L["share.err.is_heritage"] }
  end
  if code:sub(1, #PREFIX):upper() ~= PREFIX then
    return { ok = false, error = L["share.err.not_af_class"] }
  end
  local rest = code:sub(#PREFIX + 1)
  local payload, crcPart = rest:match("^(.+)%-([0-9A-Fa-f][0-9A-Fa-f])$")
  if not payload then
    return { ok = false, error = L["share.err.incomplete"] }
  end
  if hex2(crc8(payload)) ~= crcPart:upper() then
    return { ok = false, error = L["share.err.corrupt"] }
  end
  if payload:sub(1, 1) ~= KIND_CLASS then
    return { ok = false, error = L["share.err.kind"] }
  end
  local classIdx = C.ALPHABET:find(payload:sub(2, 2), 1, true)
  local classId = classIdx and (classIdx - 1) or nil
  local cls = classId and AF:GetClassData(classId) or nil
  if not cls then
    return { ok = false, error = L["share.err.class_or_catalog"] }
  end
  local path = payload:sub(3)
  local cat = BP.catalog(cls)
  local decoded = BP.decodePath(cat, path)
  if not decoded.ok then
    return { ok = false, error = Lf("share.err.catalog_changed", decoded.error) }
  end
  local check = BP.validateOrder(cat, decoded.order)
  if not check.ok then
    return { ok = false, error = Lf("share.err.impossible_order", check.step + 1, check.message) }
  end
  return {
    ok = true,
    cls = cls,
    order = decoded.order,
    talented = decoded.talented
  }
end
