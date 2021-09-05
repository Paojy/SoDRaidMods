local T, C, L, G = unpack(select(2, ...))

--if G.Client ~= "enUS" then return end

L["TANK_ICON"]				  = "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:20:20:0:0:255:66:6:24:3:27|t" -- NO TRANSLATE
L["DAMAGE_ICON"]			  = "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:20:20:0:0:255:66:40:55:5:27|t" -- NO TRANSLATE
L["HEALER_ICON"]			  = "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:20:20:0:0:255:66:71:87:5:25|t" -- NO TRANSLATE

L["TANK_ICON_SMALL"]		  = "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:15:15:0:3:255:66:6:24:3:27|t" -- NO TRANSLATE
L["DAMAGE_ICON_SMALL"]		  = "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:15:15:0:3:255:66:40:55:5:27|t" -- NO TRANSLATE
L["HEALER_ICON_SMALL"]		  = "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:15:15:0:3:255:66:71:87:5:25|t" -- NO TRANSLATE

L["缩写名字"]				  = "Abbreviated name"
L["缩写时名字长度"]			  = "Maximum length of name when abbreviated"
L["过期"]					  = [[|cFFFFFF00[|r%s|cFFFFFF00]|r
Your version %s|cFFFFFF00(%s)|r is outdate,
please download newest version %s|cFFFFFF00(%s)|r.]]
L["早期版本"]				  = "Early version"
L["更新"]					  = "Update"
L["通用"]					  = "General"
L["无法导入"]				  = "Cannot Import"
L["导入确认"]				  = "Do you want to import all the %s settings?\n"
L["版本不符合"] 			  = "\nImport Version %s（Current Version %s）"
L["不完整导入"] 			  = "\nMay not import completely."
L["导出"]					  = "Export"
L["导入"]					  = "Import"
L["复制"]					  = "Use Ctrl + c / Ctrl + v Copy download URL"
L["启用所有"]				  = "Enable all"
L["禁用所有"]                 = "Disable all"
L["禁用团队标记"]			  = "Disable raid mark"
L["隐藏小地图图标"]			  = "Hide minimap button"
L["职责启用"]                 = "Enable as role"
L["锚点"]                     = "Anchor"
L["锚点框体"] 				  = "Anchor frame"
L["选中的框体"]               = "Focused frame"
L["进入战斗锁定"]             = "Locked when in combat"
L["重置位置"]                 = "Reset position"
L["重置位置确认"] 			  = "Do you want to reset all frame position?"
L["重置所有设置"]             = "Reset all settings"
L["重置所有设置确认"] 		  = "Do you want to reset all settings?"
L["解锁框体"]				  = "Unlock frames"
L["锁定框体"]				  = "Lock frames"
L["当前首领"]				  = "Current Encounter"
L["中间"] 		     		  = "Center"
L["左"] 		     		  = "Left"
L["右"] 		     		  = "Right"
L["上"] 		     		  = "Top"
L["下"] 		     		  = "Bottom"
L["左上"] 		     		  = "TopLeft"
L["右上"] 		     		  = "TopRight"
L["左下"] 		     		  = "BottomLeft"
L["右下"] 		     		  = "BottomRight"
L["测试"]					  = "Test"
L["禁用插件"]				  = "Disable addon"
L["制作"]					  = "Made"
L["制作文本"]				  = G.addon_name.."\n\nMade by Paopaojy"
L["汪汪"] 				      = "Bow-bow！"
L["小工具"]					  = "Tools"
L["团队标记提示"]		 	  = "Announce when get marked"
L["播放语音"]				  = "Play voice announce"
L["焦点传送门可交互提示"]	  = "Demen teleport interact icon"
L["未设焦点"]			 	  = "No focus"
L["动态战术板"]				  = "Dynamic MRT notes"
L["动态战术板计时条"]		  = "Dynamic MRT notes Timer Bar"
L["显示计时条"]		 		  = "Display timing bar"
L["只显示我的计时条"]		  = "Only display the timing bar that contains me"
L["语音提示我的技能"]	      = "Voice prompt my spells"
L["查看支持的技能"]			  = "View supported skills"
L["DAMAGE"]					  = "DAMAGE"
L["TANK"]					  = "TANK"
L["INTERRUPT"]				  = "INTERRUPT"
L["STHARDCC"]				  = "STHARDCC"
L["HEALING"]				  = "HEALING"
L["RAIDCD"]					  = "RAIDCD"
L["COVENANT"]				  = "COVENANT"
L["BREZ"]					  = "BREZ"
L["SOFTCC"]					  = "SOFTCC"
L["HARDCC"]					  = "HARDCC"
L["IMMUNITY"]				  = "IMMUNITY"
L["STSOFTCC"]				  = "STSOFTCC"
L["DISPEL"]					  = "DISPEL"
L["PERSONAL"]		 		  = "PERSONAL"
L["EXTERNAL"]		 		  = "EXTERNAL"
L["UTILITY"]				  = "UTILITY"
L["计时条高度"]		          = "Timing Bar Height"
L["计时条宽度"]		          = "Timing Bar Width"
L["语音提示时间"]		      = "Voice prompt advance time"
L["我的昵称"]		    	  = "My nickname:%s"
L["无昵称"]					  = "none"
L["输入昵称"]				  = "In order to identify you in the MRT notes, enter your nickname. Please separate multiple nicknames with spaces. If there is no nickname, only the current character name will be recognized."
L["时间轴"]					  = "Timer"
L["战斗结束"]				  = "Encounter end"
L["来源"]					  = "MRT notes type"
L["个人战术板"]				  = "Personal MRT notes"
L["团队战术板"]				  = "Raid MRT notes"
L["显示战术板时间"]			  = "Show MRT Notes timer"
L["显示倒数时间"]			  = "Show countdown"
L["提前时间"]				  = "Warning time in advance"
L["持续时间"]				  = "Warning time Duration"
L["转阶段"]				 	  = "Time point of transition"
L["转阶段空"]				  = "P%d none"
L["转阶段技能"]				  = "P%d %s%s"
L["开始施法"]				  = "Start casting"
L["施法成功"]				  =	"Successfully cast"
L["获得光环"]				  = "Get aura"
L["光环消失"]				  = "Aura disappeared"
L["图标提示"]				  = "Icons"
L["显示法术名字"]			  = "Show spell name"
L["反转冷却"]		  	      = "Reverse the direction of the cooldown animation"
L["图标大小"] 				  = "Icon size"
L["图标间距"]				  = "Icon space"
L["排列方向"]                 = "Grow"
L["字体大小"]				  = "Font size"
L["变更字体大小"]			  = "Change font size"
L["大字体大小"]				  = "BigFont size"
L["小字体大小"]				  = "SmallFont size"
L["启用"] 					  = "Enable"
L["团队高亮图标"]			  = "RaidFrame icon"
L["显示高亮图标施法"]		  = "Show %s icon on RaidFrame when casting (%s)"
L["显示高亮图标光环"]         = "Show %s icon on RaidFrame when aura applied (%s)"
L["显示高亮图标光环层数"]	  = "Show %s icon on RaidFrame for aura (%s) |cFFFFFF00(Highlight after %d stack)|r"
L["高亮"] 					  = "Highlight"
L["普通"] 					  = "Normal"
L["图标透明度"] 			  = "Icon alpha"
L["喊话提示"]                 = "Say announce"
L["添加喊话光环"]             = "Say when %s (Aura applied on me)"
L["添加喊话堆叠"]             = "Say when %s (Aura stacking on me)"
L["添加喊话读条"]        	  = "Say when %s (Casting on me)"
L["添加喊话密语"]             = "Say when %s (Spell cast on me)"
L["添加倒数喊话"]             = "Add countdown as say for %s"
L["添加持续喊话"]             = "Keep say spam for %s"
L["添加距离过近喊话"] 		  = "Add too close say announce for %s"
L["添加距离过近喊话DBM"] 	  = "Add too close say announce for %s (DBM)"
L["添加距离过近喊话BW"] 	  = "Add too close say announce for %s (Bigwigs)"
L["添加距离过近喊话DBMBW"] 	  = "Add too close say announce for %s (DBM Bigwigs)"
L["姓名板图标"]				  = "Nameplate icon"
L["垂直距离"]			      = "Vertical space"
L["姓名板边框动画"]			  = "and anime glow broder"
L["显示姓名板图标施法"]       = "Show %3$s icon when casting %2$s on %1$s nameplate"
L["显示姓名板图标光环"]       = "Show %2$s aura icon on %1$s nameplate"
L["显示姓名板能量图标"]       = "Show energy icon on %s nameplate"
L["显示来源图标"]    		  = "Show %s source"
L["显示姓名板动画边框"]		  = "Show anime glow broder on nameplate for |cFFFFFF00%s|r"
L["文字提示"]			      = "Texts"
L["点你"]					  = "%s ON YOU"
L["显示图标提示"]             = "Show icon for %s"
L["点我时显示图标提示"]		  = "Show icon for %s (when aura on me)"
L["显示图标提示光环"]		  = "Show icon for %s (Aura)"
L["显示图标提示多人光环"]	  = "Show icon for %s (Multiple aura on raid)"
L["显示图标提示施法"]		  = "Show icon for %s (cast)"
L["显示图标提示DBM"]		  = "Show icon for %s (DBM)"
L["显示图标提示BW"]			  = "Show icon for %s (Bigwigs)"
L["显示图标提示DBMBW"]		  = "Show icon for %s (DBM Bigwigs)"
L["显示模块"]				  = "%s Boss Mod"
L["尺寸"]					  = "Size"
L["杂兵"]					  = "Adds"
L["阶段转换"]				  = "Phase change %%.1f/%d"
L["提示血量"]				  = "Show %s health"
L["提示能量"]				  = "Show %s energy"
L["音效提示"]				  = "Voice announce"
L["获得光环音效"]			  = "Add voice announce for %s (Aura applied)"
L["移除光环音效"]			  = "Add voice announce for %s (Aura removed)"
L["层数增加音效"]			  = "Add voice announce for %s (When stacking)"
L["开始施法音效"]			  = "Add voice announce for %s (When cast start)"
L["施法成功音效"]			  = "Add voice announce for %s (When cast succesed)"
L["开始引导音效"]			  = "Add voice announce for %s (When channeling cast start)"
L["法术预报音效DBM"]		  = "Add voice early warning for %s (DBM)"
L["法术预报音效BW"]			  = "Add voice early warning for %s (Bigwigs)"
L["法术预报音效DBMBW"]		  = "Add voice early warning for %s (DBM Bigwigs)"
L["添加文本"]				  = "Add text tip for %s"
L["首领模块"]				  = "Boss Mod"
L["召唤音效"]				  = "Add voice announce for %s summon"
L["距离过近"]				  = "TOO CLOSE!"
L["距离过近三人"]			  = "TOO CLOSE: %s %s %s...%d"
L["距离过近人数"]			  = "TOO CLOSE:[%d]"
L["加载失败"]				  = "%s NPC name load failed, please reload addons."
L["保命技能"]				  = "Defense Cooldown Alert"
L["注意自保血量"]			  = "WATCH HEALTH HP:%d%%"
L["注意自保"]				  = "WATCH HEALTH"
L["颜色随血量渐变"]			  = "Color Gradiant"
L["显示血量百分比"]			  = "Show HP Percentage"
--[[ 1 ]]--

