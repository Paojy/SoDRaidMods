﻿local T, C, L, G = unpack(select(2, ...))

local addon_name = G.addon_name
local font = G.Font

T.msg = function(msg)
	print(G.addon_cname.." >"..msg)
end

local day, hour, minute = 86400, 3600, 60
T.FormatTime = function(s)
    if s >= day then
        return format("%dd", floor(s/day + 0.5))
    elseif s >= hour then
        return format("%dh", floor(s/hour + 0.5))
    elseif s >= minute then
        return format("%dm", floor(s/minute + 0.5))
	elseif s >= 2 then
		return format("%ds", s)
	else
		return format("%.1fs", s)
    end
end

T.ShortValue = function(val)
	if type(val) == "number" then
		if G.Client == "zhCN" or G.Client == "zhTW" then
			if (val >= 1e7) then
				return ("%.1fkw"):format(val / 1e7)
			elseif (val >= 1e4) then
				return ("%.1fw"):format(val / 1e4)
			else
				return ("%d"):format(val)
			end
		else
			if (val >= 1e6) then
				return ("%.1fm"):format(val / 1e6)
			elseif (val >= 1e3) then
				return ("%.1fk"):format(val / 1e3)
			else
				return ("%d"):format(val)
			end
		end
	else
		return val
	end
end

T.pairsByKeys = function(t)
    local a = {}
    for n in pairs(t) do table.insert(a, n) end
    table.sort(a)
    local i = 0      -- iterator variable
    local iter = function ()   -- iterator function
		i = i + 1
        if a[i] == nil then return nil
        else return a[i], t[a[i]]
        end
      end
    return iter
end

T.GetIconLink = function(spellID)
	if not GetSpellInfo(spellID) then
		print(spellID.."出错 请检查")
		return ""
	end
	local name, _, icon = GetSpellInfo(spellID)
	return "|T"..icon..":12:12:0:0:64:64:4:60:4:60|t|cff71d5ff["..name.."]|r"
end

T.GetIconLinkRed = function(spellID)
	if not GetSpellInfo(spellID) then
		print(spellID.."出错 请检查")
		return ""
	end
	local name, _, icon = GetSpellInfo(spellID)
	return "|T"..icon..":12:12:0:0:64:64:4:60:4:60|t|cffff0000["..name.."]|r"
end

T.GetSpellIcon = function(spellID)
	if not GetSpellInfo(spellID) then
		print(spellID.."出错 请检查")
		return ""
	end
	local name, _, icon = GetSpellInfo(spellID)
	return "|T"..icon..":12:12:0:0:64:64:4:60:4:60|t"
end

local RTIconsList = {
	"|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_1:0|t", -- 星星
	"|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_2:0|t", -- 大饼
	"|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_3:0|t", -- 菱形
	"|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_4:0|t", -- 三角
	"|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_5:0|t", -- 月亮
	"|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_6:0|t", -- 方块
	"|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_7:0|t", -- 叉叉
	"|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_8:0|t", -- 骷髅
}
G.RTIconsList = RTIconsList

T.ColorUnitName = function(unit, name, nort)	
	local r, g, b = 1, 1, 1
	if UnitIsPlayer(unit) then
		local _, class = UnitClass(unit)
		r, g, b = G.Ccolors[class].r, G.Ccolors[class].g, G.Ccolors[class].b
	else
		local reaction = UnitReaction(unit, "player")
		if reaction then
			r, g, b = FACTION_BAR_COLORS[reaction].r, FACTION_BAR_COLORS[reaction].g, FACTION_BAR_COLORS[reaction].b 
		end
	end
	local rt = GetRaidTargetIndex(unit)
	
	if nort or not rt then
		return ('|cff%02x%02x%02x%s|r'):format(r * 255, g * 255, b * 255, name)
	else
		return (RTIconsList[rt]..'|cff%02x%02x%02x%s|r'):format(r * 255, g * 255, b * 255, name)
	end
end

T.ColorName = function(name)
	if UnitClass(name) then
		return ("|c%s%s|r"):format(G.Ccolors[select(2, UnitClass(name))]["colorStr"], name)
	else
		return name
	end
end

T.SetRaidTarget = function(unit, rm)
	if not SoD_CDB["General"]["disable_rmark"] then
		SetRaidTarget(unit, rm) -- 上标记
	end
