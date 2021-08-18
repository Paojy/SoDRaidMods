local T, C, L, G = unpack(select(2, ...))

if G.Client ~= "zhTW" then return end

L["TANK_ICON"]				  = "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:20:20:0:0:255:66:6:24:3:27|t" -- NO TRANSLATE
L["DAMAGE_ICON"]			  = "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:20:20:0:0:255:66:40:55:5:27|t" -- NO TRANSLATE
L["HEALER_ICON"]			  = "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:20:20:0:0:255:66:71:87:5:25|t" -- NO TRANSLATE

L["TANK_ICON_SMALL"]		  = "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:15:15:0:3:255:66:6:24:3:27|t" -- NO TRANSLATE
L["DAMAGE_ICON_SMALL"]		  = "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:15:15:0:3:255:66:40:55:5:27|t" -- NO TRANSLATE
L["HEALER_ICON_SMALL"]		  = "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:15:15:0:3:255:66:71:87:5:25|t" -- NO TRANSLATE

L["过期期"]					  = [[|cFFFFFF00[|r%s|cFFFFFF00]|r
你的版本%s|cFFFFFF00(%s)|r已過期，
請下載最新版本%s|cFFFFFF00(%s)|r。]]
L["早期版本"]				  = "早期版本"
L["更新"]					  = "更新"
L["通用"]					  = "通用"
L["无法导入"]				  = "錯誤的字符，無法導入。"
L["导入确认"]				  = "你想要導入所有的%s設置嗎？\n"
L["版本不符合"] 			  = "\n版本%s（當前版本%s）"
L["不完整导入"]				  = "\n導入可能不完整。"
L["导出"]					  = "導出"
L["导入"]					  = "導入"
L["复制"]					  = "Ctrl + c / Ctrl + v 複製下載網址"
L["启用所有"]				  = "啟用所有"
L["禁用所有"]                 = "禁用所有"
L["禁用团队标记"]			  = "禁用團隊標記"
L["隐藏小地图图标"]			  = "隱藏小地圖圖標"
L["职责启用"]                 = "按職責啟用"
L["锚点"]                     = "錨點"
L["锚点框体"] 				  = "錨點框體"
L["选中的框体"]               = "選中的框體"
L["进入战斗锁定"]             = "進入戰鬥鎖定"
L["重置位置"]                 = "重置位置"
L["重置位置确认"] 			  = "你想要重置所有框體的位置嗎？"
L["重置所有设置"]             = "重置所有設置"
L["重置所有设置确认"] 		  = "你想要重置所有設置嗎？"
L["解锁框体"]				  = "解鎖框體"
L["锁定框体"]				  = "鎖定框體"
L["当前首领"]				  = "當前首領"
L["中间"] 		     		  = "中間"
L["左"] 		     		  = "左"
L["右"] 		     		  = "右"
L["上"] 		     		  = "上"
L["下"] 		     		  = "下"
L["左上"] 		     		  = "左上"
L["右上"] 		     		  = "右上"
L["左下"] 		     		  = "左下"
L["右下"] 		     		  = "右下"
L["测试"]					  = "測試"
L["禁用插件"]				  = "禁用插件"
L["制作"]					  = "製作"
L["制作文本"]				  = G.addon_name.."\n\n編寫by 泡泡"
L["汪汪"] 				      = "汪汪！"
L["小工具"]					  = "小工具"
L["团队标记提示"]		 	  = "獲得標記時提示"
L["播放语音"]				  = "播放語音"
L["焦点传送门可交互提示"]	  = "可與傳送門焦點互動提示"
L["未设焦点"]			 	  = "未設焦點"
L["动态战术板"]				  = "動態戰術板"
L["动态战术板计时条"]		  = "動態戰術板計時條"
L["显示计时条"]		 		  = "顯示計時條"
L["只显示我的计时条"]		  = "只顯示包含我的計時條"
L["语音提示我的技能"]	      = "語音提示我的技能"
L["查看支持的技能"]			  = "查看支持的技能"
L["DAMAGE"]					  = "伤害"
L["TANK"]					  = "坦克"
L["INTERRUPT"]				  = "打断"
L["STHARDCC"]				  = "单体强控制"
L["HEALING"]				  = "治疗"
L["RAIDCD"]					  = "团队减伤"
L["COVENANT"]				  = "盟约"
L["BREZ"]					  = "战复"
L["SOFTCC"]					  = "群体弱控制"
L["HARDCC"]					  = "群体强控制"
L["IMMUNITY"]				  = "免疫"
L["STSOFTCC"]				  = "单体弱控制"
L["DISPEL"]					  = "驱散"
L["PERSONAL"]				  = "对自己施放的技能"
L["EXTERNAL"]				  = "对生命施放的技能"
L["UTILITY"]				  = "其他" 
L["计时条高度"]		          = "計時條高度"
L["计时条宽度"]		          = "計時條寬度"
L["语音提示时间"]		      = "語音提示提前時間"
L["我的昵称"]		    	  = "我的暱稱:%s"
L["无昵称"]					  = "无"
L["输入昵称"]				  = "为了在战术板中识别你，输入你的昵称。多个昵称请用空格隔开。没有昵称时仅识别当前角色名字。"
L["时间轴"]					  = "時間軸"
L["战斗结束"]				  = "戰鬥結束"
L["来源"]					  = "戰術板類別"
L["个人战术板"]				  = "個人戰術板"
L["团队战术板"]				  = "團隊戰術板"
L["显示战术板时间"]			  = "顯示戰術板時間"
L["显示倒数时间"]			  = "顯示倒數時間"
L["提前时间"]				  = "提前時間"
L["持续时间"]				  = "持續時間"
L["转阶段"]				 	  = "轉階段時間點"
L["转阶段空"]				  = "P%d 無"
L["转阶段技能"]				  = "P%d %s%s"
L["开始施法"]				  = "開始施法"
L["施法成功"]				  =	"施法成功"
L["获得光环"]				  = "獲得光環"
L["光环消失"]				  = "光環消失"
L["图标提示"]				  = "圖示提示"
L["显示法术名字"]			  = "顯示法術名字"
L["反转冷却"]		  	      = "反轉冷卻"
L["图标大小"] 				  = "圖示大小"
L["图标间距"]				  = "圖示間距"
L["排列方向"]                 = "排列方向"
L["字体大小"]				  = "字型大小"
L["变更字体大小"]			  = "改變字體大小"
L["大字体大小"]				  = "大字體大小"
L["小字体大小"]				  = "小字體大小"
L["启用"] 					  = "啟用"
L["团队高亮图标"]			  = "團隊框架圖示"
L["显示高亮图标施法"]		  = "為%s施放顯示團隊框架圖示(%s)"
L["显示高亮图标光环"]         = "為%s光環顯示團隊框架圖示(%s)"
L["显示高亮图标光环层数"]	  = "為%s光環顯示團隊框架圖示(%s)|cFFFFFF00（%d層後框架高亮）|r"
L["高亮"] 					  = "高亮"
L["普通"] 					  = "普通"
L["图标透明度"] 			  = "圖示透明度"
L["喊话提示"]                 = "喊話提示"
L["添加喊话光环"]             = "為%s添加喊話（光環點我）"
L["添加喊话堆叠"]             = "為%s添加喊話（光環疊層）"
L["添加喊话读条"]        	  = "為%s添加喊話（對我施法）"
L["添加喊话密语"]             = "為%s添加喊話（技能點我）"
L["添加倒数喊话"]             = "為%s添加倒數喊話"
L["添加持续喊话"]             = "為%s添加持續喊話"
L["添加距离过近喊话"] 		  = "為%s添加距離過近的喊話"
L["添加距离过近喊话DBM"] 	  = "為%s添加距離過近的喊話（DBM）"
L["添加距离过近喊话BW"] 	  = "為%s添加距離過近的喊話（Bigwigs）"
L["添加距离过近喊话DBMBW"] 	  = "為%s添加距離過近的喊話（DBM Bigwigs）"
L["姓名板图标"]				  = "名條圖示"
L["垂直距离"]			      = "垂直距離"
L["姓名板边框动画"]			  = "及動畫邊框"
L["显示姓名板图标施法"]       = "為%s的%s顯示名條施法圖示%s"
L["显示姓名板图标光环"]       = "為%s顯示名條光環圖示%s"
L["显示姓名板能量图标"]       = "為%s顯示名條能量圖示"
L["显示来源图标"]    		  = "為%s標註來源"
L["显示姓名板动画边框"]		  = "為|cFFFFFF00%s|r顯示名條動畫邊框"
L["文字提示"]			      = "文字提示"
L["点你"]					  = "點你%s"
L["显示图标提示"]             = "為%s顯示圖示"
L["点我时显示图标提示"]		  = "為%s顯示圖示（目標是我）"
L["显示图标提示光环"]		  = "為%s顯示圖示（光環）"
L["显示图标提示多人光环"]	  = "為%s顯示圖示（多人光環）"
L["显示图标提示施法"]		  = "為%s顯示圖示（施法）"
L["显示图标提示DBM"]		  = "為%s顯示圖示（DBM）"
L["显示图标提示BW"]			  = "為%s顯示圖示（Bigwigs）"
L["显示图标提示DBMBW"]		  = "為%s顯示圖示（DBM Bigwigs）"
L["显示模块"]				  = "%s首領模組"
L["尺寸"]					  = "尺寸"
L["杂兵"]					  = "雜兵"
L["阶段转换"]				  = "階段轉換 %%.1f/%d"
L["提示血量"]				  = "提示%s血量"
L["提示能量"]				  = "提示%s能量"
L["音效提示"]				  = "音效提示"
L["获得光环音效"]			  = "為%s獲得光環添加音效提示"
L["移除光环音效"]			  = "為%s移除光環添加音效提示"
L["层数增加音效"]			  = "為%s層數增加添加音效提示"
L["开始施法音效"]			  = "為%s開始施法添加音效提示"
L["施法成功音效"]			  = "為%s施法成功添加音效提示"
L["开始引导音效"]			  = "為%s開始引導添加音效提示"
L["法术预报音效DBM"]		  = "為%s添加法術預報音效(DBM)"
L["法术预报音效BW"]			  = "為%s添加法術預報音效(Bigwigs)"
L["法术预报音效DBMBW"]		  = "為%s添加法術預報音效(DBM Bigwigs)"
L["添加文本"]				  = "為%s添加文本提示"
L["首领模块"]				  = "首領模組"
L["召唤音效"]				  = "為%s添加召喚音效"
L["距离过近"]				  = "過近"
L["距离过近三人"]			  = "過近：%s、%s、%s等%d人"
L["距离过近人数"]			  = "過近[%d]人"
L["加载失败"]				  = "NPC%s的名字載入失敗，請重新載入插件。"
L["保命技能"]				  = "保命技能提示"
L["注意自保血量"]			  = "注意自保 HP:%d%%"
L["注意自保"]				  = "注意自保"
L["颜色随血量渐变"]			  = "顏色隨血量漸變"
L["显示血量百分比"]			  = "顯示血量百分比"
--[[ 1 ]]--