L["TIP捕食者之嚎"]			  = "Automatically assign healer dispel debuff, and show on RaidFrames"

L["TIP贪噬迷雾读条计数"]	  = "Hungering Mist cast bar"

L["即将迷雾"]			      = "Hungering Mist Incoming %d/100"

--[[ 2 ]]--

L["TIP垂死苦难"]			  = "Compare and announce health volume gap between two Deathseeker Eye."
L["领先"]					  = "|cFF00FF00Ahead%.f%%|r"
L["落后"]					  = "|cFFFF0000Behind%.f%%|r"

L["TIP轻蔑与忿怒"]			  = "Announce DANGER when you get too closed with different debuff."
L["debuff距离过近"]			  = "...%d man"

L["TIP毁灭凝视"]			  = "Annihilating Glare castbar"

L["即将射线"]			      = "Beam Incoming %d/100"

--[[ 3 ]]--

L["TIP命运残片"]			  = "For player who gained Fragments of Destiny, announce they run away when dispel.\nFor Healer, announce dispel order by debuff stack with voice, and highlight dispel target on raidframes.\nStack: 1+1+1+1, announce first, highlight all 4 raidframes;\n Stack: 2+1+1, announce second, highlight two member who still one stack;\nStack: 2+2/1+3, announce third, highlight both."

