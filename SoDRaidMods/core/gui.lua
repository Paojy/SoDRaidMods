local T, C, L, G = unpack(select(2, ...))

local addon_name = G.addon_name
local font = G.Font

----------------------------------------------------------
-----------------[[     Functions     ]]------------------
----------------------------------------------------------

-- 获取NPC名字
local scanTooltip = CreateFrame("GameTooltip", "NPCNameToolTip", nil, "GameTooltipTemplate") --fake tooltipframe used for reading localized npc names -- by lunaic
local function GetNameFromNpcID(npcID)
	local name
	if SoD_DB["NpcNames"][npcID] then
		name = SoD_DB["NpcNames"][npcID]
	else
		scanTooltip:SetOwner(UIParent,"ANCHOR_NONE")
		scanTooltip:SetHyperlink(format("unit:Creature-0-0-0-0-%d-0000000000", npcID))
		if scanTooltip:NumLines()>0 then
			name = NPCNameToolTipTextLeft1:GetText()
			scanTooltip:Hide()
			if name then
				SoD_DB["NpcNames"][npcID] = name
			end
		end
	end
	
	if name then
		return name
	else
		print(string.format(L["加载失败"], npcID))
	end
end
T.GetNameFromNpcID = GetNameFromNpcID

local ReskinCheck = function(f)
	f:SetNormalTexture("")
	f:SetPushedTexture("")
	f:SetHighlightTexture(G.media.blank)
	
	local hl = f:GetHighlightTexture()
	hl:SetPoint("TOPLEFT", 5, -5)
	hl:SetPoint("BOTTOMRIGHT", -5, 5)
	hl:SetVertexColor(0, 1, 0, .2)

	local bd = CreateFrame("Frame", nil, f)
	bd:SetPoint("TOPLEFT", 4, -4)
	bd:SetPoint("BOTTOMRIGHT", -4, 4)
	bd:SetFrameLevel(f:GetFrameLevel()-1)
	T.createbdframe(bd)

	local tex = f:CreateTexture(nil, "BORDER")
	tex:SetTexture(G.media.gradient)
	tex:SetVertexColor(.5, .5, .5, .3)
	tex:SetPoint("TOPLEFT", 4, -4)
	tex:SetPoint("BOTTOMRIGHT", -4, 4)

	local ch = f:GetCheckedTexture()
	ch:SetDesaturated(true)
	ch:SetVertexColor(0, 1, 0)
end

local createcheckbutton = function(parent, x, y, name, t1, t2, value, role, dif)
	local bu
	if t2 then
		bu = CreateFrame("CheckButton", addon_name..t1..t2..value.."Button", parent, "InterfaceOptionsCheckButtonTemplate")
	else
		bu = CreateFrame("CheckButton", addon_name..t1..value.."Button", parent, "InterfaceOptionsCheckButtonTemplate")	
	end
	ReskinCheck(bu)
	bu:SetFrameLevel(parent:GetFrameLevel()+4)
	bu:SetPoint("TOPLEFT", x, y)
	if parent.bgtex then
		parent.bgtex:SetPoint("BOTTOMRIGHT", parent, "TOPRIGHT", 0, y-40)
	end
	bu:SetHitRectInsets(0, -50, 0, 0)

	local difstr = ""
	if dif then
		if dif["all"] then
			difstr = ""
		else
			if dif[14] then
				difstr = difstr.."|cff00FF00(N)|r"
			end
			if dif[15] then
				difstr = difstr.."|cff1E90FF(H)|r"
			end
			if dif[16] then
				difstr = difstr.."|cff8A2BE2(M)|r"
			end
		end
	else
		difstr = ""
	end
	
	local rolestr = (role == "tank" and  L["TANK_ICON_SMALL"]) or (role == "dps" and  L["DAMAGE_ICON_SMALL"]) or (role == "healer" and L["HEALER_ICON_SMALL"])  or ""

	bu.Text:SetText(name..difstr..rolestr)
	bu.Text:SetWidth(450)	
	
	bu:SetScript("OnDisable", function(self)
		local tex = select(7, bu:GetRegions())
		tex:SetVertexColor(.8, .8, .8, .5)
	end)
	
	bu:SetScript("OnEnable", function(self)
		local tex = select(7, bu:GetRegions())
		tex:SetVertexColor(.5, .5, .5, .3)
	end)
	
	if t2 then
		bu:SetScript("OnShow", function(self) self:SetChecked(SoD_CDB[t1][t2][value]) end)
		bu:SetScript("OnClick", function(self)
			if self:GetChecked() then
				SoD_CDB[t1][t2][value] = true
			else
				SoD_CDB[t1][t2][value] = false
			end
			if bu.apply then
				bu:apply()
			end
		end)		
	else
		bu:SetScript("OnShow", function(self) self:SetChecked(SoD_CDB[t1][value]) end)
		bu:SetScript("OnClick", function(self)
			if self:GetChecked() then
				SoD_CDB[t1][value] = true
			else
				SoD_CDB[t1][value] = false
			end
			if bu.apply then
				bu:apply()
			end
		end)	
	end
	
	return bu
end

local function TestSlider_OnValueChanged(self, value)
   if not self._onsetting then   -- is single threaded 
     self._onsetting = true
     self:SetValue(self:GetValue())
     value = self:GetValue()     -- cant use original 'value' parameter
     self._onsetting = false
   else return end               -- ignore recursion for actual event handler
 end
 
local ReskinSlider = function(f)
	f:SetBackdrop(nil)
	f.SetBackdrop = function() end

	local bd = CreateFrame("Frame", nil, f)
	bd:SetPoint("TOPLEFT", 14, -2)
	bd:SetPoint("BOTTOMRIGHT", -15, 3)
	bd:SetFrameLevel(f:GetFrameLevel()-1)
	T.createbdframe(bd)

	local slider = select(4, f:GetRegions())
	--slider:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
	--slider:SetBlendMode("ADD")
end

local createslider = function(parent, x, y, name, t1, t2, value, min, max, step)
	local slider
	if t2 then
		slider = CreateFrame("Slider", addon_name..t1..t2..value.."Slider", parent, "OptionsSliderTemplate")
	else
		slider = CreateFrame("Slider", addon_name..t1..value.."Slider", parent, "OptionsSliderTemplate")
	end
	slider:SetFrameLevel(parent:GetFrameLevel()+4)
	slider:SetPoint("TOPLEFT", x, y)
	slider:SetWidth(200)
	ReskinSlider(slider)
	
	BlizzardOptionsPanel_Slider_Enable(slider)
	
	slider:SetMinMaxValues(min, max)
	_G[slider:GetName()..'Low']:SetText(min)
	_G[slider:GetName()..'Low']:ClearAllPoints()
	_G[slider:GetName()..'Low']:SetPoint("RIGHT", slider, "LEFT", -5, 0)
	_G[slider:GetName()..'High']:SetText(max)
	_G[slider:GetName()..'High']:ClearAllPoints()
	_G[slider:GetName()..'High']:SetPoint("LEFT", slider, "RIGHT", 5, 0)
	
	_G[slider:GetName()..'Text']:ClearAllPoints()
	_G[slider:GetName()..'Text']:SetPoint("BOTTOM", slider, "TOP", 0, 3)
	_G[slider:GetName()..'Text']:SetFontObject(GameFontHighlight)

	slider:SetValueStep(step)
	
	slider:SetScript("OnShow", function(self)
		if t2 then
			self:SetValue(SoD_CDB[t1][t2][value])
			_G[slider:GetName()..'Text']:SetText(name.." "..SoD_CDB[t1][t2][value])
		else
			self:SetValue(SoD_CDB[t1][value])
			_G[slider:GetName()..'Text']:SetText(name.." "..SoD_CDB[t1][value])
		end
	end)
	
	slider:SetScript("OnValueChanged", function(self, getvalue)
		if t2 then
			SoD_CDB[t1][t2][value] = getvalue
			TestSlider_OnValueChanged(self, getvalue)
			_G[slider:GetName()..'Text']:SetText(name.." "..SoD_CDB[t1][t2][value])
			if slider.apply then
				slider:apply()
			end
		else
			SoD_CDB[t1][value] = getvalue
			TestSlider_OnValueChanged(self, getvalue)
			_G[slider:GetName()..'Text']:SetText(name.." "..SoD_CDB[t1][value])
			if slider.apply then
				slider:apply()
			end
		end
	end)
	
	return slider	
end

local ReskinRadio = function(f)
	f:SetNormalTexture("")
	f:SetHighlightTexture("")
	f:SetCheckedTexture(G.media.blank)

	local ch = f:GetCheckedTexture()
	ch:SetPoint("TOPLEFT", -3, 3)
	ch:SetPoint("BOTTOMRIGHT", 3, -3)
	ch:SetBlendMode("ADD")
	ch:SetTexCoord( 0, 1, 0, 1)
	ch:SetVertexColor(1, 1, 0, .6)
	ch:SetAllPoints(f)
	
	f.bd = T.createbdframe(f)
	
	local tex = f:CreateTexture(nil, "BORDER")
	tex:SetTexture(G.media.gradient)
	tex:SetVertexColor(.5,.5,.5,.5)
	tex:SetAllPoints(f)
	
	f:HookScript("OnEnter", function() f.bd:SetBackdropBorderColor(0, 1, 0) end)
	f:HookScript("OnLeave", function() f.bd:SetBackdropBorderColor(0, 0, 0) end)
end