L["TIP捕食者之嚎"]			  = "自動分配治療驅散debuff，並標記在團隊框架上。"

L["TIP贪噬迷雾读条计数"]	  = "飢餓迷霧計時條"

L["即将迷雾"]			      = "即將迷霧 %d/100"

--[[ 2 ]]--

L["TIP垂死苦难"]			  = "對比兩個覓亡者之眼的血量，提示血量差值。"
L["领先"]					  = "|cFF00FF00領先%.f%%|r"
L["落后"]					  = "|cFFFF0000落後%.f%%|r"

L["TIP轻蔑与忿怒"]			  = "當你過於靠近相斥debuff的隊友時提示危險。"
L["debuff距离过近"]			  = " 等%d人"

L["TIP毁灭凝视"]			  = "殲滅怒視計時條"

L["即将射线"]			      = "即將射線 %d/100"

--[[ 3 ]]--

L["TIP命运残片"]			  = "對於中了命運碎片的人，在自己被驅散後語音提示快走開。\n對於治療，按剩餘debuff情況指示驅散。語音播報驅散順序，並在團隊框架高亮建議驅散的對象。\n1+1+1+1層，提示驅散一，4人全亮；\n2+1+1層，提示驅散二，1層的2人亮；\n2+2/1+3層，提示驅散三，2人全亮。"

