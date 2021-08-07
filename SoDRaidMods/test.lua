local T, C, L, G = unpack(select(2, ...))

if not G.Test_Mod then return end

G.Encounters[100] = { -- Test
	id = 1480, -- 测试用
	engage_id = 1810, -- 测试用
	npc_id = "91784", -- 测试用
	img = 1410992,
	alerts = {
		AlertIcon = {
			{type = "cast", hl = "no", spellID = 192072,  role="tank"}, -- 召唤援军--已检查
			{type = "cast", hl = "hl", spellID = 191900,  role="tank"}, -- 碎裂波动--已检查
			{type = "cast", hl = "hl", spellID = 192094,  role="tank"}, -- 穿刺之矛--已检查	
			{type = "aura", hl = "hl", spellID = 192131,  role="tank", aura_type = "HARMFUL", unit = "player"}, -- 投掷长矛--已检查
			{type = "com", hl = "hl", spellID = 192138,  role="tank"}, -- 闪电打击--已检查
			{type = "aura", hl = "hl", spellID = 197064,  role="tank", aura_type = "HELPFUL", unit = "boss1"}, -- 激怒--已检查
			{type = "bmsg", hl = "hl", spellID = 197064,  role="tank", event = "CHAT_MSG_MONSTER_YELL", msg = "又是你", dur = 3}, -- 已检查
			{type = "bwspell", hl = "hl", spellID = 139, dur = 5, role="tank"}, -- bw	
			{type = "bwtext", hl = "hl", spellID = 2060, dur = 5, role="tank", key = "好饿呀"}, -- bw
			{type = "bwspell", hl = "hl", spellID = 192094, dur = 7, role="tank"}, -- dbm	
			{type = "bwtext", hl = "hl", spellID = 2061, dur = 8, role="tank", key = "召唤援军"}, -- dbm
		},
		HLOnRaid = {
			{type = "HLCast", spellID = 192138,  role="tank"}, -- 闪电打击--已检查
			{type = "HLAuras", spellID = 191977,  role="tank"}, -- 穿刺之矛--已检查
		},
		PlateAlert = {
			{type = "PlateSpells", role="tank", spellID = 192072, spellCD = 10, mobID = "91784"}, -- 召唤援军--已检查
			{type = "PlateAuras", role="tank", spellID = 197064}, -- 召唤援军--已检查
		},
		TextAlert = {
			{	type = "hp",			
				role="tank",
				data = {
					unit = "boss1",
					npc_id = "91784",
					ranges = {
						{ ul = 90, ll = 60, tip = string.format(L["阶段转换"], "60")},--已检查
						{ ul = 50, ll = 10, tip = string.format(L["阶段转换"], "10")},--已检查
					},
				},
			},
			{	type = "pp",				
				role="tank",
				data = {
					unit = "boss1",
					npc_id = "91784",
					ranges = {
						{ ul = 90, ll = 10, tip = L["即将迷雾"]},--已检查
					},
				},
			},
			{
				type = "spell_clone",
				role= "healer",
				spellID = 139,
				color = {1, 1, .5},
				dur = 10,
				events = {
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,	
				},
				update = function(self, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then
						local _, sub_event, _, sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellID, spellName = CombatLogGetCurrentEventInfo()
						if sub_event == "SPELL_CAST_SUCCESS" and spellID == 139 then
							local player_name = T.ColorName(sourceName)
							self.Clone(player_name..SUMMONS..destName, true)
						end
					end
				end,
			},
			{	
				type = "spell", -- 盾
				spellID = 17,
				color = {1, 1, 0},
				events = {
					["UNIT_AURA"] = true,
					["PLAYER_TARGET_CHANGED"] = true,
				},
				update = function(self, event, ...)
					if event == "UNIT_AURA" or event == "PLAYER_TARGET_CHANGED" then
						local aura = GetSpellInfo(17)
						if AuraUtil.FindAuraByName(aura, "target", "HELPFUL") then
							self.text:SetText(L["目标免疫"])
							self:Show()
						else		
							self:Hide()
						end		
					end
				end,
			},
			{
				type = "spell",
				spellID = 2060,
				events = {
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,	
				},
				color = {1, 0, 1},
				update = function(self, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then
						local _, sub_event, _, sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellID, spellName = CombatLogGetCurrentEventInfo()
						if sub_event == "SPELL_CAST_START" and spellID == 2060 then
							self:Show()
							self.exp = GetTime() + 5
							self:SetScript("OnUpdate", function(s, e)
								s.t = s.t + e
								if s.t > .05 then
									local remain = self.exp - GetTime()
									if remain > 0 then
										self.text:SetText("SPELL_CAST_START2060  "..T.FormatTime(remain))
									else
										self:Hide()
										self:SetScript("OnUpdate", nil)
									end
									s.t = 0
								end
							end)
						end		
					end
				end,
			},
		},
		ChatMsg = {
			{type = "ChatMsgAuras", role="tank", spellID = 192131, role="tank",playername = true, spellname = true, icon = 0}, -- 投掷长矛--已检查
			{type = "ChatMsgAuraCountdown", role="tank", spellID = 17, playername = true, spellname = false, icon = 1}, -- buff--已检查
			{type = "ChatMsgAuraRepeat", role="tank", spellID = 139, playername = true, spellname = true, icon = 7, show_stack = false, show_dur = true}, -- buff--已检查
			{type = "ChatMsgAuras", role="tank", spellID = 61295, playername = false, spellname = true, icon = 2}, -- buff--已检查
			{type = "ChatMsgCom", role="tank", spellID = 192138, playername = true, spellname = true, icon = 1}, -- 闪电打击			
			{type = "ChatMsgAurasDose", role="tank", spellID = 974, playername = true, spellname = true, icon = 4}, -- 黑暗帷幕
			{type = "ChatMsgRange", role="tank", range_event = "SPELL_CAST_START", spellID = 740, range = 5},
			{type = "ChatMsgRange", role="tank", range_event = "BW_AND_DBM_TIMER", spellID = 192094, advance = 3, range = 5},
			
			--{type = "ChatMsgBossWhispers", role="tank", spellID = 139, playername = true, spellname = true, icon = 4},
		},
		Sound = { -- 在首领战斗中测试
			{spellID = 197064, role="tank", event = "CHAT_MSG_MONSTER_YELL", msg = "又是你"},
			{spellID = 192138, role="tank", event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_CAST_START" , unit = "player"}, -- 闪电打击
			{spellID = 192131, role="tank", event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED" , unit = "player"}, -- 投掷长矛			
			{spellID = 191900, role="tank", event = "UNIT_SPELLCAST_START"}, -- 碎裂波动
			{spellID = 191900, role="tank", event = "UNIT_SPELLCAST_SUCCEEDED"}, -- 碎裂波动
			{spellID = 8004, role="tank", event = "UNIT_SPELLCAST_START"}, -- 治疗之涌
			{spellID = 77472, role="tank", event = "UNIT_SPELLCAST_SUCCEEDED"}, -- 治疗波
			{spellID = 53390, role="tank", event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED" , unit = "player", countdown = true}, -- buff
			{spellID = 139, role="tank", event = "BW_AND_DBM_SPELL", dur = 5, countdown = true}, -- bw
			{spellID = 974, role="tank", event = "BW_AND_DBM_TEXT", dur = 5, key = "好饿呀", countdown = true}, -- bw
			{spellID = 192094, role="tank", event = "BW_AND_DBM_SPELL", dur = 5, countdown = true}, -- dbm
			{spellID = 2061, role="tank", event = "BW_AND_DBM_TEXT", dur = 5, key = "召唤援军", countdown = true}, -- dbm
			{spellID = 61295, role="healer", event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED" , unit = "player"}, -- 投掷长矛
			{spellID = 41635, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED_DOSE" , unit = "player"}, -- 愈合祷言
		},
	},
}
	
G.Encounters["trash1159"] = { -- 小怪
	map_id = 1456, -- select(8, GetInstanceInfo())
	img = 1410978,
	alerts = {
		AlertIcon = {
			{type = "cast", role="healer", hl = "no", spellID = 195108}, -- 闪电打击
			{type = "cast", role="healer", hl = "no", spellID = 196870}, -- 风暴
			{type = "com", role="tank", hl = "hl", spellID = 195108}, -- 闪电打击
			{type = "com", role="tank", hl = "hl", spellID = 196870}, -- 风暴
			{type = "cast", role="healer", hl = "no", spellID = 2096}, -- 心灵视界
			{type = "cast", role="healer", hl = "no", spellID = 2060}, -- 治疗术
			{type = "cast", role="healer", hl = "no", spellID = 121536}, -- 羽毛
			{type = "com", role="tank", hl = "hl", spellID = 186263}, -- 暗影愈合 
			{type = "com", role="tank", hl = "hl", spellID = 47757}, -- 苦修
			{type = "aura", role="tank", tip = "换坦嘲讽", hl = "no", spellID = 232698,  aura_type = "HELPFUL", unit = "player"}, -- 恢复
			{type = "aura", role="dps", tip = "转火小怪", hl = "no", spellID = 17,  aura_type = "HELPFUL", unit = "player"}, -- 恢复
			{type = "aura", role="healer", tip = "注意分散", hl = "no", spellID = 41635,  aura_type = "HELPFUL", unit = "player"}, -- 恢复
			{type = "aura", hl = "hl", spellID = 974,  aura_type = "HELPFUL", unit = "player"},
			{type = "aura", role="healer", tip = "注意分散字数", hl = "hl", spellID = 61295,  aura_type = "HELPFUL", unit = "player"},
			{type = "auras", role="healer", hl = "no", spellID = 139,  aura_type = "HELPFUL"}, -- 恢复
			{type = "auras", role="healer", hl = "no", spellID = 232698,  aura_type = "HELPFUL"}, -- 恢复
			{type = "log", tip = "BOSS火焰光环", hl = "hl", spellID = 139, event_type = "SPELL_AURA_REMOVED", dur = 3, targetID = "player"}, -- 灵魂熔炉之约
			{type = "bmsg", hl = "hl", spellID = 116841,  role="tank", event = "CHAT_MSG_SAY", msg = "又是你", dur = 3}, -- 已检查
		},
		HLOnRaid = {
			{type = "HLCast", role="healer", spellID = 195108}, -- 闪电打击
			{type = "HLCast", role="healer", spellID = 195105}, -- 闪电打击
			{type = "HLCast", role="healer", spellID = 196870}, -- 闪电打击
			{type = "HLAuras", role="healer", spellID = 61295, Glow = true}, -- 激流
			{type = "HLAuras", role="healer", spellID = 974,  stack = 6}, -- 大地盾
			{type = "HLAuras", role="healer", spellID = 41635,  stack = 6}, -- 愈合祷言
			{type = "HLAuras", role="healer", spellID = 6788, Glow = true}, -- 虚弱灵魂
		},
		PlateAlert = {
			--{type = "PlayerAuraSource", role="healer", spellID = 195105}, -- 噬骨撕咬--已检查
			--{type = "PlayerAuraSource", role="healer", spellID = 197144}, -- 勾网--已检查
			{type = "PlayerAuraSource", role="healer", spellID = 195094}, -- 珊瑚猛击--已检查
			--{type = "PlateAuras", role="tank", spellID = 453, hl_np = true}, -- 痛
			{type = "PlateSpells", role="healer", spellID = 195108, spellCD = 1, mobID = "91783", hl_np = true}, -- 闪电打击--已检查
			{type = "PlateSpells", role="healer", spellID = 196870, spellCD = 1, mobID = "91783"}, -- 风暴--已检查
			{type = "PlateSpells", role="healer", spellID = 195094, spellCD = 13, mobID = "91781"}, -- 珊瑚猛击--已检查
			{type = "PlateSpells", role="healer", spellID = 197137, spellCD = 10, mobID = "100216"}, -- 投掷长矛--已检查	
			{type = "PlatePower", role="tank", mobID = "91783"}, -- 能量--已检查
			{type = "PlateNpcID", role="tank", mobID = "91783"}, -- NPC--已检查
		},
		TextAlert = {
			
		},
	},
}
