﻿local T, C, L, G = unpack(select(2, ...))

if G.Client ~= "zhCN" then return end

L["TANK_ICON"]				  = "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:20:20:0:0:255:66:6:24:3:27|t" -- NO TRANSLATE
L["DAMAGE_ICON"]			  = "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:20:20:0:0:255:66:40:55:5:27|t" -- NO TRANSLATE
L["HEALER_ICON"]			  = "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:20:20:0:0:255:66:71:87:5:25|t" -- NO TRANSLATE

L["TANK_ICON_SMALL"]		  = "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:15:15:0:3:255:66:6:24:3:27|t" -- NO TRANSLATE
L["DAMAGE_ICON_SMALL"]		  = "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:15:15:0:3:255:66:40:55:5:27|t" -- NO TRANSLATE
L["HEALER_ICON_SMALL"]		  = "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:15:15:0:3:255:66:71:87:5:25|t" -- NO TRANSLATE

L["过期"]					  = [[|cFFFFFF00[|r%s|cFFFFFF00]|r
你的版本%s|cFFFFFF00(%s)|r已过期，
请下载最新版本%s|cFFFFFF00(%s)|r。]]
L["早期版本"]				  = "早期版本"
L["更新"]					  = "更新"
L["复制"]					  = "Ctrl + c / Ctrl + v 复制下载地址"
L["无法导入"]				  = "错误的字符，无法导入。"
L["导入确认"]				  = "你想要导入所有的%s设置吗？\n"
L["版本不符合"] 			  = "\n版本%s（当前版本%s）"
L["不完整导入"] 			  = "\n导入可能不完整。"
L["导出"]					  = "导出"
L["导入"]					  = "导入"
L["通用"]					  = "通用"
L["启用所有"]				  = "启用所有"
L["禁用所有"]                 = "禁用所有" 
L["禁用团队标记"]			  = "禁用团队标记"
L["隐藏小地图图标"]			  = "隐藏小地图图标"
L["职责启用"]                 = "按职责启用" 
L["锚点"]                     = "锚点"
L["锚点框体"] 				  = "锚点框体"
L["选中的框体"]               = "选中的框体"
L["进入战斗锁定"]             = "进入战斗锁定"
L["重置位置"]                 = "重置位置"
L["重置位置确认"] 			  = "你想要重置所有框体的位置吗？"
L["重置所有设置"]             = "重置所有设置"
L["重置所有设置确认"] 		  = "你想要重置所有设置吗？"
L["解锁框体"]				  = "解锁框体"
L["锁定框体"]				  = "锁定框体"
L["中间"] 		     		  = "中间"
L["左"] 		     		  = "左"
L["右"] 		     		  = "右"
L["上"] 		     		  = "上"
L["下"] 		     		  = "下"
L["左上"] 		     		  = "左上"
L["右上"] 		     		  = "右上"
L["左下"] 		     		  = "左下"
L["右下"] 		     		  = "右下"
L["测试"]					  = "测试"
L["禁用插件"]				  = "禁用插件"
L["制作"]					  = "制作"
L["制作文本"]				  = G.addon_name.."\n\n编写by 泡泡"
L["汪汪"] 				      = "汪汪！"
L["小工具"]					  = "小工具"
L["团队标记提示"]		 	  = "获得标记时提示"
L["播放语音"]				  = "播放语音"
L["焦点传送门可交互提示"]	  = "可与传送门焦点互动提示"
L["未设焦点"]			 	  = "未设焦点"
L["动态战术板"]				  = "动态战术板"
L["时间轴"]					  = "时间轴"
L["战斗结束"]				  = "战斗结束"
L["来源"]					  = "战术板类别"
L["个人战术板"]				  = "个人战术板"
L["团队战术板"]				  = "团队战术板"
L["显示战术板时间"]			  = "显示战术板时间"
L["显示倒数时间"]			  = "显示倒数时间"
L["提前时间"]				  = "提前时间"
L["持续时间"]				  = "持续时间"
L["图标提示"]				  = "图标提示"
L["显示法术名字"]			  = "显示法术名字"
L["图标大小"] 				  = "图标大小"
L["图标间距"]				  = "图标间距"
L["排列方向"]                 = "排列方向"
L["字体大小"]				  = "字体大小"
L["变更字体大小"]			  = "变更字体大小"
L["大字体大小"]				  = "大字体大小"
L["小字体大小"]				  = "小字体大小"
L["启用"] 					  = "启用"
L["团队高亮图标"]			  = "团队框架图标"
L["显示高亮图标施法"]		  = "为%s施放显示团队框架图标(%s)"
L["显示高亮图标光环"]         = "为%s光环显示团队框架图标(%s)"
L["显示高亮图标光环层数"]	  = "为%s光环显示团队框架图标(%s)|cFFFFFF00(%d层后框架高亮)|r"
L["高亮"] 					  = "高亮"
L["普通"] 					  = "普通"
L["图标透明度"] 			  = "图标透明度"
L["喊话提示"]                 = "喊话提示"
L["添加喊话光环"]             = "为%s添加喊话（光环点我）"
L["添加喊话堆叠"]             = "为%s添加喊话（光环叠层）"
L["添加喊话读条"]        	  = "为%s添加喊话（对我读条）"
L["添加喊话密语"]             = "为%s添加喊话（技能点我）"
L["添加倒数喊话"]             = "为%s添加倒数喊话"
L["添加持续喊话"]             = "为%s添加持续喊话"
L["添加距离过近喊话"] 		  = "为%s添加距离过近的喊话"
L["添加距离过近喊话DBM"] 	  = "为%s添加距离过近的喊话(DBM)"
L["添加距离过近喊话BW"] 	  = "为%s添加距离过近的喊话(Bigwigs)"
L["添加距离过近喊话DBMBW"] 	  = "为%s添加距离过近的喊话(DBM Bigwigs)"
L["姓名板图标"]				  = "姓名板图标"
L["垂直距离"]			      = "垂直距离"
L["姓名板边框动画"]			  = "及动画边框"
L["显示姓名板图标施法"]       = "为%s的%s显示姓名板施法图标%s"
L["显示姓名板图标光环"]       = "为%s显示姓名板光环图标%s"
L["显示姓名板能量图标"]       = "为%s显示姓名板能量图标"
L["显示来源图标"]    		  = "为%s标注来源"
L["显示姓名板动画边框"]		  = "为|cFFFFFF00%s|r显示姓名板动画边框"
L["文字提示"]			      = "文字提示"
L["点你"]					  = "点你 %s"
L["显示图标提示"]             = "为%s显示图标"
L["点我时显示图标提示"]		  = "为%s显示图标(目标是我)"
L["显示图标提示光环"]		  = "为%s显示图标(光环)"
L["显示图标提示多人光环"]	  = "为%s显示图标(多人光环)"
L["显示图标提示施法"]		  = "为%s显示图标(施法)"
L["显示图标提示DBM"]		  = "为%s显示图标(DBM)"
L["显示图标提示BW"]			  = "为%s显示图标(Bigwigs)"
L["显示图标提示DBMBW"]		  = "为%s显示图标(DBM Bigwigs)"
L["显示模块"]				  = "%s首领模块"
L["尺寸"]					  = "尺寸"
L["杂兵"]					  = "杂兵"
L["阶段转换"]				  = "阶段转换 %%.1f/%d"
L["提示血量"]				  = "提示%s血量"
L["提示能量"]				  = "提示%s能量"
L["音效提示"]				  = "音效提示"
L["获得光环音效"]			  = "为%s获得光环添加音效提示"
L["移除光环音效"]			  = "为%s移除光环添加音效提示"
L["层数增加音效"]			  = "为%s层数增加添加音效提示"
L["开始施法音效"]			  = "为%s开始施法添加音效提示"
L["施法成功音效"]			  = "为%s施法成功添加音效提示"
L["开始引导音效"]			  = "为%s开始引导添加音效提示"
L["法术预报音效DBM"]		  = "为%s添加法术预报音效(DBM)"
L["法术预报音效BW"]			  = "为%s添加法术预报音效(Bigwigs)"
L["法术预报音效DBMBW"]		  = "为%s添加法术预报音效(DBM Bigwigs)"
L["添加文本"]				  = "为%s添加文本提示"
L["首领模块"]				  = "首领模块"
L["召唤音效"]				  = "为%s添加召唤音效"
L["距离过近"]				  = "过近"
L["距离过近三人"]			  = "过近：%s %s %s等%d人"
L["距离过近人数"]			  = "过近[%d]人"
L["加载失败"]				  = "NPC%s的名字加载失败，请重载插件。"