L["TIP斯凯亚"]			  	  = "對比凱拉和西格妮的血量，提示血量差值。"

L["TIP召回咒文"]			  = "首領施放特殊技能後進行記錄，用以預測召回咒文時的技能組合。"
L["boss177171"]				  = "|cff00BFFF躲開射線|r"
L["boss177099"]				  = "|cff00BFFF躲開射線|r"
L["boss177097"]				  = "|cffFFA500護盾|r"
L["boss177222"]				  = "|cffFFFF00接圈|r"
L["boss177101"]				  = "|cffFF00FF分散|r"
L["boss177098"]				  = "|cff00FFFF分擔|r"
L["已放技能"]				  = "本輪已施放："

L["即将召唤"]				  = "即將呼喚華爾琪 %d/100"

--[[ 4 ]]--

L["TIP怨毒"]				  = "顯示中惡意者的位移技能冷卻情況，並按技能冷卻時間長短排序，需要被點名的人安裝插件才能生效。\n惡魔獵人（滑翔）\n德魯伊（野性衝鋒）\n獵人（逃脫）\n戰士（英勇躍擊）\n盜賊（暗影閃現、繩鉤）\n術士（惡魔法陣：傳送）\n死亡騎士（死神逼近）\n武僧（超凡入聖：轉）\n法師（時光倒轉）"
L["技能冷却未知"]			  = "|cFFFFFF00--|r"
L["就绪"]					  = "|cFF00FF00就緒|r"
L["无技能"]					  = "|cFFFF0000無位移技能|r"
L["胸甲"]					  = "胸甲"

