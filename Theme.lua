-- (c) Poulpix, Azeroth Forever. All rights reserved. Text and data mining and AI training prohibited (noai, noimageai, EU Directive 2019/790 art. 4). See LICENSE.md.
local ADDON_NAME, AF = ...

local Theme = {}
AF.Theme = Theme

Theme.WHITE = "Interface\\Buttons\\WHITE8X8"
Theme.TEX = "Interface\\AddOns\\AzerothForever\\Textures\\"
Theme.FONTS = "Interface\\AddOns\\AzerothForever\\Fonts\\"

Theme.PALETTES = {
  alliance = {
    bg0 = 0x07121c, bg1 = 0x0b1a28, panel = 0x102433, panel2 = 0x163044,
    ink = 0xe8f0f6, inkMuted = 0xa9c0d0,
    accent = 0x3d7eb8, accentFill = 0x2f6a9e, accentFillHi = 0x3a7cb5, accentText = 0x7fb3e0,
    gold = 0xd7c38a, goldHi = 0xecdcaa,
    line = 0x3d5a72, lineStrong = 0x56789a, lineSoft = 0x23405a,
    bad = 0xd35b5b, badText = 0xec8080
  },
  horde = {
    bg0 = 0x14080b, bg1 = 0x1c0c10, panel = 0x2a1218, panel2 = 0x3a181f,
    ink = 0xf3e6df, inkMuted = 0xc7b0a6,
    accent = 0xc45c3a, accentFill = 0xa8472a, accentFillHi = 0xbb5533, accentText = 0xe88a66,
    gold = 0xe8b15a, goldHi = 0xf5cd8a,
    line = 0x6a3a28, lineStrong = 0x8a5238, lineSoft = 0x4a2419,
    bad = 0xd35b5b, badText = 0xee8a8a
  }
}

Theme.STATIC = {
  new = 0xf2c94c, changed = 0xff7a6b, same = 0xa9b8c4,
  good = 0x7dba6a, goodText = 0xa6e394,
  nodeIdle = 0x5f6d57, nodeLocked = 0x3a3a3a, nodeEmpty = 0x333333,
  rankBg = 0x0b0b0b, rankIdle = 0x555555, rankIdleText = 0xbdbdbd, rankLockedText = 0x9a9a9a,
  connector = 0x4d4538,
  black = 0x000000, white = 0xffffff,
  allianceOn = 0x24527e, allianceOnBorder = 0x6f9fcb,
  hordeOn = 0x8e3520, hordeOnBorder = 0xd18a52
}

Theme.CLASS_COLORS = {
  [1] = 0xc79c6e, [2] = 0xf58cba, [3] = 0xabd473, [4] = 0xfff569, [5] = 0xffffff,
  [7] = 0x0070de, [8] = 0x69ccf0, [9] = 0x9482c9, [11] = 0xff7d0a
}

Theme.faction = "alliance"

local function split(h)
  local r = math.floor(h / 0x10000) % 0x100
  local g = math.floor(h / 0x100) % 0x100
  local b = h % 0x100
  return r / 255, g / 255, b / 255
end

function Theme:RGB(token)
  if type(token) == "table" then return token[1], token[2], token[3] end
  if type(token) == "number" then return split(token) end
  if type(token) == "string" then
    local classId = token:match("^class:(%d+)$")
    if classId then return split(self.CLASS_COLORS[tonumber(classId)] or 0xffffff) end
    local pal = self.PALETTES[self.faction] or self.PALETTES.alliance
    local v = pal[token] or self.STATIC[token]
    if v then return split(v) end
  end
  return 1, 0, 1
end

function Theme:Hex(token)
  local r, g, b = self:RGB(token)
  return string.format("%02x%02x%02x", math.floor(r * 255 + 0.5), math.floor(g * 255 + 0.5), math.floor(b * 255 + 0.5))
end

function Theme:Wrap(text, token)
  return "|cff" .. self:Hex(token) .. tostring(text) .. "|r"
end

