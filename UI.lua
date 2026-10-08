-- (c) Poulpix, Azeroth Forever. All rights reserved. Text and data mining and AI training prohibited (noai, noimageai, EU Directive 2019/790 art. 4). See LICENSE.md.
local ADDON_NAME, AF = ...

local UI = {}
AF.UI = UI

local L, Lf = AF.L, AF.Lf
local T = AF.Theme
local W = AF.Widgets

UI.WIN_W, UI.WIN_H = 1120, 720
UI.PAD = 12
UI.HEADER_H = 44
UI.FOOTER_H = 30
UI.GAP = 8

local TABS = {
  { key = "talents", labelKey = "tab.talents", icon = "Interface\\Icons\\Ability_Marksmanship", module = "TalentsTab" },
  { key = "heritage", labelKey = "tab.heritage", icon = "Interface\\Icons\\INV_Misc_Note_06", module = "HeritageTab" },
  { key = "donjons", labelKey = "tab.dungeons", icon = "Interface\\Icons\\INV_Misc_Bone_HumanSkull_01", module = "DungeonsTab" }
}
UI.TABS = TABS

function UI:Options()
  AzerothForeverDB = AzerothForeverDB or {}
  AzerothForeverDB.options = AzerothForeverDB.options or {}
  return AzerothForeverDB.options
end

function UI:GetFaction()
  local o = self:Options()
  if o.faction == "horde" or o.faction == "alliance" then return o.faction end
  local f = UnitFactionGroup and UnitFactionGroup("player")
  return (f == "Horde") and "horde" or "alliance"
end

function UI:RefreshLogo()
  if AF.Minimap then AF.Minimap:RefreshIcon() end
  if not self.logo then return end
  local horde = self:GetFaction() == "horde"
  self.logo:SetTexture(T:Tex(horde and "ui_logo_horde" or "ui_logo"))
end

function UI:SetFaction(faction)
  self:Options().faction = faction
  T:SetFaction(faction)
  self:RefreshFactionToggle()
  self:RefreshLogo()
  for _, tab in ipairs(TABS) do
    local m = AF[tab.module]
    if m and m.OnFactionChanged then m:OnFactionChanged(faction) end
  end
end

function UI:OnFrameLoad(frame)
  self.frame = frame
  frame:SetSize(self.WIN_W, self.WIN_H)
  frame:SetFrameStrata("DIALOG")
  frame:ClearAllPoints()
  frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
  frame:SetClampedToScreen(true)
  frame:EnableMouse(true)
  frame:SetMovable(true)
  if type(UISpecialFrames) == "table" then
    table.insert(UISpecialFrames, frame:GetName())
  end
end

