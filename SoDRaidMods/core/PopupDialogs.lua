local T, C, L, G = unpack(select(2, ...))

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
	OnShow = function (self, data)
		local str = T.ExportSettings()
		self.editBox:SetText(str)
		self.editBox:HighlightText()
	end,
	hasEditBox = true,
}

StaticPopupDialogs[G.addon_name.."Import Confirm"] = {
	text = L["导入确认"],
	button1 = ACCEPT,
	button2 = CANCEL,
	hideOnEscape = 1, 
	whileDead = true,
	preferredIndex = 3,
}

StaticPopupDialogs[G.addon_name.."Cannot Import"] = {
	text = L["无法导入"],
	button1 = ACCEPT,
	hideOnEscape = 1, 
	whileDead = true,
	preferredIndex = 3,
}