local createradiobuttongroup = function(parent, x, y, name, t1, t2, value, group)
	local frame
	if t2 then
		frame = CreateFrame("Frame", addon_name..t1..t2..value.."RadioButtonGroup", parent)
	else
		frame = CreateFrame("Frame", addon_name..t1..value.."RadioButtonGroup", parent)
	end
	frame:SetFrameLevel(parent:GetFrameLevel()+4)
	frame:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
	frame:SetSize(150, 30)
	
	frame.text = T.createtext(frame, "OVERLAY", 12, "OUTLINE", "LEFT")
	frame.text:SetPoint("TOPLEFT", frame, "TOPLEFT")
	frame.text:SetText(name)
	
	for i = 1, #group do
	
		local k = group[i][1]
		local v = group[i][2]
		
		frame[k] = CreateFrame("CheckButton", addon_name..t1..value..k.."RadioButtonGroup", frame, "UIRadioButtonTemplate")
		ReskinRadio(frame[k])
		_G[frame[k]:GetName() .. "Text"]:SetText(v)
		
		if t2 then
			frame[k]:SetScript("OnShow", function(self)
				self:SetChecked(SoD_CDB[t1][t2][value] == k)
			end)
			
			frame[k]:SetScript("OnClick", function(self)
			
				if self:GetChecked() then
					
					SoD_CDB[t1][t2][value] = k
					if frame.apply then
						frame:apply()
					end
				else
					self:SetChecked(true)
				end
			end)
		else
			frame[k]:SetScript("OnShow", function(self)
				self:SetChecked(SoD_CDB[t1][value] == k)
			end)
			
			frame[k]:SetScript("OnClick", function(self)
				if self:GetChecked() then
					SoD_CDB[t1][value] = k
					if frame.apply then
						frame:apply()
					end
				else
					self:SetChecked(true)
				end
			end)
		end
	end
	
	for i = 1, #group do
	
		local k = group[i][1]
		
		frame[k]:HookScript("OnClick", function(self)
			if (t2 and SoD_CDB[t1][t2][value] == k) or (not t2 and SoD_CDB[t1][value] == k) then
				for index = 1, #group do
					local j = group[index][1]
					if j ~= k then
						frame[j]:SetChecked(false)
					end
				end
			end
		end)
	end
	
	local buttons = {frame:GetChildren()}
	for i = 1, #buttons do
		if i == 1 then
			buttons[i]:SetPoint("LEFT", frame.text, "RIGHT", 10, 0)
		else
			buttons[i]:SetPoint("LEFT", _G[buttons[i-1]:GetName() .. "Text"], "RIGHT", 5, 0)
		end
	end
	
	return frame
end

T.CreateTitle = function(options, text, start_pos, end_pos)
	local title = T.createtext(options, "OVERLAY", 15, "OUTLINE", "LEFT")
	title:SetPoint("TOPLEFT", options, "TOPLEFT", 30, start_pos)
	title:SetTextColor(1, 1, 0)
	title:SetText(text)
	
	local line = options:CreateTexture(nil, "BACKGROUND")
	line:SetPoint("TOPLEFT", options, "TOPLEFT", 20, start_pos-18)
	line:SetPoint("BOTTOMRIGHT", options, "TOPRIGHT", 0, start_pos-20)
	line:SetTexture(G.media.blank)
	line:SetGradientAlpha("HORIZONTAL", 1, 1, 0, .8, 1, 0, 0, 0)
	
	local bgtex = options:CreateTexture(nil, "BACKGROUND")
	bgtex:SetPoint("TOPLEFT", options, "TOPLEFT", 20, start_pos-20)
	bgtex:SetPoint("BOTTOMRIGHT", options, "TOPRIGHT", 0, end_pos)
	bgtex:SetColorTexture(.4, .6, .9, .8)
end

local CreateSubTitle = function(parent, text, start_x, start_y)
	if parent.option_num > 0 then
		parent.option_num = parent.option_num + 1
	end
	local start_pos = (start_y or -70) - 30*parent.option_num
	local title = T.createtext(parent, "OVERLAY", 14, "OUTLINE", "LEFT")
	title:SetPoint("TOPLEFT", parent, "TOPLEFT", start_x or 30,  start_pos)
	title:SetTextColor(1, 1, 0)
	title:SetText(text)
	
	local line = parent:CreateTexture(nil, "BACKGROUND")
	line:SetPoint("TOPLEFT", parent, "TOPLEFT", start_x or 20, start_pos-18)
	line:SetPoint("BOTTOMRIGHT", parent, "TOPRIGHT", 0, start_pos-20)
	line:SetTexture(G.media.blank)
	line:SetGradientAlpha("HORIZONTAL", 1, 1, 0, .8, 1, 0, 0, 0)
	
	local bgtex = parent:CreateTexture(nil, "ARTWORK")	
	bgtex:SetPoint("TOPLEFT", parent, "TOPLEFT", start_x or 20, start_pos-20)
	bgtex:SetColorTexture(.4, .6, .9, .8)
		
	parent.option_num = parent.option_num + 1
	parent.bgtex = bgtex
end

local ReskinScroll = function(f)
	local frame = f:GetName()
    
	local bu = (f.ThumbTexture or f.thumbTexture) or _G[frame.."ThumbTexture"]
	bu:SetAlpha(0)
	bu:SetWidth(17)

	T.createbdframe(bu)
	
	local up, down = f:GetChildren()
	
	up:SetWidth(17)
	T.createbdframe(up)
	up:SetNormalTexture("")
	up:SetHighlightTexture("")
	up:SetPushedTexture("")
	up:SetDisabledTexture(G.media.blank)
	local dis1 = up:GetDisabledTexture()
	dis1:SetVertexColor(0, 0, 0, .4)
	dis1:SetDrawLayer("OVERLAY")
	
	local uptex = up:CreateTexture(nil, "ARTWORK")
	uptex:SetTexture(G.media.arrowUp)
	uptex:SetSize(8, 8)
	uptex:SetPoint("CENTER")
	uptex:SetVertexColor(1, 1, 1)
	up.bgTex = uptex
	
	up:HookScript("OnEnter", function(f) 
		if f:IsEnabled() then
			f.bgTex:SetVertexColor(1, 1, 0)
		end
	end)
	up:HookScript("OnLeave", function(f) 
		f.bgTex:SetVertexColor(1, 1, 1)
	end)
	
	down:SetWidth(17)
	T.createbdframe(down)
	down:SetNormalTexture("")
	down:SetHighlightTexture("")
	down:SetPushedTexture("")
	down:SetDisabledTexture(G.media.blank)
	local dis2 = down:GetDisabledTexture()
	dis2:SetVertexColor(0, 0, 0, .4)
	dis2:SetDrawLayer("OVERLAY")
	
	local downtex = down:CreateTexture(nil, "ARTWORK")
	downtex:SetTexture(G.media.arrowDown)
	downtex:SetSize(8, 8)
	downtex:SetPoint("CENTER")
	downtex:SetVertexColor(1, 1, 1)
	down.bgTex = downtex

	down:HookScript("OnEnter", function(f) 
		if f:IsEnabled() then
			f.bgTex:SetVertexColor(1, 1, 0)
		end
	end)
	down:HookScript("OnLeave", function(f) 
		f.bgTex:SetVertexColor(1, 1, 1)
	end)
	
end

T.CreateOptions = function(text, parent, scroll)
	local options = CreateFrame("Frame", nil, parent)
	options:SetPoint("TOPLEFT", parent, "TOPLEFT", 10, -15)
	options:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -10, 10)
	options:Hide()

	local tab = parent["tab"..parent.tabindex]
	tab.n = parent.tabindex
	tab:SetFrameLevel(parent:GetFrameLevel()+2)

	T.createborder(tab)

	tab.name = T.createtext(tab, "OVERLAY", 12, "OUTLINE", "LEFT")
	tab.name:SetText(text)
	tab.name:SetPoint("LEFT")
	
	tab:SetSize(150, 25)
	tab:SetPoint("TOPLEFT", parent, "TOPRIGHT", 5, -30*tab.n)
	
	if tab.n == 1 then
		tab.sd:SetBackdropBorderColor(1, 1, 0)
		options:Show()
	end
	
	tab:HookScript("OnMouseDown", function(self)
		options:Show()
		tab.sd:SetBackdropBorderColor(1, 1, 0)
	end)
	
	for i = 1, parent.tabnum do
		if i ~= tab.n then
			parent["tab"..i]:HookScript("OnMouseDown", function(self)
				options:Hide()
				tab.sd:SetBackdropBorderColor(0, 0, 0)
			end)
		end
	end
	
	parent.tabindex = parent.tabindex +1
	
	if scroll then
		options.sf = CreateFrame("ScrollFrame", G.addon_name..parent.tabindex.."ScrollFrame", options, "UIPanelScrollFrameTemplate")
		options.sf:SetPoint("TOPLEFT", options, "TOPLEFT", 10, -10)
		options.sf:SetPoint("BOTTOMRIGHT", options, "BOTTOMRIGHT", -35, 30)
		options.sf:SetFrameLevel(options:GetFrameLevel()+1)

		options.sfa = CreateFrame("Frame", G.addon_name..parent.tabindex.."ScrollAnchor", options.sf)
		options.sfa:SetPoint("TOPLEFT", options.sf, "TOPLEFT", 0, -3)
		options.sfa:SetWidth(options.sf:GetWidth()-20)
		options.sfa:SetHeight(options.sf:GetHeight())
		options.sfa:SetFrameLevel(options.sf:GetFrameLevel()+1)
		
		options.sf:SetScrollChild(options.sfa)
		options.sf.mobs = {}
		
		ReskinScroll(_G[G.addon_name..parent.tabindex.."ScrollFrameScrollBar"])
	end
	
	return options
end