--[[ 1 ]]--

L["TIP捕食者之嚎"]			  = "自动分配治疗驱散debuff，并标记在团队框架上。"

L["TIP贪噬迷雾读条计数"]	  = "贪噬迷雾计时条"

L["即将迷雾"]			      = "即将迷雾 %d/100"
 
--[[ 2 ]]--

L["TIP垂死苦难"]			  = "对比两个寻亡之眼的血量，提示血量差值。"
L["领先"]					  = "|cFF00FF00领先%.f%%|r"
L["落后"]					  = "|cFFFF0000落后%.f%%|r"

L["TIP轻蔑与忿怒"]			  = "当你过于靠近相斥DEBUFF的队友时提示危险。"
L["debuff距离过近"]			  = " 等%d人"

L["TIP毁灭凝视"]			  = "毁灭凝视计时条"

L["即将射线"]			      = "即将射线 %d/100"

--[[ 3 ]]--

L["TIP命运残片"]			  = "对于带中命运残片的人，在自己被驱散后语音提示快走开。\n对于治疗，按剩余debuff情况指示驱散。语音播报驱散顺序，并在团队框架高亮建议驱散的对象。\n1+1+1+1层，提示驱散一，4人全亮；\n2+1+1层，提示驱散二，1层的2人亮；\n2+2/1+3层，提示驱散三，2人全亮。"