L["TIP怨恨"]				  = "顯示忿恨的倒計時及剩餘5秒語音提示，通常15秒一次。"
L["下一次怨恨"]				  = "第%s輪忿恨：%s"

L["TIP群体驱散读条"]	      = "顯示群體驅散的施法條及施法者名字。"
L["施法中断"]				  = "|cFFFF0000施法中斷|r"

L["准备苦难"]				  = "準備苦難，轉火折磨之球 %d/100"

--[[ 5 ]]--

L["TIP好战者枷锁"]			  = [[根據MRT戰術板提示下一輪拉斷鎖鏈的人，並在輪到自己時特別提示。可在拉鎖鏈的三個人後面加上本輪使用的技能。MRT戰術板示例：
鎖鏈順序
1 |cffcc6819張三|r  |cff2133dd張三|r  |cffb2050f張三|r  技能:|cff2133dd張三|r{spell:31821}|cff2133dd張三|r{spell:62618}|cff2133dd張三|r{spell:97462}
2 |cffffffff張三|r  |cffffffff張三|r  |cffc18ef2張三|r  技能:|cff2133dd張三|r{spell:64901}|cff2133dd張三|r{spell:15286}|cff2133dd張三|r{spell:196718}
3 |cffcc6819張三|r  |cffffffff張三|r  |cffff9b00張三|r 	技能:|cff2133dd張三|r{spell:31821}|cff2133dd張三|r{spell:62618}|cff2133dd張三|r{spell:97462}
4 |cff26efef張三|r  |cff1c9b05張三|r  |cffb2050f張三|r 	技能:|cff2133dd張三|r{spell:64901}|cff2133dd張三|r{spell:15286}|cff2133dd張三|r{spell:196718}
end]]
L["下一轮锁链"]				  = "鎖鏈|cFF00FFFF[%d]|r |cFFFFFF00[左]|r%s |cFFFFFF00[中]|r%s |cFFFFFF00[右]|r%s"
L["锁链顺序"]				  = "鎖鏈順序"
L["去拉锁链"]				  = "去拉 |cffFF0000[%s]|r 鎖鏈"
L["死了"]					  = "|cffFF0000(死了)|r"
L["已断"]					  = "|cffC0C0C0(已斷)|r"
L["在拉"]					  = "|cff00FF00(在拉)|r"
L["烙印"]					  = "|cffFF0000(烙印)|r"