L["TIP斯凯亚"]			  	  = "Compare and announce health volume gap between Kyra and Signe."

L["TIP召回咒文"]			  = "Show all calls used by Skyja, to know which spells will be used when Word of Recall."
L["boss177171"]				  = "|cff00BFFFBlade|r"
L["boss177099"]				  = "|cff00BFFFBomb|r"
L["boss177097"]				  = "|cffFFA500Shied|r"
L["boss177222"]				  = "|cffFFFF00Soak|r"
L["boss177101"]				  = "|cffFF00FFSpread|r"
L["boss177098"]				  = "|cff00FFFFSoak|r"
L["已放技能"]				  = "Already used: "

L["即将召唤"]				  = "Val'kyr Incoming %d/100"

--[[ 4 ]]--

L["TIP怨毒"]				  = "Show movement abilities CD for player gained Malevolence, list as CDs. This function only work when player using this addon.\nDemon Hunger: Glide\nDruid: Wild Charge\nHunter: Disengage\nWarriior: Heroic Leap\nRouge: Shadowstep, Grappling Hook\nWarlock: Demonic Circle Teleport\nDeath Knight: Death's Advance\nMonk: Transcendence\nMage: Alter Time"

L["技能冷却未知"]			  = "|cFFFFFF00--|r"
L["就绪"]					  = "|cFF00FF00Ready|r"
L["无技能"]					  = "|cFFFF0000No movement abilities|r"

