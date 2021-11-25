local T, C, L, G = unpack(select(2, ...))
if select(4, GetBuildInfo()) <= 90005 then return end
-- EJ_GetEncounterInfoByIndex
-- /dump EncounterJournalBossButton1Creature:GetTexture() -- "Interface\\EncounterJournal\\UI-EJ-BOSS-Default"
local LCG = LibStub("LibCustomGlow-1.0")
local LGF = LibStub("LibGetFrame-1.0")


G.shared_sound = {
	
}

G.Encounters[1] = { -- 塔拉格鲁 已过精检
	id = 2435,
	engage_id = 2423,
	npc_id = "175611", 
	img = 4071444,
	alerts = {
		AlertIcon = {
			{type = "com", role = "tank", hl = "hl", spellID = 346985}, -- 压制
			{type = "aura", role = "tank", hl = "no", spellID = 346986, aura_type = "HARMFUL", unit = "player"}, -- 粉碎护甲
			
			{type = "cast", tip = "点名锁链", hl = "hl", spellID = 350280}, -- 永恒锁链 
			{type = "aura", tip = "快去|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_4:0|t", hl = "no", spellID = 347269, aura_type = "HARMFUL", unit = "player"}, -- 永恒锁链
			
			{type = "cast", tip = "准备驱散", hl = "hl", spellID = 347283}, -- 捕食者之嚎
			{type = "aura", tip = "分散", hl = "hl", spellID = 347283, aura_type = "HARMFUL", unit = "player"}, -- 捕食者之嚎

			{type = "cast", tip = "迷雾开始", hl = "hl", spellID = 347679}, -- 贪噬迷雾 
			
			{type = "aura", tip = "火焰DOT", hl = "no", spellID = 352392, dif = {[15] = true, [16] = true}, aura_type = "HARMFUL", unit = "player"}, -- 灵魂熔炉之约
			{type = "log", tip = "BOSS火焰光环", hl = "hl", spellID = 352397, dif = {[15] = true, [16] = true}, event_type = "SPELL_DAMAGE", dur = 2, targetID = "player"}, -- 灵魂熔炉之约
			
			{type = "log", tip = "物理易伤", hl = "hl", spellID = 352382, dif = {[15] = true, [16] = true}, event_type = "SPELL_CAST_SUCCESS", dur = 2}, -- 上层区域之力
			{type = "aura", tip = "物理易伤", hl = "no", spellID = 352384, dif = {[15] = true, [16] = true}, aura_type = "HARMFUL", unit = "player"}, -- 上层区域之力
			{type = "aura", tip = "BOSS物理增伤", hl = "hl", spellID = 352473, dif = {[15] = true, [16] = true}, aura_type = "HELPFUL", unit = "boss1"}, -- 上层区域之力
			
			{type = "log", tip = "法术易伤", hl = "hl", spellID = 352389, dif = {[15] = true, [16] = true}, event_type = "SPELL_CAST_SUCCESS", dur = 2}, -- 莫尔特雷加的回响
			{type = "aura", tip = "法术易伤", hl = "no", spellID = 352387, dif = {[15] = true, [16] = true}, aura_type = "HARMFUL", unit = "player"}, -- 莫尔特雷加的回响
			{type = "aura", tip = "BOSS法术增伤", hl = "hl", spellID = 352491, dif = {[15] = true, [16] = true}, aura_type = "HELPFUL", unit = "boss1"}, -- 上层区域之力

			{type = "cast", tip = "注意治疗", role = "healer", hl = "hl", spellID = 347668}, -- 死亡攫握
			{type = "aura", tip = "注意自保", hl = "no", spellID = 347668, aura_type = "HARMFUL", unit = "player"}, -- 死亡攫握

			{type = "cast", tip = "准备驱散", hl = "hl", spellID = 347490}, -- 远古怒火
			{type = "aura", tip = "驱散BOSS", hl = "no", spellID = 347490, aura_type = "HELPFUL", unit = "boss1"}, -- 远古怒火

			{type = "cast", tip = "进入狂暴", hl = "hl", spellID = 348313}, -- 典狱长的凝视
		},
		HLOnRaid = {		
			{type = "HLAuras", spellID = 346985}, -- 压制
			{type = "HLAuras", spellID = 346986}, -- 粉碎护甲
			{type = "HLAuras", spellID = 347269, Glow = true}, -- 永恒锁链
			{type = "HLAuras", spellID = 347283}, -- 捕食者之嚎
			{type = "HLAuras", spellID = 347286}, -- 不散之惧
			{type = "HLAuras", role = "healer", spellID = 357431, Glow = true}, -- 死亡攫握
		},
		TextAlert = {
			{
				type = "hp",
				data = {
					unit = "boss1",
					npc_id = "175611",
					ranges = {
						{ ul = 15, ll = 10.5, tip = string.format(L["阶段转换"], "10")},
					},
				},
			},
			{
				type = "pp",
				data = {
					unit = "boss1",
					npc_id = "175611",
					ranges = {
						{ ul = 99, ll = 85, tip = L["即将迷雾"]},
					},
				},
			},
		}, 
		ChatMsg = {
			{type = "ChatMsgAuraCountdown", spellID = 347269, playername = false, spellname = true, icon = 1}, -- 永恒锁链
			{type = "ChatMsgRange", range_event = "SPELL_CAST_START", spellID = 347283, range = 5}, -- 捕食者之嚎
		},
		Sound = {
			{spellID = 346985, role = "tank", event = "UNIT_SPELLCAST_START", unit = "player"}, -- 压制
			{spellID = 350280, event = "UNIT_SPELLCAST_START"}, -- 点名锁链
			{spellID = 347269, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED", unit = "player"}, -- 锁链快去三角
			{spellID = 347283, event = "UNIT_SPELLCAST_START"}, -- 5码分散
			{spellID = 347283, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED", unit = "player"}, -- 保持分散
			{spellID = 347679, event = "UNIT_SPELLCAST_START"}, -- 迷雾开始
			{spellID = 352368, event = "UNIT_SPELLCAST_SUCCEEDED"}, -- 准备吃球 待检查
			{spellID = 347668, role = "healer", event = "BW_AND_DBM_SPELL", dur = 3, countdown = false}, -- 点名攫握
			{spellID = 347668, role = "healer", event = "UNIT_SPELLCAST_START"}, -- 治疗攫握
			{spellID = 347668, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED", unit = "player"}, -- 注意自保
			{spellID = 347490, event = "UNIT_SPELLCAST_START"}, -- 准备驱散
			{spellID = 347490, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED", unit = "boss1"}, -- 驱散BOSS
			{spellID = 348313, event = "UNIT_SPELLCAST_START"}, -- 注意自保	
		},
		Phase_Change = {
			{empty = true},
			{sub_event = "SPELL_CAST_START", spellID = 348313}, -- 典狱长的凝视
		},
		BossMods = {
			{ -- 粉碎护甲
				spellID = 346986,
				role = "tank",
				tip = string.format(L["多人光环提示"], T.GetIconLink(346986)),
				points = {a1 = "TOPLEFT", a2 = "CENTER", x = -700, y = 200, width = 250, height = 100},				
				events = {
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,	
				},
				difficulty_id = {
					["all"] = true,
				},
				init = function(frame)
					frame.aura_spell_ids = {346986}
					frame.aura_spells = {}
					for i, v in pairs(frame.aura_spell_ids) do
						frame.aura_spells[v] = {aura = GetSpellInfo(v), icon = select(3, GetSpellInfo(v))}
					end
					
					frame.bars = {}
						
					frame.create_bar = function(tag, spellID, player)
						local bar = T.CreateTimerBar(frame, frame.aura_spells[spellID]["icon"], true, false, true)
						bar.spellID = spellID
						bar.name = player
						frame.bars[tag] = bar
					end
					
					frame.updatebar = function(bar, count, dur, exp_time)
						bar.left:SetText(T.ColorName(bar.name, true))
						
						bar.exp = exp_time
						bar.anim_played = false
						bar:SetMinMaxValues(0 , dur)
						
						bar:SetScript("OnUpdate", function(self, e)
							self.t = self.t + e
							if self.t > self.update_rate then		
								local remain = exp_time - GetTime()
								if remain > 0 then								
									self.right:SetText((count > 0 and "|cffFFFF00["..count.."]|r " or "")..T.FormatTime(remain))
									self:SetValue(dur - remain)
									if remain < 3 then -- 即将消失
										if not self.anim_played then
											self.anim_played = true
											self.glow:Show()
											self.anim:Play()
										end
										self.glow:SetAlpha(self.anim:GetProgress())
									end
								else
									self:Hide()
									self:SetScript("OnUpdate", nil)
									self.anim:Stop()
									self.glow:Hide()
								end
								self.t = 0
							end
						end)											
						bar:Show()
					end
					
					frame.lineup = function()
						local t = {}
						for GUID, bar in pairs(frame.bars) do
							if bar and bar:IsVisible() then
								table.insert(t, bar)
							end
						end
						if #t > 1 then
							table.sort(t, function(a, b) 
								if a.spellID < b.spellID then
									return true
								elseif a.spellID == b.spellID and a.exp < b.exp then
									return true
								end
							end)
						end
						local lastbar
						for i, bar in pairs(t) do
							bar:ClearAllPoints()
							if bar:IsVisible() then
								if not lastbar then
									bar:SetPoint("TOPLEFT", frame, "TOPLEFT", 30, -5)
									lastbar = bar
								else
									bar:SetPoint("TOPLEFT", lastbar, "BOTTOMLEFT", 0, -5)
									lastbar = bar
								end
							end
						end
					end			
				end,
				update = function(frame, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then						
						local _, sub_event, _, _, _, _, _, destGUID, destName, _, _, spellID = CombatLogGetCurrentEventInfo()
						if (sub_event == "SPELL_AURA_APPLIED" or sub_event == "SPELL_AURA_APPLIED_DOSE" or sub_event == "SPELL_AURA_REMOVED_DOSE") and frame.aura_spells[spellID] then						
							local dest = string.split("-", destName)				
							if destGUID and AuraUtil.FindAuraByName(frame.aura_spells[spellID]["aura"], dest, G.Test_Mod and "HELPFUL" or "HARMFUL") then
								local count, _, dur, exp_time = select(3, AuraUtil.FindAuraByName(frame.aura_spells[spellID]["aura"], dest, G.Test_Mod and "HELPFUL" or "HARMFUL"))
								if not frame.bars[spellID.."_"..destGUID] then
									frame.create_bar(spellID.."_"..destGUID, spellID, dest)
								end
								
								local bar = frame.bars[spellID.."_"..destGUID]
								frame.updatebar(bar, count, dur, exp_time)
								
								frame.lineup()
							end
						elseif sub_event == "SPELL_AURA_REMOVED" and frame.aura_spells[spellID] then
							if destGUID and frame.bars[spellID.."_"..destGUID] then
								local bar = frame.bars[spellID.."_"..destGUID]
								bar:Hide()
								bar:SetScript("OnUpdate", nil)
								bar.anim:Stop()
								bar.glow:Hide()
								frame.lineup()
							end
						end
					end	
				end,
				reset = function(frame)
					for tag, bar in pairs(frame.bars) do
						bar:ClearAllPoints()
						bar:Hide()
						bar:SetScript("OnUpdate", nil)
						bar.anim:Stop()
						bar.glow:Hide()
					end				
					frame.bars = table.wipe(frame.bars)
					frame:Hide()
				end,
			},
			{ -- 捕食者之嚎
				spellID = 347283,
				role = "healer",
				tip = L["TIP捕食者之嚎"],			
				events = {
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,
					["GROUP_ROSTER_UPDATE"] = true,
					["ROLE_CHANGED_INFORM"] = true,
					["UNIT_CONNECTION"] = true,
					["SPELL_UPDATE_COOLDOWN"] = true,
				},
				difficulty_id = {
					["all"] = true,
				},
				init = function(frame)
					frame.spellID = 347283
					frame.aura = GetSpellInfo(frame.spellID)
					frame.playing = false
					
					frame.healers = {} --治疗
					frame.targets = {} --中debuff的人
					
					frame.text = T.createtext(frame, "OVERLAY", 15, "OUTLINE", "LEFT")
					frame.text:SetPoint("TOPLEFT", 5, -5)
					
					frame.update_healers = function()
						if IsInRaid() then
							local group_size = GetNumGroupMembers()
							for i = 1, group_size do
								local unit = "raid"..i
								local role = UnitGroupRolesAssigned(unit)
								local name = UnitName(unit)
								if role == "HEALER" then
									if not frame.healers[name] then
										frame.healers[name] = "pp_await"
									end
									
									if UnitIsDeadOrGhost(unit) or not UnitIsConnected(unit) then -- 治疗死了/掉线了
										frame.healers[name] = "pp_dead"
									end				
								elseif frame.healers[name] then
									frame.healers[name] = nil
								end
							end
						end
						
						for target, healer in pairs(frame.targets) do
							if not frame.healers[healer] or frame.healers[healer] == "pp_dead" then
								frame.targets[target] = "pp_none"
							end
						end
					end
							
					frame.updatetext = function()
						local str = ""
						for target, healer in pairs(frame.targets) do						
							local line
							if healer == "pp_none" then							
								line = T.ColorName(target, true).."\n"
							else
								line = T.ColorName(target, true).."(驱散:"..T.ColorName(healer, true)..")\n"
							end
							str = str..line
						end
						frame.text:SetText(str)
					end
					
					frame.dispel_spells = {
						["PRIEST"] = 527,
						["DRUID"] = 88423,
						["PALADIN"] = 4987,
						["MONK"] = 115450,
						["SHAMAN"] = 77130,
					}
					
					frame.IsSpellReady = function()
						local spellID = frame.dispel_spells[G.myClass]
						if spellID then
							start, duration = GetSpellCooldown(spellID)
							if duration < 1.5 then -- 冷却中	
								return true
							end
						end
					end
					
					frame.Play = function()
						if not frame.playing then
							if frame.IsSpellReady() and not SoD_CDB["General"]["disable_sound"] then
								PlaySoundFile(G.media.sounds.."dispel.ogg", "Master") -- 声音 注意驱散
								frame.playing = true
								C_Timer.After(8, function()
									frame.playing = false
								end)
							end
						end
					end		
					
					frame.assign_dest = function(debuff_player)
						if not frame.targets[debuff_player] then
							frame.targets[debuff_player] = "pp_none"
						end
						
						if frame.targets[debuff_player] == "pp_none" then
							for healer, isbusy in pairs(frame.healers) do
								if isbusy == "pp_await" then -- 这个治疗空闲
									frame.healers[healer] = debuff_player
									frame.targets[debuff_player] = healer -- 去照顾他
									if healer == G.PlayerName then -- 是我负责
										T.GlowRaidFrame_Show(debuff_player, "dispel347283")
										frame.Play()
									end		
									break
								end
							end
						else -- 已经有人照顾这个中点名的玩家
							return
						end
						
						frame.updatetext()
					end
					
					frame.remove_dest = function(debuff_player)
						if frame.targets[debuff_player] then
							frame.targets[debuff_player] = nil
						end
						
						for healer, isbusy in pairs(frame.healers) do
							if isbusy == debuff_player then
								frame.healers[healer] = "pp_await" 
								if healer == G.PlayerName then -- 是我负责
									T.GlowRaidFrame_Hide(debuff_player, "dispel347283")
								end
								break
							end
						end
						
						frame.updatetext()
					end
					
					frame.assign_raid = function()
						if IsInRaid() then
							local group_size = GetNumGroupMembers()	
							for i = 1, group_size do
								local unit = "raid"..i
								local name = AuraUtil.FindAuraByName(frame.aura, unit, "HARMFUL")
								if name then -- 找被点名的玩家
									local debuff_player = UnitName(unit)
									frame.assign_dest(debuff_player)
								end
							end
						end
					end
					
				end,
				
				update = function(frame, event, ...)
					if event == "GROUP_ROSTER_UPDATE" or event == "ROLE_CHANGED_INFORM" or event == "UNIT_CONNECTION" then
						frame.update_healers()
					elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
						local _, sub_event, _, _, _, _, _, destGUID, destName, _, _, spellID, spellName = CombatLogGetCurrentEventInfo()					
						if (sub_event == "SPELL_AURA_APPLIED" or sub_event == "SPELL_AURA_APPLIED_DOSE") and spellID == frame.spellID then	
							local dest = string.split("-", destName)
							frame.assign_dest(dest)
						elseif sub_event == "SPELL_AURA_REMOVED" and spellID == frame.spellID then
							local dest = string.split("-", destName)
							frame.remove_dest(dest)
							frame.assign_raid()
						elseif sub_event == "UNIT_DIED" then
							frame.update_healers()
						end
					elseif event == "SPELL_UPDATE_COOLDOWN" then
						if frame.healers[G.PlayerName] then
							for k, v in pairs(frame.targets) do
								if k then -- 还有debuff
									frame.Play()
									break
								end
							end
						end
					elseif event == "ENCOUNTER_START" then
						frame.update_healers()
					end
				end,
				reset = function(frame)
					frame.targets = table.wipe(frame.targets)
					T.GlowRaidFrame_HideAll()
					frame:Hide()
				end,
			},
			{ -- 贪噬迷雾读条计数
				spellID = 354080,
				tip = L["TIP贪噬迷雾读条计数"],
				points = {a1 = "BOTTOM", a2 = "CENTER", x = 0, y = 300, width = 400, height = 40},				
				events = {
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,
				},
				difficulty_id = {
					["all"] = true,
				},
				init = function(frame)
					frame.spellName, _, frame.iconTexture = GetSpellInfo(354080)
					local bar = T.CreateTimerBar(frame, frame.iconTexture, false, false, true, 400, 40, 25, 1, 1, 0)
					
					bar:SetPoint("TOPLEFT", frame, "TOPLEFT")
					bar:SetMinMaxValues(0, 4)
					bar.ind = 0
					
					frame.bar = bar
				end,
				update = function(frame, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then
						local timestamp, sub_event, _, _, _, _, _, _, destName, _, _, spellID, spellName = CombatLogGetCurrentEventInfo()
						if sub_event == "SPELL_CAST_START" and spellID == 354080 then -- 贪噬迷雾 开始读条
							frame.bar.ind = frame.bar.ind + 1
							frame.bar.left:SetText(string.format("%s [%d]", frame.spellName, frame.bar.ind))
							
							if not SoD_CDB["General"]["disable_sound"] then
								PlaySoundFile(G.media.sounds.."count\\"..frame.bar.ind..".ogg", "Master") -- 语音报数
							end
							
							frame.bar:Show()
							frame.bar.exp = GetTime() + 4					
									
							frame.bar:SetScript("OnUpdate", function(self, e)
								self.t = self.t + e
								if self.t > self.update_rate then
									local remain = self.exp - GetTime()
									if remain > 0 then
										self.right:SetText(T.FormatTime(remain))
										self:SetValue(4 - remain)
									else
										self.left:SetText("")
										self:Hide()	
										self:SetScript("OnUpdate", nil)
									end
									self.t = 0
								end
							end)
						elseif sub_event == "SPELL_CAST_SUCCESS" and spellID == 347679 then -- 贪噬迷雾
							frame.bar.ind = 0 -- 贪噬迷雾重置为0
						end
					elseif event == "ENCOUNTER_START" then
						frame.bar.ind = 0
						frame.bar.left:SetText("")
					end
				end,
				reset = function(frame)
					frame.bar.ind = 0
					frame.bar.left:SetText("")
					frame.bar:Hide()
					frame.bar:SetScript("OnUpdate", nil)
				end,
			},		
		},
	},
}

G.Encounters[2] = { -- 典狱长之眼 已过精检
	id = 2442,
	engage_id = 2433,
	npc_id = "175725", 
	img = 4071426,
	alerts = {
		AlertIcon = {
			{type = "com", role = "tank", hl = "hl", spellID = 350828}, -- 死亡锁链
			{type = "aura", role = "tank", hl = "no", spellID = 351143, aura_type = "HARMFUL", unit = "player"}, -- 死亡锁链
			{type = "cast", tip = "准备大怪", hl = "hl", spellID = 348117}, -- 冥河喷发 		
			{type = "cast", tip = "全团AE", hl = "hl", spellID = 349030}, -- 死亡泰坦凝视		
			{type = "aura", tip = "拉开大怪", hl = "no", spellID = 351826, aura_type = "HARMFUL", unit = "player"}, -- 苦难 待检查
			{type = "cast", tip = "软狂暴开始", hl = "hl", spellID = 348974}, -- 即刻屠灭
			{type = "aura", tip = "致死", hl = "no", spellID = 348969, aura_type = "HARMFUL", unit = "player"}, -- 即刻屠灭
			{type = "com", tip = "躲开队友", hl = "hl", spellID = 350847}, -- 凄凉光波	 	
			{type = "cast", tip = "躲开白圈", hl = "hl", spellID = 350022}, -- 破裂灵魂
			{type = "aura", tip = "去拿碎片", hl = "no", spellID = 350034, aura_type = "HARMFUL", unit = "player"}, -- 破碎灵魂
			{type = "log", tip = "帮忙锁链", hl = "hl", spellID = 358609, dif = {[15] = true, [16] = true}, event_type = "SPELL_AURA_APPLIED", dur = 4}, -- 牵引锁链
			{type = "aura", tip = "拉断锁链", hl = "no", spellID = 349979, dif = {[15] = true, [16] = true}, aura_type = "HARMFUL", unit = "player"}, -- 牵引锁链	
			{type = "com", role = "tank", hl = "hl", spellID = 348074, dif = {[15] = true, [16] = true}}, -- 痛击长枪
			{type = "aura", role = "tank", hl = "no", spellID = 348074, dif = {[15] = true, [16] = true}, aura_type = "HARMFUL", unit = "player"}, -- 痛击长枪		
			{type = "aura", tip = "减速", hl = "no", spellID = 350713, aura_type = "HARMFUL", unit = "player"}, -- 倦怠腐化
			{type = "aura", tip = "出去放圈", hl = "no", spellID = 351827, aura_type = "HARMFUL", unit = "player"}, -- 蔓延痛苦
			{type = "aura", tip = "别踩", hl = "hl", spellID = 350809, aura_type = "HARMFUL", unit = "player"}, -- 典狱长的痛苦	
			{type = "aura", tip = "躲开队友", hl = "hl", spellID = 350604, dif = {[16] = true}, aura_type = "HARMFUL", unit = "player"}, -- 绝望倦怠 待检查
		},
		HLOnRaid = {
			{type = "HLCast", spellID = 350828}, -- 死亡锁链
			{type = "HLAuras", role = "tank", spellID = 351143}, -- 死亡锁链 待检查
			{type = "HLCast", spellID = 350847, Glow = true}, -- 凄凉光波
			{type = "HLAuras", spellID = 350034, Glow = true}, -- 破碎灵魂
			{type = "HLAuras", spellID = 350713}, -- 倦怠腐化
			{type = "HLAuras", spellID = 351827}, -- 蔓延痛苦
			{type = "HLAuras", spellID = 350604, dif = {[16] = true}, Glow = true}, -- 绝望倦怠 待检查
			{type = "HLAuras", spellID = 355245, dif = {[16] = true}}, -- 忿怒 待检查
			{type = "HLAuras", spellID = 355240, dif = {[16] = true}}, -- 轻蔑 待检查
		},
		TextAlert = {
			{
				type = "hp",
				data = {
					unit = "boss1",
					npc_id = "175725",
					ranges = {
						{ ul = 70, ll = 67, tip = string.format(L["阶段转换"], "66.6")},
						{ ul = 37, ll = 34, tip = string.format(L["阶段转换"], "33.3")},
					},
				},
			},
			{	
				type = "spell", -- 毁灭凝视
				spellID = 351413,
				color = {0, 1, 1},
				events = {
					["UNIT_POWER_UPDATE"] = true,
					["UNIT_AURA"] = true,
				},
				update = function(self, event, ...)
					if event == "UNIT_POWER_UPDATE" or event == "UNIT_AURA" then
						local unit = ...
						if unit == "boss1" then
							local pp = UnitPower("boss1")
							local spell = GetSpellInfo(348805)
							if pp >= 85 and not AuraUtil.FindAuraByName(spell, "boss1", "HELPFUL") then
								self.text:SetText(string.format(L["即将射线"], pp))
								self:Show()
							else
								self.text:SetText("")
								self:Hide()
							end
						end
					end
				end,
			},
		},
		ChatMsg = {		
			{type = "ChatMsgAuras", spellID = 358609, playername = true, spellname = true, icon = 1}, -- 牵引锁链			
			{type = "ChatMsgCom", spellID = 350847, playername = true, spellname = true, icon = 2}, -- 凄凉光波		
			{type = "ChatMsgAuras", spellID = 350604, playername = true, spellname = true, icon = 3}, -- 绝望倦怠 待检查			
			{type = "ChatMsgAuraCountdown", spellID = 351827, playername = true, spellname = true, icon = 4}, -- 蔓延痛苦		
		},
		Sound = {
			{spellID = 348117, event = "UNIT_SPELLCAST_START" }, -- 准备大怪
			{spellID = 349030, event = "UNIT_SPELLCAST_START" }, -- 全团AE
			{spellID = 348974, event = "UNIT_SPELLCAST_START" }, -- 软狂暴开始
			{spellID = 350828, role = "tank", event = "UNIT_SPELLCAST_START", unit = "player"}, -- 死亡锁链
			{spellID = 350847, event = "UNIT_SPELLCAST_START", unit = "player"}, -- 躲开队友
			{spellID = 350022, event = "UNIT_SPELLCAST_SUCCEEDED" }, -- 躲开白圈
			{spellID = 351413, event = "UNIT_SPELLCAST_START" }, -- 躲开射线
			{spellID = 346767, event = "BW_AND_DBM_SPELL", dur = 3, countdown = false, addon_only = "DBM"}, -- 准备冥河劫持者			
			{spellID = 358609, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED"}, -- 帮忙锁链
			{spellID = 349979, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED", unit = "player"}, -- 拉断锁链
			{spellID = 348074, role = "tank", event = "UNIT_SPELLCAST_START", unit = "player"}, -- 痛击长枪
			{spellID = 350713, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED" , unit = "player"}, -- 减速
			{spellID = 351827, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED" , unit = "player"}, -- 出去放圈
			{spellID = 350809, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED" , unit = "player"}, -- 快走开
			{spellID = 350604, event = "BW_AND_DBM_SPELL", dur = 5, countdown = true}, -- 准备范围减速 待检查
			{spellID = 350604, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED" , unit = "player"}, -- 躲开队友 待检查
			{spellID = 350606, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED" , unit = "player"}, -- 快走开 待检查
			{spellID = 355245, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED" , unit = "player"}, -- 忿怒点你 待检查
			{spellID = 355240, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED" , unit = "player"}, -- 轻蔑点你 待检查
		},
		HP_Watch = {
			{sub_event = "SPELL_CAST_START", spellID = 349030}, -- 死亡泰坦凝视
		},
		Phase_Change = {
			{sub_event = "SPELL_AURA_REMOVED", spellID = 348805}, -- 冥暗护盾消失
			{sub_event = "SPELL_AURA_APPLIED", spellID = 348805}, -- 冥暗护盾获得
			{sub_event = "SPELL_CAST_START", spellID = 348974}, -- 即刻屠灭
		},
		BossMods = {
			{ -- 死亡锁链 和 痛击长枪
				spellID = 351143,
				role = "tank",
				tip = string.format(L["多人光环提示"], T.GetIconLink(351143).." "..T.GetIconLink(348074)),			
				events = {
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,	
				},
				difficulty_id = {
					["all"] = true,
				},
				init = function(frame)
					frame.aura_spell_ids = {351143, 348074}
					frame.aura_spells = {}
					for i, v in pairs(frame.aura_spell_ids) do
						frame.aura_spells[v] = {aura = GetSpellInfo(v), icon = select(3, GetSpellInfo(v))}
					end
					
					frame.bars = {}
						
					frame.create_bar = function(tag, spellID, player)
						local bar = T.CreateTimerBar(frame, frame.aura_spells[spellID]["icon"], true, false, true)
						bar.spellID = spellID
						bar.name = player
						frame.bars[tag] = bar			
					end
				
					frame.updatebar = function(bar, count, dur, exp_time)
						bar.left:SetText(T.ColorName(bar.name, true))
						
						bar.exp = exp_time
						bar.anim_played = false
						bar:SetMinMaxValues(0 , dur)
						
						bar:SetScript("OnUpdate", function(self, e)
							self.t = self.t + e
							if self.t > self.update_rate then		
								local remain = exp_time - GetTime()
								if remain > 0 then								
									self.right:SetText((count > 0 and "|cffFFFF00["..count.."]|r " or "")..T.FormatTime(remain))
									self:SetValue(dur - remain)
									if remain < 3 then -- 即将消失
										if not self.anim_played then
											self.anim_played = true
											self.glow:Show()
											self.anim:Play()
										end
										self.glow:SetAlpha(self.anim:GetProgress())
									end
								else
									self:Hide()
									self:SetScript("OnUpdate", nil)
									self.anim:Stop()
									self.glow:Hide()
								end
								self.t = 0
							end
						end)											
						bar:Show()
					end
					
					frame.lineup = function()
						local t = {}
						for GUID, bar in pairs(frame.bars) do
							if bar and bar:IsVisible() then
								table.insert(t, bar)
							end
						end
						if #t > 1 then
							table.sort(t, function(a, b) 
								if a.spellID < b.spellID then
									return true
								elseif a.spellID == b.spellID and a.exp < b.exp then
									return true
								end
							end)
						end
						local lastbar
						for i, bar in pairs(t) do
							bar:ClearAllPoints()
							if bar:IsVisible() then
								if not lastbar then
									bar:SetPoint("TOPLEFT", frame, "TOPLEFT", 30, -5)
									lastbar = bar
								else
									bar:SetPoint("TOPLEFT", lastbar, "BOTTOMLEFT", 0, -5)
									lastbar = bar
								end
							end
						end
					end			
				end,
				update = function(frame, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then						
						local _, sub_event, _, _, _, _, _, destGUID, destName, _, _, spellID = CombatLogGetCurrentEventInfo()
						if (sub_event == "SPELL_AURA_APPLIED" or sub_event == "SPELL_AURA_APPLIED_DOSE" or sub_event == "SPELL_AURA_REMOVED_DOSE") and frame.aura_spells[spellID] then						
							local dest = string.split("-", destName)				
							if destGUID and AuraUtil.FindAuraByName(frame.aura_spells[spellID]["aura"], dest, G.Test_Mod and "HELPFUL" or "HARMFUL") then
								local count, _, dur, exp_time = select(3, AuraUtil.FindAuraByName(frame.aura_spells[spellID]["aura"], dest, G.Test_Mod and "HELPFUL" or "HARMFUL"))
								if not frame.bars[spellID.."_"..destGUID] then
									frame.create_bar(spellID.."_"..destGUID, spellID, dest)
								end
								
								local bar = frame.bars[spellID.."_"..destGUID]
								frame.updatebar(bar, count, dur, exp_time)
								
								frame.lineup()
							end
						elseif sub_event == "SPELL_AURA_REMOVED" and frame.aura_spells[spellID] then
							if destGUID and frame.bars[spellID.."_"..destGUID] then
								local bar = frame.bars[spellID.."_"..destGUID]
								bar:Hide()
								bar:SetScript("OnUpdate", nil)
								bar.anim:Stop()
								bar.glow:Hide()
								frame.lineup()
							end
						end
					end	
				end,
				reset = function(frame)
					for tag, bar in pairs(frame.bars) do
						bar:ClearAllPoints()
						bar:Hide()
						bar:SetScript("OnUpdate", nil)
						bar.anim:Stop()
						bar.glow:Hide()
					end				
					frame.bars = table.wipe(frame.bars)
					frame:Hide()
				end,
			},
			{ -- 轻蔑与忿怒
				spellID = 355232,
				tip = L["TIP轻蔑与忿怒"],
				points = {a1 = "CENTER", a2 = "CENTER", x = -0, y = 250, width = 70, height = 70},		
				events = {
					["COMBAT_LOG_EVENT_UNFILTERED"] = true
				},
				difficulty_id = {
					[16] = true,
				},
				init = function(frame)
					frame.spell1 = 355245
					frame.spell2 = 355240
					
					frame.aura1, _, frame.icon1 = GetSpellInfo(frame.spell1)
					frame.aura2, _, frame.icon2 = GetSpellInfo(frame.spell2)
	
					frame.targets1 = {}
					frame.targets2 = {}
					frame.mydebuff = ""
					frame.inrange = {}
					
					frame.playing = false
					
					frame.Play = function()
						if not frame.playing then
							if not SoD_CDB["General"]["disable_sound"] then
								PlaySoundFile(G.media.sounds.."TheEyeOfTheJailer\\danger.ogg", "Master") -- 声音 注意驱散
								frame.playing = true
								C_Timer.After(2, function()
									frame.playing = false
								end)
							end
						end
					end
					
					frame.icon = frame:CreateTexture(nil, "OVERLAY")
					frame.icon:SetTexCoord( .1, .9, .1, .9)
					frame.icon:SetAllPoints(frame)
					T.createborder(frame)
					
					frame.top = T.createtext(frame, "OVERLAY", 15, "OUTLINE", "CENTER")
					frame.top:SetPoint("BOTTOM", frame, "BOTTOM", 0, 0)
					
					frame.bot = T.createtext(frame, "OVERLAY", 15, "OUTLINE", "CENTER")
					frame.bot:SetPoint("TOP", frame, "BOTTOM", 0, 0)
					
					frame.cooldown = CreateFrame('COOLDOWN', nil, frame, "CooldownFrameTemplate")	
					frame.cooldown:SetSize(50, 50)
					frame.cooldown:SetPoint("CENTER", frame, "CENTER", 0, 0)
					frame.cooldown:SetDrawEdge(false)
					
					frame.glow = frame:CreateTexture(nil, "OVERLAY")
					frame.glow:SetPoint("TOPLEFT", -30, 30)
					frame.glow:SetPoint("BOTTOMRIGHT", 30, -30)
					frame.glow:SetTexture([[Interface\SpellActivationOverlay\IconAlert]])
					frame.glow:SetTexCoord(0.00781250, 0.50781250, 0.27734375, 0.52734375)
					frame.glow:Hide()
					
					frame.updateIcon = function(range, icon, start, stack)
						if range then
							local num = 0
							local str = ""
							for name, v in pairs(frame.inrange) do
								if name then
									num = num + 1
									if num <= 3 then
										local coloredName = T.ColorName(name, true)
										str = str.." "..coloredName
									end
								end
							end
							if num > 0 then
								if num > 3 then
									str = str..string.format(L["debuff距离过近"], num)
								end
								frame.glow:Show()
								frame.Play()
							else
								frame.glow:Hide()
							end
							frame.bot:SetText(str)
						end
						
						if start then
							if start > 0 then
								frame.cooldown:SetCooldown(start, 8)
								if stack > 1 then
									frame.top:SetText(stack)
								else
									frame.top:SetText("")
								end
								frame:Show()
							else
								frame.cooldown:SetCooldown(0, 0)
								frame.top:SetText("")
								frame:Hide()
							end
							frame.icon:SetTexture(icon)
						end
					end
					
					frame.GetConfictInrange = function()
						if frame.mydebuff == frame.aura1 then -- 我是忿怒，监测蔑视
							for name, v in pairs(frame.targets2) do
								if name and not UnitIsUnit("player", name) then
									if IsItemInRange(21519, name) then -- 20码
										if not frame.inrange[name] then
											frame.inrange[name] = true
										end
									else
										if frame.inrange[name] then
											frame.inrange[name] = nil
										end
									end
								end
							end
							for name, v in pairs(frame.inrange) do
								if not frame.targets2[name] then
									frame.inrange[name] = nil
								end
							end
						elseif frame.mydebuff == frame.aura2 then -- 我是忿怒，监测蔑视
							for name, v in pairs(frame.targets1) do
								if name and not UnitIsUnit("player", name) then
									if IsItemInRange(21519, name) then -- 20码
										if not frame.inrange[name] then
											frame.inrange[name] = true
										end
									else
										if frame.inrange[name] then
											frame.inrange[name] = nil
										end
									end
								end
							end
							for name, v in pairs(frame.inrange) do
								if not frame.targets1[name] then
									frame.inrange[name] = nil
								end
							end
						end
						frame.updateIcon(true)
					end
					
					frame.t = 0
					frame.update_rate = .5 -- 距离监测间隔
					
					frame:Hide()
				end,
				update = function(frame, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then
						local _, subEvent, _, sourceGUID, _, _, _, _, destName, _, _, spellID, spellName, _, _, amount = CombatLogGetCurrentEventInfo()
						if (subEvent == "SPELL_AURA_APPLIED" or subEvent == "SPELL_AURA_APPLIED_DOSE") then
							if spellID == frame.spell1 and destName then -- 忿怒点名
								--print("忿怒点名")
								local dest = string.split("-", destName)
								if not frame.targets1[dest] and UnitInRaid(dest) then
									frame.targets1[dest] = true
								end
								if dest == G.PlayerName then -- 忿怒点我
									--print("忿怒点我")
									frame.mydebuff = frame.aura1
									frame.inrange = table.wipe(frame.inrange)
									frame.updateIcon(nil, frame.icon1, GetTime(), amount or 1)
									frame:SetScript("OnUpdate", function(self, e)
										self.t = self.t + e
										if self.t > self.update_rate then 
											frame.GetConfictInrange()
											self.t = 0
										end
									end)
									frame:Show()									
								end
								
							elseif spellID == frame.spell2 and destName then -- 蔑视点名
								--print("蔑视点名")
								local dest = string.split("-", destName)
								if not frame.targets2[dest] and UnitInRaid(dest) then
									frame.targets2[dest] = true
								end
								if dest == G.PlayerName then -- 蔑视点我
									--print("蔑视点我")
									frame.mydebuff = frame.aura2
									frame.inrange = table.wipe(frame.inrange)
									frame.updateIcon(nil, frame.icon2, GetTime(), amount or 1)
									frame:SetScript("OnUpdate", function(self, e)
										self.t = self.t + e
										if self.t > self.update_rate then 
											frame.GetConfictInrange()
											self.t = 0
										end
									end)
									frame:Show()
								end
								
							end
						elseif (subEvent == "SPELL_AURA_REMOVED") then
							if spellID == frame.spell1 and destName then -- 忿怒消失
								--print("忿怒消失")
								local dest = string.split("-", destName)
								if frame.targets1[dest] then
									frame.targets1[dest] = nil
									if frame.inrange[dest] then
										frame.GetConfictInrange()
									end
								end
								if dest == G.PlayerName then -- 我的忿怒消失
									--print("我的忿怒消失")
									frame.mydebuff = ""
									frame.inrange = table.wipe(frame.inrange)
									frame:SetScript("OnUpdate", nil)
									frame.updateIcon(nil, 1325309, 0)
									frame:Hide()
								end
							
							elseif spellID == frame.spell2 then -- 蔑视消失
								--print("蔑视消失")
								local dest = string.split("-", destName)
								if frame.targets2[dest] then
									frame.targets2[dest] = nil
									if frame.inrange[dest] then
										frame.GetConfictInrange()
									end
								end
								if dest == G.PlayerName then -- 我的蔑视消失
									--print("我的蔑视消失")
									frame.mydebuff = ""
									frame.inrange = table.wipe(frame.inrange)
									frame:SetScript("OnUpdate", nil)
									frame.updateIcon(nil, 1325309, 0)
									frame:Hide()
								end
								
							end
						end
					elseif event == "ENCOUNTER_START" then
						frame:Hide()
					end		
				end,
				reset = function(frame)
					frame:Hide()
					
					frame.targets1 = table.wipe(frame.targets1)
					frame.targets2 = table.wipe(frame.targets2)
					frame.mydebuff = ""
					frame.inrange = table.wipe(frame.inrange)
					frame.playing = false
					
					frame.top:SetText("")
					frame.cooldown:SetCooldown(0,0)
					frame.glow:Hide()
					
					frame:SetScript("OnUpdate", nil)
					frame.t = 0
				end,
			},			
			{ -- 血量对比监视
				spellID = 351994,
				role = "dps",
				tip = L["TIP垂死苦难"],
				points = {a1 = "CENTER", a2 = "CENTER", x = -0, y = 300, width = 150, height = 50},					
				events = {
					["UNIT_HEALTH"] = true,
				},
				difficulty_id = {
					["all"] = true,
				},
				init = function(frame)
					frame.unit1 = "boss2"
					frame.unit2 = "boss3"
					frame.hp_perc1 = 100
					frame.hp_perc2 = 100
					
					frame.text = T.createtext(frame, "OVERLAY", 25, "OUTLINE", "CENTER")
					frame.text:SetPoint("CENTER")
					
					frame:Hide()
					frame.text:SetText("")
				end,
				update = function(frame, event, unit)
					if unit and (unit == frame.unit1 or unit == frame.unit2) then						
						if unit == frame.unit1 then
							frame.hp_perc1 = UnitHealth(unit)/UnitHealthMax(unit)*100
						elseif unit == frame.unit2 then
							frame.hp_perc2 = UnitHealth(unit)/UnitHealthMax(unit)*100
						end
						
						local target
						if UnitIsUnit("target", frame.unit1) then
							target = frame.unit1 
						elseif UnitIsUnit("target", frame.unit2) then 
							target = frame.unit2
						end
						
						if target and frame.hp_perc1 > 0 and frame.hp_perc2 > 0 then -- 其一死亡后隐藏
							if target == frame.unit1 then
								if frame.hp_perc2>frame.hp_perc1 then
									frame.text:SetText(string.format(L["领先"], frame.hp_perc2-frame.hp_perc1))
								else
									frame.text:SetText(string.format(L["落后"], frame.hp_perc1-frame.hp_perc2))
								end
								frame:Show()
							elseif target == frame.unit2 then
								if frame.hp_perc1>frame.hp_perc2 then
									frame.text:SetText(string.format(L["领先"], frame.hp_perc1-frame.hp_perc2))
								else
									frame.text:SetText(string.format(L["落后"], frame.hp_perc2-frame.hp_perc1))
								end
								frame:Show()
							else
								frame:Hide()
								frame.text:SetText("")
							end
						else
							frame:Hide()
							frame.text:SetText("")		
						end
					end
				end,
				reset = function(frame)
					frame:Hide()
					frame.text:SetText("")
				end,
			},
			{ -- 毁灭凝视
				spellID = 351413,
				tip = L["TIP毁灭凝视"],	
				points = {a1 = "BOTTOM", a2 = "CENTER", x = 0, y = 300, width = 400, height = 40},				
				events = {	
					["UNIT_SPELLCAST_START"] = true,
					["UNIT_SPELLCAST_CHANNEL_START"] = true,
					["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
				},
				difficulty_id = {
					["all"] = true,
				},
				init = function(frame)
					frame.spellName, _, frame.iconTexture = GetSpellInfo(351413)								
					local bar = T.CreateTimerBar(frame, frame.iconTexture, false, false, true, 400, 40, 25, 1, 1, 0)
					
					bar:SetPoint("TOPLEFT", frame, "TOPLEFT")
					bar.left:SetText(frame.spellName)
					
					frame.bar = bar
				end,
				update = function(frame, event, ...)
					local unit, _, spellID = ...
					if unit == "boss1" then
						if event == "UNIT_SPELLCAST_START" and spellID == 351413 then -- 毁灭凝视 开始读条 5s 
	
							frame.bar:SetMinMaxValues(0, 5)
							frame.bar.exp = GetTime() + 5
							
							frame.bar:SetScript("OnUpdate", function(self, e)
								self.t = self.t + e
								if self.t > self.update_rate then
									local remain = self.exp - GetTime()
									if remain > 0 then
										self.right:SetText(T.FormatTime(remain))
										self:SetValue(5 - remain)
									else
										self:Hide()	
										self:SetScript("OnUpdate", nil)
									end
									self.t = 0
								end
							end)
							frame.bar:Show()
						elseif event == "UNIT_SPELLCAST_CHANNEL_START" and spellID == 351413 then -- 毁灭凝视 开始引导 20s
							
							frame.bar:SetMinMaxValues(0, 15)
							frame.bar.exp = GetTime() + 15					
									
							frame.bar:SetScript("OnUpdate", function(self, e)
								self.t = self.t + e
								if self.t > self.update_rate then
									local remain = self.exp - GetTime()
									if remain > 0 then
										self.right:SetText(T.FormatTime(remain))
										self:SetValue(remain)
									else
										self:Hide()	
										self:SetScript("OnUpdate", nil)
									end
									self.t = 0
								end
							end)
							
							frame.bar:Show()
							
						elseif event == "UNIT_SPELLCAST_CHANNEL_STOP" and spellID == 351413 then -- 毁灭凝视 引导结束
						
							frame.bar:Hide()
							frame.bar:SetScript("OnUpdate", nil)
							
						end
					end
				end,
				reset = function(frame)
					frame.bar:Hide()
					frame.bar:SetScript("OnUpdate", nil)
				end,
			},	
		},	
	},
}

G.Encounters[3] = { -- 九武神 已过初检
	id = 2439,
	engage_id = 2429,
	npc_id = "177095", 
	img = 4071445,
	alerts = {
		AlertIcon = {
			{type = "cast", tip = "远离", hl = "hl", spellID = 350365}, -- 愤怒之翼
			{type = "cast", tip = "远离", hl = "hl", spellID = 352756}, -- 愤怒之翼 待检查
			{type = "cast", tip = "小怪", role = "dps", hl = "hl", spellID = 350342}, -- 无形物质					
			{type = "com", role = "tank", hl = "hl", spellID = 350202}, -- 无尽之击
			{type = "aura", role = "tank", hl = "no", spellID = 350202, aura_type = "HARMFUL", unit = "player"}, -- 无尽之击
			
			{type = "cast", tip = "靠近", hl = "hl", spellID = 350385}, -- 激荡高歌
			{type = "cast", tip = "靠近", hl = "hl", spellID = 352752}, -- 激荡高歌 待检查
			{type = "cast", tip = "打断", hl = "hl", spellID = 350286}, -- 终约之歌
			{type = "com", role = "tank", hl = "no", spellID = 350283}, -- 灵魂爆炸 待检查
						
			{type = "cast", hl = "hl", spellID = 350467}, -- 瓦格里的召唤
			{type = "aura", tip = "远离", hl = "hl", spellID = 350184, aura_type = "HARMFUL", unit = "player"}, -- 达丝琪拉的威猛冲击
			{type = "aura", tip = "分担", hl = "hl", spellID = 350039, aura_type = "HARMFUL", unit = "player"}, -- 阿尔苏拉的粉碎凝视
			{type = "aura", tip = "分散", hl = "hl", spellID = 350109, aura_type = "HARMFUL", unit = "player"}, -- 布琳佳的悲恸挽歌
			
			{type = "com", role = "tank", hl = "hl", spellID = 350475}, -- 灵魂穿透
			{type = "aura", role = "tank", hl = "no", spellID = 350475, aura_type = "HARMFUL", unit = "player"}, -- 灵魂穿透
			
			{type = "log", tip = "点名出去", hl = "hl", spellID = 350541, event_type = "SPELL_CAST_START", dur = 2}, -- 命运残片
			{type = "log", tip = "点名出去", hl = "hl", spellID = 352744, dif = {[16] = true}, event_type = "SPELL_CAST_START", dur = 2}, -- 命运残片 待检查
			{type = "aura", tip = "残片点你", hl = "hl", spellID = 350542, aura_type = "HARMFUL", unit = "player"}, -- 命运残片
			{type = "aura", tip = "别踩", hl = "hl", spellID = 350555, aura_type = "HARMFUL", unit = "player"}, -- 命运碎片 

			{type = "cast", tip = "全团AE", hl = "hl", spellID = 355294}, -- 积怨
			{type = "aura", tip = "全团AE", hl = "no", spellID = 355294, aura_type = "HELPFUL", unit = "boss1"}, -- 积怨
			
			{type = "cast", tip = "被点自保", hl = "hl", spellID = 350482}, -- 联结精华
			{type = "aura", tip = "自保", hl = "no", spellID = 350483, aura_type = "HARMFUL", unit = "player"}, -- 联结精华
			
			{type = "cast", tip = "重复大招", hl = "no", spellID = 350687}, -- 召回咒文 已检查
		},
		HLOnRaid = {
			{type = "HLAuras", spellID = 350202}, -- 无尽之击
			{type = "HLAuras", spellID = 350475}, -- 灵魂穿透
			{type = "HLAuras", spellID = 350109}, -- 布琳佳的悲恸挽歌
			{type = "HLAuras", spellID = 351139}, -- 布琳佳的悲恸挽歌
			{type = "HLAuras", spellID = 350542}, -- 命运残片
		},
		TextAlert = {
			{
				type = "pp",
				data = {
					unit = "boss1",
					npc_id = "175726",
					ranges = {
						{ ul = 99, ll = 85, tip = L["即将召唤"]},
					},
				},
			},
		}, 
		PlateAlert = {
			{type = "PlateAuras", spellID = 350158}, -- 安海尔德的明光之盾
			{type = "PlateSpells", spellID = 350339, spellCD = 1, mobID = "177407", hl_np = true}, -- 活力虹吸{type = "PlateSpells", spellID = 350339, spellCD = 1, mobID = "177407"}, -- 活力虹吸	 		
		},
		ChatMsg = {		
			{type = "ChatMsgAuraCountdown", spellID = 350184, playername = true, spellname = true, icon = 1}, -- 达丝琪拉的威猛冲击 
			{type = "ChatMsgRange", range_event = "SPELL_AURA_APPLIED", spellID = 350109, range = 5}, -- 布琳佳的悲恸挽歌
			{type = "ChatMsgRange", range_event = "SPELL_AURA_APPLIED", spellID = 351139, range = 5}, -- 布琳佳的悲恸挽歌
			{type = "ChatMsgAuraCountdown", spellID = 350039, playername = true, spellname = true, icon = 3}, -- 阿尔苏拉的粉碎凝视
			{type = "ChatMsgAuraRepeat", spellID = 350542, playername = true, spellname = false, icon = 6}, -- 命运残片 待检查
		},
		Sound = {	
			{spellID = 350365, event = "UNIT_SPELLCAST_START"}, -- 远离基拉	
			{spellID = 352756, event = "UNIT_SPELLCAST_START"}, -- 远离基拉 待检查
			{spellID = 350342, role = "dps", event = "UNIT_SPELLCAST_START"}, -- 小怪出现	
			{spellID = 350202, role = "tank", event = "UNIT_SPELLCAST_START", unit = "player" }, -- 无尽之击	
			{spellID = 350385, event = "UNIT_SPELLCAST_START"}, -- 靠近席格妮
			{spellID = 352752, event = "UNIT_SPELLCAST_START"}, -- 靠近席格妮 待检查
			{spellID = 350541, event = "BW_AND_DBM_SPELL", dur = 3, countdown = false, addon_only = "DBM"}, -- 准备命运残片
			{spellID = 350542, event = "BW_AND_DBM_SPELL", dur = 3, countdown = false, addon_only = "BW"}, -- 准备命运残片
			{spellID = 352744, event = "UNIT_SPELLCAST_START"}, -- 命运残片
			{spellID = 350541, event = "UNIT_SPELLCAST_START"}, -- 命运残片
			{spellID = 350542, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED" , unit = "player"}, -- 残片点你
			{spellID = 350555, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED" , unit = "player"}, -- 快走开
			{spellID = 350467, event = "UNIT_SPELLCAST_START"}, -- 瓦格里的召唤
			{spellID = 350483, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED" , unit = "player"}, -- 规避伤害
			{spellID = 350475, role = "tank", event = "UNIT_SPELLCAST_START", unit = "player"}, -- 灵魂穿透
			{spellID = 355294, event = "UNIT_SPELLCAST_START"}, -- 全团AE			
		},
		HP_Watch = {
			{sub_event = "SPELL_AURA_APPLIED", on_me = true, spellID = 350542}, -- 命运残片
		},
		Phase_Change = {
			{empty = true},
			{sub_event = "SPELL_CAST_SUCCESS", spellID = 350745}, -- 斯凯亚的攻势
		},
		BossMods = {
			{ -- 无尽之击 和 灵魂穿透
				spellID = 350202,
				role = "tank",
				tip = string.format(L["多人光环提示"], T.GetIconLink(350202).." "..T.GetIconLink(350475)),			
				points = {a1 = "TOPLEFT", a2 = "CENTER", x = -700, y = 200, width = 250, height = 100},	
				events = {
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,	
				},
				difficulty_id = {
					["all"] = true,
				},
				init = function(frame)
					frame.aura_spell_ids = {350202, 350475}
					frame.aura_spells = {}
					for i, v in pairs(frame.aura_spell_ids) do
						frame.aura_spells[v] = {aura = GetSpellInfo(v), icon = select(3, GetSpellInfo(v))}
					end
					
					frame.bars = {}
						
					frame.create_bar = function(tag, spellID, player)
						local bar = T.CreateTimerBar(frame, frame.aura_spells[spellID]["icon"], true, false, true)
						bar.spellID = spellID
						bar.name = player
						frame.bars[tag] = bar			
					end
				
					frame.updatebar = function(bar, count, dur, exp_time)
						bar.left:SetText(T.ColorName(bar.name, true))
						
						bar.exp = exp_time
						bar.anim_played = false
						bar:SetMinMaxValues(0 , dur)
						
						bar:SetScript("OnUpdate", function(self, e)
							self.t = self.t + e
							if self.t > self.update_rate then		
								local remain = exp_time - GetTime()
								if remain > 0 then								
									self.right:SetText((count > 0 and "|cffFFFF00["..count.."]|r " or "")..T.FormatTime(remain))
									self:SetValue(dur - remain)
									if remain < 3 then -- 即将消失
										if not self.anim_played then
											self.anim_played = true
											self.glow:Show()
											self.anim:Play()
										end
										self.glow:SetAlpha(self.anim:GetProgress())
									end
								else
									self:Hide()
									self:SetScript("OnUpdate", nil)
									self.anim:Stop()
									self.glow:Hide()
								end
								self.t = 0
							end
						end)											
						bar:Show()
					end
					
					frame.lineup = function()
						local t = {}
						for GUID, bar in pairs(frame.bars) do
							if bar and bar:IsVisible() then
								table.insert(t, bar)
							end
						end
						if #t > 1 then
							table.sort(t, function(a, b) 
								if a.spellID < b.spellID then
									return true
								elseif a.spellID == b.spellID and a.exp < b.exp then
									return true
								end
							end)
						end
						local lastbar
						for i, bar in pairs(t) do
							bar:ClearAllPoints()
							if bar:IsVisible() then
								if not lastbar then
									bar:SetPoint("TOPLEFT", frame, "TOPLEFT", 30, -5)
									lastbar = bar
								else
									bar:SetPoint("TOPLEFT", lastbar, "BOTTOMLEFT", 0, -5)
									lastbar = bar
								end
							end
						end
					end			
				end,
				update = function(frame, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then						
						local _, sub_event, _, _, _, _, _, destGUID, destName, _, _, spellID = CombatLogGetCurrentEventInfo()
						if (sub_event == "SPELL_AURA_APPLIED" or sub_event == "SPELL_AURA_APPLIED_DOSE" or sub_event == "SPELL_AURA_REMOVED_DOSE") and frame.aura_spells[spellID] then						
							local dest = string.split("-", destName)				
							if destGUID and AuraUtil.FindAuraByName(frame.aura_spells[spellID]["aura"], dest, G.Test_Mod and "HELPFUL" or "HARMFUL") then
								local count, _, dur, exp_time = select(3, AuraUtil.FindAuraByName(frame.aura_spells[spellID]["aura"], dest, G.Test_Mod and "HELPFUL" or "HARMFUL"))
								if not frame.bars[spellID.."_"..destGUID] then
									frame.create_bar(spellID.."_"..destGUID, spellID, dest)
								end
								
								local bar = frame.bars[spellID.."_"..destGUID]
								frame.updatebar(bar, count, dur, exp_time)
								
								frame.lineup()
							end
						elseif sub_event == "SPELL_AURA_REMOVED" and frame.aura_spells[spellID] then
							if destGUID and frame.bars[spellID.."_"..destGUID] then
								local bar = frame.bars[spellID.."_"..destGUID]
								bar:Hide()
								bar:SetScript("OnUpdate", nil)
								bar.anim:Stop()
								bar.glow:Hide()
								frame.lineup()
							end
						end
					end	
				end,
				reset = function(frame)
					for tag, bar in pairs(frame.bars) do
						bar:ClearAllPoints()
						bar:Hide()
						bar:SetScript("OnUpdate", nil)
						bar.anim:Stop()
						bar.glow:Hide()
					end				
					frame.bars = table.wipe(frame.bars)
					frame:Hide()
				end,
			},
			{ -- 命运残片驱散
				spellID = 350542,
				tip = L["TIP命运残片"],
				points = {hide = true},
				events = {
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,	
				},
				difficulty_id = {
					["all"] = true,
				},
				init = function(frame)
					frame.aura = GetSpellInfo(350542)
					
					frame.targets = {}
					
					frame.scan_raid = function() -- 获取团队整体debuff情况
						frame.targets = table.wipe(frame.targets) -- 重置
						local group_size = GetNumGroupMembers()
						for i = 1, group_size do
							local unit_id = "raid"..i
							if AuraUtil.FindAuraByName(frame.aura, unit_id, "HARMFUL") then
								local stack = select(3, AuraUtil.FindAuraByName(frame.aura, unit_id, "HARMFUL"))
								if stack and stack > 0 then
									if not frame.targets[stack] then
										frame.targets[stack] = {}
									end
									local target_player = UnitName(unit_id)
									table.insert(frame.targets[stack], target_player)
								end
							end
						end
					end
					
					frame.hl_raid = function(stack) -- 显示高亮边框
						if not stack then
							for s, t in pairs(frame.targets) do
								for i, player in pairs(t) do
									T.GlowRaidFrame_Show(player, "dispel350542")
								end
							end
						elseif frame.targets[stack] then
							for i, player in pairs(frame.targets[stack]) do
								T.GlowRaidFrame_Show(player, "dispel350542")
							end
						end
					end
				end,
				update = function(frame, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then
						local timestamp, sub_event, _, sourceGUID, _, _, _, _, destName, _, _, spellID, spellName = CombatLogGetCurrentEventInfo()
						if sub_event == "SPELL_CAST_SUCCESS" and (spellID == 352744 or spellID == 350541) then -- 施放法术
							--print(sub_event, "cast", spellID, spellName)
							C_Timer.After(.2, function() -- 延迟
								frame.scan_raid()	
								if not SoD_CDB["General"]["disable_sound"] then
									PlaySoundFile(G.media.sounds.."TheNine\\dispel1.ogg", "Master") -- 声音 驱散1
								end
								frame.hl_raid() -- 高亮所有人
							end)
						elseif sub_event == "SPELL_AURA_REMOVED" and spellID == 350542 then	-- 驱散时
							--print(sub_event, destName, spellID, spellName)
							if destName == G.PlayerName then -- 我被驱散
								if not SoD_CDB["General"]["disable_sound"] then
									PlaySoundFile(G.media.sounds.."move.ogg", "Master") -- 声音 快走开
								end
							end
							C_Timer.After(1, function() -- 延迟	
								T.GlowRaidFrame_HideAll("dispel350542") -- 去掉所有高亮
								frame.scan_raid()
								
								local difficultyID = select(3, GetInstanceInfo())
								if difficultyID	== 16 then
									if frame.targets[1] then -- 驱散1、2或3
										if frame.targets[1] and #frame.targets[1] == 2 then -- 1+1+2
											--print("驱散2 112")
											if not SoD_CDB["General"]["disable_sound"] then
												PlaySoundFile(G.media.sounds.."TheNine\\dispel2.ogg", "Master") -- 声音 驱散2
											end
											frame.hl_raid(1) -- 高亮1层的2人
										elseif frame.targets[1] and #frame.targets[1] == 1 then -- 1+3
											--print("驱散3 1+3")
											if not SoD_CDB["General"]["disable_sound"] then
												PlaySoundFile(G.media.sounds.."TheNine\\dispel3.ogg", "Master") -- 声音 驱散3
											end
											frame.hl_raid() -- 高亮所有人
										elseif frame.targets[1] and #frame.targets[1] == 4 then
											--print("驱散1 1111")
											if not SoD_CDB["General"]["disable_sound"] then
												PlaySoundFile(G.media.sounds.."TheNine\\dispel1.ogg", "Master") -- 声音 驱散1
											end
											frame.hl_raid() -- 高亮所有人
										end
									elseif frame.targets[2] and #frame.targets[2] == 2 then -- 2+2
										--print("驱散3 2+2")
										if not SoD_CDB["General"]["disable_sound"] then
											PlaySoundFile(G.media.sounds.."TheNine\\dispel3.ogg", "Master") -- 声音 驱散3
										end
										frame.hl_raid() -- 高亮所有人
									end
								else
									if frame.targets[2] and #frame.targets[2] == 1 then -- 1+2
										--print("驱散2 1+2")
										if not SoD_CDB["General"]["disable_sound"] then
											PlaySoundFile(G.media.sounds.."TheNine\\dispel2.ogg", "Master") -- 声音 驱散2
										end
										frame.hl_raid(1) -- 高亮1层的2人
									elseif frame.targets[1] and #frame.targets[1] == 3 then
										--print("驱散1 111")
										if not SoD_CDB["General"]["disable_sound"] then
											PlaySoundFile(G.media.sounds.."TheNine\\dispel1.ogg", "Master") -- 声音 驱散1
										end
										frame.hl_raid() -- 高亮所有人
									end
								end
							end)
						end
					end
				end,
				reset = function(frame)
					frame.targets = table.wipe(frame.targets)
					T.GlowRaidFrame_HideAll()
				end,
			},
			{ -- 血量对比监视
				spellID = 350745,
				role = "dps",
				tip = L["TIP斯凯亚"],
				points = {a1 = "CENTER", a2 = "CENTER", x = -0, y = 300, width = 150, height = 50},				
				events = {
					["UNIT_HEALTH"] = true,
				},
				difficulty_id = {
					["all"] = true,
				},
				init = function(frame)
					frame.unit1 = "boss2"
					frame.unit2 = "boss3"
					frame.hp_perc1 = 100
					frame.hp_perc2 = 100
					
					frame.text = T.createtext(frame, "OVERLAY", 25, "OUTLINE", "CENTER")
					frame.text:SetPoint("CENTER")
					
					frame:Hide()
					frame.text:SetText("")
				end,
				update = function(frame, event, unit)
					if unit and (unit == frame.unit1 or unit == frame.unit2) then						
						if unit == frame.unit1 then
							frame.hp_perc1 = UnitHealth(unit)/UnitHealthMax(unit)*100
						elseif unit == frame.unit2 then
							frame.hp_perc2 = UnitHealth(unit)/UnitHealthMax(unit)*100
						end
						
						local target
						if UnitIsUnit("target", frame.unit1) then
							target = frame.unit1 
						elseif UnitIsUnit("target", frame.unit2) then 
							target = frame.unit2
						end
						
						if target and frame.hp_perc1 >= 20 and frame.hp_perc2 >= 20 then -- 斯凯亚入场后隐藏
							if target == frame.unit1 then
								if frame.hp_perc2>frame.hp_perc1 then
									frame.text:SetText(string.format(L["领先"], frame.hp_perc2-frame.hp_perc1))
								else
									frame.text:SetText(string.format(L["落后"], frame.hp_perc1-frame.hp_perc2))
								end
								frame:Show()
							elseif target == frame.unit2 then
								if frame.hp_perc1>frame.hp_perc2 then
									frame.text:SetText(string.format(L["领先"], frame.hp_perc1-frame.hp_perc2))
								else
									frame.text:SetText(string.format(L["落后"], frame.hp_perc2-frame.hp_perc1))
								end
								frame:Show()
							else
								frame:Hide()
								frame.text:SetText("")
							end
						else
							frame:Hide()
							frame.text:SetText("")
						end
					end
				end,
				reset = function(frame)
					frame:Hide()
					frame.text:SetText("")
				end,
			},
			{ -- 瓦格里的召唤
				spellID = 350467,
				tip = L["TIP召回咒文"],			
				events = {
					["UNIT_SPELLCAST_SUCCEEDED"] = true,
					["CHAT_MSG_MONSTER_YELL"] = true,
				},
				difficulty_id = {
					[15] = true,
					[16] = true,
				},
				init = function(frame)				
					frame.info = T.createtext(frame, "OVERLAY", 20, "OUTLINE", "LEFT")	
					frame.info:SetPoint("TOPLEFT", frame, "TOPLEFT", 5, -5)
					frame.info:SetText(L["已放技能"])
					
					frame.texts = {}
					frame.spells = {}
					frame.create_text = function(bossName, spellID, str)				
						local text = T.createtext(frame, "OVERLAY", 20, "OUTLINE", "LEFT")	
						text:SetText(T.GetSpellIcon(spellID).." "..str)
						text:Hide()
						
						frame.texts[bossName] = text
						frame.spells[bossName] = spellID
					end
					
					frame.lineup = function()
						local lasttext
						for boss, text in pairs(frame.texts) do
							text:ClearAllPoints()
							if text:IsVisible() then
								if not lasttext then
									text:SetPoint("TOPLEFT", frame, "TOPLEFT", 5, -25)
								else
									text:SetPoint("TOPLEFT", lasttext, "BOTTOMLEFT", 0, -5)							
								end
								lasttext = text
							end
						end
					end
					
					frame.bossid = {
						["177171"] = {350031, L["boss177171"]}, --躲开射线
						["177099"] = {350184, L["boss177099"]}, --点名出去
						["177097"] = {350158, L["boss177097"]}, --护盾出现
						["177222"] = {350098, L["boss177222"]}, --注意接圈
						["177101"] = {350109, L["boss177101"]}, --5码分散
						["177098"] = {350039, L["boss177098"]}, --分担伤害
					}
					
					for npcID, args in pairs(frame.bossid) do
						local name = T.GetNameFromNpcID(npcID)
						if name then
							frame.create_text(name, args[1], args[2])
						end
					end
					
					frame.startTracking = false
					frame:Hide()
				end,
				update = function(frame, event, ...)
					if event == "UNIT_SPELLCAST_SUCCEEDED" then						
						local _, _, spellID  = ...
						if frame.startTracking and spellID == 350687 then -- 召回咒文 
							for boss, text in pairs(frame.texts) do
								text:ClearAllPoints()
								text:Hide()
							end
							if not SoD_CDB["General"]["disable_sound"] then
								PlaySoundFile(G.media.sounds.."TheNine\\recall.ogg", "Master") -- 声音 重复技能组合
							end
						elseif spellID == 350745 then -- 斯凯亚的攻势
							frame.startTracking = true
							frame:Show()
						end
					elseif event == "CHAT_MSG_MONSTER_YELL" then
						local _, bossName = ...
						if frame.startTracking and frame.texts[bossName] then
							frame.texts[bossName]:Show()
							frame.lineup()
						end
						if frame.spells[bossName] and not SoD_CDB["General"]["disable_sound"] then
							PlaySoundFile(G.media.sounds.."TheNine\\"..frame.spells[bossName].."cast.ogg", "Master") -- 特殊技能声音
						end
					end
				end,
				reset = function(frame)
					frame.startTracking = false
					frame:Hide()
				end,
			},
		},
	},
}

G.Encounters[4] = { -- 耐奥祖的残迹 已过初检
	id = 2444,
	engage_id = 2432,
	npc_id = "175729", 
	img = 4071439,
	alerts = {
		AlertIcon = {
			{type = "cast", tip = "召唤宝珠", hl = "hl", spellID = 349908}, -- 折磨宝珠 待检查
			{type = "aura", tip = "注意自保", hl = "no", spellID = 350073, aura_type = "HARMFUL", unit = "player"}, -- 折磨 已检查
			{type = "aura", tip = "拾起宝珠", hl = "no", spellID = 350388, aura_type = "HARMFUL", unit = "player"}, -- 悲伤前行 待检查
			{type = "cast", tip = "准备驱散", hl = "hl", spellID = 350469}, -- 怨毒 已检查
			{type = "aura", tip = "怨毒点你", hl = "no", spellID = 350469, aura_type = "HARMFUL", unit = "player"}, -- 怨毒 待检查
			{type = "aura", tip = "别踩", hl = "no", spellID = 350489, dif = {[15] = true, [16] = true}, aura_type = "HARMFUL", unit = "player"}, -- 怨毒残迹 待检查
			{type = "cast", role = "tank", hl = "hl", spellID = 350894}, -- 苦难 已检查 
			{type = "aura", role = "tank", hl = "no", spellID = 349890, aura_type = "HARMFUL", unit = "player"}, -- 苦难 已检查
			{type = "cast", tip = "躲地板", hl = "hl", spellID = 355123}, -- 怨恨之握 已检查
			{type = "aura", tip = "沉默", hl = "no", spellID = 354534, aura_type = "HARMFUL", unit = "player"}, -- 怨恨 待检查
			{type = "cast", tip = "P2 复制冲击", hl = "hl", spellID = 351066}, -- 碎裂 已检查
			{type = "cast", tip = "P3 复制地板", hl = "hl", spellID = 351067}, -- 碎裂 已检查
			{type = "cast", tip = "P4 复制击飞", hl = "hl", spellID = 351073}, -- 碎裂 已检查
		},
		HLOnRaid = {
			{type = "HLAuras", spellID = 350388}, -- 悲伤前行 已检查
			{type = "HLAuras", spellID = 349890}, -- 苦难 待检查
			{type = "HLAuras", spellID = 350469, Glow = true}, -- 怨毒 已检查
			{type = "HLAuras", spellID = 350073, stack = 2}, -- 折磨 已检查
		},
		PlateAlert = {
			{type = "PlateAuras", spellID = 355790}, -- 永恒折磨 已检查
		},
		TextAlert = {
			{	-- 已检查
				type = "hp",
				data = {
					unit = "boss1",
					npc_id = "175729",
					ranges = {
						{ ul = 85, ll = 80.5, tip = string.format(L["阶段转换"], "80")},
						{ ul = 65, ll = 60.5, tip = string.format(L["阶段转换"], "60")},
						{ ul = 35, ll = 30.5, tip = string.format(L["阶段转换"], "30")},
					},
				},
			},
			{	-- 已检查
				type = "pp",
				data = {
					unit = "boss1",
					npc_id = "175729",
					ranges = {
						{ ul = 99, ll = 80, tip = L["准备苦难"]},
					},
				},
			},
		},
		ChatMsg = {
			{type = "ChatMsgCom", role="tank", spellID = 350894, playername = true, spellname = true, icon = 2}, -- 苦难
			{type = "ChatMsgAuras", spellID = 350469, playername = true, spellname = true, icon = 1}, -- 怨毒 已检查
		},
		Sound = {
			{spellID = 349908, event = "UNIT_SPELLCAST_SUCCEEDED" }, -- 召唤宝珠
			{spellID = 350469, event = "BW_AND_DBM_SPELL", dur = 5, countdown = true}, -- 准备点怨毒				
			{spellID = 350469, event = "UNIT_SPELLCAST_START" }, -- 点名怨毒
			{spellID = 350469, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED" , unit = "player", countdown = true}, -- 怨毒点你
			{spellID = 350489, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED" , unit = "player"}, -- 快走开	
			{spellID = 350894, role = "tank", event = "UNIT_SPELLCAST_START" }, -- 正面冲击
			{spellID = 355123, event = "UNIT_SPELLCAST_START" }, -- 躲地板			
			{spellID = 351066, event = "UNIT_SPELLCAST_START" }, -- P2 复制冲击
			{spellID = 351067, event = "UNIT_SPELLCAST_START" }, -- P3 复制地板
			{spellID = 351073, event = "UNIT_SPELLCAST_START" }, -- P4 复制击飞	
		},
		HP_Watch = {
			{sub_event = "SPELL_CAST_START", spellID = 351066}, -- 碎裂
			{sub_event = "SPELL_CAST_START", spellID = 351067}, -- 碎裂
			{sub_event = "SPELL_CAST_START", spellID = 351073}, -- 碎裂		
		},
		Phase_Change = {
			{empty = true},
			{sub_event = "SPELL_CAST_START", spellID = 351066}, -- 碎裂
			{sub_event = "SPELL_CAST_START", spellID = 351067}, -- 碎裂
			{sub_event = "SPELL_CAST_START", spellID = 351073}, -- 碎裂		
		},
		BossMods = {
			{ -- 苦难
				spellID = 349890,
				role = "tank",
				tip = string.format(L["多人光环提示"], T.GetIconLink(349890)),			
				points = {a1 = "TOPLEFT", a2 = "CENTER", x = -700, y = 250, width = 250, height = 100},	
				events = {
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,	
				},
				difficulty_id = {
					["all"] = true,
				},
				init = function(frame)
					frame.aura_spell_ids = {349890}
					frame.aura_spells = {}
					for i, v in pairs(frame.aura_spell_ids) do
						frame.aura_spells[v] = {aura = GetSpellInfo(v), icon = select(3, GetSpellInfo(v))}
					end
					
					frame.bars = {}
						
					frame.create_bar = function(tag, spellID, player)
						local bar = T.CreateTimerBar(frame, frame.aura_spells[spellID]["icon"], true, false, true)
						bar.spellID = spellID
						bar.name = player
						frame.bars[tag] = bar			
					end
				
					frame.updatebar = function(bar, count, dur, exp_time)
						bar.left:SetText(T.ColorName(bar.name, true))
						
						bar.exp = exp_time
						bar.anim_played = false
						bar:SetMinMaxValues(0 , dur)
						
						bar:SetScript("OnUpdate", function(self, e)
							self.t = self.t + e
							if self.t > self.update_rate then		
								local remain = exp_time - GetTime()
								if remain > 0 then								
									self.right:SetText((count > 0 and "|cffFFFF00["..count.."]|r " or "")..T.FormatTime(remain))
									self:SetValue(dur - remain)
									if remain < 3 then -- 即将消失
										if not self.anim_played then
											self.anim_played = true
											self.glow:Show()
											self.anim:Play()
										end
										self.glow:SetAlpha(self.anim:GetProgress())
									end
								else
									self:Hide()
									self:SetScript("OnUpdate", nil)
									self.anim:Stop()
									self.glow:Hide()
								end
								self.t = 0
							end
						end)											
						bar:Show()
					end
					
					frame.lineup = function()
						local t = {}
						for GUID, bar in pairs(frame.bars) do
							if bar and bar:IsVisible() then
								table.insert(t, bar)
							end
						end
						if #t > 1 then
							table.sort(t, function(a, b) 
								if a.spellID < b.spellID then
									return true
								elseif a.spellID == b.spellID and a.exp < b.exp then
									return true
								end
							end)
						end
						local lastbar
						for i, bar in pairs(t) do
							bar:ClearAllPoints()
							if bar:IsVisible() then
								if not lastbar then
									bar:SetPoint("TOPLEFT", frame, "TOPLEFT", 30, -5)
									lastbar = bar
								else
									bar:SetPoint("TOPLEFT", lastbar, "BOTTOMLEFT", 0, -5)
									lastbar = bar
								end
							end
						end
					end			
				end,
				update = function(frame, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then						
						local _, sub_event, _, _, _, _, _, destGUID, destName, _, _, spellID = CombatLogGetCurrentEventInfo()
						if (sub_event == "SPELL_AURA_APPLIED" or sub_event == "SPELL_AURA_APPLIED_DOSE" or sub_event == "SPELL_AURA_REMOVED_DOSE") and frame.aura_spells[spellID] then						
							local dest = string.split("-", destName)				
							if destGUID and AuraUtil.FindAuraByName(frame.aura_spells[spellID]["aura"], dest, G.Test_Mod and "HELPFUL" or "HARMFUL") then
								local count, _, dur, exp_time = select(3, AuraUtil.FindAuraByName(frame.aura_spells[spellID]["aura"], dest, G.Test_Mod and "HELPFUL" or "HARMFUL"))
								if not frame.bars[spellID.."_"..destGUID] then
									frame.create_bar(spellID.."_"..destGUID, spellID, dest)
								end
								
								local bar = frame.bars[spellID.."_"..destGUID]
								frame.updatebar(bar, count, dur, exp_time)
								
								frame.lineup()
							end
						elseif sub_event == "SPELL_AURA_REMOVED" and frame.aura_spells[spellID] then
							if destGUID and frame.bars[spellID.."_"..destGUID] then
								local bar = frame.bars[spellID.."_"..destGUID]
								bar:Hide()
								bar:SetScript("OnUpdate", nil)
								bar.anim:Stop()
								bar.glow:Hide()
								frame.lineup()
							end
						end
					end	
				end,
				reset = function(frame)
					for tag, bar in pairs(frame.bars) do
						bar:ClearAllPoints()
						bar:Hide()
						bar:SetScript("OnUpdate", nil)
						bar.anim:Stop()
						bar.glow:Hide()
					end				
					frame.bars = table.wipe(frame.bars)
					frame:Hide()
				end,
			},
			{ -- 群体驱散 已检查
				spellID = 32375,
				tip = L["TIP群体驱散读条"],
				points = {a1 = "BOTTOM", a2 = "CENTER", x = 0, y = 300, width = 400, height = 40},		
				events = {	
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,
				},
				difficulty_id = {
					["all"] = true,
				},
				init = function(frame)
					frame.spellID = 32375
					frame.spellName, _, frame.iconTexture = GetSpellInfo(frame.spellID)
					frame.cast_dur = 1.3					
					local bar = T.CreateTimerBar(frame, frame.iconTexture, false, true, true, 400, 40, 25, 1, 1, 0)
					
					bar:SetPoint("TOPLEFT", frame, "TOPLEFT")
					bar:SetMinMaxValues(0, frame.cast_dur)
					
					frame.bar = bar
				end,
				update = function(frame, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then
						local timestamp, sub_event, _, sourceGUID, sourceName, _, _, _, destName, _, _, spellID, spellName = CombatLogGetCurrentEventInfo()
						if sub_event == "SPELL_CAST_START" and spellID == frame.spellID then -- 群体驱散 开始读条
							local source = string.split("-", sourceName)
							frame.bar.left:SetText(frame.spellName)
							frame.bar.mid:SetText(T.ColorName(source, true))
							
							if not SoD_CDB["General"]["disable_sound"] then
								PlaySoundFile(G.media.sounds.."RemnantofNerzhul\\massdispel.ogg", "Master") -- 语音 群体驱散
							end
							
							frame.bar:Show()
							frame.bar.exp = GetTime() + frame.cast_dur				
									
							frame.bar:SetScript("OnUpdate", function(self, e)
								self.t = self.t + e
								if self.t > self.update_rate then
									local remain = self.exp - GetTime()
									if remain > 0 then
										self.right:SetText(T.FormatTime(remain))
										self:SetValue(frame.cast_dur - remain)
									else
										self.left:SetText("")
										self.mid:SetText("")
										self.right:SetText("")
										self:Hide()	
										self:SetScript("OnUpdate", nil)
									end
									self.t = 0
								end
							end)
						elseif sub_event == "SPELL_CAST_FAILED" and spellID == frame.spellID then -- 群体驱散 被打断
							frame.bar:SetScript("OnUpdate", nil)
							frame.bar.right:SetText(L["施法中断"])
							C_Timer.After(.2 ,function()
								frame.bar:Hide()
								frame.bar.left:SetText("")
								frame.bar.mid:SetText("")
								frame.bar.right:SetText("")	
							end)
						end
					end
				end,
				reset = function(frame)
					frame.bar.left:SetText("")
					frame.bar.mid:SetText("")
					frame.bar.right:SetText("")
					frame.bar:Hide()
					frame.bar:SetScript("OnUpdate", nil)
				end,
			},				
			{ -- 怨恨 已检查
				spellID = 354534,
				tip = L["TIP怨恨"],
				points = {a1 = "TOPLEFT", a2 = "CENTER", x = -400, y = -30, width = 250, height = 30},	
				events = {
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,
				},
				difficulty_id = {
					["all"] = true,
				},
				init = function(frame)
					frame.iconTexture = select(3, GetSpellInfo(354534))
					frame.spell_index = { -- 转阶段怨恨
						--M
						[354519] = true, -- p2
						[354626] = true, -- p3
						[354531] = true, -- p4
						--H
						[354439] = true, -- p2 已确认
						[354441] = true, -- p3 已确认
						[354440] = true, -- p4 已确认
						--Test
						--[100780] = true, -- test			
					}
					
					local bar = T.CreateTimerBar(frame, frame.iconTexture, true, false, true)
					
					bar:SetPoint("TOPLEFT", frame, "TOPLEFT", 32, -2)
					bar:SetStatusBarColor(0, .8, 1)
					bar:SetMinMaxValues(0, 15)
					
					frame.bar = bar
				end,
				update = function(frame, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then

						local timestamp, sub_event, _, _, _, _, _, _, _, _, _, spellID, spellName = CombatLogGetCurrentEventInfo()
						if sub_event == "SPELL_CAST_SUCCESS" and frame.spell_index[spellID] then
							frame.bar.wave = 1
							frame.bar.last_wave = 0
							frame.bar.start = GetTime()
							
							frame.bar:SetScript("OnUpdate", function(self, e)
								self.t = self.t + e
								if self.t > self.update_rate then						
									if self.last_wave ~= self.wave then
										self.next_time = self.start + 15*self.wave
										self.last_wave = self.wave
										self.left:SetText(string.format(L["怨恨序数"], self.wave))
										self.anim_played = false					
										self.anim:Stop()
										self.glow:Hide()
									end
									
									local dur = self.next_time - GetTime()
									
									if dur > 0 then
										self:SetValue(15 - dur)
										self.right:SetText(T.FormatTime(dur))

										if dur < 5 then
											if not self.anim_played then
												self.anim_played = true
												if not SoD_CDB["General"]["disable_sound"] then
													PlaySoundFile(G.media.sounds.."RemnantofNerzhul\\spite.ogg", "Master") -- 语音 5秒后白圈
												end
												self.glow:Show()
												self.anim:Play()
											end
											self.glow:SetAlpha(self.anim:GetProgress())
										end
									else
										self.wave = self.wave + 1			
									end
									self.t = 0
								end
							end)
							
							frame.bar:Show()
						end
					elseif event == "ENCOUNTER_START" then
						frame.bar.wave = 1
						frame.bar.last_wave = 0
						frame.bar:Hide()
					end
				end,
				reset = function(frame)
					frame.bar.wave = 1
					frame.bar.last_wave = 0
					frame.bar:Hide()
					frame.bar.anim:Stop()
					frame.bar.glow:Hide()
					frame.bar:SetScript("OnUpdate", nil)
				end,	
			},
			{ -- 怨毒 已检查 需要检查CD交互
				spellID = 350469,
				tip = L["TIP怨毒"],
				points = {width = 250, height = 150},
				events = {
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,
					["CHAT_MSG_ADDON"] = true,
				},
				difficulty_id = {
					["all"] = true,
				},				
				init = function(frame)-- GetSpellCooldown(102417)
					frame.spell1 = 350469
					frame.spell2 = 355151
					frame.class = {
						["DEMONHUNTER"] = {spell = 131347, priority = 1},  -- 滑翔 无cd
						["DRUID"] = {spell = 102401, priority = 2}, -- cd 野性冲锋 已检查
						["HUNTER"] = {spell = 781, priority = 3},  -- cd 逃脱
						["WARRIOR"] = {spell = 6544, priority = 4},  -- cd 英勇飞跃 已检查
						["ROGUE"] = {spell = 36554, priority = 5, spell2 = 195457, priority2 = 10},  -- cd 暗影步 刺杀1 敏锐2 狂徒：抓钩
						["WARLOCK"] = {spell = 48020, priority = 6},  -- cd 恶魔法阵：传送
						["DEATHKNIGHT"] = {spell = 48265, priority = 7},  -- cd 死亡脚步
						["MONK"] = {spell = 119996, priority = 8},  -- cd 魂体双分：转移
						["MAGE"] = {spell = 108978, priority = 9},  -- cd 操控时间
						["SHAMAN"] = {spell = 350469, priority = 11},
						["PRIEST"] = {spell = 350469, priority = 11},
						["PALADIN"] = {spell = 350469, priority = 11},
					}
					
					frame.bars = {}
					frame.create_bar = function(GUID)
						local bar = T.CreateTimerBar(frame)	
						bar:SetStatusBarColor(.7, .7, 1)
						frame.bars[GUID] = bar
					end
					frame.lineup = function()
						local t = {}
						for GUID, bar in pairs(frame.bars) do
							if bar then
								table.insert(t, bar)
							end
						end
						if #t > 1 then
							table.sort(t, function(a, b) return a.priority < b.priority end)
						end
						local lastbar
						for i, bar in pairs(t) do
							bar:ClearAllPoints()
							if bar:IsVisible() then
								if not lastbar then
									bar:SetPoint("TOPLEFT", frame, "TOPLEFT", 25, -5)
									lastbar = bar
								else
									bar:SetPoint("TOPLEFT", lastbar, "BOTTOMLEFT", 0, -5)
									lastbar = bar
								end
							end
						end
						t = table.wipe(t)
					end
				end,
				update = function(frame, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then
						local _, sub_event, _, _, _, _, _, destGUID, destName, _, _, spellID = CombatLogGetCurrentEventInfo()
						if sub_event == "SPELL_AURA_APPLIED" and spellID == frame.spell1 then
							if UnitInRaid(destName) then -- 确认中的人在团队中
								if not frame.bars[destGUID] then
									frame.create_bar(destGUID)
								end
								local bar = frame.bars[destGUID]
								local class = select(2, UnitClass(destName))
								
								bar:SetStatusBarColor(G.Ccolors[class]["r"], G.Ccolors[class]["g"], G.Ccolors[class]["b"])
								bar.spell = frame.class[class]["spell"]
								bar.priority = frame.class[class]["priority"]
								bar.icon:SetTexture(select(3, GetSpellInfo(bar.spell)))	
								bar.left:SetText(destName)
								bar.right:SetText(L["技能冷却未知"])
								bar:Show()
								frame.lineup()
								
								local start, duration, exp_time
								if destName == G.PlayerName then -- 我被点哩
									if frame.class[class]["spell2"] and GetSpecialization() == 2 then -- 狂徒修正
										bar.spell = frame.class[class]["spell2"]
										bar.priority = frame.class[class]["priority2"]
										bar.icon:SetTexture(select(3, GetSpellInfo(bar.spell)))
										
										C_Timer.After(.3, function() -- 发信息给队友
											C_ChatInfo.SendAddonMessage("sodpaopao", "my_movespell_change,"..bar.spell..","..bar.priority, "RAID")
										end)
									end
										
									if bar.spell ~= 350469 and IsSpellKnown(bar.spell) then -- 有应对技能
										local hascharges = GetSpellCharges(bar.spell)
										if hascharges and hascharges > 0 then		
											duration, exp_time = 0, 0
											bar:SetScript("OnUpdate", nil)
											bar:SetMinMaxValues(0, 1)
											bar:SetValue(1)
											bar.right:SetText(L["就绪"])
										else
											start, duration = GetSpellCooldown(bar.spell)
											exp_time = start + duration
											if duration > 1.5 then -- 冷却中		
												bar:SetMinMaxValues(0, duration)
												bar:SetScript("OnUpdate", function(self, e)
													self.t = self.t + e
													if self.t > .1 then
														local remain = exp_time - GetTime()
														if remain > 0 then
															bar:SetValue(duration-remain)
															bar.right:SetText(T.FormatTime(remain))
														else
															bar:SetScript("OnUpdate", nil)
															bar:SetValue(duration)
															bar.right:SetText(L["就绪"])
														end									
														self.t = 0
													end
												end)
											else	
												bar:SetScript("OnUpdate", nil)
												bar:SetMinMaxValues(0, 1)
												bar:SetValue(1)
												bar.right:SetText(L["就绪"])
											end
										end
									else -- 没技能
										duration = "no"
										exp_time = "no"
										bar:SetMinMaxValues(0, 1)
										bar:SetValue(1)
										bar.right:SetText(L["无技能"])
									end
									
									C_Timer.After(.3, function() -- 发信息给队友
										C_ChatInfo.SendAddonMessage("sodpaopao", "my_movespell_cd,"..duration..","..exp_time, "RAID")
									end)
								end
							end
						elseif sub_event == "SPELL_AURA_APPLIED" and spellID == frame.spell2 then
							if not frame.bars[destGUID] then
								frame.create_bar(destGUID)
							end
							local bar = frame.bars[destGUID]
							bar:SetStatusBarColor(.5, .5, .5) -- 灰色
							bar.priority = 12
							bar.icon:SetTexture(select(3, GetSpellInfo(351073)))	
							bar.left:SetText(L["胸甲"])							
							bar:SetMinMaxValues(0, 21)		
							local exp_time = GetTime() + 21							
							bar:SetScript("OnUpdate", function(self, e)
								self.t = self.t + e
								if self.t > .1 then
									local remain = exp_time - GetTime()
									if remain > 0 then
										bar:SetValue(21-remain)
										bar.right:SetText(T.FormatTime(remain))
									else										
										bar:Hide()
										bar:SetScript("OnUpdate", nil)
									end									
									self.t = 0
								end
							end)
							
							bar:Show()
							frame.lineup()							
						elseif sub_event == "SPELL_AURA_REMOVED" and (spellID == frame.spell1 or spellID == frame.spell2) then
							if frame.bars[destGUID] then
								local bar = frame.bars[destGUID]
								bar:Hide()
								bar:SetScript("OnUpdate", nil)
								frame.lineup()
							end
						end
					elseif event == "CHAT_MSG_ADDON" then
						local prefix, message, channel, sender = ... 
						if prefix == "sodpaopao" then
							local mark, duration, exp_time = string.split(",", message)
							local player = string.split("-", sender)
							if mark == "my_movespell_cd" and player ~= G.PlayerName then
								local GUID = UnitGUID(player)
								if frame.bars[GUID] and frame.bars[GUID]:IsVisible() then
									local bar = frame.bars[GUID]
									if duration == "no" then -- 这个笨笨没有应对技能
										bar:SetMinMaxValues(0, 1)
										bar:SetValue(1)
										bar.right:SetText(L["无技能"])
									else -- 有技能
										duration = tonumber(duration)
										exp_time = tonumber(exp_time)
										if duration > 1.5 then -- 冷却中
											bar:SetMinMaxValues(0, duration)
											bar:SetScript("OnUpdate", function(self, e)
												self.t = self.t + e
												if self.t > .1 then
													local remain = exp_time - GetTime()
													if remain > 0 then
														bar:SetValue(duration-remain)
														bar.right:SetText(T.FormatTime(remain))
													else
														bar:SetScript("OnUpdate", nil)
														bar:SetValue(duration)
														bar.right:SetText(L["就绪"])
													end									
													self.t = 0
												end
											end)
										else
											bar:SetScript("OnUpdate", nil)
											bar:SetMinMaxValues(0, 1)
											bar:SetValue(1)
											bar.right:SetText(L["就绪"])
										end
									end
								end
							elseif mark == "my_movespell_change" and player ~= G.PlayerName then
								local GUID = UnitGUID(player)
								if frame.bars[GUID] and frame.bars[GUID]:IsVisible() then
									local bar = frame.bars[GUID]
									duration = tonumber(duration) -- spellID
									exp_time = tonumber(exp_time) -- priority
									
									bar.spell = duration
									bar.priority = exp_time
									bar.icon:SetTexture(select(3, GetSpellInfo(duration)))
								end
							end
						end
					end
				end,
				reset = function(frame)
					for GUID, bar in pairs(frame.bars) do
						bar:Hide()
						bar:SetScript("OnUpdate", nil)
					end
					
					frame.lineup()
					frame:Hide()
				end,
			},
		},
	},	
}

G.Encounters[5] = { -- 裂魂者多尔玛赞 已过初检
	id = 2445,
	engage_id = 2434,
	npc_id = "175727",
	img = 4071442,
	alerts = {
		AlertIcon = {	
			{type = "aura", tip = "拾起锁链", hl = "no", spellID = 350927, aura_type = "HARMFUL", unit = "player"}, -- 好战者枷锁 已检查
			{type = "cast", tip = "处理时限", hl = "no", spellID = 350411}, -- 地狱咆哮 已检查			
			{type = "com", role = "tank", hl = "hl", spellID = 350422}, -- 毁灭之刃 已检查
			{type = "aura", role = "tank", hl = "no", spellID = 350422, aura_type = "HARMFUL", unit = "player"}, -- 毁灭之刃 已检查				
			{type = "cast", tip = "孤儿圈", hl = "hl", spellID = 350648}, -- 折磨烙印 已检查
			{type = "aura", tip = "孤儿圈点你", hl = "hl", spellID = 350647, aura_type = "HARMFUL", unit = "player"}, -- 折磨烙印 已检查
			{type = "aura", tip = "躲开圈", hl = "no", spellID = 353429, aura_type = "HARMFUL", unit = "player"}, -- 饱受磨难 已检查	
			{type = "aura", tip = "被减速", hl = "no", spellID = 351787, aura_type = "HARMFUL", unit = "player"}, -- 刑罚新星 待检查		
			{type = "aura", tip = "别踩", hl = "no", spellID = 350851, aura_type = "HARMFUL", unit = "player"}, -- 聚魂之河	待检查				
		},
		HLOnRaid = {
			{type = "HLCast", role = "tank", spellID = 350422}, -- 毁灭之刃 已检查
			{type = "HLAuras", spellID = 350647, Glow = true}, -- 折磨烙印 已检查
			{type = "HLAuras", spellID = 353429}, -- 饱受磨难 已检查		
		},
		TextAlert = {
			{	-- 已检查
				type = "pp",
				data = {
					unit = "boss1",
					npc_id = "175727",
					ranges = {
						{ ul = 99, ll = 85, tip = L["即将折磨喷发"]},
					},
				},
			},
		},
		PlateAlert = {
			{type = "PlateSpells", spellID = 351787, spellCD = 1, mobID = "177594", hl_np = true}, -- 刑罚新星 待检查
			{type = "PlateAuras", spellID = 350650}, -- 蔑视 待检查
			{type = "PlateNpcID", mobID = "179177"}, -- 渊誓霸主 待检查			
		},
		ChatMsg = {
			{type = "ChatMsgAuras", spellID = 350647, playername = false, spellname = true, icon = 1}, -- 折磨烙印 已检查
		},
		Sound = {	
			{spellID = 350766, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_CAST_SUCCESS"}, -- 躲地板
			{spellID = 349985, event = "UNIT_SPELLCAST_SUCCEEDED"}, -- 地板连躲
			{spellID = 350422, role = "tank", event = "UNIT_SPELLCAST_START", unit = "player"}, -- 毁灭之刃
			{spellID = 350647, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED" , unit = "player"}, -- 孤儿圈点你
			{spellID = 353429, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED" , unit = "player"}, -- 快走开
			{spellID = 350615, event = "BW_AND_DBM_SPELL", dur = 5, countdown = true}, -- 准备小怪
			{spellID = 352066, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_CAST_SUCCESS"}, -- 躲开白圈		
			{spellID = 350851, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED" , unit = "player"}, -- 快走开		
		},
		HP_Watch = {
			{sub_event = "SPELL_AURA_APPLIED", spellID = 350415}, -- 开始拉锁链
			{sub_event = "SPELL_AURA_APPLIED_DOSE", spellID = 350415}, -- 开始拉锁链
		},
		BossMods = {
			{ -- 毁灭之刃
				spellID = 350422,
				role = "tank",
				tip = string.format(L["多人光环提示"], T.GetIconLink(350422)),			
				points = {a1 = "TOPLEFT", a2 = "CENTER", x = -700, y = 300, width = 250, height = 100},	
				events = {
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,	
				},
				difficulty_id = {
					["all"] = true,
				},
				init = function(frame)
					frame.aura_spell_ids = {350422}
					frame.aura_spells = {}
					for i, v in pairs(frame.aura_spell_ids) do
						frame.aura_spells[v] = {aura = GetSpellInfo(v), icon = select(3, GetSpellInfo(v))}
					end
					
					frame.bars = {}
						
					frame.create_bar = function(tag, spellID, player)
						local bar = T.CreateTimerBar(frame, frame.aura_spells[spellID]["icon"], true, false, true)
						bar.spellID = spellID
						bar.name = player
						frame.bars[tag] = bar			
					end
				
					frame.updatebar = function(bar, count, dur, exp_time)
						bar.left:SetText(T.ColorName(bar.name, true))
						
						bar.exp = exp_time
						bar.anim_played = false
						bar:SetMinMaxValues(0 , dur)
						
						bar:SetScript("OnUpdate", function(self, e)
							self.t = self.t + e
							if self.t > self.update_rate then		
								local remain = exp_time - GetTime()
								if remain > 0 then								
									self.right:SetText((count > 0 and "|cffFFFF00["..count.."]|r " or "")..T.FormatTime(remain))
									self:SetValue(dur - remain)
									if remain < 3 then -- 即将消失
										if not self.anim_played then
											self.anim_played = true
											self.glow:Show()
											self.anim:Play()
										end
										self.glow:SetAlpha(self.anim:GetProgress())
									end
								else
									self:Hide()
									self:SetScript("OnUpdate", nil)
									self.anim:Stop()
									self.glow:Hide()
								end
								self.t = 0
							end
						end)											
						bar:Show()
					end
					
					frame.lineup = function()
						local t = {}
						for GUID, bar in pairs(frame.bars) do
							if bar and bar:IsVisible() then
								table.insert(t, bar)
							end
						end
						if #t > 1 then
							table.sort(t, function(a, b) 
								if a.spellID < b.spellID then
									return true
								elseif a.spellID == b.spellID and a.exp < b.exp then
									return true
								end
							end)
						end
						local lastbar
						for i, bar in pairs(t) do
							bar:ClearAllPoints()
							if bar:IsVisible() then
								if not lastbar then
									bar:SetPoint("TOPLEFT", frame, "TOPLEFT", 30, -5)
									lastbar = bar
								else
									bar:SetPoint("TOPLEFT", lastbar, "BOTTOMLEFT", 0, -5)
									lastbar = bar
								end
							end
						end
					end			
				end,
				update = function(frame, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then						
						local _, sub_event, _, _, _, _, _, destGUID, destName, _, _, spellID = CombatLogGetCurrentEventInfo()
						if (sub_event == "SPELL_AURA_APPLIED" or sub_event == "SPELL_AURA_APPLIED_DOSE" or sub_event == "SPELL_AURA_REMOVED_DOSE") and frame.aura_spells[spellID] then						
							local dest = string.split("-", destName)				
							if destGUID and AuraUtil.FindAuraByName(frame.aura_spells[spellID]["aura"], dest, G.Test_Mod and "HELPFUL" or "HARMFUL") then
								local count, _, dur, exp_time = select(3, AuraUtil.FindAuraByName(frame.aura_spells[spellID]["aura"], dest, G.Test_Mod and "HELPFUL" or "HARMFUL"))
								if not frame.bars[spellID.."_"..destGUID] then
									frame.create_bar(spellID.."_"..destGUID, spellID, dest)
								end
								
								local bar = frame.bars[spellID.."_"..destGUID]
								frame.updatebar(bar, count, dur, exp_time)
								
								frame.lineup()
							end
						elseif sub_event == "SPELL_AURA_REMOVED" and frame.aura_spells[spellID] then
							if destGUID and frame.bars[spellID.."_"..destGUID] then
								local bar = frame.bars[spellID.."_"..destGUID]
								bar:Hide()
								bar:SetScript("OnUpdate", nil)
								bar.anim:Stop()
								bar.glow:Hide()
								frame.lineup()
							end
						end
					end	
				end,
				reset = function(frame)
					for tag, bar in pairs(frame.bars) do
						bar:ClearAllPoints()
						bar:Hide()
						bar:SetScript("OnUpdate", nil)
						bar.anim:Stop()
						bar.glow:Hide()
					end				
					frame.bars = table.wipe(frame.bars)
					frame:Hide()
				end,
			},
			{ -- 锁链
				spellID = 350415,
				tip = L["TIP好战者枷锁"],
				points = {width = 250, height = 100},
				events = {	
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,	
				},
				difficulty_id = {
					[15] = true,
					[16] = true,
				},
				init = function(frame)
					frame.spellID = 348987 -- 好战者枷锁 
					frame.spellID2 = 354231 -- 灵魂镣铐 
					frame.spellID3 = 350647 -- 折磨烙印 
					frame.debuff, _, frame.icon = GetSpellInfo(frame.spellID)
					frame.debuff2 = GetSpellInfo(frame.spellID2)
					frame.debuff3 = GetSpellInfo(frame.spellID3)
					
					frame.text = T.createtext(frame, "OVERLAY", 20, "OUTLINE", "LEFT") -- 显示计划拉锁链人员
					frame.text:SetPoint("TOPLEFT", frame, "TOPLEFT", 5, -5)
										
					frame.text_center = T.createtext(frame, "OVERLAY", 40, "OUTLINE", "LEFT") -- 点我的时候显示
					frame.text_center:SetPoint("BOTTOM", UIParent, "CENTER", 0, 200)
					
					frame.bars = {} -- 显示正在拉锁链的人
					frame.ind = 0
					frame.exp = 0
					
					frame:SetScript("OnUpdate", function(self, e)
						self.t = self.t + e
						if self.t > 1 then
							local remain = self.exp - GetTime()
							if remain <= 0 and self.ind ~= 0 then
								self.ind = 0
							end
							self.t = 0
						end
					end)
					
					frame.create_bar = function(tag, player)
						local bar = T.CreateTimerBar(frame, frame.icon, false, true, true)
						bar:SetStatusBarColor(.5, .5, .5)
						bar.name = player
						frame.bars[tag] = bar			
					end
				
					frame.updatebar = function(bar, dur, exp_time)
						if dur and exp_time then
							bar.left:SetText(T.ColorName(bar.name, true).."|cffFFFF00["..frame.ind.."]|r")
							bar.ind = frame.ind
							bar.exp = exp_time					
							bar:SetMinMaxValues(0 , dur)
							bar:SetScript("OnUpdate", function(self, e)
								self.t = self.t + e
								if self.t > self.update_rate then		
									local remain = exp_time - GetTime()
									if remain > 0 then
										self.right:SetText(T.FormatTime(remain))
										self:SetValue(dur - remain)
									else			
										self:Hide()
										self:SetScript("OnUpdate", nil)
									end
									self.t = 0
								end
							end)
							bar:Show()
						end
						
						if AuraUtil.FindAuraByName(frame.debuff3, bar.name, G.Test_Mod and "HELPFUL" or "HARMFUL") then -- 有折磨烙印
							bar.mid:SetText(L["烙印"])
						else
							bar.mid:SetText("")
						end
						
					end
					
					frame.lineup = function()
						local t = {}
						for GUID, bar in pairs(frame.bars) do
							if bar and bar:IsVisible() then
								table.insert(t, bar)
							end
						end
						if #t > 1 then
							table.sort(t, function(a, b) return a.exp < b.exp end)
						end
						local lastbar
						for i, bar in pairs(t) do
							bar:ClearAllPoints()
							if bar:IsVisible() then
								if not lastbar then
									bar:SetPoint("TOPLEFT", frame.text2, "BOTTOMLEFT", 35, -5)
									lastbar = bar
								else
									bar:SetPoint("TOPLEFT", lastbar, "BOTTOMLEFT", 0, -5)
									lastbar = bar
								end
							end
						end
					end
					
					frame.index_str = {L["左"], L["中间"], L["右"]}
					
					frame.assignment = {}
					frame.counter = 0
					frame.display_counter = 0
					
					frame.updatestatus = function(name)
						if UnitInRaid(name) then
							if UnitIsDeadOrGhost(name) then -- 死了
								return T.ColorName(name, true)..L["死了"]
							elseif AuraUtil.FindAuraByName(frame.debuff2, name, G.Test_Mod and "HELPFUL" or "HARMFUL") then -- 有灵魂镣铐
								return T.ColorName(name, true)..L["已断"]
							elseif AuraUtil.FindAuraByName(frame.debuff, name, G.Test_Mod and "HELPFUL" or "HARMFUL") then -- 有好战者枷锁
								return T.ColorName(name, true)..L["在拉"]
							else
								return T.ColorName(name, true)
							end
						else
							return T.ColorCustomName(name, true)
						end
					end

					frame.updatetext = function(counter_index)
						if frame.assignment[counter_index] then
							local player1, player2, player3 = "", "", ""
							for name, ind in pairs(frame.assignment[counter_index]) do
								if ind == 1 then
									player1 = frame.updatestatus(name)
								elseif ind == 2 then
									player2 = frame.updatestatus(name)
								elseif ind == 3 then
									player3 = frame.updatestatus(name)
								end
							end
							frame.text:SetText(string.format(L["下一轮锁链"], counter_index, player1, player2, player3))
							
							frame.display_counter = counter_index
						else
							frame.text:SetText("nodata")
						end
					end
					
				end,
				update = function(frame, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then
						local timestamp, sub_event, _, sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellID, spellName = CombatLogGetCurrentEventInfo()
						if sub_event == "SPELL_CAST_SUCCESS" and spellID == 357776 then -- 本轮拉锁链结束
							
							local next_counter = frame.counter+1
							frame.updatetext(next_counter)
							frame.text_center:SetText("")
							
							if frame.assignment[next_counter] and frame.assignment[next_counter][G.PlayerName] then -- 下一轮有我
								if not SoD_CDB["General"]["disable_sound"] then
									PlaySoundFile(G.media.sounds.."SoulrenderDormazain\\nextchain"..frame.assignment[next_counter][G.PlayerName]..".ogg", "Master") -- 声音
								end
							end
							
						elseif sub_event == "SPELL_AURA_APPLIED" and spellID == frame.spellID then -- 玩家拾起锁链
							frame.updatetext(frame.display_counter)
							local dest = string.split("-", destName)
							
							if destGUID and AuraUtil.FindAuraByName(frame.debuff, dest, G.Test_Mod and "HELPFUL" or "HARMFUL") then
								
								local dur, exp_time = select(5, AuraUtil.FindAuraByName(frame.debuff, dest, G.Test_Mod and "HELPFUL" or "HARMFUL"))
								
								frame.ind = frame.ind + 1
								if frame.exp < exp_time then
									frame.exp = exp_time
								end
								
								if not frame.bars[destGUID] then
									frame.create_bar(destGUID, dest)
								end
								
								local bar = frame.bars[destGUID]
								frame.updatebar(bar, dur, exp_time)
								
								frame.lineup()
							end
							
							if dest == G.PlayerName then
								frame.text_center:SetText("")
								if not SoD_CDB["General"]["disable_sound"] then
									PlaySoundFile(G.media.sounds.."bip.ogg", "Master") -- 声音 bip
								end
							end							
						elseif sub_event == "SPELL_AURA_REMOVED" and spellID == frame.spellID then -- 玩家拉断锁链
							frame.updatetext(frame.display_counter)
							local dest = string.split("-", destName)
							
							if destGUID and frame.bars[destGUID] then
								local bar = frame.bars[destGUID]
								bar:Hide()
								bar:SetScript("OnUpdate", nil)
								frame.lineup()
							end
							
							if dest == G.PlayerName then
								if not SoD_CDB["General"]["disable_sound"] then
									PlaySoundFile(G.media.sounds.."bip.ogg", "Master") -- 声音 bip
								end
							end
						elseif sub_event == "SPELL_AURA_APPLIED" and spellID == frame.spellID2 then -- 灵魂镣铐出现
							frame.updatetext(frame.display_counter)
						elseif sub_event == "SPELL_AURA_REMOVED" and spellID == frame.spellID2 then -- 灵魂镣铐消失
							frame.updatetext(frame.display_counter)
						elseif sub_event == "SPELL_AURA_APPLIED" and spellID == frame.spellID3 then -- 折磨烙印出现
							if destGUID and frame.bars[destGUID] then
								local bar = frame.bars[destGUID]
								frame.updatebar(bar)
							end
						elseif sub_event == "SPELL_AURA_REMOVED" and spellID == frame.spellID3 then -- 折磨烙印消失
							if destGUID and frame.bars[destGUID] then
								local bar = frame.bars[destGUID]
								frame.updatebar(bar)
							end
						elseif (sub_event == "SPELL_AURA_APPLIED" or sub_event == "SPELL_AURA_APPLIED_DOSE") and spellID == 350415 then -- 开始拉锁链
							frame.counter = frame.counter + 1
							
							if frame.assignment[frame.counter] and frame.assignment[frame.counter][G.PlayerName] then -- 这次我要拉锁链
								local index = frame.assignment[frame.counter][G.PlayerName]
								frame.text_center:SetText(format(L["去拉锁链"], frame.index_str[index]))
								if not SoD_CDB["General"]["disable_sound"] then
									PlaySoundFile(G.media.sounds.."SoulrenderDormazain\\chain"..frame.assignment[frame.counter][G.PlayerName]..".ogg", "Master") -- 声音
								end
							end
							
						elseif sub_event == "UNIT_DIED" or sub_event == "SPELL_RESURRECT" then -- 有人死了/活了
							local dest = string.split("-", destName)
							if frame.assignment[frame.display_counter] and frame.assignment[frame.display_counter][dest] then
								frame.updatetext(frame.display_counter)
							end
						end
					elseif event == "ENCOUNTER_START" then
						frame.assignment = table.wipe(frame.assignment)
						
						frame.counter = 0
						frame.display_counter = 0
						
						if IsAddOnLoaded("MRT") and _G.VExRT.Note and _G.VExRT.Note.Text1 then
							local text = _G.VExRT.Note.Text1
							local betweenLine = false
							local count = 0
							for line in text:gmatch('[^\r\n]+') do
								if line:match("end") then
									betweenLine = false
								end
								if betweenLine then
									count = count + 1
									frame.assignment[count] = {}
									local idx = 0
									for name in line:gmatch("|c%x%x%x%x%x%x%x%x([^|]+)|") do
										if idx < 3 then
											idx = idx + 1
											frame.assignment[count][name] = idx
										end
									end
								end
								if line:match(L["锁链顺序"]) then
									betweenLine = true
								end
							end
						end
						
						frame.updatetext(frame.counter+1)
						frame.text_center:SetText("")
						
						if frame.assignment[frame.counter+1] and frame.assignment[frame.counter+1][G.PlayerName] then -- 下一轮有我
							if not SoD_CDB["General"]["disable_sound"] then
								PlaySoundFile(G.media.sounds.."SoulrenderDormazain\\nextchain"..frame.assignment[frame.counter+1][G.PlayerName]..".ogg", "Master") -- 声音
							end
						end
					end
				end,
				reset = function(frame)
					frame:Hide()
					frame.text:SetText("")
					frame.text_center:SetText("")
					
					for tag, bar in pairs(frame.bars) do
						bar:ClearAllPoints()
						bar:Hide()
						bar:SetScript("OnUpdate", nil)
					end
					frame.bars = table.wipe(frame.bars)

					frame.ind = 0
					frame.assignment = table.wipe(frame.assignment)
					frame.counter = 0
					frame.display_counter = 0
				end,
			},
			{ -- 折磨
				spellID = 350217,
				tip = L["TIP折磨"],
				points = {a1 = "BOTTOM", a2 = "CENTER", x = 0, y = 300, width = 400, height = 40},	
				events = {	
					["UNIT_SPELLCAST_SUCCEEDED"] = true,
				},
				difficulty_id = {
					["all"] = true,
				},
				init = function(frame)
					frame.spellName, _, frame.iconTexture = GetSpellInfo(350217)
					
					local bar = T.CreateTimerBar(frame, frame.iconTexture, false, false, true, 400, 40, 25, 1, 1, 0)	
					bar:SetPoint("TOPLEFT", frame, "TOPLEFT")
					frame.bar = bar
				end,
				update = function(frame, event, ...)
					if event == "UNIT_SPELLCAST_SUCCEEDED" then
						local spellID = select(3, ...)
						if spellID == 349873 then -- 折磨
							frame.bar:Show()
							frame.bar.left:SetText(frame.spellName)
							frame.bar.exp = GetTime() + 10
							frame.bar:SetMinMaxValues(0, 10)
							frame.bar:SetScript("OnUpdate", function(self, e)
								self.t = self.t + e
								if self.t > self.update_rate then
									local remain = self.exp - GetTime()
									if remain > 0 then
										self.right:SetText(T.FormatTime(remain))
										self:SetValue(10 - remain)
									else
										self:Hide()
										self:SetScript("OnUpdate", nil)	
									end
									self.t = 0
								end
							end)
						elseif spellID == 352933 then -- 折磨喷发
							frame.bar:Show()
							frame.bar.left:SetText(frame.spellName)
							frame.bar.start = GetTime()
							frame.bar.ind = 1
							frame.bar.current = 0
							frame.bar.durs = {12, 17, 22, 27, 32}
							frame.bar:SetScript("OnUpdate", function(self, e)
								self.t = self.t + e
								if self.t > self.update_rate then
									if self.current ~= self.ind then		
										if self.ind == 1 then											
											self:SetMinMaxValues(0, 12)
											self.max = 12
										else
											self:SetMinMaxValues(0, 5)
											self.max = 5
										end
										self.left:SetText(string.format("%s [%d]", frame.spellName, self.ind))
										self.current = self.ind
									end
									local remain = self.start + self.durs[self.ind] - GetTime()
									if remain > 0 then
										self.right:SetText(T.FormatTime(remain))
										self:SetValue(self.max - remain)
									elseif self.ind < 5 then
										self.ind = self.ind + 1
									else
										self:Hide()
										self:SetScript("OnUpdate", nil)				
									end
									self.t = 0
								end
							end)
						end
					end
				end,
				reset = function(frame)
					frame.bar:Hide()
					frame.bar:SetScript("OnUpdate", nil)	
				end,
			},
			{ -- 刑罚者小怪标记
				spellID = 350615,
				tip = L["TIP刑罚者"],
				points = {hide = true},
				events = {
					["NAME_PLATE_UNIT_ADDED"] = true,
					["UNIT_TARGET"] = true,
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,
				},
				difficulty_id = {
					["all"] = true,
				},
				init = function(frame)
					frame.npcID = "177594" -- "97264"	
					frame.used_mark = 0
					frame.getmark = function()
						if frame.used_mark == 4 then
							frame.used_mark = 1
						else
							frame.used_mark = frame.used_mark + 1
						end
						return frame.used_mark
					end
					frame.marked = {}		
				end,
				update = function(frame, event, ...)
					if event == "NAME_PLATE_UNIT_ADDED" then
						local unit = ...
						local GUID = UnitGUID(unit)
						local npcID = select(6, strsplit("-", GUID))
						if npcID and npcID == frame.npcID then
							if not frame.marked[GUID] then
								local mark = frame.getmark()
								T.SetRaidTarget(unit, mark) -- 上标记
								--print(GUID, mark)
								frame.marked[GUID] = mark
							end
						end
					elseif event == "UNIT_TARGET" then
						local unit = ...
						if strfind(unit, "raid") then -- 只看团队						
							local targetUnit = unit.."target"
							local GUID = UnitGUID(targetUnit)
							if GUID and not UnitIsDeadOrGhost(targetUnit) then
								local npcID = select(6, strsplit("-", GUID))
								if npcID and npcID == frame.npcID then -- 确认过眼神
									if not frame.marked[GUID] then
										local mark = frame.getmark()
										T.SetRaidTarget(unit, mark) -- 上标记
										--print(GUID, mark)
										frame.marked[GUID] = mark
									end
								end
							end
						end
					elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
						local _, Event_type, _, sourceGUID, _, _, _, DestGUID, _, _, destRaidFlags, spellID = CombatLogGetCurrentEventInfo()
						if Event_type == "SPELL_CAST_START" and spellID == 350615 then --  2061
							frame.used_mark = 0 -- 施法后重置标记序号
						end
					end
				end,
				reset = function(frame)	
					frame.used_mark = 0
				end,
			},
			{ -- 折磨烙印喊话且能看见dot图标
				spellID = 350647,
				tip = L["TIP折磨烙印"],
				points = {hide = true},
				events = {
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,
				},
				difficulty_id = {
					["all"] = true,
				},
				init = function(frame)
					frame.index = 0
					
					frame.update_plate_auras = function()
						for i, namePlate in ipairs(C_NamePlate.GetNamePlates()) do
							local unitFrame = namePlate.soduf
							G.UpdateAuras(unitFrame)
						end
					end
				end,
				update = function(frame, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then
						local _, Event_type, _, sourceGUID, _, _, _, DestGUID, destName, _, destRaidFlags, spellID = CombatLogGetCurrentEventInfo()
						if Event_type == "SPELL_AURA_APPLIED" and destName == G.PlayerName and spellID == 350647 then
							C_Timer.After(.5, function()
								T.SendChatMsg(string.format(L["折磨烙印喊话"], frame.index, G.PlayerName))
							end)
							G.Plate_AurabyBossMod[350649] = true
							frame.update_plate_auras()
						elseif Event_type == "SPELL_AURA_REMOVED" and destName == G.PlayerName and spellID == 350647 then
							G.Plate_AurabyBossMod[350649] = false
							frame.update_plate_auras()
						elseif Event_type == "SPELL_CAST_SUCCESS" and spellID == 350648 then
							frame.index = frame.index + 1
						elseif Event_type == "SPELL_CAST_SUCCESS" and spellID == 352933 then
							frame.index = 0
						end
					end
				end,
				reset = function(frame)	
					frame.index = 0
					G.Plate_AurabyBossMod[350649] = false
					frame.update_plate_auras()
				end,
			},
			{ -- 碎裂之魂计时
				spellID = 351229,
				tip = L["TIP碎裂之魂"],
				points = {a1 = "BOTTOM", a2 = "CENTER", x = 0, y = 150, width = 250, height = 30},			
				events = {
					["UNIT_SPELLCAST_SUCCEEDED"] = true,
					["UNIT_SPELLCAST_START"] = true,
				},
				difficulty_id = {
					["all"] = true,
				},
				init = function(frame)
					frame.spell1 = 350766
					frame.spell2 = 350411
					
					local spell_name, _, icon = GetSpellInfo(351229)
						
					local bar = T.CreateTimerBar(frame, frame.iconTexture, false, false, true, 350, 28, 20, .7, .7, .7)
					bar.dur = 3
					bar.ind = 1
					bar:SetPoint("TOPLEFT", frame, "TOPLEFT")
					bar:SetMinMaxValues(0, bar.dur)
					
					frame.bar = bar
				end,
				update = function(frame, event, ...)
					if event == "UNIT_SPELLCAST_SUCCEEDED" or event == "UNIT_SPELLCAST_START" then
						local spellId = select(3, ...)
						if (event == "UNIT_SPELLCAST_SUCCEEDED" and spellId == frame.spell1) or (event == "UNIT_SPELLCAST_START" and spellId == frame.spell2) then
							frame.bar.exp = GetTime() + 8
							
							frame.bar.ind = 1						
							frame.bar.left:SetText(string.format(L["躲白圈"], frame.bar.ind))
							
							frame.bar:SetScript("OnUpdate", function(self, e)
								self.t = self.t + e
								if self.t > self.update_rate then
									local remain = self.exp - GetTime()
									if remain > 0 then
										if remain <= self.dur then
											self:SetAlpha(1)
											self:SetValue(self.dur - remain)
											self.right:SetText(T.FormatTime(remain))
										else
											self:SetAlpha(0)
											self:SetValue(0)
											self.right:SetText("")
										end								
									else
										if self.ind == 1 then
											self.ind = self.ind + 1
											self.exp = GetTime() + 5
											self.left:SetText(string.format(L["躲白圈"], self.ind))
										else
											self:Hide()
											self:SetScript("OnUpdate", nil)
										end
									end						
									self.t = 0
								end
							end)

							frame.bar:SetAlpha(0)
							frame.bar:Show()
						end
					end
				end,
				reset = function(frame)
					frame.bar:SetScript("OnUpdate", nil)
					frame.bar:SetValue(0)
					frame.bar.left:SetText("")
					frame.bar.right:SetText("")
					frame.bar:Hide()
				end,
			},
		},
	},
}

G.Encounters[6] = { -- 痛楚工匠莱兹纳尔 已过初检
	id = 2443,
	engage_id = 2430,
	npc_id = "176523", 
	img = 4079051,
	alerts = {
		AlertIcon = {			
			{type = "aura", tip = "AE+十字刺", hl = "hl", spellID = 355568, aura_type = "HARMFUL", unit = "player"}, --十字斧
			{type = "aura", tip = "AE+扩散刺", hl = "hl", spellID = 348508, aura_type = "HARMFUL", unit = "player"}, --振荡铁锤
			{type = "aura", tip = "AE+组合刺", hl = "hl", spellID = 355778, aura_type = "HARMFUL", unit = "player"}, --双刃镰刀		
			{type = "aura", role = "tank", hl = "no", spellID = 355786, aura_type = "HARMFUL", unit = "player"}, -- 黑化护甲 已检查
			{type = "cast", tip = "转火铁球", role = "dps", hl = "hl", spellID = 352052}, -- 尖刺铁球 已检查
			{type = "aura", tip = "孤儿圈点你", hl = "hl", spellID = 355505, aura_type = "HARMFUL", unit = "player"}, -- 影铸锁链 已检查
			{type = "aura", hl = "hl", spellID = 348456, dif = {[15] = true, [16] = true}, aura_type = "HARMFUL", unit = "player"}, -- 烈焰套索陷阱 待检查		
			{type = "aura", tip = "爆炸", hl = "no", spellID = 356870, dif = {[15] = true, [16] = true}, aura_type = "HARMFUL", unit = "player"}, -- 烈焰套索爆炸 已检查
			{type = "cast", tip = "躲圈", hl = "no", spellID = 355525}, -- 锻造武器 已检查
			{type = "aura", role = "healer", hl = "no", spellID = 356472, aura_type = "HARMFUL", unit = "player"}, -- 黑暗灼热 待检查
		},
		HLOnRaid = {
			{type = "HLAuras", spellID = 355786}, -- 黑化护甲 待检查
			{type = "HLAuras", spellID = 355505, Glow = true}, -- 影铸锁链 已检查
			{type = "HLAuras", spellID = 355506, Glow = true}, -- 影铸锁链 已检查
			{type = "HLAuras", spellID = 348456}, -- 烈焰套索陷阱 待检查
			{type = "HLAuras", spellID = 356870}, -- 烈焰套索爆炸 待检查
		},
		TextAlert = { -- 已检查
			{
				type = "hp",
				data = {
					unit = "boss1",
					npc_id = "176523",
					ranges = {
						{ ul = 75, ll = 70.5, tip = string.format(L["阶段转换"], "70")},
						{ ul = 45, ll = 40.5, tip = string.format(L["阶段转换"], "40")},
					},
				},
			},
		},
		ChatMsg = {
			{type = "ChatMsgAuraCountdown", spellID = 355505, playername = true, spellname = false, icon = 8}, -- 影铸锁链
			{type = "ChatMsgAuraCountdown", spellID = 355506, playername = true, spellname = false, icon = 8}, -- 影铸锁链
		},
		Sound = {	
			{spellID = 355568, event = "UNIT_SPELLCAST_SUCCEEDED"}, -- 十字斧		
			{spellID = 348508, event = "UNIT_SPELLCAST_SUCCEEDED"}, -- 振荡铁锤
			{spellID = 348508, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_REMOVED"}, -- 注意尖刺			
			{spellID = 355778, event = "UNIT_SPELLCAST_SUCCEEDED"}, -- 双刃镰刀
			{spellID = 355778, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_REMOVED"}, -- 注意尖刺
			{spellID = 355786, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED" , unit = "player"}, -- 黑化护甲
			{spellID = 352052, role = "dps", event = "BW_AND_DBM_SPELL", dur = 5, countdown = true}, -- 准备铁球			
			{spellID = 352052, role = "dps", event = "UNIT_SPELLCAST_SUCCEEDED"}, -- 转火铁球		
			{spellID = 355505, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED" , unit = "player"}, -- 孤儿圈点你
			{spellID = 348456, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED" , unit = "player"}, -- 陷阱点你
			{spellID = 356870, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED" , unit = "player", countdown = true}, -- 爆炸
			{spellID = 355525, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_CAST_START"}, -- 注意躲圈
			{spellID = 355525, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_REMOVED"}, -- 阶段转换		
			{spellID = 355536, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_SUMMON"}, -- 小怪出现
		},
		HP_Watch = {
			{sub_event = "SPELL_CAST_START", spellID = 355571, dur = 4}, -- 十字斧
			{sub_event = "SPELL_CAST_START", spellID = 348513, dur = 4}, -- 振荡铁锤
			{sub_event = "SPELL_CAST_START", spellID = 355787, dur = 4}, -- 双刃镰刀
		},
		Phase_Change = {
			{sub_event = "SPELL_AURA_REMOVED", spellID = 355525}, -- 锻造武器消失
			{sub_event = "SPELL_AURA_APPLIED", spellID = 355525}, -- 锻造武器开始
		},
		BossMods = {
			{ -- 十字斧 振荡铁锤 双刃镰刀 黑化护甲
				spellID = 355568,
				role = "tank",
				points = {a1 = "TOPLEFT", a2 = "CENTER", x = -700, y = 200, width = 250, height = 100},
				tip = string.format(L["多人光环提示"], T.GetIconLink(355568).." "..T.GetIconLink(348508).." "..T.GetIconLink(355778).." "..T.GetIconLink(355786)),			
				events = {
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,	
				},
				difficulty_id = {
					["all"] = true,
				},
				init = function(frame)
					frame.aura_spell_ids = {355568, 348508, 355778, 355786}
					frame.aura_spells = {}
					for i, v in pairs(frame.aura_spell_ids) do
						frame.aura_spells[v] = {aura = GetSpellInfo(v), icon = select(3, GetSpellInfo(v))}
					end
					
					frame.bars = {}
						
					frame.create_bar = function(tag, spellID, player)
						local bar = T.CreateTimerBar(frame, frame.aura_spells[spellID]["icon"], true, false, true)
						bar.spellID = spellID
						bar.name = player
						frame.bars[tag] = bar		
					end
				
					frame.updatebar = function(bar, count, dur, exp_time)
						bar.left:SetText(T.ColorName(bar.name, true))
						
						bar.exp = exp_time
						bar.anim_played = false
						bar:SetMinMaxValues(0 , dur)
						
						bar:SetScript("OnUpdate", function(self, e)
							self.t = self.t + e
							if self.t > self.update_rate then		
								local remain = exp_time - GetTime()
								if remain > 0 then								
									self.right:SetText((count > 0 and "|cffFFFF00["..count.."]|r " or "")..T.FormatTime(remain))
									self:SetValue(dur - remain)
									if remain < 3 then -- 即将消失
										if not self.anim_played then
											self.anim_played = true
											self.glow:Show()
											self.anim:Play()
										end
										self.glow:SetAlpha(self.anim:GetProgress())
									end
								else
									self:Hide()
									self:SetScript("OnUpdate", nil)
									self.anim:Stop()
									self.glow:Hide()
								end
								self.t = 0
							end
						end)											
						bar:Show()
					end
					
					frame.lineup = function()
						local t = {}
						for GUID, bar in pairs(frame.bars) do
							if bar and bar:IsVisible() then
								table.insert(t, bar)
							end
						end
						if #t > 1 then
							table.sort(t, function(a, b) 
								if a.spellID < b.spellID then
									return true
								elseif a.spellID == b.spellID and a.exp < b.exp then
									return true
								end
							end)
						end
						local lastbar
						for i, bar in pairs(t) do
							bar:ClearAllPoints()
							if bar:IsVisible() then
								if not lastbar then
									bar:SetPoint("TOPLEFT", frame, "TOPLEFT", 30, -5)
									lastbar = bar
								else
									bar:SetPoint("TOPLEFT", lastbar, "BOTTOMLEFT", 0, -5)
									lastbar = bar
								end
							end
						end
					end			
				end,
				update = function(frame, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then						
						local _, sub_event, _, _, _, _, _, destGUID, destName, _, _, spellID = CombatLogGetCurrentEventInfo()
						if (sub_event == "SPELL_AURA_APPLIED" or sub_event == "SPELL_AURA_APPLIED_DOSE" or sub_event == "SPELL_AURA_REMOVED_DOSE") and frame.aura_spells[spellID] then						
							local dest = string.split("-", destName)				
							if destGUID and AuraUtil.FindAuraByName(frame.aura_spells[spellID]["aura"], dest, G.Test_Mod and "HELPFUL" or "HARMFUL") then
								local count, _, dur, exp_time = select(3, AuraUtil.FindAuraByName(frame.aura_spells[spellID]["aura"], dest, G.Test_Mod and "HELPFUL" or "HARMFUL"))
								if not frame.bars[spellID.."_"..destGUID] then
									frame.create_bar(spellID.."_"..destGUID, spellID, dest)
								end
								
								local bar = frame.bars[spellID.."_"..destGUID]
								frame.updatebar(bar, count, dur, exp_time)
								
								frame.lineup()
							end
						elseif sub_event == "SPELL_AURA_REMOVED" and frame.aura_spells[spellID] then
							if destGUID and frame.bars[spellID.."_"..destGUID] then
								local bar = frame.bars[spellID.."_"..destGUID]
								bar:Hide()
								bar:SetScript("OnUpdate", nil)
								bar.anim:Stop()
								bar.glow:Hide()
								frame.lineup()
							end
						end
					end	
				end,
				reset = function(frame)
					for tag, bar in pairs(frame.bars) do
						bar:ClearAllPoints()
						bar:Hide()
						bar:SetScript("OnUpdate", nil)
						bar.anim:Stop()
						bar.glow:Hide()
					end				
					frame.bars = table.wipe(frame.bars)
					frame:Hide()
				end,
			},
			{ -- 烈焰陷阱爆炸 待检查
				spellID = 348456,
				tip = L["TIP烈焰套索陷阱"],
				points = {width = 250, height = 200},			
				events = {
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,	
				},
				difficulty_id = {
					["all"] = true,
					[15] = true,
					[16] = true,
				},
				init = function(frame)
					frame.spellID = 348456
					frame.spellName, _, frame.iconTexture = GetSpellInfo(frame.spellID)
					frame.trap = 0
					frame.anchor = "raid1"
					frame.prev = 0
					frame.counter = 0
					frame.bars = {}
					frame.color = {"00FF00", "FFFF00", "FFA500", "FF0000"}
					
					frame.text = T.createtext(frame, "OVERLAY", 25, "OUTLINE", "LEFT")
					frame.text:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
					
					frame.cd_tex = T.CreateCircleCD(frame, 50, 1, 1, 0)
					frame.cd_tex:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
					
					frame.update_anchor = function()
						for i = 1, GetNumGroupMembers() do
							local unit = "raid"..i
							if not UnitIsDeadOrGhost(unit) and UnitInRange(unit) then
								frame.anchor = unit
								break
							end
						end
					end
					
					frame.updatetext = function()
						frame.text:SetText(string.format(L["陷阱数量"], frame.counter, frame.color[frame.trap] or "FF0000", frame.trap))
					end
						
					frame.create_bar = function(tag, player)
						local bar = T.CreateTimerBar(frame, frame.iconTexture, false, false, true)					
						bar:SetStatusBarColor(1, 1, 0)
						bar.name = player
						frame.bars[tag] = bar			
					end
				
					frame.updatebar = function(bar, dur, exp_time)
						bar.left:SetText(T.ColorName(bar.name, true))
						
						bar.exp = exp_time
						bar:SetMinMaxValues(0 , dur)
						
						bar:SetScript("OnUpdate", function(self, e)
							self.t = self.t + e
							if self.t > self.update_rate then		
								local remain = exp_time - GetTime()
								if remain > 0 then								
									self.right:SetText(T.FormatTime(remain))
									self:SetValue(dur - remain)
								else
									self:Hide()
									self:SetScript("OnUpdate", nil)
								end
								self.t = 0
							end
						end)											
						bar:Show()
					end
					
					frame.lineup = function()
						local lastbar
						for GUID, bar in pairs(frame.bars) do
							bar:ClearAllPoints()
							if bar:IsVisible() then
								if not lastbar then
									bar:SetPoint("TOPLEFT", frame, "TOPLEFT", 35, -30)
									lastbar = bar
								else
									bar:SetPoint("TOPLEFT", lastbar, "BOTTOMLEFT", 0, -5)
									lastbar = bar
								end
							end
						end
					end
				end,
				update = function(frame, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then
						local timestamp, sub_event, _, _, _, _, _, destGUID, destName, _, _, spellID, spellName = CombatLogGetCurrentEventInfo()
			
						if (sub_event == "SPELL_AURA_APPLIED" or sub_event == "SPELL_AURA_APPLIED_DOSE") and (spellID == 356870) then	 			
							local dest = string.split("-", destName)
							if UnitIsUnit(dest, frame.anchor) then -- 避免重复
								frame.trap = frame.trap - 1
								frame.updatetext()
							end
							
						elseif sub_event == "UNIT_DIED" then						
							frame.update_anchor()
							
						elseif sub_event == "SPELL_AURA_APPLIED" and (spellID == frame.spellID) then -- 施放陷阱
							
							if GetTime() - frame.prev > 5 then -- 新的一轮
								frame.prev = GetTime()
								frame.counter = frame.counter + 1
								frame.updatetext()
								--print("轮数+1")
							end
							
							local dest = string.split("-", destName)
							
							if dest == G.PlayerName then
								frame.cd_tex:SetCooldown(GetTime(), 5)
							end
							
							if destGUID and AuraUtil.FindAuraByName(frame.spellName, dest, G.Test_Mod and "HELPFUL" or "HARMFUL") then
								local dur, exp_time = select(5, AuraUtil.FindAuraByName(frame.spellName, dest, G.Test_Mod and "HELPFUL" or "HARMFUL"))
								if not frame.bars[destGUID] then
									frame.create_bar(destGUID, dest)
								end
								
								local bar = frame.bars[destGUID]
								frame.updatebar(bar, dur, exp_time)
								frame.lineup()
							end	
								
						elseif sub_event == "SPELL_AURA_REMOVED" and (spellID == frame.spellID) then
							frame.trap = frame.trap + 1
							frame.updatetext()
							
							local dest = string.split("-", destName)
							if dest == G.PlayerName then
								frame.cd_tex:SetCooldown(0, 0)
							end						
						end
						
					elseif event == "ENCOUNTER_START" then						
						frame.update_anchor()
						frame.prev = 0 -- 时间戳
						frame.counter = 0
						frame.trap = 0
						frame.anchor = "raid1"
						frame.updatetext()
						frame:Show()
					end
				end,
				reset = function(frame)					
					for tag, bar in pairs(frame.bars) do
						bar:ClearAllPoints()
						bar:Hide()
						bar:SetScript("OnUpdate", nil)	
					end
					frame:Hide()
				end,
			},
			{ -- 尖刺提示 已检查
				spellID = 356808,
				tip = L["TIP尖刺"],
				points = {a1 = "CENTER", a2 = "CENTER", x = -0, y = -40, width = 20, height = 20},			
				events = {
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,	
				},
				difficulty_id = {
					["all"] = true,
				},
				init = function(frame)
					frame.bar = CreateFrame("Frame", nil, frame)
					frame.bar:SetHeight(20)
					frame.bar:SetWidth(20)
					frame.bar:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
						
					frame.bar.mark = frame.bar:CreateTexture(nil, "OVERLAY")
					frame.bar.mark:SetTexture(G.media.blank)
					frame.bar.mark:SetVertexColor(1, 1, 0)
					frame.bar.mark:SetAllPoints()			
					
					frame.bar.text = T.createtext(frame.bar, "OVERLAY", 15, "OUTLINE", "CENTER")
					frame.bar.text:SetPoint("CENTER")
							
					frame.t = 0
					frame.update_rate = .02
					
					frame:Hide()
					
					frame.start = 0
				end,
				update = function(frame, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then
						local timestamp, sub_event, _, _, _, _, _, _, destName, _, _, spellID, spellName = CombatLogGetCurrentEventInfo()
						if sub_event == "SPELL_AURA_REMOVED" and (spellID == 355778 or spellID == 348508) then
							frame.start = GetTime()
							frame:SetScript("OnUpdate", function(self, e)
								self.t = self.t + e
								if self.t > self.update_rate then
									self.played = self.played or 0
									local passed = GetTime() - self.start
									local index, value
									if passed <= .6 then
										index = 1
										value = 0.63 + passed
									else
										index = math.ceil((passed - 0.6)/1.23) + 1
										value = passed - 0.6 - 1.23*(index-2)
									end
									
									if value >= 1.1 and index ~= self.played then
										if not SoD_CDB["General"]["disable_sound"] then
											PlaySoundFile(G.media.sounds.."bip.ogg", "Master") -- 声音 bip
										end
										self.played = index
									end
									
									if index <= 12 then
										self.bar.text:SetText(index)
										if value < .4 then
											self.bar.mark:SetVertexColor(0, 1, 0)
										else
											self.bar.mark:SetVertexColor(1, 1, 0)
										end
									else
										self.reset(self)
									end
									self.t = 0
								end
							end)
							frame:Show()												
						end
					elseif event == "ENCOUNTER_START" then
						frame:Hide()
					end
				end,
				reset = function(frame)
					frame:Hide()
					frame:SetScript("OnUpdate", nil)
					
					frame.start = 0
					frame.bar.text:SetText("")
				end,
			},
			{ -- 熔炉烈焰 
				spellID = 359033,
				tip = L["TIP熔炉烈焰"],
				points = {a1 = "BOTTOM", a2 = "CENTER", x = 0, y = 300, width = 400, height = 40},	
				events = {	
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,
				},
				difficulty_id = {
					["all"] = true,
				},
				init = function(frame)
					frame.spellName, _, frame.iconTexture = GetSpellInfo(359033)									
					
					local bar = T.CreateTimerBar(frame, frame.iconTexture, false, false, true, 400, 40, 25, 1, 1, 0)				
					bar:SetPoint("TOPLEFT", frame, "TOPLEFT")
					bar:SetMinMaxValues(0, 5)	
					frame.bar = bar
				end,
				update = function(frame, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then
						local timestamp, sub_event, _, _, _, _, _, _, destName, _, _, spellID, spellName = CombatLogGetCurrentEventInfo()
						if sub_event == "SPELL_AURA_APPLIED" and spellID == 355525 then -- 铸造武器开始
							frame.bar:Show()
							frame.bar.left:SetText(frame.spellName)
							frame.bar.start = GetTime()
							frame.bar.ind = 2
							frame.bar.current = 1
							
							local difficultyID = select(3, GetInstanceInfo())
							if difficultyID == 16 then -- M
								frame.bar.max_ind = 11
							else
								frame.bar.max_ind = 9
							end
							
							frame.bar:SetScript("OnUpdate", function(self, e)
								self.t = self.t + e
								if self.t > self.update_rate then
									if self.current ~= self.ind then
										self.left:SetText(string.format("%s [%d]", frame.spellName, self.ind))
										self.current = self.ind
									end
									local remain = self.start + 5*(self.ind-1) - GetTime()
									if remain > 0 then
										self.right:SetText(T.FormatTime(remain))
										self:SetValue(5 - remain)
									elseif self.ind < self.max_ind then
										self.ind = self.ind + 1
									else
										self:Hide()
										self:SetScript("OnUpdate", nil)				
									end
									self.t = 0
								end
							end)
						end						
					end
				end,
				reset = function(frame)
					frame.bar:Hide()
					frame.bar:SetScript("OnUpdate", nil)	
				end,
			},
		},
	},
}

G.Encounters[7] = { -- 初诞者的卫士 已过初检	
	id = 2446,
	engage_id = 2436,
	npc_id = "175731", 
	img = 4071428,
	alerts = {
		AlertIcon = {
			{type = "aura", tip = "AE光环", hl = "no", spellID = 350534, aura_type = "HELPFUL", unit = "boss1"}, -- 净化协议 待检查	
			{type = "aura", role = "tank", hl = "no", spellID = 350732, aura_type = "HARMFUL", unit = "player"}, -- 破甲 已检查
			{type = "aura", tip = "湮灭易伤", hl = "no", spellID = 358619, dif = {[15] = true, [16] = true}, aura_type = "HARMFUL", unit = "player"}, -- 湮灭 待检查					
			{type = "cast", tip = "召唤小怪", hl = "hl", spellID = 352660}, -- 组合哨卫 已检查
			{type = "cast", tip = "召唤三圈", hl = "hl", spellID = 356090}, -- 净除威胁 待检查
			{type = "aura", tip = "出去放圈", hl = "hl", spellID = 350496, aura_type = "HARMFUL", unit = "player"}, -- 净除威胁 已检查		
			{type = "aura", tip = "能量链接", hl = "hl", spellID = 352385, aura_type = "HELPFUL", unit = "boss1"}, -- 能量链接 待检查
			{type = "aura", tip = "别出去", hl = "no", spellID = 352394, aura_type = "HARMFUL", unit = "player"}, -- 光辉能量 待检查
		},
		HLOnRaid = {
			{type = "HLCast", role = "tank", spellID = 350732}, -- 破甲 已检查
			{type = "HLCast", spellID = 355352, Glow = true}, -- 湮灭 已检查
			{type = "HLAuras", spellID = 350496, Glow = true}, -- 净除威胁 已检查
		},
		TextAlert = {
			{	-- 已检查
				type = "pp",
				data = {
					unit = "boss1",
					npc_id = "175731",
					ranges = {
						{ ul = 20, ll = 2, tip = L["BOSS能量"]},
					},
				},
				
			},
		},
		ChatMsg = {
			{type = "ChatMsgAuraCountdown", spellID = 350496, playername = true, spellname = false, icon = 8}, -- 净除威胁
			{type = "ChatMsgCom", role="tank", spellID = 355352, playername = true, spellname = true, icon = 7}, -- 湮灭
		},
		Sound = {		
			{spellID = 350732, role = "tank", event = "UNIT_SPELLCAST_START"}, -- 破甲
			{spellID = 355352, event = "UNIT_SPELLCAST_START"}, -- 湮灭
			{spellID = 352660, event = "UNIT_SPELLCAST_START"}, -- 召唤小怪
			{spellID = 350496, event = "BW_AND_DBM_SPELL", dur = 3, countdown = false}, -- 准备放圈
			{spellID = 352833, event = "UNIT_SPELLCAST_START"}, -- 躲开正面
			{spellID = 352385, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED"}, -- 能量链接		
			{spellID = 352394, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED", unit = "player"}, -- 安全安全
			{spellID = 352589, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_CAST_START"}, -- 熔毁
		},
		HP_Watch = {
			{sub_event = "SPELL_CAST_START", spellID = 352538}, -- 净化协议
			{sub_event = "SPELL_AURA_APPLIED", on_me = true, spellID = 350496}, -- 净除威胁
		},
		BossMods = {
			{ -- 破甲 湮灭
				spellID = 350732,
				role = "tank",
				tip = string.format(L["多人光环提示"], T.GetIconLink(350732).." "..T.GetIconLink(358619)),
				points = {a1 = "TOPLEFT", a2 = "CENTER", x = -700, y = 100, width = 250, height = 100},				
				events = {
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,	
				},
				difficulty_id = {
					["all"] = true,
				},
				init = function(frame)
					frame.aura_spell_ids = {350732, 358619}
					frame.aura_spells = {}
					for i, v in pairs(frame.aura_spell_ids) do
						frame.aura_spells[v] = {aura = GetSpellInfo(v), icon = select(3, GetSpellInfo(v))}
					end
					
					frame.bars = {}
						
					frame.create_bar = function(tag, spellID, player)
						local bar = T.CreateTimerBar(frame, frame.aura_spells[spellID]["icon"], true, false, true)
						bar.spellID = spellID
						bar.name = player
						frame.bars[tag] = bar	
					end
				
					frame.updatebar = function(bar, count, dur, exp_time)
						bar.left:SetText(T.ColorName(bar.name, true))
						
						bar.exp = exp_time
						bar.anim_played = false
						bar:SetMinMaxValues(0 , dur)
						
						bar:SetScript("OnUpdate", function(self, e)
							self.t = self.t + e
							if self.t > self.update_rate then		
								local remain = exp_time - GetTime()
								if remain > 0 then								
									self.right:SetText((count > 0 and "|cffFFFF00["..count.."]|r " or "")..T.FormatTime(remain))
									self:SetValue(dur - remain)
									if remain < 3 then -- 即将消失
										if not self.anim_played then
											self.anim_played = true
											self.glow:Show()
											self.anim:Play()
										end
										self.glow:SetAlpha(self.anim:GetProgress())
									end
								else
									self:Hide()
									self:SetScript("OnUpdate", nil)
									self.anim:Stop()
									self.glow:Hide()
								end
								self.t = 0
							end
						end)											
						bar:Show()
					end
					
					frame.lineup = function()
						local t = {}
						for GUID, bar in pairs(frame.bars) do
							if bar and bar:IsVisible() then
								table.insert(t, bar)
							end
						end
						if #t > 1 then
							table.sort(t, function(a, b) 
								if a.spellID < b.spellID then
									return true
								elseif a.spellID == b.spellID and a.exp < b.exp then
									return true
								end
							end)
						end
						local lastbar
						for i, bar in pairs(t) do
							bar:ClearAllPoints()
							if bar:IsVisible() then
								if not lastbar then
									bar:SetPoint("TOPLEFT", frame, "TOPLEFT", 30, -5)
									lastbar = bar
								else
									bar:SetPoint("TOPLEFT", lastbar, "BOTTOMLEFT", 0, -5)
									lastbar = bar
								end
							end
						end
					end			
				end,
				update = function(frame, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then						
						local _, sub_event, _, _, _, _, _, destGUID, destName, _, _, spellID = CombatLogGetCurrentEventInfo()
						if (sub_event == "SPELL_AURA_APPLIED" or sub_event == "SPELL_AURA_APPLIED_DOSE" or sub_event == "SPELL_AURA_REMOVED_DOSE") and frame.aura_spells[spellID] then						
							local dest = string.split("-", destName)				
							if destGUID and AuraUtil.FindAuraByName(frame.aura_spells[spellID]["aura"], dest, G.Test_Mod and "HELPFUL" or "HARMFUL") then
								local count, _, dur, exp_time = select(3, AuraUtil.FindAuraByName(frame.aura_spells[spellID]["aura"], dest, G.Test_Mod and "HELPFUL" or "HARMFUL"))
								if not frame.bars[spellID.."_"..destGUID] then
									frame.create_bar(spellID.."_"..destGUID, spellID, dest)
								end
								
								local bar = frame.bars[spellID.."_"..destGUID]
								frame.updatebar(bar, count, dur, exp_time)
								
								frame.lineup()
							end
						elseif sub_event == "SPELL_AURA_REMOVED" and frame.aura_spells[spellID] then
							if destGUID and frame.bars[spellID.."_"..destGUID] then
								local bar = frame.bars[spellID.."_"..destGUID]
								bar:Hide()
								bar:SetScript("OnUpdate", nil)
								bar.anim:Stop()
								bar.glow:Hide()
								frame.lineup()
							end
						end
					end	
				end,
				reset = function(frame)
					for tag, bar in pairs(frame.bars) do
						bar:ClearAllPoints()
						bar:Hide()
						bar:SetScript("OnUpdate", nil)
						bar.anim:Stop()
						bar.glow:Hide()
					end				
					frame.bars = table.wipe(frame.bars)
					frame:Hide()
				end,
			},
			{ -- 净化协议读条计数 已检查
				spellID = 352538,
				tip = L["TIP净化协议读条计数"],
				points = {a1 = "BOTTOM", a2 = "CENTER", x = 0, y = 300, width = 400, height = 40},				
				events = {	
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,
				},
				difficulty_id = {
					["all"] = true,
				},
				init = function(frame)
					frame.spellName, _, frame.iconTexture = GetSpellInfo(352538)
										
					local bar = T.CreateTimerBar(frame, frame.iconTexture, true, false, true, 400, 40, 25, 1, 1, 0)	
					bar:SetPoint("TOPLEFT", frame, "TOPLEFT")				
					bar:SetMinMaxValues(0, 5)
					bar.ind = 0				
					frame.bar = bar
				end,
				update = function(frame, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then
						local timestamp, sub_event, _, _, _, _, _, _, destName, _, _, spellID, spellName = CombatLogGetCurrentEventInfo()
						if sub_event == "SPELL_CAST_START" and spellID == 352538 then -- 净化协议 开始读条
							frame.bar.ind = frame.bar.ind + 1
							frame.bar.left:SetText(string.format("%s [%d]", frame.spellName, frame.bar.ind))
							
							if not SoD_CDB["General"]["disable_sound"] then
								PlaySoundFile(G.media.sounds.."count\\"..frame.bar.ind..".ogg", "Master") -- 语音报数
							end
							
							frame.bar:Show()
							frame.bar.exp = GetTime() + 5					
									
							frame.bar:SetScript("OnUpdate", function(self, e)
								self.t = self.t + e
								if self.t > self.update_rate then
									local remain = self.exp - GetTime()
									if remain > 0 then
										self.right:SetText(T.FormatTime(remain))
										self:SetValue(5 - remain)
										if self.ind >= 3 then
											self.glow:SetAlpha(self.anim:GetProgress())
										end
									else
										self.left:SetText("")
										self:Hide()	
										self:SetScript("OnUpdate", nil)
										if self.ind >= 3 then
											self.anim:Stop()
											self.glow:Hide()
										end
									end
									self.t = 0
								end
							end)
							
							if frame.bar.ind >= 3 then	
								frame.bar.glow:Show()
								frame.bar.anim:Play()						
							end
							
						elseif sub_event == "SPELL_AURA_REMOVED" and spellID == 350534 then -- 净化协议 光环消失
							frame.bar.left:SetText("")
							frame.bar:Hide()	
							frame.bar:SetScript("OnUpdate", nil)
							if frame.bar.ind >= 3 then
								frame.bar.anim:Stop()
								frame.bar.glow:Hide()
							end
						elseif sub_event == "SPELL_CAST_SUCCESS" and spellID == 352589 then -- 熔毁
							frame.bar.ind = 0 -- 熔毁后计数器重置为0
							frame.bar.glow:Hide()
						end
					elseif event == "ENCOUNTER_START" then
						frame.bar.ind = 0
						frame.bar.left:SetText("")
						frame.bar.glow:Hide()
					end
				end,
				reset = function(frame)
					frame.bar.ind = 0
					frame.bar.left:SetText("")
					frame.bar:Hide()
					frame.bar:SetScript("OnUpdate", nil)
					frame.bar.anim:Stop()
					frame.bar.glow:Hide()
				end,
			},
			{ -- 湮灭分担顺序 Exrt技能安排联动 待检查
				spellID = 355352,
				tip = L["TIP湮灭"],
				points = {width = 250, height = 100},	
				events = {
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,
				},
				difficulty_id = {
					[15] = true,
					[16] = true,
				},
				init = function(frame)
					frame.text = T.createtext(frame, "OVERLAY", 25, "OUTLINE", "LEFT")
					frame.text:SetPoint("TOPLEFT", frame, "TOPLEFT", 5, -5)
					
					frame.text2 = T.createtext(frame, "OVERLAY", 30, "OUTLINE", "LEFT")
					frame.text2:SetPoint("TOPLEFT", frame.text, "BOTTOMLEFT", 0, -5)
				
					frame.counter = 0
					frame.order = {}
				end,
				update = function(frame, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then
						local timestamp, sub_event, _, _, _, _, _, _, _, _, _, spellID, spellName = CombatLogGetCurrentEventInfo() 
						if sub_event == "SPELL_CAST_SUCCESS" and spellID == 355352 then
							frame.counter = frame.counter + 1
							local show_order = math.fmod(frame.counter+1, #frame.order)
							if show_order == 0 then show_order = #frame.order end
							if show_order and show_order > 0 then
								local next_str = tostring(frame.counter+1)
								str = "("..next_str..")"..frame.order[show_order]
							else
								str = "nodata"
							end
							frame.text:SetText(L["下一轮湮灭"]..str)
							frame.text2:SetText("")
						elseif sub_event == "SPELL_CAST_START" and spellID == 355352 then
							local show_order = math.fmod(frame.counter+1, #frame.order)
							if show_order == 0 then show_order = #frame.order end
							if show_order and show_order > 0 then
								local next_str = tostring(frame.counter+1)
								str = "("..next_str..")"..frame.order[show_order]
							else
								str = "nodata"
							end
							if str:match(G.PlayerName) then
								frame.text2:SetText(L["分担伤害"])
								if not SoD_CDB["General"]["disable_sound"] then
									PlaySoundFile(G.media.sounds.."GuardianOfTheFirstOnes\\share.ogg", "Master") -- 声音
								end
							end
						end
					elseif event == "ENCOUNTER_START" then
						frame.counter = 0
						frame.order = table.wipe(frame.order)
						if IsAddOnLoaded("MRT") and _G.VExRT.Note and _G.VExRT.Note.Text1 then
							local text = _G.VExRT.Note.Text1
							local betweenLine = false
							local count = 0
							for line in text:gmatch('[^\r\n]+') do
								if line:match("end") then
									betweenLine = false
								end
								if betweenLine then
									count = count + 1
									frame.order[count] = line:gsub("||", "|")
								end
								if line:match(L["湮灭分担顺序"]) then
									betweenLine = true
								end
							end
						end
						local show_order = math.fmod(frame.counter+1, #frame.order)
						if show_order == 0 then show_order = #frame.order end
						local str
						if show_order and show_order > 0 then
							local next_str = tostring(frame.counter+1)
							str = "("..next_str..")"..frame.order[show_order]
						else
							str = "nodata"
						end
						frame.text:SetText(L["下一轮湮灭"]..str)
					end			
				end,
				reset = function(frame)
					frame:Hide()
					frame.text:SetText("")
					frame.text2:SetText("")
					
					frame.counter = 0
					frame.order = table.wipe(frame.order)
				end,
			},	
			{ -- 净除威胁 已检查
				spellID = 350496,
				tip = L["TIP净除威胁"],
				points = {a1 = "TOPLEFT", a2 = "CENTER", x = -700, y = 300, width = 250, height = 100},			
				events = {
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,
				},
				difficulty_id = {
					["all"] = true,
				},
				init = function(frame)
					frame.aura = GetSpellInfo(350496)
					
					frame.text = T.createtext(frame, "OVERLAY", 20, "OUTLINE", "LEFT")
					frame.text:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
					
					frame.text_center = T.createtext(frame, "OVERLAY", 40, "OUTLINE", "LEFT")
					frame.text_center:SetPoint("BOTTOM", UIParent, "CENTER", 0, 200)
					
					frame.cd_tex = T.CreateCircleCD(frame, 50, 1, 1, 0)
					frame.cd_tex:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
					
					frame.marks = {
						{
							{8, "无标记", 0},
							{1, "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_1:0|t", 1}, -- 星星
							{2, "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_2:0|t", 2}, -- 大饼
						},
						{
							{8, "无标记", 0},
							{3, "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_3:0|t", 3}, -- 菱形
							{4, "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_4:0|t", 4}, -- 三角
						},
						{
							{8, "无标记", 0},
							{5, "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_5:0|t", 5}, -- 月亮
							{6, "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_6:0|t", 6}, -- 方块
						},
					}
					
					frame.targets = {}
					frame.current_core = 1
					frame.t = 0
					
					frame.updatetext = function()
						local str = ""
						local difficultyID = select(3, GetInstanceInfo())

						if difficultyID	== 16 and frame.current_core <= 3 then
							for i, target in pairs(frame.targets) do
								local mark, name
								rm = frame.marks[frame.current_core][i][1]
								mark = frame.marks[frame.current_core][i][2]
								name = T.ColorName(target, true)
								
								str = str..string.format("|T132177:12:12:0:0:64:64:4:60:4:60|t %s - %s\n", name, mark)
								
								T.SetRaidTarget(target, rm) -- 上标记
								
								if target == G.PlayerName then -- 是我
									
									frame.exp = GetTime() + 4
									frame:SetScript("OnUpdate", function(self, e)
										self.t = self.t + e
										if self.t > 0.05 then
											local remain = self.exp - GetTime()
											if remain > 0 then
												self.text_center:SetText(string.format("%s %s %s", mark, T.FormatTime(remain), mark))
											else
												self:SetScript("OnUpdate", nil)
												self.text_center:SetText("")
											end		
											self.t = 0
										end
									end)
									
									frame.cd_tex:SetCooldown(GetTime(), 4)
									
									if not SoD_CDB["General"]["disable_sound"] then
										local sound_ind = frame.marks[frame.current_core][i][3]
										PlaySoundFile(G.media.sounds.."mark\\mark"..sound_ind..".ogg", "Master") -- 声音 标记
									end
									
									T.SendChatMsg("{rt"..rm.."}{rt"..rm.."}{rt"..rm.."}", 4) -- 喊话5次
								end
							end
						else -- 3个都炸完哩
							for i, target in pairs(frame.targets) do
								local name = T.ColorName(target, true)
								
								str = str..string.format("%s\n", name)
								
								if target == G.PlayerName then -- 是我
												
									frame.exp = GetTime() + 4
									frame:SetScript("OnUpdate", function(self,e)
										self.t = self.t + e
										if self.t > 0.05 then
											local remain = self.exp - GetTime()
											if remain > 0 then
												self.text_center:SetText(L["离开人群"].." "..T.FormatTime(remain))
											else
												self:SetScript("OnUpdate", nil)
												self.text_center:SetText("")
											end		
											self.t = 0
										end
									end)
									
									frame.cd_tex:SetCooldown(GetTime(), 4)
									
									if not SoD_CDB["General"]["disable_sound"] then
										PlaySoundFile(G.media.sounds.."getout.ogg", "Master") -- 离开人群
									end
									
								end
							end
						end
						
						frame.text:SetText(str)
						
						C_Timer.After(4, function()
							frame.text:SetText("")
							frame.text_center:SetText("")
							for i, target in pairs(frame.targets) do
								T.SetRaidTarget(target, 0) --去掉标记
							end
						end)
					end
					
				end,
				update = function(frame, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then
						local _, sub_event, _, 	sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellID, spellName, _, amount = CombatLogGetCurrentEventInfo()
						
						if sub_event == "SPELL_CAST_SUCCESS" and spellID == 350496 then -- 净除威胁
							frame:Show()
							frame.targets = table.wipe(frame.targets)
							C_Timer.After(.2, function()
								local group_size = GetNumGroupMembers()	
								for i = 1, group_size do
									local unit = "raid"..i
									local name = AuraUtil.FindAuraByName(frame.aura, unit, "HARMFUL")
									if name then -- 找被点名的玩家
										local debuff_player = UnitName(unit)
										table.insert(frame.targets, debuff_player)
									end
								end
								frame.updatetext()
							end)
						elseif sub_event == "SPELL_CAST_START" and spellID == 352589 then -- 熔毁
							frame.current_core = frame.current_core + 1
						end
					elseif event == "ENCOUNTER_START" then
						frame.current_core = 1
						frame.targets = table.wipe(frame.targets)
						frame.text:SetText("")
						frame.text_center:SetText("")	
					end
				end,
				reset = function(frame)
					frame.text:SetText("")
					frame.text_center:SetText("")
					frame:Hide()
				end,
			},
			{ -- 能量核心能量 已检查
				spellID = 356093,
				tip = L["TIP能量核心能量"],
				points = {a1 = "TOPLEFT", a2 = "CENTER", x = -700, y = 200, width = 250, height = 100},					
				events = {
					["UNIT_POWER_UPDATE"] = true,
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,
				},
				difficulty_id = {
					["all"] = true,
				},
				init = function(frame)
					frame.bars = {}

					for i = 1, 4 do
						frame.bars[i] = T.CreateTimerBar(frame)
						frame.bars[i]:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, -30*(i-1))
						frame.bars[i]:SetStatusBarColor(.7, .7, .7)
						frame.bars[i]:SetMinMaxValues(0, 60)
						if i == 1 then -- BOSS
							frame.bars[i].icon:SetTexture(4062733)
						else -- 柱子
							frame.bars[i].icon:SetTexture(442737)
						end
						frame.bars[i].unit = "boss"..i
					end
					
				end,
				update = function(frame, event, ...)
					if event == "UNIT_POWER_UPDATE" then
						local unit = ...
						if strfind(unit, "boss") then
							for i, bar in pairs(frame.bars) do
								if bar.guid then
									bar:SetValue(UnitPower(bar.unit))
									bar.right:SetText(UnitPower(bar.unit))
								end
							end
						end
					elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
						local timestamp, sub_event, _, 	sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellID, spellName, _, amount = CombatLogGetCurrentEventInfo()
						if sub_event == "SPELL_CAST_SUCCESS" and spellID == 352589 then -- 熔毁
							C_Timer.After(1, function()
								for i, bar in pairs(frame.bars) do
									if bar.guid ~= sourceGUID then
										bar:SetValue(UnitPower(bar.unit))
										bar.right:SetText(UnitPower(bar.unit))
										--print(bar.unit, bar.guid, UnitPower(bar.unit))
									else -- 已经没了
										bar:SetValue(0)
										bar.left:SetText("")
										bar.right:SetText("")			
										bar.guid = nil
										bar:Hide()
									end
								end
							end)
						end
					elseif event == "ENCOUNTER_START" then
						C_Timer.After(1, function()
							for i, bar in pairs(frame.bars) do
								bar:SetValue(UnitPower(bar.unit))
								bar.left:SetText(UnitName(bar.unit))
								bar.right:SetText(UnitPower(bar.unit))			
								bar.guid = UnitGUID(bar.unit)
								bar:Show()
								--print(bar.unit, bar.guid, UnitPower(bar.unit))
							end
						end)
					end
				end,
				reset = function(frame)
					for i, bar in pairs(frame.bars) do				
						bar:SetValue(0)
						bar.left:SetText("")
						bar.right:SetText("")			
						bar.guid = nil
						bar:Hide()
					end	
					frame:Hide()
				end,
			},
			{ -- 读条 湮灭 破甲 分解 熔毁
				spellID = 352589,
				tip = L["TIP湮灭计时条"],
				points = {a1 = "BOTTOM", a2 = "CENTER", x = 0, y = 150, width = 350, height = 120},						
				events = {	
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,
				},
				difficulty_id = {
					["all"] = true,
				},
				init = function(frame)
					frame.spellIDs = {
						[355352] = { -- 湮灭
							color = {r = 1, g = 1, b = .8},
							points = {"TOPLEFT", frame, "TOPLEFT", 0, 0}, 
							text = L["湮灭"],
							count = false,
						},
						[350732] = { -- 破甲
							color = {r = .82, g = .7, b = .55},
							points = {"TOPLEFT", frame, "TOPLEFT", 0, 0}, 
							text = L["破甲"],
							count = false,
						},
						[352833] = { -- 分解
							color = {r = 0, g = 1, b = 1},
							points = {"TOPLEFT", frame, "TOPLEFT", 0, 0}, 
							text = L["分解"],
							count = false,
						},
						[352589] = { -- 熔毁
							color = {r = .7, g = .7, b = .7},
							points = {"TOPLEFT", frame, "TOPLEFT", 0, -30}, 
							text = L["熔毁"],
							count = true,
						},
					}
					frame.bars = {}
					
					frame.CreateBar = function(spellID, r, g, b, ...)
						local spell_name, _, icon, cast_time = GetSpellInfo(spellID)
						
						local bar = T.CreateTimerBar(frame, icon, false, false, true, 350, 28, 20, r, g, b)
						bar.ind = 0
						bar.dur = cast_time/1000
						bar:SetPoint(...)
						bar:SetMinMaxValues(0, bar.dur)
						
						frame.bars[spellID] = bar
					end
					
					for k, v in pairs(frame.spellIDs) do
						frame.CreateBar(k, v.color.r, v.color.g, v.color.b, unpack(v.points))
					end
				end,
				update = function(frame, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then
						local timestamp, sub_event, _, sourceGUID, sourceName, _, _, _, destName, _, _, spellID, spellName = CombatLogGetCurrentEventInfo()
						if sub_event == "SPELL_CAST_START" and frame.spellIDs[spellID] then -- 开始
							local bar = frame.bars[spellID]
							bar.ind = bar.ind + 1
							if frame.spellIDs[spellID]["count"] then
								bar.left:SetText(string.format(frame.spellIDs[spellID]["text"], bar.ind))	
							else
								bar.left:SetText(frame.spellIDs[spellID]["text"])
							end
							
							bar.exp = GetTime() + bar.dur			
							bar:SetScript("OnUpdate", function(self, e)
								self.t = self.t + e
								if self.t > self.update_rate then
									local remain = self.exp - GetTime()
									if remain > 0 then		
										self.right:SetText(T.FormatTime(remain))
										self:SetValue(bar.dur - remain)
									else
										self.right:SetText("")	
										self:Hide()
										self:SetValue(0)
										self:SetScript("OnUpdate", nil)
									end
									self.t = 0
								end
							end)
							bar:Show()
						elseif sub_event == "SPELL_CAST_FAILED" and frame.spellIDs[spellID] then -- 中断
							local bar = frame.bars[spellID]
							bar.right:SetText("")	
							bar:Hide()
							bar:SetValue(0)
							bar:SetScript("OnUpdate", nil)
						end
					elseif event == "ENCOUNTER_START" then
						for k, bar in pairs(frame.bars) do
							bar.ind = 0
						end
					end
				end,
				reset = function(frame)
					for k, bar in pairs(frame.bars) do
						bar.right:SetText("")
						bar.ind = 0
						bar:Hide()
						bar:SetValue(0)
						bar:SetScript("OnUpdate", nil)	
					end
					frame:Hide()					
				end,
			},
		},
	},
}

G.Encounters[8] = { -- 命运撰写师罗卡洛 已过初检
	id = 2447,
	engage_id = 2431,
	npc_id = "175730", 
	img = 4071427,
	alerts = {
		AlertIcon = {			
			{type = "cast", tip = "准备接圈", hl = "hl", spellID = 354367, dif = {[16] = true}}, -- 恐怖征兆 待检查
			{type = "log", tip = "接圈点你", hl = "hl", spellID = 354365, dif = {[16] = true}, event_type = "SPELL_AURA_APPLIED", dur = 11, targetID = "player"}, -- 恐怖征兆 待检查
			{type = "cast", role = "tank", hl = "hl", spellID = 351680}, -- 祈求宿命 待检查
			{type = "aura", tip = "风筝小怪", role = "tank", hl = "no", spellID = 353432, aura_type = "HARMFUL", unit = "player"}, -- 命运重担 待检查
			{type = "aura", tip = "注意自保", hl = "hl", spellID = 353435, aura_type = "HARMFUL", unit = "player"}, -- 不堪重负 已检查
			{type = "com", role = "tank", hl = "hl", spellID = 353603}, -- 预言家的查验 待检查
			{type = "aura", role = "tank", hl = "no", spellID = 353604, aura_type = "HELPFUL", unit = "boss1"}, -- 预言家的查验 待检查
			{type = "aura", tip = "注意自保", hl = "no", spellID = 353931, aura_type = "HARMFUL", unit = "player"}, -- 扭曲命运 已检查
			{type = "cast", tip = "连线快躲", hl = "hl", spellID = 350421}, -- 宿命联结	已检查	
			{type = "cast", tip = "准备大圈", hl = "hl", spellID = 350554}, -- 永恒之唤 已检查
			{type = "aura", tip = "贴边放圈", hl = "hl", spellID = 350568, aura_type = "HARMFUL", unit = "player"}, -- 永恒之唤 待检查
			{type = "aura", tip = "注意自保", hl = "no", spellID = 353162, aura_type = "HARMFUL", unit = "player"}, -- 宿命残片 待检查
			{type = "cast", tip = "阶段转换", hl = "no", spellID = 351969}, -- 命运重构 已检查
			{type = "aura", tip = "符文点你", hl = "no", spellID = 354964, aura_type = "HARMFUL", unit = "player"}, -- 符文亲和
			{type = "aura", tip = "连线出现", hl = "no", spellID = 357686, aura_type = "HARMFUL", unit = "player"}, -- 命运重担 待检查
			{type = "aura", tip = "大怪DOT", hl = "no", spellID = 357144, aura_type = "HARMFUL", unit = "player"}, -- 绝望
		},
		HLOnRaid = {
			{type = "HLAuras", role = "tank", spellID = 353432}, -- 命运重担 待检查
			{type = "HLAuras", role = "tank", spellID = 353435}, -- 不堪重负 已检查
			{type = "HLAuras", spellID = 350568, Glow = true}, -- 永恒之唤 已检查
			{type = "HLAuras", spellID = 353931, Glow = true}, -- 扭曲命运 待检查
			{type = "HLAuras", spellID = 357686}, -- 展露的命运丝线 待检查
			{type = "HLAuras", spellID = 357144}, -- 绝望 待检查
		},
		PlateAlert = {
			{type = "PlatePower", mobID = "179124"}, -- 命运之影 已检查		
		}, 
		TextAlert = {
			{	-- 已检查
				type = "hp",
				data = {
					unit = "boss1",
					npc_id = "175730",
					ranges = {
						{ ul = 75, ll = 70.5, tip = string.format(L["阶段转换"], "70")},
						{ ul = 45, ll = 40.5, tip = string.format(L["阶段转换"], "40")},
					},
				},
			},
		},
		ChatMsg = {
			{type = "ChatMsgAuras", spellID = 354367, playername = true, spellname = true, icon = 8}, -- 恐怖征兆 待检查
			{type = "ChatMsgAuraCountdown", role = "tank", spellID = 351680, playername = true, spellname = true, icon = 0}, -- 祈求宿命 待检查
			{type = "ChatMsgAuraCountdown", spellID = 350568, playername = true, spellname = true}, -- 永恒之唤 待检查	
		},
		Sound = {
			{spellID = 354367, event = "UNIT_SPELLCAST_START"}, -- 准备接圈
			{spellID = 354365, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED" , unit = "player"}, -- 接圈点你
			{spellID = 351680, event = "UNIT_SPELLCAST_START"}, -- 准备小怪
			{spellID = 353432, role = "tank", event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED" , unit = "player"}, -- 风筝小怪
			{spellID = 353435, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED" , unit = "player"}, -- 注意自保
			{spellID = 353931, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED" , unit = "player"}, -- 注意自保
			{spellID = 350421, event = "UNIT_SPELLCAST_START"}, -- 连线快躲
			{spellID = 350554, event = "UNIT_SPELLCAST_START"}, -- 准备大圈
			{spellID = 350568, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED" , unit = "player", countdown = true}, -- 贴边放圈
			{spellID = 353162, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED" , unit = "player"}, -- 注意自保
		},
		HP_Watch = {
			{sub_event = "SPELL_AURA_APPLIED", spellID = 351680, delay = 5}, -- 祈求宿命
		},
		Phase_Change = {
			{sub_event = "SPELL_AURA_REMOVED", spellID = 357739}, -- 命运重构消失
			{sub_event = "SPELL_AURA_APPLIED", spellID = 357739}, -- 命运重构开始
		},
		BossMods = {
			{ -- 命运重担
				spellID = 353432,
				role = "tank",
				tip = string.format(L["多人光环提示"], T.GetIconLink(353432)),
				points = {a1 = "TOPLEFT", a2 = "CENTER", x = -700, y = -200, width = 250, height = 100},				
				events = {
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,	
				},
				difficulty_id = {
					["all"] = true,
				},
				init = function(frame)
					frame.aura_spell_ids = {353432}
					frame.aura_spells = {}
					for i, v in pairs(frame.aura_spell_ids) do
						frame.aura_spells[v] = {aura = GetSpellInfo(v), icon = select(3, GetSpellInfo(v))}
					end
					
					frame.bars = {}
						
					frame.create_bar = function(tag, spellID, player)
						local bar = T.CreateTimerBar(frame, frame.aura_spells[spellID]["icon"], true, false, true)
						bar.spellID = spellID
						bar.name = player
						frame.bars[tag] = bar		
					end
				
					frame.updatebar = function(bar, count, dur, exp_time)
						bar.left:SetText(T.ColorName(bar.name, true))
						
						bar.exp = exp_time
						bar.anim_played = false
						bar:SetMinMaxValues(0 , dur)
						
						bar:SetScript("OnUpdate", function(self, e)
							self.t = self.t + e
							if self.t > self.update_rate then		
								local remain = exp_time - GetTime()
								if remain > 0 then								
									self.right:SetText((count > 0 and "|cffFFFF00["..count.."]|r " or "")..T.FormatTime(remain))
									self:SetValue(dur - remain)
									if remain < 3 then -- 即将消失
										if not self.anim_played then
											self.anim_played = true
											self.glow:Show()
											self.anim:Play()
										end
										self.glow:SetAlpha(self.anim:GetProgress())
									end
								else
									self:Hide()
									self:SetScript("OnUpdate", nil)
									self.anim:Stop()
									self.glow:Hide()
								end
								self.t = 0
							end
						end)											
						bar:Show()
					end
					
					frame.lineup = function()
						local t = {}
						for GUID, bar in pairs(frame.bars) do
							if bar and bar:IsVisible() then
								table.insert(t, bar)
							end
						end
						if #t > 1 then
							table.sort(t, function(a, b) 
								if a.spellID < b.spellID then
									return true
								elseif a.spellID == b.spellID and a.exp < b.exp then
									return true
								end
							end)
						end
						local lastbar
						for i, bar in pairs(t) do
							bar:ClearAllPoints()
							if bar:IsVisible() then
								if not lastbar then
									bar:SetPoint("TOPLEFT", frame, "TOPLEFT", 30, -5)
									lastbar = bar
								else
									bar:SetPoint("TOPLEFT", lastbar, "BOTTOMLEFT", 0, -5)
									lastbar = bar
								end
							end
						end
					end			
				end,
				update = function(frame, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then						
						local _, sub_event, _, _, _, _, _, destGUID, destName, _, _, spellID = CombatLogGetCurrentEventInfo()
						if (sub_event == "SPELL_AURA_APPLIED" or sub_event == "SPELL_AURA_APPLIED_DOSE" or sub_event == "SPELL_AURA_REMOVED_DOSE") and frame.aura_spells[spellID] then						
							local dest = string.split("-", destName)				
							if destGUID and AuraUtil.FindAuraByName(frame.aura_spells[spellID]["aura"], dest, G.Test_Mod and "HELPFUL" or "HARMFUL") then
								local count, _, dur, exp_time = select(3, AuraUtil.FindAuraByName(frame.aura_spells[spellID]["aura"], dest, G.Test_Mod and "HELPFUL" or "HARMFUL"))
								if not frame.bars[spellID.."_"..destGUID] then
									frame.create_bar(spellID.."_"..destGUID, spellID, dest)
								end
								
								local bar = frame.bars[spellID.."_"..destGUID]
								frame.updatebar(bar, count, dur, exp_time)
								
								frame.lineup()
							end
						elseif sub_event == "SPELL_AURA_REMOVED" and frame.aura_spells[spellID] then
							if destGUID and frame.bars[spellID.."_"..destGUID] then
								local bar = frame.bars[spellID.."_"..destGUID]
								bar:Hide()
								bar:SetScript("OnUpdate", nil)
								bar.anim:Stop()
								bar.glow:Hide()
								frame.lineup()
							end
						end
					end	
				end,
				reset = function(frame)
					for tag, bar in pairs(frame.bars) do
						bar:ClearAllPoints()
						bar:Hide()
						bar:SetScript("OnUpdate", nil)
						bar.anim:Stop()
						bar.glow:Hide()
					end				
					frame.bars = table.wipe(frame.bars)
					frame:Hide()
				end,
			},
			{ -- 符文亲和 已检查
				spellID = 354964,
				tip = L["TIP符文亲和"],
				points = {width = 200, height = 600},				
				events = {
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,
					["CHAT_MSG_ADDON"] = true,
				},
				difficulty_id = {
					[15] = true,
					[16] = true,
				},
				init = function(frame)
					frame.spellID = 354964
					frame.aura = GetSpellInfo(frame.spellID) -- 符文亲和
					frame.rings = {}
					
					frame.marked_players = {}
					frame.backup_players = {}
					frame.p3_states = {}
					frame.in_phase = false
					frame.my_index = 0
					frame.wait_for_states = false
					
					frame.CreateRing = function(ind)
						local ring = frame:CreateTexture("sod_ring"..ind, "ARTWORK", nil, 9-ind*2)
						ring:SetSize(ind*28, ind*28)
						ring:SetPoint("CENTER", frame, "TOP", 0, -100)
						ring:SetTexture(G.media.circle)
						ring:SetVertexColor(.5, .5, .5)
						
						local ringbg = frame:CreateTexture("sod_ring"..ind, "ARTWORK", nil, 8-ind*2)
						ringbg:SetSize(ind*28+2, ind*28+2)
						ringbg:SetPoint("CENTER", frame, "TOP", 0, -100)
						ringbg:SetTexture(G.media.circle)
						ringbg:SetVertexColor(0, 0, 0)
						
						if ind >= 2 then
							local ringindex = T.createtext(frame, "OVERLAY", 14, "OUTLINE", "RIGHT")
							ringindex:SetPoint("RIGHT", ring, "RIGHT", 0, 0)
							ringindex:SetText(ind-1)
							
							frame.rings[ind-1] = ring
						end
					end
					
					for i = 1, 7 do
						frame.CreateRing(i)
					end
					
					frame.lightring = function(ind)
						frame.t = 0
						frame.exp = GetTime() + 1.5
						frame:SetScript("OnUpdate", function(self, e)
							self.t = self.t + e
							if self.t > 0.2 then
								local remain = self.exp - GetTime()
								if remain > 0 then
									local v = math.fmod(remain, .5)*2
									self.rings[ind]:SetVertexColor(.3*v, 1*v, .6*v)
								else
									self.rings[ind]:SetVertexColor(.3, 1, .6)
									self:SetScript("OnUpdate", nil)
								end
								self.t = 0
							end
						end)
					end
					
					frame.resetrings = function()
						for i = 1, 6 do
							frame.rings[i]:SetVertexColor(.5, .5, .5)
						end
					end
					
					frame.bar = CreateFrame("StatusBar", nil, frame)
					frame.bar:SetSize(160, 25)
					frame.bar:SetPoint("TOP", frame, "TOP", 0, -210)
					T.createborder(frame.bar)
					
					frame.bar:SetStatusBarTexture(G.media.blank)
					frame.bar:SetStatusBarColor(1, 1, 0)
										
					frame.bar.right = T.createtext(frame.bar, "OVERLAY", 18, "OUTLINE", "RIGHT")
					frame.bar.right:SetPoint("RIGHT", frame.bar, "RIGHT", -10, 0)
									
					frame.bar.t = 0
					frame.countdown = function()
						local dur 
						if frame.InP3() then
							dur = 46
						else
							dur = 53
						end
						frame.bar.exp = GetTime() + dur
						frame.bar:SetMinMaxValues(0, dur)
						frame.bar:SetValue(0)
						frame.bar:SetScript("OnUpdate", function(self, e)
							self.t = self.t + e
							if self.t > 0.02 then
								local remain = self.exp - GetTime()
								if remain > 0 then
									self:SetValue(dur - remain)
									self.right:SetText(T.FormatTime(remain))
								else
									self:SetScript("OnUpdate", nil)
								end
							end
						end)
					end
					
					frame.helpbtn = CreateFrame("Button", nil, frame)
					frame.helpbtn:SetPoint("TOP", frame.bar, "BOTTOM", 0, -10)
					frame.helpbtn:SetSize(160, 30)
					T.createborder(frame.helpbtn, 1, 1, .5, 1)
					
					frame.helpbtn.text = T.createtext(frame.helpbtn, "ARTWORK", 18, "OUTLINE", "CENTER")
					frame.helpbtn.text:SetPoint("CENTER", frame.helpbtn, "CENTER", 0, 0)
					frame.helpbtn.text:SetText(L["逆时针"])
					
					frame.helpbtn:RegisterForClicks("LeftButtonDown")
					
					frame.helpbtn:SetScript("OnEnable", function(self)
						self.sd:SetBackdropColor(1, 1, .5, 1)
						self.text:SetTextColor( 1, 1, 1, 1)
						frame.helpbtn:RegisterForClicks("LeftButtonUp")
					end)
					
					frame.helpbtn:SetScript("OnDisable", function(self)
						self.sd:SetBackdropColor( .5, .5, .5, 1)
						self.text:SetTextColor(.5, .5, .5)
						frame.helpbtn:RegisterForClicks("LeftButtonUp")
					end)				
					
					frame.helpbtn:SetScript("OnMouseDown", function(self)
						if self:IsEnabled() then
							self.sd:SetBackdropColor(0, .7, 1, 1)
							self.text:SetTextColor(.3, 1, 1)
							if not SoD_CDB["General"]["disable_sound"] then
								PlaySoundFile(G.media.sounds.."ding.ogg", "Master") -- 声音 ding
							end
						end
					end)
					
					frame.helpbtn:SetScript("OnMouseUp", function(self)
						if self:IsEnabled() then
							self.sd:SetBackdropColor(1, 1, .5, 1)
							self.text:SetTextColor( 1, 1, 1, 1)
						end
					end)
					 
					frame.helpbtn.timer = CreateFrame("Frame", nil, frame.helpbtn.timer)
					frame.helpbtn.timer.t = 0
					frame.helpbtn:SetScript("OnClick", function(self)
						if #frame.backup_players > 0 then -- 还有备用人员
							local player = frame.backup_players[1]
							C_ChatInfo.SendAddonMessage("sodpaopao", "need_"..player.."_"..frame.my_index, "RAID")
							self:Disable()
							frame.helpbtn.timer:SetScript("OnUpdate", function(self, e)
								self.t = self.t + e
								if self.t > 1 then
									if AuraUtil.FindAuraByName(frame.aura, "player", G.Test_Mod and "HELPFUL" or "HARMFUL") then -- 符文亲和期间
										T.SendChatMsg("{rt"..frame.my_index.."}"..frame.my_index..frame.my_index..frame.my_index.."{rt"..frame.my_index.."}") -- 持续喊话，让队友看到
									else
										self:SetScript("OnUpdate", nil) -- 符文亲和消失后取消
									end
									self.t = 0
								end
							end)
						end
					end)
					frame.helpbtn:Disable()
					
					frame.helpbtn.prepare = frame.helpbtn:CreateTexture(nil, "OVERLAY")
					frame.helpbtn.prepare:SetTexture(G.media.blank)
					frame.helpbtn.prepare:SetAllPoints()
					frame.helpbtn.prepare:SetVertexColor(.3, 1, .6)
					
					frame.helpbtn.preparetext = T.createtext(frame.helpbtn, "OVERLAY", 18, "OUTLINE", "CENTER")
					frame.helpbtn.preparetext:SetPoint("CENTER", frame.helpbtn, "CENTER", 0, 0)
					frame.helpbtn.preparetext:SetText(L["准备"])
				
					frame.show_prepare = function()
						frame.helpbtn.prepare:Show()
						frame.helpbtn.preparetext:Show()
					end
					
					frame.hide_prepare = function()
						frame.helpbtn.prepare:Hide()
						frame.helpbtn.prepare:SetVertexColor(.3, 1, .6)
						frame.helpbtn.preparetext:Hide()
						frame.helpbtn.preparetext:SetText(L["准备"])
					end
					
					frame.help_ind = function(ind)
						frame.helpbtn.t = 0
						frame.helpbtn.exp = GetTime() + 1.5
						frame.helpbtn:SetScript("OnUpdate", function(self, e)
							self.t = self.t + e
							if self.t > 0.2 then
								local remain = self.exp - GetTime()
								if remain > 0 then
									local v = math.fmod(remain, .5)*2
									frame.rings[ind]:SetVertexColor(1*v, .2*v, .2*v)
								else
									frame.rings[ind]:SetVertexColor(1, .2, .2)
									self:SetScript("OnUpdate", nil)
								end
								self.t = 0
							end
						end)	
						frame.helpbtn.preparetext:SetText(format(L["帮忙"], ind.."|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_"..ind..":0|t"))
						frame.lightring(ind)
						if not SoD_CDB["General"]["disable_sound"] then
							PlaySoundFile(G.media.sounds.."FatescribeRohKalo\\help"..ind..".ogg", "Master") -- 声音
						end
					end
					
					frame.text = T.createtext(frame, "OVERLAY", 20, "OUTLINE", "LEFT")
					frame.text:SetPoint("TOPLEFT", frame.helpbtn, "BOTTOMLEFT", 0, -5)
					
					frame.colorName = function(name) -- 人死了上标记
						if name then
							if UnitIsDead(name) then
								return T.ColorName(name)..L["死了"]
							else
								return T.ColorName(name)
							end
						end
					end
					
					frame.updatetext = function()
						local str = ""
						for i, players in pairs(frame.marked_players) do
							local line
							if players.backup then -- 偶数
								line = "["..i.."]|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_"..i..":0|t"..frame.colorName(players.assign).."("..frame.colorName(players.backup)..")".."\n"
							else -- 奇数
								line = "["..i.."]|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_"..i..":0|t"..frame.colorName(players.assign).."\n"
							end
							str = str..line
						end
						str = str.."------------\n"
						for i, player in pairs(frame.backup_players) do
							local line = frame.colorName(player).."\n"
							str = str..line
						end
						frame.text:SetText(str)
					end
					
					frame.InP3 = function()
						local perc = 1
						local hp = UnitHealth("boss1")
						local hp_max = UnitHealthMax("boss1")
						if hp and hp_max then
							perc = hp/hp_max
						end
						if perc < .38 then -- P3
							return true
						end
					end
					
					frame.UpdateP3Ring = function()
						frame.marked_players = table.wipe(frame.marked_players)
						frame.backup_players = table.wipe(frame.backup_players)
						frame.resetrings()
						frame.hide_prepare()
						frame.my_index = 0						
						frame.helpbtn:Disable()
						
						local used = {}
						local group_size = GetNumGroupMembers()																			
						for i = group_size, 1, -1 do  
							local unit_id = "raid" .. i

							if AuraUtil.FindAuraByName(frame.aura, unit_id, G.Test_Mod and "HELPFUL" or "HARMFUL") then
								local name = UnitName(unit_id)												
								for ind, v in pairs(frame.p3_states) do
									if frame.p3_states[ind] then -- 这一环要转 安排人
										frame.marked_players[ind] = {["assign"] = name}		
										T.SetRaidTarget(unit_id, ind) -- 上标记
										
										if UnitIsUnit(unit_id, 'player') then -- 是我自己
											frame.my_index = ind
											frame.lightring(ind)
											frame.helpbtn:Enable()
											T.SendChatMsg("{rt"..ind.."}"..ind..ind..ind.."{rt"..ind.."}", 10) -- 喊话11次
											if not SoD_CDB["General"]["disable_sound"] then
												PlaySoundFile(G.media.sounds.."FatescribeRohKalo\\assign"..ind..".ogg", "Master") -- 声音
											end
										end
										
										used[name] = true -- 这个人用过了
										frame.p3_states[ind] = false -- 这一环不需要人了
										break
									end 
								end
								
								if not used[name] then
									table.insert(frame.backup_players, name)
									if UnitIsUnit(unit_id, 'player') then -- 是我自己
										frame.show_prepare()
										if not SoD_CDB["General"]["disable_sound"] then
											PlaySoundFile(G.media.sounds.."FatescribeRohKalo\\backup.ogg", "Master") -- 声音 符文待命
										end
									end
								end
							end
						end
							
						frame.updatetext()
						frame:Show()
					end
					
					frame:Hide()
				end,
				update = function(frame, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then
						local timestamp, sub_event, _, _, _, _, _, _, _, _, _, spellID, spellName = CombatLogGetCurrentEventInfo()
						if sub_event == "SPELL_AURA_APPLIED" and spellID == frame.spellID and not frame.in_phase then -- 命运重构开始
							frame.in_phase = true
							frame.countdown()
							if not frame.InP3() then -- 转阶段							
								C_Timer.After(.5, function() -- 延迟
									--print("转阶段")
									frame.marked_players = table.wipe(frame.marked_players)
									frame.backup_players = table.wipe(frame.backup_players)
									frame.resetrings()
									frame.hide_prepare()
									frame.my_index = 0
									frame.helpbtn:Disable()
										
									local group_size = GetNumGroupMembers()					
									local passed = 0

									for i = group_size, 1, -1 do  
										local unit_id = "raid" .. i
										
										if AuraUtil.FindAuraByName(frame.aura, unit_id, G.Test_Mod and "HELPFUL" or "HARMFUL") then--HARMFUL
											passed = passed + 1
											local name = UnitName(unit_id)
											
											if passed <= 6 then -- 直接安排的6人
												frame.marked_players[passed] = {["assign"] = name}
												T.SetRaidTarget(unit_id, passed) -- 上标记
																		
												if UnitIsUnit(unit_id, 'player') then -- 是我自己
													frame.my_index = passed
													frame.lightring(passed)
													frame.helpbtn:Enable()
													T.SendChatMsg("{rt"..passed.."}"..passed..passed..passed.."{rt"..passed.."}", 10) -- 喊话11次
													if not SoD_CDB["General"]["disable_sound"] then
														PlaySoundFile(G.media.sounds.."FatescribeRohKalo\\assign"..passed..".ogg", "Master") -- 声音
													end
												end
											else -- 备用的人
												table.insert(frame.backup_players, name)
												if UnitIsUnit(unit_id, 'player') then -- 是我自己
													frame.show_prepare()
													if not SoD_CDB["General"]["disable_sound"] then
														PlaySoundFile(G.media.sounds.."FatescribeRohKalo\\backup.ogg", "Master") -- 声音 符文待命
													end
												end
											end
										end
									end
									
									frame.updatetext()
									frame:Show()	
								end)
							else -- P3
								frame.p3_states = table.wipe(frame.p3_states)
								local difficultyID = select(3, GetInstanceInfo())
								if difficultyID == 15 then -- H
									frame.p3_states[1] = true
									frame.p3_states[2] = true
									frame.p3_states[3] = false
									frame.p3_states[4] = false
									frame.p3_states[5] = false
									frame.p3_states[6] = false
								else -- M
									frame.p3_states[1] = true
									frame.p3_states[2] = true
									frame.p3_states[3] = true
									frame.p3_states[4] = true
									frame.p3_states[5] = false
									frame.p3_states[6] = false									
								end
								
								frame.wait_for_states = true -- 等人点
								
								C_Timer.After(10, function() -- 等待10秒	 
									if frame.wait_for_states then
										local str = "ringstates"
										for i = 1, 6 do
											if frame.p3_states[i] then
												str = str.."_yes"
											else
												str = str.."_no"
											end
										end
										C_ChatInfo.SendAddonMessage("sodpaopao", str, "RAID")
										frame.wait_for_states = false -- 1 0秒还没人点？不等了
										frame.UpdateP3Ring()
									end
								end)
							end
						elseif sub_event == "SPELL_AURA_REMOVED" and spellID == frame.spellID and frame.in_phase then -- 符文亲和消失，命运重构结束
							local group_size = GetNumGroupMembers()
							if not SoD_CDB["General"]["disable_sound"] then
								PlaySoundFile(G.media.sounds.."FatescribeRohKalo\\success.ogg", "Master") -- 声音 转圈成功
							end
							for i = 1, group_size do -- 去除标记
								local mark_id = GetRaidTargetIndex("raid" .. i)
								if mark_id and mark_id <= 6 then
									T.SetRaidTarget("raid" .. i, 0)	
								end
							end
							frame.reset(frame)
						end
					elseif event == "CHAT_MSG_ADDON" then
						local prefix, message, channel, sender = ... 
						if prefix == "sodpaopao" then
							local tag = string.split("_", message)
							if tag == "need" then -- 喊人帮忙的消息
								local name, mark_index = select(2, string.split("_", message))
								mark_index = tonumber(mark_index)
								if name == G.PlayerName then -- 被叫去帮忙的竟是我寄几
									frame.help_ind(mark_index)
								end
								frame.marked_players[mark_index]["backup"] = name
								for i, backup_name in pairs(frame.backup_players) do --从备用人员中移除
									if name == backup_name then
										table.remove(frame.backup_players, i)
										break
									end
								end
								frame.updatetext()
							elseif tag == "ringstates" then -- 提示转圈的消息
								if frame.wait_for_states then -- 还未收到
									frame.wait_for_states = false
									for ind, v in pairs(frame.p3_states) do
										local active = select(ind+1, string.split("_", message))
										if active == "yes" then
											frame.p3_states[ind] = true
										else
											frame.p3_states[ind] = false
										end
									end
									frame.UpdateP3Ring()
								end
							end 
						end
					elseif event == "ENCOUNTER_START" then
						frame.marked_players = table.wipe(frame.marked_players)
						frame.backup_players = table.wipe(frame.backup_players)
						frame.p3_states = table.wipe(frame.p3_states)
						frame.in_phase = false
						frame.my_index = 0
						frame.wait_for_states = false
						
						frame.resetrings()
						frame.helpbtn:Disable()
						frame.hide_prepare()
						frame.updatetext()
						
						frame:Hide()
					end
				end,
				reset = function(frame)		
					frame.marked_players = table.wipe(frame.marked_players)
					frame.backup_players = table.wipe(frame.backup_players)
					frame.p3_states = table.wipe(frame.p3_states)
					frame.in_phase = false
					frame.my_index = 0
					frame.wait_for_states = false
					
					frame.resetrings()
					frame.helpbtn:Disable()
					frame.hide_prepare()
					frame.updatetext()
					
					frame:Hide()
				end,
			},
			{ -- 随演命运选择按钮
				spellID = 353195,
				tip = L["TIP随演命运"],
				points = {a1 = "CENTER", a2 = "CENTER", x = 0, y = 0, width = 250, height = 30},						
				events = {
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,
					["CHAT_MSG_ADDON"] = true,
				},
				difficulty_id = {
					[15] = true,
					[16] = true,
				},
				init = function(frame)
					frame.btns = {}
					frame.spellID = 354964
					frame.createbtn = function(i)
						local btn = CreateFrame("Button", nil, frame)
						btn:SetSize(30, 30)
						btn:SetPoint("LEFT", frame, "LEFT", 35*(i-1), 0)
						T.createborder(btn)
						
						btn.text = T.createtext(btn, "ARTWORK", 18, "OUTLINE", "CENTER")
						btn.text:SetPoint("CENTER", btn, "CENTER", 0, 0)
						if i <= 6 then
							btn.text:SetText(i)
						else
							btn.text:SetText("OK")
							btn.sd:SetBackdropColor(1, 0, 1)
						end
						
						btn:RegisterForClicks("LeftButtonUp")
						
						btn:SetScript("OnMouseDown", function(self)
							self.sd:SetBackdropBorderColor(1, 1, 1)								
						end)
						
						btn:SetScript("OnMouseUp", function(self)
							self.sd:SetBackdropBorderColor(0, 0, 0)
						end)
						
						btn:SetScript("OnClick", function(self)
							if i <= 6 then
								if self.v == "yes" then
									self.v = "no"
								else -- "no"
									self.v = "yes"
								end
								frame.updatebtn(self)
							else
								frame.send_btn_states()	
							end
						end)	

						frame.btns[i] = btn
						
						btn:Hide()
					end
					
					frame.updatebtn = function(btn)
						if btn.v == "yes" then
							btn.sd:SetBackdropColor(0, 1, 0)
						else
							btn.sd:SetBackdropColor(.5, .5, .5)
						end
					end
					
					frame.reset_btn_states = function()
						local difficultyID = select(3, GetInstanceInfo())
						local default
						
						if difficultyID == 15 then -- H
							default = "no"
						else -- M
							default = "yes"
						end
						
						for i = 1, 6 do
							frame.btns[i]["v"] = default
							frame.updatebtn(frame.btns[i])
						end
					end
					
					frame.send_btn_states = function()
						local str = "ringstates"
						for i = 1, 6 do
							str = str.."_"..frame.btns[i]["v"] 
						end
						C_ChatInfo.SendAddonMessage("sodpaopao", str, "RAID")
					end	
					
					frame.show_btns = function()
						for i = 1, 7 do
							frame.btns[i]:Show()
						end
					end
					
					for i = 1, 7 do
						frame.createbtn(i)
					end
					
					frame.InP3 = function()
						local perc = 1
						local hp = UnitHealth("boss1")
						local hp_max = UnitHealthMax("boss1")
						if hp and hp_max then
							perc = hp/hp_max
						end
						if perc < .38 then -- P3
							return true
						end
					end
				end,
				update = function(frame, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then
						local timestamp, sub_event, _, _, _, _, _, _, _, _, _, spellID, spellName = CombatLogGetCurrentEventInfo()
						if sub_event == "SPELL_AURA_APPLIED" and spellID == frame.spellID and not frame.in_phase then -- 命运重构开始
							if frame.InP3() then -- 转阶段
								frame.in_phase = true
								frame.reset_btn_states()
								frame.show_btns()
							end
						elseif sub_event == "SPELL_AURA_REMOVED" and spellID == frame.spellID and frame.in_phase then -- 符文亲和消失，命运重构结束
							frame.in_phase = false
						end
					elseif event == "CHAT_MSG_ADDON" then
						local prefix, message, channel, sender = ...
						if prefix == "sodpaopao" then
							local tag = string.split("_", message)
							if tag == "ringstates" then -- 收到讯息 隐藏框体
								for k, b in pairs(frame.btns) do
									b:Hide()
								end
							end
						end
					end
				end,
				reset = function(frame)
					frame.reset_btn_states()
					for k, b in pairs(frame.btns) do
						b:Hide()
					end
				end,				
			},
			{ -- 绝望距离检查
				spellID = 357144,
				tip = L["TIP绝望距离检查"],
				points = {a1 = "BOTTOM", a2 = "CENTER", x = 0, y = 150, width = 250, height = 60},								
				events = {	
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,
				},
				difficulty_id = {
					[16] = true,
				},
				init = function(frame)
					frame.spellID = 357144 -- 绝望
					frame.spellName, _, frame.iconTexture = GetSpellInfo(frame.spellID)
					frame.bars = {}
					
					frame.CreateBar = function(unit)
						local bar = T.CreateTimerBar(frame, frame.iconTexture, true, true, true, 350, 28, 20, 1, .3, .8)
						bar:SetMinMaxValues(0, 2.6)
						bar.unit = unit
						bar.inRange = false
						frame.bars[unit] = bar
					end
					
					if G.Test_Mod then
						frame.CreateBar("raid2")
						frame.CreateBar("raid3")
					else
						frame.CreateBar("boss2")
						frame.CreateBar("boss3")
					end
					
					frame.lineup = function()
						local lastbar
						for unit, bar in pairs(frame.bars) do
							bar:ClearAllPoints()
							if bar:IsVisible() then
								if not lastbar then
									bar:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
									lastbar = bar
								else
									bar:SetPoint("TOPLEFT", lastbar, "BOTTOMLEFT", 0, -4)
									lastbar = bar
								end
							end
						end
					end
									
					frame.UpdateInRange = function(bar)
						if G.Test_Mod then
							if IsItemInRange(31463, bar.unit) then -- 25码友方								
								bar.inrange = true
							else			
								bar.inrange = false
							end
						else
							if IsItemInRange(24268, bar.unit) then -- 25码敌方								
								bar.inrange = true
							else			
								bar.inrange = false
							end
						end
					end
				end,
				update = function(frame, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then
						local timestamp, sub_event, _, sourceGUID, sourceName, _, _, _, destName, _, _, spellID, spellName = CombatLogGetCurrentEventInfo()
						if sub_event == "SPELL_CAST_START" and spellID == frame.spellID then -- 绝望 开始读条
							for unit, bar in pairs(frame.bars) do
								if UnitGUID(bar.unit) and sourceGUID and UnitGUID(bar.unit) == sourceGUID then
									frame.UpdateInRange(bar)
									
									local mark_ind = GetRaidTargetIndex(bar.unit)
									if mark_ind then
										bar.mid:SetText("|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_"..mark_ind..":0|t")
									else
										bar.mid:SetText("")
									end
									
									if bar.inrange then
										if not SoD_CDB["General"]["disable_sound"] then
											PlaySoundFile(G.media.sounds.."FatescribeRohKalo\\tooclose.ogg", "Master") -- 语音 距离过近
										end
									end
									
									bar.exp = GetTime() + 2.6				
									bar:SetScript("OnUpdate", function(self, e)
										self.t = self.t + e
										if self.t > self.update_rate then
											local remain = self.exp - GetTime()
											if remain > 0 then
												self.right:SetText(T.FormatTime(remain))
												self:SetValue(2.6 - remain)
												frame.UpdateInRange(self)
												if self.inrange then
													self.left:SetText(L["绝望距离过近"])
													self.glow:SetAlpha(self.anim:GetProgress())
												else
													self.left:SetText(L["绝望距离安全"])
													self.glow:SetAlpha(0)
												end
											else
												self.left:SetText("")
												self.mid:SetText("")
												self.right:SetText("")
												self:Hide()	
												self:SetScript("OnUpdate", nil)
												self.anim:Stop()
												self.glow:Hide()
												frame.lineup()
											end
											self.t = 0
										end
									end)

									bar:Show()
									bar.anim:Play()	
									bar.glow:Show()
									frame.lineup()
								end
							end
						end
					end
				end,
				reset = function(frame)
					for unit, bar in pairs(frame.bars) do
						bar.left:SetText("")
						bar.mid:SetText("")
						bar.right:SetText("")
						bar:Hide()
						bar:SetScript("OnUpdate", nil)
						bar.anim:Stop()
						bar.glow:Hide()
						frame.lineup()
					end
					frame:Hide()					
				end,
			},
			{ -- 宿命联结
				spellID = 350421,
				tip = L["TIP宿命联结"],
				points = {a1 = "BOTTOM", a2 = "CENTER", x = 0, y = 300, width = 400, height = 60},			
				events = {	
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,
				},
				difficulty_id = {
					["all"] = true,
				},
				init = function(frame)
					frame.spellID = 350421 -- 宿命联结
					frame.spellID2 = 351969 -- 命运重构
					frame.spellName, _, frame.iconTexture = GetSpellInfo(frame.spellID)
					frame.bars = {}
					
					frame.CreateBar = function(tag, r, g, b, glow, dur, ...)
						local bar = T.CreateTimerBar(frame, frame.iconTexture, glow, false, true, 350, 28, 20, r, g, b)
						bar.ind = 0
						bar.dur = dur
						bar:SetPoint(...)	
						bar:SetMinMaxValues(0, dur)
						frame.bars[tag] = bar
					end
					
					frame.CreateBar(1, 1, 1, 0, nil, 1.3, "TOPLEFT", frame, "TOPLEFT", 0, 0)
					frame.CreateBar(2, 1, .6, 0, true, 5, "TOPLEFT", frame, "TOPLEFT", 0, -32)					
				end,
				update = function(frame, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then
						local timestamp, sub_event, _, sourceGUID, sourceName, _, _, _, destName, _, _, spellID, spellName = CombatLogGetCurrentEventInfo()
						if sub_event == "SPELL_CAST_START" and spellID == frame.spellID then -- 宿命联结 开始读条
							local bar = frame.bars[1]
							bar.ind = bar.ind + 1
							bar.left:SetText(string.format(L["连线出现"], bar.ind))
							
							bar.exp = GetTime() + bar.dur			
							bar:SetScript("OnUpdate", function(self, e)
								self.t = self.t + e
								if self.t > self.update_rate then
									local remain = self.exp - GetTime()
									if remain > 0 then		
										self.right:SetText(T.FormatTime(remain))
										self:SetValue(bar.dur - remain)
									else
										self.right:SetText("")	
										self:Hide()
										self:SetValue(0)
										self:SetScript("OnUpdate", nil)
									end
									self.t = 0
								end
							end)
							bar:Show()
						elseif sub_event == "SPELL_CAST_SUCCESS" and spellID == frame.spellID then -- 宿命联结 读条结束
							local bar = frame.bars[2]
							bar.ind = bar.ind + 1
							bar.left:SetText(string.format(L["连线生效"], bar.ind))
							
							bar.exp = GetTime() + bar.dur			
							bar:SetScript("OnUpdate", function(self, e)
								self.t = self.t + e
								if self.t > self.update_rate then
									local remain = self.exp - GetTime()
									if remain > 0 then		
										self.right:SetText(T.FormatTime(remain))
										self:SetValue(bar.dur - remain)
										self.glow:SetAlpha(self.anim:GetProgress())
									else
										self.right:SetText("")
										self:Hide()
										self:SetValue(0)
										self:SetScript("OnUpdate", nil)
										self.anim:Stop()
										self.glow:Hide()
										
									end
									self.t = 0
								end
							end)
							bar:Show()
							bar.anim:Play()	
							bar.glow:Show()
						elseif sub_event == "SPELL_CAST_START" and spellID == frame.spellID2 then -- 命运重构 转阶段 重置计数为0
							for i, bar in pairs(frame.bars) do
								bar.ind = 0
							end
						end
					end
				end,
				reset = function(frame)
					for i, bar in pairs(frame.bars) do
						bar.ind = 0
						bar.right:SetText("")	
						bar:Hide()
						bar:SetValue(0)
						bar:SetScript("OnUpdate", nil)	
						
						if bar.glow then				
							bar.anim:Stop()
							bar.glow:Hide()
						end
					end
					frame:Hide()					
				end,
			},			
		},
	},
}

G.Encounters[9] = { -- 克尔苏加德 已过初检
	id = 2440,
	engage_id = 2422,
	npc_id = "175559", 
	img = 4071435,
	alerts = {
		AlertIcon = {
			{type = "cast", tip = "躲地板", hl = "hl", spellID = 354198}, -- 咆哮风暴 已检查
			{type = "aura", tip = "快走开", hl = "no", spellID = 354208, aura_type = "HARMFUL", unit = "player"}, -- 咆哮风暴 已检查
			{type = "cast", tip = "复活小怪", hl = "hl", spellID = 352530}, -- 黑暗唤醒 已检查			
			{type = "cast", tip = "灵魂碎裂", role = "tank", hl = "hl", spellID = 348071}, -- 灵魂碎裂 已检查
			{type = "aura", role = "tank", hl = "no", spellID = 348978, aura_type = "HARMFUL", unit = "player"}, -- 灵魂疲惫 已检查
			{type = "cast", tip = "准备尖刺", hl = "hl", spellID = 346459}, -- 冰川之怒 已检查
			{type = "aura", tip = "去放尖刺", hl = "hl", spellID = 353808, aura_type = "HARMFUL", unit = "player"}, -- 冰川之怒 已检查
			{type = "aura", tip = "尖刺爆炸", hl = "no", spellID = 346530, aura_type = "HARMFUL", unit = "player"}, -- 冰封毁灭 已检查
			{type = "cast", tip = "准备沉默圈", hl = "hl", spellID = 347291}, -- 湮灭回响 已检查
			{type = "aura", tip = "沉默圈点你", hl = "hl", spellID = 347292, aura_type = "HARMFUL", unit = "player"}, -- 湮灭回响 已检查
			{type = "log", tip = "找人分担", hl = "hl", spellID = 348760, event_type = "SPELL_AURA_APPLIED", dur = 3, targetID = "player"}, -- 冰霜冲击 已检查
			{type = "cast", tip = "分担伤害", hl = "hl", spellID = 348756}, -- 冰霜冲击 已检查 
			{type = "aura", tip = "AE光环", hl = "no", spellID = 354289, aura_type = "HARMFUL", unit = "player"}, -- 险恶瘴气 已检查
			{type = "aura", tip = "BOSS强化", hl = "no", spellID = 352051, dif = {[15] = true, [16] = true}, aura_type = "HELPFUL", unit = "boss1"}, -- 通灵涌动 已检查
			{type = "aura", tip = "不能进入", hl = "no", spellID = 352316, dif = {[16] = true}, aura_type = "HARMFUL", unit = "player"}, -- 灵魂印记 已检查
			{type = "aura", tip = "别踩", hl = "no", spellID = 354639, aura_type = "HARMFUL", unit = "player"}, -- 深度冻结 已检查
		},
		HLOnRaid = {
			{type = "HLAuras", spellID = 348978}, -- 灵魂疲惫 已检查
			{type = "HLAuras", spellID = 353808, Glow = true}, -- 冰川之怒 已检查
			{type = "HLAuras", spellID = 347292, Glow = true}, -- 湮灭回响 已检查
			{type = "HLAuras", spellID = 348760, Glow = true}, -- 冰霜冲击 已检查
			{type = "HLAuras", spellID = 357298}, -- 冻结之缚 已检查
		},
		PlateAlert = {
			{type = "PlayerAuraSource", spellID = 355389}, -- 无情追击 已检查
			{type = "PlateSpells", spellID = 348428, spellCD = 1, mobID = "176605", hl_np = true}, -- 穿透哀嚎 待检查
			{type = "PlateSpells", spellID = 352141, spellCD = 1, mobID = "176974", hl_np = true}, -- 女妖尖叫 待检查
			{type = "PlateAuras", spellID = 355948}, -- 通灵强化 已检查
			{type = "PlateAuras", spellID = 355935}, -- 女妖尖叫 已检查	
		},
		TextAlert = {
			{ -- 已检查
				type = "hp",
				data = {
					unit = "boss1",
					npc_id = "175559",
					ranges = {
						{ ul = 10, ll = 0.5, tip = string.format(L["阶段转换"], "0")},
					},
				},
			},
			{	
				type = "spell",
				role="dps",
				spellID = 359354,
				color = {0, 1, 1},
				events = {
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,	
				},
				update = function(self, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then
						local _, sub_event, _, sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellID, spellName = CombatLogGetCurrentEventInfo()
						if sub_event == "SPELL_SUMMON" and spellID == 352094 then -- 召唤大怪
							self.text:SetText(L["注意仇恨"])
							self:Show()
							C_Timer.After(5, function()
								self:Hide()
							end)
						end
					end
				end,
			},
			{	
				type = "spell",
				role="dps",
				spellID = 352355,
				dif = {[15] = true, [16] = true},
				color = {0, 1, 1},
				events = {
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,	
				},
				update = function(self, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then
						local _, sub_event, _, sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellID, spellName = CombatLogGetCurrentEventInfo()
						if sub_event == "SPELL_CAST_START" and spellID == 352293 then -- 进P2
							self.text:SetText(L["击杀大怪"])
							C_Timer.After(34, function()
								if UnitCastingInfo("boss1") then
									local spellid = select(9, UnitCastingInfo("boss1"))
									if spellid and spellid == 352293 then
										self:Show()
									end
								end
							end)
						elseif (sub_event == "SPELL_AURA_APPLIED" or sub_event == "SPELL_AURA_APPLIED_DOSE") and spellID == 352051 then -- 进P1
							self:Hide()
						end
					end
				end,
			},
		},
		ChatMsg = { 
			{type = "ChatMsgAuraCountdown", spellID = 347292, playername = false, spellname = true, icon = 7}, -- 湮灭回响 已检查
			{type = "ChatMsgAuraCountdown", spellID = 348760, playername = true, spellname = true, icon = 8}, -- 冰霜冲击 已检查	
			{type = "ChatMsgCom", role="tank", spellID = 348071, playername = true, spellname = true}, -- 灵魂碎裂 待检查
		},
		Sound = {		
			{spellID = 354198, event = "UNIT_SPELLCAST_START"}, -- 躲地板
			{spellID = 354208, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED" , unit = "player"}, -- 快走开
			{spellID = 352530, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED"}, -- 复活小怪		
			{spellID = 348071, event = "UNIT_SPELLCAST_START"}, -- 灵魂碎裂
			{spellID = 346459, event = "UNIT_SPELLCAST_START"}, -- 准备冰刺
			{spellID = 347291, event = "UNIT_SPELLCAST_START"}, -- 准备沉默圈
			{spellID = 347292, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED" , unit = "player"}, -- 沉默圈点你
			{spellID = 355389, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED" , unit = "player"}, -- 小怪盯你	
			{spellID = 348756, event = "UNIT_SPELLCAST_START"}, -- 分担伤害
			{spellID = 348760, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED" , unit = "player"}, -- 找人分担
			{spellID = 355137, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED" , unit = "player"}, -- 快走开	
			{spellID = 352348, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_SUMMON"}, -- 召唤大怪
			{spellID = 354639, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED" , unit = "player"}, -- 快走开
		},
		HP_Watch = {
			{sub_event = "SPELL_AURA_APPLIED", on_me = true, spellID = 348760, delay = 3}, -- 冰霜冲击
		},
		Phase_Change = {
			{sub_event = "SPELL_AURA_APPLIED", spellID = 352051}, -- 通灵涌动
			{sub_event = "SPELL_CAST_START", spellID = 352293}, -- 复仇毁灭		
		},
		BossMods = {
			{ -- 灵魂疲惫
				spellID = 348978,
				role = "tank",
				tip = string.format(L["多人光环提示"], T.GetIconLink(348978)),
				points = {a1 = "TOPLEFT", a2 = "CENTER", x = -700, y = 0, width = 250, height = 100},				
				events = {
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,	
				},
				difficulty_id = {
					["all"] = true,
				},
				init = function(frame)
					frame.aura_spell_ids = {348978}
					frame.aura_spells = {}
					for i, v in pairs(frame.aura_spell_ids) do
						frame.aura_spells[v] = {aura = GetSpellInfo(v), icon = select(3, GetSpellInfo(v))}
					end
					
					frame.bars = {}
						
					frame.create_bar = function(tag, spellID, player)
						local bar = T.CreateTimerBar(frame, frame.aura_spells[spellID]["icon"], true, false, true)
						bar.spellID = spellID
						bar.name = player
						frame.bars[tag] = bar			
					end
				
					frame.updatebar = function(bar, count, dur, exp_time)
						bar.left:SetText(T.ColorName(bar.name, true))
						
						bar.exp = exp_time
						bar.anim_played = false
						bar:SetMinMaxValues(0 , dur)
						
						bar:SetScript("OnUpdate", function(self, e)
							self.t = self.t + e
							if self.t > self.update_rate then		
								local remain = exp_time - GetTime()
								if remain > 0 then								
									self.right:SetText((count > 0 and "|cffFFFF00["..count.."]|r " or "")..T.FormatTime(remain))
									self:SetValue(dur - remain)
									if remain < 3 then -- 即将消失
										if not self.anim_played then
											self.anim_played = true
											self.glow:Show()
											self.anim:Play()
										end
										self.glow:SetAlpha(self.anim:GetProgress())
									end
								else
									self:Hide()
									self:SetScript("OnUpdate", nil)
									self.anim:Stop()
									self.glow:Hide()
								end
								self.t = 0
							end
						end)											
						bar:Show()
					end
					
					frame.lineup = function()
						local t = {}
						for GUID, bar in pairs(frame.bars) do
							if bar and bar:IsVisible() then
								table.insert(t, bar)
							end
						end
						if #t > 1 then
							table.sort(t, function(a, b) 
								if a.spellID < b.spellID then
									return true
								elseif a.spellID == b.spellID and a.exp < b.exp then
									return true
								end
							end)
						end
						local lastbar
						for i, bar in pairs(t) do
							bar:ClearAllPoints()
							if bar:IsVisible() then
								if not lastbar then
									bar:SetPoint("TOPLEFT", frame, "TOPLEFT", 30, -5)
									lastbar = bar
								else
									bar:SetPoint("TOPLEFT", lastbar, "BOTTOMLEFT", 0, -5)
									lastbar = bar
								end
							end
						end
					end			
				end,
				update = function(frame, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then						
						local _, sub_event, _, _, _, _, _, destGUID, destName, _, _, spellID = CombatLogGetCurrentEventInfo()
						if (sub_event == "SPELL_AURA_APPLIED" or sub_event == "SPELL_AURA_APPLIED_DOSE" or sub_event == "SPELL_AURA_REMOVED_DOSE") and frame.aura_spells[spellID] then						
							local dest = string.split("-", destName)				
							if destGUID and AuraUtil.FindAuraByName(frame.aura_spells[spellID]["aura"], dest, G.Test_Mod and "HELPFUL" or "HARMFUL") then
								local count, _, dur, exp_time = select(3, AuraUtil.FindAuraByName(frame.aura_spells[spellID]["aura"], dest, G.Test_Mod and "HELPFUL" or "HARMFUL"))
								if not frame.bars[spellID.."_"..destGUID] then
									frame.create_bar(spellID.."_"..destGUID, spellID, dest)
								end
								
								local bar = frame.bars[spellID.."_"..destGUID]
								frame.updatebar(bar, count, dur, exp_time)
								
								frame.lineup()
							end
						elseif sub_event == "SPELL_AURA_REMOVED" and frame.aura_spells[spellID] then
							if destGUID and frame.bars[spellID.."_"..destGUID] then
								local bar = frame.bars[spellID.."_"..destGUID]
								bar:Hide()
								bar:SetScript("OnUpdate", nil)
								bar.anim:Stop()
								bar.glow:Hide()
								frame.lineup()
							end
						end
					end	
				end,
				reset = function(frame)
					for tag, bar in pairs(frame.bars) do
						bar:ClearAllPoints()
						bar:Hide()
						bar:SetScript("OnUpdate", nil)
						bar.anim:Stop()
						bar.glow:Hide()
					end				
					frame.bars = table.wipe(frame.bars)
					frame:Hide()
				end,
			},
			{ -- 小怪复活计时条 已检查
				spellID = 358679,
				tip = L["TIP不死"],
				points = {width = 250, height = 200},			
				events = {
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,	
				},
				difficulty_id = {
					["all"] = true,
				},
				init = function(frame)
					frame.npcs = {
						["176973"] = 2492256, -- 憎恶
						["176974"] = 3675492, -- 女妖
						
						--["91783"] = 2492256, -- test
						--["91781"] = 3675492, -- test
					}
					
					frame.boss = "boss2"
					frame.bars = {}
					
					frame.create_bar = function(tag, max, text, icon, r, g, b)
						local bar = T.CreateTimerBar(frame, icon)
						bar:SetStatusBarColor(r, g, b)
						bar.left:SetText(text)
						bar:SetMinMaxValues(0, max)
						
						if tag == "P2Timer" then
							bar.mark1 = bar:CreateTexture(nil, "OVERLAY")
							bar.mark1:SetSize(2, 20)
							bar.mark1:SetTexture(G.media.blank)
							bar.mark1:SetVertexColor(0, 0, 0)
							bar.mark1:SetPoint("LEFT", bar, "LEFT", 166, 0)
							
						elseif tag == "Boss2hp" then
							bar.mark1 = bar:CreateTexture(nil, "OVERLAY")
							bar.mark1:SetSize(2, 20)
							bar.mark1:SetTexture(G.media.blank)
							bar.mark1:SetVertexColor(0, 0, 0)
							bar.mark1:SetPoint("LEFT", bar, "LEFT", 150, 0)
							
							bar.mark2 = bar:CreateTexture(nil, "OVERLAY")
							bar.mark2:SetSize(2, 20)
							bar.mark2:SetTexture(G.media.blank)
							bar.mark2:SetVertexColor(0, 0, 0)
							bar.mark2:SetPoint("LEFT", bar, "LEFT", 50, 0)
						end
						
						frame.bars[tag] = bar
														
						frame.lineup()
					end
					
					frame.lineup = function()
						local lastbar
						for tag, bar in pairs(frame.bars) do
							bar:ClearAllPoints()
							if bar:IsVisible() then
								if tag == "Boss2hp" then
									bar:SetPoint("TOPLEFT", frame, "TOPLEFT", 5, -5)
								elseif tag == "P2Timer" then
									bar:SetPoint("TOPLEFT", frame.bars["Boss2hp"], "BOTTOMLEFT", 0, -5)
								else
									if not lastbar then
										bar:SetPoint("TOPLEFT", frame.bars["P2Timer"], "BOTTOMLEFT", 0, -5)
										lastbar = bar
									else
										bar:SetPoint("TOPLEFT", lastbar, "BOTTOMLEFT", 0, -5)
										lastbar = bar
									end
								end
							end
						end
					end
					
					frame.p2 = false
					frame:Hide()
					
				end,
				update = function(frame, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then
						local _, sub_event, _, _, _, _, _, destGUID, destName, _, _, spellID = CombatLogGetCurrentEventInfo()
						if sub_event == "SPELL_CAST_START" and spellID == 352293 then -- 进P2
							if not frame.bars["P2Timer"] then
								frame.create_bar("P2Timer", 45, "P2", 537516, 1, .5, 1)
								local bar_timer = frame.bars["P2Timer"]
								bar_timer.exp = GetTime() + 45 -- P2结束时间
								bar_timer.played = false
								bar_timer:SetScript("OnUpdate", function(self, e)
									self.t = self.t + e
									if self.t > self.update_rate then
										local remain = self.exp - GetTime()
										if remain > 0 then
											self.right:SetText(T.FormatTime(remain))
											self:SetValue(45-remain)
											self.t = 0
											if not SoD_CDB["General"]["disable_sound"] then
												if remain <= 11 then
													if not self.played then
														PlaySoundFile(G.media.sounds.."killadd.ogg", "Master") -- 声音
														self.played = true
													end
												end
											end
										end
									end
								end)
							end
							
							
							if not frame.bars["Boss2hp"] then
								frame.create_bar("Boss2hp", 1, "", 134514, .5, .5, .5)
								local bar_hp = frame.bars["Boss2hp"]
								bar_hp:RegisterEvent("UNIT_HEALTH")
								bar_hp:SetScript("OnEvent", function(self, event, unit)
									if unit == frame.boss then
										local hp, hp_max = UnitHealth(frame.boss), UnitHealthMax(frame.boss)
										if hp and hp > 0 then
											self:SetValue(hp/hp_max)
											self.right:SetText(string.format("%.1f%%", hp/hp_max*100))
										end
									end
								end)
							end
							
							
							frame.p2 = true
							frame.bars["P2Timer"]["exp"] = GetTime() + 45 -- P2结束时间
							frame.bars["P2Timer"]["played"] = false
							frame:Show()
							frame.lineup()
							
						elseif (sub_event == "SPELL_AURA_APPLIED" or sub_event == "SPELL_AURA_APPLIED_DOSE") and spellID == 352051 then -- 进P1
							frame.p2 = false
							frame:Hide()
						elseif sub_event == "UNIT_DIED" and frame.p2 then
							local npcID = select(6, strsplit("-", destGUID))
							if frame.npcs[npcID] then -- 死了个小怪
								if not frame.bars[destGUID] then
									frame.create_bar(destGUID, 10, destName, frame.npcs[npcID], .7, .7, 1)			
								end
								
								local bar = frame.bars[destGUID]
								bar.exp = GetTime() + 10 -- 复活时间
								bar:SetScript("OnUpdate", function(self, e)
									self.t = self.t + e
									if self.t > self.update_rate then
										local remain = self.exp - GetTime()
										if remain > 0 then
											self.right:SetText(T.FormatTime(remain))
											self:SetValue(10-remain)
											self.t = 0
										else
											self:Hide()
											self:SetScript("OnUpdate", nil)
											frame.bars[destGUID] = nil
										end
									end
								end)
								frame.lineup()
							end
						end
					end
				end,
				reset = function(frame)
					for tag, bar in pairs(frame.bars) do
						bar:ClearAllPoints()
						bar:Hide()
						if bar:GetScript("OnUpdate") then
							bar:SetScript("OnUpdate", nil)
						end
						if bar:GetScript("OnEvent") then
							bar:SetScript("OnEvent", nil)
						end
						frame.bars[tag] = nil
					end
					frame.p2 = false					
					frame:Hide()
				end,
			},
			{ -- 劫魂者标记
				spellID = 352094,
				tip = L["TIP劫魂者标记"],
				points = {hide = true},
				events = {
					["NAME_PLATE_UNIT_ADDED"] = true,
					["UNIT_TARGET"] = true,
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,
				},
				difficulty_id = {
					["all"] = true,
				},
				init = function(frame)
					frame.npcID = "176974"
					frame.used_mark = 5
					frame.getmark = function()
						if frame.used_mark == 8 then
							frame.used_mark = 6
						else
							frame.used_mark = frame.used_mark + 1
						end					
						return frame.used_mark
					end
					frame.marked = {}		
				end,
				update = function(frame, event, ...)
					if event == "NAME_PLATE_UNIT_ADDED" then
						local unit = ...
						local GUID = UnitGUID(unit)
						local npcID = select(6, strsplit("-", GUID))
						if npcID and npcID == frame.npcID then
							if not frame.marked[GUID] then
								local mark = frame.getmark()
								T.SetRaidTarget(unit, mark) -- 上标记
								--print(GUID, mark)
								frame.marked[GUID] = mark
							end
						end
					elseif event == "UNIT_TARGET" then
						local unit = ...
						if strfind(unit, "raid") then -- 只看团队						
							local targetUnit = unit.."target"
							local GUID = UnitGUID(targetUnit)
							if GUID and not UnitIsDeadOrGhost(targetUnit) then
								local npcID = select(6, strsplit("-", GUID))
								if npcID and npcID == frame.npcID then -- 确认过眼神
									if not frame.marked[GUID] then
										local mark = frame.getmark()
										T.SetRaidTarget(targetUnit, mark) -- 上标记
										--print(GUID, mark)
										frame.marked[GUID] = mark
									end
								end
							end
						end
					elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
						local _, Event_type, _, sourceGUID, _, _, _, DestGUID, _, _, destRaidFlags, spellID = CombatLogGetCurrentEventInfo()
						if Event_type == "SPELL_CAST_START" and spellID == 352094 then
							frame.used_mark = 5 -- 施法后重置标记序号
						end
					end
				end,
				reset = function(frame)	
					frame.used_mark = 5
				end,
			},
			{ -- 灵魂碎裂小怪标记 已检查
				spellID = 348071,
				tip = L["TIP灵魂碎裂"],
				points = {hide = true},
				events = {
					["NAME_PLATE_UNIT_ADDED"] = true,
					["UNIT_TARGET"] = true,
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,
				},
				difficulty_id = {
					["all"] = true,
				},
				init = function(frame)
					frame.npcID = "176605" --97264
					frame.used_mark = 0
					frame.getmark = function()
						local difficultyID = select(3, GetInstanceInfo())
						if difficultyID	== 16 then -- M 5个碎片
							if frame.used_mark == 5 then
								frame.used_mark = 1
							else
								frame.used_mark = frame.used_mark + 1
							end
						else
							if frame.used_mark == 3 then
								frame.used_mark = 1
							else
								frame.used_mark = frame.used_mark + 1
							end
						end
						return frame.used_mark
					end
					frame.marked = {}		
				end,
				update = function(frame, event, ...)
					if event == "NAME_PLATE_UNIT_ADDED" then
						local unit = ...
						local GUID = UnitGUID(unit)
						local npcID = select(6, strsplit("-", GUID))
						if npcID and npcID == frame.npcID then
							if not frame.marked[GUID] then
								local mark = frame.getmark()
								T.SetRaidTarget(unit, mark) -- 上标记
								--print(GUID, mark)
								frame.marked[GUID] = mark
							end
						end
					elseif event == "UNIT_TARGET" then
						local unit = ...
						if strfind(unit, "raid") then -- 只看团队						
							local targetUnit = unit.."target"
							local GUID = UnitGUID(targetUnit)
							if GUID and not UnitIsDeadOrGhost(targetUnit) then
								local npcID = select(6, strsplit("-", GUID))
								if npcID and npcID == frame.npcID then -- 确认过眼神
									if not frame.marked[GUID] then
										local mark = frame.getmark()
										T.SetRaidTarget(targetUnit, mark) -- 上标记
										--print(GUID, mark)
										frame.marked[GUID] = mark
									end
								end
							end
						end
					elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
						local _, Event_type, _, sourceGUID, _, _, _, DestGUID, _, _, destRaidFlags, spellID = CombatLogGetCurrentEventInfo()
						if Event_type == "SPELL_CAST_START" and spellID == 348071 then --  2061
							frame.used_mark = 0 -- 施法后重置标记序号
						end
					end
				end,
				reset = function(frame)	
					frame.used_mark = 0
				end,
			},
			{ -- 冰川尖刺血量监视 已检查
				spellID = 338560,
				tip = L["TIP冰川尖刺"],
				points = {a1 = "TOPLEFT", a2 = "CENTER", x = -700, y = 200, width = 250, height = 200},				
				events = {
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,	
					["CHAT_MSG_ADDON"] = true,
				},
				difficulty_id = {
					["all"] = true,
				},
				init = function(frame)
					frame.npcID = "175861" --"97264"
					frame.t = 0
					
					frame.marks = {
					    [128] = 8, -- skull
						[64] = 7, -- cross
						[32] = 6, -- square
						[16] = 5, -- moon
						[8] = 4, -- triangle
						[4] = 3, -- diamond
						[2] = 2, -- circle
						[1] = 1, -- star
					}
								
					frame.text_center = T.createtext(frame, "OVERLAY", 40, "OUTLINE", "LEFT")
					frame.text_center:SetPoint("BOTTOM", UIParent, "CENTER", 0, 200)
					
					frame.subEvents = {
						["SWING_DAMAGE"] = function(bar, arg12, arg13, arg14, arg15)
							bar.min = bar.min - arg12
							if bar.min < 0 then
								bar.min = 0
							end
						end,
						["SWING_HEAL"] = function(bar, arg12, arg13, arg14, arg15)
							local amount = arg12
							bar.min = bar.min + amount
							if bar.min > bar.max then
								bar.min = bar.max
							end
						end,
						["RANGE_DAMAGE"] = function(bar, arg12, arg13, arg14, arg15)
							local amount = arg15
							bar.min = bar.min - amount
							if bar.min < 0 then
								bar.min = 0
							end
						end,
						["RANGE_HEAL"] = function(bar, arg12, arg13, arg14, arg15)
							local amount = arg15
							bar.min = bar.min + amount
							if bar.min > bar.max then
								bar.min = bar.max
							end
						end,
						["ENVIRONMENTAL_DAMAGE"] = function(bar, arg12, arg13, arg14, arg15)
							local amount = arg13
							bar.min = bar.min - amount
							if bar.min < 0 then
								bar.min = 0
							end
						end,
						["ENVIRONMENTAL_HEAL"] = function(bar, arg12, arg13, arg14, arg15)
							local amount = arg13
							bar.min = bar.min + amount
							if bar.min > bar.max then
								bar.min = bar.max
							end
						end,
						["SPELL_DAMAGE"] = function(bar, arg12, arg13, arg14, arg15) 
							local amount = arg15
							bar.min = bar.min - amount
							if bar.min < 0 then
								bar.min = 0
							end
						end,
						["SPELL_HEAL"] = function(bar, arg12, arg13, arg14, arg15) 
							local amount = arg15
							bar.min = bar.min + amount
							if bar.min > bar.max then
								bar.min = bar.max
							end
						end,
						["SPELL_PERIODIC_DAMAGE"] = function(bar, arg12, arg13, arg14, arg15) 
							local amount = arg15
							bar.min = bar.min - amount
							if bar.min < 0 then
								bar.min = 0
							end
						end,
						["SPELL_PERIODIC_HEAL"] = function(bar, arg12, arg13, arg14, arg15) 
							local amount = arg15
							bar.min = bar.min + amount
							if bar.min > bar.max then
								bar.min = bar.max
							end
						end,
					}
					frame.bars = {}
					frame.create_bar = function(GUID)
						if GUID then
							local bar = T.CreateTimerBar(frame, 458718, false, true)
							bar:SetStatusBarColor(.7, .7, 1)
							bar.min = 500000
							bar.max = 500000
							bar.update_rate = 2
							bar.GUID = GUID
							
							bar:SetMinMaxValues(0, bar.max)
							bar:SetValue(bar.max)
							
							bar.update_mark = function(bar, RaidFlags)
								local check = bit.band(RaidFlags, COMBATLOG_OBJECT_RAIDTARGET_MASK)
								if check and frame.marks[check] then
									bar.left:SetText(G.RTIconsList[frame.marks[check]])
								else
									bar.left:SetText("")
								end
							end 
							
							bar.update_value = function(bar)
								bar:SetValue(bar.min)
								bar.mid:SetText(string.format("%d%%",bar.min/bar.max*100))
								bar.right:SetText(T.ShortValue(bar.min))
								if bar.min == 0 then
									bar:SetScript("OnUpdate", nil)
								end
								if bar.min < 125000 and not bar.hp_warning then -- 25%
									C_ChatInfo.SendAddonMessage("sodpaopao", "spikelowhp", "WHISPER", G.PlayerName)
									bar.hp_warning = true
								end
							end						
							
							bar:SetScript("OnUpdate", function(self, e)
								self.t = self.t + e
								if self.t > self.update_rate then
									self.min = self.min - self.max*0.05
									if self.min < 0 then
										self.min = 0
									end
									self.update_value(self)
									self.t = 0
								end
							end)
							
							frame.bars[GUID] = bar	
							frame.lineup()
							
							return bar
						end
					end
					
					frame.lineup = function()
						local lastbar
						for GUID, bar in pairs(frame.bars) do
							bar:ClearAllPoints()
							if bar:IsVisible() then
								if not lastbar then
									bar:SetPoint("TOPLEFT", frame, "TOPLEFT", 5, -5)
									lastbar = bar
								else
									bar:SetPoint("TOPLEFT", lastbar, "BOTTOMLEFT", 0, -5)
									lastbar = bar
								end
							end
						end
					end
				end,
				update = function(frame, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then
						local _, Event_type, _, sourceGUID, _, _, _, DestGUID, _, _, destRaidFlags, arg12, arg13, arg14, arg15 = CombatLogGetCurrentEventInfo()
						if Event_type == "SPELL_SUMMON" and arg12 == 346469 then -- 召唤冰川之刺 192072
							frame.create_bar(DestGUID)
							local bar = frame.bars[DestGUID]
							bar.update_mark(bar, destRaidFlags)
						elseif frame.bars[sourceGUID] then
							local bar = frame.bars[sourceGUID]
							bar:Hide()
							bar:SetScript("OnUpdate", nil)
							frame.lineup()
						elseif frame.subEvents[Event_type] and frame.bars[DestGUID] then
							local bar = frame.bars[DestGUID]			
							frame.subEvents[Event_type](bar, arg12, arg13, arg14, arg15)
							bar.update_value(bar)
							bar.update_mark(bar, destRaidFlags)
						end	
					elseif event == "CHAT_MSG_ADDON" then
						local prefix, message, channel, sender = ... 
						if prefix == "sodpaopao" and message == "spikelowhp" then
							frame.exp = GetTime() + 3
							if not frame:GetScript("OnUpdate") then
								if not SoD_CDB["General"]["disable_sound"] and not frame.play then
									PlaySoundFile(G.media.sounds.."KelThuzad\\spikelowhp.ogg", "Master") -- 声音 冰刺低血量
									frame.play = true
									C_Timer.After(20, function()
										frame.play = false
									end)
								end
								frame:SetScript("OnUpdate", function(self,e)
									self.t = self.t + e
									if self.t > 0.05 then
										local remain = self.exp - GetTime()
										if remain > 0 then
											self.text_center:SetText(L["冰刺低血量"])
										else
											self:SetScript("OnUpdate", nil)
											self.text_center:SetText("")
										end		
										self.t = 0
									end
								end)
							end
						end
					end
				end,
				reset = function(frame)
					for i, bar in pairs(frame.bars) do
						bar:SetScript("OnUpdate", nil)
						bar:ClearAllPoints()
						bar:Hide()
					end
					frame.bars = table.wipe(frame.bars)		
					frame:Hide()
				end,
			},
			{ -- 内场读条 腐溃之风 冻结冲击 冰川之风 亡灵之怒
				spellID = 352379,
				tip = L["TIP冻结冲击计时条"],
				points = {a1 = "BOTTOM", a2 = "CENTER", x = 0, y = 150, width = 350, height = 120},								
				events = {	
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,
				},
				difficulty_id = {
					["all"] = true,
				},
				init = function(frame)
					frame.spellIDs = {
						[355127] = { -- 腐溃之风
							color = {r = .6, g = .3, b = .8},
							points = {"TOPLEFT", frame, "TOPLEFT", 0, 0}, 
							text = L["腐溃之风"],
							count = false,
						},
						[352379] = { -- 冻结冲击
							color = {r = .6, g = .93, b = .93},
							points = {"TOPLEFT", frame, "TOPLEFT", 0, 0}, 
							text = L["冻结冲击"],
							count = false,
						},
						[355055] = { -- 冰川之风
							color = {r = .7, g = .7, b = .7},
							points = {"TOPLEFT", frame, "TOPLEFT", 0, 0}, 
							text = L["冰川之风"],
							count = false,
						},
						[352355] = { -- 亡灵之怒
							color = {r = .2, g = .8, b = .2},
							points = {"TOPLEFT", frame, "TOPLEFT", 0, 0}, 
							text = L["亡灵之怒"],
							count = false,
						},
					}
					frame.bars = {}
					
					frame.CreateBar = function(spellID, r, g, b, ...)
						local spell_name, _, icon, cast_time = GetSpellInfo(spellID)
						
						local bar = T.CreateTimerBar(frame, icon, false, false, true, 350, 28, 20, r, g, b)
						bar.ind = 0
						bar.dur = cast_time/1000
						bar:SetPoint(...)
						bar:SetMinMaxValues(0, bar.dur)
						
						frame.bars[spellID] = bar
					end
					
					for k, v in pairs(frame.spellIDs) do
						frame.CreateBar(k, v.color.r, v.color.g, v.color.b, unpack(v.points))
					end
					
					frame.hasdebuff = function()
						local debuff = GetSpellInfo(354289)
						if AuraUtil.FindAuraByName(debuff, "player", "HARMFUL") then
							return true
						end
					end
				end,
				update = function(frame, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then
						local timestamp, sub_event, _, sourceGUID, sourceName, _, _, _, destName, _, _, spellID, spellName = CombatLogGetCurrentEventInfo()
						if sub_event == "SPELL_CAST_START" and frame.spellIDs[spellID] then -- 开始
						
							if not SoD_CDB["General"]["disable_sound"] and frame.hasdebuff() then
								PlaySoundFile(G.media.sounds.."KelThuzad\\"..spellID.."cast.ogg", "Master") -- 技能语音
							end
							
							local bar = frame.bars[spellID]
							bar.ind = bar.ind + 1
							if frame.spellIDs[spellID]["count"] then
								bar.left:SetText(string.format(frame.spellIDs[spellID]["text"], bar.ind))	
							else
								bar.left:SetText(frame.spellIDs[spellID]["text"])
							end
							
							bar.exp = GetTime() + bar.dur			
							bar:SetScript("OnUpdate", function(self, e)
								self.t = self.t + e
								if self.t > self.update_rate then
									local remain = self.exp - GetTime()
									if remain > 0 then		
										self.right:SetText(T.FormatTime(remain))
										self:SetValue(bar.dur - remain)
									else
										self.right:SetText("")	
										self:Hide()
										self:SetValue(0)
										self:SetScript("OnUpdate", nil)
									end
									self.t = 0
								end
							end)
							
							if frame.hasdebuff() then
								bar:Show()
							end
						elseif sub_event == "SPELL_CAST_FAILED" and frame.spellIDs[spellID] then -- 中断
							local bar = frame.bars[spellID]
							bar.right:SetText("")	
							bar:Hide()
							bar:SetValue(0)
							bar:SetScript("OnUpdate", nil)
						end
					elseif event == "ENCOUNTER_START" then
						for k, bar in pairs(frame.bars) do
							bar.ind = 0
						end
					end
				end,
				reset = function(frame)
					for k, bar in pairs(frame.bars) do
						bar.right:SetText("")
						bar.ind = 0
						bar:Hide()
						bar:SetValue(0)
						bar:SetScript("OnUpdate", nil)	
					end
					frame:Hide()					
				end,
			},
		},
	},
}

G.Encounters[10] = { -- 希尔瓦娜斯·风行者
	id = 2441,
	engage_id = 2435,
	npc_id = "175732",
	img = 4071443,
	alerts = {
		AlertIcon = {
			-- P1
			{type = "aura", tip = "躲地板", hl = "no", spellID = 347504, aura_type = "HELPFUL", unit = "boss1"}, -- 风行者 已检查
			{type = "aura", role = "tank", hl = "no", spellID = 347548, aura_type = "HELPFUL", unit = "boss1"}, -- 游侠射击 待检查
			{type = "aura", tip = "倒刺", hl = "no", spellID = 347807, aura_type = "HARMFUL", unit = "player"}, -- 倒刺之箭 已检查
			{type = "aura", tip = "自保", hl = "hl", spellID = 347670, aura_type = "HARMFUL", unit = "player"}, -- 暗影匕首 已检查			
			{type = "cast", tip = "准备锁链", hl = "hl", spellID = 349419}, -- 统御锁链 已检查
			{type = "aura", tip = "连接锁链", hl = "hl", spellID = 349458, aura_type = "HARMFUL", unit = "player"}, -- 统御锁链 已检查
			{type = "aura", tip = "大意了啊", hl = "hl", spellID = 356624, dif = {[15] = true, [16] = true}, aura_type = "HARMFUL", unit = "player"}, -- 灾祸 待检查
			{type = "aura", tip = "禁连锁链", hl = "no", spellID = 356651, dif = {[16] = true}, aura_type = "HARMFUL", unit = "player"}, -- 悲哀 已检查
			{type = "aura", tip = "吸收治疗", hl = "no", spellID = 347704, aura_type = "HARMFUL", unit = "player"}, -- 黑暗帷幕 待检查
			{type = "aura", tip = "哀恸点你", hl = "hl", spellID = 348064, dif = {[14] = true, [15] = true}, aura_type = "HARMFUL", unit = "player"}, -- 哀恸箭 已检查
			{type = "aura", tip = "黑蚀点你", hl = "hl", spellID = 358705, dif = {[16] = true}, aura_type = "HARMFUL", unit = "player"}, -- 黑蚀箭 待检查
			{type = "aura", tip = "小怪盯你", hl = "no", spellID = 358711, dif = {[16] = true}, aura_type = "HARMFUL", unit = "player"}, -- 怒气 已检查
			{type = "aura", role = "tank", hl = "no", spellID = 352650, aura_type = "HELPFUL", unit = "boss1"}, -- 游侠的觅心箭 已检查
			{type = "com", role = "tank", hl = "hl", spellID = 352663}, -- 游侠的觅心箭 待检查
			{type = "aura", role = "tank", hl = "no", spellID = 347607, aura_type = "HARMFUL", unit = "player"}, -- 女妖的印记 已检查
					
			-- P2
			{type = "aura", tip = "减速+吸收治疗", hl = "no", spellID = 351092, aura_type = "HARMFUL", unit = "player"}, -- 动荡能量 待检查
			{type = "aura", role = "tank", hl = "no", spellID = 351180, aura_type = "HARMFUL", unit = "player"}, -- 闪袭创伤 待检查
			{type = "aura", tip = "躲开队友", hl = "hl", spellID = 351117, aura_type = "HARMFUL", unit = "player"}, -- 恐惧压迫 已检查
			{type = "aura", tip = "伤害降低", hl = "no", spellID = 355826, aura_type = "HARMFUL", unit = "player"}, -- 蔑视光环 已检查
			{type = "aura", tip = "减速", hl = "no", spellID = 351451, aura_type = "HARMFUL", unit = "player"}, -- 嗜睡诅咒 待检查
			{type = "aura", tip = "分担伤害", hl = "hl", spellID = 351562, aura_type = "HARMFUL", unit = "player"}, -- 驱逐 待检查
			
			-- P3			
			{type = "aura", tip = "灾厄", hl = "no", spellID = 353929, aura_type = "HARMFUL", unit = "player"}, -- 女妖的灾厄 待检查
			{type = "cast", tip = "躲开紫圈", hl = "hl", spellID = 354011}, -- 灾厄箭 已检查
			{type = "aura", role = "tank", hl = "no", spellID = 358185, aura_type = "HELPFUL", unit = "boss1"}, -- 女妖的武器 待检查
			{type = "aura", role = "tank", hl = "no", spellID = 353965, aura_type = "HELPFUL", unit = "boss1"}, -- 女妖的觅心箭 待检查
			{type = "com", role = "tank", hl = "hl", spellID = 353969}, -- 女妖的觅心箭 待检查
			{type = "com", role = "tank", hl = "hl", spellID = 358181}, -- 女妖之刃 待检查
			{type = "cast", tip = "注意接圈", hl = "hl", spellID = 358588}, -- 无情 待检查	
		},
		HLOnRaid = {			
			{type = "HLAuras", spellID = 347807, stack = 2}, -- 倒刺之箭 已检查
			{type = "HLAuras", spellID = 349458, stack = 3}, -- 统御锁链 待检查
			{type = "HLAuras", role = "healer", spellID = 347670}, -- 暗影匕首 已检查
			{type = "HLAuras", spellID = 347704}, -- 黑暗帷幕 已检查			
			{type = "HLAuras", spellID = 351180}, -- 闪袭创伤 待检查
			{type = "HLAuras", role = "healer", spellID = 351117, stack = 4}, -- 恐惧压迫 已检查
			{type = "HLAuras", spellID = 347607}, -- 女妖的印记 待检查
			{type = "HLAuras", spellID = 353929}, -- 女妖的灾厄 已检查
			{type = "HLAuras", spellID = 348064, Glow = true}, -- 哀恸箭 待检查
			{type = "HLAuras", spellID = 358705, Glow = true}, -- 黑蚀箭 待检查
			{type = "HLAuras", spellID = 358434, Glow = true}, -- 死亡飞刀 待检查
		},
		PlateAlert = {
			{type = "PlayerAuraSource", spellID = 358711}, -- 怒气 待检查
			{type = "PlateSpells", spellID = 351075, spellCD = 1, mobID = "177154"}, -- 无坚不摧之力 渊誓前锋
			{type = "PlateNpcID", mobID = "177787", color = {1, .6, 0, 1}}, -- 渊誓灭愿者
			{type = "PlateNpcID", mobID = "177889", color = {.6, .7, .8, 1}}, -- 渊铸判魂者
			{type = "PlateNpcID", mobID = "177891", color = {.5, .2, 1, 1}}, -- 黑暗召唤师
			{type = "PlateNpcID", mobID = "179963", color = {1, 0, 0, 1}, dif = {[16] = true}}, -- 恐惧宝珠
			{type = "PlateNpcID", mobID = "178008", color = {.7, .7, .7, 1}}, -- 衰弱宝珠
		},
		TextAlert = {
			{	-- 已检查
				type = "hp",
				data = {
					unit = "boss1",
					npc_id = "175732",
					ranges = {
						{ ul = 86, ll = 84, tip = string.format(L["阶段转换"], "84")},
					},
				},
			},
			{	-- 已检查
				type = "pp",
				data = {
					unit = "boss1",
					npc_id = "175732",
					ranges = {
						{ ul = 99, ll = 80, tip = L["即将黑暗帷幕"]},
					},
				},
			},
			{	
				type = "spell", -- 风行者
				spellID = 347504,
				color = {0, 1, 1},
				events = {
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,	
				},
				update = function(self, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then
						local _, sub_event, _, sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellID, spellName = CombatLogGetCurrentEventInfo()
						if sub_event == "SPELL_AURA_APPLIED" and spellID == 347504 then -- 风行者
							self.text:SetText(L["小心脚下"])
							self:Show()
							C_Timer.After(5, function()
								self:Hide()
							end)
						end
					end
				end,
			},
			{	
				type = "spell", -- 女妖斗篷
				spellID = 350857,
				color = {1, 1, 0},
				events = {
					["UNIT_AURA"] = true,
					["PLAYER_TARGET_CHANGED"] = true,
				},
				update = function(self, event, ...)
					if event == "UNIT_AURA" or event == "PLAYER_TARGET_CHANGED" then
						local aura = GetSpellInfo(350857)
						if AuraUtil.FindAuraByName(aura, "target", "HELPFUL") then -- boss免疫
							self.text:SetText(L["目标免疫"])
							self:Show()
						else		
							self:Hide()
						end		
					end
				end,
			},
			{	
				type = "spell_clone", -- 恐惧压迫
				spellID = 351117,
				color = {.8, .2, 1},
				dur = 2,
				events = {
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,	
				},
				update = function(self, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then
						local _, sub_event, _, sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellID, spellName = CombatLogGetCurrentEventInfo()
						if sub_event == "SPELL_CAST_START" and spellID == 351117 then -- 恐惧压迫
							self.Clone(L["点名白圈"], true)
						end
					end
				end,
			},
		},
		ChatMsg = {
			{type = "ChatMsgAuraCountdown", spellID = 348064, playername = true, spellname = true, icon = 0}, -- 哀恸箭 待检查
			{type = "ChatMsgAuraCountdown", spellID = 358705, playername = true, spellname = true, icon = 0}, -- 黑蚀箭 待检查
			{type = "ChatMsgRange", range_event = "SPELL_CAST_START", spellID = 348094, range = 7}, -- 女妖哀嚎 已检查 法术为6码，但只能监测7码
			{type = "ChatMsgRange", range_event = "SPELL_CAST_START", spellID = 353957, range = 7}, -- 女妖尖啸 已检查 7码
			{type = "ChatMsgAuraCountdown", spellID = 351562, playername = true, spellname = true, icon = 8}, -- 驱逐 待检查
			{type = "ChatMsgAuraCountdown", spellID = 358434, playername = true, spellname = true, icon = 7}, -- 死亡飞刀 待检查
		},
		Sound = {
			-- P1
			{spellID = 347504, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED"}, -- 小心脚下 已检查
			{spellID = 347807, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED", unit = "player"}, -- 倒刺 已检查
			{spellID = 347807, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED_DOSE", unit = "player"}, -- 倒刺叠层 已检查
			{spellID = 347670, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED", unit = "player"}, -- 注意自保 已检查
			{spellID = 349419, event = "BW_AND_DBM_SPELL", dur = 3, countdown = false, addon_only = "DBM"}, -- 准备锁链 已检查
			{spellID = 349458, event = "BW_AND_DBM_SPELL", dur = 3, countdown = false, addon_only = "BW"}, -- 准备锁链 已检查			
			{spellID = 349458, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED", unit = "player"}, -- 连接锁链
			{spellID = 347726, event = "CHAT_MSG_RAID_BOSS_EMOTE", msg = "347704"}, -- 黑暗帷幕 已检查
			{spellID = 347704, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED", unit = "player"}, -- 注意自保
			{spellID = 348064, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED", unit = "player", countdown = true}, -- 哀恸点你
			{spellID = 358705, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED", unit = "player", countdown = true}, -- 黑蚀点你
			{spellID = 352663, role = "tank", event = "UNIT_SPELLCAST_START", unit = "player"}, -- 觅心箭
			-- P1.5
			{spellID = 353417, event = "UNIT_SPELLCAST_START"}, -- 劈裂
			{spellID = 353418, event = "UNIT_SPELLCAST_START"}, -- 劈裂
			-- P2	
			{spellID = 352271, event = "UNIT_SPELLCAST_START"}, -- 躲推波
			{spellID = 351353, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_CAST_START"}, -- 宝珠快打
			{spellID = 356021, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_CAST_START"}, -- 召唤宝珠
			{spellID = 356023, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_CAST_START"}, -- 打断恐惧宝珠			
			{spellID = 351117, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED", unit = "player"}, -- 躲开队友		
			{spellID = 351589, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_CAST_START"}, -- 躲开巨像正面
			-- P3
			{spellID = 354011, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_CAST_START"}, -- 躲开紫圈
			{spellID = 353929, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED", unit = "player"}, -- 灾厄
			{spellID = 353929, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED_DOSE", unit = "player"}, -- 灾厄叠层
			{spellID = 353969, role = "tank", event = "UNIT_SPELLCAST_START", unit = "player"}, -- 觅心箭
			{spellID = 358181, role = "tank", event = "UNIT_SPELLCAST_START", unit = "player"}, -- 女妖之刃
			{spellID = 354068, event = "UNIT_SPELLCAST_START"}, -- 女妖之怒
			{spellID = 354147, event = "UNIT_SPELLCAST_START"}, -- 换台子
			{spellID = 358434, event = "COMBAT_LOG_EVENT_UNFILTERED", sub_event = "SPELL_AURA_APPLIED", unit = "player"}, -- 飞刀点你
		},
		HP_Watch = {
			{sub_event = "SPELL_CAST_START", spellID = 347609}, -- 哀恸箭
			{sub_event = "SPELL_CAST_START", spellID = 354142}, -- 黑暗帷幕 P3
		},
		Phase_Change = {
			{empty = true},
			{sub_event = "SPELL_CAST_START", spellID = 352843}, -- 引导寒冰
			{sub_event = "SPELL_CAST_SUCCESS", spellID = 357102}, -- 团队副本传送门：奥利波斯		
		},
		BossMods = {
			{ -- 女妖的印记
				spellID = 347607,
				role = "tank",
				tip = string.format(L["多人光环提示"], T.GetIconLink(347607)),
				points = {a1 = "TOPLEFT", a2 = "CENTER", x = -700, y = 100, width = 250, height = 100},				
				events = {
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,	
				},
				difficulty_id = {
					["all"] = true,
				},
				init = function(frame)
					frame.aura_spell_ids = {347607}
					frame.aura_spells = {}
					for i, v in pairs(frame.aura_spell_ids) do
						frame.aura_spells[v] = {aura = GetSpellInfo(v), icon = select(3, GetSpellInfo(v))}
					end
					
					frame.bars = {}
						
					frame.create_bar = function(tag, spellID, player)
						local bar = T.CreateTimerBar(frame, frame.aura_spells[spellID]["icon"], true, false, true)
						bar.spellID = spellID
						bar.name = player
						frame.bars[tag] = bar			
					end
				
					frame.updatebar = function(bar, count, dur, exp_time)
						bar.left:SetText(T.ColorName(bar.name, true))
						
						bar.exp = exp_time
						bar.anim_played = false
						bar:SetMinMaxValues(0 , dur)
						
						bar:SetScript("OnUpdate", function(self, e)
							self.t = self.t + e
							if self.t > self.update_rate then		
								local remain = exp_time - GetTime()
								if remain > 0 then								
									self.right:SetText((count > 0 and "|cffFFFF00["..count.."]|r " or "")..T.FormatTime(remain))
									self:SetValue(dur - remain)
									if remain < 3 then -- 即将消失
										if not self.anim_played then
											self.anim_played = true
											self.glow:Show()
											self.anim:Play()
										end
										self.glow:SetAlpha(self.anim:GetProgress())
									end
								else
									self:Hide()
									self:SetScript("OnUpdate", nil)
									self.anim:Stop()
									self.glow:Hide()
								end
								self.t = 0
							end
						end)											
						bar:Show()
					end
					
					frame.lineup = function()
						local t = {}
						for GUID, bar in pairs(frame.bars) do
							if bar and bar:IsVisible() then
								table.insert(t, bar)
							end
						end
						if #t > 1 then
							table.sort(t, function(a, b) 
								if a.spellID < b.spellID then
									return true
								elseif a.spellID == b.spellID and a.exp < b.exp then
									return true
								end
							end)
						end
						local lastbar
						for i, bar in pairs(t) do
							bar:ClearAllPoints()
							if bar:IsVisible() then
								if not lastbar then
									bar:SetPoint("TOPLEFT", frame, "TOPLEFT", 30, -5)
									lastbar = bar
								else
									bar:SetPoint("TOPLEFT", lastbar, "BOTTOMLEFT", 0, -5)
									lastbar = bar
								end
							end
						end
					end			
				end,
				update = function(frame, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then						
						local _, sub_event, _, _, _, _, _, destGUID, destName, _, _, spellID = CombatLogGetCurrentEventInfo()
						if (sub_event == "SPELL_AURA_APPLIED" or sub_event == "SPELL_AURA_APPLIED_DOSE" or sub_event == "SPELL_AURA_REMOVED_DOSE") and frame.aura_spells[spellID] then						
							local dest = string.split("-", destName)				
							if destGUID and AuraUtil.FindAuraByName(frame.aura_spells[spellID]["aura"], dest, G.Test_Mod and "HELPFUL" or "HARMFUL") then
								local count, _, dur, exp_time = select(3, AuraUtil.FindAuraByName(frame.aura_spells[spellID]["aura"], dest, G.Test_Mod and "HELPFUL" or "HARMFUL"))
								if not frame.bars[spellID.."_"..destGUID] then
									frame.create_bar(spellID.."_"..destGUID, spellID, dest)
								end
								
								local bar = frame.bars[spellID.."_"..destGUID]
								frame.updatebar(bar, count, dur, exp_time)
								
								frame.lineup()
							end
						elseif sub_event == "SPELL_AURA_REMOVED" and frame.aura_spells[spellID] then
							if destGUID and frame.bars[spellID.."_"..destGUID] then
								local bar = frame.bars[spellID.."_"..destGUID]
								bar:Hide()
								bar:SetScript("OnUpdate", nil)
								bar.anim:Stop()
								bar.glow:Hide()
								frame.lineup()
							end
						end
					end	
				end,
				reset = function(frame)
					for tag, bar in pairs(frame.bars) do
						bar:ClearAllPoints()
						bar:Hide()
						bar:SetScript("OnUpdate", nil)
						bar.anim:Stop()
						bar.glow:Hide()
					end				
					frame.bars = table.wipe(frame.bars)
					frame:Hide()
				end,
			},
			{ -- 全团倒刺之箭层数监视 已检查
				spellID = 347807,
				tip = L["TIP倒刺之箭"],
				points = {a1 = "TOPLEFT", a2 = "CENTER", x = -950, y = 250, width = 250, height = 250},				
				events = {
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,	
				},
				difficulty_id = {
					["all"] = true,
				},
				init = function(frame)
					frame.aura_spell_id = 347807
					frame.aura, _, frame.icon = GetSpellInfo(frame.aura_spell_id)
					frame.bars = {}
					
					frame.create_bar = function(guid, player)
						local bar = CreateFrame("Frame", nil, frame)
						bar:SetHeight(20)
						bar:SetWidth(150)
											
						bar.icon = bar:CreateTexture(nil, "OVERLAY")
						bar.icon:SetTexCoord( .1, .9, .1, .9)
						bar.icon:SetSize(20, 20)
						bar.icon:SetPoint("RIGHT", bar, "LEFT", -5, 0)
						bar.icon:SetTexture(frame.icon)
						bar.stack = 0
						T.createbdframe(bar.icon)
						
						bar.name = T.ColorName(player, true)
						
						bar.text = T.createtext(bar, "OVERLAY", 15, "OUTLINE", "LEFT")
						bar.text:SetPoint("LEFT", bar, "LEFT", 5, 0)
							
						frame.bars[guid] = bar							
					end
					frame.updatebar = function(bar, name)
						if AuraUtil.FindAuraByName(frame.aura, name, "HARMFUL") then
							local stack = select(3, AuraUtil.FindAuraByName(frame.aura, name, "HARMFUL"))
							if stack >= 5 then
								bar.text:SetText(bar.name.."|cffFF0000["..stack.."]|r")
							elseif stack >= 4 then
								bar.text:SetText(bar.name.."|cffFFA500["..stack.."]|r")
							elseif stack >= 3 then
								bar.text:SetText(bar.name.."|cffFFFF00["..stack.."]|r")
							else
								bar.text:SetText(bar.name.."["..stack.."]")
							end
							
							if stack >= 2 then
								bar:Show()
							else
								bar:Hide()
							end
							bar.stack = stack
						else
							bar:Hide()
							bar.stack = 0
						end
					end
					frame.lineup = function()
						local t = {}
						for GUID, bar in pairs(frame.bars) do
							if bar and bar:IsVisible() then
								table.insert(t, bar)
							end
						end
						if #t > 1 then
							table.sort(t, function(a, b) return a.stack > b.stack end)
						end
						local lastbar
						for i, bar in pairs(t) do
							bar:ClearAllPoints()
							if bar:IsVisible() then
								if not lastbar then
									bar:SetPoint("TOPLEFT", frame, "TOPLEFT", 25, -5)
									lastbar = bar
								else
									bar:SetPoint("TOPLEFT", lastbar, "BOTTOMLEFT", 0, -5)
									lastbar = bar
								end
							end
						end
					end			
				end,
				update = function(frame, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then
						local _, sub_event, _, _, _, _, _, destGUID, destName, _, _, spellID = CombatLogGetCurrentEventInfo()
						if (sub_event == "SPELL_AURA_APPLIED" or sub_event == "SPELL_AURA_APPLIED_DOSE" or sub_event == "SPELL_AURA_REMOVED" or sub_event == "SPELL_AURA_REMOVED_DOSE") and spellID == frame.aura_spell_id then						
							if destGUID then
								if not frame.bars[destGUID] then
									frame.create_bar(destGUID, destName)
								end
								
								local bar = frame.bars[destGUID]
								frame.updatebar(bar, destName)
								frame.lineup()
							end
						end
					end
				end,
				reset = function(frame)
					for tag, bar in pairs(frame.bars) do
						bar:ClearAllPoints()
						bar:Hide()
						bar.stack = 0
					end
					frame.bars = table.wipe(frame.bars)
					frame:Hide()
				end,
			},
			{ -- 锁链时倒刺之箭情况 已检查
				spellID = 349419,
				tip = L["TIP统御锁链"],		
				events = {
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,
					["UNIT_AURA"] = true,
					["NAME_PLATE_UNIT_ADDED"] = true,
					["NAME_PLATE_UNIT_REMOVED"] = true,
				},
				difficulty_id = {
					["all"] = true,
				},
				init = function(frame)
					frame.aura_spell_id = 347807 -- 倒刺
					frame.aura, _, frame.icon = GetSpellInfo(frame.aura_spell_id)
					frame.aura_spell_id2 = 356651 -- 悲哀
					frame.aura2, _, frame.icon2 = GetSpellInfo(frame.aura_spell_id2)
					frame.aura3 = GetSpellInfo(356624) -- 灾祸
					
					frame.targets = {}
					
					frame.text = T.createtext(frame, "OVERLAY", 15, "OUTLINE", "LEFT")
					frame.text:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
					
					frame.text_center = T.createtext(frame, "OVERLAY", 40, "OUTLINE", "LEFT")
					frame.text_center:SetPoint("BOTTOM", UIParent, "CENTER", 0, 200)
					
					frame.update_text = function()
						if #frame.targets > 1 then
							table.sort(frame.targets, function(a, b)
								if a.s > b.s then
									return true
								elseif a.s == b.s and a.i < b.i then
									return true
								end
							end)
						end
						
						local str = L["右"].."\n"
						
						local My 
						for i, v in pairs(frame.targets) do
							if i <= 8 then
								local target_string = string.format(" %s [%d]\n", T.ColorName(v.n), v.s)
								if i == 4 then
									str = str..target_string.." \n"..L["左"].."\n" -- 第4个人之后换行
								else
									str = str..target_string
								end
								if v.n == G.PlayerName then -- 我也是其中之一
									if i <= 4 then -- 右侧
										T.SendChatMsg("右 "..v.s, 5, "SAY")								
										frame.text_center:SetText(string.format("|T450908:12:12:0:0:64:64:4:60:4:60|t %d |T450908:12:12:0:0:64:64:4:60:4:60|t", v.s))
										if not SoD_CDB["General"]["disable_sound"] then
											PlaySoundFile(G.media.sounds.."SylvanasWindrunner\\goright.ogg", "Master") -- 靠近左侧锁链声音							
										end
									else -- 左侧
										T.SendChatMsg("左 "..v.s, 5, "YELL")
										frame.text_center:SetText(string.format("|T450906:12:12:0:0:64:64:4:60:4:60|t %d |T450906:12:12:0:0:64:64:4:60:4:60|t", v.s))
										if not SoD_CDB["General"]["disable_sound"] then
											PlaySoundFile(G.media.sounds.."SylvanasWindrunner\\goleft.ogg", "Master") -- 靠近右侧锁链声音							
										end
									end
									C_Timer.After(4, function()
										frame.text_center:SetText("")
									end)
								end
							else
								break
							end
						end
						frame.text:SetText(str)
					end
					
					frame:Hide()
				end,
				update = function(frame, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then
						local _, Event_type, _, SourceGUID, SourceName, _, _, DestGUID, destName, _, destRaidFlags, spellID = CombatLogGetCurrentEventInfo()
						if Event_type == "SPELL_CAST_START" and spellID == 349419 then
							local difficultyID = select(3, GetInstanceInfo())
							if difficultyID == 16 then -- M
								frame.targets = table.wipe(frame.targets)
								local group_size = GetNumGroupMembers()	
								for i = 1, group_size do					
									local unit = "raid"..i
									if AuraUtil.FindAuraByName(frame.aura, unit, "HARMFUL") then -- 带倒刺
										local has_debuff, _, debuff_stack = AuraUtil.FindAuraByName(frame.aura2, unit, "HARMFUL")
										if not has_debuff or debuff_stack <= 2 then --悲哀小于两层
											local name = UnitName(unit)
											local stack = select(3, AuraUtil.FindAuraByName(frame.aura, unit, "HARMFUL"))
											table.insert(frame.targets, {n = name, s = stack, i = i})
										end
									end							
								end
								frame.update_text()
							else -- H/PT
								if AuraUtil.FindAuraByName(frame.aura, "player", "HARMFUL") then -- 带debuff
									local stack = select(3, AuraUtil.FindAuraByName(frame.aura, "player", "HARMFUL"))
									if stack >= 2 then
										T.SendChatMsg("{rt8}["..stack.."]"..frame.aura.."{rt8}", 5)
										if not SoD_CDB["General"]["disable_sound"] then
											PlaySoundFile(G.media.sounds.."SylvanasWindrunner\\closetochain.ogg", "Master") -- 靠近锁链						
										end
									end
								end
							end
						elseif Event_type == "SPELL_AURA_APPLIED" and spellID == 350857 then --  P2
							frame:Hide()	
						end
					elseif event == "UNIT_AURA" or event == "NAME_PLATE_UNIT_ADDED" or event == "NAME_PLATE_UNIT_REMOVED" then
						local unit = ...
						if strfind(unit, "nameplate") then
							local target_frame = LGF.GetUnitNameplate(unit)
							if target_frame then
								if unit and AuraUtil.FindAuraByName(frame.aura3, unit, "HARMFUL") then
									local unitCaster = select(7, AuraUtil.FindAuraByName(frame.aura3, unit, "HARMFUL"))
									if UnitIsUnit(unitCaster ,"player") then
										LCG.PixelGlow_Start(target_frame, {1,0,0}, 12, .25, nil, 3, 3, 3, true, "chain")
									else
										LCG.PixelGlow_Stop(target_frame, "chain")
									end
								else
									LCG.PixelGlow_Stop(target_frame, "chain")
								end
							end
						end
					end
				end,
				reset = function(frame)
					frame.targets = table.wipe(frame.targets)
					frame.text:SetText("")
					frame:Hide()
					for i, namePlate in ipairs(C_NamePlate.GetNamePlates()) do
						local unit = namePlate.namePlateUnitToken
						if unit then
							local target_frame = LGF.GetUnitNameplate(unit)
							if target_frame then
								LCG.PixelGlow_Stop(target_frame, "chain")
							end
						end
					end
				end,
			},
			{ -- 全团女妖的灾厄层数监视 已检查
				spellID = 353929,
				tip = L["TIP女妖的灾厄"],
				points = {a1 = "TOPLEFT", a2 = "CENTER", x = -950, y = 250, width = 250, height = 250},			
				events = {
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,	
				},
				difficulty_id = {
					["all"] = true,
				},
				init = function(frame)
					frame.aura_spell_id = 353929
					frame.aura, _, frame.icon = GetSpellInfo(frame.aura_spell_id)
					frame.bars = {}
					
					frame.create_bar = function(guid, player)
						local bar = CreateFrame("Frame", nil, frame)
						bar:SetHeight(20)
						bar:SetWidth(150)
											
						bar.icon = bar:CreateTexture(nil, "OVERLAY")
						bar.icon:SetTexCoord( .1, .9, .1, .9)
						bar.icon:SetSize(20, 20)
						bar.icon:SetPoint("RIGHT", bar, "LEFT", -5, 0)
						bar.icon:SetTexture(frame.icon)
						bar.stack = 0
						T.createbdframe(bar.icon)
						
						bar.name = T.ColorName(player, true)
						
						bar.text = T.createtext(bar, "OVERLAY", 15, "OUTLINE", "LEFT")
						bar.text:SetPoint("LEFT", bar, "LEFT", 5, 0)
						
						frame.bars[guid] = bar
					end
					frame.updatebar = function(bar, name)
						if AuraUtil.FindAuraByName(frame.aura, name, "HARMFUL") then
							local stack = select(3, AuraUtil.FindAuraByName(frame.aura, name, "HARMFUL"))
							if stack >= 4 then
								bar.text:SetText(bar.name.."|cffFF0000["..stack.."]|r")
							elseif stack >= 3 then
								bar.text:SetText(bar.name.."|cffFFA500["..stack.."]|r")
							elseif stack >= 2 then
								bar.text:SetText(bar.name.."|cffFFFF00["..stack.."]|r")	
							else
								bar.text:SetText(bar.name.."["..stack.."]")	
							end
							bar.stack = stack
						else
							bar:Hide()
							bar.stack = 0
						end
					end
					frame.lineup = function()		
						local t = {}
						for GUID, bar in pairs(frame.bars) do
							if bar and bar:IsVisible() then
								table.insert(t, bar)
							end
						end
						if #t > 1 then
							table.sort(t, function(a, b) return a.stack > b.stack end)
						end
						local lastbar
						for i, bar in pairs(t) do
							bar:ClearAllPoints()
							if bar:IsVisible() then
								if not lastbar then
									bar:SetPoint("TOPLEFT", frame, "TOPLEFT", 25, -5)
									lastbar = bar
								else
									bar:SetPoint("TOPLEFT", lastbar, "BOTTOMLEFT", 0, -5)
									lastbar = bar
								end
							end
						end
					end
				end,
				update = function(frame, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then
						local _, sub_event, _, _, _, _, _, destGUID, destName, _, _, spellID = CombatLogGetCurrentEventInfo()
						if (sub_event == "SPELL_AURA_APPLIED" or sub_event == "SPELL_AURA_APPLIED_DOSE" or sub_event == "SPELL_AURA_REMOVED" or sub_event == "SPELL_AURA_REMOVED_DOSE") and spellID == frame.aura_spell_id then						
							if destGUID then
								if not frame.bars[destGUID] then
									frame.create_bar(destGUID, destName)			
								end
								
								local bar = frame.bars[destGUID]
								frame.updatebar(bar, destName)
								frame.lineup()
							end
						end
					end
				end,
				reset = function(frame)
					for tag, bar in pairs(frame.bars) do
						bar:ClearAllPoints()
						bar:Hide()
						bar.stack = 0
					end
					frame.bars = table.wipe(frame.bars)					
					frame:Hide()
				end,
			},
			{ -- 女妖之怒时高亮框架 已检查
				spellID = 354068,
				role = "healer",
				tip = L["TIP女妖之怒"],
				points = {a1 = "BOTTOM", a2 = "CENTER", x = 0, y = 300, width = 400, height = 40},				
				events = {
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,
				},
				difficulty_id = {
					[15] = true,
					[16] = true,
				},
				init = function(frame)
					frame.spellID = 354068
					frame.spellID2 = 353929
					frame.spellName, _, frame.iconTexture = GetSpellInfo(frame.spellID)
					frame.spellName2, _, frame.iconTexture2 = GetSpellInfo(frame.spellID2)
					
					local bar = T.CreateTimerBar(frame, frame.iconTexture, true, false, true, 400, 40, 25, .48, .4, .93)	
					bar:SetPoint("TOPLEFT", frame, "TOPLEFT")
					bar.glow:SetBackdropBorderColor(1, 0, 0)
					bar:SetMinMaxValues(0, 5)	
					bar.count_down = 0
					bar.ind = 0
					
					frame.bar = bar
					
					frame.update_text = function()
						if AuraUtil.FindAuraByName(frame.spellName2, "player", G.Test_Mod and "HELPFUL" or "HARMFUL") then -- 带灾厄debuff
							local stack = select(3, AuraUtil.FindAuraByName(frame.spellName2, "player", G.Test_Mod and "HELPFUL" or "HARMFUL"))
							frame.bar.left:SetText(string.format("|cffFF0000%s (%d)!|r", frame.spellName2, stack))
						else
							frame.bar.left:SetText(string.format("%s [%d]", frame.spellName, frame.bar.ind))
						end
					end
				end,
				update = function(frame, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then
						local _, Event_type, _, _, _, _, _, DestGUID, destName, _, destRaidFlags, spellID = CombatLogGetCurrentEventInfo()
						if Event_type == "SPELL_CAST_START" and spellID == frame.spellID then -- 女妖之怒读条
							frame.bar.ind = frame.bar.ind + 1
							frame.update_text()
							
							frame.bar.exp = GetTime() + 5
							frame.bar:SetScript("OnUpdate", function(self, e)
								self.t = self.t + e
								if self.t > self.update_rate then
									local remain = self.exp - GetTime()
									if remain > 0 then
										self:SetValue(5 - remain)
										if not SoD_CDB["General"]["disable_sound"] then
											if self.count_down ~= ceil(remain) then -- 倒数
												self.count_down = ceil(remain)
												if self.count_down <= 3 then
													PlaySoundFile(G.media.sounds.."count\\"..self.count_down..".ogg", "Master") -- 3..2..1..
												end
											end
										end
										if AuraUtil.FindAuraByName(frame.spellName2, "player", G.Test_Mod and "HELPFUL" or "HARMFUL") then -- 带灾厄debuff
											self.glow:SetAlpha(self.anim:GetProgress())
											self.right:SetText("|cffFF0000"..T.FormatTime(remain).."|r")
										else
											self.glow:SetAlpha(0)
											self.right:SetText(T.FormatTime(remain))
										end
									else
										self:Hide()	
										self:SetScript("OnUpdate", nil)
										self.anim:Stop()
										self.glow:Hide()
									end
									self.t = 0
								end
							end)
							
							if AuraUtil.FindAuraByName(frame.spellName2, "player", G.Test_Mod and "HELPFUL" or "HARMFUL") then -- 带灾厄debuff
								frame.bar.glow:Show()
								frame.bar.anim:Play()
							end	
							
							frame.bar:Show()
							
							local group_size = GetNumGroupMembers()	-- 高亮团队框架
							for i = 1, group_size do					
								local unit = "raid"..i
								if AuraUtil.FindAuraByName(frame.spellName2, unit, G.Test_Mod and "HELPFUL" or "HARMFUL") then -- 带灾厄debuff
									local name = UnitName(unit)
									T.GlowRaidFrame_Show(name, "dispel354068", 1, 0, 0)
								end							
							end
						elseif Event_type == "SPELL_AURA_APPLIED" or Event_type == "SPELL_AURA_APPLIED_DOSE" and spellID == frame.spellID2 then -- 灾厄debuff出现/叠层
							local dest = string.split("-", destName)
							if dest == G.PlayerName then
								frame.update_text()
							end
						elseif Event_type == "SPELL_AURA_REMOVED" and spellID == frame.spellID2 then -- 灾厄debuff消失
							local dest = string.split("-", destName)
							T.GlowRaidFrame_Hide(dest, "dispel354068")
							if dest == G.PlayerName then
								frame.update_text()
							end
						end
					elseif event == "ENCOUNTER_START" then
						frame.bar.ind = 0
					end
				end,
				reset = function(frame)
					frame.bar.ind = 0
					frame.bar.left:SetText("")
					frame.bar:Hide()
					frame.bar:SetScript("OnUpdate", nil)
					frame.bar.anim:Stop()
					frame.bar.glow:Hide()
					T.GlowRaidFrame_HideAll()		
				end,
			},
			{ -- 黑暗帷幕吸收量团队框架发光指示 已检查
				spellID = 347704,
				role = "healer",
				tip = L["TIP黑暗帷幕"],
				points = {hide = true},
				events = {
					["UNIT_HEAL_ABSORB_AMOUNT_CHANGED"] = true,
				},
				difficulty_id = {
					["all"] = true,
				},
				init = function(frame)
					
				end,
				update = function(frame, event, ...)
					if event == "UNIT_HEAL_ABSORB_AMOUNT_CHANGED" then
						local unit = ...
						if unit and UnitInRaid(unit) then
							local name = UnitName(unit)
							if UnitGetTotalHealAbsorbs(unit) > 40000 then 
								T.GlowRaidFrame_Show(name, "absorb347704", .7, .5, 1)
							else
								T.GlowRaidFrame_Hide(name, "absorb347704", .7, .5, 1)
							end
						end
					end
				end,
				reset = function(frame)
					T.GlowRaidFrame_HideAll()	
				end,
			},
			{ -- 黑暗帷幕读条计数 已检查
				spellID = 347726,
				tip = L["TIP黑暗帷幕读条计数"],
				points = {a1 = "BOTTOM", a2 = "CENTER", x = 0, y = 300, width = 400, height = 40},				
				events = {	
					["CHAT_MSG_RAID_BOSS_EMOTE"] = true,
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,	
					--["CHAT_MSG_SAY"] = true,
				},
				difficulty_id = {
					["all"] = true,
				},
				init = function(frame)
					frame.spellID = 347726
					frame.spellName, _, frame.iconTexture = GetSpellInfo(frame.spellID)
					frame.msg = "347704"
					
					local bar = T.CreateTimerBar(frame, frame.iconTexture, false, false, true, 400, 40, 25, 1, 1, 0)			
					bar:SetPoint("TOPLEFT", frame, "TOPLEFT")
					bar.ind = 0
					bar.count_down = 0
					
					frame.bar = bar
					frame.stage = 1					
				end,
				update = function(frame, event, ...)
					if event == "CHAT_MSG_RAID_BOSS_EMOTE" then
						local Message = ...
						if strfind(Message, frame.msg) then -- 黑暗帷幕 开始
							frame.bar.ind = frame.bar.ind + 1
							frame.bar.left:SetText(string.format("%s [%d]", frame.spellName, frame.bar.ind))
							
							local cast_dur
							if frame.stage == 1 then
								cast_dur = 7
							elseif frame.stage == 2 then
								cast_dur = 5
							else
								cast_dur = 3
								T.RangeCheck(5) -- 距离检查
							end
							
							frame.bar:SetMinMaxValues(0, cast_dur)
							frame.bar.exp = GetTime() + cast_dur					
							frame.bar:Show()
							
							frame.bar:SetScript("OnUpdate", function(self, e)
								self.t = self.t + e
								if self.t > self.update_rate then
									local remain = self.exp - GetTime()
									if remain > 0 then
										self.right:SetText(T.FormatTime(remain))
										self:SetValue(cast_dur - remain)
										if not SoD_CDB["General"]["disable_sound"] then
											if self.count_down ~= ceil(remain) then -- 倒数
												self.count_down = ceil(remain)
												if self.count_down <= 3 then
													PlaySoundFile(G.media.sounds.."count\\"..self.count_down..".ogg", "Master") -- 3..2..1..
												end
											end
										end
									else
										self.left:SetText("")
										self:Hide()	
										self:SetScript("OnUpdate", nil)
									end
									self.t = 0
								end
							end)					
						end
					elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
						local _, sub_event, _, _, _, _, _, DestGUID, destName, _, destRaidFlags, spellID = CombatLogGetCurrentEventInfo()
						if sub_event == "SPELL_AURA_APPLIED" and spellID == 348146 and frame.stage ~= 2 then --  P2 女妖形态 转阶段 重置计数为0
							frame.stage = 2
							frame.bar.ind = 0	
						elseif sub_event == "SPELL_CAST_SUCCESS" and spellID == 357729 and frame.stage ~= 3 then --  P3 渎神之光 转阶段 重置计数为0
							frame.stage = 3
							frame.bar.ind = 0							
						end
					elseif event == "ENCOUNTER_START" then
						frame.stage = 1
						frame.bar.ind = 0
						frame.bar.left:SetText("")
					end
				end,
				reset = function(frame)
					frame.bar:Hide()
					frame.bar:SetScript("OnUpdate", nil)			
				end,
			},		
			{ -- 哀痛箭/黑蚀箭 已检查
				spellID = 348064,
				tip = L["TIP哀痛箭"],
				points = {a1 = "TOPLEFT", a2 = "CENTER", x = -700, y = 200, width = 250, height = 100},			
				events = {
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,	
				},
				difficulty_id = {
					["all"] = true,
				},
				init = function(frame)
					frame.aura_spell_id = 139 --348064
					frame.aura = GetSpellInfo(frame.aura_spell_id)
					frame.icon = select(3, GetSpellInfo(frame.aura_spell_id))
					
					frame.bars = {}
					frame.ind = 0
					frame.exp = 0
					
					frame:SetScript("OnUpdate", function(self, e)
						self.t = self.t + e
						if self.t > 1 then
							local remain = self.exp - GetTime()
							if remain <= 0 and self.ind ~= 0 then
								self.ind = 0
							end
							self.t = 0
						end
					end)
					
					frame.text_center = T.createtext(frame, "OVERLAY", 40, "OUTLINE", "LEFT")
					frame.text_center:SetPoint("BOTTOM", UIParent, "CENTER", 0, 200)
					
					frame.cd_tex = T.CreateCircleCD(frame, 50, 0, 1, 0)
					frame.cd_tex:SetPoint("CENTER", UIParent, "CENTER", 0, 0)					

					frame.create_bar = function(tag, player)
						local bar = T.CreateTimerBar(frame, frame.icon, true, false, true)
						bar:SetStatusBarColor(.5, .2, 1)
						bar.name = player									
						frame.bars[tag] = bar			
					end
				
					frame.updatebar = function(bar, dur, exp_time)
						bar.left:SetText(T.ColorName(bar.name, true).."|cffFFFF00["..frame.ind.."]|r")
						bar.ind = frame.ind
						bar.exp = exp_time
						bar.count_down = 0
						bar.anim_played = false
						bar:SetMinMaxValues(0 , dur)
						
						bar:SetScript("OnUpdate", function(self, e)
							self.t = self.t + e
							if self.t > self.update_rate then		
								local remain = exp_time - GetTime()
								if remain > 0 then
									self.right:SetText(T.FormatTime(remain))
									self:SetValue(dur - remain)
									
									if bar.name == G.PlayerName then
										frame.text_center:SetText(string.format(L["你被点"], frame.aura, bar.ind, remain))
										
										if remain < 2 then
											frame.cd_tex.color(1, 0, 0)
										elseif remain < 5 then										
											frame.cd_tex.color(1, 1, 0)
										else
											frame.cd_tex.color(0, 1, 0)
										end
									end
									
									if remain < 5 then -- 预警时间
										if not self.anim_played then
											self.anim_played = true
											self.glow:Show()
											self.anim:Play()
										end
										self.glow:SetAlpha(self.anim:GetProgress())
										
										if not SoD_CDB["General"]["disable_sound"] then
											if bar.count_down ~= ceil(remain) then -- 倒数
												bar.count_down = ceil(remain)
												if bar.ind<= 3 then -- 防bug
													if bar.count_down == 4 then
														if frame.aura_spell_id == 348064 then
															PlaySoundFile(G.media.sounds.."SylvanasWindrunner\\arrow1"..bar.ind..".ogg", "Master") -- 哀痛1/2/3准备
														else
															PlaySoundFile(G.media.sounds.."SylvanasWindrunner\\arrow2"..bar.ind..".ogg", "Master") -- 黑蚀1/2/3准备
														end
													elseif bar.count_down <= 2 then
														PlaySoundFile(G.media.sounds.."count\\"..bar.count_down..".ogg", "Master") -- 2..1..
													end
												end
											end
										end
									end
								else			
									self:Hide()
									self:SetScript("OnUpdate", nil)
									self.anim:Stop()
									self.glow:Hide()
								end
								self.t = 0
							end
						end)
						
						bar:Show()
						
						if bar.name == G.PlayerName then
							frame.cd_tex:SetCooldown(GetTime(), dur)
						end
					end
					
					frame.lineup = function()
						local t = {}
						for GUID, bar in pairs(frame.bars) do
							if bar and bar:IsVisible() then
								table.insert(t, bar)
							end
						end
						if #t > 1 then
							table.sort(t, function(a, b) return a.exp < b.exp end)
						end
						local lastbar
						for i, bar in pairs(t) do
							bar:ClearAllPoints()
							if bar:IsVisible() then
								if not lastbar then
									bar:SetPoint("TOPLEFT", frame, "TOPLEFT", 30, -5)
									lastbar = bar
								else
									bar:SetPoint("TOPLEFT", lastbar, "BOTTOMLEFT", 0, -5)
									lastbar = bar
								end
							end
						end
					end
					
					frame.said = true
				end,
				update = function(frame, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then
						local _, sub_event, _, _, _, _, _, destGUID, destName, _, _, spellID = CombatLogGetCurrentEventInfo()
						if sub_event == "SPELL_AURA_APPLIED" and spellID == frame.aura_spell_id then
							
							local dest = string.split("-", destName)				
							if destGUID and AuraUtil.FindAuraByName(frame.aura, dest, G.Test_Mod and "HELPFUL" or "HARMFUL") then
								
								local dur, exp_time = select(5, AuraUtil.FindAuraByName(frame.aura, dest, G.Test_Mod and "HELPFUL" or "HARMFUL"))
								
								frame.ind = frame.ind + 1
								if frame.exp < exp_time then
									frame.exp = exp_time
								end
								
								if not frame.bars[destGUID] then
									frame.create_bar(destGUID, dest)
								end
								
								local bar = frame.bars[destGUID]
								frame.updatebar(bar, dur, exp_time)
								
								frame.lineup()
							end
						elseif sub_event == "SPELL_AURA_REMOVED" and spellID == frame.aura_spell_id then
							if destGUID and frame.bars[destGUID] then
								local bar = frame.bars[destGUID]
								bar:Hide()
								bar:SetScript("OnUpdate", nil)
								bar.anim:Stop()
								bar.glow:Hide()
								if bar.name == G.PlayerName then
									frame.text_center:SetText(L["等待伤害"])
									frame.cd_tex:SetCooldown(0, 0)
									frame.said = false
								end				
								frame.lineup()
							end
						elseif sub_event == "SPELL_DAMAGE" and (spellID == 357618 or spellID == 358709) then
							if not frame.said then
								frame.said = true
								frame.text_center:SetText("")
								T.SendChatMsg(G.PlayerName..L["已炸"])
							end
						elseif sub_event == "SPELL_CAST_SUCCESS" and spellID == 357729 then --  P3 渎神之光 转阶段 重置计数为0
							frame.aura_spell_id = 348064
							frame.aura = GetSpellInfo(frame.aura_spell_id)
							frame.icon = select(3, GetSpellInfo(frame.aura_spell_id))
						end
					elseif event == "ENCOUNTER_START" then						
						local dif = select(3, GetInstanceInfo())
						if dif == 16 then
							frame.aura_spell_id = 358705
							frame.aura = GetSpellInfo(frame.aura_spell_id)
							frame.icon = select(3, GetSpellInfo(frame.aura_spell_id))
						else
							frame.aura_spell_id = 348064
							frame.aura = GetSpellInfo(frame.aura_spell_id)
							frame.icon = select(3, GetSpellInfo(frame.aura_spell_id))
						end
						
						frame.ind = 0
						frame.said = true
					end	
				end,
				reset = function(frame)
					for tag, bar in pairs(frame.bars) do
						bar:ClearAllPoints()
						bar:Hide()
						bar:SetScript("OnUpdate", nil)
						bar.anim:Stop()
						bar.glow:Hide()
					end
					frame.text_center:SetText("")
					frame.cd_tex:SetCooldown(0, 0)
					frame.cd_tex.color(0, 1, 0)
					frame.bars = table.wipe(frame.bars)
					frame:Hide()
					frame.ind = 0
					frame.said = true
				end,
			},
			{ -- 死亡飞刀 待检查
				spellID = 358434,
				tip = L["TIP死亡飞刀"],
				points = {a1 = "TOPLEFT", a2 = "CENTER", x = -700, y = 200, width = 250, height = 100},				
				events = {
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,	
				},
				difficulty_id = {
					[16] = true,
				},
				init = function(frame)
					frame.aura_spell_id = 358434
					frame.aura = GetSpellInfo(frame.aura_spell_id)
					frame.icon = select(3, GetSpellInfo(frame.aura_spell_id))
					
					frame.bars = {}
					frame.ind = 0
					frame.exp = 0
					
					frame:SetScript("OnUpdate", function(self, e)
						self.t = self.t + e
						if self.t > 1 then
							local remain = self.exp - GetTime()
							if remain <= 0 and self.ind ~= 0 then
								self.ind = 0
							end
							self.t = 0
						end
					end)
					
					frame.text_center = T.createtext(frame, "OVERLAY", 40, "OUTLINE", "LEFT")
					frame.text_center:SetPoint("BOTTOM", UIParent, "CENTER", 0, 200)
					
					frame.create_bar = function(tag, player)
						local bar = T.CreateTimerBar(frame, frame.icon, false, false, true)						
						bar:SetStatusBarColor(.5, .2, 1)					
						bar.name = player					
						frame.bars[tag] = bar			
					end
				
					frame.updatebar = function(bar, dur, exp_time)
						bar.left:SetText(T.ColorName(bar.name, true).."|cffFFFF00["..frame.ind.."]|r")
						bar.ind = frame.ind
						bar.exp = exp_time
						bar.count_down = 0
						
						bar:SetMinMaxValues(0 , dur)
						bar:SetScript("OnUpdate", function(self, e)
							self.t = self.t + e
							if self.t > self.update_rate then		
								local remain = exp_time - GetTime()
								if remain > 0 then
									
									self.right:SetText(T.FormatTime(remain))
									self:SetValue(dur - remain)
									
									if self.name == G.PlayerName then
										frame.text_center:SetText(string.format(L["你被点"], frame.aura, self.ind, remain))
									end
									
									if self.ind == 1 then -- 防重复，预警时间
										if not SoD_CDB["General"]["disable_sound"] then
											if self.count_down ~= ceil(remain) then -- 倒数
												self.count_down = ceil(remain)
												if self.count_down <= 3 then
													PlaySoundFile(G.media.sounds.."count\\"..self.count_down..".ogg", "Master") -- 3..2..1..
												end
											end
										end
									end
								else			
									self:Hide()
									self:SetScript("OnUpdate", nil)
									if self.name == G.PlayerName then
										frame.text_center:SetText("")
									end
								end
								self.t = 0
							end
						end)											
						bar:Show()
					end
					
					frame.lineup = function()
						local t = {}
						for GUID, bar in pairs(frame.bars) do
							if bar and bar:IsVisible() then
								table.insert(t, bar)
							end
						end
						if #t > 1 then
							table.sort(t, function(a, b) return a.ind < b.ind end)
						end
						local lastbar
						for i, bar in pairs(t) do
							bar:ClearAllPoints()
							if bar:IsVisible() then
								if not lastbar then
									bar:SetPoint("TOPLEFT", frame, "TOPLEFT", 30, -5)
									lastbar = bar
								else
									bar:SetPoint("TOPLEFT", lastbar, "BOTTOMLEFT", 0, -5)
									lastbar = bar
								end
							end
						end
					end			
				end,
				update = function(frame, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then
						local _, sub_event, _, _, _, _, _, destGUID, destName, _, _, spellID = CombatLogGetCurrentEventInfo()
						if sub_event == "SPELL_AURA_APPLIED" and spellID == frame.aura_spell_id then
							
							local dest = string.split("-", destName)				
							if destGUID and AuraUtil.FindAuraByName(frame.aura, dest, G.Test_Mod and "HELPFUL" or "HARMFUL") then
								
								local dur, exp_time = select(5, AuraUtil.FindAuraByName(frame.aura, dest, G.Test_Mod and "HELPFUL" or "HARMFUL"))
								
								frame.ind = frame.ind + 1
								if frame.exp < exp_time then
									frame.exp = exp_time
								end
								
								if not frame.bars[destGUID] then
									frame.create_bar(destGUID, dest)
								end
								
								local bar = frame.bars[destGUID]
								frame.updatebar(bar, dur, exp_time)
								
								frame.lineup()
							end
						elseif sub_event == "SPELL_AURA_REMOVED" and spellID == frame.aura_spell_id then
							if destGUID and frame.bars[destGUID] then
								local bar = frame.bars[destGUID]
								bar:Hide()
								bar:SetScript("OnUpdate", nil)
								if bar.name == G.PlayerName then
									frame.text_center:SetText("")
								end
								frame.lineup()
							end
						end
					end	
				end,
				reset = function(frame)
					for tag, bar in pairs(frame.bars) do
						bar:ClearAllPoints()
						bar:Hide()
						bar:SetScript("OnUpdate", nil)
					end
					frame.text_center:SetText("")
					frame.bars = table.wipe(frame.bars)
					frame:Hide()
					frame.ind = 0
				end,
			},
			{ -- 读条 造桥 妖魂索命 传送奥利波斯 劈裂 女妖哀嚎 女妖尖啸 毁灭 破城箭 已检查
				spellID = 352842,
				tip = L["TIP造桥"],
				points = {a1 = "BOTTOM", a2 = "CENTER", x = 0, y = 150, width = 350, height = 120},			
				events = {	
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,
				},
				difficulty_id = {
					["all"] = true,
				},
				init = function(frame)
					frame.spellIDs = {
						[352842] = { -- 大地召唤 已检查
							color = {r = .87, g = .72, b = .52},
							points = {"TOPLEFT", frame, "TOPLEFT", 0, 0}, 
							text = L["造桥"],
							count = true,
						},
						[352843] = { -- 引导寒冰 已检查
							color = {r = 0, g = 1, b = 1},
							points = {"TOPLEFT", frame, "TOPLEFT", 0, -30}, 
							text = L["造桥"],
							count = true,
						},
						[348094] = { -- 女妖哀嚎 已检查
							color = {r = .72, g = .33, b = .82},
							points = {"TOPLEFT", frame, "TOPLEFT", 0, -60}, 
							text = L["女妖哀嚎"],
							count = true,
						},
						[353952] = { -- 女妖尖啸 已检查
							color = {r = .58, g = 0, b = .82},
							points = {"TOPLEFT", frame, "TOPLEFT", 0, -60}, 
							text = L["女妖尖啸"],
							count = true,
						},	
						[357102] = { -- 传送奥利波斯 已检查
							color = {r = .2, g = .4, b = 1},
							points = {"TOPLEFT", frame, "TOPLEFT", 0, -60}, 
							text = L["传送"],
							count = false,
						},
						[352271] = { -- 妖魂索命 已检查
							color = {r = .7, g = .7, b = .7},
							points = {"TOPLEFT", frame, "TOPLEFT", 0, -60}, 
							text = L["推波"],
							count = true,
						},
						[353417] = { -- 劈裂 已检查
							color = {r = .5, g = .5, b = .6},
							points = {"TOPLEFT", frame, "TOPLEFT", 0, -60}, 
							text = L["躲开"],
							count = false,
						},
						[353418] = { -- 劈裂 已检查
							color = {r = .5, g = .5, b = .6},
							points = {"TOPLEFT", frame, "TOPLEFT", 0, -60}, 
							text = L["躲开"],
							count = false,
						},		
						[355540] = { -- 毁灭 已检查
							color = {r = 1, g = 0, b = 0},
							points = {"TOPLEFT", frame, "TOPLEFT", 0, -60}, 
							text = L["打断"],
							count = true,
						},
						[354147] = { -- 破城箭 已检查
							color = {r = .3, g = .3, b = .3},
							points = {"TOPLEFT", frame, "TOPLEFT", 0, -60}, 
							text = L["跳台子"],
							count = true,
						},
						[351353] = { -- 召唤宝珠
							color = {r = .7, g = 0, b = .7},
							points = {"TOPLEFT", frame, "TOPLEFT", 0, -90}, 
							text = L["召唤宝珠"],
							count = true,
						},
						[356021] = { -- 黑暗交融
							color = {r = .7, g = 0, b = .7},
							points = {"TOPLEFT", frame, "TOPLEFT", 0, -90}, 
							text = L["召唤宝珠"],
							count = true,
						},
						[351589] = { -- 污秽
							color = {r = .3, g = .3, b = .3},
							points = {"TOPLEFT", frame, "TOPLEFT", 0, -90}, 
							text = L["躲开巨像正面"],
							count = true,
						},
					}
					frame.bars = {}
					
					frame.CreateBar = function(spellID, r, g, b, ...)
						local spell_name, _, icon, cast_time = GetSpellInfo(spellID)
						
						local bar = T.CreateTimerBar(frame, icon, false, false, true, 350, 28, 20, r, g, b)
						bar.ind = 0
						bar.dur = cast_time/1000
						bar:SetPoint(...)	
						bar:SetMinMaxValues(0, bar.dur)
						
						frame.bars[spellID] = bar
					end
					
					for k, v in pairs(frame.spellIDs) do
						frame.CreateBar(k, v.color.r, v.color.g, v.color.b, unpack(v.points))
					end
				end,
				update = function(frame, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then
						local timestamp, sub_event, _, sourceGUID, sourceName, _, _, _, destName, _, _, spellID, spellName = CombatLogGetCurrentEventInfo()
						if sub_event == "SPELL_CAST_START" and frame.spellIDs[spellID] then -- 开始
							local bar = frame.bars[spellID]
							bar.ind = bar.ind + 1
							if frame.spellIDs[spellID]["count"] then
								bar.left:SetText(string.format(frame.spellIDs[spellID]["text"], bar.ind))	
							else
								bar.left:SetText(frame.spellIDs[spellID]["text"])
							end
							
							bar.exp = GetTime() + bar.dur			
							bar:SetScript("OnUpdate", function(self, e)
								self.t = self.t + e
								if self.t > self.update_rate then
									local remain = self.exp - GetTime()
									if remain > 0 then		
										self.right:SetText(T.FormatTime(remain))
										self:SetValue(bar.dur - remain)
									else
										self.right:SetText("")	
										self:Hide()
										self:SetValue(0)
										self:SetScript("OnUpdate", nil)
									end
									self.t = 0
								end
							end)
							bar:Show()
						elseif sub_event == "SPELL_CAST_FAILED" and frame.spellIDs[spellID] then -- 中断
							local bar = frame.bars[spellID]
							bar.right:SetText("")	
							bar:Hide()
							bar:SetValue(0)
							bar:SetScript("OnUpdate", nil)
						end
					elseif event == "ENCOUNTER_START" then
						for k, bar in pairs(frame.bars) do
							bar.ind = 0
						end
					end
				end,
				reset = function(frame)
					for k, bar in pairs(frame.bars) do
						bar.right:SetText("")
						bar.ind = 0
						bar:Hide()
						bar:SetValue(0)
						bar:SetScript("OnUpdate", nil)	
					end
					frame:Hide()					
				end,
			},
			{ -- 无情 已检查
				spellID = 358588,
				tip = L["TIP无情"],
				points = {a1 = "BOTTOM", a2 = "CENTER", x = 0, y = 350, width = 400, height = 40},				
				events = {
					["COMBAT_LOG_EVENT_UNFILTERED"] = true,
				},
				difficulty_id = {
					[16] = true,
				},
				init = function(frame)
					frame.spellID = 358588
					frame.spellID2 = 354147
					frame.spellName, _, frame.iconTexture = GetSpellInfo(frame.spellID)
										
					local bar = T.CreateTimerBar(frame, frame.iconTexture, true, true, true, 400, 40, 25, .7,.7,.7)					
					bar:SetPoint("TOPLEFT", frame, "TOPLEFT")
					bar.glow:SetBackdropColor(1, 0, 0, 0.3)
					bar.glow:SetBackdropBorderColor(1, 0, 0)
					bar:SetMinMaxValues(0, 3.5)	

					frame.bar = bar
					
					frame.casts = {3, 2, 3, 3, 2, 2, 3, 3, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4} -- 每次攻击的台子
					frame.count = 1
					frame.platform = 1
					frame.last = 0
				end,
				update = function(frame, event, ...)
					if event == "COMBAT_LOG_EVENT_UNFILTERED" then
						local _, Event_type, _, _, _, _, _, DestGUID, destName, _, destRaidFlags, spellID = CombatLogGetCurrentEventInfo()
						if Event_type == "SPELL_CAST_SUCCESS" and spellID == frame.spellID and frame.casts[frame.count] then
							
							if GetTime() > frame.last+3 then -- 重新开始一轮
								frame.num = 0 -- 数量重置
							end
							
							frame.num = frame.num + 1 -- 数量加1
							frame.last = GetTime()
							
							local diff = frame.casts[frame.count]-frame.platform
							if diff == 0 or diff == 1 then 
							
								if diff == 0 then -- 本台子
									frame.bar.left:SetText(L["当前台子"])
									frame.bar.mid:SetText(string.format(L["圈数"], "FF0000", frame.num))	
								else -- 相邻的台子
									frame.bar.left:SetText(L["下个台子"])
									frame.bar.mid:SetText(string.format(L["圈数"], "D3D3D3", frame.num))
								end
								
								frame.bar.exp = GetTime() + 3.5
								frame.bar:SetScript("OnUpdate", function(self, e)
									self.t = self.t + e
									if self.t > self.update_rate then
										local remain = self.exp - GetTime()
										if remain > 0 then
											self:SetValue(3.5 - remain)
											self.right:SetText(T.FormatTime(remain))
											if diff == 0 then -- 本台子
												self.glow:SetAlpha(self.anim:GetProgress())
											end	
										else
											self.left:SetText("")
											self.mid:SetText("")
											self:Hide()	
											self:SetScript("OnUpdate", nil)
											self.anim:Stop()
											self.glow:Hide()
										end
										self.t = 0
									end
								end)
								
								if diff == 0 then -- 本台子
									frame.bar.glow:Show()
									frame.bar.anim:Play()
								end
								
								frame.bar:Show()						
							end
							frame.count = frame.count+1	
						elseif Event_type == "SPELL_CAST_SUCCESS" and spellID == frame.spellID2 then -- 破城箭
							frame.platform = frame.platform + 1
						end	
					elseif event == "ENCOUNTER_START" then
						frame.count = 1
						frame.platform = 1
					end
				end,
				reset = function(frame)
					frame.bar.left:SetText("")
					frame.bar.mid:SetText("")
					frame.bar:Hide()
					frame.bar:SetScript("OnUpdate", nil)
					frame.bar.anim:Stop()
					frame.bar.glow:Hide()
					T.GlowRaidFrame_HideAll()
					frame:Hide()
				end,
			},
		},
	},
}

G.Encounters["trash1861"] = { -- 小怪
	map_id = 2450,
	img = "Interface\\EncounterJournal\\UI-EJ-BOSS-Default",
	alerts = {
	},
}