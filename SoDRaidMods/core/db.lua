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
		moving_boss = 1,
	},
	
	AlertFrame = {
		enable = true,
		show_spellname = true,
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

function T.UpdateDefaultSettings()
	for index, data in pairs(G.Encounters) do
		for Alert_Type, Alerts in T.pairsByKeys(data["alerts"]) do
			if Alert_Type == "BossMods" then
				for i, args in pairs(Alerts) do
					if Character_default_Settings["BossMods"][args.spellID] == nil then
						if SoD_DB["resetmode"] == "enable" or SoD_DB["resetmode"] == "spec" then
							Character_default_Settings["BossMods"][args.spellID] = true
						elseif SoD_DB["resetmode"] == "disable" then
							Character_default_Settings["BossMods"][args.spellID] = false
						end		
					end
				end
			elseif Alert_Type == "AlertIcon" then
				for i, args in pairs(Alerts) do -- 已改			
					local v = args.type.."_"..args.spellID
					
					if Character_default_Settings["Icons"][v] == nil then
						if SoD_DB["resetmode"] == "enable" then
							Character_default_Settings["Icons"][v] = true
						elseif SoD_DB["resetmode"] == "disable" then
							Character_default_Settings["Icons"][v] = false
						elseif SoD_DB["resetmode"] == "spec" then
							if not args.role or G.Role[args.role] == SoD_DB[G.PlayerName]["spec_info"] then
								Character_default_Settings["Icons"][v] = true
							else
								Character_default_Settings["Icons"][v] = false
							end
						end
					end
				end
			elseif Alert_Type == "TextAlert" then -- 已改
				for i, args in pairs(Alerts) do
				
					local v
					if args.type == "spell" or args.type == "spell_clone" then -- 法术、其他提示
						v = args.spellID
					else
						v = args.type.."_"..args.data.npc_id -- 血量、能量提示
					end
					
					if Character_default_Settings["Text_Alerts"][v] == nil then
						if SoD_DB["resetmode"] == "enable" then
							Character_default_Settings["Text_Alerts"][v] = true
						elseif SoD_DB["resetmode"] == "disable" then
							Character_default_Settings["Text_Alerts"][v] = false
						elseif SoD_DB["resetmode"] == "spec" then
							if not args.role or G.Role[args.role] == SoD_DB[G.PlayerName]["spec_info"] then
								Character_default_Settings["Text_Alerts"][v] = true
							else
								Character_default_Settings["Text_Alerts"][v] = false
							end
						end
					end
				end	
			elseif Alert_Type == "HLOnRaid" then -- 已改
				for i, args in pairs(Alerts) do
					
					local v = args.type.."_"..args.spellID..(args.Glow and "_Glow" or "")
					
					if Character_default_Settings[args.type][v] == nil then
						if SoD_DB["resetmode"] == "enable" then
							Character_default_Settings[args.type][v] = true
						elseif SoD_DB["resetmode"] == "disable" then
							Character_default_Settings[args.type][v] = false
						elseif SoD_DB["resetmode"] == "spec" then
							if not args.role or G.Role[args.role] == SoD_DB[G.PlayerName]["spec_info"] then
								Character_default_Settings[args.type][v] = true
							else
								Character_default_Settings[args.type][v] = false
							end
						end
					end
				end
				
			elseif Alert_Type == "PlateAlert" then -- 已改
				for i, args in pairs(Alerts) do
					if args.type == "PlatePower" or args.type == "PlateNpcID" then
					
						if Character_default_Settings[args.type][args.mobID] == nil then
							if SoD_DB["resetmode"] == "enable" then
								Character_default_Settings[args.type][args.mobID] = true
							elseif SoD_DB["resetmode"] == "disable" then
								Character_default_Settings[args.type][args.mobID] = false
							elseif SoD_DB["resetmode"] == "spec" then
								if not args.role or G.Role[args.role] == SoD_DB[G.PlayerName]["spec_info"] then
									Character_default_Settings[args.type][args.mobID] = true
								else
									Character_default_Settings[args.type][args.mobID] = false
								end
							end
						end
						
					else -- 光环或施法，有法术id
	
						if Character_default_Settings[args.type][args.spellID] == nil then
							if SoD_DB["resetmode"] == "enable" then
								Character_default_Settings[args.type][args.spellID] = true
							elseif SoD_DB["resetmode"] == "disable" then
								Character_default_Settings[args.type][args.spellID] = false
							elseif SoD_DB["resetmode"] == "spec" then
								if not args.role or G.Role[args.role] == SoD_DB[G.PlayerName]["spec_info"] then
									Character_default_Settings[args.type][args.spellID] = true
								else
									Character_default_Settings[args.type][args.spellID] = false
								end
							end
						end

					end			
				end
			elseif Alert_Type == "ChatMsg" then -- 已改
				for i, args in pairs(Alerts) do			
	
					if Character_default_Settings[args.type][args.spellID] == nil then
						if SoD_DB["resetmode"] == "enable" then
							Character_default_Settings[args.type][args.spellID] = true
						elseif SoD_DB["resetmode"] == "disable" then
							Character_default_Settings[args.type][args.spellID] = false
						elseif SoD_DB["resetmode"] == "spec" then
							if not args.role or G.Role[args.role] == SoD_DB[G.PlayerName]["spec_info"] then
								Character_default_Settings[args.type][args.spellID] = true
							else
								Character_default_Settings[args.type][args.spellID] = false
							end
						end
					end

				end
			elseif Alert_Type == "Sound" then -- 已改
				for i, args in pairs(Alerts) do
				
					local tag
					
					if args.event == "COMBAT_LOG_EVENT_UNFILTERED" then
						tag = args.spellID..G.sound_suffix[args.sub_event][1]
					else
						tag = args.spellID..G.sound_suffix[args.event][1]
					end
									
					if Character_default_Settings["Sound"][tag] == nil then
						if SoD_DB["resetmode"] == "enable" then
							Character_default_Settings["Sound"][tag] = true
						elseif SoD_DB["resetmode"] == "disable" then
							Character_default_Settings["Sound"][tag] = false
						elseif SoD_DB["resetmode"] == "spec" then
							if not args.role or G.Role[args.role] == SoD_DB[G.PlayerName]["spec_info"] then
								Character_default_Settings["Sound"][tag] = true
							else
								Character_default_Settings["Sound"][tag] = false
							end
						end
					end
					
				end
			end
		end
	end
end

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
		
		SoD_DB["resetmode"] = "enable"
		T.UpdateDefaultSettings()
		T.LoadVariables()
		T.LoadAccountVariables()		
		
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

T.ExportSettings = function()
	local str = G.addon_name.." Export".."~"..G.Version
	for OptionCategroy, OptionTable in pairs(Character_default_Settings) do
		if type(OptionTable) == "table" then		
			for setting, value in pairs(OptionTable) do
				if type(value) ~= "table" then -- 3
					--print(OptionCategroy, setting)
					if SoD_CDB[OptionCategroy][setting] ~= value then
						
						local valuetext
						if SoD_CDB[OptionCategroy][setting] == false then
							valuetext = "false"
						elseif SoD_CDB[OptionCategroy][setting] == true then
							valuetext = "true"
						else
							valuetext = SoD_CDB[OptionCategroy][setting]
						end
						str = str.."^"..OptionCategroy.."~"..setting.."~"..valuetext
						--print(OptionCategroy.."~"..setting.."~"..valuetext)
					else
						
					end
				end
			end
		end
	end
	for frame, info in pairs (SoD_CDB["FramePoints"]) do
		for key, value in pairs(info) do
			local f = _G[frame]
			if f and f["point"] then
				if info[key] ~= f["point"][key] then
					str = str.."^FramePoints~"..frame.."~"..key.."~"..info[key]
					--print(frame.."~"..key.."~"..info[key])
				end
			else -- 框体在当前配置尚未创建
				str = str.."^FramePoints~"..frame.."~"..key.."~"..info[key]
				--print(frame.."~"..key.."~"..info[key])
			end
		end
	end
	return str
end

T.ImportSettings = function(str)
	local optionlines = {string.split("^", str)}
	local addon_name, version = string.split("~", optionlines[1])
	local sameversion
	
	if addon_name ~= G.addon_name.." Export" then
		StaticPopup_Show(G.addon_name.."Cannot Import")
	else
		local import_str = ""
		if version ~= G.Version then
			import_str = import_str..format(L["版本不符合"], version, G.Version)
		else
			sameversion = true
		end
		
		if not sameversion then
			import_str = import_str..L["不完整导入"]
		end
		
		StaticPopupDialogs[G.addon_name.."Import Confirm"].text = format(L["导入确认"]..import_str, G.addon_name)
		StaticPopupDialogs[G.addon_name.."Import Confirm"].OnAccept = function()
			SoD_CDB = {}
			
			SoD_DB["resetmode"] = "enable"
			T.UpdateDefaultSettings()
			T.LoadVariables()

			for index, v in pairs(optionlines) do
				if index ~= 1 then
					local OptionCategroy, setting, arg1, arg2 = string.split("~", v)	
					local count = select(2, string.gsub(v, "~", "~")) + 1
					
					if count == 3 then -- 可以直接赋值
					
						if tonumber(setting) and OptionCategroy ~= "PlateNpcID" and OptionCategroy ~= "PlatePower" then
							setting = tonumber(setting)
						end
						
						if SoD_CDB[OptionCategroy][setting] ~= nil then
							if arg1 == "true" then
								SoD_CDB[OptionCategroy][setting] = true	
							elseif arg1 == "false" then
								SoD_CDB[OptionCategroy][setting] = false
							elseif tonumber(arg1) then
								SoD_CDB[OptionCategroy][setting] = tonumber(arg1)
							else
								SoD_CDB[OptionCategroy][setting] = arg1
							end
						end
					elseif OptionCategroy == "FramePoints" then -- 4 ^FramePoints~"..frame.."~"..key.."~"..info[key]
						if SoD_CDB[OptionCategroy][setting] == nil then
							SoD_CDB[OptionCategroy][setting] = {}
						end
						if arg1 == "x" or arg1 == "y" then
							SoD_CDB[OptionCategroy][setting][arg1] = tonumber(arg2)
						else
							SoD_CDB[OptionCategroy][setting][arg1] = arg2
						end
					end
				end
			end
			ReloadUI()
		end
		StaticPopup_Show(G.addon_name.."Import Confirm")
	end
end