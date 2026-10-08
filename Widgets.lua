-- (c) Poulpix, Azeroth Forever. All rights reserved. Text and data mining and AI training prohibited (noai, noimageai, EU Directive 2019/790 art. 4). See LICENSE.md.
local ADDON_NAME, AF = ...

local W = {}
AF.Widgets = W

local L = AF.L
local T = AF.Theme

function W.Tex(parent, layer, token, alpha, sublevel)
  local t = parent:CreateTexture(nil, layer or "ARTWORK")
  t:SetTexture(T.WHITE)
  if sublevel and t.SetDrawLayer then t:SetDrawLayer(layer or "ARTWORK", sublevel) end
  if token then T:PaintTex(t, token, alpha) end
  return t
end

function W.Image(parent, layer, key, token, alpha, sublevel)
  local t = parent:CreateTexture(nil, layer or "ARTWORK")
  t:SetTexture(T:Tex(key))
  if sublevel and t.SetDrawLayer then t:SetDrawLayer(layer or "ARTWORK", sublevel) end
  if token then T:PaintTex(t, token, alpha) end
  return t
end

function W.Fill(frame, token, alpha)
  local bg = W.Tex(frame, "BACKGROUND", token, alpha, -7)
  bg:SetAllPoints(frame)
  frame.afFill = bg
  return bg
end