local painted = setmetatable({}, { __mode = "k" })
local listeners = {}

local function apply(obj, entry)
  local r, g, b = Theme:RGB(entry.token)
  if entry.kind == "text" then
    obj:SetTextColor(r, g, b, entry.alpha or 1)
  else
    obj:SetVertexColor(r, g, b, entry.alpha or 1)
  end
end

function Theme:PaintTex(tex, token, alpha)
  local entry = painted[tex]
  if entry then
    entry.kind, entry.token, entry.alpha = "tex", token, alpha
  else
    entry = { kind = "tex", token = token, alpha = alpha }
    painted[tex] = entry
  end
  apply(tex, entry)
  return tex
end

function Theme:PaintText(fs, token, alpha)
  local entry = painted[fs]
  if entry then
    entry.kind, entry.token, entry.alpha = "text", token, alpha
  else
    entry = { kind = "text", token = token, alpha = alpha }
    painted[fs] = entry
  end
  apply(fs, entry)
  return fs
end

function Theme:OnChange(fn)
  listeners[#listeners + 1] = fn
end

function Theme:SetFaction(faction)
  if faction ~= "horde" then faction = "alliance" end
  self.faction = faction
  for obj, entry in pairs(painted) do apply(obj, entry) end
  for _, fn in ipairs(listeners) do pcall(fn, faction) end
end

local FALLBACK = (type(STANDARD_TEXT_FONT) == "string" and STANDARD_TEXT_FONT) or "Fonts\\FRIZQT__.TTF"

local FONT_FILES = {
  display = "Cinzel-Bold.ttf",
  regular = "SourceSans3-Regular.ttf",
  semi = "SourceSans3-SemiBold.ttf",
  bold = "SourceSans3-Bold.ttf",
  mono = "JetBrainsMono-SemiBold.ttf"
}

local FONT_STYLES = {
  AF_Display20 = { "display", 20 },
  AF_Display15 = { "display", 15 },
  AF_Display14 = { "display", 14 },
  AF_Body13 = { "regular", 13 },
  AF_Body12 = { "regular", 12 },
  AF_Semi13 = { "semi", 13 },
  AF_Semi12 = { "semi", 12 },
  AF_Bold13 = { "bold", 13 },
  AF_Bold16 = { "bold", 16 },
  AF_Kicker10 = { "bold", 10 },
  AF_Kicker9 = { "bold", 9 },
  AF_Mono17 = { "mono", 17 },
  AF_Mono12 = { "mono", 12 },
  AF_Mono10 = { "mono", 10 }
}

Theme.fonts = {}

-- The bundled fonts (Cinzel, Source Sans 3, JetBrains Mono) only cover Latin. Cyrillic and CJK clients use the
-- client font, which has the glyphs: Cyrillic only for the display font, CJK for everything.
local function needsClientFont(family)
  local loc = type(GetLocale) == "function" and GetLocale() or ""
  if loc == "koKR" or loc == "zhCN" or loc == "zhTW" or loc == "jaJP" then return true end
  if loc == "ruRU" and family == "display" then return true end
  return false
end

local function makeFont(name, family, size)
  local font = _G[name] or CreateFont(name)
  local ok = true
  if not needsClientFont(family) then ok = font:SetFont(Theme.FONTS .. FONT_FILES[family], size, "") end
  local path = font.GetFont and font:GetFont()
  if ok == false or not path or needsClientFont(family) then
    font:SetFont(FALLBACK, size, "")
  end
  if font.SetShadowOffset then font:SetShadowOffset(0, 0) end
  return font
end

function Theme:InitFonts()
  if self.fontsReady then return end
  for name, def in pairs(FONT_STYLES) do
    self.fonts[name] = makeFont(name, def[1], def[2])
  end
  self.fontsReady = true
end

function Theme:Font(name)
  if not self.fontsReady then self:InitFonts() end
  return self.fonts[name] or self.fonts.AF_Body12
end

function Theme:Tex(key)
  return self.TEX .. key .. ".tga"
end