-- 图标提示
T.Create_AlertIcon_Options = function(parent, dif, v, addon_only, role, tip)
	if not parent.IconAlert_Options then
		CreateSubTitle(parent, L["图标提示"])
		parent.IconAlert_Options = true
	end
	
	local spell_type, spell_id = strsplit("_", v)
	local str
	
	if spell_type == "com" then
		str	= string.format(L["点我时显示图标提示"], T.GetIconLink(spell_id))
	elseif spell_type == "aura" then
		str	= string.format(L["显示图标提示光环"], T.GetIconLink(spell_id))
	elseif spell_type == "auras" then
		str	= string.format(L["显示图标提示多人光环"], T.GetIconLink(spell_id))
	elseif spell_type == "cast" then
		str	= string.format(L["显示图标提示施法"], T.GetIconLink(spell_id))
	elseif spell_type == "bwspell" or spell_type == "bwtext" then
		if addon_only == "DBM" then
			str	= string.format(L["显示图标提示DBM"], T.GetIconLink(spell_id))
		elseif addon_only == "BW" then
			str	= string.format(L["显示图标提示BW"], T.GetIconLink(spell_id))
		else
			str	= string.format(L["显示图标提示DBMBW"], T.GetIconLink(spell_id))
		end
	else
		str	= string.format(L["显示图标提示"], T.GetIconLink(spell_id))
	end
	
	local bu = createcheckbutton(parent, 30,  - 70 - 30*parent.option_num, str, "Icons", false, v, role, dif)
	bu.apply = function() G["Icons"][v].update_onedit("enable") end
	
	bu:SetScript("OnEnter", function(self) 
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT",  -20, 10)
		GameTooltip:SetSpellByID(spell_id)
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(tip or "", .8, .5, 1)
		GameTooltip:Show() 
	end)
	bu:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)
	
	parent.option_num = parent.option_num + 1
	table.insert(parent.options, bu)
	
	return bu
end

-- 文字提示
T.Create_TextAlert_Options = function(parent, dif, index, v, role)
	if not parent.TextAlert_Options then
		CreateSubTitle(parent, L["文字提示"])
		parent.TextAlert_Options = true
	end
	
	local text_type, npc = strsplit("_", v)
	local str

	if text_type == "hp" then
		str	= string.format(L["提示血量"], GetNameFromNpcID(npc) or "")
	elseif text_type == "pp" then
		str	= string.format(L["提示能量"], GetNameFromNpcID(npc) or "")
	else
		str	= string.format(L["添加文本"], T.GetIconLink(v))
	end
	
	local bu = createcheckbutton(parent, 30,  - 70 - 30*parent.option_num, str, "Text_Alerts", false, v, role, dif)
	bu.apply = function() G["Texts"][v].update_onedit("enable") end
		
	if type(v) == "number" then
		bu:SetScript("OnEnter", function(self) 
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT",  -20, 10)
			GameTooltip:SetSpellByID(v)
			GameTooltip:Show() 
		end)
		bu:SetScript("OnLeave", function(self)
			GameTooltip:Hide()
		end)
	end
		
	parent.option_num = parent.option_num + 1
	table.insert(parent.options, bu)
	
	return bu
end

-- 团队高亮提示
T.Create_HLOnRaid_Options = function(parent, dif, v, role, stack)
	if not parent.HLOnRaid_Options then
		CreateSubTitle(parent, L["团队高亮图标"])
		parent.HLOnRaid_Options = true
	end
	
	local type_str, ID_str, Glow, spellID	
	type_str, ID_str, Glow = strsplit("_" , v)
	spellID = tonumber(ID_str)
	
	local str
	if type_str == "HLCast" then
		str = string.format(L["显示高亮图标施法"], T.GetIconLink(spellID), Glow and L["高亮"] or L["普通"])
	elseif stack then
		str = string.format(L["显示高亮图标光环层数"], T.GetIconLink(spellID), Glow and L["高亮"] or L["普通"], stack)
	else
		str = string.format(L["显示高亮图标光环"], T.GetIconLink(spellID), Glow and L["高亮"] or L["普通"])
	end
	local bu = createcheckbutton(parent, 30, - 70 - 30*parent.option_num, str, type_str, false, v, role, dif)
	
	bu:SetScript("OnEnter", function(self) 
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT",  -20, 10)
		GameTooltip:SetSpellByID(spellID)
		GameTooltip:Show() 
	end)
	bu:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)
	
	parent.option_num = parent.option_num + 1
	table.insert(parent.options, bu)
end

-- 姓名板提示
T.Create_PlateAlert_Options = function(parent, v, role, t, mobID, hl_np)
	if not parent.PlateAlert_Options then
		CreateSubTitle(parent, L["姓名板图标"])
		parent.PlateAlert_Options = true
	end
	
	local hl_tag = ""
	if hl_np then
		hl_tag = L["姓名板边框动画"]
	end
	
	local str
	if t == "PlateSpells" then
		local npc = GetNameFromNpcID(mobID) or "??"
		str = string.format(L["显示姓名板图标施法"], npc, T.GetIconLink(v), hl_tag)	
	elseif t == "PlateAuras" then
		str = string.format(L["显示姓名板图标光环"], T.GetIconLink(v), hl_tag)
	elseif t == "PlayerAuraSource" then
		str = string.format(L["显示来源图标"], T.GetIconLink(v))
	elseif t == "PlatePower" then
		local npc = GetNameFromNpcID(v) or "??"
		str = string.format(L["显示姓名板能量图标"], npc)
	elseif t == "PlateNpcID" then
		local npc = GetNameFromNpcID(v) or "??"
		str = string.format(L["显示姓名板动画边框"], npc)	
	end
	
	local bu = createcheckbutton(parent, 30,  - 70 - 30*parent.option_num, str, t, false, v, role)
	
	if t == "PlateSpells" or t == "PlateAuras" or t == "PlayerAuraSource" then
		bu:SetScript("OnEnter", function(self) 
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT",  -20, 10)
			GameTooltip:SetSpellByID(v)
			GameTooltip:Show() 
		end)
		bu:SetScript("OnLeave", function(self)
			GameTooltip:Hide()
		end)
	end
	
	parent.option_num = parent.option_num + 1
	table.insert(parent.options, bu)
end

-- 喊话提示
T.Create_ChatMsg_Options = function(parent, v, role, t)
	if not parent.ChatMsg_Options then
		CreateSubTitle(parent, L["喊话提示"])
		parent.ChatMsg_Options = true
	end
	
	local str, bu
	if t == "ChatMsgAuras" then
		str = string.format(L["添加喊话光环"], T.GetIconLink(v))
		bu = createcheckbutton(parent, 30,  - 70 - 30*parent.option_num, str, "ChatMsgAuras", false, v, role)
	elseif t == "ChatMsgAurasDose" then
		str = string.format(L["添加喊话堆叠"], T.GetIconLink(v))
		bu = createcheckbutton(parent, 30,  - 70 - 30*parent.option_num, str, "ChatMsgAurasDose", false, v, role)		
	elseif t == "ChatMsgAuraCountdown" then
		str = string.format(L["添加倒数喊话"], T.GetIconLink(v))
		bu = createcheckbutton(parent, 30,  - 70 - 30*parent.option_num, str, "ChatMsgAuraCountdown", false, v, role)
	elseif t == "ChatMsgAuraRepeat" then
		str = string.format(L["添加持续喊话"], T.GetIconLink(v))
		bu = createcheckbutton(parent, 30,  - 70 - 30*parent.option_num, str, "ChatMsgAuraRepeat", false, v, role)
	elseif t == "ChatMsgBossWhispers" then
		str = string.format(L["添加喊话密语"], T.GetIconLink(tonumber(v)))
		bu = createcheckbutton(parent, 30,  - 70 - 30*parent.option_num, str, "ChatMsgBossWhispers", false, v, role)
	elseif t == "ChatMsgCom" then
		str = string.format(L["添加喊话读条"], T.GetIconLink(v))
		bu = createcheckbutton(parent, 30,  - 70 - 30*parent.option_num, str, "ChatMsgCom", false, v, role)
	elseif t == "ChatMsgRange" then
		if G.Msgs[t][v]["range_event"] == "BW_AND_DBM_TIMER" then
			if G.Msgs[t][v]["addon_only"] == "DBM" then
				str = string.format(L["添加距离过近喊话DBM"], T.GetIconLink(v))
			elseif G.Msgs[t][v]["addon_only"] == "BW" then
				str = string.format(L["添加距离过近喊话BW"], T.GetIconLink(v))
			else
				str = string.format(L["添加距离过近喊话DBMBW"], T.GetIconLink(v))
			end
		else
			str = string.format(L["添加距离过近喊话"], T.GetIconLink(v))
		end
		bu = createcheckbutton(parent, 30,  - 70 - 30*parent.option_num, str, "ChatMsgRange", false, v, role)		
	end
	
	bu:SetScript("OnEnter", function(self) 
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT",  -20, 10)
		GameTooltip:SetSpellByID(v)
		GameTooltip:Show() 
	end)
	bu:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)
	
	parent.option_num = parent.option_num + 1
	table.insert(parent.options, bu)
end

G.sound_suffix = {
	["SPELL_AURA_APPLIED"] = {"aura", L["获得光环音效"]},
	["SPELL_AURA_REMOVED"] = {"auralose", L["移除光环音效"]},
	["SPELL_AURA_APPLIED_DOSE"] = {"stack", L["层数增加音效"]},	
	["SPELL_CAST_START"] = {"cast", L["开始施法音效"]},
	["SPELL_CAST_SUCCESS"] = {"succeed", L["施法成功音效"]},
	["SPELL_SUMMON"] = {"summon", L["召唤音效"]},
	
	["UNIT_SPELLCAST_START"] = {"cast", L["开始施法音效"]},
	["UNIT_SPELLCAST_SUCCEEDED"] = {"succeed", L["施法成功音效"]},
	["UNIT_SPELLCAST_CHANNEL_START"] = {"channel", L["开始引导音效"]},
	
	["CHAT_MSG_MONSTER_YELL"] = {"yell", L["施法成功音效"]},
	["CHAT_MSG_RAID_BOSS_EMOTE"] = {"emote", L["施法成功音效"]},
	
	["BW_AND_DBM_SPELL"] = {"bws", L["法术预报音效DBMBW"]},
	["BW_AND_DBM_TEXT"] = {"bwt", L["法术预报音效DBMBW"]},
}