L["TIP怨恨"]				  = "Show timer for Spite, and voice countdown in 5 sec."
L["下一次怨恨"]				  = "%s round Spite: %s"

L["TIP群体驱散读条"]	      = "Show castbar and caster name for Mass Dispel."
L["施法中断"]				  = "|cFFFF0000Cast Stopped|r"

L["准备苦难"]				  = "Suffering incoming, kill orb. %d/100"

--[[ 5 ]]--

L["TIP好战者枷锁"]			  = [[Show a announce for destroy Warmonger Shackles. List basic by MRT notes, announce next round, and special announce on yourself round. MRT notes example:
Shackles Order
1 |cffcc6819Tom|r  |cff2133ddTom|r  |cffb2050fTom|r	Use:|cff2133ddTom|r{spell:31821}|cff2133ddTom|r{spell:62618}|cff2133ddTom|r{spell:97462}
2 |cffffffffTom|r  |cffffffffTom|r  |cffc18ef2Tom|r Use:|cff2133ddTom|r{spell:64901}|cff2133ddTom|r{spell:15286}|cff2133ddTom|r{spell:196718}
3 |cffcc6819Tom|r  |cffffffffTom|r  |cffff9b00Tom|r Use:|cff2133ddTom|r{spell:31821}|cff2133ddTom|r{spell:62618}|cff2133ddTom|r{spell:97462}
4 |cff26efefTom|r  |cff1c9b05Tom|r  |cffb2050fTom|r Use:|cff2133ddTom|r{spell:64901}|cff2133ddTom|r{spell:15286}|cff2133ddTom|r{spell:196718}
end]]
L["下一轮锁链"]				  = "Shackles|cFF00FFFF[%d]|r |cFFFFFF00[LEFT]|r%s |cFFFFFF00[CENTER]|r%s |cFFFFFF00[RIGHT]|r%s"
L["锁链顺序"]				  = "Shackles order"
L["去拉锁链"]				  = "GO SNAP |cffFF0000[%s]|r Shackle"
L["死了"]					  = "|cffFF0000(Dead)|r"
L["已断"]					  = "|cffC0C0C0(Broken)|r"
L["在拉"]					  = "|cff00FF00(Pulling)|r"
L["烙印"]					  = "|cffFF0000(Brand)|r"

L["TIP折磨"]				  = "Show timer for Torment and Tormented Eruptions."

L["TIP刑罚者"]				  = "Mark Mawsworn Agonizer as |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_1:0|t|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_2:0|t|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_3:0|t|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_4:0|t"

L["TIP折磨烙印"]			  = "Say Brand of Torment rounds, will be reset to 1 after Tormented Eruptions."
L["折磨烙印喊话"]			  = "Brand [%s] %s"

L["TIP碎裂之魂"]              = "Rendered Soul castbar"
L["躲白圈"]					  = "Dodge [%d]"

L["即将折磨喷发"]			  = "Tormented Eruptions Incoming %d/100"

--[[ 6 ]]--

L["TIP烈焰套索陷阱"]		  = [[Show count of Flameclasp Trap and coping raid cooldown spells for every round. MRT note example:
TrapOrder
|cff2133ddTom|r{spell:31821}|cff2133ddTom|r{spell:62618}|cff2133ddTom|r{spell:97462}
|cff2133ddTom|r{spell:64901}|cff2133ddTom|r{spell:15286}|cff2133ddTom|r{spell:196718}
|cff2133ddTom|r{spell:31821}|cff2133ddTom|r{spell:62618}|cff2133ddTom|r{spell:97462}
|cff2133ddTom|r{spell:64901}|cff2133ddTom|r{spell:15286}|cff2133ddTom|r{spell:196718}
end]]
L["陷阱数量"]				  = "|cffFFFF00[%d round]|rTrap count: |cff%s[%d]|r"
L["陷阱顺序"]				  = "Flameclasp Trap order"
L["陷阱出现"]				  = "Trap Incoming"

