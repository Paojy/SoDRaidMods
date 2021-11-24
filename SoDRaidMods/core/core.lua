local T, C, L, G = unpack(select(2, ...))

local addon_name = G.addon_name
local font = G.Font
local LCG = LibStub("LibCustomGlow-1.0")
local LGF = LibStub("LibGetFrame-1.0")

G.Test = {}
G.Icons = {}
G.Texts = {}
G.HL_Holders = {}
G.Plate_IconHolders = {}
G.Plate_Alerts = {
	PlateAuras = {},
	PlayerAuraSource = {},
	PlatePower = {},
	PlateSpells = {},
	PlateSpells = {},
	PlateNpcID = {},
}
G.Plate_AurabyBossMod = {}

G.Msgs = {}
G.Sounds = {}

 -- 需要转团队
G.Test_Mod = false
----------------------------------------------------------
-----------------[[    Frame Holder    ]]------------------
----------------------------------------------------------
local FrameHolder = CreateFrame("Frame", addon_name.."FrameHolder", UIParent)
G.FrameHolder = FrameHolder

local update_rate = 0.05
local glow_updaterate = 0.05
local glow_value = 0
G.glow_value = glow_value

FrameHolder:SetScript("OnUpdate", function(self, e)
	glow_updaterate = glow_updaterate - e
	if glow_updaterate <= 0 then
		glow_value = glow_value + 0.05
		if glow_value >= .5 then
			glow_value = -.5
		end
		glow_updaterate = 0.05
	end
end)

T.UpdateAll = function()
	if SoD_CDB["General"]["disable_all"] then
		FrameHolder:Hide()
	else
		FrameHolder:Show()
	end
	-- update
	T.EditAlertFrame("all")
	T.EditTextFrame("all")
	T.EditPlateIcons("enable")
	T.EditBossModsFrame("all")
	T.EditTimeline("all")
	T.EditDSFrame("all")
end

FrameHolder:RegisterEvent("PLAYER_ENTERING_WORLD")
FrameHolder:SetScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_ENTERING_WORLD" then
		T.UpdateAll()
		FrameHolder:UnregisterEvent("PLAYER_ENTERING_WORLD")
	end
end)

----------------------------------------------------------
---------------[[    Raid Mark Frame    ]]----------------
----------------------------------------------------------
local RMFrame = CreateFrame("Frame", addon_name.."RMFrame", FrameHolder)
RMFrame:SetSize(100,100)

RMFrame.movingname = L["团队标记提示"]
RMFrame.point = { a1 = "BOTTOM", parent = "UIParent", a2 = "CENTER", x = 0, y = 200 }
T.CreateDragFrame(RMFrame)

RMFrame.Icon = RMFrame:CreateTexture(nil, "OVERLAY")
RMFrame.Icon:SetAllPoints()
RMFrame.Icon:SetTexture([[Interface\TargetingFrame\UI-RaidTargetingIcons]])
RMFrame.Icon:Hide()

RMFrame.anim = RMFrame:CreateAnimationGroup()
RMFrame.anim:SetLooping("REPEAT")
RMFrame.timer = RMFrame.anim:CreateAnimation()
RMFrame.timer.t = 0
RMFrame.timer:SetDuration(.5)

RMFrame:RegisterEvent("RAID_TARGET_UPDATE")
 
RMFrame:SetScript("OnEvent", function(self, event)
	if SoD_CDB["General"]["rm"] then
		local index = GetRaidTargetIndex("player")
		if index and self.old ~= index then
			self.old = index
			--print("index changed to"..index)
			if not SoD_CDB["General"]["disable_sound"] and SoD_CDB["General"]["rm_sound"] then
				PlaySoundFile(G.media.sounds.."mark\\mark"..index..".ogg", "Master") -- 声音 标记名字
			end
			SetRaidTargetIconTexture(self.Icon, index)
			self.timer.exp = GetTime() + 3
			self.timer:SetScript("OnUpdate", function(timer,e)
				timer.t = timer.t + e
				if timer.t > update_rate then
					--print("update")
					local remain = timer.exp - GetTime()
					if remain > 0 then
						self.Icon:SetAlpha(timer:GetProgress())
					else
						timer:SetScript("OnUpdate", nil)
						self.anim:Stop()
						self.Icon:Hide()
					end		
					timer.t = 0
				end
			end)
			self.Icon:Show()
			self.anim:Play()
			
		elseif not index then
			self.old = 0
			self.timer:SetScript("OnUpdate", nil)
			self.Icon:Hide()
			self.anim:Stop()
		end
	else
		self.old = 0
		self.timer:SetScript("OnUpdate", nil)
		self.Icon:Hide()
		self.anim:Stop()
	end
end)

----------------------------------------------------------
------------[[    Trans In Range Check    ]]--------------
----------------------------------------------------------
local TransFrame = CreateFrame("Button", addon_name.."TransFrame", FrameHolder, "SecureUnitButtonTemplate")
TransFrame:SetSize(70,70)
TransFrame:SetAttribute("unit", "focus")
TransFrame.unit = "focus"
G.TransFrame = TransFrame

TransFrame.movingname = L["焦点传送门可交互提示"]
TransFrame.point = { a1 = "LEFT", parent = "UIParent", a2 = "CENTER", x = 200, y = 0 }
T.CreateDragFrame(TransFrame)

TransFrame.Icon = TransFrame:CreateTexture(nil, "OVERLAY", 1)
TransFrame.Icon:SetAllPoints()
TransFrame.Icon:SetTexture(select(3, GetSpellInfo(111771)))
TransFrame.Icon:SetTexCoord(.1, .9, .1, .9)
TransFrame.Iconbg = T.createbdframe(TransFrame)

TransFrame:SetScript("OnEnter", function(self)
	UnitFrame_OnEnter(self)
end)
TransFrame:SetScript("OnLeave", function(self)
	UnitFrame_OnLeave(self)	
end)

TransFrame.glow = TransFrame:CreateTexture(nil, "OVERLAY")
TransFrame.glow:SetPoint("TOPLEFT", -25, 25)
TransFrame.glow:SetPoint("BOTTOMRIGHT", 25, -25)
TransFrame.glow:SetAlpha(1)
TransFrame.glow:SetTexture([[Interface\SpellActivationOverlay\IconAlert]])
TransFrame.glow:SetTexCoord(0.00781250, 0.50781250, 0.27734375, 0.52734375)
TransFrame.glow:Hide()

NoTransFrame = CreateFrame("Frame", addon_name.."NoTransFrame", FrameHolder)
NoTransFrame:SetAllPoints(TransFrame)
G.NoTransFrame = NoTransFrame

NoTransFrame.text = T.createtext(NoTransFrame, "OVERLAY", 20, "OUTLINE", "CENTER")
NoTransFrame.text:SetPoint("CENTER")
NoTransFrame.text:SetTextColor(1, 1, 0)
NoTransFrame.text:SetText(L["未设焦点"])

NoTransFrame.Icon = NoTransFrame:CreateTexture(nil, "OVERLAY", 1)
NoTransFrame.Icon:SetAllPoints()
NoTransFrame.Icon:SetTexture(select(3, GetSpellInfo(111771)))
NoTransFrame.Icon:SetTexCoord(.1, .9, .1, .9)
NoTransFrame.Icon:SetDesaturated(true)
NoTransFrame.Icon:SetVertexColor(1, 0, 0)
NoTransFrame.Iconbg = T.createbdframe(NoTransFrame)

local trans_debuff = GetSpellInfo(113942)

TransFrame.Update = function(self, event, arg1)
	if event == "SOD_UPDATE_DB" then
		if SoD_CDB["General"]["trans"] then
			TransFrame.Update(self, "PLAYER_ENTERING_WORLD")
			TransFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
		else
			TransFrame:Hide()
			NoTransFrame:Hide()
			UnregisterUnitWatch(TransFrame)
			TransFrame:UnregisterAllEvents()
		end
	elseif event == "PLAYER_ENTERING_WORLD" then
		if SoD_CDB["General"]["trans"] then
			local instanceType = select(2, GetInstanceInfo())
			if instanceType == "raid" then
				TransFrame:Show()
				NoTransFrame:Show()
				RegisterUnitWatch(TransFrame)
				TransFrame:RegisterEvent("PLAYER_FOCUS_CHANGED")
				TransFrame:RegisterEvent("UNIT_AURA")
			else
				TransFrame:Hide()
				NoTransFrame:Hide()
				UnregisterUnitWatch(TransFrame)
				TransFrame:UnregisterEvent("PLAYER_FOCUS_CHANGED")
				TransFrame:UnregisterEvent("UNIT_AURA")
			end
		end
	elseif event == "PLAYER_FOCUS_CHANGED" then
		if SoD_CDB["General"]["trans"] then
			local guid = UnitGUID("focus")
			if not guid then
				NoTransFrame:Show()
				self.focused = false
			else
				local npcID = select(6, strsplit("-", guid))
				if npcID == "59271" or npcID == "59262" then
					NoTransFrame:Hide()
					self.focused = true
				else
					NoTransFrame:Show()
					self.focused = false
				end
			end		
		end
	elseif event == "UNIT_AURA" and arg1 == "player" then
		if SoD_CDB["General"]["trans"] then
			if AuraUtil.FindAuraByName(trans_debuff, "player", "HARMFUL") then
				self.Icon:SetDesaturated(true)
			else
				self.Icon:SetDesaturated(false)
			end
		end
	end
end

TransFrame:SetScript("OnEvent", function(self, event, arg1)
	TransFrame.Update(self, event, arg1)
end)

TransFrame.t = 0
TransFrame.anim = TransFrame:CreateAnimationGroup()
TransFrame.anim:SetLooping("REPEAT")
TransFrame.timer = TransFrame.anim:CreateAnimation()
TransFrame.timer.t = 0
TransFrame.timer:SetDuration(.5)
TransFrame.last_played = 0

TransFrame:SetScript("OnUpdate", function(self, e)
	if SoD_CDB["General"]["trans"] then
		self.t = self.t + e
		if self.t > 0.1 then
			if TransFrame.focused and not AuraUtil.FindAuraByName(trans_debuff, "player", "HARMFUL") then
				local inrange = IsItemInRange(37727, "focus")
				if inrange and not TransFrame.state then
					TransFrame.state = true
					if not SoD_CDB["General"]["disable_sound"] and SoD_CDB["General"]["trans_sound"] then
						if GetTime() - TransFrame.last_played > 10 then -- 10秒内不再播放
							PlaySoundFile(G.media.sounds.."transready.ogg", "Master") -- 声音 标记名字
							TransFrame.last_played = GetTime()
						end
					end
					self.timer.exp = GetTime() + 5
					self.timer:SetScript("OnUpdate", function(timer,e)
						timer.t = timer.t + e
						if timer.t > update_rate then
							local remain = timer.exp - GetTime()
							if remain > 0 then
								self.glow:SetAlpha(timer:GetProgress())
							else
								timer:SetScript("OnUpdate", nil)
								self.anim:Stop()
								self.glow:Hide()
							end		
							timer.t = 0
						end
					end)
					self.glow:Show()
					self.anim:Play()
				elseif not inrange then
					TransFrame.state = false
					self.timer:SetScript("OnUpdate", nil)
					self.glow:Hide()
					self.anim:Stop()
				end		
			else
				self.timer:SetScript("OnUpdate", nil)
				self.glow:Hide()
				self.anim:Stop()
			end
			self.t	= 0
		end
	end
end)

----------------------------------------------------------
----------------[[    EXRT time line    ]]----------------
----------------------------------------------------------

local Timeline = CreateFrame("Frame", addon_name.."TLFrame", FrameHolder)
Timeline:SetSize(300,100)
Timeline.assignment_cd = {}
Timeline.phase_cd = {}
Timeline.start = 0
Timeline:Hide()

Timeline.movingname = L["动态战术板"]
Timeline.point = { a1 = "TOPLEFT", parent = "UIParent", a2 = "CENTER", x = -700, y = 500 }
T.CreateDragFrame(Timeline)

Timeline.clock = T.createtext(Timeline, "OVERLAY", 20, "OUTLINE", "LEFT")
Timeline.clock:SetPoint("TOPLEFT", Timeline, "TOPLEFT", 0, 0)

Timeline.whiteline = Timeline:CreateTexture(nil, "ARTWORK")
Timeline.whiteline:SetSize(150, 1)
Timeline.whiteline:SetPoint("TOPLEFT", Timeline.clock, "BOTTOMLEFT", 0, -6)
Timeline.whiteline:SetColorTexture(1, 1, 1, .5)
T.createbdframe(Timeline.whiteline)
		
Timeline.clock:SetPoint("TOPLEFT", Timeline, "TOPLEFT", 0, 0)

Timeline.ActiveLines = {}
Timeline.ActiveBars = {}
Timeline.MyNames = {}
	
T.EditTimeline = function(option)
	if option == "all" or option == "enable" then
		if SoD_CDB["General"]["tl"] then			
			Timeline:RegisterEvent("ENCOUNTER_START")
			Timeline:RegisterEvent("ENCOUNTER_END")
			Timeline:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
			Timeline:RegisterEvent("CHAT_MSG_ADDON")
		else
			Timeline:UnregisterEvent("ENCOUNTER_START")
			Timeline:UnregisterEvent("ENCOUNTER_END")
			Timeline:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
			Timeline:UnregisterEvent("CHAT_MSG_ADDON")
			Timeline:Hide()
		end
	end
	
	if option == "all" or option == "name" then
		Timeline.MyNames = table.wipe(Timeline.MyNames)
		table.insert(Timeline.MyNames, G.PlayerName)
		local storename = {string.split(" ", SoD_CDB["General"]["tl_bar_mynickname"])}
		for i, name in pairs(storename) do
			if name ~= "" then
				table.insert(Timeline.MyNames, name)
			end
		end
	end
	
	if option == "all" or option == "bar" then
		Timeline.BarParent:SetSize(SoD_CDB["General"]["tl_bar_width"], SoD_CDB["General"]["tl_bar_height"])
	end
	
	for k, line in pairs(Timeline.ActiveLines) do
		line.update_onedit(option)
	end
	
	for k, bar in pairs(Timeline.ActiveBars) do
		line.update_onedit(option)
	end
	
	if option == "all" or option == "font_size" then
		Timeline.clock:SetFont(G.Font, SoD_CDB["General"]["tl_font_size"], "OUTLINE")
		Timeline.whiteline:SetSize(8*SoD_CDB["General"]["tl_font_size"], 1)
		Timeline.LineUpLines()
	end
end

Timeline.LineUpLines = function()
	local t = {}
	for i, line in pairs(Timeline.ActiveLines) do
		if line and line:IsVisible() then
			table.insert(t, line)
		end
	end
	if #t > 1 then
		table.sort(t, function(a, b) 
			if a.row_time < b.row_time then
				return true
			elseif a.row_time == b.row_time and a.ind < b.ind then
				return true
			end
		end)
	end
	local lastline
	for i, line in pairs(t) do
		line:ClearAllPoints()
		if line:IsVisible() then
			if not lastline then
				line:SetPoint("TOPLEFT", Timeline.whiteline, "TOPLEFT", 0, -5)
				lastline = line
			else
				line:SetPoint("TOPLEFT", lastline, "BOTTOMLEFT", 0, -5)
				lastline = line
			end
		end
	end
end

Timeline.CreateLine = function(ind, str, exp_time, row_time)
	local frame = CreateFrame("Frame", nil, Timeline)
	frame:SetSize(300, SoD_CDB["General"]["tl_font_size"])
	frame:SetPoint("TOPLEFT", Timeline.whiteline, "BOTTOMLEFT", 0, -5)
	frame.exp_time = exp_time
	frame.row_time = row_time
	
	frame.ind = ind
	
	frame.text = T.createtext(frame, "OVERLAY", SoD_CDB["General"]["tl_font_size"], "OUTLINE", "LEFT")	
	frame.text:SetPoint("LEFT", frame, "LEFT", 0, 0)
	
	frame.update_str = function(remain)	
		local format_str = str
		if not SoD_CDB["General"]["tl_show_time"] then
			format_str = format_str:gsub("%d+:%d+", "") 
		end
		
		format_str = format_str:gsub("{spell:(%d+)}", T.GetSpellIcon)
		
		if SoD_CDB["General"]["tl_exp_time"] then
			local layout_remain = remain - SoD_CDB["General"]["tl_dur"]
			if layout_remain < 0 then
				format_str = string.format("|cffC0C0C0------|r %s", format_str)
			elseif layout_remain < 3 then
				format_str = string.format("|cffFF0000%.1f|r     %s", layout_remain, format_str)
			elseif layout_remain < 5 then
				format_str = string.format("|cffFFD700%d|r        %s", layout_remain, format_str)
			elseif layout_remain < 10 then 
				format_str = string.format("|cff00FF00%d|r        %s", layout_remain, format_str)
			else
				format_str = string.format("%s %s", date("|cff40E0D0%M:%S|r", layout_remain), format_str)
			end 
		end
		
		frame.text:SetText(format_str)
	end
	
	frame.update_onedit = function(option)
		if option == "all" or option == "font_size" then
			frame:SetSize(300, SoD_CDB["General"]["tl_font_size"])
			frame.text:SetFont(G.Font, SoD_CDB["General"]["tl_font_size"], "OUTLINE")
		end
		
		if option == "all" or option == "format" then
			local remain = frame.exp_time - GetTime()
			frame.update_str(remain)
		end
	end
	
	frame.t = 0
	frame:SetScript("OnUpdate", function(self, e)
		self.t = self.t + e
		if self.t > update_rate then
			local remain = self.exp_time - GetTime()
			if remain > 0 then
				self.update_str(remain)
				if remain < 1 and not self.fade then
					self.fade = true
					T.UIFrameFadeOut(self, remain, self:GetAlpha(), 0)
				end
			else
				self:SetScript("OnUpdate", nil)
				self:Hide()
				Timeline.ActiveLines[ind] = nil
				Timeline.LineUpLines()
			end
			self.t = 0
		end
	end)
	
	Timeline.ActiveLines[ind] = frame
	Timeline.LineUpLines()
	
	frame:SetAlpha(0)
	T.UIFrameFadeIn(frame, 1, frame:GetAlpha(), 1)
end

Timeline.BarParent = CreateFrame("Frame", addon_name.."TLFrame Bar", FrameHolder)
Timeline.BarParent:SetSize(400,25)

Timeline.BarParent.movingname = L["动态战术板计时条"]
Timeline.BarParent.point = { a1 = "BOTTOM", parent = "UIParent", a2 = "CENTER", x = 0, y = 350 }
T.CreateDragFrame(Timeline.BarParent)

Timeline.BarParent.soundexp = 0

Timeline.LineUpBars = function()
	local t = {}
	for i, bar in pairs(Timeline.ActiveBars) do
		if bar and bar:IsVisible() then
			table.insert(t, bar)
		end
	end
	if #t > 1 then
		table.sort(t, function(a, b) 
			if a.row_time < b.row_time then
				return true
			elseif a.row_time == b.row_time and a.ind < b.ind then
				return true
			end
		end)
	end
	local lastbar
	for i, bar in pairs(t) do
		bar:ClearAllPoints()
		if bar:IsVisible() then
			if not lastbar then
				bar:SetPoint("TOP", Timeline.BarParent, "TOP", 0, 0)
				lastbar = bar
			else
				bar:SetPoint("TOP", lastbar, "BOTTOM", 0, -5)
				lastbar = bar
			end
		end
	end
end
	
Timeline.CreateBar = function(ind, str, exp_time, row_time)
	local frame = CreateFrame("StatusBar", nil, Timeline.BarParent)
	frame:SetSize(SoD_CDB["General"]["tl_bar_width"], SoD_CDB["General"]["tl_bar_height"])
	frame:SetPoint("TOP", Timeline.BarParent, "TOP", 0, 0)	
	T.createborder(frame)
	
	frame.exp_time = exp_time
	frame.row_time = row_time	
	frame.ind = ind
	
	frame:SetStatusBarTexture(G.media.blank)
	frame:SetStatusBarColor(0, 1, .7)
	frame:GetStatusBarTexture():SetHorizTile(false)
	frame:GetStatusBarTexture():SetVertTile(false)
	frame:SetOrientation("HORIZONTAL")
	frame:SetMinMaxValues(0, 10)
	frame:SetValue(0)
	
	frame.left = T.createtext(frame, "OVERLAY", SoD_CDB["General"]["tl_bar_height"]-4, "OUTLINE", "LEFT")	
	frame.left:SetPoint("LEFT", frame, "LEFT", 5, 0)
	frame.left:SetText(str:gsub("%d+:%d+", ""):gsub("{spell:(%d+)}", T.GetSpellIcon))
	
	frame.right = T.createtext(frame, "OVERLAY", SoD_CDB["General"]["tl_bar_height"]-4, "OUTLINE", "RIGHT")	
	frame.right:SetPoint("RIGHT", frame, "RIGHT", -5, 0)
	
	frame.tex = frame:CreateTexture(nil, "OVERLAY", 1)
	frame.tex:SetTexture("Interface\\Buttons\\WHITE8x8")
	frame.tex:SetVertexColor(0, 0, 0)
	frame.tex:SetSize(2, SoD_CDB["General"]["tl_bar_height"])
	frame.tex:SetPoint("LEFT", frame:GetStatusBarTexture(), "RIGHT", 0, 0)

	frame.update_onedit = function(option)
		if option == "all" or option == "bar" then
			if not SoD_CDB["General"]["tl_show_bar"] then
				frame:Hide()
				frame:SetScript("OnUpdate", nil)
				Timeline.ActiveBars[ind] = nil
			else
				frame:SetSize(SoD_CDB["General"]["tl_bar_width"], SoD_CDB["General"]["tl_bar_height"])
				frame.left:SetFont(G.Font, SoD_CDB["General"]["tl_bar_height"]-2, "OUTLINE")
				frame.right:SetFont(G.Font, SoD_CDB["General"]["tl_bar_height"]-2, "OUTLINE")
			end
		end
	end
	
	frame.Play = function()
		if not SoD_CDB["General"]["disable_sound"] and SoD_CDB["General"]["tl_bar_sound"] then
			if GetTime() > Timeline.BarParent.soundexp then
				local spell_voice = {}
				local spell_voice_id_tag = {}
				for i, name in pairs(Timeline.MyNames) do
					local pos = 1
					while strfind(str, name, pos) do
						local target_pos, target_end = strfind(str, name, pos)
						local str_after = strsub(str, target_end+1)
						local last_spell = last_spell or 1
						for spellID in str_after:gmatch("{spell:(%d+)}") do
							local spell_str = string.format("{spell:%d}", spellID)
							local spell_start, spell_end = strfind(str_after, spell_str, pos)
							local between = strsub(str_after, last_spell, spell_start - 1):gsub(" ", ""):gsub("|r", "")
							if between == "" then -- 去掉空格和|r后什么都没有							
								if not spell_voice_id_tag[spellID] then -- 避免重复
									table.insert(spell_voice, spellID)
									spell_voice_id_tag[spellID] = true
								end
							end
							last_spell = spell_end + 1
						end
						pos = target_end -- 看看后面这个人还出现没
					end
				end
				for i, spell in pairs(spell_voice) do
					if i == 1 then
						PlaySoundFile(G.media.spellsounds..spell..".ogg", "Master") -- 声音
						--print(GetSpellInfo(spell))
					else
						local wait = i-1
						C_Timer.After(wait, function()
							PlaySoundFile(G.media.spellsounds..spell..".ogg", "Master") -- 声音
							--print(GetSpellInfo(spell))
						end)
					end
				end
				frame.played = true
				Timeline.BarParent.soundexp = GetTime() + #spell_voice
			end
		end
	end
	--frame.Play()
	
	frame.t = 0
	frame:SetScript("OnUpdate", function(self, e)		
		self.t = self.t + e
		if self.t > 0.02 then	
			local remain = self.exp_time - GetTime()	
			if remain > 0 then				
				if remain < SoD_CDB["General"]["tl_bar_sound_dur"] then
					for i, bar in pairs(Timeline.ActiveBars) do
						if not frame.played then
							self.Play()
						end
					end
				end
				self.right:SetText(T.FormatTime(remain))
				self:SetValue(10 - remain)
			else
				self:SetScript("OnUpdate", nil)
				self:Hide()
				Timeline.ActiveBars[ind] = nil
				Timeline.LineUpBars()
			end
			self.t = 0
		end
	end)
	
	Timeline.ActiveBars[ind] = frame
	Timeline.LineUpBars()
end

Timeline.t = 0
Timeline.t_offset = 0
Timeline:SetScript("OnUpdate", function(self, e)
	self.t = self.t + e
	if self.t > update_rate then
		if self.start > 0 then
			local dur = GetTime() - self.start
			local passed = floor(dur)
			local fake_passed = floor(dur + self.t_offset) 
			if self.last ~= passed then
				--print(passed)
				C_ChatInfo.SendAddonMessage("sodpaopao", "timeline_"..fake_passed, "WHISPER", G.PlayerName)
				self.last = passed
			end
			
			local str = date("|T134376:12:12:0:0:64:64:4:60:4:60|t %M:%S", dur)
			local fake_str = date("|T1391675:12:12:0:0:64:64:4:60:4:60|t %M:%S", fake_passed)
			self.clock:SetText(str.." ["..fake_str.."]")
		end
		self.t = 0
	end
end)

Timeline.PhaseTable = {}
Timeline.Encounter_Tags = {}