end

T.SendChatMsg = function(msg, rp, Channel)
	if SoD_CDB["ChatMsg"]["enable"] then
		local channel
		if select(2, GetInstanceInfo()) == "none" then
			channel = "PARTY"
		elseif Channel then
			channel = Channel
		else
			channel = "SAY"
		end

		SendChatMessage(msg, channel)
		if rp then
			for i = 1, rp do
				C_Timer.After(i, function() SendChatMessage(msg, channel) end)
			end
		end
	end
end

-- Convenience function to do a simple fade in
T.UIFrameFadeIn = function(frame, timeToFade, startAlpha, endAlpha)
	local fadeInfo = {}
	fadeInfo.mode = "IN"
	fadeInfo.timeToFade = timeToFade
	fadeInfo.startAlpha = startAlpha
	fadeInfo.endAlpha = endAlpha
	UIFrameFade(frame, fadeInfo)
end

T.UIFrameFadeOut = function(frame, timeToFade, startAlpha, endAlpha)
	local fadeInfo = {}
	fadeInfo.mode = "OUT"
	fadeInfo.timeToFade = timeToFade
	fadeInfo.startAlpha = startAlpha
	fadeInfo.endAlpha = endAlpha
	UIFrameFade(frame, fadeInfo)
end

T.createborder = function(f, r, g, b, a)
	if f.style then return end
	
	f.sd = CreateFrame("Frame", nil, f, "BackdropTemplate")
	local lvl = f:GetFrameLevel()
	f.sd:SetFrameLevel(lvl == 0 and 1 or lvl - 1)
	f.sd:SetBackdrop({
		bgFile = "Interface\\Buttons\\WHITE8x8",
		edgeFile = "Interface\\AddOns\\SoDRaidMods\\media\\glow",
		edgeSize = 3,
			insets = { left = 3, right = 3, top = 3, bottom = 3,}
		})
	f.sd:SetPoint("TOPLEFT", f, -3, 3)
	f.sd:SetPoint("BOTTOMRIGHT", f, 3, -3)
	if not (r and g and b) then
		f.sd:SetBackdropColor(.05, .05, .05, .5)
		f.sd:SetBackdropBorderColor(0, 0, 0)
	else
		f.sd:SetBackdropColor(r, g, b, a)
		f.sd:SetBackdropBorderColor(0, 0, 0)
	end
	f.style = true
end

T.createbdframe = function(f)
	local bg
	
	if f:GetObjectType() == "Texture" then
		bg = CreateFrame("Frame", nil, f:GetParent(), "BackdropTemplate")
		local lvl = f:GetParent():GetFrameLevel()
		bg:SetFrameLevel(lvl == 0 and 0 or lvl - 1)
	else
		bg = CreateFrame("Frame", nil, f, "BackdropTemplate")
		local lvl = f:GetFrameLevel()
		bg:SetFrameLevel(lvl == 0 and 0 or lvl - 1)
	end
	
	bg:SetPoint("TOPLEFT", f, -3, 3)
	bg:SetPoint("BOTTOMRIGHT", f, 3, -3)
	
	bg:SetBackdrop({
		bgFile = "Interface\\Buttons\\WHITE8x8",
		edgeFile = "Interface\\AddOns\\SoDRaidMods\\media\\glow",
		edgeSize = 3,
			insets = { left = 3, right = 3, top = 3, bottom = 3,}
		})
		
	bg:SetBackdropColor(.05, .05, .05, .5)
	bg:SetBackdropBorderColor(0, 0, 0)
	
	return bg
end

T.createtext = function(frame, layer, fontsize, flag, justifyh, shadow)
	local text = frame:CreateFontString(nil, layer)
	text:SetFont(font, fontsize, flag)
	text:SetJustifyH(justifyh)
	--text:SetWidth(2000)
	
	if shadow then
		text:SetShadowColor(0, 0, 0)
		text:SetShadowOffset(1, -1)
	end
	
	return text
end