-- 音效提示
T.Create_Sound_Options = function(parent, tag, role, event, sub_event, spellID, addon_only)
	if not parent.Sound_Options then
		CreateSubTitle(parent, L["音效提示"])
		parent.Sound_Options = true
	end
	
	local suffix	
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		suffix = sub_event
	else
		suffix = event
	end

	local str
	if addon_only == "DBM" then
		str = string.format(L["法术预报音效DBM"], T.GetIconLink(spellID))
	elseif addon_only == "BW" then
		str = string.format(L["法术预报音效BW"], T.GetIconLink(spellID))
	else
		str = string.format(G.sound_suffix[suffix][2], T.GetIconLink(spellID))
	end
	local bu = createcheckbutton(parent, 30,  - 70 - 30*parent.option_num, str, "Sound", nil, tag, role)

	bu:SetScript("OnEnter", function(self) 
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT",  -20, 10)
		GameTooltip:SetSpellByID(spellID)
		GameTooltip:Show()
		T.Play(bu, tag)
	end)
	bu:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)
	
	parent.option_num = parent.option_num + 1
	table.insert(parent.options, bu)
end

-- 首领模块
T.Create_BossMod_Options = function(parent, role, dif, v, tip)
	if not parent.BossMod_Options then
		CreateSubTitle(parent, L["首领模块"])
		parent.BossMod_Options = true
	end
	
	local str = string.format(L["显示模块"], T.GetIconLink(v))
	
	local bu = createcheckbutton(parent, 30,  - 70 - 30*parent.option_num, str, "BossMods", false, v, role, dif)
	bu.apply = function() G["BossMods"][v].update_onedit("enable") end
	
	bu:SetScript("OnEnter", function(self) 
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT",  -20, 10)
		GameTooltip:AddLine(tip)
		GameTooltip:Show()
	end)
	bu:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)
	
	parent.option_num = parent.option_num + 1
	table.insert(parent.options, bu)
	
	return bu
end

-- 自保技能
T.Create_DefenseSpell_Options = function(parent, spell)
	if not parent.DefenseSpell_Options then
		CreateSubTitle(parent, L["保命技能"])
		parent.DefenseSpell_Options = true
	end

	local bu_str = T.createtext(parent, "OVERLAY", 14, "OUTLINE", "LEFT")
	bu_str:SetPoint("TOPLEFT", parent, "TOPLEFT", 30, - 70 - 30*parent.option_num)
	bu_str:SetText(T.GetIconLink(spell))
	
	if parent.bgtex then
		parent.bgtex:SetPoint("BOTTOMRIGHT", parent, "TOPRIGHT", 0, - 110 - 30*parent.option_num)
	end
	
	parent.option_num = parent.option_num + 1
end

-- 时间轴
local Sub_Events = {
	["SPELL_AURA_APPLIED"] = L["获得光环"],
	["SPELL_AURA_REMOVED"] = L["光环消失"],
	["SPELL_CAST_START"] = L["开始施法"],
	["SPELL_CAST_SUCCESS"] = L["施法成功"],
}

T.Create_Phase_Options = function(parent, index, empty, subevent, spell)
	if not parent.Phase_Options then
		CreateSubTitle(parent, L["转阶段"])
		parent.Phase_Options = true
	end
	
	local str
	if empty then
		str = string.format(L["转阶段空"], index)
	else
		str = string.format(L["转阶段技能"], index, T.GetIconLink(spell), Sub_Events[subevent])
	end
	
	local bu_str = T.createtext(parent, "OVERLAY", 14, "OUTLINE", "LEFT")
	bu_str:SetPoint("TOPLEFT", parent, "TOPLEFT", 30, - 70 - 30*parent.option_num)
	bu_str:SetText(str)
	
	if parent.bgtex then
		parent.bgtex:SetPoint("BOTTOMRIGHT", parent, "TOPRIGHT", 0, - 110 - 30*parent.option_num)
	end
	
	parent.option_num = parent.option_num + 1
end

G.boss_msg_spell = {}
G.bw_sound_keyword = {}

-- BOSS设置面板
T.CreateEncounterOptions = function(parent, index, data)
	local ef = CreateFrame("Frame", nil, parent.sfa)
	ef.option_num = 0
	ef.options = {}
	
	ef:SetAllPoints()
	
	ef.img = ef:CreateTexture(nil, "OVERLAY")
	ef.img:SetPoint("TOPLEFT", 0, 0)
	ef.img:SetTexCoord( 0, 1, 0, .95)
	ef.img:SetSize(128, 64)
	ef.img:SetTexture(data["img"])
	
	ef.title = T.createtext(ef, "OVERLAY", 25, "OUTLINE", "LEFT")
	ef.title:SetPoint("LEFT", ef.img, "RIGHT", 0, 0)
	
	if data.id then
		ef.title:SetText(EJ_GetEncounterInfo(data["id"]))
	else
		ef.title:SetText(L["杂兵"])
	end
	
	for Alert_Type, Alerts in T.pairsByKeys(data["alerts"]) do
		if Alert_Type == "BossMods" then -- 已改
			for i, args in pairs(Alerts) do
				local points = args.points or {}
				if not points.hide then -- 默认位置和大小
					points.a1 = args.points and args.points.a1 or "TOPLEFT"
					points.a2 = args.points and args.points.a2 or "CENTER"
					points.x = args.points and args.points.x or -700
					points.y = args.points and args.points.y or 400					
					points.width = args.points and args.points.width or 250
					points.height = args.points and args.points.height or 200
				end
				T.CreateBossMod(ef, index, args.spellID, args.role, args.tip, points, args.events, args.difficulty_id, args.init, args.reset, args.update, args.update_onframe, args.update_rate)
			end
		elseif Alert_Type == "AlertIcon" then
			for i, args in pairs(Alerts) do -- 已改			
				local v = args.type.."_"..args.spellID

				local dif = args.dif or {["all"] = true}
				local hl = args.hl or "no"
				
				if args.type == "aura" then
					T.CreateAura(ef, dif, index, v, hl, args.role, args.tip, args.aura_type, args.unit, args.index)
				elseif args.type == "auras" then
					T.CreateAuras(ef, dif, index, v, hl, args.role, args.tip, args.aura_type, args.index)
				elseif args.type == "log" then
					T.CreateLog(ef, dif, index, v, hl, args.role, args.tip, args.event_type, args.targetID, args.dur)
				elseif args.type == "cast" then
					T.CreateCast(ef, dif, index, v, hl, args.role, args.tip)
				elseif args.type == "com" then
					T.CreateCastingOnMe(ef, dif, index, v, hl, args.role, args.tip)
				elseif args.type == "bmsg" then
					T.CreateBossMsg(ef, dif, index, v, hl, args.role, args.tip, args.event, args.msg, args.dur)
				elseif args.type == "bwspell" then
					T.CreateBWSpellTimer(ef, dif, index, v, hl, args.role, args.tip, args.dur, args.addon_only)
				elseif args.type == "bwtext" then
					T.CreateBWTextTimer(ef, dif, index, v, hl, args.role, args.tip, args.key, args.dur, args.addon_only)
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
				
				local dif = args.dif or {["all"] = true}
				local color = args.color or {1, 1, 0}
				
				if args.type == "hp" then
					T.CreateHealthText(ef, dif, index, v, args.role, args.data)
				elseif args.type == "pp" then
					T.CreatePowerText(ef, dif, index, v, args.role, args.data)
				elseif args.type == "spell" then
					T.CreateNoneCloneText(ef, dif, index, v, args.role, args.events, args.update, color)
				elseif args.type == "spell_clone" then
					T.CreateSelfCloneText(ef, dif, index, v, args.role, args.events, args.update, args.dur, color)
				end
			end	
		elseif Alert_Type == "HLOnRaid" then -- 已改
			for i, args in pairs(Alerts) do
				
				local v = args.type.."_"..args.spellID..(args.Glow and "_Glow" or "")
				
				local dif = args.dif or {["all"] = true}
				
				T.Create_HL_EventFrame(ef, dif, index, v, args.role, args.stack, args.arg, args.amount)
			end
			
		elseif Alert_Type == "PlateAlert" then -- 已改
			for i, args in pairs(Alerts) do
				if args.type == "PlatePower" or args.type == "PlateNpcID" then
					if not G.Plate_Alerts[args.type] then
						G.Plate_Alerts[args.type] = {}
					end
					if not G.Plate_Alerts[args.type][args.mobID] then
						G.Plate_Alerts[args.type][args.mobID] = {}
						if args.type == "PlateNpcID" then
							G.Plate_Alerts[args.type][args.mobID]["color"] = args.color or {1,0,0,1}
						end
					end
					
					T.Create_PlateAlert_Options(ef, args.mobID, args.role, args.type)
					
				else -- 光环或施法，有法术id
					if not G.Plate_Alerts[args.type] then
						G.Plate_Alerts[args.type] = {}
					end
					if not G.Plate_Alerts[args.type][args.spellID] then
						G.Plate_Alerts[args.type][args.spellID] = {}
						if args.type == "PlateAuras" then
							G.Plate_Alerts[args.type][args.spellID]["color"] = args.color or {0,1,0,1}
							G.Plate_Alerts[args.type][args.spellID]["hl_np"] = args.hl_np
						elseif args.type == "PlayerAuraSource" then
							G.Plate_Alerts[args.type][args.spellID]["color"] = args.color or {1,1,0,1}
						elseif args.type == "PlateSpells" then
							G.Plate_Alerts[args.type][args.spellID]["color"] = args.color or {0,1,1,1}
							G.Plate_Alerts[args.type][args.spellID]["hl_np"] = args.hl_np
						end
					end
					
					T.Create_PlateAlert_Options(ef, args.spellID, args.role, args.type, args.mobID, args.hl_np)
				
				end			
			end
		elseif Alert_Type == "ChatMsg" then -- 已改
			for i, args in pairs(Alerts) do			

				if not G.Msgs[args.type] then
					G.Msgs[args.type] = {}
				end
				if not G.Msgs[args.type][args.spellID] then
					G.Msgs[args.type][args.spellID] = {
						playername = args.playername,
						spellname = args.spellname,
						icon = args.icon,
						range = args.range,
						range_event = args.range_event,
						addon_only = args.addon_only,
						advance = args.advance,
						show_stack = args.show_stack,
						show_dur = args.show_dur,
					}
				end
				
				T.Create_ChatMsg_Options(ef, args.spellID, args.role, args.type)
				
			end
		elseif Alert_Type == "Sound" then -- 已改
			for i, args in pairs(Alerts) do
				local tag, file
				if args.event == "COMBAT_LOG_EVENT_UNFILTERED" then
					tag = args.spellID..G.sound_suffix[args.sub_event][1]
				else
					tag = args.spellID..G.sound_suffix[args.event][1]
				end
				
				if args.event == "CHAT_MSG_MONSTER_YELL" or args.event == "CHAT_MSG_RAID_BOSS_EMOTE" then
					G.boss_msg_spell[args.msg] = args.spellID -- 对应boss喊话的关键词和法术ID 
				end
				
				if args.event == "BW_AND_DBM_TEXT" then
					G.bw_sound_keyword[args.key] = args.spellID -- 对应bw计时条关键词和法术ID
				end
				
				-- 声音文件
				if G.shared_sound[tag] then
					file = G.media.sounds..G.shared_sound[tag]..".ogg"
				elseif args.event == "BW_AND_DBM_SPELL" or args.event == "BW_AND_DBM_TEXT" then
					file = G.media.sounds..args.spellID.."pp.ogg"
				else
					file = G.media.sounds..tag..".ogg"
				end
				
				if not G.Sounds[tag] then
					G.Sounds[tag] = {
						["unit"] = args.unit,
						["soundfile"] = file,
						["countdown"] = args.countdown,
						["dur"] = args.dur,
					}
				end
				
				T.Create_Sound_Options(ef, tag, args.role, args.event, args.sub_event, args.spellID, args.addon_only)
			end
		elseif Alert_Type == "HP_Watch" then -- 已改
			for i, args in pairs(Alerts) do
				T.Create_DefenseSpell_Options(ef, args.spellID)
			end
		elseif Alert_Type == "Phase_Change" then -- 已改
			for i, args in pairs(Alerts) do
				T.Create_Phase_Options(ef, i, args.empty, args.sub_event, args.spellID)
			end
		end
	end