L["TIP折磨"]				  = "顯示折磨及折磨爆發計時條。"

L["TIP刑罚者"]				  = "標記淵誓折磨者，使用|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_1:0|t|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_2:0|t|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_3:0|t|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_4:0|t"

L["TIP折磨烙印"]			  = "中了折磨烙印喊話輪數，折磨爆發後重置為1。"
L["折磨烙印喊话"]			  = "烙印 [%s] %s"

L["TIP碎裂之魂"]           	  = "伏屈靈魂白圈出傷計時條。"
L["躲白圈"]					  = "白圈 [%d]"

L["即将折磨喷发"]			  = "即將折磨爆發 %d/100"

--[[ 6 ]]--

L["TIP烈焰套索陷阱"]		  = [[顯示鉤焰陷阱數量及本輪應對減傷技能。MRT戰術板示例：
陷阱順序
|cff2133dd張三|r{spell:31821}|cff2133dd張三|r{spell:62618}|cff2133dd張三|r{spell:97462}
|cff2133dd張三|r{spell:64901}|cff2133dd張三|r{spell:15286}|cff2133dd張三|r{spell:196718}
|cff2133dd張三|r{spell:31821}|cff2133dd張三|r{spell:62618}|cff2133dd張三|r{spell:97462}
|cff2133dd張三|r{spell:64901}|cff2133dd張三|r{spell:15286}|cff2133dd張三|r{spell:196718}
end]]
L["陷阱数量"]				  = "|cffFFFF00[第%d輪]|r陷阱數量: |cff%s[%d]|r"
L["陷阱顺序"]				  = "陷阱順序"
L["陷阱出现"]				  = "陷阱出現"

L["TIP尖刺"]				  = "尖刺提示，附語音"

L["TIP熔炉烈焰"]		      = "顯示影鋼餘燼出火圈的計時條。"

--[[ 7 ]]--

L["TIP净除威胁"]		      = "監控消除威脅點名的三個人，並提示他們需要去的光柱，以便迅速就位，避免互炸。\n能量核心1左|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_1:0|t 右|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_2:0|t。\n能量核心2左|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_3:0|t 右|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_4:0|t。\n能量核心3左|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_5:0|t 右|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_6:0|t。"
L["离开人群"]				  = "離開人群"

L["TIP能量核心能量"]		  = "監控能量核心的能量。"

L["TIP湮灭"]				  = [[根據MRT戰術板提示下一輪分擔抹滅的人，並在輪到自己時特別提示。MRT戰術板示例：
抹滅分擔順序
第一組 |cff2133dd張三|r  |cffffffff張三|r  |cff26efef張三|r  |cffff9b00張三|r  |cffb2050f張三|r 
第二組 |cffc18ef2張三|r  |cff26efef張三|r  |cff2133dd張三|r  |cffc18ef2張三|r  |cffffffff張三|r 
end]]
L["湮灭分担顺序"]			  = "抹滅分擔順序"
L["分担伤害"]				  = "|cffFF0000分擔傷害|r"
L["下一轮湮灭"]				  = "下一輪抹滅"