L["TIP斯凯亚"]			  	  = "对比基拉和席格妮的血量，提示血量差值。"

L["TIP召回咒文"]			  = "BOSS施放特殊技能后进行记录，用以预测召回咒文时的技能组合。"
L["boss177171"]				  = "|cff00BFFF躲开射线|r"
L["boss177099"]				  = "|cff9370DB被点出去|r"
L["boss177097"]				  = "|cffFFA500护盾|r"
L["boss177222"]				  = "|cffFFFF00接圈|r"
L["boss177101"]				  = "|cffFF00FF分散|r"
L["boss177098"]				  = "|cff00FFFF分担|r"
L["已放技能"]				  = "本轮已放技能："

L["即将召唤"]				  = "即将召唤瓦格里 %d/100"

--[[ 4 ]]--

L["TIP怨毒"]				  = "显示中怨毒的人技能冷却情况，并按技能冷却时间长短排序，需要被点名的人安装插件才能生效。\n恶魔猎手（滑翔）\n德鲁伊（野性冲锋）\n猎人（逃脱）\n战士（英勇飞跃）\n盗贼（暗影步/抓钩）\n术士（恶魔法阵：传送）\n死亡骑士（死亡脚步）\n武僧（魂体双分：转移）\n法师（操控时间）"
L["技能冷却未知"]			  = "|cFFFFFF00--|r"
L["就绪"]					  = "|cFF00FF00就绪|r"
L["无技能"]					  = "|cFFFF0000无位移技能|r"
L["胸甲"]					  = "胸甲"

L["TIP怨恨"]				  = "显示怨恨(15秒一次的白圈)的倒计时及剩余5秒语音提示。"
L["下一次怨恨"]				  = "第%s轮怨恨：%s"

L["TIP群体驱散读条"]	      = "显示群体驱散的读条及施放者名字。"
L["施法中断"]				  = "|cFFFF0000施法中断|r"

L["准备苦难"]				  = "准备苦难，转宝珠 %d/100"

--[[ 5 ]]--