end
----------------------------------------------------------
-----------------[[        GUI        ]]------------------
----------------------------------------------------------

local gui = CreateFrame("Frame", addon_name.."_GUI", UIParent)
gui:SetSize(800, 730)
gui:SetScale(1)
gui:SetPoint("CENTER", UIParent, "CENTER")
gui:SetFrameStrata("HIGH")
gui:SetFrameLevel(2)
gui:Hide()

gui:RegisterForDrag("LeftButton")
gui:SetScript("OnDragStart", function(self) self:StartMoving() end)
gui:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
gui:SetClampedToScreen(true)
gui:SetMovable(true)
gui:SetUserPlaced(true)
gui:EnableMouse(true)
T.createborder(gui)

gui.title = T.createtext(gui, "OVERLAY", 20, "OUTLINE", "CENTER")
gui.title:SetPoint("BOTTOM", gui, "TOP", 0, -10)
gui.title:SetText(G.addon_cname)

gui.close = CreateFrame("Button", nil, gui)
gui.close:SetPoint("BOTTOMRIGHT", -3, 3)
gui.close:SetSize(20, 20)
gui.close:SetNormalTexture("Interface\\BUTTONS\\UI-GroupLoot-Pass-Up")
gui.close:SetHighlightTexture("Interface\\BUTTONS\\UI-GroupLoot-Pass-Highlight")
gui.close:SetPushedTexture("Interface\\BUTTONS\\UI-GroupLoot-Pass-Down")
gui.close:SetPushedTextOffset(3, 3)
gui.close:SetScript("OnClick", function() gui:Hide() end)

gui.bot_line = gui:CreateTexture(nil, "ARTWORK")
gui.bot_line:SetSize(gui:GetWidth()-50, 1)
gui.bot_line:SetPoint("BOTTOMLEFT", gui, "BOTTOMLEFT", 20, 30)
gui.bot_line:SetColorTexture(1, 1, 0, .5)

gui.updatebutton = T.createUIPanelButton(gui, addon_name.."UpdateButton", 50, 20, L["更新"])
gui.updatebutton:SetPoint("TOPLEFT", gui.bot_line, "BOTTOMLEFT", 0, -5)
gui.updatebutton:SetScript("OnClick", function()
	StaticPopupDialogs[G.addon_name.."Update"].text = L["复制"]	
	StaticPopup_Show(G.addon_name.."Update")
end)

gui.bot_text = T.createtext(gui, "OVERLAY", 15, "OUTLINE", "CENTER")
gui.bot_text:SetPoint("LEFT", gui.updatebutton, "RIGHT", 10, 0)
gui.bot_text:SetText(string.format("%s %s(%s) by Skyline", G.addon_name, G.Version, G.NumVersion))
gui.bot_text:SetTextColor(1, 1, 0)
G.gui = gui


----------------------------------------------------------
--------------[[     General Settings     ]]--------------
----------------------------------------------------------
gui.tabindex = 1
gui.tabnum = 20
for i = 1, 20 do
	gui["tab"..i] = CreateFrame("Frame", addon_name.."GUI Tab"..i, gui)
	gui["tab"..i]:SetScript("OnMouseDown", function() end)
end

local options = T.CreateOptions(L["通用"], gui, true)

T.CreateTitle(options.sfa, L["通用"], -20, -170)

local resetposbutton = T.createUIPanelButton(options.sfa, addon_name.."ResetPosButton", 150, 25, L["重置位置"])
resetposbutton:SetFrameLevel(options.sfa:GetFrameLevel()+4)
resetposbutton:SetPoint("TOPLEFT", options.sfa, "TOPLEFT", 50, -50)
resetposbutton:SetScript("OnClick", function()
	StaticPopupDialogs[G.addon_name.."Reset Positions Confirm"].text = L["重置位置确认"]
	StaticPopupDialogs[G.addon_name.."Reset Positions Confirm"].OnAccept = function()
		T.ResetAll()
	end
	StaticPopup_Show(G.addon_name.."Reset Positions Confirm")
end)

local unlockbutton = T.createUIPanelButton(options.sfa, G.addon_name.."UnlockAllFramesButton", 150, 25, L["解锁框体"])
unlockbutton:SetFrameLevel(options.sfa:GetFrameLevel()+4)
unlockbutton:SetPoint("LEFT", resetposbutton, "RIGHT", 10, 0)
unlockbutton:SetScript("OnClick", function()
	T.UnlockCurrentBoss()
end)

local resetbutton = T.createUIPanelButton(options.sfa, G.addon_name.."ResetButton", 150, 25, L["重置所有设置"])
resetbutton:SetFrameLevel(options.sfa:GetFrameLevel()+4)
resetbutton:SetPoint("LEFT", unlockbutton, "RIGHT", 10, 0)
resetbutton:SetScript("OnClick", function()
	StaticPopupDialogs[G.addon_name.."Reset Settings Confirm"].text = L["重置所有设置确认"]
	StaticPopupDialogs[G.addon_name.."Reset Settings Confirm"].button1 = L["启用所有"]
	StaticPopupDialogs[G.addon_name.."Reset Settings Confirm"].button2 = L["禁用所有"]
	StaticPopupDialogs[G.addon_name.."Reset Settings Confirm"].button3 = L["职责启用"]
	
	StaticPopupDialogs[G.addon_name.."Reset Settings Confirm"].OnButton1 = function()
		--print(L["启用所有"])
		SoD_DB["resetmode"] = "enable"
		SoD_CDB = nil
		ReloadUI()
	end
	StaticPopupDialogs[G.addon_name.."Reset Settings Confirm"].OnButton2 = function()
		--print(L["禁用所有"])
		SoD_DB["resetmode"] = "disable"
		SoD_CDB = nil
		ReloadUI()
	end
	StaticPopupDialogs[G.addon_name.."Reset Settings Confirm"].OnButton3 = function()
		--print(L["职责启用"])
		SoD_DB["resetmode"] = "spec"
		SoD_CDB = nil		
		ReloadUI()
	end
	StaticPopupDialogs[G.addon_name.."Reset Settings Confirm"].OnButton4 = function(self)
		--print(CANCEL)
		self:Hide()	
	end
	StaticPopup_Show(G.addon_name.."Reset Settings Confirm")
end)

local testbutton = T.createUIPanelButton(options.sfa, G.addon_name.."TestButton", 150, 25, L["测试"])
testbutton:SetFrameLevel(options.sfa:GetFrameLevel()+4)
testbutton:SetPoint("LEFT", resetbutton, "RIGHT", 10, 0)
testbutton:SetScript("OnClick", function()
	for k, frame in pairs(G.Test) do
		frame.StartTest()
	end
end)

options.Golbal_disable_all = createcheckbutton(options.sfa, 50, -90, L["禁用插件"], "General", false, "disable_all")
options.Golbal_disable_all.apply = function() T.UpdateAll() end

options.Sound_enable = createcheckbutton(options.sfa, 210, -90, MUTE, "General", false, "disable_sound")

options.Mark_enable = createcheckbutton(options.sfa, 370, -90, L["禁用团队标记"], "General", false, "disable_rmark")

options.Minimapbutton_enable = createcheckbutton(options.sfa, 530, -90, L["隐藏小地图图标"], "General", false, "hide_minimap")
options.Minimapbutton_enable.apply = function() T.ToggleMinimapButton() end

options.short_name = createcheckbutton(options.sfa, 50, -140, L["缩写名字"], "General", false, "short_name")
options.name_length = createslider(options.sfa, 210, -145, L["缩写时名字长度"], "General", false, "name_length", 1, 6, 1)

T.CreateTitle(options.sfa, L["图标提示"], -180, -380)

options.AlertFrame_enable = createcheckbutton(options.sfa, 50, -210, L["启用"], "AlertFrame", false, "enable")
options.AlertFrame_enable.apply = function() T.EditAlertFrame("enable") end

options.AlertFrame_spellname = createcheckbutton(options.sfa, 210, -210, L["显示法术名字"], "AlertFrame", false, "show_spellname")
options.AlertFrame_spellname.apply = function() T.EditAlertFrame("spelltext") end