L["TIP湮灭计时条"] 			  = "顯示抹滅 破甲 分解 熔毁的计时条。"
L["湮灭"]					  = "分擔"
L["破甲"]                     = "破甲"
L["分解"]                     = "躲開正面"
L["熔毁"]                     = "AE"

L["TIP净化协议减伤安排"]	  = [[根據MRT戰術板提示下一組凈化程序的減傷安排。MRT戰術板示例：
凈化協議減傷順序
1 |cffcc6819張三|r{spell:31821}|cff2133dd張三|r{spell:62618}|cffb2050f張三|r{spell:97462}
2 |cffffffff張三|r{spell:196718}|cffffffff張三|r{spell:15286}|cffc18ef2張三|r{spell:64901}
3 |cffcc6819張三|r{spell:31821}|cffffffff張三|r{spell:62618}|cffff9b00張三|r{spell:97462}
end]]
L["净化协议减伤顺序"]		  = "凈化程序減傷順序"

L["TIP净化协议读条计数"]	  = "顯示凈化程序的施法條並計數，每一輪到第三次施法開始以後高亮。"

L["能量核心"]				  = "能量核心"
L["BOSS能量"]				  = "BOSS能量 %d/0"

--[[ 8 ]]--

L["TIP符文亲和"] 			  = "檢測中符文共鳴的人，根據團隊順序依次安排6人到1~6環（剩餘人員待命），\n並提供一個【逆時針，需要加人】的按鈕，點擊按鈕即分配其他待命人員之一到此環進行幫助。\n顯示每一環的分配情況，並對自己的狀態（去N環/待命/幫助N環）特別提示。\n1~6環的對應光柱標記依次為|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_1:0|t|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_2:0|t|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_3:0|t|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_4:0|t|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_5:0|t|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_6:0|t"
L["逆时针"]		 			  = "逆時針，需要加人"
L["准备"]		 			  = "準備……"
L["帮忙"]		 			  = "幫助%s"
L["剩余时间"]				  = "剩餘時間"

L["TIP随演命运"]			  = "判定階段三即興命運啟動的符文環序號，英雄難度請點擊需要轉動的兩環，傳奇難度請點擊無需轉動的兩環。（團隊里僅需1人點即可，多人啟用本功能時採用最先點出的狀態。）"

L["TIP绝望距离检查"]		  = "監視衍命巨怪的絕望讀條，在傳奇難度下提示安全距離（25碼）。"
L["绝望距离安全"]			      = "|cff00FF00安全|r"
L["绝望距离过近"]			      = "|cffFF0000危險|r"

L["TIP宿命联结"]              = "顯示命定聚合的施法條及出傷倒計時。"
L["连线出现"]				  = "連線出現(%d)"
L["连线生效"]                 = "連線生效(%d)"

L["TIP扭曲命运减伤安排"]      = [[根據MRT戰術板提示下一次扭曲命運的減傷安排。MRT戰術板示例：
扭曲命運減傷順序
1 |cffcc6819張三|r{spell:31821}|cff2133dd張三|r{spell:62618}|cffb2050f張三|r{spell:97462}
2 |cffffffff張三|r{spell:196718}|cffffffff張三|r{spell:15286}|cffc18ef2張三|r{spell:64901}
3 |cffcc6819張三|r{spell:31821}|cffffffff張三|r{spell:62618}|cffff9b00張三|r{spell:97462}
end]]
L["扭曲命运减伤顺序"]		  = "扭曲命運減傷順序"

--[[ 9 ]]--

L["TIP不死"]				  = "轉階段的各種提示：階段計時、小怪復活計時、骨匣血量。"

L["TIP灵魂碎裂"]		 	  = "替靈魂破裂產生的靈魂裂片上標記，使用|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_1:0|t|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_2:0|t|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_3:0|t|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_4:0|t|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_5:0|t"