L["TIP好战者枷锁"]			  = [[根据Exrt战术板提示下一轮拉断锁链的人，并在轮到自己时特别提示。可在拉锁链的三个人后面加上本轮需要放的技能。Exrt战术板示例：
锁链顺序
1 |cffcc6819张三|r  |cff2133dd张三|r  |cffb2050f张三|r  技能:|cff2133dd张三|r{spell:31821}|cff2133dd张三|r{spell:62618}|cff2133dd张三|r{spell:97462}
2 |cffffffff张三|r  |cffffffff张三|r  |cffc18ef2张三|r  技能:|cff2133dd张三|r{spell:64901}|cff2133dd张三|r{spell:15286}|cff2133dd张三|r{spell:196718}
3 |cffcc6819张三|r  |cffffffff张三|r  |cffff9b00张三|r 	技能:|cff2133dd张三|r{spell:31821}|cff2133dd张三|r{spell:62618}|cff2133dd张三|r{spell:97462}
4 |cff26efef张三|r  |cff1c9b05张三|r  |cffb2050f张三|r 	技能:|cff2133dd张三|r{spell:64901}|cff2133dd张三|r{spell:15286}|cff2133dd张三|r{spell:196718}
end]]
L["下一轮锁链"]				  = "锁链|cFF00FFFF[%d]|r |cFFFFFF00[左]|r%s |cFFFFFF00[中]|r%s |cFFFFFF00[右]|r%s"
L["锁链顺序"]				  = "锁链顺序"
L["去拉锁链"]				  = "去拉 |cffFF0000[%s]|r 锁链"

L["TIP折磨"]				  = "显示折磨及折磨喷发计时条"

L["TIP刑罚者"]				  = "给渊誓刑罚者上标记，使用标记|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_1:0|t|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_2:0|t|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_3:0|t|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_4:0|t"

L["TIP折磨烙印"]			  = "中了折磨烙印喊话轮数，折磨喷发后重置为1。"
L["折磨烙印喊话"]			  = "烙印 [%s] %s"

L["TIP碎裂之魂"]              = "灵魂碎裂白圈出伤计时条。"
L["躲白圈"]					  = "白圈 [%d]"

L["即将折磨喷发"]			  = "即将折磨喷发 %d/100"

--[[ 6 ]]--

L["TIP烈焰套索陷阱"]		  = [[显示烈焰套索陷阱数量及本轮应对减伤技能。Exrt战术板示例：
陷阱顺序
|cff2133dd张三|r{spell:31821}|cff2133dd张三|r{spell:62618}|cff2133dd张三|r{spell:97462}
|cff2133dd张三|r{spell:64901}|cff2133dd张三|r{spell:15286}|cff2133dd张三|r{spell:196718}
|cff2133dd张三|r{spell:31821}|cff2133dd张三|r{spell:62618}|cff2133dd张三|r{spell:97462}
|cff2133dd张三|r{spell:64901}|cff2133dd张三|r{spell:15286}|cff2133dd张三|r{spell:196718}
end]]
L["陷阱数量"]				  = "|cffFFFF00[第%d轮]|r陷阱数量: |cff%s[%d]|r"
L["陷阱顺序"]				  = "陷阱顺序"

L["TIP尖刺"]				  = "尖刺提示，带语音"

L["TIP熔炉烈焰"]		      = "显示熔炉烈焰出圈的计时条"

--[[ 7 ]]--

L["TIP净除威胁"]		      = "监控净除威胁点名的三个人并提示他们需要去的光柱，以便迅速就位，避免互炸。\n能量核心1 左|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_1:0|t 右|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_2:0|t。\n能量核心2 左|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_3:0|t 右|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_4:0|t。\n能量核心3 左|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_5:0|t 右|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_6:0|t。"
L["离开人群"]				  = "离开人群"

L["TIP能量核心能量"]		  = "监控能量核心的能量。"