options.AlertFrame_cdreverse = createcheckbutton(options.sfa, 370, -210, L["反转冷却"], "AlertFrame", false, "reverse_cooldown")
options.AlertFrame_cdreverse.apply = function() T.EditAlertFrame("cdreverse") end

local growdirection_group = {
	{"RIGHT",  L["左"]},	
	{"LEFT",   L["右"]},
	{"BOTTOM", L["上"]},
	{"TOP",    L["下"]},	
}

options.AlertFrame_icon_size = createslider(options.sfa, 80, -260, L["图标大小"], "AlertFrame", false, "icon_size", 40, 100, 1)
options.AlertFrame_icon_size.apply = function() T.EditAlertFrame("icon_size") end

options.AlertFrame_icon_space = createslider(options.sfa, 400, -260, L["图标间距"], "AlertFrame", false, "icon_space", 0, 20, 1)
options.AlertFrame_icon_space.apply = function() T.EditAlertFrame("icon_space") end

options.AlertFrame_font_size = createslider(options.sfa, 80, -300, L["大字体大小"], "AlertFrame", false, "font_size", 15, 30, 1)
options.AlertFrame_font_size.apply = function() T.EditAlertFrame("font_size") end

options.AlertFrame_ifont_size = createslider(options.sfa, 400, -300, L["小字体大小"], "AlertFrame", false, "ifont_size", 10, 20, 1)
options.AlertFrame_ifont_size.apply = function() T.EditAlertFrame("ifont_size") end

options.AlertFrame_grow_dir = createradiobuttongroup(options.sfa, 50, -340, L["排列方向"], "AlertFrame", false, "grow_dir", growdirection_group)
options.AlertFrame_grow_dir.apply = function() T.EditAlertFrame("grow_dir") end

T.CreateTitle(options.sfa, L["团队高亮图标"], -390, -540)

options.HL_Frame_enable = createcheckbutton(options.sfa, 50, -420, L["启用"], "HL_Frame", false, "enable")

options.HL_Frame_icon_size = createslider(options.sfa, 80, -470, L["图标大小"], "HL_Frame", false, "iconSize", 15, 40, 1)

options.HL_Frame_icon_alpha = createslider(options.sfa, 400, -470, L["图标透明度"], "HL_Frame", false, "iconAlpha", 10, 100, 1)

local anchors = {
	{"CENTER",		 L["中间"]}, 
	{"LEFT",		 L["左"]},
	{"RIGHT",		 L["右"]},
	{"TOP", 		 L["上"]},
	{"BOTTOM",		 L["下"]},
	{"TOPLEFT",		 L["左上"]},
	{"TOPRIGHT",	 L["右上"]},
	{"BOTTOMLEFT",	 L["左下"]},
	{"BOTTOMRIGHT",	 L["右下"]},
}

options.HL_Frame_position = createradiobuttongroup(options.sfa, 50, -510, L["锚点"], "HL_Frame", false, "position", anchors)
options.HL_Frame_position.apply = function() T.EditHL() end

T.CreateTitle(options.sfa, L["姓名板图标"], -550, -710)

options.PlateAlerts_enable = createcheckbutton(options.sfa, 50, -580, L["启用"], "PlateAlerts", false, "enable")
options.PlateAlerts_enable.apply = function() T.EditPlateIcons("enable") end

options.PlateAlerts_size = createslider(options.sfa, 80, -630, L["图标大小"], "PlateAlerts", false, "size", 20, 50, 1)
options.PlateAlerts_size.apply = function() T.EditPlateIcons("icon_size") end

options.PlateAlerts_fsize = createslider(options.sfa, 400, -630, L["字体大小"], "PlateAlerts", false, "fsize", 6, 16, 1)
options.PlateAlerts_fsize.apply = function() T.EditPlateIcons("font_size") end

options.PlateAlerts_y = createslider(options.sfa, 80, -670, L["垂直距离"], "PlateAlerts", false, "y", -50, 50, 1)
options.PlateAlerts_y.apply = function() T.EditPlateIcons("y") end

T.CreateTitle(options.sfa, L["文字提示"], -720, -830)

options.PlateAlerts_enable = createcheckbutton(options.sfa, 50, -750, L["启用"], "TextFrame", false, "enable")
options.PlateAlerts_enable.apply = function() T.EditTextFrame("enable") end

options.TextFrame_font_size = createslider(options.sfa, 80, -800, L["字体大小"], "TextFrame", false, "font_size", 20, 80, 1)
options.TextFrame_font_size.apply = function() T.EditTextFrame("font_size") end

T.CreateTitle(options.sfa, L["喊话提示"], -850, -970)

options.ChatMsg_enable = createcheckbutton(options.sfa, 50, -880, L["启用"], "ChatMsg", false, "enable")
options.ChatMsg_customfontsize = createcheckbutton(options.sfa, 210, -880, L["变更字体大小"], "ChatMsg", false, "custom_fsize")
options.ChatMsg_customfontsize.apply = function() 
	if SoD_CDB["ChatMsg"]["custom_fsize"] then
		ChatBubbleFont:SetFont(G.Font, SoD_CDB["ChatMsg"]["fsize"], "OUTLINE")
	else
		ChatBubbleFont:SetFont(G.ChatFont, G.ChatFointsize, G.ChatOutline)
	end
end

options.ChatMsg_fsize = createslider(options.sfa, 80, -930, L["字体大小"], "ChatMsg", false, "fsize", 10, 30, 2)


T.CreateTitle(options.sfa, L["首领模块"], -980, -1110)

options.BossMods_enable = createcheckbutton(options.sfa, 50, -1010, L["启用"], "BM", false, "enable")
options.BossMods_enable.apply = function() T.EditBossModsFrame("enable") end

options.BossMods_scale = createslider(options.sfa, 80, -1060, L["尺寸"], "BM", false, "scale", 50, 200, 1)
options.BossMods_scale.apply = function() T.EditBossModsFrame("scale") end

options.import = T.createUIPanelButton(options, addon_name.."ImportButton", 50, 20, L["导入"])
options.import:SetPoint("TOPRIGHT", gui.bot_line, "BOTTOMRIGHT", 0, -5)
options.import:SetScript("OnClick", function()
	StaticPopupDialogs[G.addon_name.."Import"].OnAccept = function(self)
		local str = self.editBox:GetText()
		T.ImportSettings(str)
	end
	StaticPopup_Show(G.addon_name.."Import")
end)

options.export = T.createUIPanelButton(options, addon_name.."ExportButton", 50, 20, L["导出"])
options.export:SetPoint("RIGHT", options.import, "LEFT", -5, 0)
options.export:SetScript("OnClick", function()
	StaticPopup_Show(G.addon_name.."Export")
end)

----------------------------------------------------------
-----------------[[     Raid Tools     ]]-----------------
----------------------------------------------------------
local tool_options = T.CreateOptions(L["小工具"], gui, true)

T.CreateTitle(tool_options.sfa, L["团队标记提示"], -20, -110)

tool_options.rm_enable = createcheckbutton(tool_options.sfa, 50, -50, L["启用"], "General", false, "rm")

tool_options.rm_sound = createcheckbutton(tool_options.sfa, 250, -50, L["播放语音"], "General", false, "rm_sound")

T.CreateTitle(tool_options.sfa, L["焦点传送门可交互提示"], -120, -210)

tool_options.ts_enable = createcheckbutton(tool_options.sfa, 50, -150, L["启用"], "General", false, "trans")
tool_options.ts_enable.apply = function()
	G.TransFrame.Update(G.TransFrame, "SOD_UPDATE_DB")
end

tool_options.ts_sound = createcheckbutton(tool_options.sfa, 250, -150, L["播放语音"], "General", false, "trans_sound")

T.CreateTitle(tool_options.sfa, L["动态战术板"], -220, -630)
		
tool_options.tl_enable = createcheckbutton(tool_options.sfa, 50, -250, L["启用"], "General", false, "tl")
tool_options.tl_enable.apply = function() T.EditTimeline("enable") end

tool_options.tl_use_raid = createcheckbutton(tool_options.sfa, 250, -255, L["团队战术板"], "General", false, "tl_use_raid")
tool_options.tl_use_self = createcheckbutton(tool_options.sfa, 470, -255, L["个人战术板"], "General", false, "tl_use_self")

tool_options.tl_show_time = createcheckbutton(tool_options.sfa, 50, -290, L["显示战术板时间"], "General", false, "tl_show_time")
tool_options.tl_show_time.apply = function() T.EditTimeline("format") end

tool_options.tl_exp_time = createcheckbutton(tool_options.sfa, 250, -290, L["显示倒数时间"], "General", false, "tl_exp_time")
tool_options.tl_exp_time.apply = function() T.EditTimeline("format") end

tool_options.tl_font_size = createslider(tool_options.sfa, 80, -340, L["字体大小"], "General", false, "tl_font_size", 10, 30, 1)
tool_options.tl_font_size.apply = function() T.EditTimeline("font_size") end

tool_options.tl_advance = createslider(tool_options.sfa, 400, -340, L["提前时间"], "General", false, "tl_advance", 2, 120, 1)

tool_options.tl_dur = createslider(tool_options.sfa, 80, -390, L["持续时间"], "General", false, "tl_dur", 2, 20, 1)

tool_options.tl_show_bar = createcheckbutton(tool_options.sfa, 50, -430, L["显示计时条"], "General", false, "tl_show_bar")
tool_options.tl_show_bar.apply = function() T.EditTimeline("bar") end


tool_options.tl_only_my_bar = createcheckbutton(tool_options.sfa, 250, -430, L["只显示我的计时条"], "General", false, "tl_only_my_bar")

tool_options.tl_bar_sound = createcheckbutton(tool_options.sfa, 470, -430, L["语音提示我的技能"], "General", false, "tl_bar_sound")

tool_options.tl_my_name = T.createUIPanelButton(tool_options.sfa, addon_name.."tl_my_name Button", 18, 18, "")
tool_options.tl_my_name:SetPoint("TOPLEFT", tool_options.sfa, "TOPLEFT", 55, -473)