function W.Border(frame, token, alpha, th, layer)
  th = th or 1
  local strips = {}
  local function strip()
    local s = W.Tex(frame, layer or "BORDER", token, alpha)
    strips[#strips + 1] = s
    return s
  end
  local top, bottom, left, right = strip(), strip(), strip(), strip()
  top:SetPoint("TOPLEFT", 0, 0); top:SetPoint("TOPRIGHT", 0, 0); top:SetHeight(th)
  bottom:SetPoint("BOTTOMLEFT", 0, 0); bottom:SetPoint("BOTTOMRIGHT", 0, 0); bottom:SetHeight(th)
  left:SetPoint("TOPLEFT", 0, 0); left:SetPoint("BOTTOMLEFT", 0, 0); left:SetWidth(th)
  right:SetPoint("TOPRIGHT", 0, 0); right:SetPoint("BOTTOMRIGHT", 0, 0); right:SetWidth(th)
  local b = {}
  function b:SetToken(tok, a)
    for _, s in ipairs(strips) do T:PaintTex(s, tok, a) end
  end
  function b:Show() for _, s in ipairs(strips) do s:Show() end end
  function b:Hide() for _, s in ipairs(strips) do s:Hide() end end
  return b
end

function W.Text(parent, font, token, justify, layer, alpha)
  local fs = parent:CreateFontString(nil, layer or "OVERLAY")
  fs:SetFontObject(T:Font(font or "AF_Body12"))
  fs:SetJustifyH(justify or "LEFT")
  if fs.SetJustifyV then fs:SetJustifyV("MIDDLE") end
  if fs.SetWordWrap then fs:SetWordWrap(false) end
  T:PaintText(fs, token or "ink", alpha)
  return fs
end

function W.Paragraph(parent, font, token, width)
  local fs = W.Text(parent, font, token, "LEFT")
  fs:SetWidth(width)
  if fs.SetWordWrap then fs:SetWordWrap(true) end
  if fs.SetJustifyV then fs:SetJustifyV("TOP") end
  if fs.SetSpacing then fs:SetSpacing(2) end
  return fs
end

function W.TextHeight(fs, fallback)
  local h = fs.GetStringHeight and fs:GetStringHeight()
  if not h or h <= 0 then return fallback or 14 end
  return h
end

function W.WrappedHeight(fs, width)
  local measured = W.TextHeight(fs, 14)
  local _, size = fs:GetFont()
  size = size or 12
  local lineH = size * 1.25 + 2
  local full = (fs.GetUnboundedStringWidth and fs:GetUnboundedStringWidth()) or W.TextWidth(fs, 0)
  if not width or width <= 0 or not full or full <= 0 then return measured end
  local nLines = 1
  for _ in (fs:GetText() or ""):gmatch("\n") do nLines = nLines + 1 end
  local minLines = math.max(nLines, math.ceil(full / width - 0.02))
  if measured < (minLines * lineH - 2) * 0.8 then
    return math.max(nLines, math.ceil(full * 1.1 / width)) * lineH - 2
  end
  return measured
end

function W.TextWidth(fs, fallback)
  local w = fs.GetStringWidth and fs:GetStringWidth()
  if not w or w <= 0 then return fallback or 40 end
  return w
end

function W.Card(parent, variant)
  local f = CreateFrame("Frame", nil, parent)
  W.Fill(f, variant or "panel")
  f.afBorder = W.Border(f, "line")
  local hl = W.Tex(f, "BORDER", "gold", 0.28, 1)
  hl:SetPoint("TOPLEFT", 1, -1); hl:SetPoint("TOPRIGHT", -1, -1); hl:SetHeight(1)
  return f
end

local function simpleTip(owner, text)
  if not text then return end
  W.Tip:Start(owner, true)
  W.Tip:Line(text, "ink")
  W.Tip:Finish()
end

local VARIANTS = {
  standard = { bg = "panel2", bgA = 1, border = "lineStrong", text = "ink", hBg = "panel2", hBgA = 1, hBorder = "gold", hText = "ink" },
  primary = { bg = "accentFill", bgA = 1, border = "gold", text = "white", hBg = "accentFillHi", hBgA = 1, hBorder = "goldHi", hText = "white" },
  ghost = { bg = "panel", bgA = 0, border = "line", text = "inkMuted", hBg = "panel", hBgA = 1, hBorder = "lineStrong", hText = "ink" },
  link = { bg = "panel", bgA = 0, border = "line", borderA = 0, text = "accentText", hBg = "panel", hBgA = 0, hBorder = "line", hBorderA = 0, hText = "goldHi" }
}

local function refreshButton(btn)
  local v = VARIANTS[btn.variant] or VARIANTS.standard
  local hover = btn.hover and not btn.disabled
  T:PaintTex(btn.afFill, hover and v.hBg or v.bg, hover and v.hBgA or v.bgA)
  btn.afBorder:SetToken(hover and v.hBorder or v.border, hover and (v.hBorderA or 1) or (v.borderA or 1))
  local textTok = hover and v.hText or v.text
  T:PaintText(btn.label, textTok)
  if btn.icon then T:PaintTex(btn.icon, textTok) end
  if btn.caret then T:PaintTex(btn.caret, textTok) end
  btn:SetAlpha(btn.disabled and 0.45 or 1)
end

function W.Button(parent, opts)
  opts = opts or {}
  local btn = CreateFrame("Button", nil, parent)
  btn.variant = opts.variant or "standard"
  btn:SetHeight(opts.height or 26)
  W.Fill(btn, "panel2")
  btn.afBorder = W.Border(btn, "lineStrong")

  local label = W.Text(btn, opts.font or "AF_Semi12", "ink", "CENTER")
  btn.label = label
  local padding = opts.padding or 12
  local iconSize = opts.iconSize or 14
  local lead = 0
  if opts.icon then
    local icon = btn:CreateTexture(nil, "ARTWORK")
    icon:SetSize(iconSize, iconSize)
    icon:SetTexture(T:Tex(opts.icon))
    btn.icon = icon
    lead = iconSize + (opts.text and opts.text ~= "" and 6 or 0)
  end
  local trail = 0
  if opts.caret then
    local caret = btn:CreateTexture(nil, "ARTWORK")
    caret:SetTexture(T:Tex("ui_caret"))
    caret:SetSize(10, 10)
    btn.caret = caret
    trail = 16
  end

  function btn:SetLabel(text)
    label:SetText(text or "")
    local tw = (text and text ~= "") and W.TextWidth(label, 8 * #text) or 0
    if not opts.width then
      self:SetWidth(math.floor(tw + lead + trail + 2 * padding + 0.5))
    end
    local content = lead + tw + trail
    local x0 = -content / 2
    if self.icon then
      self.icon:ClearAllPoints()
      self.icon:SetPoint("LEFT", self, "CENTER", x0, 0)
    end
    label:ClearAllPoints()
    label:SetPoint("LEFT", self, "CENTER", x0 + lead, 0)
    if self.caret then
      self.caret:ClearAllPoints()
      self.caret:SetPoint("LEFT", self, "CENTER", x0 + lead + tw + 6, -1)
    end
  end

  function btn:SetDisabled(v) self.disabled = v and true or false; refreshButton(self) end
  function btn:SetVariant(v) self.variant = v; refreshButton(self) end
  function btn:Refresh() refreshButton(self) end

  if opts.width then btn:SetWidth(opts.width) end
  btn:SetLabel(opts.text or "")
  btn:RegisterForClicks("LeftButtonUp", "RightButtonUp")
  btn:SetScript("OnEnter", function(self)
    self.hover = true
    refreshButton(self)
    if opts.tooltip then simpleTip(self, opts.tooltip) end
  end)
  btn:SetScript("OnLeave", function(self)
    self.hover = false
    refreshButton(self)
    if opts.tooltip then W.Tip:Hide() end
  end)
  btn:SetScript("OnClick", function(self, mouseButton)
    if self.disabled then return end
    if opts.onClick then opts.onClick(self, mouseButton) end
  end)
  refreshButton(btn)
  return btn
end

function W.IconButton(parent, key, size, onClick, tooltip)
  return W.Button(parent, { variant = "ghost", icon = key, iconSize = math.floor(size * 0.6), width = size, height = size, onClick = onClick, tooltip = tooltip })
end

function W.Switch(parent, text, onToggle)
  local btn = CreateFrame("Button", nil, parent)
  btn:SetHeight(26)
  W.Fill(btn, "panel", 0)
  btn.afBorder = W.Border(btn, "line")
  local rail = CreateFrame("Frame", nil, btn)
  rail:SetSize(28, 14)
  rail:SetPoint("LEFT", 8, 0)
  rail.fill = W.Fill(rail, "bg0")
  rail.border = W.Border(rail, "lineStrong")
  local knob = W.Image(rail, "OVERLAY", "ui_circle", "inkMuted")
  knob:SetSize(10, 10)
  local label = W.Text(btn, "AF_Semi12", "inkMuted")
  label:SetPoint("LEFT", rail, "RIGHT", 8, 0)
  label:SetText(text)
  btn:SetWidth(math.floor(8 + 28 + 8 + W.TextWidth(label, 90) + 12))

  function btn:SetChecked(on)
    self.checked = on and true or false
    knob:ClearAllPoints()
    if self.checked then
      knob:SetPoint("RIGHT", rail, "RIGHT", -2, 0)
      T:PaintTex(knob, "white")
      T:PaintTex(rail.fill, "accentFill")
      self.afBorder:SetToken("gold")
      T:PaintText(label, "ink")
    else
      knob:SetPoint("LEFT", rail, "LEFT", 2, 0)
      T:PaintTex(knob, "inkMuted")
      T:PaintTex(rail.fill, "bg0")
      self.afBorder:SetToken(self.hover and "lineStrong" or "line")
      T:PaintText(label, self.hover and "ink" or "inkMuted")
    end
  end
  btn:SetScript("OnEnter", function(self) self.hover = true; self:SetChecked(self.checked) end)
  btn:SetScript("OnLeave", function(self) self.hover = false; self:SetChecked(self.checked) end)
  btn:SetScript("OnClick", function(self)
    self:SetChecked(not self.checked)
    if onToggle then onToggle(self.checked) end
  end)
  btn:SetChecked(false)
  return btn
end

function W.Checkbox(parent, text, onToggle, tooltip)
  local btn = CreateFrame("Button", nil, parent)
  btn:SetHeight(18)
  local box = CreateFrame("Frame", nil, btn)
  box:SetSize(14, 14)
  box:SetPoint("LEFT", 0, 0)
  box.fill = W.Fill(box, "bg0")
  box.border = W.Border(box, "lineStrong")
  local check = W.Image(box, "OVERLAY", "ui_check", "white")
  check:SetSize(12, 12)
  check:SetPoint("CENTER", 0, 0)
  local label = W.Text(btn, "AF_Body12", "inkMuted")
  label:SetPoint("LEFT", box, "RIGHT", 6, 0)
  label:SetText(text)
  btn:SetWidth(math.floor(20 + W.TextWidth(label, 160)))
  function btn:SetChecked(on)
    self.checked = on and true or false
    if self.checked then
      check:Show(); T:PaintTex(box.fill, "accentFill"); box.border:SetToken("gold")
    else
      check:Hide(); T:PaintTex(box.fill, "bg0"); box.border:SetToken(self.hover and "gold" or "lineStrong")
    end
  end
  btn:SetScript("OnEnter", function(self)
    self.hover = true; self:SetChecked(self.checked); T:PaintText(label, "ink")
    if tooltip then simpleTip(self, tooltip) end
  end)
  btn:SetScript("OnLeave", function(self)
    self.hover = false; self:SetChecked(self.checked); T:PaintText(label, "inkMuted")
    if tooltip then W.Tip:Hide() end
  end)
  btn:SetScript("OnClick", function(self)
    self:SetChecked(not self.checked)
    if onToggle then onToggle(self.checked) end
  end)
  btn:SetChecked(false)
  return btn
end

function W.Segmented(parent, items, onChange, height, font)
  local f = CreateFrame("Frame", nil, parent)
  height = height or 24
  f:SetHeight(height)
  f.border = W.Border(f, "lineStrong", 1, 1, "OVERLAY")
  f.buttons = {}
  local x = 1
  for i, item in ipairs(items) do
    local b = CreateFrame("Button", nil, f)
    b.key = item.key
    b:SetHeight(height - 2)
    b:SetPoint("TOPLEFT", x, -1)
    b.fill = W.Fill(b, "panel2")
    b.label = W.Text(b, font or "AF_Semi12", "inkMuted", "CENTER")
    b.label:SetPoint("CENTER", 0, 0)
    b.label:SetText(item.label)
    local w = item.width or math.floor(W.TextWidth(b.label, 8 * #item.label) + 24)
    b:SetWidth(w)
    x = x + w
    if i < #items then
      local sep = W.Tex(f, "OVERLAY", "lineStrong")
      sep:SetWidth(1)
      sep:SetPoint("TOPLEFT", x, -1)
      sep:SetPoint("BOTTOMLEFT", x, 1)
      x = x + 1
    end
    b:SetScript("OnEnter", function(self) if f.value ~= self.key then T:PaintText(self.label, "ink") end end)
    b:SetScript("OnLeave", function(self) if f.value ~= self.key then T:PaintText(self.label, "inkMuted") end end)
    b:SetScript("OnClick", function(self)
      if f.value == self.key then return end
      f:SetValue(self.key)
      if onChange then onChange(self.key) end
    end)
    f.buttons[#f.buttons + 1] = b
  end
  f:SetWidth(x + 1)
  function f:SetValue(key)
    self.value = key
    for _, b in ipairs(self.buttons) do
      if b.key == key then
        T:PaintTex(b.fill, "accentFill"); T:PaintText(b.label, "white")
      else
        T:PaintTex(b.fill, "panel2"); T:PaintText(b.label, "inkMuted")
      end
    end
  end
  return f
end

function W.Slider(parent, minV, maxV, onChange, fillToken)
  local f = CreateFrame("Frame", nil, parent)
  f:SetHeight(28)
  f.min, f.max, f.value = minV, maxV, maxV
  local rail = W.Tex(f, "ARTWORK", "bg0")
  rail:SetHeight(6)
  local inset = 30
  rail:SetPoint("LEFT", inset, 0)
  rail:SetPoint("RIGHT", -inset, 0)
  f.rail = rail
  local railBorder = CreateFrame("Frame", nil, f)
  railBorder:SetPoint("TOPLEFT", rail, "TOPLEFT", 0, 0)
  railBorder:SetPoint("BOTTOMRIGHT", rail, "BOTTOMRIGHT", 0, 0)
  W.Border(railBorder, "lineSoft")
  local fill = W.Tex(f, "ARTWORK", fillToken or "gold", 1, 1)
  fill:SetHeight(6)
  fill:SetPoint("LEFT", rail, "LEFT", 0, 0)
  fill:SetWidth(1)
  f.fill = fill
  local thumb = W.Image(f, "OVERLAY", "ui_circle", fillToken or "gold")
  thumb:SetSize(14, 14)
  f.thumb = thumb
  local lo = W.Text(f, "AF_Mono10", "inkMuted", "LEFT")
  local hi = W.Text(f, "AF_Mono10", "inkMuted", "RIGHT")
  lo:SetPoint("RIGHT", rail, "LEFT", -12, 0)
  hi:SetPoint("LEFT", rail, "RIGHT", 12, 0)
  lo:SetText(tostring(minV))
  hi:SetText(tostring(maxV))

  function f:SetFillToken(tok)
    T:PaintTex(fill, tok)
    T:PaintTex(thumb, tok)
  end

  function f:Layout()
    local w = rail:GetWidth()
    if not w or w <= 0 then w = (self:GetWidth() or 200) - 2 * inset end
    local frac = (self.max > self.min) and (self.value - self.min) / (self.max - self.min) or 1
    local x = math.floor(w * frac + 0.5)
    fill:SetWidth(math.max(1, x))
    thumb:ClearAllPoints()
    thumb:SetPoint("CENTER", rail, "LEFT", x, 0)
  end

  function f:SetValue(v, fromUser)
    v = math.max(self.min, math.min(self.max, math.floor(v + 0.5)))
    local changed = v ~= self.value
    self.value = v
    self:Layout()
    if changed and fromUser and onChange then onChange(v) end
  end

  local hit = CreateFrame("Frame", nil, f)
  hit:SetPoint("TOPLEFT", rail, "TOPLEFT", -8, 10)
  hit:SetPoint("BOTTOMRIGHT", rail, "BOTTOMRIGHT", 8, -10)
  hit:EnableMouse(true)
  if hit.EnableMouseWheel then hit:EnableMouseWheel(true) end
  local function fromCursor()
    local scale = hit:GetEffectiveScale()
    local left = rail:GetLeft()
    local w = rail:GetWidth()
    if not scale or scale == 0 or not left or not w or w <= 0 then return end
    local cx = GetCursorPosition() / scale
    local frac = math.max(0, math.min(1, (cx - left) / w))
    f:SetValue(f.min + frac * (f.max - f.min), true)
  end
  hit:SetScript("OnMouseDown", function(self)
    self.dragging = true
    fromCursor()
    self:SetScript("OnUpdate", function(s) if s.dragging then fromCursor() end end)
  end)
  hit:SetScript("OnMouseUp", function(self)
    self.dragging = false
    self:SetScript("OnUpdate", nil)
  end)
  hit:SetScript("OnMouseWheel", function(self, delta)
    f:SetValue(f.value + (delta > 0 and 1 or -1), true)
  end)
  f:SetScript("OnSizeChanged", function(self) self:Layout() end)

  -- Disabled: no mouse, no wheel, dimmed. The value stays where the caller puts it.
  f.enabled = true
  function f:SetEnabled(on)
    on = on and true or false
    self.enabled = on
    hit.dragging = false
    hit:SetScript("OnUpdate", nil)
    hit:EnableMouse(on)
    if hit.EnableMouseWheel then hit:EnableMouseWheel(on) end
    self:SetAlpha(on and 1 or 0.35)
  end
  return f
end

local CAP_TOP, BASELINE = 0.1, 0.76

local function fontSize(fs, default)
  local _, size = fs:GetFont()
  return size or default
end

function W.Stat(parent, kicker, opts)
  opts = opts or {}
  local f = CreateFrame("Frame", nil, parent)
  local k = W.Text(f, "AF_Kicker10", "inkMuted")
  k:SetPoint("TOPLEFT", 0, 0)
  k:SetText(kicker)
  f.kicker = k
  local v = W.Text(f, opts.valueFont or "AF_Mono17", "ink")
  v:SetPoint("TOPLEFT", k, "BOTTOMLEFT", 0, -3)
  f.value = v
  local s = W.Text(f, "AF_Mono12", "inkMuted")
  s:SetPoint("BOTTOMLEFT", v, "BOTTOMRIGHT", 3, 1)
  f.suffix = s
  local kS, vS = fontSize(k, 10), fontSize(v, 17)
  local descent = vS * (1 - BASELINE)
  f:SetSize(opts.width or 80, kS + 3 + vS)
  if opts.bar then
    local rail = W.Tex(f, "ARTWORK", "bg0")
    rail:SetHeight(4)
    rail:SetPoint("TOPLEFT", v, "BOTTOMLEFT", 0, descent - 2)
    rail:SetWidth(opts.barWidth or math.max(60, math.floor(W.TextWidth(k, 90) + 0.5)))
    local fill = W.Image(f, "ARTWORK", "ui_hgrad", "gold", 1, 1)
    fill:SetTexCoord(1, 0, 0, 1)
    fill:SetHeight(4)
    fill:SetPoint("LEFT", rail, "LEFT", 0, 0)
    local base = W.Tex(f, "ARTWORK", "accent", 1, 0)
    base:SetHeight(4)
    base:SetPoint("LEFT", rail, "LEFT", 0, 0)
    f.barRail, f.barFill, f.barBase = rail, fill, base
  end
  if opts.pips then
    f.pips = {}
    for i = 1, opts.pips do
      local p = CreateFrame("Frame", nil, f)
      p:SetSize(8, 8)
      p:SetPoint("TOPLEFT", v, "BOTTOMLEFT", (i - 1) * 10, descent - 4)
      p.fill = W.Fill(p, "bg0")
      p.border = W.Border(p, "lineStrong")
      f.pips[i] = p
    end
  end
  function f:Fit()
    if opts.width then return end
    local w = W.TextWidth(k, 40)
    local vw = W.TextWidth(v, 10) + ((s:GetText() or "") ~= "" and (3 + W.TextWidth(s, 10)) or 0)
    if vw > w then w = vw end
    if self.barRail then w = math.max(w, self.barRail:GetWidth() or 0) end
    if self.pips then w = math.max(w, #self.pips * 10 - 2) end
    self:SetWidth(math.floor(w + 0.5))
  end
  function f:Set(value, suffix)
    v:SetText(tostring(value))
    s:SetText(suffix or "")
    self:Fit()
  end
  function f:VisualSpan()
    local baseline = kS + 3 + vS * BASELINE
    local bottom = self.pips and (baseline + 4 + 8) or baseline
    return kS * CAP_TOP, bottom
  end
  function f:SetBar(frac)
    if not self.barRail then return end
    local w = self.barRail:GetWidth() or 100
    local px = math.max(0, math.min(w, math.floor(w * frac + 0.5)))
    if px < 1 then
      self.barFill:Hide(); self.barBase:Hide()
    else
      self.barFill:Show(); self.barBase:Show()
      self.barFill:SetWidth(px); self.barBase:SetWidth(px)
    end
  end
  function f:SetPips(n)
    for i, p in ipairs(self.pips or {}) do
      if i <= n then
        T:PaintTex(p.fill, "gold"); p.border:SetToken("goldHi")
      else
        T:PaintTex(p.fill, "bg0"); p.border:SetToken("lineStrong")
      end
    end
  end
  return f
end

function W.LayoutStats(parent, stats, x, gap)
  local top, bottom = math.huge, 0
  for _, st in ipairs(stats) do
    local t, b = st:VisualSpan()
    top, bottom = math.min(top, t), math.max(bottom, b)
  end
  local lift = math.floor((top + bottom) / 2 + 0.5)
  for i, st in ipairs(stats) do
    st:ClearAllPoints()
    if i == 1 then
      st:SetPoint("TOPLEFT", parent, "LEFT", x, lift)
    else
      st:SetPoint("TOPLEFT", stats[i - 1], "TOPRIGHT", gap, 0)
    end
  end
  return stats[#stats]
end

local GLYPHS = { star = "ui_star", diamond = "ui_diamond" }

function W.Badge(parent, text, token, glyph, font)
  local f = CreateFrame("Frame", nil, parent)
  f:SetHeight(18)
  f.fill = W.Fill(f, "black", 0.25)
  f.border = W.Border(f, token)
  f.glyph = f:CreateTexture(nil, "OVERLAY")
  f.glyph:SetSize(9, 9)
  f.glyph:SetPoint("LEFT", 6, 0)
  f.label = W.Text(f, font or "AF_Semi12", token)
  function f:SetBadge(txt, tok, gl)
    self.label:SetText(txt)
    T:PaintText(self.label, tok)
    self.border:SetToken(tok)
    self.label:ClearAllPoints()
    if gl and GLYPHS[gl] then
      self.glyph:SetTexture(T:Tex(GLYPHS[gl]))
      T:PaintTex(self.glyph, tok)
      self.glyph:Show()
      self.label:SetPoint("LEFT", self.glyph, "RIGHT", 4, 0)
      self:SetWidth(math.ceil(6 + 9 + 4 + W.TextWidth(self.label, 7 * #txt) + 8))
    else
      self.glyph:Hide()
      self.label:SetPoint("LEFT", 7, 0)
      self:SetWidth(math.ceil(W.TextWidth(self.label, 7 * #txt) + 15))
    end
  end
  f:SetBadge(text, token, glyph)
  return f
end

function W.Chip(parent, text, count, onClick)
  local b = CreateFrame("Button", nil, parent)
  b:SetHeight(24)
  b.fill = W.Fill(b, "bg1")
  b.border = W.Border(b, "line")
  b.label = W.Text(b, "AF_Semi12", "inkMuted")
  b.label:SetPoint("LEFT", 10, 0)
  b.label:SetText(text)
  b.count = W.Text(b, "AF_Mono10", "inkMuted")
  b.count:SetPoint("LEFT", b.label, "RIGHT", 6, 0)
  b.count:SetText(count and tostring(count) or "")
  b:SetWidth(math.floor(10 + W.TextWidth(b.label, 40) + (count and (6 + W.TextWidth(b.count, 14)) or 0) + 10))
  function b:SetActive(on)
    self.active = on
    if on then
      T:PaintTex(self.fill, "panel2"); self.border:SetToken("gold")
      T:PaintText(self.label, "ink"); T:PaintText(self.count, "gold")
    else
      T:PaintTex(self.fill, "bg1"); self.border:SetToken(self.hover and "lineStrong" or "line")
      T:PaintText(self.label, self.hover and "ink" or "inkMuted"); T:PaintText(self.count, "inkMuted")
    end
  end
  b:SetScript("OnEnter", function(self) self.hover = true; self:SetActive(self.active) end)
  b:SetScript("OnLeave", function(self) self.hover = false; self:SetActive(self.active) end)
  b:SetScript("OnClick", function(self) if onClick then onClick(self) end end)
  b:SetActive(false)
  return b
end

function W.EditBox(parent, height, font)
  local holder = CreateFrame("Frame", nil, parent)
  holder:SetHeight(height or 26)
  holder.fill = W.Fill(holder, "bg0")
  holder.border = W.Border(holder, "lineStrong")
  local eb = CreateFrame("EditBox", nil, holder)
  eb:SetPoint("TOPLEFT", 8, 0)
  eb:SetPoint("BOTTOMRIGHT", -8, 0)
  eb:SetFontObject(T:Font(font or "AF_Mono12"))
  if eb.SetTextColor then eb:SetTextColor(T:RGB("ink")) end
  eb:SetAutoFocus(false)
  eb:SetMaxLetters(600)
  eb:SetScript("OnEditFocusGained", function() holder.border:SetToken("gold") end)
  eb:SetScript("OnEditFocusLost", function() holder.border:SetToken("lineStrong") end)
  eb:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
  T:OnChange(function() if eb.SetTextColor then eb:SetTextColor(T:RGB("ink")) end end)
  holder.edit = eb
  return holder
end

function W.Scroll(parent)
  local holder = CreateFrame("Frame", nil, parent)
  local sf = CreateFrame("ScrollFrame", nil, holder)
  sf:SetPoint("TOPLEFT", 0, 0)
  sf:SetPoint("BOTTOMRIGHT", -12, 0)
  local content = CreateFrame("Frame", nil, sf)
  content:SetSize(1, 1)
  sf:SetScrollChild(content)
  holder.scroll, holder.content = sf, content
  holder.offset = 0

  local track = W.Tex(holder, "ARTWORK", "bg0")
  track:SetWidth(6)
  track:SetPoint("TOPRIGHT", 0, 0)
  track:SetPoint("BOTTOMRIGHT", 0, 0)
  local thumb = CreateFrame("Frame", nil, holder)
  thumb:SetWidth(6)
  thumb.tex = W.Fill(thumb, "lineStrong")
  thumb:EnableMouse(true)
  holder.track, holder.thumb = track, thumb

  function holder:ViewHeight()
    local h = sf:GetHeight()
    if not h or h <= 0 then h = self:GetHeight() or 1 end
    return h
  end

  function holder:MaxOffset()
    return math.max(0, (self.contentHeight or 0) - self:ViewHeight())
  end

  function holder:UpdateBar()
    local view, total = self:ViewHeight(), self.contentHeight or 0
    if total <= view + 1 then
      thumb:Hide(); track:Hide()
      return
    end
    track:Show(); thumb:Show()
    local h = math.max(24, math.floor(view * view / total))
    thumb:SetHeight(h)
    local y = math.floor((view - h) * (self.offset / self:MaxOffset()) + 0.5)
    thumb:ClearAllPoints()
    thumb:SetPoint("TOPRIGHT", holder, "TOPRIGHT", 0, -y)
  end

  function holder:SetOffset(y)
    y = math.max(0, math.min(self:MaxOffset(), y or 0))
    self.offset = y
    sf:SetVerticalScroll(y)
    self:UpdateBar()
  end

  function holder:SetContentHeight(h)
    self.contentHeight = h
    content:SetHeight(math.max(1, h))
    local w = sf:GetWidth()
    if w and w > 0 then content:SetWidth(w) end
    self:SetOffset(self.offset)
  end

  function holder:ContentWidth()
    local w = sf:GetWidth()
    if not w or w <= 0 then w = (self:GetWidth() or 100) - 12 end
    return w
  end

  if sf.EnableMouseWheel then sf:EnableMouseWheel(true) end
  sf:SetScript("OnMouseWheel", function(_, delta)
    holder:SetOffset(holder.offset - delta * 40)
  end)
  thumb:SetScript("OnEnter", function() T:PaintTex(thumb.tex, "gold") end)
  thumb:SetScript("OnLeave", function() if not thumb.dragging then T:PaintTex(thumb.tex, "lineStrong") end end)
  thumb:SetScript("OnMouseDown", function(self)
    local scale = self:GetEffectiveScale()
    local _, cy = GetCursorPosition()
    self.dragging = true
    self.startY = cy / scale
    self.startOffset = holder.offset
    self:SetScript("OnUpdate", function(s)
      local _, y = GetCursorPosition()
      local dy = s.startY - y / scale
      local view = holder:ViewHeight()
      local range = view - s:GetHeight()
      if range > 0 then holder:SetOffset(s.startOffset + dy * holder:MaxOffset() / range) end
    end)
  end)
  thumb:SetScript("OnMouseUp", function(self)
    self.dragging = false
    self:SetScript("OnUpdate", nil)
    T:PaintTex(self.tex, "lineStrong")
  end)
  holder:SetScript("OnSizeChanged", function(self) self:SetContentHeight(self.contentHeight or 0) end)
  return holder
end

local Tip = CreateFrame("Frame", "AzerothForeverTip", UIParent)
W.Tip = Tip
Tip:SetFrameStrata("TOOLTIP")
Tip:SetClampedToScreen(true)
Tip:Hide()
Tip.width = 300
Tip.lines = {}
Tip.used = 0

local function relayoutTip(self)
  self.relayout = self.relayout - 1
  self:Layout()
  if self.relayout <= 0 then self:SetScript("OnUpdate", nil) end
end

local tipBuilt = false
local function buildTip()
  if tipBuilt then return end
  tipBuilt = true
  W.Fill(Tip, "bg1", 0.97)
  W.Border(Tip, "line")
  local hl = W.Tex(Tip, "BORDER", "gold", 0.28, 1)
  hl:SetPoint("TOPLEFT", 1, -1); hl:SetPoint("TOPRIGHT", -1, -1); hl:SetHeight(1)
  Tip.badge = W.Badge(Tip, "", "new", nil, "AF_Semi12")
  Tip.badge:Hide()
  Tip.sep = W.Tex(Tip, "ARTWORK", "line")
  Tip.sep:SetHeight(1)
  Tip.sep:Hide()
end

local function nextLine(font)
  Tip.used = Tip.used + 1
  local fs = Tip.lines[Tip.used]
  if not fs then
    fs = W.Text(Tip, font or "AF_Body12", "ink")
    if fs.SetWordWrap then fs:SetWordWrap(true) end
    if fs.SetSpacing then fs:SetSpacing(2) end
    Tip.lines[Tip.used] = fs
  end
  fs:SetFontObject(T:Font(font or "AF_Body12"))
  if fs.SetWordWrap then fs:SetWordWrap(true) end
  if fs.SetMaxLines then fs:SetMaxLines(0) end
  if fs.SetJustifyV then fs:SetJustifyV("TOP") end
  fs:SetWidth(Tip.width - 24)
  fs:Show()
  return fs
end

function Tip:Start(owner, compact)
  buildTip()
  self.owner = owner
  self.compact = compact and true or false
  self.width = 300
  self.used = 0
  self.items = {}
  for _, fs in ipairs(self.lines) do fs:Hide() end
  self.badge:Hide()
  self.sep:Hide()
end

function Tip:Title(text, token)
  local fs = nextLine("AF_Bold13")
  fs:SetText(text)
  T:PaintText(fs, token or "new")
  self.items[#self.items + 1] = { fs = fs, gap = 0 }
end

function Tip:Line(text, token, font, gap)
  local fs = nextLine(font)
  fs:SetText(text)
  T:PaintText(fs, token or "ink")
  self.items[#self.items + 1] = { fs = fs, gap = gap or 4 }
  return fs
end

function Tip:Meta(text, badgeText, badgeToken)
  local fs = self:Line(text, "inkMuted", "AF_Body12", 3)
  if badgeText then
    if fs.SetWordWrap then fs:SetWordWrap(false) end
    fs:SetWidth(math.ceil(W.TextWidth(fs, 60)) + 8)
    self.items[#self.items].fixedWidth = true
    self.items[#self.items].badge = true
    self.badge:SetBadge(badgeText, badgeToken)
    self.badge:ClearAllPoints()
    self.badge:SetPoint("LEFT", fs, "RIGHT", 6, 0)
    self.badge:Show()
  end
end

function Tip:Sep()
  self.items[#self.items + 1] = { sep = true, gap = 7 }
end

function Tip:Layout()
  local PAD_X = 12
  if self.single then
    local fs = self.items[1].fs
    local _, size = fs:GetFont()
    fs:ClearAllPoints()
    fs:SetPoint("LEFT", self, "LEFT", PAD_X, 0)
    self:SetSize(self.width, math.ceil((size or 12) + 12))
    return
  end
  local PAD_Y = self.compact and 8 or 11
  local y = -PAD_Y
  for i, item in ipairs(self.items) do
    if i > 1 then y = y - (item.gap or 0) end
    if item.sep then
      self.sep:ClearAllPoints()
      self.sep:SetPoint("TOPLEFT", PAD_X, y)
      self.sep:SetPoint("TOPRIGHT", -PAD_X, y)
      self.sep:Show()
      y = y - 7
    else
      local fs = item.fs
      local w = item.fixedWidth and fs:GetWidth() or (self.width - 2 * PAD_X)
      if not item.fixedWidth then fs:SetWidth(w) end
      fs:ClearAllPoints()
      if item.badge then
        local bh = (self.badge and self.badge:GetHeight()) or 18
        local h = math.ceil(math.max(W.TextHeight(fs, 14), bh, 18))
        fs:SetPoint("LEFT", self, "TOPLEFT", PAD_X, y - h / 2)
        y = y - h
      else
        local h = math.ceil(W.WrappedHeight(fs, w))
        fs:SetPoint("TOPLEFT", PAD_X, y)
        y = y - h
      end
    end
  end
  self:SetSize(self.width, math.ceil(-y + PAD_Y))
end

function Tip:Finish()
  local PAD_X = 12
  self.single = false
  if self.compact then
    local MAX_W = 400
    local w = 0
    for _, item in ipairs(self.items) do
      if item.fs then
        item.fs:SetWidth(MAX_W - 2 * PAD_X)
        w = math.max(w, W.TextWidth(item.fs, 100))
      end
    end
    self.width = math.min(MAX_W, math.ceil(w) + 2 * PAD_X + 2)
    local only = #self.items == 1 and self.items[1].fs
    if only and w <= MAX_W - 2 * PAD_X and not (only:GetText() or ""):find("\n") then
      self.single = true
      if only.SetWordWrap then only:SetWordWrap(false) end
      only:SetWidth(math.ceil(w) + 2)
    end
  end
  self:Layout()
  self:ClearAllPoints()
  local owner = self.owner
  if self.compact then
    local top = owner and owner:GetTop()
    local screenH = UIParent:GetHeight()
    if top and screenH and top + self:GetHeight() + 12 > screenH then
      self:SetPoint("TOP", owner, "BOTTOM", 0, -6)
    else
      self:SetPoint("BOTTOM", owner, "TOP", 0, 6)
    end
  else
    local x = owner and owner:GetCenter()
    local screenW = UIParent:GetWidth()
    if x and screenW and x > screenW / 2 then
      self:SetPoint("TOPRIGHT", owner, "TOPLEFT", -8, 0)
    else
      self:SetPoint("TOPLEFT", owner, "TOPRIGHT", 8, 0)
    end
  end
  self:Show()
  self.relayout = 2
  self:SetScript("OnUpdate", relayoutTip)
end

local menu, catcher
local function buildMenu()
  if menu then return end
  catcher = CreateFrame("Button", nil, UIParent)
  catcher:SetAllPoints(UIParent)
  catcher:SetFrameStrata("FULLSCREEN_DIALOG")
  catcher:RegisterForClicks("LeftButtonUp", "RightButtonUp")
  catcher:SetScript("OnClick", function() W.HideMenu() end)
  catcher:Hide()
  menu = CreateFrame("Frame", "AzerothForeverMenu", UIParent)
  menu:SetFrameStrata("FULLSCREEN_DIALOG")
  menu:SetFrameLevel(catcher:GetFrameLevel() + 5)
  menu:SetClampedToScreen(true)
  W.Fill(menu, "panel")
  W.Border(menu, "line")
  menu.items = {}
  menu:Hide()
end

function W.HideMenu()
  if menu then menu:Hide() end
  if catcher then catcher:Hide() end
end

function W.ShowMenu(anchor, items, width)
  buildMenu()
  width = width or 300
  menu:SetWidth(width)
  for _, it in ipairs(menu.items) do it:Hide() end
  local y = -4
  for i, def in ipairs(items) do
    local it = menu.items[i]
    if not it then
      it = CreateFrame("Button", nil, menu)
      it.fill = W.Fill(it, "panel2", 0)
      it.title = W.Text(it, "AF_Semi13", "ink")
      it.title:SetPoint("TOPLEFT", 12, -7)
      it.help = W.Text(it, "AF_Body12", "inkMuted")
      it.help:SetPoint("TOPLEFT", it.title, "BOTTOMLEFT", 0, -2)
      it:SetScript("OnEnter", function(self) T:PaintTex(self.fill, "panel2", 1) end)
      it:SetScript("OnLeave", function(self) T:PaintTex(self.fill, "panel2", 0) end)
      menu.items[i] = it
    end
    it:ClearAllPoints()
    it:SetPoint("TOPLEFT", 4, y)
    it:SetPoint("TOPRIGHT", -4, y)
    it:SetHeight(def.help and 44 or 28)
    it.title:SetText(def.title)
    it.help:SetText(def.help or "")
    it:SetScript("OnClick", function()
      W.HideMenu()
      if def.onClick then def.onClick() end
    end)
    it:Show()
    y = y - (def.help and 44 or 28)
  end
  menu:SetHeight(-y + 4)
  menu:ClearAllPoints()
  menu:SetPoint("TOPRIGHT", anchor, "BOTTOMRIGHT", 0, -6)
  catcher:Show()
  menu:Show()
end

local function mainFrame() return (AF.UI and AF.UI.frame) or UIParent end

function W.Popup(width, height)
  local host = mainFrame()
  local veil = CreateFrame("Button", nil, host)
  veil:SetAllPoints(host)
  veil:SetFrameLevel(host:GetFrameLevel() + 60)
  W.Fill(veil, "black", 0.55)
  veil:Hide()
  local p = CreateFrame("Frame", nil, veil)
  p:SetSize(width, height)
  p:SetPoint("CENTER", host, "CENTER", 0, 40)
  p:SetFrameLevel(veil:GetFrameLevel() + 2)
  p:EnableMouse(true)
  W.Fill(p, "panel")
  W.Border(p, "gold")
  p.veil = veil
  p.title = W.Text(p, "AF_Display15", "ink")
  p.title:SetPoint("TOPLEFT", 16, -14)
  p.close = W.IconButton(p, "ui_close", 24, function() p:Close() end)
  p.close:SetPoint("TOPRIGHT", -10, -10)
  veil:SetScript("OnClick", function() p:Close() end)
  function p:Open()
    self.veil:Show()
    if self.EnableKeyboard then
      self:EnableKeyboard(true)
    end
  end
  function p:Close()
    self.veil:Hide()
    if self.onClose then self.onClose() end
  end
  p:SetScript("OnKeyDown", function(self, key)
    if key == "ESCAPE" then
      self:Close()
      if self.SetPropagateKeyboardInput then self:SetPropagateKeyboardInput(false) end
    elseif self.SetPropagateKeyboardInput then
      self:SetPropagateKeyboardInput(true)
    end
  end)
  return p
end

local copyPopup
function W.ShowCopy(title, text, help)
  if not copyPopup then
    copyPopup = W.Popup(580, 132)
    copyPopup.field = W.EditBox(copyPopup, 28)
    copyPopup.field:SetPoint("TOPLEFT", 16, -46)
    copyPopup.field:SetPoint("TOPRIGHT", -16, -46)
    copyPopup.help = W.Text(copyPopup, "AF_Body12", "inkMuted")
    copyPopup.help:SetPoint("TOPLEFT", copyPopup.field, "BOTTOMLEFT", 0, -10)
    local eb = copyPopup.field.edit
    eb:SetScript("OnEscapePressed", function(self) self:ClearFocus(); copyPopup:Close() end)
    eb:SetScript("OnEnterPressed", function(self) self:HighlightText() end)
    eb:SetScript("OnTextChanged", function(self, userInput)
      if userInput and copyPopup.text then self:SetText(copyPopup.text); self:HighlightText() end
    end)
    local done = W.Button(copyPopup, { text = L["common.close"], variant = "ghost", onClick = function() copyPopup:Close() end })
    done:SetPoint("BOTTOMRIGHT", -16, 14)
  end
  copyPopup.title:SetText(title)
  copyPopup.text = text
  copyPopup.help:SetText(help or L["popup.copy_help"])
  copyPopup:Open()
  local eb = copyPopup.field.edit
  eb:SetText(text)
  eb:SetFocus()
  if eb.SetCursorPosition then eb:SetCursorPosition(0) end
  eb:HighlightText()
end

local pastePopup
function W.ShowPaste(title, help, onImport)
  if not pastePopup then
    pastePopup = W.Popup(580, 150)
    pastePopup.field = W.EditBox(pastePopup, 28)
    pastePopup.field:SetPoint("TOPLEFT", 16, -46)
    pastePopup.field:SetPoint("TOPRIGHT", -16, -46)
    pastePopup.help = W.Text(pastePopup, "AF_Body12", "inkMuted")
    pastePopup.help:SetPoint("TOPLEFT", pastePopup.field, "BOTTOMLEFT", 0, -8)
    pastePopup.err = W.Paragraph(pastePopup, "AF_Body12", "badText", 400)
    pastePopup.err:SetPoint("TOPLEFT", pastePopup.help, "BOTTOMLEFT", 0, -6)
    local function submit()
      local ok, err = pastePopup.onImport(pastePopup.field.edit:GetText())
      if ok then
        pastePopup:Close()
      else
        pastePopup.err:SetText(err or L["popup.code_unreadable"])
      end
    end
    pastePopup.submit = W.Button(pastePopup, { text = L["common.import"], variant = "primary", onClick = submit })
    pastePopup.submit:SetPoint("BOTTOMRIGHT", -16, 14)
    local cancel = W.Button(pastePopup, { text = L["common.cancel"], variant = "ghost", onClick = function() pastePopup:Close() end })
    cancel:SetPoint("RIGHT", pastePopup.submit, "LEFT", -6, 0)
    local eb = pastePopup.field.edit
    eb:SetScript("OnEscapePressed", function(self) self:ClearFocus(); pastePopup:Close() end)
    eb:SetScript("OnEnterPressed", function() submit() end)
  end
  pastePopup.title:SetText(title)
  pastePopup.help:SetText(help or "")
  pastePopup.err:SetText("")
  pastePopup.onImport = onImport
  pastePopup:Open()
  pastePopup.field.edit:SetText("")
  pastePopup.field.edit:SetFocus()
end

local confirmPopup
function W.Confirm(text, acceptLabel, onAccept)
  if not confirmPopup then
    confirmPopup = W.Popup(400, 130)
    confirmPopup.msg = W.Paragraph(confirmPopup, "AF_Body13", "ink", 360)
    confirmPopup.msg:SetPoint("TOPLEFT", 16, -48)
    confirmPopup.accept = W.Button(confirmPopup, { text = L["common.ok"], variant = "primary", onClick = function()
      confirmPopup:Close()
      if confirmPopup.onAccept then confirmPopup.onAccept() end
    end })
    confirmPopup.accept:SetPoint("BOTTOMRIGHT", -16, 14)
    local cancel = W.Button(confirmPopup, { text = L["common.cancel"], variant = "ghost", onClick = function() confirmPopup:Close() end })
    cancel:SetPoint("RIGHT", confirmPopup.accept, "LEFT", -6, 0)
  end
  confirmPopup.title:SetText(L["common.confirm"])
  confirmPopup.msg:SetText(text)
  confirmPopup.accept:SetLabel(acceptLabel or L["common.ok"])
  confirmPopup.onAccept = onAccept
  confirmPopup:Open()
end

local toast
function W.Toast(text, isError)
  local host = mainFrame()
  if not toast then
    toast = CreateFrame("Frame", nil, host)
    toast:SetFrameLevel(host:GetFrameLevel() + 80)
    toast:SetHeight(32)
    toast:SetPoint("BOTTOMLEFT", host, "BOTTOMLEFT", 12, 42)
    toast.fill = W.Fill(toast, "panel")
    toast.border = W.Border(toast, "line")
    toast.text = W.Text(toast, "AF_Body12", "ink")
    toast.text:SetPoint("LEFT", 12, 0)
    toast:SetScript("OnUpdate", function(self, elapsed)
      self.t = (self.t or 0) + elapsed
      if self.t > 3.3 then
        self:Hide()
      elseif self.t > 3 then
        self:SetAlpha(1 - (self.t - 3) / 0.3)
      end
    end)
  end
  toast.text:SetText(text)
  toast.border:SetToken(isError and "bad" or "line")
  toast:SetWidth(math.min(640, math.floor(W.TextWidth(toast.text, 7 * #text) + 24)))
  toast.t = 0
  toast:SetAlpha(1)
  toast:Show()
end

local NODE_STYLES = {
  idle = { border = "nodeIdle", rankBorder = "rankIdle", rankText = "rankIdleText", glow = nil, iconShade = 0.72, desat = true },
  points = { border = "good", rankBorder = "good", rankText = "goodText", glow = "good", glowA = 0.45, iconShade = 1 },
  max = { border = "new", rankBorder = "new", rankText = "new", glow = "new", glowA = 0.5, iconShade = 1 },
  locked = { border = "nodeLocked", rankBorder = "rankIdle", rankText = "rankLockedText", glow = nil, iconShade = 0.38, desat = true },
  empty = { border = "nodeEmpty", rankBorder = nil, rankText = nil, glow = nil, iconShade = 0 }
}

function W.Node(parent, size)
  local n = CreateFrame("Button", nil, parent)
  n:SetSize(size, size)
  n:RegisterForClicks("LeftButtonUp", "RightButtonUp")

  local glow = W.Image(n, "BACKGROUND", "ui_glow", "good", 0.45, -8)
  glow:SetPoint("TOPLEFT", -size * 0.45, size * 0.45)
  glow:SetPoint("BOTTOMRIGHT", size * 0.45, -size * 0.45)
  glow:Hide()
  n.glow = glow

  n.bg = W.Tex(n, "BACKGROUND", "black", 1, -6)
  n.bg:SetAllPoints(n)
  n.border = W.Border(n, "nodeIdle", 1, 2)

  local icon = n:CreateTexture(nil, "ARTWORK")
  icon:SetPoint("TOPLEFT", 3, -3)
  icon:SetPoint("BOTTOMRIGHT", -3, 3)
  icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
  n.icon = icon

  n.qmark = W.Text(n, "AF_Bold13", "inkMuted", "CENTER")
  n.qmark:SetPoint("CENTER", 0, 0)
  n.qmark:SetText("?")
  n.qmark:Hide()

  local rank = CreateFrame("Frame", nil, n)
  rank:SetFrameLevel(n:GetFrameLevel() + 3)
  rank:SetSize(28, 14)
  rank:SetPoint("BOTTOMRIGHT", n, "BOTTOMRIGHT", 7, -6)
  rank.fill = W.Fill(rank, "rankBg")
  rank.border = W.Border(rank, "rankIdle")
  rank.text = W.Text(rank, "AF_Mono10", "rankIdleText", "CENTER")
  rank.text:SetPoint("CENTER", 0, 0)
  n.rank = rank

  local plan = CreateFrame("Frame", nil, n)
  plan:SetFrameLevel(n:GetFrameLevel() + 3)
  plan:SetSize(20, 13)
  plan:SetPoint("TOPRIGHT", n, "TOPRIGHT", 7, 6)
  plan.fill = W.Fill(plan, "rankBg")
  plan.border = W.Border(plan, "gold")
  plan.text = W.Text(plan, "AF_Mono10", "goldHi", "CENTER")
  plan.text:SetPoint("CENTER", 0, 0)
  plan:Hide()
  n.plan = plan

  local dot = CreateFrame("Frame", nil, n)
  dot:SetFrameLevel(n:GetFrameLevel() + 3)
  dot:SetSize(14, 14)
  dot:SetPoint("CENTER", n, "TOPLEFT", 0, 0)
  dot.bg = W.Image(dot, "ARTWORK", "ui_circle", "rankBg")
  dot.bg:SetAllPoints()
  dot.ring = W.Image(dot, "OVERLAY", "ui_ring", "new")
  dot.ring:SetAllPoints()
  dot.star = W.Image(dot, "OVERLAY", "ui_star", "new", 1, 1)
  dot.star:SetSize(8, 8)
  dot.star:SetPoint("CENTER", 0, 0)
  dot:Hide()
  n.dot = dot

  function n:SetState(st)
    self.state = st
    local s = NODE_STYLES[st.kind] or NODE_STYLES.idle
    local borderTok, borderA = s.border, 1
    if st.future then borderTok, borderA = "gold", 0.7 end
    if self.hover and st.kind ~= "locked" and st.kind ~= "empty" then borderTok, borderA = "goldHi", 1 end
    self.border:SetToken(borderTok, borderA)
    if s.glow and not st.future then
      T:PaintTex(glow, s.glow, s.glowA)
      glow:Show()
    else
      glow:Hide()
    end
    if st.kind == "empty" then
      icon:Hide(); rank:Hide(); plan:Hide(); dot:Hide()
      self.qmark:Show()
      return
    end
    self.qmark:Hide()
    icon:Show()
    if icon.SetDesaturated then icon:SetDesaturated(s.desat and not self.hover or false) end
    local shade = (self.hover and st.kind ~= "locked") and 1 or s.iconShade
    icon:SetVertexColor(shade, shade, shade)
    icon:SetAlpha(st.future and 0.38 or 1)
    rank:Show()
    rank.text:SetText(st.rankText or "")
    rank:SetWidth(math.max(26, math.floor(W.TextWidth(rank.text, 24) + 8)))
    rank.border:SetToken(s.rankBorder)
    T:PaintText(rank.text, s.rankText)
    if st.planText then
      plan.text:SetText(st.planText)
      plan:SetWidth(math.max(20, math.floor(W.TextWidth(plan.text, 16) + 6)))
      plan:Show()
    else
      plan:Hide()
    end
    if st.status == "new" or st.status == "changed" then
      T:PaintTex(dot.ring, st.status)
      T:PaintTex(dot.star, st.status)
      dot:SetAlpha(st.kind == "idle" and 0.8 or 1)
      dot:Show()
    else
      dot:Hide()
    end
  end

  n:SetScript("OnEnter", function(self)
    self.hover = true
    if self.state then self:SetState(self.state) end
    if self.onEnter then self.onEnter(self) end
  end)
  n:SetScript("OnLeave", function(self)
    self.hover = false
    if self.state then self:SetState(self.state) end
    if self.onLeave then self.onLeave(self) end
  end)
  return n
end
