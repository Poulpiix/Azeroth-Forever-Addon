-- (c) Poulpix, Azeroth Forever. All rights reserved. Text and data mining and AI training prohibited (noai, noimageai, EU Directive 2019/790 art. 4). See LICENSE.md.
-- Localization core. Loaded first (see the .toc), before every locale file and before any UI file.
--
-- Usage in the code:
--   local L, Lf, Lp = AF.L, AF.Lf, AF.Lp
--   L["tab.talents"]                      plain string
--   Lf("tip.rank", rank, maxRank)         string.format on the localized string
--   Lp("unit.dungeon", n, n)              plural: looks up "unit.dungeon.one" or "unit.dungeon.other"
--   local pre, post = AF.Lsplit(key)      splits a string around its single %s (label / value / label layouts)
--
-- Lookup order for a key: active locale (esMX also tries esES) -> enUS -> frFR -> the key itself.
-- A key can therefore never render as an empty string.
local ADDON_NAME, AF = ...

local registry = {}
local clientLocale = (type(GetLocale) == "function" and GetLocale()) or "enUS"
local active = clientLocale

local KNOWN = { "frFR", "enUS", "deDE", "esES", "esMX", "itIT", "koKR", "jaJP" }
local NEXT_IN_CHAIN = { esMX = "esES" }

-- Which counts use the ".one" form of a plural key. Default rule: n == 1.
local PLURAL_ONE = {
  frFR = function(n) return n < 2 end,
  koKR = function() return false end,
  jaJP = function() return false end
}

AF.missingKeys = {}

local function lookup(code, key)
  local t = registry[code]
  local v = t and t[key]
  if v ~= nil and v ~= "" then return v end
  return nil
end

-- Returns the string and the code of the locale that supplied it.
local function resolve(key)
  local code = active
  while code do
    local v = lookup(code, key)
    if v then return v, code end
    code = NEXT_IN_CHAIN[code]
  end
  local v = lookup("enUS", key)
  if v then return v, "enUS" end
  v = lookup("frFR", key)
  if v then return v, "frFR" end
  return nil
end

local L = setmetatable({}, {
  __index = function(_, key)
    local v = resolve(key)
    if v == nil then
      AF.missingKeys[key] = true
      return tostring(key)
    end
    return v
  end
})
AF.L = L

-- Optional lookup: the string, or nil when no locale has the key (never recorded as a missing key).
-- Used by Names.lua for keys built from data ids.
function AF.Lopt(key)
  return (resolve(key))
end

function AF:RegisterLocale(code, strings)
  registry[code] = strings
end

-- Positional tokens (%2$s) let a translation reorder its arguments (dates: 5/23/2026 vs 23/5/2026).
-- Resolved here so it never depends on the client string.format supporting them.
local function formatPositional(fmt, ...)
  if not fmt:find("%%%d+%$") then return string.format(fmt, ...) end
  local args, order = { ... }, {}
  local plain = fmt:gsub("%%(%d+)%$", function(n) order[#order + 1] = tonumber(n); return "%" end)
  local list = {}
  for i, n in ipairs(order) do list[i] = args[n] end
  return string.format(plain, unpack(list, 1, #order))
end

function AF.Lf(key, ...)
  local fmt = L[key]
  local ok, out = pcall(formatPositional, fmt, ...)
  if ok then return out end
  -- A broken token in a translation must never break the UI: retry with the source languages.
  for _, code in ipairs({ "enUS", "frFR" }) do
    local f = lookup(code, key)
    if f then
      local ok2, out2 = pcall(formatPositional, f, ...)
      if ok2 then return out2 end
    end
  end
  return fmt
end

function AF.Lp(key, n, ...)
  n = tonumber(n) or 0
  -- The plural rule follows the locale that supplies the string (a frFR fallback text needs the French rule).
  local _, code = resolve(key .. ".other")
  local rule = code and PLURAL_ONE[code]
  local isOne
  if rule then isOne = rule(n) else isOne = (n == 1) end
  local first, second = key .. (isOne and ".one" or ".other"), key .. (isOne and ".other" or ".one")
  local k = first
  if resolve(first) == nil and resolve(second) ~= nil then k = second end
  return AF.Lf(k, ...)
end

function AF.Lsplit(key)
  local s = L[key]
  local pre, post = s:match("^(.-)%%s(.*)$")
  if not pre then return s, "" end
  return (pre:gsub("%s+$", "")), (post:gsub("^%s+", ""))
end

-- Locale selection ------------------------------------------------------------

function AF:GetClientLocale() return clientLocale end
function AF:GetActiveLocale() return active end
function AF:GetKnownLocales() return KNOWN end

-- Language names as each language writes itself (endonyms, never translated) and the short code of the header button.
local NATIVE = {
  frFR = "Français", enUS = "English", deDE = "Deutsch", esES = "Español (España)", esMX = "Español (México)",
  itIT = "Italiano", koKR = "한국어", jaJP = "日本語"
}
local SHORT = { frFR = "FR", enUS = "EN", deDE = "DE", esES = "ES", esMX = "MX", itIT = "IT", koKR = "KO", jaJP = "JA" }
-- Scripts whose glyphs only exist in the client font of that same language.
local NEEDS_OWN_CLIENT = { koKR = true, jaJP = true }

function AF:GetLocaleNativeName(code) return NATIVE[code] or tostring(code) end
function AF:GetLocaleShort(code) return SHORT[code] or tostring(code):sub(1, 2):upper() end

-- A Korean or Japanese interface needs the game font of that language: on another client the text would show as boxes.
function AF:CanDisplayLocale(code)
  if not NEEDS_OWN_CLIENT[code] then return true end
  return clientLocale == code
end

-- Name of a language for menus: its own name when the client font can draw it, otherwise its name in the active language.
function AF:GetLocaleDisplayName(code)
  if self:CanDisplayLocale(code) then return self:GetLocaleNativeName(code) end
  return (self.Lopt("lang." .. code)) or code
end

-- The saved choice: a locale code, or nil when the addon follows the game language.
function AF:GetLocaleOverride()
  local opts = AzerothForeverDB and AzerothForeverDB.options
  return opts and self:NormalizeLocale(opts.locale) or nil
end

function AF:NormalizeLocale(text)
  local wanted = tostring(text or ""):lower()
  for _, code in ipairs(KNOWN) do
    if code:lower() == wanted then return code end
  end
  return nil
end

-- code = nil goes back to the client locale.
function AF:SetActiveLocale(code)
  active = code or clientLocale
end

-- Called once SavedVariables are available (ADDON_LOADED).
function AF:ApplyLocaleOverride()
  local opts = AzerothForeverDB and AzerothForeverDB.options
  local code = opts and self:NormalizeLocale(opts.locale)
  if code and not self:CanDisplayLocale(code) then code = nil end
  self:SetActiveLocale(code)
end