tool_options.tl_my_name.tex = tool_options.tl_my_name:CreateTexture(nil, "OVERLAY")
tool_options.tl_my_name.tex:SetAllPoints()
tool_options.tl_my_name.tex:SetTexture(134520)
tool_options.tl_my_name.tex:SetTexCoord(.1, .9, .1, .9)

tool_options.tl_my_name.text = T.createtext(tool_options.tl_my_name, "OVERLAY", 14, "OUTLINE", "LEFT")
tool_options.tl_my_name.text:SetPoint("LEFT", tool_options.tl_my_name, "RIGHT", 3, 0)

tool_options.tl_my_name.update_names = function()
	local storename = {string.split(" ", SoD_CDB["General"]["tl_bar_mynickname"])}
	local nickname = {}
	for i, name in pairs(storename) do
		if name ~= "" then
			table.insert(nickname, name)
		end
	end
	local str
	if #nickname > 0 then
		str = T.utf8sub(table.concat(nickname, " "), 25, nil, true)
	else
		str = L["无昵称"]
	end
	tool_options.tl_my_name.text:SetText(string.format(L["我的昵称"], str))
end

tool_options.tl_my_name:SetScript("OnShow", tool_options.tl_my_name.update_names)
tool_options.tl_my_name:SetScript("OnClick", function()
	StaticPopupDialogs[G.addon_name.."My Nick Name"].OnAccept = function(self)
		SoD_CDB["General"]["tl_bar_mynickname"] = self.editBox:GetText()
		tool_options.tl_my_name.update_names()
		T.EditTimeline("name")
	end
	
	StaticPopup_Show(G.addon_name.."My Nick Name")
end)

tool_options.view_support_spell = T.createUIPanelButton(tool_options.sfa, addon_name.."view_support_spell Button", 18, 18, "")
tool_options.view_support_spell:SetPoint("TOPLEFT", tool_options.sfa, "TOPLEFT", 475, -473)

tool_options.view_support_spell.tex = tool_options.view_support_spell:CreateTexture(nil, "OVERLAY")
tool_options.view_support_spell.tex:SetAllPoints()
tool_options.view_support_spell.tex:SetTexture(237586)
tool_options.view_support_spell.tex:SetTexCoord(.1, .9, .1, .9)

tool_options.view_support_spell.text = T.createtext(tool_options.view_support_spell, "OVERLAY", 14, "OUTLINE", "LEFT")
tool_options.view_support_spell.text:SetPoint("LEFT", tool_options.view_support_spell, "RIGHT", 3, 0)
tool_options.view_support_spell.text:SetText(L["查看支持的技能"])

tool_options.view_support_spell.frame = CreateFrame("Frame", nil, gui)
tool_options.view_support_spell.frame:SetPoint("TOPRIGHT", gui, "TOPLEFT", -5, 0)
tool_options.view_support_spell.frame:SetPoint("BOTTOMLEFT", gui, "BOTTOMLEFT", -350, 0)
T.createborder(tool_options.view_support_spell.frame)
tool_options.view_support_spell.frame:Hide()

tool_options.view_support_spell.frame.sf = CreateFrame("ScrollFrame", G.addon_name.."view_support_spell ScrollFrame", tool_options.view_support_spell.frame, "UIPanelScrollFrameTemplate")
tool_options.view_support_spell.frame.sf:SetPoint("TOPLEFT", tool_options.view_support_spell.frame, "TOPLEFT", 10, -10)
tool_options.view_support_spell.frame.sf:SetPoint("BOTTOMRIGHT", tool_options.view_support_spell.frame, "BOTTOMRIGHT", -30, 10)
tool_options.view_support_spell.frame.sf:SetFrameLevel(tool_options.view_support_spell.frame:GetFrameLevel()+1)

tool_options.view_support_spell.frame.sfa = CreateFrame("Frame", G.addon_name.."view_support_spell ScrollAnchor", tool_options.view_support_spell.frame.sf)
tool_options.view_support_spell.frame.sfa:SetPoint("TOPLEFT", tool_options.view_support_spell.frame.sf, "TOPLEFT", 0, -3)
tool_options.view_support_spell.frame.sfa:SetWidth(tool_options.view_support_spell.frame.sf:GetWidth()-10)
tool_options.view_support_spell.frame.sfa:SetHeight(tool_options.view_support_spell.frame.sf:GetHeight())
tool_options.view_support_spell.frame.sfa:SetFrameLevel(tool_options.view_support_spell.frame.sf:GetFrameLevel()+1)

tool_options.view_support_spell.frame.sf:SetScrollChild(tool_options.view_support_spell.frame.sfa)
tool_options.view_support_spell.frame.sfa.option_num = 0

local spell_type_order = {"RAIDCD", "DAMAGE", "TANK", "HEALING", "BREZ", "IMMUNITY", "HARDCC", "SOFTCC", "STHARDCC", "STSOFTCC", "INTERRUPT", "DISPEL", "COVENANT", "PERSONAL", "EXTERNAL", "UTILITY"}
local function CreateSupportSpellList(parent)
	for _, spell_type in pairs(spell_type_order) do
		local t = G.spells[spell_type]
		CreateSubTitle(parent, L[spell_type], 5, -10)
		
		for spell, v in pairs(t) do
			local bu = CreateFrame("Frame", nil, parent)
			bu:SetPoint("TOPLEFT", parent, "TOPLEFT", 15, - 10 - 30*parent.option_num)
			bu:SetSize(265, 30)
	
			bu.left = T.createtext(bu, "OVERLAY", 14, "OUTLINE", "LEFT")
			bu.left:SetPoint("LEFT", bu, "LEFT", 0, 0)
			
			bu.right = T.createtext(bu, "OVERLAY", 14, "OUTLINE", "RIGHT")
			bu.right:SetPoint("RIGHT", bu, "RIGHT", 0, 0)
			
			local spellID = tonumber(spell)
			if spellID then
				bu.left:SetText(T.GetIconLink(spell))
				bu.right:SetText(spellID)
			elseif G.sharedConfigSpellIDs[spell] then
				bu.left:SetText(T.GetIconLink(G.sharedConfigSpellIDs[spell][1]))
				local spellIDs = table.concat(G.sharedConfigSpellIDs[spell], ",")
				bu.right:SetText(T.utf8sub(spellIDs, 10, nil, true))
				bu.tip = spellIDs
			end
			
			if bu.tip then
				bu:SetScript("OnEnter", function(self) 
					GameTooltip:SetOwner(self, "ANCHOR_RIGHT",  -20, 10)
					GameTooltip:AddLine("spellID:"..self.tip, .8, .5, 1)
					GameTooltip:Show() 
				end)
				bu:SetScript("OnLeave", function(self)
					GameTooltip:Hide()
				end)
			end
			
			if parent.bgtex then
				parent.bgtex:SetPoint("BOTTOMRIGHT", parent, "TOPRIGHT", 0, - 50 - 30*parent.option_num)
			end
			
			parent.option_num = parent.option_num + 1
		end
	end
end

CreateSupportSpellList(tool_options.view_support_spell.frame.sfa)

ReskinScroll(_G[G.addon_name.."view_support_spell ScrollFrameScrollBar"])

tool_options.view_support_spell:SetScript("OnHide", function(self)
	self.frame:Hide()
end)

tool_options.view_support_spell:SetScript("OnClick", function(self)
	if self.frame:IsShown() then
		self.frame:Hide()
	else
		self.frame:Show()
	end
end)

tool_options.tl_bar_width = createslider(tool_options.sfa, 80, -520, L["计时条高度"], "General", false, "tl_bar_width", 200, 800, 5)
tool_options.tl_bar_width.apply = function() T.EditTimeline("bar") end

tool_options.tl_bar_height = createslider(tool_options.sfa, 400, -520, L["计时条宽度"], "General", false, "tl_bar_height", 10, 40, 1)
tool_options.tl_bar_height.apply = function() T.EditTimeline("bar") end

tool_options.tl_bar_sound_dur = createslider(tool_options.sfa, 80, -570, L["语音提示时间"], "General", false, "tl_bar_sound_dur", 2, 10, 1)

T.CreateTitle(tool_options.sfa, L["保命技能"], -640, -820)

tool_options.ds_enable = createcheckbutton(tool_options.sfa, 50, -670, L["启用"], "General", false, "ds")
tool_options.ds_enable.apply = function() T.EditDSFrame("enable") end

tool_options.ds_test = createcheckbutton(tool_options.sfa, 250, -670, L["测试"], "General", false, "ds_test")
tool_options.ds_test.apply = function() T.EditDSFrame("enable") end

tool_options.ds_show_hp = createcheckbutton(tool_options.sfa, 50, -710, L["显示血量百分比"], "General", false, "ds_show_hp")
tool_options.ds_show_hp.apply = function() T.EditDSFrame("show_hp") end

tool_options.ds_color_gradiant = createcheckbutton(tool_options.sfa, 250, -710, L["颜色随血量渐变"], "General", false, "ds_color_gradiant")
tool_options.ds_color_gradiant.apply = function() T.EditDSFrame("color_gradiant") end

tool_options.ds_icon_size = createslider(tool_options.sfa, 80, -760, L["图标大小"], "General", false, "ds_icon_size", 25, 50, 1)
tool_options.ds_icon_size.apply = function() T.EditDSFrame("icon_size") end
	
tool_options.ds_font_size = createslider(tool_options.sfa, 400, -760, L["字体大小"], "General", false, "ds_font_size", 30, 60, 1)
tool_options.ds_font_size.apply = function() T.EditDSFrame("font_size") end


----------------------------------------------------------
---------------[[     Version Check     ]]----------------
----------------------------------------------------------

local vc_frame = CreateFrame("Frame")
C_ChatInfo.RegisterAddonMessagePrefix("sodpaopao")

vc_frame:RegisterEvent("CHAT_MSG_ADDON")
vc_frame:RegisterEvent("PLAYER_LOGIN")
vc_frame:RegisterEvent("GROUP_FORMED")
vc_frame:RegisterEvent("ENCOUNTER_END")
vc_frame.newest = ""
vc_frame.newest_num = 0
vc_frame.raidroster = {}