L["TIP尖刺"]				  = "Spikes announce wich voice"

L["TIP熔炉烈焰"]		      = "Show timer for Forge's Flames"

--[[ 7 ]]--

L["TIP净除威胁"]		      = "Announce three Threat Neutralization where to go.\nEnergy core one, left|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_1:0|t right|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_2:0|t.\nEnergy core two, left|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_3:0|t right|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_4:0|t.\nEnergy core three, left|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_5:0|t right|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_6:0|t."
L["离开人群"]				  = "Run away"

L["TIP能量核心能量"]		  = "Show core's energy."

L["TIP湮灭"]				  = [[Show player list basic by MRT Notes to soak Obliterate, special announce when your round. MRT note example:
ObliterateOrder
First |cff2133ddTom|r  |cffffffffTom|r  |cff26efefTom|r  |cffff9b00Tom|r  |cffb2050fTom|r 
Second |cffc18ef2Tom|r  |cff26efefTom|r  |cff2133ddTom|r  |cffc18ef2Tom|r  |cffffffffTom|r 
end]]
L["湮灭分担顺序"]			  = "Obliterate soak order"
L["分担伤害"]				  = "|cffFF0000SOAK DAMAGE|r"
L["下一轮湮灭"]				  = "NEXT Obliterate"

L["TIP湮灭计时条"] 			  = "Show cast bar for Obliterate Sunder Disintegration Meltdown."
L["湮灭"]					  = "Share damage"
L["破甲"]                     = "Sunder"
L["分解"]                     = "Avoid the front"
L["熔毁"]                     = "AE"

L["TIP净化协议减伤安排"]	  = [[Show raid cooldown spells plan for every round Purification Protocol. MRT note example:
ProtocolOrder
1 |cffcc6819Tom|r{spell:31821}|cff2133ddTom|r{spell:62618}|cffb2050fTom|r{spell:97462}
2 |cffffffffTom|r{spell:196718}|cffffffffTom|r{spell:15286}|cffc18ef2Tom|r{spell:64901}
3 |cffcc6819Tom|r{spell:31821}|cffffffffTom|r{spell:62618}|cffff9b00Tom|r{spell:97462}
end]]
L["净化协议减伤顺序"]		  = "Protocol cooldown Order"

L["TIP净化协议读条计数"]	  = "Show Purification Protocol cast bar and count and highlight over 3rd cast every round"

L["能量核心"]				  = "Energy Core"
L["BOSS能量"]				  = "Boss Energy %d/0"

--[[ 8 ]]--

L["TIP符文亲和"] 			  = "Show Runic Affinity player list and assign 6 player to each ring, other stand by.\n Show a buttom for <Counterclockwise, Need Help>, automatically order one stand by player come to help which ring clicked buttom.\nShow assign for every ring and special order announce on yourself.\n Mark ring 1~6 as |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_1:0|t|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_2:0|t|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_3:0|t|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_4:0|t|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_5:0|t|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_6:0|t"
L["逆时针"]		 			  = "Counterclockwise, Need Help"
L["准备"]		 			  = "Prepare......"
L["帮忙"]		 			  = "Help %s"
L["剩余时间"]				  = "Time left"

L["TIP随演命运"]			  = "Check Extemporaneous Fate effect rings. Heroic mode: click 2 rings which need rotate, Mythic mode: click 2 rings which don't need rotate. Only need 1 player in raid click rings, mutiple click only effect first."

L["TIP绝望距离检查"]		  = "Show Despair cast bar and announce 25 yards safe distance in mythic."
L["绝望距离安全"]			  = "|cff00FF00SAFE|r"
L["绝望距离过近"]			  = "|cffFF0000DANGER|r"

L["TIP宿命联结"]              = "Show Fated Conjunction cast bar and damage delay countdown."
L["连线出现"]				  = "Beams Spawn (%d)"
L["连线生效"]                 = "Beams Effect (%d)"

