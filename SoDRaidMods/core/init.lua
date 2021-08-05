
-- local T, C, L, G = unpack(select(2, ...))

local addon, ns = ...
ns[1] = {} -- T, functions, constants, variables
ns[2] = {} -- C, config
ns[3] = {} -- L, localization
ns[4] = {} -- G, globals (Optionnal)

--[[--------------
--     init     --
--------------]]--
local T, C, L, G = unpack(select(2, ...))

G.addon_name = "SoDRaidMods"
G.addon_cname = select(2, GetAddOnInfo(G.addon_name))
G.addon_c = "|cffff0000"

G.dragFrameList = {}
G.Encounters = {}
G.Npc = {}

G.Font = GameFontHighlight:GetFont()

G.media = {
	blank = "Interface\\Buttons\\WHITE8x8",
	sounds = "Interface\\AddOns\\SoDRaidMods\\media\\sounds\\",
	count = "Interface\\AddOns\\SoDRaidMods\\media\\sounds\\count\\",
	arrowUp = "Interface\\AddOns\\SoDRaidMods\\media\\up",
	arrowDown = "Interface\\AddOns\\SoDRaidMods\\media\\down",
	gradient = "Interface\\AddOns\\SoDRaidMods\\media\\gradient",
	logo = "Interface\\AddOns\\SoDRaidMods\\media\\logo",
	ring = "Interface\\AddOns\\SoDRaidMods\\media\\ring",
}

G.Client = GetLocale()
G.Version = GetAddOnMetadata("SoDRaidMods", "Version")
G.NumVersion = tonumber(GetAddOnMetadata("SoDRaidMods", "X-Version"))
G.PlayerName = UnitName("player")
G.myClass = select(2, UnitClass("player"))

G.Ccolors = {}
if(IsAddOnLoaded'!ClassColors' and CUSTOM_CLASS_COLORS) then
	G.Ccolors = CUSTOM_CLASS_COLORS
else
	G.Ccolors = RAID_CLASS_COLORS
end

StaticPopupDialogs[G.addon_name.."Reset Positions Confirm"] = {
	text = "",
	button1 = ACCEPT,
	button2 = CANCEL,
	hideOnEscape = 1, 
	whileDead = true,
	preferredIndex = 3,
}

StaticPopupDialogs[G.addon_name.."Reset Settings Confirm"] = {
	text = "",
	button1 = "",
	button2 = "",
	button3 = "",
	button4 = CANCEL,
	hideOnEscape = 1, 
	whileDead = true,
	preferredIndex = 3,
	selectCallbackByIndex = true,
}

StaticPopupDialogs[G.addon_name.."Outdate"] = {
	text = "",
	button1 = ACCEPT,
	button2 = CANCEL,
	hideOnEscape = 1, 
	whileDead = true,
	preferredIndex = 3,
}

StaticPopupDialogs[G.addon_name.."Update"] = {
	text = "",
	button1 = ACCEPT,
	hideOnEscape = 1, 
	whileDead = true,
	preferredIndex = 3,
	OnShow = function (self, data)
		self.editBox:SetText("https://www.curseforge.com/wow/addons/skyline-sod-raid-mods/")
		self.editBox:HighlightText()
	end,
	hasEditBox = true,
}

G.Role = {
	["tank"] = "TANK",
	["dps"] = "DAMAGER",
	["healer"] = "HEALER",
}

StaticPopupDialogs[G.addon_name.."Import"] = {
	text = "",
	button1 = ACCEPT,
	hideOnEscape = 1, 
	whileDead = true,
	preferredIndex = 3,
	hasEditBox = true,
}

StaticPopupDialogs[G.addon_name.."Export"] = {
	text = "",
	button1 = ACCEPT,
	hideOnEscape = 1, 
	whileDead = true,
	preferredIndex = 3,
	hasEditBox = true,
}

