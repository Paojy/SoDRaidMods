local T, C, L, G = unpack(select(2, ...))
	
local Character_default_Settings = {
	FramePoints = {},
	
	General = {
		disable_all = false,
		disable_sound = false,
		disable_rmark = false,
		hide_minimap = false,
		rm = true,
		rm_sound = true,
		trans = true,
		trans_sound = true,
		tl = true,
		tl_font_size = 18,
		tl_use_self = "raid",
		tl_show_time = false,
		tl_exp_time = true,
		tl_advance = 60,
		tl_dur = 5,		
	},
	
	AlertFrame = {
		enable = true,
		show_spellname = false,
		icon_size = 65,
		icon_space = 5,
		grow_dir = "BOTTOM",
		font_size = 18,
		ifont_size = 12,
	},
	
	TextFrame = {
		enable = true,
		font_size = 30,
	},
	
	HL_Frame = {
		enable = true,
		position = "CENTER",
		iconSize = 30,
		iconAlpha = 80,
	},
	
	PlateAlerts = {
		enable = true,
		fsize = 7,
		size = 30,
		y = 30,
	},
	
	ChatMsg = {
		enable = true,
		custom_fsize = false,
		fsize = 16,
	},
	
	BM = {
		enable = true,
		scale = 100,
	},

	Icons = {},
	
	Text_Alerts = {},
	
	HLAuras = {},
	HLCast = {},
	
	PlateSpells = {},
	PlateAuras = {},
	PlatePower = {},
	PlayerAuraSource = {},
	PlateNpcID = {},
	
	ChatMsgAuras = {},
	ChatMsgAurasDose = {},
	ChatMsgAuraCountdown = {},
	ChatMsgAuraRepeat = {},
	ChatMsgBossWhispers = {},
	ChatMsgCom  = {},
	ChatMsgRange = {},
	
	Sound = {},
	
	BossMods = {},
}

local Account_default_Settings = {
	NpcNames = {},
	resetmode = "enable",
}

function T.LoadVariables()
	if SoD_CDB == nil then
		SoD_CDB = {}
	end
	for a, b in pairs(Character_default_Settings) do
		if type(b) ~= "table" then
			if SoD_CDB[a] == nil then
				SoD_CDB[a] = b
			end
		else
			if SoD_CDB[a] == nil then
				SoD_CDB[a] = {}
			end
			for k, v in pairs(b) do
				if SoD_CDB[a][k] == nil then
					SoD_CDB[a][k] = v
				end
			end
		end
	end
end

function T.LoadAccountVariables()
	if SoD_DB == nil then
		SoD_DB = {}
	end
	for a, b in pairs(Account_default_Settings) do
		if type(b) ~= "table" then
			if SoD_DB[a] == nil then
				SoD_DB[a] = b
			end
		else
			if SoD_DB[a] == nil then
				SoD_DB[a] = {}
			end
			for k, v in pairs(b) do
				if SoD_DB[a][k] == nil then
					if v then
						SoD_DB[a][k] = v
					else
						print(a,k)
					end
				end
			end
		end
	end
	if SoD_DB[G.PlayerName] == nil then
		SoD_DB[G.PlayerName] = {}
		if SoD_DB[G.PlayerName]["spec_info"] == nil then
			SoD_DB[G.PlayerName]["spec_info"] = ""
		end
	end
end

local eventframe = CreateFrame("Frame")
eventframe:RegisterEvent("ADDON_LOADED")
eventframe:RegisterEvent("PLAYER_ENTERING_WORLD")

eventframe:SetScript("OnEvent", function(self, event, ...)
	if event == "ADDON_LOADED" then
		local addon = ...
		if addon ~= "SoDRaidMods" then return end
		
		T.LoadVariables()
		T.LoadAccountVariables()
		
		for index, data in pairs(G.Encounters) do
			local option_page
			if type(index) == "string" then
				option_page = T.CreateOptions(L["杂兵"], G.gui, true)
				T.CreateEncounterOptions(option_page, index, data)	
			else
				option_page = T.CreateOptions(EJ_GetEncounterInfo(data["id"]), G.gui, true)
				T.CreateEncounterOptions(option_page, index, data)	
			end
			if data["alerts"]["PlateAlert"] then
				for i, args in pairs(data["alerts"]["PlateAlert"]) do
					if args.type == "PlateSpells" then
						if not G.Npc[args.mobID] then
							G.Npc[args.mobID] = {}
						end
						G.Npc[args.mobID][args.spellID] = args.spellCD
					end
				end
			end
		end
		
		local options = T.CreateOptions(L["制作"], G.gui)
		
		local info = T.createtext(options, "OVERLAY", 25, "OUTLINE", "CENTER")
		info:SetPoint("CENTER", options, "CENTER", 0, -80)
		info:SetText(L["制作文本"])
		
		logo = options:CreateTexture(nil, "OVERLAY")
		logo:SetSize(400, 400)
		logo:SetPoint("TOP", options, "TOP", 0, -50)
		logo:SetTexture(G.media.logo)
		logo:SetTexCoord(0, 1, 1, 0)
		logo:SetBlendMode("ADD")
		
		model = CreateFrame("PlayerModel", nil, options)
		model:SetSize(200,200)
		model:SetPoint("BOTTOM", options, "BOTTOM", 0, 30)
	
		model:SetPosition(0, 0, 0)
		model:SetFacing(1)
		model:SetCreature(112144)
	
		model.text = T.createtext(model, "HIGHLIGHT", 20, "NONE", "CENTER")
		model.text:SetPoint("BOTTOM", model, "BOTTOM", 0, 25)
		model.text:SetTextColor(1, 1, 1)
		model.text:SetText(L["汪汪"])
	
		model:SetScript("OnEnter", function(self) self:SetFacing(0) end)
		model:SetScript("OnLeave", function(self) self:SetFacing(1) end)
		
		model:EnableMouse(true)
	else
		if event == "PLAYER_ENTERING_WORLD" then
			self:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
			self:UnregisterEvent("PLAYER_ENTERING_WORLD")
			C_Timer.After(3, function()
				local spec = GetSpecialization()
				if spec then
					SoD_DB[G.PlayerName]["spec_info"] = select(5, GetSpecializationInfo(spec))
				else
					SoD_DB[G.PlayerName]["spec_info"] = "" 
				end

				G.TransFrame.Update(G.TransFrame, "SOD_UPDATE_DB")
			end)
			
			G.ChatFont, G.ChatFointsize, G.ChatOutline = ChatBubbleFont:GetFont() -- 存起来先
			if SoD_CDB["ChatMsg"]["custom_fsize"] then
				ChatBubbleFont:SetFont(G.Font, SoD_CDB["ChatMsg"]["fsize"], "OUTLINE")
			end
			
			print("|T"..G.media.logo..":36:36:0:0:64:64:0:64:64:6|t |cffff0000Skyline|r "..G.addon_name.." "..G.Version)
			
			T.ToggleMinimapButton()
		else
			local spec = GetSpecialization()
			if spec then
				SoD_DB[G.PlayerName]["spec_info"] = select(5, GetSpecializationInfo(spec))
			else
				SoD_DB[G.PlayerName]["spec_info"] = "" 
			end
		end
	end
end)