L["TIP扭曲命运减伤安排"]      = [[Show raid cooldown spells plan for next Twist Fate. MRT note example:
TwistFateOrder
1 |cffcc6819Tom|r{spell:31821}|cff2133ddTom|r{spell:62618}|cffb2050fTom|r{spell:97462}
2 |cffffffffTom|r{spell:196718}|cffffffffTom|r{spell:15286}|cffc18ef2Tom|r{spell:64901}
3 |cffcc6819Tom|r{spell:31821}|cffffffffTom|r{spell:62618}|cffff9b00Tom|r{spell:97462}
end]]
L["扭曲命运减伤顺序"]		  = "Twist Fate cooldown order"

--[[ 9 ]]--

L["TIP不死"]				  = "Stage change announce: timer, adds respawn timer, Phylactery health."

L["TIP灵魂碎裂"]		 	  = "Mark Soul Fracture adds as|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_1:0|t|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_2:0|t|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_3:0|t|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_4:0|t|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_5:0|t"

L["TIP劫魂者标记"]			  = "给劫魂者上标记，使用标记|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_6:0|t|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_7:0|t|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_8:0|t"

L["TIP冰川尖刺"]			  = "Show all Glacial Spike health and alart when they reach low health"
L["冰刺低血量"]				  = "Spike Low HP!"

L["TIP冻结冲击计时条"]     	  = "Show cast bar with voice announce for Foul Winds, Freezing Blast, Glacial Winds and Undying Wrath within the phylactery."
L["腐溃之风"]		 		  = "Push"
L["冻结冲击"]		 		  = "Avoid the front"
L["冰川之风"]		 		  = "Avoid Winds"
L["亡灵之怒"]		 		  = "Leave"

L["注意仇恨"]                 = "Attention: threat"
L["击杀大怪"]				  = "Kill Adds"

--[[ 10 ]]--

L["TIP倒刺之箭"]			  = "List Barbed Arrow stack for raid, only show stack over 2."

L["TIP统御锁链"]			  = "Normal/Heroic mode: say announce for Barbed Arrow stack over2 when Domination Chains casting. Mythic mode: assign player by Barbed Arrow stack without Woe when Domination Chains, half left and right."

L["TIP女妖的灾厄"]			  = "Show raid Banshee's Bane stack"

L["TIP女妖之怒"]			  = "Show Banshee's Fury cast bar, highlight Banshee's Bane on raidframes when casting."

L["TIP黑暗帷幕"]			  = "Highlight raidframes if absbrob over 40k."

L["TIP黑暗帷幕读条计数"]	  = "Show Veil of Darkness cast bar and count."

L["TIP哀痛箭"]				  = "Show player list for Wailing Arrow and Black Arrow with duration, text announce and countdown for yourself."
L["你被点"]					  = "YOUR|cff9370DB[%s]|r|cffFF0000[%d]|r %.1fs"
L["等待伤害"]				  = "|cff9370DBWait for arrow!|r"
L["已炸"]					  = "DONE"

L["TIP女妖尖啸"]			  = "Show Banshee Wail and Banshee Scream cast bar"

L["TIP死亡飞刀"]              = "Shlow player list for Death Knives and text/voice announce for yourself."

L["TIP造桥"]				  = "Show cast bar for briges, teleport, waves, spread, interrupt, change platform and summon orbs."
L["造桥"]					  = "BRIDGE [%d]"
L["女妖哀嚎"]				  = "6 yards [%d]"
L["女妖尖啸"]			 	  = "7 yards [%d]"
L["传送"]					  = "Teleport"
L["推波"]					  = "RUN AWAY [%d]"
L["躲开"]					  = "Dodge"
L["打断"]					  = "Interrupt [%d]"
L["跳台子"]					  = "Change platform [%d]"
L["躲开巨像正面"]			  = "Avoid the front"
L["召唤宝珠"]	              = "Summon orb"

L["TIP无情"]				  = "Show soak timer."
L["当前台子"]				  = "|cffFF0000This platform|r"
L["下个台子"]				  = "|cffD3D3D3Next platform|r"
L["圈数"]					  = "|cff%s[ %d round ]|r"

L["即将黑暗帷幕"]			  = "INCOMING: Veil of Darkness %d/100"
L["小心脚下"]			      = "WATCH YOUR FEET"
L["目标免疫"]			      = "TARGET IMMUNE"
L["召唤宝珠"]				  = "ORB SUMMON"
L["打断恐惧宝珠"]			  = "Interrupt Terror Orb"
L["点名白圈"]				  = "Circle on me"