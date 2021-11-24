local T, C, L, G = unpack(select(2, ...))

local sharedConfigSpellIDs = {
    ["ArcaneTorrent"] = {202719, 50613, 80483, 28730, 129597, 155145, 232633, 25046, 69179},
    ["Asphyxiate"] = {221562, 108194},
    ["Evasion/Riposte"] = {5277, 199754},
    ["Ascendance"] = {114050, 114051},
    ["Bladestorm"] = {227847, 46924},
}

G.sharedConfigSpellIDs = sharedConfigSpellIDs	

local spells = 	{
	["DAMAGE"] = {
		["152108"] = true,
		["152279"] = true,
		["228920"] = true,
		["84714"] = true,
		["322109"] = true,
		["111898"] = true,
		["321530"] = true,
		["279302"] = true,
		["123904"] = true,
		["201430"] = true,
		["113656"] = true,
		["31884"] = true,
		["13877"] = true,
		["205180"] = true,
		["1122"] = true,
		["113860"] = true,
		["79140"] = true,
		["49206"] = true,
		["102543"] = true,
		["19574"] = true,
		["319952"] = true,
		["343142"] = true,
		["51271"] = true,
		["12042"] = true,
		["121471"] = true,
		["42650"] = true,
		["102560"] = true,
		["190319"] = true,
		["107574"] = true,
		["193530"] = true,
		["1719"] = true,
		["198067"] = true,
		["137639"] = true,
		["10060"] = true,
		["271877"] = true,
		["63560"] = true,
		["152277"] = true,
		["105809"] = true,
		["260402"] = true,
		["280772"] = true,
		["Ascendance"] = true,
		["12472"] = true,
		["106951"] = true,
		["51533"] = true,
		["267217"] = true,
		["231895"] = true,
		["321507"] = true,
		["275699"] = true,
		["202770"] = true,
		["191427"] = true,
		["319454"] = true,
		["288613"] = true,
		["113858"] = true,
		["277925"] = true,
		["115989"] = true,
		["Bladestorm"] = true,
		["228260"] = true,
		["13750"] = true,
		["192249"] = true,
		["152173"] = true,
		["191634"] = true,
		["266779"] = true,
		["262228"] = true,
		["51690"] = true,
		["265187"] = true,
		["207289"] = true,
		["194223"] = true,
		["258925"] = true,
		["343721"] = true,
	},
	["TANK"] = {
		["204021"] = true,
		["31850"] = true,
		["1160"] = true,
		["12975"] = true,
		["187827"] = true,
		["115176"] = true,
		["115546"] = true,
		["263648"] = true,
		["56222"] = true,
		["194844"] = true,
		["115399"] = true,
		["871"] = true,
		["49028"] = true,
		["55233"] = true,
		["185245"] = true,
		["102558"] = true,
		["325153"] = true,
		["322507"] = true,
		["86659"] = true,
		["212084"] = true,
		["204066"] = true,
		["6795"] = true,
		["50334"] = true,
		["132578"] = true,
		["80313"] = true,
		["1161"] = true,
		["320341"] = true,
		["219809"] = true,
		["355"] = true,
		["105809"] = true,
		["62124"] = true,
	},
	["INTERRUPT"] = {
		["147362"] = true,
		["57994"] = true,
		["15487"] = true,
		["1766"] = true,
		["183752"] = true,
		["187707"] = true,
		["116705"] = true,
		["2139"] = true,
		["106839"] = true,
		["47528"] = true,
		["96231"] = true,
		["89766"] = true,
		["6552"] = true,
		["78675"] = true,
		["31935"] = true,
		["19647"] = true,
	},
	["STHARDCC"] = {
		["408"] = true,
		["853"] = true,
		["5211"] = true,
		["287712"] = true,
		["107570"] = true,
		["64044"] = true,
		["22570"] = true,
		["6789"] = true,
		["Asphyxiate"] = true,
		["211881"] = true,
		["88625"] = true,
		["19577"] = true,
	},
	["HEALING"] = {
		["200025"] = true,
		["198838"] = true,
		["246287"] = true,
		["216331"] = true,
		["740"] = true,
		["200183"] = true,
		["203651"] = true,
		["102351"] = true,
		["108281"] = true,
		["47536"] = true,
		["108280"] = true,
		["33891"] = true,
		["265202"] = true,
		["322118"] = true,
		["64843"] = true,
		["31884"] = true,
		["10060"] = true,
		["197721"] = true,
		["114052"] = true,
		["319454"] = true,
		["109964"] = true,
		["115310"] = true,
		["325197"] = true,
		["105809"] = true,
		["15286"] = true,
	},
	["RAIDCD"] = {
		["62618"] = true,
		["31821"] = true,
		["98008"] = true,
		["51052"] = true,
		["196718"] = true,
		["97462"] = true,
	},
	["COVENANT"] = {
		["326059"] = true,
		["307443"] = true,
		["323673"] = true,
		["323547"] = true,
		["328547"] = true,
		["312202"] = true,
		["328231"] = true,
		["327661"] = true,
		["324739"] = true,
		["323654"] = true,
		["314791"] = true,
		["323546"] = true,
		["311648"] = true,
		["324149"] = true,
		["310143"] = true,
		["304971"] = true,
		["324386"] = true,
		["314793"] = true,
		["324220"] = true,
		["325216"] = true,
		["310454"] = true,
		["312321"] = true,
		["325886"] = true,
		["300728"] = true,
		["307865"] = true,
		["329554"] = true,
		["325028"] = true,
		["328923"] = true,
		["324143"] = true,
		["320674"] = true,
		["308491"] = true,
		["325289"] = true,
		["325727"] = true,
		["321792"] = true,
		["323764"] = true,
		["323639"] = true,
		["326860"] = true,
		["324631"] = true,
		["324724"] = true,
		["328204"] = true,
		["327104"] = true,
		["328305"] = true,
		["325640"] = true,
		["323436"] = true,
		["315443"] = true,
		["306830"] = true,
		["317009"] = true,
		["324128"] = true,
		["325013"] = true,
		["316958"] = true,
	},
	["BREZ"] = {
		["20484"] = true,
		["20707"] = true,
		["61999"] = true,
	},
	["SOFTCC"] = {
		["102359"] = true,
		["198898"] = true,
		["207167"] = true,
		["204263"] = true,
		["202137"] = true,
		["324312"] = true,
		["207684"] = true,
		["99"] = true,
		["102793"] = true,
		["5246"] = true,
		["116844"] = true,
		["113724"] = true,
		["132469"] = true,
		["51485"] = true,
		["8122"] = true,
		["202138"] = true,
		["115750"] = true,
		["108199"] = true,
		["31661"] = true,
		["5484"] = true,
		["162488"] = true,
	},
	["HARDCC"] = {
		["205369"] = true,
		["179057"] = true,
		["255654"] = true,
		["119381"] = true,
		["20549"] = true,
		["30283"] = true,
		["192058"] = true,
		["46968"] = true,
		["109248"] = true,
	},
	["IMMUNITY"] = {
		["45438"] = true,
		["642"] = true,
		["196555"] = true,
		["31224"] = true,
		["186265"] = true,
	},
	["STSOFTCC"] = {
		["186387"] = true,
		["187650"] = true,
		["51514"] = true,
		["20066"] = true,
		["1776"] = true,
		["217832"] = true,
		["88625"] = true,
		["115078"] = true,
		["2094"] = true,
		["107079"] = true,
	},
	["DISPEL"] = {
		["32375"] = true,
		["ArcaneTorrent"] = true,
		["527"] = true,
		["77130"] = true,
		["265221"] = true,
		["51886"] = true,
		["8143"] = true,
		["115450"] = true,
		["88423"] = true,
		["4987"] = true,
		["278326"] = true,
		["213644"] = true,
		["213634"] = true,
		["19801"] = true,
		["20594"] = true,
		["475"] = true,
		["2782"] = true,
		["218164"] = true,
		["2908"] = true,
	},
	["PERSONAL"] = {
		["327574"] = true,
		["185311"] = true,
		["108978"] = true,
		["108271"] = true,
		["118038"] = true,
		["48743"] = true,
		["198589"] = true,
		["109304"] = true,
		["205191"] = true,
		["Evasion/Riposte"] = true,
		["48792"] = true,
		["235450"] = true,
		["122783"] = true,
		["264735"] = true,
		["498"] = true,
		["22812"] = true,
		["184662"] = true,
		["108238"] = true,
		["48707"] = true,
		["55342"] = true,
		["108416"] = true,
		["61336"] = true,
		["319454"] = true,
		["23920"] = true,
		["235313"] = true,
		["47585"] = true,
		["122278"] = true,
		["49039"] = true,
		["122470"] = true,
		["115203"] = true,
		["104773"] = true,
		["342245"] = true,
		["243435"] = true,
		["19236"] = true,
		["184364"] = true,
		["11426"] = true,
	},
	["EXTERNAL"] = {
		["633"] = true,
		["47788"] = true,
		["33206"] = true,
		["3411"] = true,
		["6940"] = true,
		["204018"] = true,
		["102342"] = true,
		["1022"] = true,
		["116849"] = true,
		["207399"] = true,
	},
	["UTILITY"] = {
		["132158"] = true,
		["1725"] = true,
		["199483"] = true,
		["235219"] = true,
		["188501"] = true,
		["205636"] = true,
		["192077"] = true,
		["114018"] = true,
		["16191"] = true,
		["1856"] = true,
		["205025"] = true,
		["186257"] = true,
		["29166"] = true,
		["64901"] = true,
		["64382"] = true,
		["57934"] = true,
		["34477"] = true,
		["66"] = true,
		["58984"] = true,
		["116841"] = true,
		["1044"] = true,
		["79206"] = true,
		["49576"] = true,
		["73325"] = true,
		["110959"] = true,
		["198103"] = true,
		["106898"] = true,
		["333889"] = true,
		["5384"] = true,
	},
}

G.spells = spells

local Character_default_Settings = {
	FramePoints = {},
	
	General = {
		disable_all = false,
		disable_sound = false,
		disable_rmark = false,
		hide_minimap = false,
		short_name = true,
		name_length = 4,
		rm = true,
		rm_sound = true,
		trans = true,
		trans_sound = true,
		tl = true,
		tl_font_size = 18,
		tl_use_self = true,
		tl_use_raid = true,
		tl_show_time = false,
		tl_exp_time = true,
		tl_advance = 60,
		tl_dur = 5,
		tl_show_bar = true,
		tl_only_my_bar = true,
		tl_bar_sound = true,
		tl_bar_width = 400,
		tl_bar_height = 20,
		tl_bar_sound_dur = 5, 
		tl_bar_mynickname = "",
		moving_boss = 1,
		ds = true,
		ds_test = false,
		ds_icon_size = 35,
		ds_font_size = 35,
		ds_color_gradiant = true,
		ds_show_hp = true,
	},
	
	AlertFrame = {
		enable = true,
		show_spellname = true,
		reverse_cooldown = true,
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
		size = 25,
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
		if addon ~= G.addon_name then return end
				
		T.LoadAccountVariables()
		T.UpdateDefaultSettings()
		T.LoadVariables()
		
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