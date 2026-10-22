-- (c) Poulpix, Azeroth Forever. All rights reserved. Text and data mining and AI training prohibited (noai, noimageai, EU Directive 2019/790 art. 4). See LICENSE.md.
local ADDON_NAME, AF = ...

local MM = {}
AF.Minimap = MM

local L = AF.L
local TITLE = "Azeroth Forever"

local function DB()
  AzerothForeverDB = AzerothForeverDB or {}
  AzerothForeverDB.minimap = AzerothForeverDB.minimap or { angle = 200, hide = false }
  local db = AzerothForeverDB.minimap
  if db.minimapPos == nil then db.minimapPos = db.angle or 200 end
  return db
end

local function LogoPath()
  local horde = AF.UI and AF.UI:GetFaction() == "horde"
  return AF.Theme:Tex(horde and "ui_logo_horde" or "ui_logo")
end

local function OnClick(button)
  if button == "RightButton" then
    AF.UI:Show("donjons")
  else
    AF.UI:Toggle()
  end
end

local function FillTooltip(tip)
  tip:AddLine(TITLE, 0.85, 0.66, 0.34)
  tip:AddLine(L["minimap.tip.left"], 1, 1, 1)
  tip:AddLine(L["minimap.tip.right"], 1, 1, 1)
  tip:AddLine(L["minimap.tip.drag"], 0.7, 0.7, 0.7)
  tip:AddLine(L["minimap.tip.cmd"], 0.7, 0.7, 0.7)
end

function MM:Place()
  local b = self.button
  if not b or self.lib or not Minimap then return end
  local a = math.rad(DB().minimapPos or 200)
  local r = math.max(Minimap:GetWidth() or 140, Minimap:GetHeight() or 140) / 2 + 6
  b:ClearAllPoints()
  b:SetPoint("CENTER", Minimap, "CENTER", math.cos(a) * r, math.sin(a) * r)
end

function MM:CreateOwn()
  local b = CreateFrame("Button", "AzerothForeverMinimapButton", Minimap)
  b:SetSize(31, 31)
  b:SetFrameStrata("MEDIUM")
  b:SetFrameLevel((Minimap:GetFrameLevel() or 0) + 8)
  b:RegisterForClicks("LeftButtonUp", "RightButtonUp")
  b:RegisterForDrag("LeftButton")

  local bg = b:CreateTexture(nil, "BACKGROUND")
  bg:SetTexture("Interface\\Minimap\\UI-Minimap-Background")
  bg:SetSize(22, 22)
  bg:SetPoint("CENTER", 0, 1)

  local icon = b:CreateTexture(nil, "ARTWORK")
  icon:SetSize(20, 20)
  icon:SetPoint("CENTER", 0, 1)
  b.icon = icon

  local border = b:CreateTexture(nil, "OVERLAY")
  border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
  border:SetSize(53, 53)
  border:SetPoint("TOPLEFT")

  b:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")

  b:SetScript("OnClick", function(_, button) OnClick(button) end)
  b:SetScript("OnEnter", function(s)
    GameTooltip:SetOwner(s, "ANCHOR_LEFT")
    FillTooltip(GameTooltip)
    GameTooltip:Show()
  end)
  b:SetScript("OnLeave", function() GameTooltip:Hide() end)
  b:SetScript("OnDragStart", function(s)
    GameTooltip:Hide()
    s:SetScript("OnUpdate", function()
      local mx, my = Minimap:GetCenter()
      if not mx then return end
      local x, y = GetCursorPosition()
      local scale = Minimap:GetEffectiveScale()
      DB().minimapPos = math.deg(math.atan2(y / scale - my, x / scale - mx))
      MM:Place()
    end)
  end)
  b:SetScript("OnDragStop", function(s) s:SetScript("OnUpdate", nil) end)

  self.button = b
  self:Place()
end

function MM:CreateWithLib()
  if not LibStub then return false end
  local ldb = LibStub("LibDataBroker-1.1", true)
  local icon = LibStub("LibDBIcon-1.0", true)
  if not ldb or not icon then return false end
  local obj = ldb:NewDataObject(ADDON_NAME, {
    type = "launcher",
    text = TITLE,
    icon = LogoPath(),
    OnClick = function(_, button) OnClick(button) end,
    OnTooltipShow = function(tip) FillTooltip(tip) end,
  })
  if not obj then return false end
  icon:Register(ADDON_NAME, obj, DB())
  self.lib, self.obj = icon, obj
  self.button = _G["LibDBIcon10_" .. ADDON_NAME]
  return true
end

function MM:RefreshIcon()
  local path = LogoPath()
  if self.obj then self.obj.icon = path end
  if self.button and self.button.icon then self.button.icon:SetTexture(path) end
end

function MM:Init()
  if self.ready or not Minimap then return end
  self.ready = true
  if not self:CreateWithLib() then self:CreateOwn() end
  self:RefreshIcon()
  self:Apply()
end

function MM:Apply()
  local hide = DB().hide
  if self.lib then
    if hide then self.lib:Hide(ADDON_NAME) else self.lib:Show(ADDON_NAME) end
  elseif self.button then
    if hide then self.button:Hide() else self.button:Show() end
  end
end

function MM:Toggle()
  local db = DB()
  db.hide = not db.hide
  self:Apply()
  AF:Print(db.hide and L["minimap.hidden"] or L["minimap.shown"])
end