T.createUIPanelButton = function(parent, name, width, height, text)
	local button = CreateFrame("Button", name, parent)
	button:SetSize(width, height)
	T.createborder(button)	
	
	button.text = T.createtext(button, "OVERLAY", 12, "OUTLINE", "CENTER")
	button.text:SetText(text)
	button.text:SetPoint("CENTER")

	button:SetScript("OnEnter", function()
		button.text:SetTextColor(1, 1, 0)
		button.sd:SetBackdropColor(1, 1, 0, 0.2)
		button.sd:SetBackdropBorderColor(1, 1, 0)
	end)
 	button:SetScript("OnLeave", function()
		button.text:SetTextColor(1, 1, 1)
		button.sd:SetBackdropColor(.05, .05, .05, .5)
		button.sd:SetBackdropBorderColor(0, 0, 0)
	end)
	button:SetScript("OnEnable", function()
		if button:IsMouseOver() then
			button.text:SetTextColor(1, 1, 0)
			button.sd:SetBackdropColor(1, 1, 0, 0.2)
			button.sd:SetBackdropBorderColor(1, 1, 0)
		else
			button.text:SetTextColor(1, 1, 1)
			button.sd:SetBackdropColor(.05, .05, .05, .5)
			button.sd:SetBackdropBorderColor(0, 0, 0)	
		end
	end)
	button:SetScript("OnDisable", function()
		button.text:SetTextColor(.5, .5, .5)
		button.sd:SetBackdropColor(.5, .5, .5, .7)
		button.sd:SetBackdropBorderColor(0, 0, 0)
	end)
	return button
end

T.FindRaidFrame = function(target)
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
                    return f
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
                            return f
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
                            return f
                        end
                    end
                end
            end
        end
    elseif hasVuhDo then
        for i = 1, 40 do
            local f = _G["Vd1H"..i]
            if f and f.raidid and UnitName(f.raidid) == target then
				return f
            end
        end
    elseif hasAltzUI then
        for i = 1, 40 do
            local f = _G["Altz_HealerRaidUnitButton"..i]
            if f and f.unit and UnitName(f.unit) == target then
                return f
            end
        end
	elseif hasNDui then
		for i =1, 8 do 
            for j = 1, 5 do
                local f = _G["oUF_Raid"..i.."UnitButton"..j]
                if f and f.unit and UnitName(f.unit) == target then
                    return f
                end
            end
        end
    elseif hasCompactRaid then
        for i =1, 8 do 
            for j = 1, 5 do
                local f = _G["CompactRaidGroupHeaderSubGroup"..i.."UnitButton"..j]
                if f and f.unit and UnitName(f.unit) == target then
                    return f
                end
            end
        end
    else
        for i=1, 40 do
            local f = _G["CompactRaidFrame"..i]
            if f and f.unitExists and f.unit and UnitName(f.unit) == target then
                return f
            end
        end
        for i=1, 4 do
            for j=1, 5 do
                local f = _G["CompactRaidGroup"..i.."Member"..j]
                if f and f.unitExists and f.unit and UnitName(f.unit) == target then
                   return f
                end
            end
        end
    end
	
end

T.GlowRaidFrame_Show = function(target, tag, r, g, b, dur)
	local f = T.FindRaidFrame(target)
	if f then
		if not f.glow_frames then
			f.glow_frames = {}
		end
		
		if not f.glow_frames[tag] then
			f.glow_frames[tag] = CreateFrame("Frame", nil, f, "BackdropTemplate")
			f.glow_frames[tag]:SetPoint("TOPLEFT", -10, 10)
			f.glow_frames[tag]:SetPoint("BOTTOMRIGHT", 10, -10)
			f.glow_frames[tag]:SetBackdrop({
							bgFile = "Interface\\Buttons\\WHITE8x8",
							edgeFile = "Interface\\AddOns\\SoDRaidMods\\media\\glow",
							edgeSize = 10,
								insets = { left = 10, right = 10, top = 10, bottom = 10,}
						})
						
			if r and g and b then
				f.glow_frames[tag]:SetBackdropColor(0, 0, 0, 0)
				f.glow_frames[tag]:SetBackdropBorderColor(r, g, b)
			else
				f.glow_frames[tag]:SetBackdropColor(0, 0, 0, 0)
				f.glow_frames[tag]:SetBackdropBorderColor(1, 1, .8)
			end
		end
		
		f.glow_frames[tag]:Show()
		
		if dur then
			C_Timer.After(dur, function()
				f.glow_frames[tag]:Hide()
			end)
		end
	end
end

T.GlowRaidFrame_Hide = function(target, tag)
	local f = T.FindRaidFrame(target)
	if f and f.glow_frames and f.glow_frames[tag] then
		f.glow_frames[tag]:Hide()
	end