vc_frame:SetScript("OnEvent", function(self, event, ...)
	if event == "CHAT_MSG_ADDON" then
		local prefix, message, channel, sender = ... 
		
		if prefix == "sodpaopao" then 
			--print(prefix, message, channel, sender)
			if message == "start_vc" then 
				if G.PlayerName == string.split("-", sender) and IsInRaid() then 
					print(G.addon_cname.." Version Check") 
					
					vc_frame.raidroster = table.wipe(vc_frame.raidroster)
					
					C_ChatInfo.SendAddonMessage("sodpaopao", "ver", "RAID") 
					
					for i = 1, 40 do 
						local unitID = "raid"..i 
						local name = UnitName(unitID) 
						if name then 
							self.raidroster[name] = "NO ADDON" 
						end 
					end 
	
					C_Timer.After(2, function() 
						print("-----------------") 
						for name, ver in pairs(self.raidroster) do
							local c_name = "|c"..G.Ccolors[select(2, UnitClass(name))]["colorStr"]..name.." |r"
							print(c_name.."ver: "..ver) 
						end 
					end)
				end 
			elseif message == "ver" then 
				C_ChatInfo.SendAddonMessage("sodpaopao", "send_ver,"..G.PlayerName..","..G.Version..","..G.NumVersion, "RAID")
			else 
				local mark, name, ver, num_ver = string.split(",", message)		
				if mark == "send_ver" then
					num_ver = tonumber(num_ver)
					if UnitInRaid(name) then
						if num_ver then
							self.raidroster[name] = string.format("%s(%s)", ver, num_ver)
						else
							self.raidroster[name] = string.format("%s(%s)", ver, L["早期版本"])
						end
					end
					if num_ver and num_ver > self.newest_num then
						self.newest = ver
						self.newest_num = num_ver
					end		
				end 
			end
		end
	elseif event == "GROUP_FORMED" or event == "ENCOUNTER_END" then
		if IsInGroup() then
			C_ChatInfo.SendAddonMessage("sodpaopao", "ver", IsInRaid() and "RAID" or "PARTY")
			C_Timer.After(5, function()
				local str = string.format(L["过期"], G.addon_cname, G.Version, G.NumVersion, self.newest, self.newest_num)
				if G.NumVersion < self.newest_num then
					if self.newest_num - G.NumVersion > 3000 then -- 超过10天的更新
						StaticPopupDialogs[G.addon_name.."Outdate"].text = str
						StaticPopupDialogs[G.addon_name.."Outdate"].button1 = L["更新"]
						StaticPopupDialogs[G.addon_name.."Outdate"].OnAccept = function()
							StaticPopupDialogs[G.addon_name.."Update"].text = L["复制"]	
							StaticPopup_Show(G.addon_name.."Update")
						end
						StaticPopup_Show(G.addon_name.."Outdate")
					else
						print(str)
					end
				end
			end)
		end
	elseif event == "PLAYER_LOGIN" then
		if IsInGuild() then
			C_ChatInfo.SendAddonMessage("sodpaopao", "ver", "GUILD")
			C_Timer.After(5, function()
				local str = string.format(L["过期"], G.addon_cname, G.Version, G.NumVersion, self.newest, self.newest_num)
				if G.NumVersion < self.newest_num then
					if self.newest_num - G.NumVersion > 3000 then -- 超过10天的更新
						StaticPopupDialogs[G.addon_name.."Outdate"].text = str
						StaticPopupDialogs[G.addon_name.."Outdate"].button1 = L["更新"]
						StaticPopupDialogs[G.addon_name.."Outdate"].OnAccept = function()
							StaticPopupDialogs[G.addon_name.."Update"].text = L["复制"]	
							StaticPopup_Show(G.addon_name.."Update")
						end
						StaticPopup_Show(G.addon_name.."Outdate")
					else
						print(str)
					end
				end
			end)
		end		
	end
end)

----------------------------------------------------------
--------------------[[     CMD     ]]---------------------
----------------------------------------------------------

SLASH_SOD1 = "/sod"
SlashCmdList["SOD"] = function(arg)
	if arg == "vc" then
		C_ChatInfo.SendAddonMessage("sodpaopao", "start_vc", "RAID")
	else
		if gui:IsShown() then
			gui:Hide()
		else
			gui:Show()
		end
	end
end

local MinimapButton = CreateFrame("Button", "SOD_MinimapButton", Minimap)
MinimapButton:SetSize(32,32)
MinimapButton:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight") 
MinimapButton:SetFrameStrata("MEDIUM")
MinimapButton:SetFrameLevel(8)
MinimapButton:SetPoint("CENTER", 12, -80)
MinimapButton:SetDontSavePosition(true)
MinimapButton:RegisterForDrag("LeftButton")

MinimapButton.icon = MinimapButton:CreateTexture(nil, "ARTWORK")
MinimapButton.icon:SetTexture(G.media.logo)
MinimapButton.icon:SetSize(30,30)
MinimapButton.icon:SetPoint("CENTER",-1,2)
MinimapButton.icon:SetTexCoord( .1, .8, 1, .35)

MinimapButton.icon2 = MinimapButton:CreateTexture(nil, "OVERLAY")
MinimapButton.icon2:SetTexture(G.media.logo)
MinimapButton.icon2:SetSize(30,30)
MinimapButton.icon2:SetPoint("CENTER",-1,2)
MinimapButton.icon2:SetTexCoord( .1, .8, 1, .35)
MinimapButton.icon2:SetVertexColor(1,.5,.5,1)
MinimapButton.icon2:Hide()

MinimapButton.bg = MinimapButton:CreateTexture(nil, "BACKGROUND")
MinimapButton.bg:SetTexture("Interface\\CharacterFrame\\TempPortraitAlphaMask")
MinimapButton.bg:SetVertexColor(1, 1, 1)
MinimapButton.bg:SetSize(27,27)
MinimapButton.bg:SetPoint("CENTER",0,0)

MinimapButton.anim = MinimapButton:CreateAnimationGroup()
MinimapButton.anim:SetLooping("BOUNCE")
MinimapButton.timer = MinimapButton.anim:CreateAnimation()
MinimapButton.timer:SetDuration(2)


MinimapButton:SetScript("OnEnter",function(self) 
	GameTooltip:SetOwner(self, "ANCHOR_LEFT") 
	GameTooltip:AddLine(G.addon_cname)
	GameTooltip:Show()
	
	self.timer:SetScript("OnUpdate", function(s,elapsed) 
		self.icon2:SetAlpha(s:GetProgress())
	end)
	self.anim:Play()
	self.icon:Hide()
	self.icon2:Show()
end)

MinimapButton:SetScript("OnLeave", function(self)    
	GameTooltip:Hide()
	
	self.timer:SetScript("OnUpdate", nil)
	self.anim:Stop()
	self.icon:Show()
	self.icon2:Hide()
end)

MinimapButton:SetScript("OnClick", function()
	if gui:IsShown() then
		gui:Hide()
	else
		gui:Show()
	end
end)

local minimapShapes = {
	["ROUND"] = {true, true, true, true},
	["SQUARE"] = {false, false, false, false},
	["CORNER-TOPLEFT"] = {false, false, false, true},
	["CORNER-TOPRIGHT"] = {false, false, true, false},
	["CORNER-BOTTOMLEFT"] = {false, true, false, false},
	["CORNER-BOTTOMRIGHT"] = {true, false, false, false},
	["SIDE-LEFT"] = {false, true, false, true},
	["SIDE-RIGHT"] = {true, false, true, false},
	["SIDE-TOP"] = {false, false, true, true},
	["SIDE-BOTTOM"] = {true, true, false, false},
	["TRICORNER-TOPLEFT"] = {false, true, true, true},
	["TRICORNER-TOPRIGHT"] = {true, false, true, true},
	["TRICORNER-BOTTOMLEFT"] = {true, true, false, true},
	["TRICORNER-BOTTOMRIGHT"] = {true, true, true, false},
}

local function IconMoveButton(self)
	if self.dragMode == "free" then
		local centerX, centerY = Minimap:GetCenter()
		local x, y = GetCursorPosition()
		x, y = x / self:GetEffectiveScale() - centerX, y / self:GetEffectiveScale() - centerY
		self:ClearAllPoints()
		self:SetPoint("CENTER", x, y)
		VMRT.Addon.IconMiniMapLeft = x
		VMRT.Addon.IconMiniMapTop = y
	else
		local mx, my = Minimap:GetCenter()
		local px, py = GetCursorPosition()
		local scale = Minimap:GetEffectiveScale()
		px, py = px / scale, py / scale
		
		local angle = math.atan2(py - my, px - mx)
		local x, y, q = math.cos(angle), math.sin(angle), 1
		if x < 0 then q = q + 1 end
		if y > 0 then q = q + 2 end
		local minimapShape = GetMinimapShape and GetMinimapShape() or "ROUND"
		local quadTable = minimapShapes[minimapShape]
		if quadTable[q] then
			x, y = x*80, y*80
		else
			local diagRadius = 103.13708498985 --math.sqrt(2*(80)^2)-10
			x = math.max(-80, math.min(x*diagRadius, 80))
			y = math.max(-80, math.min(y*diagRadius, 80))
		end
		self:ClearAllPoints()
		self:SetPoint("CENTER", Minimap, "CENTER", x, y)
		VMRT.Addon.IconMiniMapLeft = x
		VMRT.Addon.IconMiniMapTop = y
	end
end

MinimapButton:SetScript("OnDragStart", function(self)
	self:LockHighlight()
	self:SetScript("OnUpdate", IconMoveButton)
	GameTooltip:Hide()
end)

MinimapButton:SetScript("OnDragStop", function(self)
	self:UnlockHighlight()
	self:SetScript("OnUpdate", nil)
end)

T.ToggleMinimapButton = function()
	if SoD_CDB["General"]["hide_minimap"] then
		MinimapButton:Hide()
	else
		MinimapButton:Show()
	end
end