function UI:EnsureBuilt()
  if self.built then return end
  self.built = true
  T:InitFonts()
  T.faction = self:GetFaction()
  local o = self:Options()
  if o.scale then self.frame:SetScale(o.scale) end
  if o.point and o.point[1] then
    self.frame:ClearAllPoints()
    self.frame:SetPoint(o.point[1], UIParent, o.point[2] or o.point[1], o.point[3] or 0, o.point[4] or 0)
  end

  local sections = {
    { "chrome", function() self:BuildChrome() end }
  }
  for _, tab in ipairs(TABS) do
    sections[#sections + 1] = { tab.key, function() self:BuildTab(tab) end }
  end
  for _, s in ipairs(sections) do
    local ok, err = pcall(s[2])
    if not ok then AF:Print(Lf("ui.err_section", s[1], tostring(err))) end
  end
end

function UI:OnFrameShow()
  AF.classId = AF.classId or AF:GetPlayerClassId()
  self:EnsureBuilt()
  T:SetFaction(self:GetFaction())
  self:RefreshFactionToggle()
  self:RefreshLogo()
  self:SelectTab(self:Options().tab or "talents")
end

function UI:OnFrameHide()
  W.HideMenu()
  W.Tip:Hide()
end

function UI:Toggle()
  if not self.frame then return end
  if self.frame:IsShown() then self.frame:Hide() else self.frame:Show() end
end

function UI:Hide()
  if self.frame then self.frame:Hide() end
end

function UI:Show(tabKey)
  if not self.frame then return end
  if tabKey then self:Options().tab = tabKey end
  if self.frame:IsShown() then
    if tabKey then self:SelectTab(tabKey) end
  else
    self.frame:Show()
  end
end

function UI:HandleSlash(msg)
  msg = (msg or ""):lower():gsub("^%s+", ""):gsub("%s+$", "")
  if msg == "" then return self:Toggle() end
  local scale = msg:match("^echelle%s+([%d%.]+)$") or msg:match("^scale%s+([%d%.]+)$")
  if scale then
    scale = math.max(0.6, math.min(1.2, tonumber(scale) or 1))
    self:Options().scale = scale
    if self.frame then self.frame:SetScale(scale) end
    AF:Print(Lf("cmd.scale", scale))
    return
  end
  if msg == "diag" then
    for _, line in ipairs(AF.Talents:Diagnose()) do AF:Print(line) end
    AF:Print(L["cmd.diag_saved"])
    return
  end
  if msg == "releve" or msg == "relevé" or msg == "survey" then return AF.Audit:Run() end
  if msg == "butin" or msg == "loot" then return AF.Audit:LootSummary() end
  if msg == "minimap" then return AF.Minimap:Toggle() end
  local wanted = msg:match("^locale%s*(%S*)$")
  if wanted then
    if wanted == "" then
      AF:Print(Lf("cmd.locale_current", AF:GetActiveLocale(), AF:GetClientLocale()))
    elseif wanted == "auto" then
      self:Options().locale = nil
      AF:Print(Lf("cmd.locale_auto", AF:GetClientLocale()))
    else
      local code = AF:NormalizeLocale(wanted)
      if code then
        self:Options().locale = code
        AF:Print(Lf("cmd.locale_set", code))
      else
        AF:Print(Lf("cmd.locale_bad", wanted, table.concat(AF:GetKnownLocales(), ", ")))
      end
    end
    return
  end
  if msg == "debug" then
    AF.debugMode = not AF.debugMode
    AF:Print(Lf("cmd.debug", AF.debugMode and L["state.on"] or L["state.off"]))
    return
  end
  if msg == "talents" or msg == "talent" then return self:Show("talents") end
  if msg == "heritage" or msg == "héritage" or msg == "legacy" then return self:Show("heritage") end
  if msg == "donjons" or msg == "donjon" or msg == "dungeons" then return self:Show("donjons") end
  AF:Print(L["cmd.help"])
end

function UI:BuildChrome()
  local f = self.frame
  local bg = W.Tex(f, "BACKGROUND", "bg0", 1, -8)
  bg:SetAllPoints(f)
  W.Border(f, "line", 1, 1, "OVERLAY")

  local header = CreateFrame("Frame", nil, f)
  header:SetPoint("TOPLEFT", 1, -1)
  header:SetPoint("TOPRIGHT", -1, -1)
  header:SetHeight(self.HEADER_H - 1)
  W.Fill(header, "bg1")
  header:EnableMouse(true)
  header:RegisterForDrag("LeftButton")
  header:SetScript("OnDragStart", function() f:StartMoving() end)
  header:SetScript("OnDragStop", function()
    f:StopMovingOrSizing()
    local point, _, relPoint, x, y = f:GetPoint(1)
    self:Options().point = { point, relPoint, x, y }
  end)
  self.header = header
  local line = W.Tex(header, "BORDER", "line")
  line:SetPoint("BOTTOMLEFT", 0, 0); line:SetPoint("BOTTOMRIGHT", 0, 0); line:SetHeight(1)
  local goldLine = W.Image(f, "ARTWORK", "ui_hfade", "gold", 0.6)
  goldLine:SetPoint("TOPLEFT", header, "BOTTOMLEFT", 0, -2)
  goldLine:SetPoint("TOPRIGHT", header, "BOTTOMRIGHT", 0, -2)
  goldLine:SetHeight(1)

  local logo = header:CreateTexture(nil, "ARTWORK")
  logo:SetSize(30, 30)
  logo:SetPoint("LEFT", 12, 0)
  self.logo = logo
  self:RefreshLogo()
  local brand = W.Text(header, "AF_Display14", "ink")
  brand:SetPoint("TOPLEFT", logo, "TOPRIGHT", 8, -1)
  brand:SetText("Azeroth Forever")
  local sub = W.Text(header, "AF_Kicker9", "inkMuted")
  sub:SetPoint("TOPLEFT", brand, "BOTTOMLEFT", 0, -3)
  sub:SetText(L["ui.tagline"])

  self.navButtons = {}
  local x = 250
  for _, tab in ipairs(TABS) do
    local b = CreateFrame("Button", nil, header)
    b:SetHeight(self.HEADER_H - 1)
    b:SetPoint("TOPLEFT", x, 0)
    local icon = b:CreateTexture(nil, "ARTWORK")
    icon:SetSize(18, 18)
    icon:SetPoint("LEFT", 12, 0)
    icon:SetTexture(tab.icon)
    icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    local label = W.Text(b, "AF_Semi13", "inkMuted")
    label:SetPoint("LEFT", icon, "RIGHT", 7, 0)
    label:SetText(L[tab.labelKey])
    local w = math.floor(12 + 18 + 7 + W.TextWidth(label, 60) + 12)
    b:SetWidth(w)
    local under = W.Tex(b, "OVERLAY", "gold")
    under:SetHeight(2)
    under:SetPoint("BOTTOMLEFT", b, "BOTTOMLEFT", 10, 1)
    under:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", -10, 1)
    b.icon, b.label, b.under, b.key = icon, label, under, tab.key
    b:SetScript("OnClick", function() self:SelectTab(tab.key) end)
    b:SetScript("OnEnter", function() if self.activeTab ~= tab.key then T:PaintText(label, "ink") end end)
    b:SetScript("OnLeave", function() if self.activeTab ~= tab.key then T:PaintText(label, "inkMuted") end end)
    self.navButtons[tab.key] = b
    b.navW = w
    x = x + w + 4
  end

  local close = W.IconButton(header, "ui_close", 26, function() self:Hide() end, L["ui.close"])
  close:SetPoint("RIGHT", -10, 0)

  local ft = CreateFrame("Frame", nil, header)
  ft:SetSize(196, 28)
  ft:SetPoint("RIGHT", close, "LEFT", -10, 0)

  local brandRight = 12 + 30 + 8 + math.max(W.TextWidth(brand, 120), W.TextWidth(sub, 160))
  local toggleLeft = self.WIN_W - 10 - 26 - 10 - 196
  local navW = -4
  for _, tab in ipairs(TABS) do navW = navW + self.navButtons[tab.key].navW + 4 end
  local nx = math.floor(brandRight + (toggleLeft - brandRight - navW) / 2)
  for _, tab in ipairs(TABS) do
    local b = self.navButtons[tab.key]
    b:ClearAllPoints()
    b:SetPoint("TOPLEFT", nx, 0)
    nx = nx + b.navW + 4
  end
  W.Fill(ft, "bg0")
  W.Border(ft, "line")
  self.factionButtons = {}
  local segW = 95
  for i, def in ipairs({ { "alliance", L["faction.alliance_caps"] }, { "horde", L["faction.horde_caps"] } }) do
    local b = CreateFrame("Button", nil, ft)
    b:SetSize(segW, 22)
    b:SetPoint("LEFT", 3 + (i - 1) * segW, 0)
    b.fill = W.Fill(b, "allianceOn", 0)
    b.border = W.Border(b, "allianceOnBorder", 0)
    b.dot = W.Image(b, "ARTWORK", "ui_circle", "inkMuted", 0.55)
    b.dot:SetSize(7, 7)
    b.label = W.Text(b, "AF_Kicker10", "inkMuted")
    b.label:SetText(def[2])
    local lw = W.TextWidth(b.label, 60)
    b.dot:SetPoint("LEFT", b, "CENTER", -math.floor((lw + 12) / 2), 0)
    b.label:SetPoint("LEFT", b.dot, "RIGHT", 5, 0)
    b.key = def[1]
    b:SetScript("OnClick", function() self:SetFaction(def[1]) end)
    b:SetScript("OnEnter", function() if self:GetFaction() ~= def[1] then T:PaintText(b.label, "ink") end end)
    b:SetScript("OnLeave", function() if self:GetFaction() ~= def[1] then T:PaintText(b.label, "inkMuted") end end)
    self.factionButtons[def[1]] = b
  end

  local body = CreateFrame("Frame", nil, f)
  body:SetPoint("TOPLEFT", self.PAD, -(self.HEADER_H + 10))
  body:SetPoint("BOTTOMRIGHT", -self.PAD, self.FOOTER_H + self.GAP)
  self.body = body

  local footer = CreateFrame("Frame", nil, f)
  footer:SetPoint("BOTTOMLEFT", 1, 1)
  footer:SetPoint("BOTTOMRIGHT", -1, 1)
  footer:SetHeight(self.FOOTER_H - 1)
  W.Fill(footer, "bg1")
  local fl = W.Tex(footer, "BORDER", "line")
  fl:SetPoint("TOPLEFT", 0, 0); fl:SetPoint("TOPRIGHT", 0, 0); fl:SetHeight(1)
  self.footer = footer
  local site = W.Button(footer, { text = "azerothforever.info", variant = "link", icon = "ui_external", iconSize = 11, height = 22, padding = 6,
    onClick = function() self:ShowSiteLink(AF.SITE_URL) end, tooltip = L["ui.site_tip"] })
  site:SetPoint("RIGHT", footer, "RIGHT", -8, -0.5)
  self.footerRight = site
end

function UI:RefreshFactionToggle()
  if not self.factionButtons then return end
  local current = self:GetFaction()
  for key, b in pairs(self.factionButtons) do
    if key == current then
      local on = (key == "horde") and "hordeOn" or "allianceOn"
      T:PaintTex(b.fill, on, 1)
      b.border:SetToken(on .. "Border", 1)
      T:PaintText(b.label, "white")
      T:PaintTex(b.dot, "gold", 1)
    else
      T:PaintTex(b.fill, "allianceOn", 0)
      b.border:SetToken("allianceOnBorder", 0)
      T:PaintText(b.label, "inkMuted")
      T:PaintTex(b.dot, "inkMuted", 0.55)
    end
  end
end

function UI:BuildTab(tab)
  local m = AF[tab.module]
  if not m then return end
  local page = CreateFrame("Frame", nil, self.body)
  page:SetAllPoints(self.body)
  page:Hide()
  local foot = CreateFrame("Frame", nil, self.footer)
  foot:SetPoint("TOPLEFT", self.footer, "TOPLEFT", 12, -1)
  foot:SetPoint("BOTTOMLEFT", self.footer, "BOTTOMLEFT", 12, 0)
  foot:SetPoint("RIGHT", self.footerRight, "LEFT", -12, 0)
  foot:Hide()
  tab.page, tab.foot = page, foot
  m:Build(page, foot)
end

function UI:SelectTab(key)
  local found = false
  for _, tab in ipairs(TABS) do if tab.key == key then found = true end end
  if not found then key = "talents" end
  self.activeTab = key
  self:Options().tab = key
  W.HideMenu()
  W.Tip:Hide()
  for _, tab in ipairs(TABS) do
    local on = tab.key == key
    if tab.page then
      if on then tab.page:Show(); tab.foot:Show() else tab.page:Hide(); tab.foot:Hide() end
    end
    local b = self.navButtons and self.navButtons[tab.key]
    if b then
      T:PaintText(b.label, on and "ink" or "inkMuted")
      if on then b.under:Show() else b.under:Hide() end
    end
  end
  local active = self:ActiveModule()
  if active and active.OnShow then
    local ok, err = pcall(active.OnShow, active)
    if not ok then AF:Print(Lf("ui.err_section", key, tostring(err))) end
  end
end

function UI:ActiveModule()
  for _, tab in ipairs(TABS) do
    if tab.key == self.activeTab then return AF[tab.module] end
  end
end

function UI:RefreshAll()
  if not self.built or not self.frame or not self.frame:IsShown() then return end
  local m = self:ActiveModule()
  if m and m.Refresh then
    local ok, err = pcall(m.Refresh, m)
    if not ok then AF:Print(Lf("ui.err", tostring(err))) end
  end
end

function UI:RefreshTalents()
  if self.activeTab == "talents" then self:RefreshAll() end
end

function UI:ShowSiteLink(url)
  W.ShowCopy(L["ui.site_title"], url or AF.SITE_URL, L["ui.site_hint"])
end

function UI:ImportAnyCode(text)
  local info = AF.ShareCode.inspect(text)
  if not info.ok then return false, info.error end
  if info.kind == "H" then
    local ok, err = AF.HeritageTab:ImportCode(text)
    if ok then self:SelectTab("heritage") end
    return ok, err
  end
  local ok, err = AF.TalentsTab:ImportCode(text)
  if ok then self:SelectTab("talents") end
  return ok, err
end

local frame = CreateFrame("Frame", "AzerothForeverFrame", UIParent)
frame:Hide()
frame:SetToplevel(true)
frame:SetScript("OnShow", function() UI:OnFrameShow() end)
frame:SetScript("OnHide", function() UI:OnFrameHide() end)
UI:OnFrameLoad(frame)
