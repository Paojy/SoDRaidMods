
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
G.raid_short = "SOD"
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
	spellsounds = "Interface\\AddOns\\SoDRaidMods\\media\\sounds\\spell\\",
	arrowUp = "Interface\\AddOns\\SoDRaidMods\\media\\up",
	arrowDown = "Interface\\AddOns\\SoDRaidMods\\media\\down",
	gradient = "Interface\\AddOns\\SoDRaidMods\\media\\gradient",
	logo = "Interface\\AddOns\\SoDRaidMods\\media\\logo",
	ring = "Interface\\AddOns\\SoDRaidMods\\media\\ring",
	circle = "Interface\\AddOns\\SoDRaidMods\\media\\circle",
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