Timeline:RegisterEvent("ADDON_LOADED")
Timeline:SetScript("OnEvent", function(self, event, ...)
	if event == "ENCOUNTER_START" then
		local encounterID = ...
		
		self.t_offset = 0
		self.start = GetTime()
		self:Show()
        self.assignment_cd = table.wipe(self.assignment_cd)
        self.phase_cd = table.wipe(self.phase_cd)
				
        if IsAddOnLoaded("MRT") and (_G.VExRT.Note) then
			if SoD_CDB["General"]["tl_use_raid"] and _G.VExRT.Note.Text1 then
				local text = _G.VExRT.Note.Text1
				local betweenLine = false
				for line in text:gmatch('[^\r\n]+') do
					if line:match(L["战斗结束"]) then
						betweenLine = false
					end
					if betweenLine then                
						local str = line:gsub("||", "|")
						local phase_str, reset_m, reset_s = string.match(str, "P(%d+) (%d+):(%d+)")
						if phase_str then
							local reset_phase = tonumber(phase_str)
							if reset_phase > 1 and reset_m and reset_s then
								local engageID = ...
								if Timeline.PhaseTable[engageID] and Timeline.PhaseTable[engageID]["phase"..phase_str] then				
									if not self.phase_cd["phase"..phase_str] then
										self.phase_cd["phase"..phase_str] = {}
										self.phase_cd["phase"..phase_str]["to_time"] = {}					
										self.phase_cd["phase"..phase_str]["sub_event"] = Timeline.PhaseTable[engageID]["phase"..phase_str]["sub_event"]
										self.phase_cd["phase"..phase_str]["spellID"] = Timeline.PhaseTable[engageID]["phase"..phase_str]["spellID"]
										self.phase_cd["phase"..phase_str]["current"] = 1
									end
									local r = tonumber(reset_m)*60+tonumber(reset_s)
									table.insert(self.phase_cd["phase"..phase_str]["to_time"], r)
								end
							end
						else
							local m, s = string.match(str, "(%d+):(%d+)")
							if m and s then
								local r = tonumber(m)*60+tonumber(s)
								local t = max(r - SoD_CDB["General"]["tl_advance"], 0)
								local info = {
									cd_str = str,
									row_time = r,
									show_time = t,
									hide_time = r + SoD_CDB["General"]["tl_dur"],
								}
								table.insert(self.assignment_cd, info)
								--print(#self.assignment_cd, str, r, t)
							end
						end
					end
					if line:match(L["时间轴"]) then
						betweenLine = true
					end
				end    
			end
			if SoD_CDB["General"]["tl_use_self"] and _G.VExRT.Note.SelfText then
				
				local text = _G.VExRT.Note.SelfText
				local betweenLine = false
				local phase_cd_cache = {}
				
				for line in text:gmatch('[^\r\n]+') do
					if line:match(L["战斗结束"]) then
						betweenLine = false
					end
					if betweenLine then                
						local str = line:gsub("||", "|")
						local phase_str, reset_m, reset_s = string.match(str, "P(%d+) (%d+):(%d+)")
						if phase_str then
							local reset_phase = tonumber(phase_str)
							if reset_phase > 1 and reset_m and reset_s then
								local engageID = ...
								if Timeline.PhaseTable[engageID] and Timeline.PhaseTable[engageID]["phase"..phase_str] then				
									if not phase_cd_cache["phase"..phase_str] then
										phase_cd_cache["phase"..phase_str] = {}
										phase_cd_cache["phase"..phase_str]["to_time"] = {}					
										phase_cd_cache["phase"..phase_str]["sub_event"] = Timeline.PhaseTable[engageID]["phase"..phase_str]["sub_event"]
										phase_cd_cache["phase"..phase_str]["spellID"] = Timeline.PhaseTable[engageID]["phase"..phase_str]["spellID"]
										phase_cd_cache["phase"..phase_str]["current"] = 1
									end
									local r = tonumber(reset_m)*60+tonumber(reset_s)
									table.insert(phase_cd_cache["phase"..phase_str]["to_time"], r)
								end
							end
						else
							local m, s = string.match(str, "(%d+):(%d+)")
							if m and s then
								local r = tonumber(m)*60+tonumber(s)
								local t = max(r - SoD_CDB["General"]["tl_advance"], 0)
								local info = {
									cd_str = str,
									row_time = r,
									show_time = t,
									hide_time = r + SoD_CDB["General"]["tl_dur"],
								}
								table.insert(self.assignment_cd, info)
								--print(#self.assignment_cd, str, r, t)
							end
						end
					end
					if line:match(Timeline.Encounter_Tags[encounterID]..L["时间轴"]) then
						betweenLine = true
					end
				end
				-- 覆盖转阶段信息
				for p, info in pairs(phase_cd_cache) do
					if not self.phase_cd[p] then
						self.phase_cd[p] = {}
						self.phase_cd[p]["to_time"] = {}					
						self.phase_cd[p]["sub_event"] = phase_cd_cache[p]["sub_event"]
						self.phase_cd[p]["spellID"] = phase_cd_cache[p]["spellID"]
						self.phase_cd[p]["current"] = 1
					end
					for index, v in pairs(phase_cd_cache[p]["to_time"]) do
						self.phase_cd[p]["to_time"][index] = v
					end
				end
			end
        end
        
    elseif event == "ENCOUNTER_END" then
		self.start = 0
		
		self:Hide()
		
		for ind, line in pairs(Timeline.ActiveLines) do
			Timeline.ActiveLines[ind]:Hide()
			Timeline.ActiveLines[ind]:SetScript("OnUpdate", nil)
			Timeline.ActiveLines[ind] = nil
			Timeline.LineUpLines()
		end
		for ind, bar in pairs(Timeline.ActiveBars) do
			Timeline.ActiveBars[ind]:Hide()
			Timeline.ActiveBars[ind]:SetScript("OnUpdate", nil)
			Timeline.ActiveBars[ind] = nil
			Timeline.LineUpBars()
		end
    elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local _, sub_event, _, _, _, _, _, _, _, _, _, spellID = CombatLogGetCurrentEventInfo()
		for i, t in pairs(self.phase_cd) do
			if string.find(sub_event, t.sub_event) and t.spellID == spellID then
				if t.to_time[t.current] then
					self.t_offset = t.to_time[t.current] - (GetTime() - self.start)
					for ind, frame in pairs(Timeline.ActiveLines) do
						frame.exp_time = self.start + frame.row_time + SoD_CDB["General"]["tl_dur"] - self.t_offset
					end
					for ind, frame in pairs(Timeline.ActiveBars) do
						frame.exp_time = self.start + frame.row_time - self.t_offset
					end
					t.current = t.current + 1
				end
			end
		end
    elseif event == "CHAT_MSG_ADDON" then
        local prefix, message, channel, sender = ...

        if prefix == "sodpaopao" and channel == "WHISPER" and G.PlayerName == string.split("-", sender) then
			local mark, passed = string.split("_", message)
			if mark and mark == "timeline" then
				--print("战斗计时", passed)
				passed = tonumber(passed)
				for i, t in pairs (self.assignment_cd) do
					if t.show_time <= passed and t.hide_time > passed then	
						if not Timeline.ActiveLines[i] then
							local exp_time = self.start + t.row_time + SoD_CDB["General"]["tl_dur"] - self.t_offset
							Timeline.CreateLine(i, t.cd_str, exp_time, t.row_time)
						end
					end
					if SoD_CDB["General"]["tl_show_bar"] then
						if t.row_time - 10 <= passed and t.row_time > passed then
							if not Timeline.ActiveBars[i] then
								if SoD_CDB["General"]["tl_only_my_bar"] then
									for _, name in pairs(Timeline.MyNames) do
										if strfind(t.cd_str, name) then
											local exp_time = self.start + t.row_time - self.t_offset
											Timeline.CreateBar(i, t.cd_str, exp_time, t.row_time)
											break
										end
									end
								else
									local exp_time = self.start + t.row_time - self.t_offset
									Timeline.CreateBar(i, t.cd_str, exp_time, t.row_time)
								end
							end
						end
					end
				end
			end
        end
	elseif event == "ADDON_LOADED" then
		local addon = ...
		if addon == G.addon_name then
			for index, data in pairs(G.Encounters) do
				if data["alerts"]["Phase_Change"] then
					Timeline.PhaseTable[data.engage_id] = {}
					
					for i, args in pairs(data["alerts"]["Phase_Change"]) do
						if not args.empty then
							Timeline.PhaseTable[data.engage_id]["phase"..i] = {sub_event = args.sub_event, spellID = args.spellID}
						end
					end
				end
				if data.engage_id then
					Timeline.Encounter_Tags[data.engage_id] = G.raid_short..index
				end
			end
			self:UnregisterEvent("ADDON_LOADED")
		end
    end
end)

----------------------------------------------------------
------------[[    Defense spell icons    ]]---------------
----------------------------------------------------------
local DSFrame = CreateFrame("Frame", addon_name.."DSFrame", FrameHolder)
DSFrame:SetSize(400,70)

DSFrame.movingname = L["保命技能"]
DSFrame.point = { a1 = "BOTTOM", parent = "UIParent", a2 = "CENTER", x = 0, y = 100 }
T.CreateDragFrame(DSFrame)

DSFrame.text = T.createtext(DSFrame, "OVERLAY", 35, "OUTLINE", "LEFT")
DSFrame.text:SetPoint("TOP", DSFrame, "TOP", 0, 0)

DSFrame.anim = DSFrame:CreateAnimationGroup()
DSFrame.anim:SetLooping("BOUNCE")
DSFrame.timer = DSFrame.anim:CreateAnimation()
DSFrame.timer.t = 0
DSFrame.timer:SetDuration(.5)
DSFrame.anim:Play()

DSFrame.ActiveIcons = {}
DSFrame.WatchSpells = {}

T.EditDSFrame = function(option)
	if option == "all" or option == "enable" then
		if SoD_CDB["General"]["ds"] then
			DSFrame:RegisterEvent("UNIT_HEALTH")
			DSFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
			DSFrame:RegisterEvent("ENCOUNTER_END")
			if SoD_CDB["General"]["ds_test"] then				
				local perc = UnitHealth("player")/UnitHealthMax("player")
				if SoD_CDB["General"]["ds_color_gradiant"] then
					DSFrame.text:SetTextColor(1, perc, 0)
				else
					DSFrame.text:SetTextColor(1, 0, 0)
				end
				if SoD_CDB["General"]["ds_show_hp"] then
					DSFrame.text:SetText(string.format(L["注意自保血量"], perc*100))
				else
					DSFrame.text:SetText(L["注意自保"])
				end		
				for k, frame in pairs(DSFrame.ActiveIcons) do
					frame.update()
				end
				
				DSFrame:Show()
			else
				DSFrame:Hide()
			end
		else
			DSFrame:UnregisterEvent("UNIT_HEALTH")
			DSFrame:Hide()
		end
	end
	
	for k, frame in pairs(DSFrame.ActiveIcons) do
		frame.update_onedit(option)
	end
	
	if option == "all" or option == "icon_size" then
		DSFrame:SetSize(400, SoD_CDB["General"]["ds_icon_size"]+SoD_CDB["General"]["ds_font_size"]+5)
		DSFrame.LineUpIcons()
	end
	
	if option == "all" or option == "font_size" then
		DSFrame:SetSize(400, SoD_CDB["General"]["ds_icon_size"]+SoD_CDB["General"]["ds_font_size"]+5)
		DSFrame.text:SetFont(G.Font, SoD_CDB["General"]["ds_font_size"], "OUTLINE")
	end
	
	if option == "all" or option == "color_gradiant" then
		if SoD_CDB["General"]["ds_color_gradiant"] then
			local perc = UnitHealth("player")/UnitHealthMax("player")
			DSFrame.text:SetTextColor(1, perc, 0)
		else
			DSFrame.text:SetTextColor(1, 0, 0)
		end
	end
	
	if option == "all" or option == "show_hp" then
		if SoD_CDB["General"]["ds_show_hp"] then
			local perc = UnitHealth("player")/UnitHealthMax("player")
			DSFrame.text:SetText(string.format(L["注意自保血量"], perc*100))
		else
			DSFrame.text:SetText(L["注意自保"])
		end
	end
end

DSFrame.LineUpIcons = function()
	local t = {}
	for tag, icon in pairs(DSFrame.ActiveIcons) do
		if icon and icon:IsVisible() then
			table.insert(t, icon)
		end
	end
	if #t > 1 then
		table.sort(t, function(a, b) return a.ind > b.ind end)
	end
	local lasticon
	for i, icon in pairs(t) do
		icon:ClearAllPoints()
		if icon:IsVisible() then
			if not lasticon then
				icon:SetPoint("BOTTOMLEFT", DSFrame, "BOTTOM", -((SoD_CDB["General"]["ds_icon_size"]+10)*#t-10)/2,0)
			else
				icon:SetPoint("LEFT", lasticon, "RIGHT", 10, 0)	
			end
			lasticon = icon
		end
	end
end

local function MySpellCheck(spellID)
	if not IsSpellKnown(spellID) and not IsSpellKnown(FindBaseSpellByID(spellID)) then			
		return 
	end
	local hascharges = GetSpellCharges(spellID)
	if hascharges then
		local charges = GetSpellCharges(spellID)
		if charges > 0 then
			return true
		end
	else
		local start, duration = GetSpellCooldown(spellID)
		if start and duration < 2 then
			return true
		end
	end
end

local function MyItemCheck(itemID)
	local itemType = select(6, GetItemInfoInstant(itemID))
	if itemType == 2 or itemType == 4 then -- 武器或护甲
		if IsEquippedItem(itemID) then
			local start, duration, enable = GetItemCooldown(itemID)
			if enable == 1 and start and duration < 2 then
				return true
			end
		end
	elseif itemType == 0 then -- 消耗品
		if GetItemCount(itemID) > 0 then
			local start, duration, enable = GetItemCooldown(itemID)
			if enable == 1 and start and duration < 2 then
				return true
			end
		end
	end
end

DSFrame.CreateIcon = function(cd_type, arg1, ind)
	local frame = CreateFrame("Frame", nil, DSFrame)
	frame:SetSize(35, 35)
	T.createborder(frame)
	
	frame.cd_type = cd_type
	frame.ind = ind
	
	if cd_type == "spell" then
		frame.spell_id = arg1
		frame.spell, _, frame.icon_tex = GetSpellInfo(arg1)
		frame.aura = GetSpellInfo(arg1)
	elseif cd_type == "item" then
		frame.item_id = arg1
		frame.item,  _, _, _, frame.icon_tex = GetItemInfoInstant(arg1)
	end
	
	frame.cooldown = CreateFrame("Cooldown", nil, frame, "CooldownFrameTemplate")
	frame.cooldown:SetAllPoints()
	frame.cooldown:SetDrawEdge(false)
	frame.cooldown:SetFrameLevel(frame:GetFrameLevel())
	frame.cooldown:SetHideCountdownNumbers(true)
	
	frame.glow = frame:CreateTexture(nil, "OVERLAY")
	frame.glow:SetPoint("TOPLEFT", -15, 15)
	frame.glow:SetPoint("BOTTOMRIGHT", 15, -15)
	frame.glow:SetTexture([[Interface\SpellActivationOverlay\IconAlert]])
	frame.glow:SetTexCoord(0.00781250, 0.50781250, 0.27734375, 0.52734375)
	frame.glow:Hide()
	
	frame.texture = frame:CreateTexture(nil, "BORDER", nil, 1)
	frame.texture:SetTexCoord( .1, .9, .1, .9)
	frame.texture:SetAllPoints()
	frame.texture:SetTexture(frame.icon_tex)
	
	frame.update_onedit = function(option)	
		if option == "all" or option == "enable" then
			if SoD_CDB["General"]["ds"] then				
				if cd_type == "spell" then
					frame:RegisterEvent("UNIT_AURA")
					frame:RegisterEvent("SPELL_UPDATE_COOLDOWN")
				elseif cd_type == "item" then
					frame:RegisterEvent("BAG_UPDATE_COOLDOWN")
				end
			else
				frame:UnregisterAllEvents()
			end
		end
		
		if option == "all" or option == "icon_size" then
			frame:SetSize(SoD_CDB["General"]["ds_icon_size"], SoD_CDB["General"]["ds_icon_size"])
		end
	end
	
	frame.update = function()
		if cd_type == "spell" then
			if AuraUtil.FindAuraByName(frame.aura, "player", "HELPFUL") then
				if not frame.glow:IsVisible() then
					local dur, exp_time = select(5, AuraUtil.FindAuraByName(frame.aura, "player", "HELPFUL"))
					if dur then
						local start = exp_time - dur
						frame.cooldown:SetCooldown(start, dur)
					end
					frame.glow:Show()
				end
				frame:Show()
			else
				if frame.glow:IsVisible() then
					frame.cooldown:SetCooldown(0, 0)
					frame.glow:Hide()
				end
				if MySpellCheck(frame.spell_id) then
					frame:Show()	
				else
					frame:Hide()
				end
			end
		elseif cd_type == "item" then
			if MyItemCheck(frame.item_id) then
				frame:Show()
			else
				frame:Hide()
			end
		end
	end
	
	frame:SetScript("OnEvent", function(self, event, arg1)
		if event == "UNIT_AURA" and arg1 == "player" then
			self.update()
		elseif event == "SPELL_UPDATE_COOLDOWN" then
			self.update()
		elseif event == "BAG_UPDATE_COOLDOWN" then
			self.update()
		end
	end)
	
	local tag = cd_type..arg1
	
	DSFrame.ActiveIcons[tag] = frame
	DSFrame.LineUpIcons()
	
	frame:HookScript("OnShow", function()	
		DSFrame.LineUpIcons()
	end)
	
	frame:HookScript("OnHide", function()
		DSFrame.LineUpIcons()
	end)	
end

local Defense_spell_class = {
	PRIEST = { 
        [19236]   = 1, -- 绝望祷言
		[33206]   = 2, -- 痛苦压制
		[47788]   = 3, -- 守护之魂
		[47585]   = 4, -- 消散
	},
	DRUID = {
		[22812]   = 1, -- 树皮术
	    [102342]  = 2, -- 铁木树皮
		[61336]   = 3, -- 生存本能
		[22842]   = 4, -- 狂暴回复
	},
	SHAMAN = { 
		[108271]  = 1, -- 星界转移
	},
	PALADIN = {
        [498]     = 1, -- 圣佑术
		[642]     = 2, -- 圣盾术
	},
	WARRIOR = { 
		[12975]   = 1, -- 破釜沉舟
		[871]     = 2, -- 盾墙
		[184364]  = 3, -- 狂怒回复
		[118038]  = 4, -- 剑在人在
	},
	MAGE = { 
		[45438]   = 1, -- 寒冰屏障
	},
	WARLOCK = { 
		[104773]  = 1, -- 不灭决心
	},
	HUNTER = { 
		[186265]  = 1, -- 灵龟守护
	},
	ROGUE = { 
		[31224]  = 1, -- 暗影斗篷
		[1966]   = 2, -- 佯攻
	},
	DEATHKNIGHT = {
		[48707]  = 1, -- 反魔法护罩
		[48792]  = 2, -- 冰封之韧
	},
	MONK = {
		[116849]  = 1, -- 作茧缚命
		[115203]  = 2, -- 壮胆酒
		[122470]  = 3, -- 业报之触
		[122783]  = 4, -- 散魔功
	},
	DEMONHUNTER = {
		[196555]  = 1, -- 虚空行走 浩劫
		[187827]  = 2, -- 恶魔变形
		[212084]  = 3, -- 邪能毁灭
		[204021]  = 4, -- 烈火烙印
		[203720]  = 5, -- 恶魔尖刺
	},
}

local Defense_spell_common = {
	[324867] = 10, -- 血肉铸造
}

local Defense_item_common = {
	[177278] = 20, -- 静谧之瓶
	[171267] = 21, -- 灵魂治疗药水
	[5512] = 22, -- 治疗石
}

local MyDS = {
	spell = {},
	item = {},
}

for k, v in pairs(Defense_spell_class[G.myClass]) do
	MyDS["spell"][k] = v
end
for k, v in pairs(Defense_spell_common) do
	MyDS["spell"][k] = v
end
for k, v in pairs(Defense_item_common) do
	MyDS["item"][k] = v
end

DSFrame.t = 0
DSFrame:SetScript("OnUpdate", function(self, e)
	self.t = self.t + e
	if self.t > update_rate then
		if SoD_CDB["General"]["ds_test"] then
			self.text:SetAlpha(DSFrame.timer:GetProgress())
		else		
			local remain = self.exp - GetTime()
			if remain > 0 then
				self.text:SetAlpha(DSFrame.timer:GetProgress())
			else
				DSFrame:Hide()
			end
		end
		self.t = 0
	end
end)

DSFrame:RegisterEvent("ADDON_LOADED")
DSFrame:SetScript("OnEvent", function(self, event, arg1)
	if event == "UNIT_HEALTH" and arg1 == "player" then
		local perc = UnitHealth("player")/UnitHealthMax("player")
		if SoD_CDB["General"]["ds_color_gradiant"] then
			DSFrame.text:SetTextColor(1, perc, 0)
		end
		if SoD_CDB["General"]["ds_show_hp"] then
			DSFrame.text:SetText(string.format(L["注意自保血量"], perc*100))
		end
	elseif event == "ADDON_LOADED" and arg1 == G.addon_name then
		for tag, t in pairs(MyDS) do
			for k, v in pairs(t) do
				if k and v then
					DSFrame.CreateIcon(tag, k, v)
				end
			end
		end
		for index, data in pairs(G.Encounters) do
			if data["alerts"]["HP_Watch"] then
				for i, args in pairs(data["alerts"]["HP_Watch"]) do
					if not DSFrame.WatchSpells[args.sub_event] then
						DSFrame.WatchSpells[args.sub_event] = {}
					end
					DSFrame.WatchSpells[args.sub_event][args.spellID] = {delay = args.delay, dur = args.dur or 3, on_me = args.on_me}
				end
			end
		end
		DSFrame:UnregisterEvent("ADDON_LOADED")
	elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
		if SoD_CDB["General"]["ds_test"] then return end
		local Time_stamp, Event_type, _, SourceGUID, SourceName, _, _, DestGUID, DestName, _, _, SpellID, SpellName = CombatLogGetCurrentEventInfo()
		if DSFrame.WatchSpells[Event_type] and DSFrame.WatchSpells[Event_type][SpellID] then
			local on_me = DSFrame.WatchSpells[Event_type][SpellID]["on_me"]
			local delay = DSFrame.WatchSpells[Event_type][SpellID]["delay"]
			local dest = DestName and string.split("-", DestName) or ""
			if not on_me or dest == G.PlayerName then
				if delay then
					C_Timer.After(delay, function()
						for k, frame in pairs(DSFrame.ActiveIcons) do
							frame.update()
						end
						DSFrame:Show()
						DSFrame.exp = GetTime() + DSFrame.WatchSpells[Event_type][SpellID]["dur"]
					end)
				else
					for k, frame in pairs(DSFrame.ActiveIcons) do
						frame.update()
					end
					DSFrame:Show()
					DSFrame.exp = GetTime() + DSFrame.WatchSpells[Event_type][SpellID]["dur"]
				end
			end
		end
	elseif event == "ENCOUNTER_END" then
		DSFrame:Hide()
    end
end)
----------------------------------------------------------
-----------------[[    Alert Frame    ]]------------------
----------------------------------------------------------
local AlertFrame = CreateFrame("Frame", addon_name.."AlertFrame", FrameHolder)
AlertFrame:SetSize(70,70)

AlertFrame.movingname = L["图标提示"]
AlertFrame.point = { a1 = "BOTTOMLEFT", parent = "UIParent", a2 = "CENTER", x = -400, y = -20 }
T.CreateDragFrame(AlertFrame)

T.EditAlertFrame = function(option)
	if option == "all" or option == "icon_size" then
		AlertFrame:SetSize(SoD_CDB["AlertFrame"]["icon_size"], SoD_CDB["AlertFrame"]["icon_size"])
	end
	for k, frame in pairs(G.Icons) do
		frame.update_onedit(option)
	end
end

AlertFrame.ActiveIcons = {}
AlertFrame.LineUpIcons = function()
	local lastframe
	local grow_dir = SoD_CDB["AlertFrame"]["grow_dir"]
	local space = SoD_CDB["AlertFrame"]["icon_space"]
	for v, frame in T.pairsByKeys(AlertFrame.ActiveIcons) do
		frame:ClearAllPoints()
		frame.text:ClearAllPoints()
		frame.text2:ClearAllPoints()
		
		if grow_dir == "TOP" or grow_dir == "BOTTOM" then
			frame.text:SetPoint("TOPLEFT", frame, "TOPRIGHT", 10, -5)
			frame.text:SetJustifyH("LEFT")
			
			frame.text2:SetPoint("TOPLEFT", frame, "RIGHT", 10, -5)
			frame.text2:SetJustifyH("LEFT")
		else
			frame.text:SetPoint("TOP", frame, "BOTTOM", 0, -5)
			frame.text:SetJustifyH("CENTER")
			
			frame.text2:SetPoint("BOTTOM", frame, "TOP", 0, 5)
			frame.text2:SetJustifyH("CENTER")
		end
		
		if not lastframe then
			frame:SetPoint(grow_dir, AlertFrame, grow_dir)
		elseif grow_dir == "BOTTOM" then
			frame:SetPoint(grow_dir, lastframe, "TOP", 0, space)
		elseif grow_dir == "TOP" then
			frame:SetPoint(grow_dir, lastframe, "BOTTOM", 0, -space)
		elseif grow_dir == "LEFT" then
			frame:SetPoint(grow_dir, lastframe, "RIGHT", space, 0)
		elseif grow_dir == "RIGHT" then
			frame:SetPoint(grow_dir, lastframe, "LEFT", -space, 0)	
		end
		lastframe = frame
	end
end

AlertFrame.QueueIcon = function(frame)
	frame:HookScript("OnShow", function()
		AlertFrame.ActiveIcons[frame.v] = frame
		AlertFrame.LineUpIcons()
	end)
	
	frame:HookScript("OnHide", function()
		AlertFrame.ActiveIcons[frame.v] = nil
		AlertFrame.LineUpIcons()
	end)
end

T.CreateAlertIcon = function(v, hl, index, tip, r, g, b, role)
	local frame = CreateFrame("Frame", nil, AlertFrame)
	frame:SetSize(70,70)
	frame:Hide()
	T.createborder(frame)
	
	frame.boss_index = index
	frame.hl = hl
	
	frame.spell_id = select(2, strsplit("_", v))
	frame.spell_id = tonumber(frame.spell_id)
	
	if frame.boss_index ~= "test" then 
		if type(frame.boss_index) == "string" then
			frame.mapID = G.Encounters[frame.boss_index]["map_id"]
		else
			frame.boss_index = tonumber(frame.boss_index)
			frame.npcID = G.Encounters[frame.boss_index]["npc_id"]
			frame.engageID = G.Encounters[frame.boss_index]["engage_id"]
		end
	end
	
	frame.spell_name, _, frame.spell_icon, frame.cast_time = GetSpellInfo(frame.spell_id)
	frame.v = v
	frame.t = 0

	frame.cooldown = CreateFrame("Cooldown", nil, frame, "CooldownFrameTemplate")
	frame.cooldown:SetAllPoints()
	frame.cooldown:SetDrawEdge(false)
	frame.cooldown:SetFrameLevel(frame:GetFrameLevel())
	frame.cooldown:SetHideCountdownNumbers(true)
	
	frame.glow = frame:CreateTexture(nil, "OVERLAY")
	frame.glow:SetPoint("TOPLEFT", -25, 25)
	frame.glow:SetPoint("BOTTOMRIGHT", 25, -25)
	frame.glow:SetAlpha(1)
	frame.glow:SetTexture([[Interface\SpellActivationOverlay\IconAlert]])
	frame.glow:SetTexCoord(0.00781250, 0.50781250, 0.27734375, 0.52734375)
	
	if frame.hl == "hl" then
		frame.glow:Show()
	else
		frame.glow:Hide()
	end
	
	frame.texture = frame:CreateTexture(nil, "BORDER", nil, 1)
	frame.texture:SetTexCoord( .1, .9, .1, .9)
	frame.texture:SetAllPoints()
	frame.texture:SetTexture(frame.spell_icon)
	
	frame.role_btn = CreateFrame("Frame", nil, frame)
	frame.role_btn:SetFrameLevel(frame:GetFrameLevel()+2)
	frame.role_btn:SetSize(17, 17)
	frame.role_btn:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 2, 2)
	T.createborder(frame.role_btn)
		
	frame.role_text = T.createtext(frame.role_btn, "HIGH", 10, "OUTLINE", "CENTER")
	frame.role_text:SetPoint("CENTER")

	if role == "tank" then
		frame.role_text:SetText(L["TANK_ICON"])
		frame.role_btn.sd:SetBackdropColor(1, .8, .5)
		frame.role_btn.sd:SetBackdropBorderColor(.5, .4, .25)
	elseif role == "dps" then
		frame.role_text:SetText(L["DAMAGE_ICON"])
		frame.role_btn.sd:SetBackdropColor(.5, .4, 1)
		frame.role_btn.sd:SetBackdropBorderColor(.25, .2, .5)
	elseif role == "healer" then
		frame.role_text:SetText(L["HEALER_ICON"])
		frame.role_btn.sd:SetBackdropColor(.5, 1, 0)
		frame.role_btn.sd:SetBackdropBorderColor(.25, .5, 0)
	else
		frame.role_btn:Hide()
	end
	
	frame.bottomtext = T.createtext(frame, "OVERLAY", 12, "OUTLINE", "CENTER") -- 技能名字
	frame.bottomtext:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", -5, 0)
	frame.bottomtext:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 5, 0)
	frame.bottomtext:SetHeight(12)	
	frame.bottomtext:SetTextColor(1, 1, 0)
	frame.bottomtext:SetText(frame.spell_name)
	
	frame.toptext = T.createtext(frame, "OVERLAY", 25, "OUTLINE", "CENTER") -- 层数
	frame.toptext:SetPoint("TOPLEFT", frame, "TOPLEFT", -2, -10)
	frame.toptext:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 2, -10)
	frame.toptext:SetHeight(25)
	frame.toptext:SetTextColor(0, 1, 1)
	
	frame.text = T.createtext(frame, "OVERLAY", 20, "OUTLINE", "LEFT") -- 时间
	frame.text:SetTextColor(r, g, b)
		
	frame.text2 = T.createtext(frame, "OVERLAY", 20, "OUTLINE", "CENTER") -- 应对tip
	frame.text2:SetTextColor(0, 1, .5)
	frame.text2:SetText(tip)
	
	return frame
end

T.CreateTestIcon = function(v, hl, dur, r, g, b)

	local frame = T.CreateAlertIcon(v, hl, "test", nil, r, g, b)

	frame.reset = function()
		frame:Hide()
		frame.exp = false
	end
	
	frame.update_onedit = function()
		frame.enable = SoD_CDB["AlertFrame"]["enable"]
		if frame.enable then
			frame:RegisterEvent("CHAT_MSG_ADDON")
		else
			frame:UnregisterEvent("CHAT_MSG_ADDON")
		end		
		
		frame:SetSize(SoD_CDB["AlertFrame"]["icon_size"], SoD_CDB["AlertFrame"]["icon_size"])
		frame.glow:SetPoint("TOPLEFT", -SoD_CDB["AlertFrame"]["icon_size"]/3, SoD_CDB["AlertFrame"]["icon_size"]/3)
		frame.glow:SetPoint("BOTTOMRIGHT", SoD_CDB["AlertFrame"]["icon_size"]/3, -SoD_CDB["AlertFrame"]["icon_size"]/3)					
		
		frame.text:SetFont(G.Font, SoD_CDB["AlertFrame"]["font_size"], "OUTLINE")
		frame.text2:SetFont(G.Font, SoD_CDB["AlertFrame"]["font_size"], "OUTLINE")
		frame.bottomtext:SetFont(G.Font, SoD_CDB["AlertFrame"]["ifont_size"], "OUTLINE")
		
		if SoD_CDB["AlertFrame"]["show_spellname"] then
			frame.bottomtext:Show()
		else
			frame.bottomtext:Hide()
		end
		
		if SoD_CDB["AlertFrame"]["reverse_cooldown"] then
			frame.cooldown:SetReverse(true)
		else
			frame.cooldown:SetReverse(false)	
		end
		
		AlertFrame.LineUpIcons()
	end
	
	frame.update_onevent = function()
		if frame.enable then
			frame.exp = GetTime() + dur
			frame:Show()	
		else
			frame.reset()
		end
	end
	
	frame.update_onframe = function()
		if frame.enable and frame.exp then	
			local remain = frame.exp - GetTime()
			frame.text:SetText(T.FormatTime(remain))
			if remain <= 0 then
				frame.reset()
			end
		else
			frame.reset()
		end
	end
	
	frame.StartTest = function()
		frame.update_onevent()
	end
	
	frame:SetScript("OnUpdate", function(self, e)
		frame.t = frame.t + e
		if frame.t > update_rate then	
			frame.update_onframe()
			frame.t = 0
		end
	end)
	
	AlertFrame.QueueIcon(frame)	
	
	G.Icons[v] = frame
	G.Test[v] = frame
end

T.CreateAura = function(option_page, difficulty_id, index, v, hl, role, tip, aura_type, unit, arg_index)
	local frame = T.CreateAlertIcon(v, hl, index, tip, 1, 1, 1, role)
	
	frame.reset = function()
		frame:Hide()
		frame.count = false
		frame.dur = false
		frame.exp = false
		frame.cooldown:SetCooldown(0, 0)
	end
	
	frame.update_onedit = function(option)
		if option == "all" or option == "enable" then
		
			frame.enable = SoD_CDB["Icons"][v] and SoD_CDB["AlertFrame"]["enable"]
			if frame.enable then
				if type(frame.boss_index) == "string" then
					frame:RegisterEvent("PLAYER_ENTERING_WORLD")
				else
					frame:RegisterEvent("ENCOUNTER_START")
					frame:RegisterEvent("ENCOUNTER_END")
				end
			else
				if type(frame.boss_index) == "string" then
					frame:UnregisterEvent("PLAYER_ENTERING_WORLD")
				else
					frame:UnregisterEvent("ENCOUNTER_START")
					frame:UnregisterEvent("ENCOUNTER_END")
				end
			end
			
			frame.update_onevent("INIT")
		end
		
		if option == "all" or option == "icon_size" then
			frame:SetSize(SoD_CDB["AlertFrame"]["icon_size"], SoD_CDB["AlertFrame"]["icon_size"])
			frame.glow:SetPoint("TOPLEFT", -SoD_CDB["AlertFrame"]["icon_size"]/3, SoD_CDB["AlertFrame"]["icon_size"]/3)
			frame.glow:SetPoint("BOTTOMRIGHT", SoD_CDB["AlertFrame"]["icon_size"]/3, -SoD_CDB["AlertFrame"]["icon_size"]/3)
		end
		
		if option == "all" or option == "font_size" then
			frame.text:SetFont(G.Font, SoD_CDB["AlertFrame"]["font_size"], "OUTLINE")
			frame.text2:SetFont(G.Font, SoD_CDB["AlertFrame"]["font_size"], "OUTLINE")
		end
		
		if option == "all" or option == "ifont_size" then
			frame.bottomtext:SetFont(G.Font, SoD_CDB["AlertFrame"]["ifont_size"], "OUTLINE")
		end
		
		if option == "all" or option == "grow_dir" or option == "icon_space" then
			AlertFrame.LineUpIcons()
		end
		
		if option == "all" or option == "spelltext" then
			if SoD_CDB["AlertFrame"]["show_spellname"] then
				frame.bottomtext:Show()
			else
				frame.bottomtext:Hide()
			end
		end
		
		if option == "all" or option == "cdreverse" then
			if SoD_CDB["AlertFrame"]["reverse_cooldown"] then
				frame.cooldown:SetReverse(true)
			else
				frame.cooldown:SetReverse(false)
			end
		end
	end
	
	frame.Update_data = function()	
		if frame.enable and AuraUtil.FindAuraByName(frame.spell_name, unit, aura_type) then
			frame.count, _, frame.dur, frame.exp = select(3, AuraUtil.FindAuraByName(frame.spell_name, unit, aura_type))
			if arg_index then -- 取某一数值
				frame.aoumnt = select(arg_index, AuraUtil.FindAuraByName(frame.spell_name, unit, aura_type))
			end
			frame:Show()
			if frame.dur and frame.exp then
				frame.cooldown:SetCooldown(frame.exp-frame.dur, frame.dur)
			end
		else
			frame.reset()
		end
	end
	
	frame.Update_layout = function()
		if frame.enable and frame.exp and (frame.exp == 0 or frame.exp > GetTime()) then
			if frame.exp > 0 and frame.exp <= GetTime() then
				frame.reset()
			end
			
			local count, amount, remain
			
			if frame.count and frame.count > 0 then
				count = "|cffFFA500["..frame.count.."]|r"
			else
				count = ""
			end
			
			if frame.amount then
				amount = "|cff00BFFF["..T.ShortValue(frame.amount).."]|r"
			else
				amount = ""
			end
			
			if frame.exp and frame.dur ~= 0 then -- 有持续时间
				remain = T.FormatTime(frame.exp - GetTime())
			else
				remain = "∞"
			end	
			
			frame.text:SetText(count..remain..amount)
		else
			frame.reset()
		end
	end
	
	frame.encounter_check = function(event, ...)
		if event == "INIT" then
			if type(frame.boss_index) == "string" then
				local map = select(8, GetInstanceInfo())
				if frame.enable and map == frame.mapID then
					frame:RegisterEvent("UNIT_AURA")
				else
					frame:UnregisterEvent("UNIT_AURA")
					frame.reset()
				end
			else
				local guid = UnitGUID("boss1")
				if guid then
					local NPC_ID = select(6, strsplit("-", UnitGUID("boss1")))
					local difficultyID = select(3, GetInstanceInfo())
					if frame.enable and NPC_ID == frame.npcID and (difficulty_id["all"] or difficulty_id[difficultyID]) then
						frame:RegisterEvent("UNIT_AURA")
					end
				end
			end
		elseif event == "ENCOUNTER_START" then
			local encounterID, encounterName, difficultyID, groupSize = ...
			if frame.enable and encounterID == frame.engageID and (difficulty_id["all"] or difficulty_id[difficultyID]) then
				frame:RegisterEvent("UNIT_AURA")
			end
		elseif event == "ENCOUNTER_END" then
			local encounterID, encounterName, difficultyID, groupSize = ...
			if encounterID == frame.engageID then
				frame:UnregisterEvent("UNIT_AURA")
				frame.reset()
			end
		elseif event == "PLAYER_ENTERING_WORLD" then
			local map = select(8, GetInstanceInfo())
			if frame.enable and map == frame.mapID then
				frame:RegisterEvent("UNIT_AURA")
			else
				frame:UnregisterEvent("UNIT_AURA")
				frame.reset()
			end
		end
	end
	
	frame.update_onevent = function(event, ...)
		if event == "INIT" then
			frame.encounter_check(event, ...)
			frame.Update_data()
			frame.Update_layout()
		elseif event == "ENCOUNTER_START" or event == "ENCOUNTER_END" or event == "PLAYER_ENTERING_WORLD" then
			frame.encounter_check(event, ...)
		elseif event == "UNIT_AURA" then
			local u = ...
			if u == unit then
				frame.Update_data()
				frame.Update_layout()
			end
		end
	end

	frame:SetScript("OnEvent", function(self, event, ...)	
		frame.update_onevent(event, ...)	
	end)
	
	frame:SetScript("OnUpdate", function(self, e)
		frame.t = frame.t + e
		if frame.t > update_rate then	
			frame.Update_layout()
			frame.t = 0
		end
	end)
	
	AlertFrame.QueueIcon(frame)	
	
	G.Icons[v] = frame
	
	T.Create_AlertIcon_Options(option_page, difficulty_id, v, nil, role, tip)
	
end

T.CreateLog = function(option_page, difficulty_id, index, v, hl, role, tip, event_type, targetID, dur)
	local frame = T.CreateAlertIcon(v, hl, index, tip, 1, 1, 1, role)
	
	frame.dur = dur
	
	frame.reset = function()
		frame:Hide()
		frame.exp = false
		frame.target = false
		frame.cooldown:SetCooldown(0, 0)
	end
	
	frame.update_onedit = function(option)
		if option == "all" or option == "enable" then
		
			frame.enable = SoD_CDB["Icons"][v] and SoD_CDB["AlertFrame"]["enable"]
			if frame.enable then
				if type(frame.boss_index) == "string" then
					frame:RegisterEvent("PLAYER_ENTERING_WORLD")
				else
					frame:RegisterEvent("ENCOUNTER_START")
					frame:RegisterEvent("ENCOUNTER_END")
				end
			else
				if type(frame.boss_index) == "string" then
					frame:UnregisterEvent("PLAYER_ENTERING_WORLD")
				else
					frame:UnregisterEvent("ENCOUNTER_START")
					frame:UnregisterEvent("ENCOUNTER_END")
				end
			end	
			
			frame.update_onevent("INIT")
		end
		
		if option == "all" or option == "icon_size" then
			frame:SetSize(SoD_CDB["AlertFrame"]["icon_size"], SoD_CDB["AlertFrame"]["icon_size"])
			frame.glow:SetPoint("TOPLEFT", -SoD_CDB["AlertFrame"]["icon_size"]/3, SoD_CDB["AlertFrame"]["icon_size"]/3)
			frame.glow:SetPoint("BOTTOMRIGHT", SoD_CDB["AlertFrame"]["icon_size"]/3, -SoD_CDB["AlertFrame"]["icon_size"]/3)
		end
		
		if option == "all" or option == "font_size" then
			frame.text:SetFont(G.Font, SoD_CDB["AlertFrame"]["font_size"], "OUTLINE")
			frame.text2:SetFont(G.Font, SoD_CDB["AlertFrame"]["font_size"], "OUTLINE")
		end
		
		if option == "all" or option == "ifont_size" then
			frame.bottomtext:SetFont(G.Font, SoD_CDB["AlertFrame"]["ifont_size"], "OUTLINE")
		end
		
		if option == "all" or option == "grow_dir" or option == "icon_space" then
			AlertFrame.LineUpIcons()
		end
		
		if option == "all" or option == "spelltext" then
			if SoD_CDB["AlertFrame"]["show_spellname"] then
				frame.bottomtext:Show()
			else
				frame.bottomtext:Hide()
			end
		end
		
		if option == "all" or option == "cdreverse" then
			if SoD_CDB["AlertFrame"]["reverse_cooldown"] then
				frame.cooldown:SetReverse(true)
			else
				frame.cooldown:SetReverse(false)
			end
		end
	end
	
	frame.encounter_check = function(event, ...)
		if event == "INIT" then
			if type(frame.boss_index) == "string" then
				local map = select(8, GetInstanceInfo())
				if frame.enable and map == frame.mapID then
					frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
				else
					frame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
					frame.reset()
				end
			else
				local guid = UnitGUID("boss1")
				if guid then
					local NPC_ID = select(6, strsplit("-", UnitGUID("boss1")))
					local difficultyID = select(3, GetInstanceInfo())
					if frame.enable and NPC_ID == frame.npcID and (difficulty_id["all"] or difficulty_id[difficultyID]) then
						frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
					end
				end
			end
		elseif event == "ENCOUNTER_START" then
			local encounterID, encounterName, difficultyID, groupSize = ...
			if frame.enable and encounterID == frame.engageID and (difficulty_id["all"] or difficulty_id[difficultyID]) then
				frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
			end
		elseif event == "ENCOUNTER_END" then
			local encounterID, encounterName, difficultyID, groupSize = ...
			if encounterID == frame.engageID then
				frame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
				frame.reset()
			end
		elseif event == "PLAYER_ENTERING_WORLD" then
			local map = select(8, GetInstanceInfo())
			if frame.enable and map == frame.mapID then
				frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
			else
				frame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
				frame.reset()
			end
		end
	end
	
	frame.update_onevent = function(event, ...)
		if event == "INIT" or event == "ENCOUNTER_START" or event == "ENCOUNTER_END" or event == "PLAYER_ENTERING_WORLD" then
			frame.encounter_check(event, ...)
		elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
			if frame.enable then
				local Time_stamp, Event_type, _, SourceGUID, SourceName, _, _, DestGUID, DestName, _, _, SpellID, SpellName = CombatLogGetCurrentEventInfo()
				if Event_type == event_type and SpellID == frame.spell_id then
					if not targetID then
						frame.exp = GetTime() + frame.dur
						frame:Show()
						frame.cooldown:SetCooldown(GetTime(), frame.dur)			
					elseif UnitIsUnit(targetID, DestName) then -- 这里targetID只用于玩家
						frame.target = DestName
						frame.exp = GetTime() + frame.dur
						frame:Show()
						frame.cooldown:SetCooldown(GetTime(), frame.dur)
					end
				end
			else
				frame.reset()
			end
		end
	end
	
	frame.update_onframe = function()
		if frame.enable and frame.exp then		
			local remain = frame.exp - GetTime()
			frame.text:SetText(T.FormatTime(remain))

			if remain <= 0 then
				frame.reset()
			end
		else
			frame.reset()
		end
	end
	
	frame:SetScript("OnEvent", function(self, event, ...)
		frame.update_onevent(event, ...)
	end)
	
	frame:SetScript("OnUpdate", function(self, e)
		frame.t = frame.t + e
		if frame.t > update_rate then	
			frame.update_onframe()
			frame.t = 0
		end
	end)
	
	AlertFrame.QueueIcon(frame)	
	
	G.Icons[v] = frame
	
	T.Create_AlertIcon_Options(option_page, difficulty_id, v, nil, role, tip)
	
end

local CastingEvents = {
	["UNIT_SPELLCAST_START"] = true,
	["UNIT_SPELLCAST_SUCCEEDED"] = true,
	["UNIT_SPELLCAST_STOP"] = true,
	["UNIT_SPELLCAST_CHANNEL_START"] = true,
	["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
	["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
}

local UpdateCastFrame = function(frame, unit, GUID, cast_type)
	local startTimeMS, endTimeMS
	
	if cast_type == "CHANNEL" then
		startTimeMS, endTimeMS = select(4, UnitChannelInfo(unit))
	elseif cast_type == "CAST" then
		startTimeMS, endTimeMS = select(4, UnitCastingInfo(unit))
	elseif cast_type == "INSTANT" then
		if UnitChannelInfo(unit) or UnitCastingInfo(unit) then
			return 
		end
		startTimeMS, endTimeMS = GetTime()*1000, (GetTime()+2)*1000
	end
	
	if not startTimeMS or not endTimeMS then return end
	
	if not frame.source[GUID] then
		frame.source[GUID] = {}
		frame.count = frame.count + 1
		frame.toptext:SetText(frame.count > 1 and frame.count or "")
	end
	
	if not frame.source[GUID]["exp"] or frame.source[GUID]["exp"] ~= endTimeMS/1000 then -- 避免重复
		frame.source[GUID]["start"] = startTimeMS/1000
		frame.source[GUID]["exp"] = endTimeMS/1000
		frame.source[GUID]["dur"] = (endTimeMS -startTimeMS)/1000
		
		local min_exp, min_start, min_dur, min_guid
		for k, v in pairs(frame.source) do
			if not min_exp or min_exp > v.exp then
				min_exp = v.exp
				min_start = v.start
				min_dur = v.dur
				min_guid = k
			end
		end
		
		if frame.exp ~= min_exp then
			frame.exp = min_exp
			frame.guid = min_guid
			frame.cooldown:SetCooldown(min_start, min_dur)
			frame:Show()
		end
	end
end

local OnFrameExp = function(frame, GUID)
	if frame.source[GUID] then
		frame.source[GUID] = nil
		frame.count = frame.count - 1
		
		if frame.count > 0 then
			frame.toptext:SetText(frame.count > 1 and frame.count or "")
			
			local min_exp, min_start, min_dur, min_guid
			for k, v in pairs(frame.source) do
				if not min_exp or min_exp > v.exp then
					min_exp = v.exp
					min_start = v.start
					min_dur = v.dur
					min_guid = k
				end
			end
			
			if frame.exp ~= min_exp then
				frame.exp = min_exp
				frame.guid = min_guid
				frame.cooldown:SetCooldown(min_start, min_dur)
				frame:Show()
			end			
		else
			frame.reset()
		end
	end
end

T.CreateCast = function(option_page, difficulty_id, index, v, hl, role, tip)
	local frame = T.CreateAlertIcon(v, hl, index, tip, 1, 1, 1, role)
	
	frame.reset = function()
		frame:Hide()
		frame.exp = 0
		frame.count = 0
		frame.source = table.wipe(frame.source)
		frame.cooldown:SetCooldown(0, 0)
	end
	
	frame:Hide()
	frame.exp = 0
	frame.count = 0
	frame.source = {}
	
	frame.update_onedit = function(option)
		if option == "all" or option == "enable" then	
			frame.enable = SoD_CDB["Icons"][v] and SoD_CDB["AlertFrame"]["enable"]
			if frame.enable then
				if type(frame.boss_index) == "string" then
					frame:RegisterEvent("PLAYER_ENTERING_WORLD")
				else
					frame:RegisterEvent("ENCOUNTER_START")
					frame:RegisterEvent("ENCOUNTER_END")
				end
			else
				if type(frame.boss_index) == "string" then
					frame:UnregisterEvent("PLAYER_ENTERING_WORLD")
				else
					frame:UnregisterEvent("ENCOUNTER_START")
					frame:UnregisterEvent("ENCOUNTER_END")
				end
			end	
			
			frame.update_onevent("INIT")
		end
		
		if option == "all" or option == "icon_size" then
			frame:SetSize(SoD_CDB["AlertFrame"]["icon_size"], SoD_CDB["AlertFrame"]["icon_size"])
			frame.glow:SetPoint("TOPLEFT", -SoD_CDB["AlertFrame"]["icon_size"]/3, SoD_CDB["AlertFrame"]["icon_size"]/3)
			frame.glow:SetPoint("BOTTOMRIGHT", SoD_CDB["AlertFrame"]["icon_size"]/3, -SoD_CDB["AlertFrame"]["icon_size"]/3)			
		end
		
		if option == "all" or option == "font_size" then
			frame.text:SetFont(G.Font, SoD_CDB["AlertFrame"]["font_size"], "OUTLINE")
			frame.text2:SetFont(G.Font, SoD_CDB["AlertFrame"]["font_size"], "OUTLINE")
		end
		
		if option == "all" or option == "ifont_size" then	
			frame.bottomtext:SetFont(G.Font, SoD_CDB["AlertFrame"]["ifont_size"], "OUTLINE")
		end
		
		if option == "all" or option == "grow_dir" or option == "icon_space" then
			AlertFrame.LineUpIcons()
		end
		
		if option == "all" or option == "spelltext" then
			if SoD_CDB["AlertFrame"]["show_spellname"] then
				frame.bottomtext:Show()
			else
				frame.bottomtext:Hide()
			end
		end
		
		if option == "all" or option == "cdreverse" then
			if SoD_CDB["AlertFrame"]["reverse_cooldown"] then
				frame.cooldown:SetReverse(true)
			else
				frame.cooldown:SetReverse(false)
			end
		end
	end
	
	frame.encounter_check = function(e, ...)
		if e == "INIT" then
			if type(frame.boss_index) == "string" then
				local map = select(8, GetInstanceInfo())
				if frame.enable and map == frame.mapID then
					for k, j in pairs(CastingEvents) do
						frame:RegisterEvent(k)
					end
				else
					for k, j in pairs(CastingEvents) do
						frame:UnregisterEvent(k)
					end
					frame.reset()
				end
			else
				local guid = UnitGUID("boss1")
				if guid then
					local NPC_ID = select(6, strsplit("-", UnitGUID("boss1")))
					local difficultyID = select(3, GetInstanceInfo())
					if frame.enable and NPC_ID == frame.npcID and (difficulty_id["all"] or difficulty_id[difficultyID]) then
						for k, j in pairs(CastingEvents) do
							frame:RegisterEvent(k)
						end
					end
				end
			end
		elseif e == "ENCOUNTER_START" then
			local encounterID, encounterName, difficultyID, groupSize = ...
			if frame.enable and encounterID == frame.engageID and (difficulty_id["all"] or difficulty_id[difficultyID]) then
				for k, j in pairs(CastingEvents) do
					frame:RegisterEvent(k)
				end
			end
		elseif e == "ENCOUNTER_END" then
			local encounterID, encounterName, difficultyID, groupSize = ...
			if encounterID == frame.engageID then
				for k, j in pairs(CastingEvents) do
					frame:UnregisterEvent(k)
				end
				frame.reset()
			end
		elseif e == "PLAYER_ENTERING_WORLD" then
			local map = select(8, GetInstanceInfo())
			if frame.enable and map == frame.mapID then
				for k, j in pairs(CastingEvents) do
					frame:RegisterEvent(k)
				end
			else
				for k, j in pairs(CastingEvents) do
					frame:UnregisterEvent(k)
				end
				frame.reset()
			end
		end
	end
	
	frame.update_onevent = function(e, ...)
		if e == "INIT" or e == "PLAYER_ENTERING_WORLD" or e == "ENCOUNTER_START" or e == "ENCOUNTER_END" then
			frame.encounter_check(e, ...)
		elseif frame.enable then	
			local Unit, _, SpellID = ...
			
			if SpellID == frame.spell_id then
				local GUID = UnitGUID(Unit)
				if e == "UNIT_SPELLCAST_CHANNEL_START" then -- 开始引导
					UpdateCastFrame(frame, Unit, GUID, "CHANNEL")
				elseif e == "UNIT_SPELLCAST_CHANNEL_UPDATE" then -- 刷新引导
					UpdateCastFrame(frame, Unit, GUID, "CHANNEL")
				elseif e == "UNIT_SPELLCAST_START" then -- 开始施法
					UpdateCastFrame(frame, Unit, GUID, "CAST")
				elseif e == "UNIT_SPELLCAST_SUCCEEDED" then
					UpdateCastFrame(frame, Unit, GUID, "INSTANT")		
				elseif e == "UNIT_SPELLCAST_CHANNEL_STOP" or e == "UNIT_SPELLCAST_STOP" then	
					OnFrameExp(frame, GUID)
				end
			end
		else
			frame.reset()
		end
	end
	
	frame.update_onframe = function()
		if frame.enable and frame.exp then	
			local remain = frame.exp - GetTime()
			
			if remain > 0 then
				frame.text:SetText(T.FormatTime(remain))
			else
				OnFrameExp(frame, frame.guid)
			end
		else
			frame.reset()
		end
	end
	
	frame:SetScript("OnEvent", function(self, e, ...)
		frame.update_onevent(e, ...)
	end)
	
	frame:SetScript("OnUpdate", function(self, e)
		frame.t = frame.t + e
		if frame.t > update_rate then	
			frame.update_onframe()
			frame.t = 0
		end
	end)
	
	AlertFrame.QueueIcon(frame)	
	
	G.Icons[v] = frame
	
	T.Create_AlertIcon_Options(option_page, difficulty_id, v, nil, role, tip)
	
end

T.CreateCastingOnMe = function(option_page, difficulty_id, index, v, hl, role, tip)
	local frame = T.CreateAlertIcon(v, hl, index, tip, 1, 1, 0, role)
	
	frame.reset = function()
		frame:Hide()
		frame.exp = 0
		frame.count = 0
		frame.source = table.wipe(frame.source)
		frame.cooldown:SetCooldown(0, 0)
	end
	
	frame:Hide()
	frame.exp = 0
	frame.count = 0
	frame.source = {}
	
	frame.update_onedit = function(option)
		if option == "all" or option == "enable" then	
			frame.enable = SoD_CDB["Icons"][v] and SoD_CDB["AlertFrame"]["enable"]
			if frame.enable then
				if type(frame.boss_index) == "string" then
					frame:RegisterEvent("PLAYER_ENTERING_WORLD")
				else
					frame:RegisterEvent("ENCOUNTER_START")
					frame:RegisterEvent("ENCOUNTER_END")
				end
			else
				if type(frame.boss_index) == "string" then
					frame:UnregisterEvent("PLAYER_ENTERING_WORLD")
				else
					frame:UnregisterEvent("ENCOUNTER_START")
					frame:UnregisterEvent("ENCOUNTER_END")
				end
			end
			
			frame.update_onevent("INIT")
		end
		
		if option == "all" or option == "icon_size" then
			frame:SetSize(SoD_CDB["AlertFrame"]["icon_size"], SoD_CDB["AlertFrame"]["icon_size"])
			frame.glow:SetPoint("TOPLEFT", -SoD_CDB["AlertFrame"]["icon_size"]/3, SoD_CDB["AlertFrame"]["icon_size"]/3)
			frame.glow:SetPoint("BOTTOMRIGHT", SoD_CDB["AlertFrame"]["icon_size"]/3, -SoD_CDB["AlertFrame"]["icon_size"]/3)			
		end
		
		if option == "all" or option == "font_size" then
			frame.text:SetFont(G.Font, SoD_CDB["AlertFrame"]["font_size"], "OUTLINE")
			frame.text2:SetFont(G.Font, SoD_CDB["AlertFrame"]["font_size"], "OUTLINE")
		end
		
		if option == "all" or option == "ifont_size" then			
			frame.bottomtext:SetFont(G.Font, SoD_CDB["AlertFrame"]["ifont_size"], "OUTLINE")
		end
		
		if option == "all" or option == "grow_dir" or option == "icon_space" then
			AlertFrame.LineUpIcons()
		end
		
		if option == "all" or option == "spelltext" then
			if SoD_CDB["AlertFrame"]["show_spellname"] then
				frame.bottomtext:Show()
			else
				frame.bottomtext:Hide()
			end
		end
		
		if option == "all" or option == "cdreverse" then
			if SoD_CDB["AlertFrame"]["reverse_cooldown"] then
				frame.cooldown:SetReverse(true)
			else
				frame.cooldown:SetReverse(false)
			end
		end
	end
	
	frame.encounter_check = function(e, ...)
		if e == "INIT" then
			if type(frame.boss_index) == "string" then
				local map = select(8, GetInstanceInfo())
				if frame.enable and map == frame.mapID then
					for k, j in pairs(CastingEvents) do
						frame:RegisterEvent(k)
					end
				else
					for k, j in pairs(CastingEvents) do
						frame:UnregisterEvent(k)
					end
					frame.reset()
				end
			else
				local guid = UnitGUID("boss1")
				if guid then
					local NPC_ID = select(6, strsplit("-", UnitGUID("boss1")))
					local difficultyID = select(3, GetInstanceInfo())
					if frame.enable and NPC_ID == frame.npcID and (difficulty_id["all"] or difficulty_id[difficultyID]) then
						for k, j in pairs(CastingEvents) do
							frame:RegisterEvent(k)
						end
					end
				end
			end
		elseif e == "ENCOUNTER_START" then
			local encounterID, encounterName, difficultyID, groupSize = ...
			if frame.enable and encounterID == frame.engageID and (difficulty_id["all"] or difficulty_id[difficultyID]) then
				for k, j in pairs(CastingEvents) do
					frame:RegisterEvent(k)
				end
			end
		elseif e == "ENCOUNTER_END" then
			local encounterID, encounterName, difficultyID, groupSize = ...
			if encounterID == frame.engageID then
				for k, j in pairs(CastingEvents) do
					frame:UnregisterEvent(k)
				end
				frame.reset()
			end
		elseif e == "PLAYER_ENTERING_WORLD" then
			local map = select(8, GetInstanceInfo())
			if frame.enable and map == frame.mapID then
				for k, j in pairs(CastingEvents) do
					frame:RegisterEvent(k)
				end
			else
				for k, j in pairs(CastingEvents) do
					frame:UnregisterEvent(k)
				end
				frame.reset()
			end
		end
	end
	
	frame.update_onevent = function(e, ...)
		if e == "INIT" or e == "PLAYER_ENTERING_WORLD" or e == "ENCOUNTER_START" or e == "ENCOUNTER_END" then
			frame.encounter_check(e, ...)
		elseif frame.enable then
			local Unit, _, SpellID = ...
			if SpellID == frame.spell_id then
				local GUID = UnitGUID(Unit)
				if e == "UNIT_SPELLCAST_CHANNEL_START" then -- 开始引导
					C_Timer.After(.1, function()					
						if UnitIsUnit(Unit.."target", "player") then -- 目标是我
							UpdateCastFrame(frame, Unit, GUID, "CHANNEL")
						end
					end)
				elseif e == "UNIT_SPELLCAST_CHANNEL_UPDATE" then -- 刷新引导
					C_Timer.After(.1, function()					
						if UnitIsUnit(Unit.."target", "player") then -- 目标是我
							UpdateCastFrame(frame, Unit, GUID, "CHANNEL")
						end
					end)
				elseif e == "UNIT_SPELLCAST_START" then -- 开始施法
					C_Timer.After(.1, function()
						if UnitIsUnit(Unit.."target", "player") then
							UpdateCastFrame(frame, Unit, GUID, "CAST")
						end
					end)
				elseif e == "UNIT_SPELLCAST_CHANNEL_STOP" or e == "UNIT_SPELLCAST_STOP" then
					OnFrameExp(frame, GUID)
				end
			end
		else
			frame.reset()
		end
	end
	
	frame.update_onframe = function()
		if frame.enable and frame.exp then	
			local remain = frame.exp - GetTime()
			
			if remain > 0 then
				frame.text:SetText(string.format(L["点你"], T.FormatTime(remain)))
			else
				OnFrameExp(frame, frame.guid)
			end
		else
			frame.reset()
		end
	end
	
	frame:SetScript("OnEvent", function(self, e, ...)
		frame.update_onevent(e, ...)
	end)
	
	frame:SetScript("OnUpdate", function(self, e)
		frame.t = frame.t + e
		if frame.t > update_rate then	
			frame.update_onframe()
			frame.t = 0
		end
	end)
	
	AlertFrame.QueueIcon(frame)	
	
	G.Icons[v] = frame

	T.Create_AlertIcon_Options(option_page, difficulty_id, v, nil, role, tip)
	
end

T.CreateBossMsg = function(option_page, difficulty_id, index, v, hl, role, tip, event, msg, dur)
	local frame = T.CreateAlertIcon(v, hl, index, tip, 1, 1, 1, role)
	
	frame.dur = dur
	
	frame.reset = function()
		frame:Hide()
		frame.exp = false
	end
	
	frame.update_onedit = function(option)
		if option == "all" or option == "enable" then	
			frame.enable = SoD_CDB["Icons"][v] and SoD_CDB["AlertFrame"]["enable"]
			if frame.enable then
				if type(frame.boss_index) == "string" then
					frame:RegisterEvent("PLAYER_ENTERING_WORLD")
				else
					frame:RegisterEvent("ENCOUNTER_START")
					frame:RegisterEvent("ENCOUNTER_END")
				end
			else
				if type(frame.boss_index) == "string" then
					frame:UnregisterEvent("PLAYER_ENTERING_WORLD")
				else
					frame:UnregisterEvent("ENCOUNTER_START")
					frame:UnregisterEvent("ENCOUNTER_END")
				end
			end	
			
			frame.update_onevent("INIT")
		end
		
		if option == "all" or option == "icon_size" then
			frame:SetSize(SoD_CDB["AlertFrame"]["icon_size"], SoD_CDB["AlertFrame"]["icon_size"])
			frame.glow:SetPoint("TOPLEFT", -SoD_CDB["AlertFrame"]["icon_size"]/3, SoD_CDB["AlertFrame"]["icon_size"]/3)
			frame.glow:SetPoint("BOTTOMRIGHT", SoD_CDB["AlertFrame"]["icon_size"]/3, -SoD_CDB["AlertFrame"]["icon_size"]/3)					
		end
		
		if option == "all" or option == "font_size" then
			frame.text:SetFont(G.Font, SoD_CDB["AlertFrame"]["font_size"], "OUTLINE")
			frame.text2:SetFont(G.Font, SoD_CDB["AlertFrame"]["font_size"], "OUTLINE")
		end
		
		if option == "all" or option == "ifont_size" then			
			frame.bottomtext:SetFont(G.Font, SoD_CDB["AlertFrame"]["ifont_size"], "OUTLINE")
		end
		
		if option == "all" or option == "grow_dir" or option == "icon_space" then
			AlertFrame.LineUpIcons()
		end
		
		if option == "all" or option == "spelltext" then
			if SoD_CDB["AlertFrame"]["show_spellname"] then
				frame.bottomtext:Show()
			else
				frame.bottomtext:Hide()
			end
		end
		
		if option == "all" or option == "cdreverse" then
			if SoD_CDB["AlertFrame"]["reverse_cooldown"] then
				frame.cooldown:SetReverse(true)
			else
				frame.cooldown:SetReverse(false)
			end
		end
	end
	
	frame.encounter_check = function(e, ...)
		if e == "INIT" then
			if type(frame.boss_index) == "string" then
				local map = select(8, GetInstanceInfo())
				if frame.enable and map == frame.mapID then
					frame:RegisterEvent(event)
				else
					frame:UnregisterEvent(event)
					frame.reset()
				end
			else
				local guid = UnitGUID("boss1")
				if guid then
					local NPC_ID = select(6, strsplit("-", UnitGUID("boss1")))
					local difficultyID = select(3, GetInstanceInfo())
					if frame.enable and NPC_ID == frame.npcID and (difficulty_id["all"] or difficulty_id[difficultyID]) then
						frame:RegisterEvent(event)
					end
				end
			end
		elseif e == "ENCOUNTER_START" then
			local encounterID, encounterName, difficultyID, groupSize = ...
			if frame.enable and encounterID == frame.engageID and (difficulty_id["all"] or difficulty_id[difficultyID]) then
				frame:RegisterEvent(event)
			end
		elseif e == "ENCOUNTER_END" then
			local encounterID, encounterName, difficultyID, groupSize = ...
			if encounterID == frame.engageID then
				frame:UnregisterEvent(event)
				frame.reset()
			end
		elseif e == "PLAYER_ENTERING_WORLD" then
			local map = select(8, GetInstanceInfo())
			if frame.enable and map == frame.mapID then
				frame:RegisterEvent(event)
			else
				frame:UnregisterEvent(event)
				frame.reset()
			end
		end
	end
	
	frame.update_onevent = function(e, ...)
		if e == "INIT" or e == "PLAYER_ENTERING_WORLD" or e == "ENCOUNTER_START" or e == "ENCOUNTER_END" then
			frame.encounter_check(e, ...)
		elseif e == event then
			local Msg = ...
			if Msg and Msg:find(msg) then
				frame.exp = GetTime() + frame.dur
				frame:Show()
				frame.cooldown:SetCooldown(GetTime(), frame.dur)
			end
		end
	end
	
	frame.update_onframe = function()
		if frame.enable and frame.exp then
			local remain = frame.exp - GetTime()	
			frame.text:SetText(T.FormatTime(remain))			
			
			if remain <= 0 then
				frame.reset()
			end
		else
			frame.reset()
		end
	end
	
	frame:SetScript("OnEvent", function(self, e, ...)
		frame.update_onevent(e, ...)
	end)
	
	frame:SetScript("OnUpdate", function(self, e)
		frame.t = frame.t + e
		if frame.t > update_rate then	
			frame.update_onframe()	
			frame.t = 0
		end
	end)
	
	AlertFrame.QueueIcon(frame)	
	
	G.Icons[v] = frame
	
	T.Create_AlertIcon_Options(option_page, difficulty_id, v, nil, role, tip)
	
end

T.CreateBWSpellTimer = function(option_page, difficulty_id, index, v, hl, role, tip, dur, addon_only)
	local frame = T.CreateAlertIcon(v, hl, index, tip, 1, 1, 1, role)
	
	frame.dur = dur
	
	frame.reset = function()
		frame:Hide()
		frame.start = false
		frame.exp = false
		frame.eframe:SetScript("OnUpdate", nil)
	end
	
	frame.update_onedit = function(option)
		if option == "all" or option == "enable" then	
			frame.enable = SoD_CDB["Icons"][v] and SoD_CDB["AlertFrame"]["enable"]
			if frame.enable then
				frame:RegisterEvent("ENCOUNTER_START")
				frame:RegisterEvent("ENCOUNTER_END")
			else
				frame:UnregisterEvent("ENCOUNTER_START")
				frame:UnregisterEvent("ENCOUNTER_END")
			end
			
			frame.update_onevent("INIT")
		end
		
		if option == "all" or option == "icon_size" then
			frame:SetSize(SoD_CDB["AlertFrame"]["icon_size"], SoD_CDB["AlertFrame"]["icon_size"])
			frame.glow:SetPoint("TOPLEFT", -SoD_CDB["AlertFrame"]["icon_size"]/3, SoD_CDB["AlertFrame"]["icon_size"]/3)
			frame.glow:SetPoint("BOTTOMRIGHT", SoD_CDB["AlertFrame"]["icon_size"]/3, -SoD_CDB["AlertFrame"]["icon_size"]/3)					
		end
		
		if option == "all" or option == "font_size" then
			frame.text:SetFont(G.Font, SoD_CDB["AlertFrame"]["font_size"], "OUTLINE")
			frame.text2:SetFont(G.Font, SoD_CDB["AlertFrame"]["font_size"], "OUTLINE")
		end
		
		if option == "all" or option == "ifont_size" then			
			frame.bottomtext:SetFont(G.Font, SoD_CDB["AlertFrame"]["ifont_size"], "OUTLINE")
		end
		
		if option == "all" or option == "grow_dir" or option == "icon_space" then
			AlertFrame.LineUpIcons()
		end
		
		if option == "all" or option == "spelltext" then
			if SoD_CDB["AlertFrame"]["show_spellname"] then
				frame.bottomtext:Show()
			else
				frame.bottomtext:Hide()
			end
		end
		
		if option == "all" or option == "cdreverse" then
			if SoD_CDB["AlertFrame"]["reverse_cooldown"] then
				frame.cooldown:SetReverse(true)
			else
				frame.cooldown:SetReverse(false)
			end
		end
	end

	frame.encounter_check = function(event, ...)
		if event == "INIT" then
			local guid = UnitGUID("boss1")
			if guid then
				local NPC_ID = select(6, strsplit("-", UnitGUID("boss1")))
				local difficultyID = select(3, GetInstanceInfo())
				if frame.enable and NPC_ID == frame.npcID and (difficulty_id["all"] or difficulty_id[difficultyID]) then
					frame:RegisterEvent("CHAT_MSG_ADDON")
				end
			end
		elseif event == "ENCOUNTER_START" then
			local encounterID, encounterName, difficultyID = ...
			if frame.enable and encounterID == frame.engageID and (difficulty_id["all"] or difficulty_id[difficultyID]) then
				frame:RegisterEvent("CHAT_MSG_ADDON")
			end
		elseif event == "ENCOUNTER_END" then
			local encounterID, encounterName, difficultyID = ...
			if encounterID == frame.engageID then
				frame:UnregisterEvent("CHAT_MSG_ADDON")
				frame.reset()
			end
		end
	end
	
	frame.eframe = CreateFrame('Frame', nil, G.FrameHolder)
	frame.eframe.t = 0
	
	frame.update_onevent = function(event, ...)
		if event == "INIT" or event == "PLAYER_ENTERING_WORLD" or event == "ENCOUNTER_START" or event == "ENCOUNTER_END" then
			frame.encounter_check(event, ...)
		elseif event == "CHAT_MSG_ADDON" then
			local prefix, message, channel, sender = ... 
			if prefix == "sodpaopao" and channel == "WHISPER" and G.PlayerName == string.split("-", sender) then
				
				local mark, event_type, id, text, exp_time = string.split("_", message)

				if mark == "sodbw" or mark == "soddbm" then
					id = tonumber(id)
					if id == frame.spell_id then -- id匹配
						if event_type == "start" then -- 计时条开始，计算图标出现时间
							exp_time = tonumber(exp_time)
							frame.exp = exp_time
							frame.start = exp_time - frame.dur
							if frame.exp > GetTime() then
								frame.eframe:SetScript('OnUpdate', function(self, e)
									self.t = self.t + e
									if self.t > update_rate then
										if frame.start then
											local wait = frame.start - GetTime()
											if wait <= 0 then
												frame:Show()
												frame.cooldown:SetCooldown(frame.start, frame.dur)
												self:SetScript("OnUpdate", nil)
											end
											self.t = 0
										else
											self:SetScript("OnUpdate", nil)
										end
									end
								end)
							end
						elseif event_type == "stop" then -- 计时条结束
							frame.reset()
						end
					end
				end
			end
		end
	end
	
	frame.update_onframe = function()
		if frame.enable and frame.exp then
			local remain = frame.exp - GetTime()
			if remain > 0 then
				frame.text:SetText(T.FormatTime(remain))
			else 
				frame.reset()
			end
		else
			frame.reset()
		end
	end
	
	frame:SetScript("OnEvent", function(self, event, ...)
		frame.update_onevent(event, ...)
	end)
	
	frame:SetScript("OnUpdate", function(self, e)
		frame.t = frame.t + e
		if frame.t > update_rate then	
			frame.update_onframe()	
			frame.t = 0
		end
	end)
	
	AlertFrame.QueueIcon(frame)	
	
	G.Icons[v] = frame

	T.Create_AlertIcon_Options(option_page, difficulty_id, v, addon_only, role, tip)
end

T.CreateBWTextTimer = function(option_page, difficulty_id, index, v, hl, role, tip, key, dur, addon_only)
	local frame = T.CreateAlertIcon(v, hl, index, tip, 1, 1, 1, role)
	
	frame.dur = dur

	frame.reset = function()
		frame:Hide()
		frame.start = false
		frame.exp = false
		frame.eframe:SetScript("OnUpdate", nil)
	end
	
	frame.update_onedit = function(option)
		if option == "all" or option == "enable" then	
			frame.enable = SoD_CDB["Icons"][v] and SoD_CDB["AlertFrame"]["enable"]
			if frame.enable then
				frame:RegisterEvent("ENCOUNTER_START")
				frame:RegisterEvent("ENCOUNTER_END")
			else
				frame:UnregisterEvent("ENCOUNTER_START")
				frame:UnregisterEvent("ENCOUNTER_END")
			end
			
			frame.update_onevent("INIT")
		end
		
		if option == "all" or option == "icon_size" then
			frame:SetSize(SoD_CDB["AlertFrame"]["icon_size"], SoD_CDB["AlertFrame"]["icon_size"])
			frame.glow:SetPoint("TOPLEFT", -SoD_CDB["AlertFrame"]["icon_size"]/3, SoD_CDB["AlertFrame"]["icon_size"]/3)
			frame.glow:SetPoint("BOTTOMRIGHT", SoD_CDB["AlertFrame"]["icon_size"]/3, -SoD_CDB["AlertFrame"]["icon_size"]/3)					
		end
		
		if option == "all" or option == "font_size" then
			frame.text:SetFont(G.Font, SoD_CDB["AlertFrame"]["font_size"], "OUTLINE")
			frame.text2:SetFont(G.Font, SoD_CDB["AlertFrame"]["font_size"], "OUTLINE")
		end
		
		if option == "all" or option == "ifont_size" then
			frame.bottomtext:SetFont(G.Font, SoD_CDB["AlertFrame"]["ifont_size"], "OUTLINE")
		end
		
		if option == "all" or option == "grow_dir" or option == "icon_space" then
			AlertFrame.LineUpIcons()
		end
		
		if option == "all" or option == "spelltext" then
			if SoD_CDB["AlertFrame"]["show_spellname"] then
				frame.bottomtext:Show()
			else
				frame.bottomtext:Hide()
			end
		end
		
		if option == "all" or option == "cdreverse" then
			if SoD_CDB["AlertFrame"]["reverse_cooldown"] then
				frame.cooldown:SetReverse(true)
			else
				frame.cooldown:SetReverse(false)
			end
		end
	end
	
	frame.encounter_check = function(event, ...)
		if event == "INIT" then
			local guid = UnitGUID("boss1")
			if guid then
				local NPC_ID = select(6, strsplit("-", UnitGUID("boss1")))
				local difficultyID = select(3, GetInstanceInfo())
				if frame.enable and NPC_ID == frame.npcID and (difficulty_id["all"] or difficulty_id[difficultyID]) then
					frame:RegisterEvent("CHAT_MSG_ADDON")
				end
			end
		elseif event == "ENCOUNTER_START" then
			local encounterID, encounterName, difficultyID = ...
			if frame.enable and encounterID == frame.engageID and (difficulty_id["all"] or difficulty_id[difficultyID]) then
				frame:RegisterEvent("CHAT_MSG_ADDON")
			end
		elseif event == "ENCOUNTER_END" then
			local encounterID, encounterName, difficultyID = ...
			if encounterID == frame.engageID then
				frame:UnregisterEvent("CHAT_MSG_ADDON")
				frame.reset()
			end
		end
	end
	
	frame.eframe = CreateFrame('Frame', nil, G.FrameHolder)
	frame.eframe.t = 0

	frame.update_onevent = function(event, ...)
		if event == "INIT" or event == "PLAYER_ENTERING_WORLD" or event == "ENCOUNTER_START" or event == "ENCOUNTER_END" then
			frame.encounter_check(event, ...)
		elseif event == "CHAT_MSG_ADDON" then
			local prefix, message, channel, sender = ... 
			if prefix == "sodpaopao" and channel == "WHISPER" and G.PlayerName == string.split("-", sender) then

				local mark, event_type, id, text, exp_time = string.split("_", message)
				
				if mark == "sodbw" or mark == "soddbm" then
					if text:find(key) then -- 文本匹配
						if event_type == "start" then -- 计时条开始，计算图标出现时间
							exp_time = tonumber(exp_time)
							frame.exp = exp_time
							frame.start = exp_time - frame.dur
							if frame.exp > GetTime() then
								frame.eframe:SetScript('OnUpdate', function(self, e)
									self.t = self.t + e
									if self.t > update_rate then
										if frame.start then
											local wait = frame.start - GetTime()
											if wait <= 0 then
												frame:Show()
												frame.cooldown:SetCooldown(frame.start, frame.dur)
												self:SetScript("OnUpdate", nil)
											end
											self.t = 0
										else
											self:SetScript("OnUpdate", nil)
										end
									end
								end)
							end
						elseif event_type == "stop" then -- 计时条结束
							frame.reset()	
						end
					end
				end
			end
		end
	end
	
	frame.update_onframe = function()
		if frame.enable and frame.exp then
			local remain = frame.exp - GetTime()
			if remain > 0 then
				frame.text:SetText(T.FormatTime(remain))
			else 
				frame.reset()
			end
		else
			frame.reset()
		end
	end
	
	frame:SetScript("OnEvent", function(self, event, ...)
		frame.update_onevent(event, ...)
	end)
	
	frame:SetScript("OnUpdate", function(self, e)
		frame.t = frame.t + e
		if frame.t > update_rate then	
			frame.update_onframe()	
			frame.t = 0
		end
	end)
	
	AlertFrame.QueueIcon(frame)	
	
	G.Icons[v] = frame

	T.Create_AlertIcon_Options(option_page, difficulty_id, v, addon_only, role, tip)
end
----------------------------------------------------------
--------------------[[    Text Alert    ]]----------------
----------------------------------------------------------

local TextFrame = CreateFrame("Frame", G.addon_name.."Text_Alert", G.FrameHolder)
TextFrame:SetSize(300,50)
G.TextFrame = TextFrame

TextFrame.movingname = L["文字提示"]
TextFrame.point = { a1 = "CENTER", parent = "UIParent", a2 = "CENTER", x = 0, y = 250 }
T.CreateDragFrame(TextFrame)

T.EditTextFrame = function(option)
	if option == "all" or option == "font_size" then
		TextFrame:SetSize(SoD_CDB["TextFrame"]["font_size"]*8, SoD_CDB["TextFrame"]["font_size"])
	end
	
	for k, frame in pairs(G.Texts) do
		frame.update_onedit(option)
	end	
end

TextFrame.ActiveTexts = {}
TextFrame.LineUpTexts = function()
	local lastframe
	for v, frame in T.pairsByKeys(TextFrame.ActiveTexts) do
		frame:ClearAllPoints()
		if not lastframe then
			frame:SetPoint("TOP", TextFrame, "TOP")
		else
			frame:SetPoint("TOP", lastframe, "BOTTOM", 0, -5)
		end
		lastframe = frame
	end
end

TextFrame.QueueText = function(frame)
	frame:HookScript("OnShow", function()
		TextFrame.ActiveTexts[frame.v] = frame
		TextFrame.LineUpTexts()
	end)
	
	frame:HookScript("OnHide", function()
		TextFrame.ActiveTexts[frame.v] = nil
		TextFrame.LineUpTexts()
	end)
end

T.CreateAlertText = function(v, index, color)
	local frame = CreateFrame("Frame", nil, TextFrame)
	frame:SetSize(300,50)
	frame:Hide()
	
	if index == "test" then
		frame.type = v
	else
		frame.boss_index = index
		frame.type = strsplit("_", v)
		
		if type(frame.boss_index) == "string" then
			frame.mapID = G.Encounters[frame.boss_index]["map_id"]
		else
			frame.boss_index = tonumber(frame.boss_index)
			frame.npcID = G.Encounters[frame.boss_index]["npc_id"]
			frame.engageID = G.Encounters[frame.boss_index]["engage_id"]
		end
	end

	frame.v = tostring(v)
	--print(frame.v)
	frame.t = 0
	
	frame.text = T.createtext(frame, "OVERLAY", 50, "OUTLINE", "CENTER")
	frame.text:SetPoint("CENTER", frame, "CENTER", 0, 0)
	
	if frame.type == "hp" then
		frame.text:SetTextColor(1, 0, 0)
	elseif frame.type == "pp" then
		frame.text:SetTextColor(0, 1, 1)
	else
		frame.text:SetTextColor(unpack(color))
	end
	
	return frame
end

T.CreateSelfCloneAlertText = function(v, index, dur, color)
	local frame = CreateFrame("Frame", nil, TextFrame)
	
	frame.boss_index = index
	frame.type = strsplit("_", v)
	
	if type(frame.boss_index) == "string" then
		frame.mapID = G.Encounters[frame.boss_index]["map_id"]
	else
		frame.boss_index = tonumber(frame.boss_index)
		frame.npcID = G.Encounters[frame.boss_index]["npc_id"]
		frame.engageID = G.Encounters[frame.boss_index]["engage_id"]
	end
	
	frame.v = v
	frame.t = 0
	frame.children = {}
	
	frame.Clone = function(str, show_time)
		local f = CreateFrame("Frame", nil, frame)
		f:SetSize(800, SoD_CDB["TextFrame"]["font_size"])

		f.text = T.createtext(f, "OVERLAY", SoD_CDB["TextFrame"]["font_size"], "OUTLINE", "CENTER")
		f.text:SetPoint("CENTER", f, "CENTER", 0, 0)
		f.text:SetTextColor(unpack(color))
		
		f.exp = GetTime() + dur
		f:SetScript("OnUpdate", function(s, e)
			s.t = (s.t or 0) + e
			if s.t > update_rate then
				local remain = s.exp - GetTime()
				if remain > 0 then
					if show_time then
						f.text:SetText(str.." "..T.FormatTime(remain))
					else
						f.text:SetText(str)
					end
				else
					s:Hide()
					s:SetScript("OnUpdate", nil)
				end
			end
		end)

		table.insert(frame.children, f)
		f.v = v.."clone_"..#frame.children
		
		TextFrame.QueueText(f)
		f:Hide()
		f:Show()
	end
	
	return frame
end

T.CreateHealthText = function(option_page, difficulty_id, index, v, role, data)

	local frame = T.CreateAlertText(v, index)
	
	frame.update_onedit = function(option)
		if option == "all" or option == "enable" then
			frame.enable = SoD_CDB["Text_Alerts"][v] and SoD_CDB["TextFrame"]["enable"]
			if frame.enable then
				frame:RegisterEvent("ENCOUNTER_START")
				frame:RegisterEvent("ENCOUNTER_END")
			else
				frame:UnregisterEvent("ENCOUNTER_START")
				frame:UnregisterEvent("ENCOUNTER_END")
			end	
			
			frame.update_onevent(frame, "INIT")
		end
		
		if option == "all" or option == "font_size" then	
			frame:SetSize(SoD_CDB["TextFrame"]["font_size"]*8, SoD_CDB["TextFrame"]["font_size"])
			frame.text:SetFont(G.Font, SoD_CDB["TextFrame"]["font_size"], "OUTLINE")
		end
		
		TextFrame.LineUpTexts()
	end
	
	frame.encounter_check = function(event, ...)
		if frame.enable then
			if event == "INIT" then
				local guid = UnitGUID("boss1")
				if guid then
					local NPC_ID = select(6, strsplit("-", UnitGUID("boss1")))
					local difficultyID = select(3, GetInstanceInfo())
					if frame.enable and NPC_ID == frame.npcID and (difficulty_id["all"] or difficulty_id[difficultyID]) then
						frame:RegisterEvent("UNIT_HEALTH")
						frame.update(self, event, data.unit)
					end
				end
			elseif event == "ENCOUNTER_START" then
				local encounterID, encounterName, difficultyID, groupSize = ...
				if frame.enable and encounterID == frame.engageID and (difficulty_id["all"] or difficulty_id[difficultyID]) then
					frame:RegisterEvent("UNIT_HEALTH")
					frame.update(self, event, data.unit)
				end
			elseif event == "ENCOUNTER_END" then
				local encounterID, encounterName, difficultyID, groupSize = ...
				if encounterID == frame.engageID then
					frame:UnregisterEvent("UNIT_HEALTH")
					frame:Hide()
				end
			end
		else
			frame:UnregisterEvent("UNIT_HEALTH")
			frame:Hide()
		end
	end
	
	frame.update = function(self, event, unit)
		if unit == data.unit then
			local guid = UnitGUID(data.unit)
			if not guid then
				frame:Hide()
			else
				local NPC_ID = select(6, strsplit("-", guid))
				if NPC_ID ~= data.npc_id then
					frame:Hide()
				else
					local hp = UnitHealth(data.unit)
					local hp_max = UnitHealthMax(data.unit)
					local hp_perc

					if hp and hp_max then
						hp_perc = hp/hp_max*100
					end
					
					local show
							
					for i, range in pairs(data.ranges) do
						if hp_perc and (hp_perc <= range["ul"]) and (hp_perc >= range["ll"]) then
							frame.text:SetText(string.format(range["tip"], hp_perc))
							frame:Show()
							show = true
							break
						end
					end

					if not show then
						frame:Hide()
					end
				end
			end
		end
	end
	
	frame.update_onevent = function(self, event, ...)
		if event == "INIT" or event == "ENCOUNTER_START" or event == "ENCOUNTER_END" then
			frame.encounter_check(event, ...)
		else
			frame.update(self, event, ...)
		end
	end
	
	frame:SetScript("OnEvent", function(self, event, ...)
		frame.update_onevent(self, event, ...)
	end)
	
	TextFrame.QueueText(frame)	
	
	G.Texts[v] = frame
	
	T.Create_TextAlert_Options(option_page, difficulty_id, index, v, role)
	
end

T.CreatePowerText = function(option_page, difficulty_id, index, v, role, data)

	local frame = T.CreateAlertText(v, index)
	
	frame.update_onedit = function(option)
		if option == "all" or option == "enable" then
			frame.enable = SoD_CDB["Text_Alerts"][v] and SoD_CDB["TextFrame"]["enable"]
			if frame.enable then
				frame:RegisterEvent("ENCOUNTER_START")
				frame:RegisterEvent("ENCOUNTER_END")
			else
				frame:UnregisterEvent("ENCOUNTER_START")
				frame:UnregisterEvent("ENCOUNTER_END")
			end	
			
			frame.update_onevent(frame, "INIT")
		end
		
		if option == "all" or option == "font_size" then	
			frame:SetSize(SoD_CDB["TextFrame"]["font_size"]*8, SoD_CDB["TextFrame"]["font_size"])
			frame.text:SetFont(G.Font, SoD_CDB["TextFrame"]["font_size"], "OUTLINE")
		end
		
		TextFrame.LineUpTexts()
	end
	
	frame.encounter_check = function(event, ...)
		if frame.enable then
			if event == "INIT" then
				local guid = UnitGUID("boss1")
				if guid then
					local NPC_ID = select(6, strsplit("-", UnitGUID("boss1")))
					local difficultyID = select(3, GetInstanceInfo())
					if frame.enable and NPC_ID == frame.npcID and (difficulty_id["all"] or difficulty_id[difficultyID]) then
						frame:RegisterEvent("UNIT_POWER_UPDATE")
						frame.update(self, event, data.unit)
					end
				end
			elseif event == "ENCOUNTER_START" then
				local encounterID, encounterName, difficultyID, groupSize = ...
				if frame.enable and encounterID == frame.engageID and (difficulty_id["all"] or difficulty_id[difficultyID]) then
					frame:RegisterEvent("UNIT_POWER_UPDATE")
					frame.update(self, event, data.unit)
				end
			elseif event == "ENCOUNTER_END" then
				local encounterID, encounterName, difficultyID, groupSize = ...
				if encounterID == frame.engageID then
					frame:UnregisterEvent("UNIT_POWER_UPDATE")
					frame:Hide()
				end
			end
		else
			frame:UnregisterEvent("UNIT_POWER_UPDATE")
			frame:Hide()
		end
	end
	
	frame.update = function(self, event, unit)
		if unit == data.unit then
			local guid = UnitGUID(data.unit)
			if not guid then
				frame:Hide()
			else
				local NPC_ID = select(6, strsplit("-", guid))
				if NPC_ID ~= data.npc_id then
					frame:Hide()
				else			
					local pp = UnitPower(data.unit)
					
					local show = false
					
					for i, range in pairs(data.ranges) do
						if pp and (pp <= range["ul"]) and (pp >= range["ll"]) then
							frame.text:SetText(string.format(range["tip"], pp))
							frame:Show()
							show = true
							break
						end
					end
					
					if not show then
						frame:Hide()
					end
				end
			end
		end
	end
	
	frame.update_onevent = function(self, event, ...)
		if event == "INIT" or event == "ENCOUNTER_START" or event == "ENCOUNTER_END" then
			frame.encounter_check(event, ...)
		else
			frame.update(self, event, ...)
		end
	end
	
	frame:SetScript("OnEvent", function(self, event, ...)
		frame.update_onevent(self, event, ...)
	end)
	
	TextFrame.QueueText(frame)	
	
	G.Texts[v] = frame
	
	T.Create_TextAlert_Options(option_page, difficulty_id, index, v, role)
	
end

T.CreateNoneCloneText = function(option_page, difficulty_id, index, v, role, events, update, color)

	local frame = T.CreateAlertText(v, index, color)
	
	frame.events = events
	frame.update = update
	
	frame.update_onedit = function(option)
		if option == "all" or option == "enable" then
			frame.enable = SoD_CDB["Text_Alerts"][v] and SoD_CDB["TextFrame"]["enable"]
			if frame.enable then
				if type(frame.boss_index) == "string" then
					frame:RegisterEvent("PLAYER_ENTERING_WORLD")
				else
					frame:RegisterEvent("ENCOUNTER_START")
					frame:RegisterEvent("ENCOUNTER_END")
				end
			else
				if type(frame.boss_index) == "string" then
					frame:UnregisterEvent("PLAYER_ENTERING_WORLD")
				else
					frame:UnregisterEvent("ENCOUNTER_START")
					frame:UnregisterEvent("ENCOUNTER_END")
				end
			end
			
			frame.update_onevent(frame, "INIT")
		end
		
		if option == "all" or option == "font_size" then	
			frame:SetSize(SoD_CDB["TextFrame"]["font_size"]*8, SoD_CDB["TextFrame"]["font_size"])
			frame.text:SetFont(G.Font, SoD_CDB["TextFrame"]["font_size"], "OUTLINE")
		end
		
		TextFrame.LineUpTexts()
	end
	
	frame.encounter_check = function(event, ...)
		if event == "INIT" then
			if type(frame.boss_index) == "string" then
				local map = select(8, GetInstanceInfo())
				if frame.enable and map == frame.mapID then
					for event in pairs(frame.events) do
						frame:RegisterEvent(event)
					end
				else
					for event in pairs(frame.events) do
						frame:UnregisterEvent(event)
					end
				end
			else
				local guid = UnitGUID("boss1")
				if guid then
					local NPC_ID = select(6, strsplit("-", UnitGUID("boss1")))
					local difficultyID = select(3, GetInstanceInfo())
					if frame.enable and NPC_ID == frame.npcID and (difficulty_id["all"] or difficulty_id[difficultyID]) then
						for event in pairs(frame.events) do
							frame:RegisterEvent(event)
						end
					end
				end
			end
		elseif event == "ENCOUNTER_START" then
			local encounterID, encounterName, difficultyID, groupSize = ...
			if frame.enable and encounterID == frame.engageID and (difficulty_id["all"] or difficulty_id[difficultyID]) then
				for event in pairs(frame.events) do
					frame:RegisterEvent(event)
				end
			end
		elseif event == "ENCOUNTER_END" then
			local encounterID, encounterName, difficultyID, groupSize = ...
			if encounterID == frame.engageID then
				for event in pairs(frame.events) do
					frame:UnregisterEvent(event)
				end
				frame:Hide()
			end
		elseif event == "PLAYER_ENTERING_WORLD" then
			local map = select(8, GetInstanceInfo())
			if frame.enable and map == frame.mapID then
				for event in pairs(frame.events) do
					frame:RegisterEvent(event)
				end
			else
				for event in pairs(frame.events) do
					frame:UnregisterEvent(event)	
				end
				frame:Hide()
			end
		end
	end

	frame.update_onevent = function(self, event, ...)
		if event == "INIT" or event == "ENCOUNTER_START" or event == "ENCOUNTER_END" or event == "PLAYER_ENTERING_WORLD" then
			frame.encounter_check(event, ...)
		else
			frame.update(self, event, ...)
		end
	end
	
	frame:SetScript("OnEvent", function(self, event, ...)
		frame.update_onevent(self, event, ...)
	end)
	
	TextFrame.QueueText(frame)
	
	G.Texts[v] = frame
	
	T.Create_TextAlert_Options(option_page, difficulty_id, index, v, role)
end

T.CreateSelfCloneText = function(option_page, difficulty_id, index, v, role, events, update, dur, color)

	local frame = T.CreateSelfCloneAlertText(v, index, dur, color)
	
	frame.events = events
	frame.update = update
	
	frame.update_onedit = function(option)
		if option == "all" or option == "enable" then
			frame.enable = SoD_CDB["Text_Alerts"][v] and SoD_CDB["TextFrame"]["enable"]
			if frame.enable then
				if type(frame.boss_index) == "string" then
					frame:RegisterEvent("PLAYER_ENTERING_WORLD")
				else
					frame:RegisterEvent("ENCOUNTER_START")
					frame:RegisterEvent("ENCOUNTER_END")
				end
			else
				if type(frame.boss_index) == "string" then
					frame:UnregisterEvent("PLAYER_ENTERING_WORLD")
				else
					frame:UnregisterEvent("ENCOUNTER_START")
					frame:UnregisterEvent("ENCOUNTER_END")
				end
			end
			
			frame.update_onevent(frame, "INIT")
		end
		
		if option == "all" or option == "font_size" then
			for i = 1, #frame.children do
				local child = frame.children[i]
				child:SetSize(SoD_CDB["TextFrame"]["font_size"]*8, SoD_CDB["TextFrame"]["font_size"])
				child.text:SetFont(G.Font, SoD_CDB["TextFrame"]["font_size"], "OUTLINE")
			end
		end
		
		TextFrame.LineUpTexts()
	end
	
	frame.encounter_check = function(event, ...)
		if event == "INIT" then
			if type(frame.boss_index) == "string" then
				local map = select(8, GetInstanceInfo())
				if frame.enable and map == frame.mapID then
					for event in pairs(frame.events) do
						frame:RegisterEvent(event)
					end
				else
					for event in pairs(frame.events) do
						frame:UnregisterEvent(event)
					end
				end
			else
				local guid = UnitGUID("boss1")
				if guid then
					local NPC_ID = select(6, strsplit("-", UnitGUID("boss1")))
					local difficultyID = select(3, GetInstanceInfo())
					if frame.enable and NPC_ID == frame.npcID and (difficulty_id["all"] or difficulty_id[difficultyID]) then
						for event in pairs(frame.events) do
							frame:RegisterEvent(event)
						end
					end
				end
			end
		elseif event == "ENCOUNTER_START" then
			local encounterID, encounterName, difficultyID, groupSize = ...
			if frame.enable and encounterID == frame.engageID and (difficulty_id["all"] or difficulty_id[difficultyID]) then
				for event in pairs(frame.events) do
					frame:RegisterEvent(event)
				end
			end
		elseif event == "ENCOUNTER_END" then
			local encounterID, encounterName, difficultyID, groupSize = ...
			if encounterID == frame.engageID then
				for event in pairs(frame.events) do
					frame:UnregisterEvent(event)
				end
			end
		elseif event == "PLAYER_ENTERING_WORLD" then
			local map = select(8, GetInstanceInfo())
			if frame.enable and map == frame.mapID then
				for event in pairs(frame.events) do
					frame:RegisterEvent(event)
				end
			else
				for event in pairs(frame.events) do
					frame:UnregisterEvent(event)
				end
			end
		end
	end

	frame.update_onevent = function(self, event, ...)
		if event == "INIT" or event == "ENCOUNTER_START" or event == "ENCOUNTER_END" or event == "PLAYER_ENTERING_WORLD" then
			frame.encounter_check(event, ...)
		else
			frame.update(self, event, ...)
		end
	end
	
	frame:SetScript("OnEvent", function(self, event, ...)
		frame.update_onevent(self, event, ...)
	end)

	G.Texts[v] = frame
	
	T.Create_TextAlert_Options(option_page, difficulty_id, index, v, role)
end

----------------------------------------------------------
----------[[    Highlight Icon on Raid UF    ]]-----------
----------------------------------------------------------
local add_HL_holder = function(f)
	if f.hl_holder then return end
	
	f.hl_holder	= CreateFrame("Frame", nil, f)
	f.hl_holder:SetPoint(SoD_CDB["HL_Frame"]["position"], 0, 0)
	f.hl_holder:SetSize(10, 10)
	f.hl_holder:SetFrameStrata("HIGH")
	table.insert(G.HL_Holders, f.hl_holder)
	
	f.hl_holder.ActiveIcons = {}
	f.hl_holder.LineUpIcons = function()
		local lastframe
		for v, frame in T.pairsByKeys(f.hl_holder.ActiveIcons) do
			frame:ClearAllPoints()
			local anchor = SoD_CDB["HL_Frame"]["position"]
			if strfind(anchor, "LEFT") then
				if not lastframe then
					frame:SetPoint(anchor, f.hl_holder, anchor)
				else
					frame:SetPoint("LEFT", lastframe, "RIGHT", 3, 0)
				end
			elseif strfind(anchor, "RIGHT") then
				if not lastframe then
					frame:SetPoint(anchor, f.hl_holder, anchor)
				else
					frame:SetPoint("RIGHT", lastframe, "LEFT", -3, 0)
				end
			elseif not lastframe then
				local num = 0
				for k, j in pairs(f.hl_holder.ActiveIcons) do
					num = num + 1
				end
				local iconsize = SoD_CDB["HL_Frame"]["iconSize"]
				if anchor == "TOP" then
					frame:SetPoint("TOPLEFT", f.hl_holder, "TOP", -((iconsize+2)*num-2)/2,0)
				elseif anchor == "CENTER" then
					frame:SetPoint("LEFT", f.hl_holder, "CENTER", -((iconsize+2)*num-2)/2,0)
				elseif anchor == "BOTTOM" then
					frame:SetPoint("BOTTOMLEFT", f.hl_holder, "BOTTOM", -((iconsize+2)*num-2)/2,0)
				end			
			else
				frame:SetPoint("LEFT", lastframe, "RIGHT", 3, 0)
			end

			lastframe = frame
		end
	end

	f.hl_holder.QueueIcon = function(frame, tag)
		frame.v = tag
		
		frame.show = function(Glow)
			frame:Show()
			if Glow then
				ActionButton_ShowOverlayGlow(frame)
			end
		end
		
		frame.hide = function(Glow)
			if Glow then
				ActionButton_HideOverlayGlow(frame)
			end
			frame:Hide()
			frame:UnregisterAllEvents()
			frame:SetScript("OnEvent", nil)
			frame:SetScript("OnUpdate", nil)
		end
		
		frame:HookScript("OnShow", function()
			f.hl_holder.ActiveIcons[frame.v] = frame
			f.hl_holder.LineUpIcons()
		end)
		
		frame:HookScript("OnHide", function()
			f.hl_holder.ActiveIcons[frame.v] = nil
			f.hl_holder.LineUpIcons()
		end)
		
	end	
end

local add_Icon = function(f, v, target, sourceGUID, dur, stack)
	add_HL_holder(f)
	local tag = v..sourceGUID or ""

	if f.hl_holder.ActiveIcons[tag] then return end

	local type_str, ID_str, Glow, spellID	
	type_str, ID_str, Glow = strsplit("_" , v)
	spellID = tonumber(ID_str)
	
	local spellName, _, spellIcon = GetSpellInfo(spellID)
	
    local frame = CreateFrame("Frame", nil, f.hl_holder)	
	frame:SetSize(SoD_CDB["HL_Frame"]["iconSize"], SoD_CDB["HL_Frame"]["iconSize"])
	frame:SetAlpha(SoD_CDB["HL_Frame"]["iconAlpha"]/100)
	frame:Hide()
	f.hl_holder.QueueIcon(frame, tag)
	
	local count = T.createtext(frame, "ADD", 10, "OUTLINE", "LEFT")
    count:SetPoint("TOPLEFT", 5, -3)
	count:SetTextColor(1, .5, .8)
	frame.count = count
	
	local remaining = T.createtext(frame, "ADD", 10, "OUTLINE", "RIGHT")
    remaining:SetPoint("BOTTOMRIGHT", -5, 3)
    remaining:SetTextColor(1, 1, 0)
	frame.remaining = remaining
	
    local texture = frame:CreateTexture(nil,"HIGH")
    texture:SetTexture(spellIcon)
    texture:SetPoint("TOPLEFT", 4, -4)
	texture:SetPoint("BOTTOMRIGHT", -4, 4)
    texture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	
	local bgtex = frame:CreateTexture(nil,"BORDER")
    bgtex:SetTexture(G.media.blank)
	bgtex:SetVertexColor(1, 1, 1)
    bgtex:SetPoint("TOPLEFT", 3, -3)
	bgtex:SetPoint("BOTTOMRIGHT", -3, 3)
	frame.bgtex = bgtex
	
	local cooldown = CreateFrame("COOLDOWN", nil, frame, "CooldownFrameTemplate")
	cooldown:SetPoint("TOPLEFT", 2, -2)
	cooldown:SetPoint("BOTTOMRIGHT", -2, 2)
	cooldown:SetDrawEdge(false)
	cooldown:SetHideCountdownNumbers(true)
	cooldown:SetReverse(true)
	frame.cooldown = cooldown
	
    frame.updatedebuff = function(debuff_player, count, dtype, duration, expires)	
		color = DebuffTypeColor[dtype] or DebuffTypeColor.none
		frame.bgtex:SetVertexColor(color.r, color.g, color.b)
		
		if count then
			if count > 1 then
				frame.count:SetText(count)
			else
				frame.count:SetText("")
			end
			if stack then
				if count >= stack then
					T.GlowRaidFrame_Show(debuff_player, v)
				else
					T.GlowRaidFrame_Hide(debuff_player, v)
				end
			end
		end
		
		frame:SetScript("OnUpdate", function(self, elapsed)
			self.elapsed = (self.elapsed or 0) + elapsed
		
			if self.elapsed < .2 then return end
			self.elapsed = 0
		
			local timeLeft = expires - GetTime()
			if timeLeft <= 0 then
				remaining:SetText(nil)
			else
				remaining:SetText(T.FormatTime(timeLeft))
			end
		end)
	end
	
	frame.updatecast = function()	
		if not dur then	 -- 瞬发法术		
			frame.cooldown:SetCooldown(GetTime(), 2)
			
			C_Timer.After(2, function()
				frame.hide(Glow)
			end)		
		else -- 读条或引导法术
			cooldown:SetCooldown(GetTime(), dur)			
			C_Timer.After(dur, function()
				if frame:IsShown() then
					frame.hide(Glow)
				end
			end)   
			
			frame:RegisterEvent("UNIT_SPELLCAST_STOP")
			
			frame:SetScript("OnEvent", function(self, event, ...) 
				local Unit, _, SpellID = ...
				if SpellID == spellID and UnitGUID(Unit) == sourceGUID then
					frame.hide(Glow)
				end
			end)		
		end
	end
	
	if type_str == "HLAuras" then
		local name, icon, count, dtype, duration, expires  = AuraUtil.FindAuraByName(spellName, target, G.Test_Mod and "HELPFUL" or "HARMFUL")
		if not name then return end
		
		frame.updatedebuff(target, count, dtype, duration, expires)
		
		frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")	
		frame:SetScript("OnEvent", function(self, event, ...)
			if event == "COMBAT_LOG_EVENT_UNFILTERED" then
				local _, Event_type, _, _, _, _, _, _, DestName, _, _, SpellID = CombatLogGetCurrentEventInfo()
				if SpellID == spellID and DestName then
					if Event_type == "SPELL_AURA_APPLIED_DOSE" or Event_type == "SPELL_AURA_REMOVED_DOSE" or Event_type == "SPELL_AURA_REFRESH" then
						local Tar = string.split("-", DestName)
						if Tar == target then
							local name, icon, count, dtype, duration, expires = AuraUtil.FindAuraByName(spellName, target, G.Test_Mod and "HELPFUL" or "HARMFUL")
							
							if name then
								frame.updatedebuff(Tar, count, dtype, duration, expires)
							else
								frame.hide(Glow)
								if stack then
									T.GlowRaidFrame_Hide(Tar, v)
								end
							end
						end
					elseif Event_type == "SPELL_AURA_REMOVED" then
						local Tar = string.split("-", DestName)
						if Tar == target then
							frame.hide(Glow)
							if stack then
								T.GlowRaidFrame_Hide(Tar, v)
							end
						end
					end
				end
			end
		end)
		
		frame.show(Glow)
		
	elseif type_str == "HLCast" then
		frame.updatecast()
		frame.show(Glow)
	end
end

T.EditHL = function()
	for _, holder in pairs(G.HL_Holders) do
		holder:ClearAllPoints()
		holder:SetPoint(SoD_CDB["HL_Frame"]["position"], 0, 0)
	end
end

T.HL_OnRaid = function(v, target, sourceGUID, dur, stack)
	
	local type_str = strsplit("_" , v)
	if SoD_CDB["General"]["disable_all"] or not SoD_CDB["HL_Frame"]["enable"] or not SoD_CDB[type_str][v] then return end

    local hasGrid = IsAddOnLoaded("Grid")
    local hasGrid2 = IsAddOnLoaded("Grid2")
    local hasCompactRaid = IsAddOnLoaded("CompactRaid")
    local hasVuhDo = IsAddOnLoaded("VuhDo")
    local hasElvUI = _G["ElvUF_Raid"] and _G["ElvUF_Raid"]:IsVisible()
    local hasAltzUI = _G["Altz_HealerRaid"] and _G["Altz_HealerRaid"]:IsVisible()
    local hasNDui = IsAddOnLoaded("NDui")
	
    if hasElvUI then
        for i=1, 8 do
            for j=1, 5 do
                local f = _G["ElvUF_RaidGroup"..i.."UnitButton"..j]
                if f and f.unit and UnitName(f.unit) == target then
                    add_Icon(f, v, target, sourceGUID, dur, stack)
                    return
                end
            end
        end
    elseif hasGrid then
        local layout = GridLayoutFrame
        
        if layout then
            local children = {layout:GetChildren()}
            for _, child in ipairs(children) do
                if child:IsVisible() then
                    local frames = {child:GetChildren()}
                    for _, f in ipairs(frames) do
                        if f.unit and UnitName(f.unit) == target then
                            add_Icon(f, v, target, sourceGUID, dur, stack)
                            return
                        end
                    end
                end
            end
        end
    elseif hasGrid2 then
        local layout = Grid2LayoutFrame
        
        if layout then
            local children = {layout:GetChildren()}
            for _, child in ipairs(children) do
                if child:IsVisible() then
                    local frames = {child:GetChildren()}
                    for _, f in ipairs(frames) do
                        if f.unit and UnitName(f.unit) == target then
                            add_Icon(f, v, target, sourceGUID, dur, stack)
                            return
                        end
                    end
                end
            end
        end
    elseif hasVuhDo then
        for i = 1, 40 do
            local f = _G["Vd1H"..i]
            if f and f.raidid and UnitName(f.raidid) == target then
                add_Icon(f, v, target, sourceGUID, dur, stack)
                return
            end
        end
    elseif hasAltzUI then
		if aCoreCDB["UnitframeOptions"]["ind_party"] then -- 小队相连
			for i = 1, 40 do
				local f = _G["Altz_HealerRaidUnitButton"..i]
				if f and f.unit and UnitName(f.unit) == target then
					add_Icon(f, v, target, sourceGUID, dur, stack)
					return
				end
			end
		else
			for i = 1, 8 do
				for j = 1, 5 do
					if i == 1 then
						local f = _G["Altz_HealerRaidUnitButton"..j]
						if f and f.unit and UnitName(f.unit) == target then
							add_Icon(f, v, target, sourceGUID, dur, stack)
							return
						end
					else
						local f = _G["Altz_HealerRaid"..i.."UnitButton"..j]
						if f and f.unit and UnitName(f.unit) == target then
							add_Icon(f, v, target, sourceGUID, dur, stack)
							return
						end
					end
				end
			end
		end
	elseif hasNDui then
		for i =1, 8 do 
            for j = 1, 5 do
                local f = _G["oUF_Raid"..i.."UnitButton"..j]
                if f and f.unit and UnitName(f.unit) == target then
                    add_Icon(f, v, target, sourceGUID, dur, stack)
                    return
                end
            end
        end
    elseif hasCompactRaid then
        for i =1, 8 do 
            for j = 1, 5 do
                local f = _G["CompactRaidGroupHeaderSubGroup"..i.."UnitButton"..j]
                if f and f.unit and UnitName(f.unit) == target then
                    add_Icon(f, v, target, sourceGUID, dur, stack)
                    return
                end
            end
        end
    else
        for i=1, 40 do
            local f = _G["CompactRaidFrame"..i]
            if f and f.unitExists and f.unit and UnitName(f.unit) == target then
                add_Icon(f, v, target, sourceGUID, dur, stack)
                return
            end
        end
        for i=1, 4 do
            for j=1, 5 do
                local f = _G["CompactRaidGroup"..i.."Member"..j]
                if f and f.unitExists and f.unit and UnitName(f.unit) == target then
                    add_Icon(f, v, target, sourceGUID, dur, stack)
                    return
                end
            end
        end
    end
	
end

T.Create_HL_EventFrame = function(parent, difficulty_id, index, v, role, stack)
	local frame = CreateFrame("Frame", addon_name.."HL_EventFrame"..v, FrameHolder)
	
	local type_str, ID_str, Glow, spellID	
	type_str, ID_str, Glow = strsplit("_" , v)
	spellID = tonumber(ID_str)
	
	if type(index) == "string" then
		frame.mapID = G.Encounters[index]["map_id"]
	else
		local boss_index = tonumber(index)
		frame.npcID = G.Encounters[boss_index]["npc_id"]
		frame.engageID = G.Encounters[boss_index]["engage_id"]
		frame:RegisterEvent("ENCOUNTER_START")
		frame:RegisterEvent("ENCOUNTER_END")
	end
	frame:RegisterEvent("PLAYER_ENTERING_WORLD")
	
	frame.encounter_check = function(event, ...)
		if event == "ENCOUNTER_START" then
			local encounterID, encounterName, difficultyID, groupSize = ...
			if encounterID == frame.engageID and (difficulty_id["all"] or difficulty_id[difficultyID]) then
				return true
			end
		elseif event == "ENCOUNTER_END" then
			T.GlowRaidFrame_HideAll() -- 隐藏所有高亮
			return false
		elseif event == "PLAYER_ENTERING_WORLD" then	
			if type(index) == "string" then
				local map = select(8, GetInstanceInfo())
				if map == frame.mapID then
					return true
				end
			else
				local guid = UnitGUID("boss1")
				if guid then
					local NPC_ID = select(6, strsplit("-", UnitGUID("boss1")))
					local difficultyID = select(3, GetInstanceInfo())
					if NPC_ID == frame.npcID and (difficulty_id["all"] or difficulty_id[difficultyID]) then
						return true
					end
				end
			end
		end
	end
	
	if type_str == "HLAuras" then
		frame:SetScript("OnEvent", function(self, e, ...)
			if e == "PLAYER_ENTERING_WORLD" or e == "ENCOUNTER_START" or e == "ENCOUNTER_END" then
				if frame.encounter_check(e, ...) then
					frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
				else
					frame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
				end
			else
				local _, Event_type, _, sourceGUID, _, _, _, _, DestName, _, _, SpellID = CombatLogGetCurrentEventInfo()
				if SpellID == spellID and Event_type == "SPELL_AURA_APPLIED" and DestName then
					local target = string.split("-", DestName)
					T.HL_OnRaid(v, target, sourceGUID, nil, stack)
				end
			end
		end)
	elseif type_str == "HLCast" then
		frame:SetScript("OnEvent", function(self, e, ...)
			if e == "PLAYER_ENTERING_WORLD" or e == "ENCOUNTER_START" or e == "ENCOUNTER_END" then
				if frame.encounter_check(e, ...) then
					frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
					frame:RegisterEvent("UNIT_SPELLCAST_START")
					frame:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START")
					frame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
				else
					frame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
					frame:UnregisterEvent("UNIT_SPELLCAST_START")
					frame:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_START")
					frame:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED")
				end
			else
				local Unit, _, SpellID = ...
				if SpellID == spellID then				
					local cast_time = select(4, GetSpellInfo(SpellID))/1000 -- 施法时间
					if not UnitChannelInfo(Unit) and cast_time == 0 then -- 瞬发法术
						if e == "UNIT_SPELLCAST_SUCCEEDED" then 
							C_Timer.After(.1, function()
								local target = UnitName(Unit.."target")
								if target then
									local sourceGUID = UnitGUID(Unit)
									T.HL_OnRaid(v, target, sourceGUID)
								end
							end)			
						end
					else -- 读条法术
						if e == "UNIT_SPELLCAST_START" then
							C_Timer.After(.1, function()
								local target = UnitName(Unit.."target")
								if target then
									local sourceGUID = UnitGUID(Unit)
									T.HL_OnRaid(v, target, sourceGUID, cast_time)
								end
							end)						
						elseif e =="UNIT_SPELLCAST_CHANNEL_START" then -- 引导法术
							local endTimeMS = select(5, UnitChannelInfo(Unit))
							if endTimeMS then							
								C_Timer.After(.1, function()
									local target = UnitName(Unit.."target")
									if target then
										local sourceGUID = UnitGUID(Unit)
										T.HL_OnRaid(v, target, sourceGUID, endTimeMS/1000 - GetTime())
									end
								end)
							end
						end
					end
				end
			end
		end)
	end
	
	T.Create_HLOnRaid_Options(parent, difficulty_id, v, role, stack)
	
end
----------------------------------------------------------
---------------[[    Nameplate Icons    ]]----------------
----------------------------------------------------------
local function CreateIcon(parent, tag)
	local button = CreateFrame("Frame", nil, parent)
	button:SetSize(SoD_CDB["PlateAlerts"]["size"], SoD_CDB["PlateAlerts"]["size"])
	
	button.icon = button:CreateTexture(nil, "OVERLAY", nil, 3)
	button.icon:SetPoint("TOPLEFT",button,"TOPLEFT", 1, -1)
	button.icon:SetPoint("BOTTOMRIGHT",button,"BOTTOMRIGHT",-1, 1)
	button.icon:SetTexCoord(.08, .92, 0.08, 0.92)
	
	button.overlay = button:CreateTexture(nil, "ARTWORK", nil, 7)
	button.overlay:SetTexture("Interface\\Buttons\\WHITE8x8")
	button.overlay:SetAllPoints(button)	
	
	button.bd = button:CreateTexture(nil, "ARTWORK", nil, 6)
	button.bd:SetTexture("Interface\\Buttons\\WHITE8x8")
	button.bd:SetVertexColor(0, 0, 0)
	button.bd:SetPoint("TOPLEFT",button,"TOPLEFT", -1, 1)
	button.bd:SetPoint("BOTTOMRIGHT",button,"BOTTOMRIGHT", 1, -1)
	
	if strfind(tag, "spells") then
		button.cd_frame = CreateFrame("COOLDOWN", nil, button, "CooldownFrameTemplate")
		button.cd_frame:SetPoint("TOPLEFT", 1, -1)
		button.cd_frame:SetPoint("BOTTOMRIGHT", -1, 1)
		button.cd_frame:SetDrawEdge(false)
		button.cd_frame:SetAlpha(.7)
		
		button.cd_frame:SetScript("OnShow", function()
			button.icon:SetDesaturated(true)
		end)
		button.cd_frame:SetScript("OnHide", function()
			button.icon:SetDesaturated(false)
		end)
		
		button.cast = CreateFrame("Frame", nil, button)
		button.cast:SetAllPoints()
		button.cast:Hide()
		
		button.cast.icon = button.cast:CreateTexture(nil, "OVERLAY", nil, 3)
		button.cast.icon:SetPoint("TOPLEFT",button.cast,"TOPLEFT", 1, -1)
		button.cast.icon:SetPoint("BOTTOMRIGHT",button.cast,"BOTTOMRIGHT",-1, 1)
		button.cast.icon:SetTexCoord(.08, .92, 0.08, 0.92)
		
		button.cast.overlay = button.cast:CreateTexture(nil, "ARTWORK", nil, 7)
		button.cast.overlay:SetTexture("Interface\\Buttons\\WHITE8x8")
		button.cast.overlay:SetAllPoints()	
		button.cast.overlay:SetVertexColor(1, 1, 0)
		
		button.cast.spell = T.createtext(button.cast, "OVERLAY", SoD_CDB["PlateAlerts"]["fsize"], "OUTLINE", "CENTER") -- 中间
		button.cast.spell:SetPoint("TOPLEFT", button.cast, "TOPLEFT", -5, 1)
		button.cast.spell:SetPoint("TOPRIGHT", button.cast, "TOPRIGHT", 5, 1)
		button.cast.spell:SetTextColor(1, 1, 0)
		button.cast.spell:SetHeight(SoD_CDB["PlateAlerts"]["fsize"])
		
		button.cast.target = T.createtext(button.cast, "OVERLAY", SoD_CDB["PlateAlerts"]["fsize"], "OUTLINE", "CENTER") -- 中间
		button.cast.target:SetPoint("BOTTOMLEFT", button.cast, "BOTTOMLEFT", -5, -1)
		button.cast.target:SetPoint("BOTTOMRIGHT", button.cast, "BOTTOMRIGHT", 5, -1)
		button.cast.target:SetHeight(SoD_CDB["PlateAlerts"]["fsize"]*2.5)
		
		button.cast.dur = T.createtext(button.cast, "OVERLAY", SoD_CDB["PlateAlerts"]["fsize"], "OUTLINE", "CENTER") -- 中间
		button.cast.dur:SetPoint("TOP", button.cast, "BOTTOM", 0, -2)
		
		button.cast.t = 0	
	end
	
	if strfind(tag, "aura") then
		button.text = T.createtext(button, "OVERLAY", SoD_CDB["PlateAlerts"]["fsize"], "OUTLINE", "CENTER") -- 中间
		button.text:SetPoint("BOTTOM", button, "BOTTOM", 0, -2)
		button.text:SetTextColor(1, 1, 0)
	end
	
	if strfind(tag, "aura") or strfind(tag, "power") then
		button.count = T.createtext(button, "OVERLAY", SoD_CDB["PlateAlerts"]["fsize"], "OUTLINE", "RIGHT") -- 右上
		button.count:SetPoint("TOPRIGHT", button, "TOPRIGHT", -1, 2)
		button.count:SetTextColor(.4, .95, 1)
	end
	
	if strfind(tag, "source") then
		button.glow = button:CreateTexture(nil, "OVERLAY")
		button.glow:SetPoint("TOPLEFT", -10, 10)
		button.glow:SetPoint("BOTTOMRIGHT", 10, -10)
		button.glow:SetTexture([[Interface\SpellActivationOverlay\IconAlert]])
		button.glow:SetTexCoord(0.00781250, 0.50781250, 0.27734375, 0.52734375)
	end
	
	button:Hide()
	parent.QueueIcon(button, tag)
	
	return button
end

local function UpdateNPC_Highlight(unit, alert_type, tag)
	if SoD_CDB["General"]["disable_all"] or not (unit and SoD_CDB["PlateAlerts"]["enable"]) then return end
	local frame = LGF.GetUnitNameplate(unit)
	if frame then
		if IsAddOnLoaded("TidyPlates") and TidyPlatesOptions["ActiveTheme"] == "Neon" and not frame.anchor_frame then
			frame.anchor_frame = CreateFrame("Frame", nil, frame)
			local width, height = frame:GetSize()
			frame.anchor_frame:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, -10)
			frame.anchor_frame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 10)
		end
		if alert_type == "PlateNpcID" then
			local npcID = select(6, strsplit("-", UnitGUID(unit)))
			if npcID and G.Plate_Alerts[alert_type][npcID] and SoD_CDB["PlateNpcID"][npcID] then
				LCG.PixelGlow_Start(frame.anchor_frame or frame, G.Plate_Alerts[alert_type][npcID]["color"], 12, .25, nil, 3, 3, 3, true, "npc")
			else
				LCG.PixelGlow_Stop(frame.anchor_frame or frame, "npc")
			end
		elseif alert_type == "PlayerAuraSource" then
			if tag and G.Plate_Alerts[alert_type][tag] then
				LCG.PixelGlow_Start(frame.anchor_frame or frame, G.Plate_Alerts[alert_type][tag]["color"], 12, .25, nil, 3, 3, 3, true, "sourceaura")
			else
				LCG.PixelGlow_Stop(frame.anchor_frame or frame, "sourceaura")
			end
		elseif alert_type == "PlateAuras" then
			if tag and G.Plate_Alerts[alert_type][tag] then
				LCG.PixelGlow_Start(frame.anchor_frame or frame, G.Plate_Alerts[alert_type][tag]["color"], 12, .25, nil, 3, 3, 3, true, "aura")
			else
				LCG.PixelGlow_Stop(frame.anchor_frame or frame, "aura")
			end
		elseif alert_type == "PlateSpells" then
			if tag and G.Plate_Alerts[alert_type][tag] then
				LCG.PixelGlow_Start(frame.anchor_frame or frame, G.Plate_Alerts[alert_type][tag]["color"], 12, .25, nil, 3, 3, 3, true, "spell")
			else
				LCG.PixelGlow_Stop(frame.anchor_frame or frame, "spell")
			end
		end
	end
end

local function CreateSpellIcon(button, spellID, cd)
	local spell_name, _, icon = GetSpellInfo(spellID)
	button.icon:SetTexture(icon)
	button.cast.icon:SetTexture(icon)
	button.cast.spell:SetText(spell_name)
	button.spellID = spellID
	button.cd = cd
end

local function UpdateSpellIcon(event, button, unit, spellID)
	if event == "UNIT_SPELLCAST_START" then
		local _, _, _, startTimeMS, endTimeMS, _, _, notInterruptible, casting_spellID = UnitCastingInfo(unit)
		if casting_spellID == spellID then
						
			if notInterruptible then
				button.cast.overlay:SetVertexColor(1, 0, 0)
			else
				button.cast.overlay:SetVertexColor(0, 1, 1)
			end
			
			button.cast.exp = endTimeMS/1000
			button.cast:SetScript("OnUpdate", function(self, e)
				self.t = self.t + e
				if self.t > .1 then
					local remain = self.exp - GetTime()
					if remain > 0 then
						if UnitName(unit.."target") then
							self.target:SetText(T.ColorUnitName(unit.."target", UnitName(unit.."target"), true))
						else
							self.target:SetText("")
						end
						self.dur:SetText(T.FormatTime(remain))
					else				
						self:SetScript("OnUpdate", nil)
						self.target:SetText("")
						self:Hide()
						if button.cd == 1 then
							button:Hide()
						end		
						if G.Plate_Alerts["PlateSpells"][spellID]["hl_np"] then
							UpdateNPC_Highlight(unit, "PlateSpells")
						end
					end
					self.t = 0
				end
			end)
			
			button.cast:Show()
			if button.cd == 1 then
				button:Show()
			else
				button.cd_frame:SetCooldown(0, 0)
			end
			if G.Plate_Alerts["PlateSpells"][spellID]["hl_np"] then
				UpdateNPC_Highlight(unit, "PlateSpells", spellID)
			end
		end
	elseif event == "UNIT_SPELLCAST_CHANNEL_START" then
		local _, _, _, startTimeMS, endTimeMS, _, notInterruptible, channel_spellID = UnitChannelInfo(unit)
		if channel_spellID == spellID then
			
			if notInterruptible then
				button.cast.overlay:SetVertexColor(1, 0, 0)
			else
				button.cast.overlay:SetVertexColor(0, 1, 1)
			end

			button.cast.exp = endTimeMS/1000
			button.cast:SetScript("OnUpdate", function(self, e)
				self.t = self.t + e
				if self.t > .1 then
					local remain = self.exp - GetTime()
					if remain > 0 then
						if UnitName(unit.."target") then
							self.target:SetText(T.ColorUnitName(unit.."target", UnitName(unit.."target"), true))
						else
							self.target:SetText("")
						end
						self.dur:SetText(T.FormatTime(remain))
					else
						self:SetScript("OnUpdate", nil)
						self.target:SetText("")
						self:Hide()
						if button.cd == 1 then
							button:Hide()
						end
						if G.Plate_Alerts["PlateSpells"][spellID]["hl_np"] then
							UpdateNPC_Highlight(unit, "PlateSpells")
						end
					end
					self.t = 0
				end
			end)
				
			button.cast:Show()
			
			if button.cd == 1 then
				button:Show()
			else
				button.cd_frame:SetCooldown(0, 0)
			end
			if G.Plate_Alerts["PlateSpells"][spellID]["hl_np"] then
				UpdateNPC_Highlight(unit, "PlateSpells", spellID)
			end
		end
	elseif event == "UNIT_SPELLCAST_CHANNEL_UPDATE" then
		local _, _, _, startTimeMS, endTimeMS, _, notInterruptible, channel_spellID = UnitChannelInfo(unit)
		if channel_spellID == spellID then		
			if notInterruptible then
				button.cast.overlay:SetVertexColor(1, 0, 0)
			else
				button.cast.overlay:SetVertexColor(0, 1, 1)
			end

			button.cast.exp = endTimeMS/1000		
		end		
	elseif event == "UNIT_SPELLCAST_SUCCEEDED" then -- 施法成功才开始计算CD
		if button.cd > 1 then
			button.cd_frame:SetCooldown(GetTime(), button.cd)
		end
	elseif not (UnitCastingInfo(unit) or UnitChannelInfo(unit)) then
		button.cast:SetScript("OnUpdate", nil)
		button.cast.target:SetText("")
		button.cast:Hide()
		if button.cd == 1 then
			button:Hide()
		end
		if G.Plate_Alerts["PlateSpells"][spellID]["hl_np"] then
			UpdateNPC_Highlight(unit, "PlateSpells")
		end
	end
end

local function UpdateSpells(unitFrame, event, unit, ...)
	if SoD_CDB["General"]["disable_all"] or not SoD_CDB["PlateAlerts"]["enable"] then return end
	
	if event == "ALL" then -- 单位刷新类事件	
		if unit then -- 检查此单位需要监控的技能cd
			if G.Npc[unitFrame.npcID] then
				for event, v in pairs(CastingEvents) do
					unitFrame:RegisterUnitEvent(event, unit)
				end
				local i = 1
				for spellID, cd in pairs(G.Npc[unitFrame.npcID]) do
					if not unitFrame.icons.Spell_Icons[i] then
						unitFrame.icons.Spell_Icons[i] = CreateIcon(unitFrame.icons, "spells"..i)
					end
					CreateSpellIcon(unitFrame.icons.Spell_Icons[i], spellID, cd)
					if cd ~= 1 then
						unitFrame.icons.Spell_Icons[i]:Show()
					end
					i = i + 1
				end
				
				for index = i, #unitFrame.icons.Spell_Icons do -- 隐藏多余的button
					unitFrame.icons.Spell_Icons[index]:Hide()
					unitFrame.icons.Spell_Icons[index].spellID = nil
					unitFrame.icons.Spell_Icons[index].cd = nil
				end
			else
				for event, v in pairs(CastingEvents) do
					unitFrame:UnregisterEvent(event)
				end
				for _, button in pairs(unitFrame.icons.Spell_Icons) do
					button:Hide()
					button.spellID = nil
					button.cd = nil
				end
			end
		else
			for event, v in pairs(CastingEvents) do
				unitFrame:UnregisterEvent(event)
			end		
			for _, button in pairs(unitFrame.icons.Spell_Icons) do
				button:Hide()
				button.spellID = nil
				button.cd = nil
			end
		end
	else -- 施法类事件
		local guid, event_spellID = ...
		if G.Plate_Alerts["PlateSpells"][event_spellID] and SoD_CDB["PlateSpells"][event_spellID] then
			for _, button in pairs(unitFrame.icons.Spell_Icons) do
				if button.spellID == event_spellID and unit == unitFrame.unit then
					UpdateSpellIcon(event, button, unit, event_spellID)	
				end
			end		
		end
	end
end

local function UpdateAuraIcon(button, unit, index, filter)
	local name, icon, count, debuffType, duration, expirationTime, _, _, _, spellID = UnitAura(unit, index, filter)

	button.icon:SetTexture(icon)
	button.expirationTime = expirationTime
	button.duration = duration
	button.spellID = spellID
	
	local color = DebuffTypeColor[debuffType] or DebuffTypeColor.none
	button.overlay:SetVertexColor(color.r, color.g, color.b)

	if count and count > 1 then
		button.count:SetText(count)
	else
		button.count:SetText("")
	end
	
	button:SetScript("OnUpdate", function(self, elapsed)
		if not self.duration then return end
		
		self.elapsed = (self.elapsed or 0) + elapsed

		if self.elapsed < .2 then return end
		self.elapsed = 0

		local timeLeft = self.expirationTime - GetTime()
		if timeLeft <= 0 then
			self.text:SetText(nil)
		else
			self.text:SetText(T.FormatTime(timeLeft))
		end
	end)
	
	button:Show()
end

local function UpdateAuras(unitFrame)
	if not unitFrame or not unitFrame.unit then
		for index = 1, #unitFrame.icons.Aura_Icons do unitFrame.icons.Aura_Icons[index]:Hide() end
		return
	end
	
	if SoD_CDB["General"]["disable_all"] or not SoD_CDB["PlateAlerts"]["enable"] then return end
	local unit = unitFrame.unit	
	local i = 1
	local last_match
	
	for index = 1, 20 do
		if i <= 5 then			
			local bname, _, _, _, bduration, _, bcaster, _, _, bspellid = UnitAura(unit, index, 'HELPFUL')
			if bname and ((SoD_CDB["PlateAuras"][bspellid] and G.Plate_Alerts["PlateAuras"][bspellid]) or G.Plate_AurabyBossMod[bspellid]) then
				if not unitFrame.icons.Aura_Icons[i] then
					unitFrame.icons.Aura_Icons[i] = CreateIcon(unitFrame.icons, "aura"..i)
				end
				UpdateAuraIcon(unitFrame.icons.Aura_Icons[i], unit, index, 'HELPFUL')
				if G.Plate_Alerts["PlateAuras"][bspellid] and G.Plate_Alerts["PlateAuras"][bspellid]["hl_np"] then
					last_match = bspellid
				end
				i = i + 1
			end
		end
	end
	
	for index = 1, 20 do
		if i <= 5 then
			local dname, _, _, _, dduration, _, dcaster, _, _, dspellid = UnitAura(unit, index, 'HARMFUL')	
			if dname and ((SoD_CDB["PlateAuras"][dspellid] and G.Plate_Alerts["PlateAuras"][dspellid]) or G.Plate_AurabyBossMod[dspellid] ) then
				if not unitFrame.icons.Aura_Icons[i] then
					unitFrame.icons.Aura_Icons[i] = CreateIcon(unitFrame.icons, "aura"..i)
				end
				UpdateAuraIcon(unitFrame.icons.Aura_Icons[i], unit, index, 'HARMFUL')
				if G.Plate_Alerts["PlateAuras"][dspellid] and G.Plate_Alerts["PlateAuras"][dspellid]["hl_np"] then
					last_match = dspellid
				end
				i = i + 1
			end
		end
	end
	
	for index = i, #unitFrame.icons.Aura_Icons do unitFrame.icons.Aura_Icons[index]:Hide() end

	UpdateNPC_Highlight(unitFrame.unit, "PlateAuras", last_match)
end
G.UpdateAuras = UpdateAuras

local function UpdateSourceAuraIcon(button, name, icon, count, debuffType, duration, expirationTime)
	button.icon:SetTexture(icon)
	button.expirationTime = expirationTime
	button.duration = duration
	button.aura = name
	
	local color = DebuffTypeColor[debuffType] or DebuffTypeColor.none
	button.overlay:SetVertexColor(color.r, color.g, color.b)

	if count and count > 1 then
		button.count:SetText(count)
	else
		button.count:SetText("")
	end
	
	button:SetScript("OnUpdate", function(self, elapsed)
		if not self.duration then return end
	
		self.elapsed = (self.elapsed or 0) + elapsed

		if self.elapsed < .2 then return end
		self.elapsed = 0

		local timeLeft = self.expirationTime - GetTime()
		if timeLeft <= 0 then
			self.text:SetText(nil)		
		else
			self.text:SetText(T.FormatTime(timeLeft))
		end
	end)
	
	button:Show()
end

local function UpdateSourceAuras(unitFrame)
	if not unitFrame.unit then
		for index = 1, #unitFrame.icons.SourceAura_Icons do unitFrame.icons.SourceAura_Icons[index]:Hide() end
		return
	end
	
	if SoD_CDB["General"]["disable_all"] or not SoD_CDB["PlateAlerts"]["enable"] then return end	
	local i = 1
	local last_match
	
	for index = 1, 10 do
		if i <= 5 then
			local name, icon, count, debuffType, duration, expirationTime, source, isStealable, nameplateShowPersonal, dspellid = UnitDebuff("player", index)
			if name and SoD_CDB["PlayerAuraSource"][dspellid] and G.Plate_Alerts["PlayerAuraSource"][dspellid] then -- 有需要找到来源的debuff				
				if source and UnitIsUnit(source, unitFrame.unit) then
					if not unitFrame.icons.SourceAura_Icons[i] then
						unitFrame.icons.SourceAura_Icons[i] = CreateIcon(unitFrame.icons, "source_aura"..i)
					end
					UpdateSourceAuraIcon(unitFrame.icons.SourceAura_Icons[i], name, icon, count, debuffType, duration, expirationTime)
					last_match = dspellid
					i = i + 1
				end
			end
		end
	end
	
	for index = i, #unitFrame.icons.SourceAura_Icons do unitFrame.icons.SourceAura_Icons[index]:Hide() end
	
	UpdateNPC_Highlight(unitFrame.unit, "PlayerAuraSource", last_match)
end

local function UpdatePower(unitFrame)
	if not unitFrame.unit or not G.Plate_Alerts["PlatePower"][unitFrame.npcID] or SoD_CDB["General"]["disable_all"] or not SoD_CDB["PlateAlerts"]["enable"] or not SoD_CDB["PlatePower"][unitFrame.npcID] then
		if unitFrame.icons.powericon and unitFrame.icons.powericon:IsShown() then
			unitFrame.icons.powericon:Hide()
		end
		return
	end
	
	local unit = unitFrame.unit
	local pp = UnitPower(unit)
	
	if not unitFrame.icons.powericon then
		unitFrame.icons.powericon = CreateIcon(unitFrame.icons, "power")
	end
	
	if pp > 85 then
		unitFrame.icons.powericon.icon:SetTexture(531771)
	elseif pp > 45 then
		unitFrame.icons.powericon.icon:SetTexture(531773)
	else
		unitFrame.icons.powericon.icon:SetTexture(531776)
	end
	unitFrame.icons.powericon.count:SetText(pp)
	unitFrame.icons.powericon:Show()
end

local function NamePlate_OnEvent(self, event, arg1, ...)
	if event == "UNIT_AURA" and arg1 == self.unit then
		UpdateAuras(self)
	elseif event == "UNIT_POWER_UPDATE" and arg1 == self.unit then
		UpdatePower(self)
	elseif CastingEvents[event] and arg1 == self.unit then		
		UpdateSpells(self, event, arg1, ...)
	elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local _, Event_type, _, _, _, _, _, _, DestName = CombatLogGetCurrentEventInfo()
		if strfind(Event_type, "AURA") and DestName == G.PlayerName then
			UpdateSourceAuras(self)
		end
	end
end

local function SetUnit(unitFrame, unit)
	unitFrame.unit = unit
	if unit then
		unitFrame:RegisterUnitEvent("UNIT_AURA", unitFrame.unit)
		unitFrame:RegisterUnitEvent("UNIT_POWER_UPDATE", unitFrame.unit)
		unitFrame:RegisterUnitEvent("COMBAT_LOG_EVENT_UNFILTERED")
		unitFrame:SetScript("OnEvent", NamePlate_OnEvent)
		unitFrame.npcID = select(6, strsplit("-", UnitGUID(unit)))
	else
		unitFrame:UnregisterAllEvents()
		unitFrame:SetScript("OnEvent", nil)
		unitFrame.npcID = nil	
	end
end

local function NamePlates_UpdateAllNamePlates()
	for i, namePlate in ipairs(C_NamePlate.GetNamePlates()) do
		local unitFrame = namePlate.soduf
		UpdateAuras(unitFrame)
		UpdateSourceAuras(unitFrame)
		UpdatePower(unitFrame)
		UpdateSpells(unitFrame, "ALL", unitFrame.unit)
		UpdateNPC_Highlight(unitFrame.unit, "PlateNpcID")
	end
end

local function OnNamePlateCreated(namePlate)
	namePlate.soduf = CreateFrame("Button", "$parent_SOD_UnitFrame", namePlate)
	namePlate.soduf:SetSize(1,1)
	namePlate.soduf:SetPoint("BOTTOM", namePlate, "TOP", 0, SoD_CDB["PlateAlerts"]["y"])
	namePlate.soduf:SetFrameLevel(namePlate:GetFrameLevel())
	
	namePlate.soduf.icons = CreateFrame("Frame", nil, namePlate.soduf)
	namePlate.soduf.icons:SetAllPoints(namePlate.soduf)
	namePlate.soduf.icons:SetFrameLevel(namePlate:GetFrameLevel()+1)

	namePlate.soduf.icons.Aura_Icons = {}
	namePlate.soduf.icons.SourceAura_Icons = {}
	namePlate.soduf.icons.Spell_Icons = {}	
	
	namePlate.soduf.icons.ActiveIcons = {}
	namePlate.soduf.icons.LineUpIcons = function()
		local lastframe
		for v, frame in T.pairsByKeys(namePlate.soduf.icons.ActiveIcons) do
			frame:ClearAllPoints()
			if not lastframe then
				local num = 0
				for k, j in pairs(namePlate.soduf.icons.ActiveIcons) do
					num = num + 1
				end
				frame:SetPoint("LEFT", namePlate.soduf.icons, "CENTER", -((SoD_CDB["PlateAlerts"]["size"]+4)*num-4)/2,0)
			else
				frame:SetPoint("LEFT", lastframe, "RIGHT", 3, 0)
			end

			lastframe = frame
		end
	end
	
	namePlate.soduf.icons.QueueIcon = function(frame, tag)
		frame.v = tag
		
		frame:HookScript("OnShow", function()
			namePlate.soduf.icons.ActiveIcons[frame.v] = frame
			namePlate.soduf.icons.LineUpIcons()
		end)
		
		frame:HookScript("OnHide", function()
			namePlate.soduf.icons.ActiveIcons[frame.v] = nil
			namePlate.soduf.icons.LineUpIcons()
		end)
	end
	
	table.insert(G.Plate_IconHolders, namePlate.soduf.icons)
	
	namePlate.soduf:EnableMouse(false)
end

local function OnNamePlateAdded(unit)
	local namePlate = C_NamePlate.GetNamePlateForUnit(unit)
	local unitFrame = namePlate.soduf
	SetUnit(unitFrame, unit)
	UpdateAuras(unitFrame)
	UpdateSourceAuras(unitFrame)
	UpdatePower(unitFrame)
	UpdateSpells(unitFrame, "ALL", unitFrame.unit)
	UpdateNPC_Highlight(unit, "PlateNpcID")
end

local function OnNamePlateRemoved(unit)
	local namePlate = C_NamePlate.GetNamePlateForUnit(unit)
	local unitFrame = namePlate.soduf
	SetUnit(unitFrame)
	UpdateAuras(unitFrame)
	UpdateSourceAuras(unitFrame)
	UpdatePower(unitFrame)
	UpdateSpells(unitFrame, "ALL", unitFrame.unit)
	UpdateNPC_Highlight(unit, "PlateNpcID")
	UpdateNPC_Highlight(unit, "PlateSpells")
end

local function NamePlates_OnEvent(self, event, ...) 
	if ( event == "VARIABLES_LOADED" ) then
		NamePlates_UpdateAllNamePlates()
	elseif ( event == "NAME_PLATE_CREATED" ) then
		local namePlate = ...
		OnNamePlateCreated(namePlate)
	elseif ( event == "NAME_PLATE_UNIT_ADDED" ) then 
		local unit = ...
		OnNamePlateAdded(unit)
	elseif ( event == "NAME_PLATE_UNIT_REMOVED" ) then 
		local unit = ...
		OnNamePlateRemoved(unit)
	end
end

local NamePlatesFrame = CreateFrame("Frame", G.addon_name.."NamePlatesFrame", UIParent) 
NamePlatesFrame:SetScript("OnEvent", NamePlates_OnEvent)
NamePlatesFrame:RegisterEvent("VARIABLES_LOADED")
NamePlatesFrame:RegisterEvent("NAME_PLATE_CREATED")
NamePlatesFrame:RegisterEvent("NAME_PLATE_UNIT_ADDED")
NamePlatesFrame:RegisterEvent("NAME_PLATE_UNIT_REMOVED")

T.EditPlateIcons = function(tag)
	if tag == "enable" or tag == "all" then
		if SoD_CDB["General"]["disable_all"] or not SoD_CDB["PlateAlerts"]["enable"] then
			for k, frame in pairs(G.Plate_IconHolders) do
				frame:SetAlpha(0)
			end

		else			
			for k, frame in pairs(G.Plate_IconHolders) do
				frame:SetAlpha(1)		
			end	
		end
	end
	
	if tag == "icon_size" or tag == "all" then
		for k, frame in pairs(G.Plate_IconHolders) do
			for j, icon in pairs(frame.Aura_Icons) do
				icon:SetSize(SoD_CDB["PlateAlerts"]["size"], SoD_CDB["PlateAlerts"]["size"])
			end
			for j, icon in pairs(frame.SourceAura_Icons) do
				icon:SetSize(SoD_CDB["PlateAlerts"]["size"], SoD_CDB["PlateAlerts"]["size"])
			end
			for j, icon in pairs(frame.Spell_Icons) do
				icon:SetSize(SoD_CDB["PlateAlerts"]["size"], SoD_CDB["PlateAlerts"]["size"])
			end
			if frame.powericon then
				frame.powericon:SetSize(SoD_CDB["PlateAlerts"]["size"], SoD_CDB["PlateAlerts"]["size"])
			end
			frame.LineUpIcons()
		end
	end
	
	if tag == "font_size" or tag == "all" then
		for k, frame in pairs(G.Plate_IconHolders) do
			for j, icon in pairs(frame.Aura_Icons) do
				icon.text:SetFont(font, SoD_CDB["PlateAlerts"]["fsize"], "OUTLINE")
				icon.count:SetFont(font, SoD_CDB["PlateAlerts"]["fsize"], "OUTLINE")
			end
			for j, icon in pairs(frame.SourceAura_Icons) do
				icon.text:SetFont(font, SoD_CDB["PlateAlerts"]["fsize"], "OUTLINE")
				icon.count:SetFont(font, SoD_CDB["PlateAlerts"]["fsize"], "OUTLINE")
			end
			for j, icon in pairs(frame.Spell_Icons) do
				icon.cast.target:SetFont(font, SoD_CDB["PlateAlerts"]["fsize"], "OUTLINE")
				icon.cast.target:SetHeight(SoD_CDB["PlateAlerts"]["fsize"]*2.5)
				icon.cast.spell:SetFont(font, SoD_CDB["PlateAlerts"]["fsize"], "OUTLINE")
				icon.cast.spell:SetHeight(SoD_CDB["PlateAlerts"]["fsize"])
				icon.cast.dur:SetFont(font, SoD_CDB["PlateAlerts"]["fsize"], "OUTLINE")
			end
			if frame.powericon then
				frame.powericon.count:SetFont(font, SoD_CDB["PlateAlerts"]["fsize"], "OUTLINE")
			end
		end
	end
	
	if tag == "y" or tag == "all" then
		for k, frame in pairs(G.Plate_IconHolders) do
			frame:SetPoint("BOTTOM", frame:GetParent(), "TOP", 0, SoD_CDB["PlateAlerts"]["y"])
		end
	end
end
----------------------------------------------------------
----------------[[    Chat Message    ]]------------------
----------------------------------------------------------
local SentFormatChatmassge = function(AuraType, SpellID, SpellName, Stack, Dur)
	if SoD_CDB["General"]["disable_all"] then return end
	
	local str = ""

	if G.Msgs[AuraType][SpellID] then
		if G.Msgs[AuraType][SpellID]["playername"] then
			str = str..G.PlayerName.." "
		end
		
		if G.Msgs[AuraType][SpellID]["spellname"] then
			str = str..SpellName.." "
		end
		
		if Stack then
			str = str.."("..Stack..")"
		end
		
		if Dur then
			str = str..Dur
		end
		
		if G.Msgs[AuraType][SpellID]["icon"] and G.Msgs[AuraType][SpellID]["icon"] ~= 0 then
			local icon = "{rt"..G.Msgs[AuraType][SpellID]["icon"].."}"
			str = icon..str..icon
		end
		
		str = gsub(str, " {", "{")
		
		T.SendChatMsg(str)
	end
end

local ChatMsgEvents = {
	"COMBAT_LOG_EVENT_UNFILTERED",
	"RAID_BOSS_WHISPER",
	"UNIT_SPELLCAST_START",
	"CHAT_MSG_ADDON",
}

local ChatMsgEventFrame = CreateFrame("Frame", G.addon_name.."ChatMsgEventFrame", G.FrameHolder) 
ChatMsgEventFrame:RegisterEvent("ENCOUNTER_START")
ChatMsgEventFrame:RegisterEvent("ENCOUNTER_END")
ChatMsgEventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")

local ChatMsgTiggerFrames = {}

ChatMsgEventFrame:SetScript("OnEvent", function(self, event, ...)
	if event == "ENCOUNTER_START" then
		for i, event in pairs(ChatMsgEvents) do
			self:RegisterEvent(event)
		end
	elseif event == "ENCOUNTER_END" then
		for i, event in pairs(ChatMsgEvents) do
			self:UnregisterEvent(event)
		end
		for k, ctf in pairs(ChatMsgTiggerFrames) do
			ctf:SetScript("OnUpdate", nil)
			ctf.start = 0
		end
	elseif event == "PLAYER_ENTERING_WORLD" then			
		local guid = UnitGUID("boss1")
		if guid then
			for i, event in pairs(ChatMsgEvents) do
				self:RegisterEvent(event)
			end
		end
	elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local _, Event_type, _, _, _, _, _, _, DestName, _, _, SpellID, SpellName, _, _, amount = CombatLogGetCurrentEventInfo()
		
		if Event_type == "SPELL_AURA_APPLIED" and DestName == G.PlayerName then

			if SoD_CDB["ChatMsgAuras"][SpellID] then
				SentFormatChatmassge("ChatMsgAuras", SpellID, SpellName)
			end
			
			if SoD_CDB["ChatMsgAurasDose"][SpellID] then
				local Stack = select(3, AuraUtil.FindAuraByName(SpellName, "player", G.Test_Mod and "HELPFUL" or "HARMFUL")) -- "HARMFUL"
				SentFormatChatmassge("ChatMsgAurasDose", SpellID, SpellName, Stack)
			end
			
			if SoD_CDB["ChatMsgAuraCountdown"][SpellID] and not self.countdown_spellid then -- 需要倒数
				SentFormatChatmassge("ChatMsgAuraCountdown", SpellID, SpellName)
				
				self.countdown_spellid = SpellID
				self.countdown = 5
				self.t = 0
				self:SetScript("OnUpdate", function(self, e)
					self.t = self.t + e
					if self.t > update_rate then
						local name, icon, count, debuffType, duration, expirationTime, _, _, _, aura_spellID = AuraUtil.FindAuraByName(SpellName, "player", G.Test_Mod and "HELPFUL" or "HARMFUL")
						if name and aura_spellID == SpellID then
							local dur = ceil(expirationTime - GetTime())
							if dur == self.countdown and dur > 0 then
								SentFormatChatmassge("ChatMsgAuraCountdown", SpellID, SpellName, nil, dur)							
								self.countdown = self.countdown - 1
							end
						else
							self.countdown_spellid = nil
							self:SetScript("OnUpdate", nil)							
						end
						self.t = 0
					end
				end)
			end
			
			if SoD_CDB["ChatMsgAuraRepeat"][SpellID] and G.Msgs["ChatMsgAuraRepeat"][SpellID] and not self.repeat_spellid then -- 需要倒数
				self.repeat_spellid = SpellID
				self.t = 0
				self:SetScript("OnUpdate", function(self, e)
					self.t = self.t + e
					if self.t > update_rate then
						local name, icon, count, debuffType, duration, expirationTime, _, _, _, aura_spellID = AuraUtil.FindAuraByName(SpellName, "player", G.Test_Mod and "HELPFUL" or "HARMFUL")
						if name and aura_spellID == SpellID then
							local now = GetTime()
							local Dur
							if G.Msgs["ChatMsgAuraRepeat"][SpellID]["show_dur"] then
								if expirationTime == 0 then -- 一直持续
									Dur = "/"
								elseif expirationTime > now then -- 有剩余时间
									Dur = T.FormatTime(expirationTime - now)
								else
									self.repeat_spellid = nil
									self:SetScript("OnUpdate", nil)
									self.time = 0
								end
							else
								Dur = ""
							end
							
							local Stack
							if G.Msgs["ChatMsgAuraRepeat"][SpellID]["show_stack"] then
								Stack = count
							else
								Stack = ""
							end
							
							if self.time ~= ceil(now) then
								SentFormatChatmassge("ChatMsgAuraRepeat", SpellID, SpellName, Count, Dur)							
								self.time = ceil(now)
							end
						else
							self.repeat_spellid = nil
							self:SetScript("OnUpdate", nil)
							self.time = 0							
						end
						self.t = 0
					end
				end)
			end
			
			if SoD_CDB["ChatMsgRange"][SpellID] and G.Msgs["ChatMsgRange"][SpellID] and G.Msgs["ChatMsgRange"][SpellID]["range_event"] == Event_type then -- 距离过近检查
				T.RangeCheck(G.Msgs["ChatMsgRange"][SpellID]["range"])
			end
			
		elseif Event_type == "SPELL_AURA_REMOVED" and DestName == G.PlayerName then
			if SoD_CDB["ChatMsgAurasDose"][SpellID] then
				SentFormatChatmassge("ChatMsgAurasDose", SpellID, SpellName, 0)
			end
			
			if SoD_CDB["ChatMsgRange"][SpellID] and G.Msgs["ChatMsgRange"][SpellID] and G.Msgs["ChatMsgRange"][SpellID]["range_event"] == Event_type then -- 距离过近检查
				T.RangeCheck(G.Msgs["ChatMsgRange"][SpellID]["range"])
			end
			
		elseif (Event_type == "SPELL_AURA_APPLIED_DOSE" or Event_type == "SPELL_AURA_REMOVED_DOSE")and DestName == G.PlayerName then
			if SoD_CDB["ChatMsgAurasDose"][SpellID] then			
				SentFormatChatmassge("ChatMsgAurasDose", SpellID, SpellName, amount)
			end
		elseif Event_type == "SPELL_CAST_START" or Event_type == "SPELL_CAST_SUCCESS" then
			if SoD_CDB["ChatMsgRange"][SpellID] and G.Msgs["ChatMsgRange"][SpellID] and G.Msgs["ChatMsgRange"][SpellID]["range_event"] == Event_type then -- 距离过近检查
				T.RangeCheck(G.Msgs["ChatMsgRange"][SpellID]["range"])
			end
		end
	elseif event == "RAID_BOSS_WHISPER" then --CHAT_MSG_SAY
		local Msg = ...
		for SpellID, v in pairs(SoD_CDB["ChatMsgBossWhispers"]) do
			if Msg and strfind(Msg, SpellID) then -- 带spell link的boss密语
				local SpellName = GetSpellInfo(SpellID)
				SentFormatChatmassge("ChatMsgBossWhispers", SpellID, SpellName)	
				break
			end
		end
	elseif event == "UNIT_SPELLCAST_START" then
		local Unit, _, SpellID = ...
		if SoD_CDB["ChatMsgCom"][SpellID] then -- 对我施法检查
			C_Timer.After(.1, function()
				if UnitIsUnit(Unit.."target", "player") then -- 延迟一下再判定目标
					local Name, SpellName, _, startTimeMS, endTimeMS, _, _, _, SpellID = UnitCastingInfo(Unit)
					
					SentFormatChatmassge("ChatMsgCom", SpellID, SpellName)
					
					if endTimeMS then
						self.countdown_spellid = SpellID
						self.countdown = ceil((endTimeMS - startTimeMS)/1000 - 1)
	
						self.t = 0
						self:SetScript("OnUpdate", function(self, e)
							self.t = self.t + e
							if self.t > update_rate then
								local dur = ceil(endTimeMS/1000 - GetTime())
								if dur > 0 then
									if dur == self.countdown and dur > 0 then
										SentFormatChatmassge("ChatMsgCom", SpellID, SpellName, nil, dur)							
										self.countdown = self.countdown - 1
									end
								else
									self.countdown_spellid = nil
									self:SetScript("OnUpdate", nil)		
								end
								self.t = 0
							end
						end)
					end
				end	
			end)
		end
	elseif event == "CHAT_MSG_ADDON" then
		local prefix, message, channel, sender = ... 
		if prefix == "sodpaopao" and channel == "WHISPER" and G.PlayerName == string.split("-", sender) then
			local mark, event_type, id, text, exp_time = string.split("_", message)
			
			if mark == "sodbw" or mark == "soddbm" then
				local spellID = tonumber(id)
				if SoD_CDB["ChatMsgRange"][spellID] and G.Msgs["ChatMsgRange"][spellID] and G.Msgs["ChatMsgRange"][spellID]["range_event"] == "BW_AND_DBM_TIMER" then -- 距离过近检查
					
					if not ChatMsgTiggerFrames[spellID] then
						ChatMsgTiggerFrames[spellID] = CreateFrame("Frame", nil, self)
						ChatMsgTiggerFrames[spellID]["t"] = 0
					end
					
					local ctf = ChatMsgTiggerFrames[spellID]
					
					if event_type == "start" then -- 计时条开始
						exp_time = tonumber(exp_time)
						ctf.start = exp_time - G.Msgs["ChatMsgRange"][spellID]["advance"]
						
						if exp_time > GetTime() then
							ctf:SetScript('OnUpdate', function(s, e)
								s.t = s.t + e
								if s.t > update_rate then
								
									if s.start > 0 then
										local wait = s.start - GetTime()	
										if wait <= 0 then
											T.RangeCheck(G.Msgs["ChatMsgRange"][spellID]["range"])
											s:SetScript("OnUpdate", nil)
											s.start = 0
										end
									else
										s:SetScript("OnUpdate", nil)
										s.start = 0
									end
									
									s.t = 0
								end
							end)
						end
						
					elseif event_type == "stop" then -- 计时条结束
						ctf:SetScript("OnUpdate", nil)
						ctf.start = 0
					end
				end
			end
		end
	end
end)
----------------------------------------------------------
--------------------[[    Sound    ]]---------------------
----------------------------------------------------------
T.Play = function(frame, v)
	local enable = SoD_CDB["Sound"][v] and not SoD_CDB["General"]["disable_all"] and not SoD_CDB["General"]["disable_sound"]
	if enable and not frame.play then
		PlaySoundFile(G.Sounds[v]["soundfile"], "Master")
		frame.play = true
		C_Timer.After(.2, function() frame.play = false end)
	end
end

T.PlayCountDown = function(frame, v, i)
	local enable = SoD_CDB["Sound"][v] and not SoD_CDB["General"]["disable_all"] and not SoD_CDB["General"]["disable_sound"]
	if enable and not frame.play then
		PlaySoundFile(G.media.count..i..".ogg", "Master")
		frame.play = true
		C_Timer.After(.2, function() frame.play = false end)
	end
end

local SoundEvents = {
	"COMBAT_LOG_EVENT_UNFILTERED",
	"UNIT_SPELLCAST_START",
	"UNIT_SPELLCAST_SUCCEEDED",
	"UNIT_SPELLCAST_CHANNEL_START",
	"CHAT_MSG_MONSTER_YELL",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"CHAT_MSG_ADDON",
}

local SoundTigger = CreateFrame("Frame", G.addon_name.."SoundTigger", G.FrameHolder)
SoundTigger:RegisterEvent("ENCOUNTER_START")
SoundTigger:RegisterEvent("ENCOUNTER_END")
SoundTigger:RegisterEvent("PLAYER_ENTERING_WORLD")

local SoundTiggerFrames = {}

SoundTigger:SetScript("OnEvent", function(self, event, ...)
	if event == "ENCOUNTER_START" then
		for i, event in pairs(SoundEvents) do
			self:RegisterEvent(event)
		end
	elseif event == "ENCOUNTER_END" then
		for i, event in pairs(SoundEvents) do
			self:UnregisterEvent(event)
		end
		for k, stf in pairs(SoundTiggerFrames) do
			stf:SetScript("OnUpdate", nil)
			stf.start = 0
			stf.count = 0
			stf.played = false
		end
	elseif event == "PLAYER_ENTERING_WORLD" then			
		local guid = UnitGUID("boss1")
		if guid then
			for i, event in pairs(SoundEvents) do
				self:RegisterEvent(event)
			end
		end
	elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local _, sub_event, _, _, _, _, _, _, DestName, _, _, SpellID, _, _, _, amount = CombatLogGetCurrentEventInfo()
		if G.sound_suffix[sub_event] then
			local tag = SpellID..G.sound_suffix[sub_event][1]
			if SoD_CDB["Sound"][tag] and G.Sounds[tag] then	
				local unit = G.Sounds[tag]["unit"]
				if (not unit or UnitName(unit) == DestName) then
					T.Play(self, tag)
					if sub_event == "SPELL_AURA_APPLIED_DOSE" and amount <=  10 then
						C_Timer.After(1, function() -- 延迟
							PlaySoundFile(G.media.sounds.."count\\"..amount..".ogg", "Master") -- 声音 层数
						end)
					end
					if G.Sounds[tag]["countdown"] then
						self.countdown_spellid = SpellID
						self.countdown = 5
						self.t = 0
						self:SetScript("OnUpdate", function(self, e)
							self.t = self.t + e
							if self.t > update_rate then
								local aura_name = GetSpellInfo(self.countdown_spellid)
								local name, icon, count, debuffType, duration, expirationTime = AuraUtil.FindAuraByName(aura_name, "player", "HARMFUL")--"HARMFUL"
								if name then
									local dur = ceil(expirationTime - GetTime())
									if dur == self.countdown and dur > 0 then
										T.PlayCountDown(self, tag, dur)
										self.countdown = self.countdown - 1
									end
								else
									self.countdown_spellid = nil
									self:SetScript("OnUpdate", nil)							
								end
								self.t = 0
							end
						end)
					end
				end
			end
		end
	elseif event == "UNIT_SPELLCAST_START" or event == "UNIT_SPELLCAST_SUCCEEDED" or event == "UNIT_SPELLCAST_CHANNEL_START" then
		local cast_unit, _, SpellID = ...
		local tag = SpellID..G.sound_suffix[event][1]
		if SoD_CDB["Sound"][tag] and G.Sounds[tag] then
			local unit = G.Sounds[tag]["unit"]
			if unit and unit == "player" then	
				C_Timer.After(.2, function() -- 延迟
					if UnitIsUnit(cast_unit.."target", "player") then -- 目标是我
						--print(cast_unit.."target", "player", UnitName(cast_unit.."target"), UnitName("player"))
						T.Play(self, tag)
					--else
						--print("failed", cast_unit.."target", "player", UnitName(cast_unit.."target"), UnitName("player"))
					end
				end)
			elseif not unit then
				T.Play(self, tag)
			end
		end
	elseif event == "CHAT_MSG_MONSTER_YELL" or event == "CHAT_MSG_RAID_BOSS_EMOTE" then
		local Message = ...
		for msg, spellID in pairs(G.boss_msg_spell) do
			if strfind(Message, msg) then
				local tag = spellID..G.sound_suffix[event][1]
				if SoD_CDB["Sound"][tag] and G.Sounds[tag] then
					T.Play(self, tag)
				end
				break
			end
		end
	elseif event == "CHAT_MSG_ADDON" then
		local prefix, message, channel, sender = ... 
		if prefix == "sodpaopao" and channel == "WHISPER" and G.PlayerName == string.split("-", sender) then
			
			local mark, event_type, id, text, exp_time = string.split("_", message)
			
			if mark == "sodbw" or mark == "soddbm" then
				local spell_tag = id.."bws"	
				
				if SoD_CDB["Sound"][spell_tag] and G.Sounds[spell_tag] then -- 有法术id
					
					if not SoundTiggerFrames[spell_tag] then
						SoundTiggerFrames[spell_tag] = CreateFrame("Frame", nil, self)
						SoundTiggerFrames[spell_tag]["t"] = 0
					end
					
					local stf = SoundTiggerFrames[spell_tag]
					
					if event_type == "start" then -- 计时条开始
					
						exp_time = tonumber(exp_time)
						stf.start = exp_time - G.Sounds[spell_tag]["dur"]
						
						if exp_time > GetTime() then
							stf:SetScript('OnUpdate', function(s, e)
								s.t = s.t + e
								if s.t > update_rate then
								
									if s.start > 0 then
										local remain = exp_time - GetTime()
										local wait = s.start - GetTime()
										
										if remain > 0 then
											if wait <= 0 then
												if not s.played then
													T.Play(self, spell_tag)
													s.played = true
												end
												
												if G.Sounds[spell_tag]["countdown"] then							
													local count = ceil(exp_time - GetTime())
													if count > 0 and count < G.Sounds[spell_tag]["dur"] and count ~= s.count then						
														T.PlayCountDown(self, spell_tag, count)
														s.count = count
													end
												end
											end
										else
											s:SetScript("OnUpdate", nil)
											s.start = 0
											s.count = 0
											s.played = false
										end
									else
										s:SetScript("OnUpdate", nil)
										s.start = 0
										s.count = 0
										s.played = false
									end
									
									s.t = 0
								end
							end)
						end
						
					elseif event_type == "stop" then -- 计时条结束
						stf:SetScript("OnUpdate", nil)
						stf.start = 0
						stf.count = 0
						stf.played = false
					end
				end
			
				for key, spellID in pairs(G.bw_sound_keyword) do
					if text:find(key) then -- 找到关键词
						local text_tag = spellID.."bwt"
						if SoD_CDB["Sound"][text_tag] and G.Sounds[text_tag] then
							
							if not SoundTiggerFrames[text_tag] then
								SoundTiggerFrames[text_tag] = CreateFrame("Frame", nil, self)
								SoundTiggerFrames[text_tag]["t"] = 0
							end
						
							local stf = SoundTiggerFrames[text_tag]
							
							if event_type == "start" then -- 计时条开始
								
								exp_time = tonumber(exp_time)
								stf.start = exp_time - G.Sounds[text_tag]["dur"]
								
								if exp_time > GetTime() then
									stf:SetScript('OnUpdate', function(s, e)
										s.t = s.t + e
										if s.t > update_rate then
										
											if s.start > 0 then
												local remain = exp_time - GetTime()
												local wait = s.start - GetTime()
												
												if remain > 0 then
													if wait <= 0 then
														if not s.played then
															T.Play(self, text_tag)
															s.played = true
														end
														
														if G.Sounds[text_tag]["countdown"]  then							
															local count = ceil(exp_time - GetTime())									
															if count > 0 and count < G.Sounds[text_tag]["dur"] and count ~= s.count then						
																T.PlayCountDown(self, text_tag, count)
																s.count = count
															end
														end
													end
												else
													s:SetScript("OnUpdate", nil)
													s.start = 0
													s.count = 0
													s.played = false
												end
											else
												s:SetScript("OnUpdate", nil)
												s.start = 0
												s.count = 0
												s.played = false
											end
											
											s.t = 0
										end
									end)
								end
							elseif event_type == "stop" then -- 计时条结束
								stf:SetScript("OnUpdate", nil)
								stf.start = 0
								stf.count = 0
								stf.played = false
							end
						end
					end
				end
			end
		end
	end
end)

----------------------------------------------------------
-----------------[[    BW Callback    ]]------------------
----------------------------------------------------------

local bw_bars = {}
local bw_nextExpire -- time of next expiring timer

local function bw_recheckTimers()
  local now = GetTime()
  bw_nextExpire = nil
  for text, bar in pairs(bw_bars) do
    if bar.expirationTime < now then
      bw_bars[text] = nil
    elseif bw_nextExpire == nil then
      bw_nextExpire = bar.expirationTime
    elseif bar.expirationTime < bw_nextExpire then
      bw_nextExpire = bar.expirationTime
    end
  end

  if bw_nextExpire then
    C_Timer.After(bw_nextExpire - now, bw_recheckTimers)
  end
end
	
local BigwigsCallback = function(event, ...)
    if event=="BigWigs_StartBar" then
        local addon, id, text, duration = ...
		local now = GetTime()
		local expirationTime = now + duration
		id = tostring(id)
		
		if not id then return end
		
		if id then
			bw_bars[text] = bw_bars[text] or {}
			
			local bar = bw_bars[text]
			bar.addon = addon
			bar.id = id
			bar.text = text
			bar.duration = duration
			bar.expirationTime = expirationTime
			
			if bw_nextExpire == nil or expirationTime < bw_nextExpire then
				C_Timer.After(duration, bw_recheckTimers)
				bw_nextExpire = expirationTime
			end
			
			C_ChatInfo.SendAddonMessage("sodpaopao", "sodbw_start_"..bar.id.."_"..bar.text.."_"..bar.expirationTime, "WHISPER", G.PlayerName)
			
			--print("start", text, id)
			--
			--local str = "现有："
			--for text, v in pairs(bw_bars) do
			--	str = str..text..","
			--end
			--print(str)
		end
    elseif event == "BigWigs_StopBar" then
        local addon, text = ...
		
        if bw_bars[text] then
		
			local bar = bw_bars[text]
		
			C_ChatInfo.SendAddonMessage("sodpaopao", "sodbw_stop_"..bar.id.."_"..bar.text, "WHISPER", G.PlayerName)
			
			bw_bars[text] = nil
			
			--print("end", text, id)
			--local str = "现有："
			--for text, v in pairs(bw_bars) do
			--	str = str..text..","
			--end
			--print(str)	
		end
		
		
    elseif (event == "BigWigs_StopBars" or event == "BigWigs_OnBossDisable" or event == "BigWigs_OnPluginDisable") then
	
        local addon = ...
		
		for text, bar in pairs(bw_bars) do
			if bar.addon == addon then
			
				C_ChatInfo.SendAddonMessage("sodpaopao", "sodbw_stop_"..bar.id.."_"..bar.text, "WHISPER", G.PlayerName)
				
				bw_bars[text] = nil
				
				--print("end_all", id, id)
				
				--local str = "现有："
				--for text, v in pairs(bw_bars) do
				--	str = str..text..","
				--end
				--print(str)	
				break
			end
		end
    end
end

if BigWigsLoader then
    BWCallbackObj = {}
    BigWigsLoader.RegisterMessage(BWCallbackObj, "BigWigs_StartBar", BigwigsCallback)
    BigWigsLoader.RegisterMessage(BWCallbackObj, "BigWigs_StopBar", BigwigsCallback)
    BigWigsLoader.RegisterMessage(BWCallbackObj, "BigWigs_StopBars", BigwigsCallback)
    BigWigsLoader.RegisterMessage(BWCallbackObj, "BigWigs_OnBossDisable", BigwigsCallback)
end

----------------------------------------------------------
-----------------[[    DBM Callback    ]]-----------------
----------------------------------------------------------
local dbm_bars = {}
local dbm_nextExpire -- time of next expiring timer

local function dbm_recheckTimers()
  local now = GetTime()
  dbm_nextExpire = nil
  for text, bar in pairs(dbm_bars) do
    if bar.expirationTime < now then
      dbm_bars[text] = nil
    elseif dbm_nextExpire == nil then
      dbm_nextExpire = bar.expirationTime
    elseif bar.expirationTime < dbm_nextExpire then
      dbm_nextExpire = bar.expirationTime
    end
  end

  if dbm_nextExpire then
    C_Timer.After(dbm_nextExpire - now, dbm_recheckTimers)
  end
end

local DBMCallback = function(event, ...)

    if event=="DBM_TimerStart" then
		local tag, text, duration = ...
		local id = tag:match('%d+')
		if not id then return end
		
		local now = GetTime()
		local expirationTime = now + duration
		
		dbm_bars[text] = dbm_bars[text] or {}
		
		local bar = dbm_bars[text]
		bar.id = id
		bar.text = text
		bar.duration = duration
		bar.expirationTime = expirationTime

		if dbm_nextExpire == nil or expirationTime < dbm_nextExpire then
			C_Timer.After(duration, dbm_recheckTimers)
			dbm_nextExpire = expirationTime
		end
		
		C_ChatInfo.SendAddonMessage("sodpaopao", "soddbm_start_"..bar.id.."_"..bar.text.."_"..bar.expirationTime, "WHISPER", G.PlayerName)
		
		--print("start", text, id)
		--
		--local str = "现有："
		--for text, v in pairs(dbm_bars) do
		--	str = str..text..","
		--end
		--print(str)
		
    elseif event=="DBM_TimerUpdate" then
		local tag, passed, new_dur = ...
		local id = tag:match('%d+')
		if not id then return end
		
		local now = GetTime()
		local new_exp = now + (new_dur - passed)
		
		for text, _ in pairs(dbm_bars) do
			if dbm_bars[text]["id"] == id then
				local bar = dbm_bars[text]
				
				bar.duration = new_dur
				bar.expirationTime = new_exp
				
				C_ChatInfo.SendAddonMessage("sodpaopao", "soddbm_start_"..bar.id.."_"..bar.text.."_"..bar.expirationTime, "WHISPER", G.PlayerName)
				
				--print("update", text, id)	
				--local str = "现有："
				--for text, v in pairs(dbm_bars) do
				--	str = str..text..","
				--end
				--print(str)	

				break
			end
		end

		
    elseif event=="DBM_TimerStop" then
		local tag = ...
		local id = tag:match('%d+')
		if not id then return end
		
        for text, _ in pairs(dbm_bars) do
			if dbm_bars[text]["id"] == id then
				local bar = dbm_bars[text]
				
				C_ChatInfo.SendAddonMessage("sodpaopao", "soddbm_stop_"..bar.id.."_"..bar.text, "WHISPER", G.PlayerName)
				
				dbm_bars[text] = nil
				
				--print("stop", text, id)	
				--local str = "现有："
				--for text, v in pairs(dbm_bars) do
				--	str = str..text..","
				--end
				--print(str)
				
				break
			end
		end		
    end
end

if DBM and DBM.Bars then
    hooksecurefunc(DBM.Bars,"CancelBar", function(self, tag)
		local id = tag:match('%d+')
		if not id then return end
		
		for text, _ in pairs(dbm_bars) do
			if dbm_bars[text]["id"] == id then
				local bar = dbm_bars[text]
				
				C_ChatInfo.SendAddonMessage("sodpaopao", "soddbm_stop_"..bar.id.."_"..bar.text, "WHISPER", G.PlayerName)
			
				dbm_bars[text] = nil
				
				--print("cancel", text, id)	
				--local str = "现有："
				--for text, v in pairs(dbm_bars) do
				--	str = str..text..","
				--end
				--print(str)

				break
			end
		end		
    end)
end

if DBM and not DBM:IsCallbackRegistered("DBM_TimerStart", DBMCallback) then 
    DBM:RegisterCallback("DBM_TimerStart", DBMCallback)
end
if DBM and not DBM:IsCallbackRegistered("DBM_TimerUpdate", DBMCallback) then 
    DBM:RegisterCallback("DBM_TimerUpdate", DBMCallback)
end
if DBM and not DBM:IsCallbackRegistered("DBM_TimerStop", DBMCallback) then 
    DBM:RegisterCallback("DBM_TimerStop", DBMCallback)
end

----------------------------------------------------------
-----------------[[    Bosss Mods    ]]-------------------
----------------------------------------------------------
G.BossMods = {}

T.EditBossModsFrame = function(option)
	for k, frame in pairs(G.BossMods) do
		frame.update_onedit(option)
	end
end

T.CreateBossMod = function(ef, index, v, role, tip, points, events, difficulty_id, init, reset, update)
	local frame = CreateFrame("Frame", addon_name.."_"..v.."_Mods", G.FrameHolder)
	
	frame.events = events
	frame.init = init
	frame.reset = reset
	frame.update = update
	
	frame.npcID = G.Encounters[index]["npc_id"]
	frame.engageID = G.Encounters[index]["engage_id"]
	frame.t = 0	
	
	frame:Hide()
	frame.movingname = EJ_GetEncounterInfo(G.Encounters[index]["id"])..GetSpellInfo(v)..L["首领模块"]
	frame.movingtag = index
	if not points.hide then
		frame:SetSize(points.width, points.height)
		frame.point = { a1 = points.a1, parent = "UIParent", a2 = points.a2, x = points.x, y = points.y }
		T.CreateDragFrame(frame)
	else
		frame:SetPoint("CENTER", UIParent, "CENTER")
	end
	
	frame.update_onedit = function(option)
		if option == "all" or option == "enable" then
			frame.enable = SoD_CDB["BossMods"][v] and SoD_CDB["BM"]["enable"]
			if frame.enable then
				frame:RegisterEvent("ENCOUNTER_START")
				frame:RegisterEvent("ENCOUNTER_END")
			else
				frame:UnregisterEvent("ENCOUNTER_START")
				frame:UnregisterEvent("ENCOUNTER_END")
			end
			
			frame.update_onevent("INIT")
		end
		
		if option == "all" or option == "scale" then
			frame:SetScale(SoD_CDB["BM"]["scale"]/100)
		end
	end
	
	frame.encounter_check = function(event, ...)
		if event == "INIT" then
			if G.Test_Mod then
				if not points.hide then
					frame:Show()
				end
				for event in pairs(frame.events) do
					frame:RegisterEvent(event)
				end
			else
				local guid = UnitGUID("boss1")
				if guid then
					local NPC_ID = select(6, strsplit("-", UnitGUID("boss1")))
					local difficultyID = select(3, GetInstanceInfo())
					if frame.enable and NPC_ID == frame.npcID and (difficulty_id["all"] or difficulty_id[difficultyID]) then
						if not points.hide then
							frame:Show()
						end
						for event in pairs(frame.events) do
							frame:RegisterEvent(event)
						end
					end
				end
			end
		elseif event == "ENCOUNTER_START" then
			local encounterID, encounterName, difficultyID, groupSize = ...
			
			if frame.enable and encounterID == frame.engageID and (difficulty_id["all"] or difficulty_id[difficultyID]) then
				if not points.hide then
					frame:Show()
				end
				for event in pairs(frame.events) do
					frame:RegisterEvent(event)
				end
				frame.update(frame, event) -- 战斗开始时
			end
		elseif event == "ENCOUNTER_END" then
			local encounterID = ...
			if encounterID == frame.engageID then
				for event in pairs(frame.events) do
					frame:UnregisterEvent(event)
				end
				frame.reset(frame)
			end
		end
	end
	
	frame.update_onevent = function(event, ...)
		if event == "INIT" then
			frame.encounter_check(event) -- 显示框体、注册事件
			frame.init(frame)
			frame.update(frame, event)			
		elseif event == "ENCOUNTER_START" or event == "ENCOUNTER_END" then
			frame.encounter_check(event, ...)
		elseif frame.events[event] then
			frame.update(frame, event, ...)
		end
	end

	frame:SetScript("OnEvent", function(self, event, ...)
		frame.update_onevent(event, ...)	
	end)
	
	G.BossMods[v] = frame
	
	T.Create_BossMod_Options(ef, role, difficulty_id, v, tip)
end

----------------------------------------------------------
-----------------[[    Test Frame    ]]-------------------
----------------------------------------------------------
T.CreateTestIcon("test_200768", "hl", 15, 1, 1, 1)
T.CreateTestIcon("test_200630", "no", 17, 1, 1, 0)
T.CreateTestIcon("test_200580", "no", 18, 1, 0, 0)