L["TIP湮灭"]				  = [[根据Exrt战术板提示下一轮分担湮灭的人，并在轮到自己时特别提示。Exrt战术板示例：
湮灭分担顺序
第一组 |cff2133dd张三|r  |cffffffff张三|r  |cff26efef张三|r  |cffff9b00张三|r  |cffb2050f张三|r 
第二组 |cffc18ef2张三|r  |cff26efef张三|r  |cff2133dd张三|r  |cffc18ef2张三|r  |cffffffff张三|r 
end]]
L["湮灭分担顺序"]			  = "湮灭分担顺序"
L["分担伤害"]				  = "|cffFF0000分担伤害|r"
L["下一轮湮灭"]				  = "下一轮湮灭 "

L["TIP湮灭计时条"] 			  = "显示湮灭 破甲 分解 熔毁的计时条。"
L["湮灭"]					  = "分担"
L["破甲"]                     = "破甲"
L["分解"]                     = "躲开正面"
L["熔毁"]                     = "AE"

L["TIP净化协议减伤安排"]	  = [[根据Exrt战术板提示下一组净化协议的减伤安排。Exrt战术板示例：
净化协议减伤顺序
1 |cffcc6819张三|r{spell:31821}|cff2133dd张三|r{spell:62618}|cffb2050f张三|r{spell:97462}
2 |cffffffff张三|r{spell:196718}|cffffffff张三|r{spell:15286}|cffc18ef2张三|r{spell:64901}
3 |cffcc6819张三|r{spell:31821}|cffffffff张三|r{spell:62618}|cffff9b00张三|r{spell:97462}
end]]
L["净化协议减伤顺序"]		  = "净化协议减伤顺序"

L["TIP净化协议读条计数"]	  = "显示净化协议的读条并计数，每一轮到第三次施法开始以后高亮。"

L["能量核心"]				  = "能量核心"
L["BOSS能量"]				  = "BOSS能量 %d/0"
--[[ 8 ]]--

L["TIP符文亲和"] 			  = "监测中符文亲和的人，根据团队顺序依次安排6人到1~6环（剩余人员待命），\n并提供一个【逆时针，需要加人】的按钮，点击按钮即分配其他待命人员之一到此环进行帮助。\n显示每一环的分配情况，并对自己的状态（去N环/待命/帮助N环）特别提示。\n1~6环的对应光柱标记依次为|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_1:0|t|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_2:0|t|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_3:0|t|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_4:0|t|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_5:0|t|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_6:0|t"
L["逆时针"]		 			  = "逆时针，需要加人"
L["准备"]		 			  = "准备……"
L["帮忙"]		 			  = "帮助%s"
L["剩余时间"]				  = "剩余时间"

L["TIP随演命运"]			  = "判定P3随演命运的环序号，H点需要转动的两环，M点无需转动的两环。（团队里仅需1人点即可，多人启用本功能时采用最先点出的状态。）"

L["TIP绝望距离检查"]		  = "监视转阶段大怪的绝望读条，在史诗难度下提示安全距离（25码）。"
L["绝望距离安全"]			  = "|cff00FF00安全|r"
L["绝望距离过近"]			  = "|cffFF0000危险|r"

L["TIP宿命联结"]              = "显示宿命联结的读条及出伤倒计时。"
L["连线出现"]				  = "连线出现(%d)"
L["连线生效"]                 = "连线生效(%d)"

L["TIP扭曲命运减伤安排"]      = [[根据Exrt战术板提示下一次扭曲命运的减伤安排。Exrt战术板示例：
扭曲命运减伤顺序
1 |cffcc6819张三|r{spell:31821}|cff2133dd张三|r{spell:62618}|cffb2050f张三|r{spell:97462}
2 |cffffffff张三|r{spell:196718}|cffffffff张三|r{spell:15286}|cffc18ef2张三|r{spell:64901}
3 |cffcc6819张三|r{spell:31821}|cffffffff张三|r{spell:62618}|cffff9b00张三|r{spell:97462}
end]]
L["扭曲命运减伤顺序"]		  = "扭曲命运减伤顺序"

--[[ 9 ]]--

L["TIP不死"]				  = "转阶段的各种提示：阶段计时，小怪复活计时，护命匣血量。"