end

T.GlowRaidFrame_HideAll = function(tag)
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
				if f and f.glow_frames then
					if tag then
						if f.glow_frames[tag] then
							f.glow_frames[tag]:Hide()
						end
					else
						for k, v in pairs(f.glow_frames) do
							v:Hide()
						end
					end
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
                        if f and f.glow_frames then
							if tag then
								if f.glow_frames[tag] then
									f.glow_frames[tag]:Hide()
								end
							else
								for k, v in pairs(f.glow_frames) do
									v:Hide()
								end
							end
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
                        if f and f.glow_frames then
							if tag then
								if f.glow_frames[tag] then
									f.glow_frames[tag]:Hide()
								end
							else
								for k, v in pairs(f.glow_frames) do
									v:Hide()
								end
							end
						end
                    end
                end
            end
        end
    elseif hasVuhDo then
        for i = 1, 40 do
            local f = _G["Vd1H"..i]
            if f and f.glow_frames then
				if tag then
					if f.glow_frames[tag] then
						f.glow_frames[tag]:Hide()
					end
				else
					for k, v in pairs(f.glow_frames) do
						v:Hide()
					end
				end
			end
        end
    elseif hasAltzUI then
        for i = 1, 40 do
            local f = _G["Altz_HealerRaidUnitButton"..i]
            if f and f.glow_frames then
				if tag then
					if f.glow_frames[tag] then
						f.glow_frames[tag]:Hide()
					end
				else
					for k, v in pairs(f.glow_frames) do
						v:Hide()
					end
				end
			end
        end
	elseif hasNDui then
		for i =1, 8 do 
            for j = 1, 5 do
                local f = _G["oUF_Raid"..i.."UnitButton"..j]
                if f and f.glow_frames then
					if tag then
						if f.glow_frames[tag] then
							f.glow_frames[tag]:Hide()
						end
					else
						for k, v in pairs(f.glow_frames) do
							v:Hide()
						end
					end
				end
            end
        end
    elseif hasCompactRaid then
        for i =1, 8 do 
            for j = 1, 5 do
                local f = _G["CompactRaidGroupHeaderSubGroup"..i.."UnitButton"..j]
                if f and f.glow_frames then
					if tag then
						if f.glow_frames[tag] then
							f.glow_frames[tag]:Hide()
						end
					else
						for k, v in pairs(f.glow_frames) do
							v:Hide()
						end
					end
				end
            end
        end
    else
        for i=1, 40 do
            local f = _G["CompactRaidFrame"..i]
            if f and f.glow_frames then
				if tag then
					if f.glow_frames[tag] then
						f.glow_frames[tag]:Hide()
					end
				else
					for k, v in pairs(f.glow_frames) do
						v:Hide()
					end
				end
			end
        end
        for i=1, 4 do
            for j=1, 5 do
                local f = _G["CompactRaidGroup"..i.."Member"..j]
				if f and f.glow_frames then
					if tag then
						if f.glow_frames[tag] then
							f.glow_frames[tag]:Hide()
						end
					else
						for k, v in pairs(f.glow_frames) do
							v:Hide()
						end
					end
				end
            end
        end
    end
end

local rangecheck_items = {
	[5] = 8149,
	[7] = 61323,
	[8] = 34368,
}

T.RangeCheck = function(range)
	for i = 0, 2 do
		C_Timer.After(i, function()
			if IsInRaid() then
				local group_size = GetNumGroupMembers()	
				local inrange = {}
				for index = 1, group_size do					
					local unit = "raid"..index
					if IsItemInRange(rangecheck_items[range], unit) and not UnitIsUnit("player", unit) then -- 距离过近
						local unit_name = UnitName(unit)
						table.insert(inrange, unit_name)
					end								
				end
				if #inrange > 0 then
					local str = string.format(L["距离过近人数"], #inrange)
					--if #inrange > 3 then
					--	str = string.format(L["距离过近三人"], inrange[1], inrange[2], inrange[3], #inrange)
					--else
					--	str = L["距离过近"]..": "..table.concat(inrange, " ")
					--end
					
					if i == 0 then
						PlaySoundFile(G.media.sounds.."range.ogg", "Master")
					end
					T.SendChatMsg(str)
				end
			end
		end)
	end
end