L["TIP劫魂者标记"]			  = "给劫魂者上标记，使用标记|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_6:0|t|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_7:0|t|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_8:0|t"

L["TIP冰川尖刺"]			  = "整合顯示每個冰川之刺的血量，在冰刺低血量時特別提示。"
L["冰刺低血量"]				  = "冰刺低血量！"

L["TIP冻结冲击计时条"]        = "在內場時，添加腐潰之風 冰凍衝擊 冰河之風 不死之怒的計時條和語音提示。"
L["腐溃之风"]		 		  = "推人"
L["冻结冲击"]		 		  = "躲開正面"
L["冰川之风"]		 		  = "躲開龍捲風"
L["亡灵之怒"]		 		  = "離開內場"

L["注意仇恨"]                 = "注意仇恨"
L["击杀大怪"]				  = "擊殺大怪"

--[[ 10 ]]--

L["TIP倒刺之箭"]			  = "全團倒鉤箭層數監視（僅顯示大於等於2層的）"

L["TIP统御锁链"]			  = "在普通和英雄難度下，統御鎖鏈開始施法時，身上倒鉤箭debuff層數大於2層則喊話提示。在傳奇難度下，每輪統御鎖鏈按倒鉤箭層數安排最多8個人（無悲痛debuff），並將這些人分到左右兩側。"

L["TIP女妖的灾厄"]			  = "全團女妖災禍層數監視"

L["TIP女妖之怒"]			  = "女妖狂怒時，高亮團隊框架上有女妖災禍的目標"

L["TIP黑暗帷幕"]			  = "團隊框架中隊友的治療吸收量大於4萬時邊框發光提示。"

L["TIP黑暗帷幕读条计数"]	  = "顯示黑暗籠罩的施法條並計數。"

L["TIP哀痛箭"]				  = "替悲鳴箭和黑蝕箭顯示點名列表，自身被點文字提示、及每一箭的倒數。"
L["你被点"]					  = "你的|cff9370DB[%s]|r|cffFF0000[%d]|r %.1fs"
L["等待伤害"]				  = "|cff9370DB等箭飛到 ！|r"
L["已炸"]					  = "已炸"

L["TIP女妖尖啸"]			  = "顯示女妖哀嚎和女妖號叫的施法條。"

L["TIP死亡飞刀"]              = "死亡利刃點名列表、語音倒數及自身被點文字提示"

L["TIP造桥"]				  = "顯示召喚大地 引導寒冰 索命妖魂 傳送奧睿博司 劈裂 女妖哀嚎 召喚寶珠 汙穢 女妖號叫 敗壞 抹除的計時條。"
L["造桥"]					  = "造橋 [%d]"
L["传送"]					  = "傳送"
L["女妖哀嚎"]				  = "6碼分散 [%d]"
L["女妖尖啸"]			 	  = "7碼分散 [%d]"
L["推波"]					  = "推波 [%d]"
L["躲开"]					  = "躲開"
L["打断"]					  = "打斷 [%d]"
L["跳台子"]					  = "换台子 [%d]"
L["躲开巨像正面"]			  = "躲開巨像正面"
L["召唤宝珠"]	              = "召喚寶珠"

L["TIP无情"]				  = "顯示落點在當前台子及下個台子的接圈計時條。"
L["当前台子"]				  = "|cffFF0000當前台子|r"
L["下个台子"]				  = "|cffD3D3D3下個台子|r"
L["圈数"]					  = "|cff%s[ %d 圈 ]|r"

L["即将黑暗帷幕"]			  = "即將黑暗籠罩 %d/100"
L["小心脚下"]			      = "小心腳下"
L["目标免疫"]			      = "目標免疫"
L["召唤宝珠"]				  = "召喚寶珠"
L["打断恐惧宝珠"]			  = "打斷恐懼之球"
L["点名白圈"]				  = "點名白圈"