L["TIP灵魂碎裂"]		 	  = "给灵魂碎裂的小怪上标记，使用标记|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_1:0|t|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_2:0|t|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_3:0|t|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_4:0|t|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_5:0|t"

L["TIP劫魂者标记"]			  = "给劫魂者上标记，使用标记|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_6:0|t|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_7:0|t|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_8:0|t"

L["TIP冰川尖刺"]			  = "冰川尖刺的血量列表，在冰刺低血量时特别提示。"
L["冰刺低血量"]				  = "冰刺低血量！"

L["TIP冻结冲击计时条"]        = "在内场时，添加腐溃之风 冻结冲击 冰川之风 亡灵之怒的计时条和语音提示。"
L["腐溃之风"]		 		  = "推人"
L["冻结冲击"]		 		  = "躲开正面"
L["冰川之风"]		 		  = "躲开龙卷风"
L["亡灵之怒"]		 		  = "离开内场"

L["注意仇恨"]                 = "注意仇恨"
L["击杀大怪"]				  = "击杀大怪"

--[[ 10 ]]--

L["TIP倒刺之箭"]			  = "全团倒刺之箭层数监视(仅显示大于等于2层的)"

L["TIP统御锁链"]			  = "在普通和英雄难度下统御锁链读条时身上倒刺之箭debuff层数大于2层则喊话提示。在史诗难度下每轮统御锁链按倒刺之箭层数安排最多8个人（无悲哀debuff），并将这些人分到左右两侧。为联结自己的锁链显示姓名板动画边框。"

L["TIP女妖的灾厄"]			  = "全团女妖的灾厄层数监视"

L["TIP女妖之怒"]			  = "女妖之怒计时条，在女妖之怒读条时高亮团队框架上有灾厄的目标（红色）。"

L["TIP黑暗帷幕"]			  = "团队框架中队友的治疗吸收量大于4万时边框发光提示（紫色）。"

L["TIP黑暗帷幕读条计数"]	  = "显示黑暗帷幕的读条并计数。"

L["TIP哀痛箭"]				  = "哀恸箭/黑蚀箭点名列表显示及自身被点文字提示，每一箭的倒数。"
L["你被点"]					  = "你的|cff9370DB[%s]|r|cffFF0000[%d]|r %.1fs"
L["等待伤害"]				  = "|cff9370DB等箭飞到！|r"
L["已炸"]					  = "已炸"

L["TIP女妖尖啸"]			  = "显示女妖哀嚎/女妖尖啸的读条。"

L["TIP死亡飞刀"]              = "死亡飞刀点名列表及自身被点文字提示，语音倒数。"

L["TIP造桥"]				  = "显示大地召唤 引导寒冰 妖魂索命 传送奥利波斯 劈裂 女妖哀嚎 召唤宝珠 污秽 女妖尖啸 毁灭 破城箭的计时条。"
L["造桥"]					  = "造桥 [%d]"
L["女妖哀嚎"]				  = "6码分散 [%d]"
L["女妖尖啸"]			 	  = "7码分散 [%d]"
L["传送"]					  = "传送"
L["推波"]					  = "推波 [%d]"
L["躲开"]					  = "躲开"
L["打断"]					  = "打断BOSS [%d]"
L["跳台子"]					  = "换台子 [%d]"
L["躲开巨像正面"]			  = "躲开巨像正面"
L["召唤宝珠"]	              = "召唤宝珠"

L["TIP无情"]				  = "显示落点在当前台子及下个台子的接圈计时条。"
L["当前台子"]				  = "|cffFF0000当前台子|r"
L["下个台子"]				  = "|cffD3D3D3下个台子|r"
L["圈数"]					  = "|cff%s[ %d 圈 ]|r"

L["即将黑暗帷幕"]			  = "即将黑暗帷幕 %d/100"
L["小心脚下"]			      = "小心脚下"
L["目标免疫"]			      = "目标伤害免疫"
L["召唤宝珠"]				  = "召唤宝珠"
L["打断恐惧宝珠"]			  = "打断恐惧宝珠"
L["点名白圈"]				  = "点名白圈"