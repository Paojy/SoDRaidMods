local T, C, L, G = unpack(select(2, ...))

local CurrentFrame = "NONE"

local anchors = {
	["CENTER"] = L["中间"], 
	["LEFT"] = L["左"], 
	["RIGHT"] = L["右"], 
	["TOP"] = L["上"], 
	["BOTTOM"] = L["下"], 
	["TOPLEFT"] = L["左上"], 
	["TOPRIGHT"] = L["右上"], 
	["BOTTOMLEFT"] = L["左下"], 
	["BOTTOMRIGHT"] = L["右下"],
}

local function PlaceCurrentFrame()
	local f = _G[CurrentFrame]
	local points = SoD_CDB["FramePoints"][CurrentFrame]
	f:ClearAllPoints()
	f:SetPoint(points.a1, _G[points.parent], points.a2, points.x, points.y)
end

local function Reskinbox(box, name, value, ...)
	box:SetPoint(...)
	
	box.name = T.createtext(box, "OVERLAY", 12, "OUTLINE", "LEFT")
	box.name:SetPoint("BOTTOMLEFT", box, "TOPLEFT", 5, 8)
	box.name:SetText(G.addon_c..name.."|r")
	
	local bd = CreateFrame("Frame", nil, box)
	bd:SetPoint("TOPLEFT", -2, 0)
	bd:SetPoint("BOTTOMRIGHT")
	T.createborder(bd)

	box:SetFont(GameFontHighlight:GetFont(), 12, "OUTLINE")
	box:SetAutoFocus(false)
	box:SetTextInsets(3, 0, 0, 0)
	
	box:SetScript("OnShow", function(self)
		if CurrentFrame ~= "NONE" then
			self:SetText(SoD_CDB["FramePoints"][CurrentFrame][value])
		else
			self:SetText("")
		end
	end)
	
	box:SetScript("OnEscapePressed", function(self) 
		if CurrentFrame ~= "NONE" then
			self:SetText(SoD_CDB["FramePoints"][CurrentFrame][value])
		else
			self:SetText("")
		end
		self:ClearFocus()
	end)
	
	box:SetScript("OnEnterPressed", function(self)
		if CurrentFrame ~= "NONE" then
			SoD_CDB["FramePoints"][CurrentFrame][value] = self:GetText()
			PlaceCurrentFrame()
		else
			self:SetText("")
		end
		self:ClearFocus()
	end)
	
	box:SetScript("OnEnable", function()
		bd.sd:SetBackdropColor(0, 0, 0, .3)
		bd.sd:SetBackdropBorderColor(0, 0, 0)	
	end)
	box:SetScript("OnDisable", function()
		bd.sd:SetBackdropColor(.5, .5, .5, .7)
		bd.sd:SetBackdropBorderColor(0, 0, 0)
	end)
	
end

local Mover = CreateFrame("Frame", G.addon_name.."Mover", UIParent)
Mover:SetPoint("CENTER", 0, -300)
Mover:SetSize(540, 160)
Mover:SetFrameStrata("HIGH")
Mover:SetFrameLevel(30)
Mover:Hide()

Mover:RegisterForDrag("LeftButton")
Mover:SetScript("OnDragStart", function(self) self:StartMoving() end)
Mover:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
Mover:SetClampedToScreen(true)
Mover:SetMovable(true)
Mover:EnableMouse(true)
T.createborder(Mover)

local DropDownButtons = {}
 
local function CreateDropDownButton(text, dropdown_type, value, v_table, ...)
	local frame = T.createUIPanelButton(Mover, G.addon_name.."DropDown"..value, 100, 20, "")
	frame:SetPoint(...)

	frame.name = T.createtext(frame, "OVERLAY", 12, "OUTLINE", "LEFT")
	frame.name:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 5, 8)
	frame.name:SetText(G.addon_c..text.."|r")
	
	frame.buttons = {}
	
	for k, v in pairs(v_table) do
		frame[k] = T.createUIPanelButton(frame, G.addon_name.."DropDown"..value..k, 90, 20, v)
		frame[k]:SetFrameLevel(frame:GetFrameLevel()+5)
		frame[k]:Hide()
		
		frame[k]:SetScript("OnClick", function(self)
			if dropdown_type == "anchor" then
				SoD_CDB["FramePoints"][CurrentFrame][value] = k
				frame.text:SetText(v_table[k])
				PlaceCurrentFrame()
			elseif dropdown_type == "boss" then
				SoD_CDB["General"][value] = k
				frame.text:SetText(v_table[k])
				T.UnlockCurrentBoss()
			end
			
			for _, btn in pairs(frame.buttons) do
				btn:Hide()
			end
			frame.bg:Hide()
		end)
		
		table.insert(frame.buttons, frame[k])
	end

	for i = 1, #frame.buttons do
		if i == 1 then
			frame.buttons[i]:SetPoint("TOP", frame, "BOTTOM", 0, -10)
		else
			frame.buttons[i]:SetPoint("TOP", frame.buttons[i-1], "BOTTOM", 0, -4)
		end
	end

	frame.bg = CreateFrame("Frame", nil, frame)
	frame.bg:SetPoint("TOPLEFT", frame.buttons[1], "TOPLEFT", -5, 5)
	frame.bg:SetPoint("BOTTOMRIGHT", frame.buttons[#frame.buttons], "BOTTOMRIGHT", 5, -5)
	frame.bg:SetFrameLevel(frame:GetFrameLevel()+2)
	frame.bg:EnableMouse()
	frame.bg:SetScript("OnEnter", function() end)
	T.createborder(frame.bg)
	frame.bg.sd:SetBackdropColor(.1, .4, .9, 1)
	frame.bg:Hide()
	
	table.insert(DropDownButtons, frame)
	
	frame:SetScript("OnClick", function(self)
		if frame.buttons[1]:IsShown() then
			for _, btn in pairs(frame.buttons) do
				btn:Hide()
			end
			frame.bg:Hide()
		else
			for _, btn in pairs(frame.buttons) do
				btn:Show()
			end
			frame.bg:Show()
		end
		
		for _, dropdown_btn in pairs(DropDownButtons) do
			if dropdown_btn ~= frame then
				for _, btn in pairs(dropdown_btn.buttons) do
					btn:Hide()
				end
				dropdown_btn.bg:Hide()
			end
		end
	end)
	
	frame:SetScript("OnHide", function(self)
		for _, btn in pairs(frame.buttons) do
			btn:Hide()
		end
		frame.bg:Hide()
	end)

	return frame
end

Mover.curframe = T.createtext(Mover, "OVERLAY", 16, "OUTLINE", "LEFT")
Mover.curframe:SetPoint("TOP", Mover, "TOP", 0, -45)
Mover.curframe:SetWidth(500)

-- parent
local ParentBox = CreateFrame("EditBox", G.addon_name.."MoverParentBox", Mover)
ParentBox:SetSize(120, 20)
Reskinbox(ParentBox, L["锚点框体"], "parent", "TOPLEFT", Mover, "TOPLEFT", 20, -90)

-- a1
local a1Box = CreateDropDownButton(L["锚点"].."1", "anchor", "a1", anchors, "LEFT", ParentBox, "RIGHT", 20, 0)

-- a2
local a2Box = CreateDropDownButton(L["锚点"].."2", "anchor", "a2", anchors, "LEFT", a1Box, "RIGHT", 20, 0)

-- x
local XBox = CreateFrame("EditBox", G.addon_name.."MoverXBox", Mover)
XBox:SetSize(55, 20)
Reskinbox(XBox, "X", "x", "LEFT", a2Box, "RIGHT", 20, 0)

-- y
local YBox = CreateFrame("EditBox", G.addon_name.."MoverYBox", Mover)
YBox:SetSize(55, 20)
Reskinbox(YBox, "Y", "y", "LEFT", XBox, "RIGHT", 20, 0)

local function DisplayCurrentFramePoint()
	local points = SoD_CDB["FramePoints"][CurrentFrame]
	a1Box.text:SetText(anchors[SoD_CDB["FramePoints"][CurrentFrame]["a1"]])
	a2Box.text:SetText(anchors[SoD_CDB["FramePoints"][CurrentFrame]["a2"]])
	ParentBox:SetText(points.parent)
	XBox:SetText(points.x)
	YBox:SetText(points.y)
end

local function EnableOptions()
	a1Box:Enable()
	a2Box:Enable()
	ParentBox:Enable()
	XBox:Enable()
	YBox:Enable()
end

local function DisableOptions()
	a1Box:Disable()
	a1Box.text:SetText("")
	a2Box:Disable()
	a2Box.text:SetText("")
	ParentBox:Disable()
	ParentBox:SetText("")
	XBox:Disable()
	XBox:SetText("")
	YBox:Disable()
	YBox:SetText("")
end

-- reset
local ResetButton = T.createUIPanelButton(Mover, G.addon_name.."MoverResetButton", 250, 25, L["重置位置"])
ResetButton:SetPoint("BOTTOMLEFT", Mover, "BOTTOMLEFT", 20, 10)
ResetButton:SetScript("OnClick", function()
	if CurrentFrame ~= "NONE" then
		local frame = _G[CurrentFrame]
		
		SoD_CDB["FramePoints"][CurrentFrame].a1 = frame["point"].a1
		SoD_CDB["FramePoints"][CurrentFrame].parent = frame["point"].parent
		SoD_CDB["FramePoints"][CurrentFrame].a2 = frame["point"].a2
		SoD_CDB["FramePoints"][CurrentFrame].x = frame["point"].x
		SoD_CDB["FramePoints"][CurrentFrame].y = frame["point"].y
		
		PlaceCurrentFrame()
		DisplayCurrentFramePoint()
	end
end)

function T.CreateDragFrame(frame)
	local fname = frame:GetName()

	table.insert(G.dragFrameList, frame) --add frame object to the list
	
	frame:SetMovable(true)
	frame:SetClampedToScreen(true)
	
	frame.df = CreateFrame("Frame", fname.."DragFrame", UIParent)
	frame.df:SetAllPoints(frame)
	frame.df:SetFrameStrata("HIGH")
	frame.df:EnableMouse(true)
	frame.df:RegisterForDrag("LeftButton")
	frame.df:SetClampedToScreen(true)
	frame.df:SetScript("OnDragStart", function(self)
		frame:StartMoving()
		self.x, self.y = frame:GetCenter() -- 开始的位置
	end)
	frame.df:SetScript("OnDragStop", function(self) 
		frame:StopMovingOrSizing()
		local x, y = frame:GetCenter() -- 结束的位置
		local x1, y1 = ("%d"):format(x - self.x), ("%d"):format(y -self.y)
		SoD_CDB["FramePoints"][fname].x = SoD_CDB["FramePoints"][fname].x + x1
		SoD_CDB["FramePoints"][fname].y = SoD_CDB["FramePoints"][fname].y + y1
		PlaceCurrentFrame() -- 重新连接到锚点
		DisplayCurrentFramePoint()
	end)
	frame.df:Hide()
	
	--overlay texture
	frame.df.mask = T.createbdframe(frame.df)
	frame.df.mask.text = T.createtext(frame.df, "OVERLAY", 13, "OUTLINE", "LEFT")
	frame.df.mask.text:SetPoint("TOPLEFT")
	frame.df.mask.text:SetText(frame.movingname)
	
	frame.df:SetScript("OnMouseDown", function()
		CurrentFrame = fname
		Mover.curframe:SetText(L["选中的框体"].." "..G.addon_c..gsub(frame.movingname, "\n", "").."|r")
		DisplayCurrentFramePoint()
		EnableOptions()
		for i = 1, #G.dragFrameList do
			if G.dragFrameList[i]:GetName() == fname then
				G.dragFrameList[i].df.mask:SetBackdropBorderColor(0, 1, 1)
			else
				G.dragFrameList[i].df.mask:SetBackdropBorderColor(0, 0, 0)
			end
		end
	end)
end

T.UnlockAll = function()
	if not InCombatLockdown() then
		if CurrentFrame ~= "NONE" then
			Mover.curframe:SetText(L["选中的框体"].." "..G.addon_c..gsub(_G[CurrentFrame].movingname, "\n", "").."|r")
		else
			Mover.curframe:SetText(L["选中的框体"].." "..G.addon_c..CurrentFrame.."|r")
			DisableOptions()
		end
		for i = 1, #G.dragFrameList do
			G.dragFrameList[i].df:Show()
		end
		Mover:Show()
		G.gui:Hide()
	else
		Mover:RegisterEvent("PLAYER_REGEN_ENABLED")
		T.msg(L["进入战斗锁定"])
	end
end

T.UnlockCurrentBoss = function()
	if not InCombatLockdown() then
		if CurrentFrame ~= "NONE" then
			local frame = _G[CurrentFrame]
			if not frame.movingtag or frame.movingtag == SoD_CDB["General"]["moving_boss"] then
				Mover.curframe:SetText(L["选中的框体"].." "..G.addon_c..gsub(frame.movingname, "\n", "").."|r")
				EnableOptions()
			else
				CurrentFrame = "NONE"
				Mover.curframe:SetText(L["选中的框体"].." "..G.addon_c..CurrentFrame.."|r")
				DisableOptions()
				for i = 1, #G.dragFrameList do
					G.dragFrameList[i].df.mask:SetBackdropBorderColor(0, 0, 0)
				end
			end
		else
			Mover.curframe:SetText(L["选中的框体"].." "..G.addon_c..CurrentFrame.."|r")
			DisableOptions()
		end
		for i = 1, #G.dragFrameList do
			local frame = G.dragFrameList[i]
			if not frame.movingtag or frame.movingtag == SoD_CDB["General"]["moving_boss"] then
				frame.df:Show()
			else
				frame.df:Hide()
			end
		end
		Mover:Show()
		G.gui:Hide()
	else
		Mover:RegisterEvent("PLAYER_REGEN_ENABLED")
		T.msg(L["进入战斗锁定"])
	end
end

T.LockAll = function()
	CurrentFrame = "NONE"
	DisableOptions()
	
	for i = 1, #G.dragFrameList do
		G.dragFrameList[i].df.mask:SetBackdropBorderColor(0, 0, 0)
		G.dragFrameList[i].df:Hide()
	end
	Mover:Hide()
end

T.PlaceAllFrames = function()		
	for i = 1, #G.dragFrameList do
		local frame = G.dragFrameList[i]
		local name = frame:GetName()
		
		if SoD_CDB["FramePoints"][name] == nil then
			SoD_CDB["FramePoints"][name] = frame.point
		else
			if SoD_CDB["FramePoints"][name]["a1"] == nil then
				SoD_CDB["FramePoints"][name]["a1"] = frame.point.a1
			end
			if SoD_CDB["FramePoints"][name]["a2"] == nil then
				SoD_CDB["FramePoints"][name]["a2"] = frame.point.a2
			end
			if SoD_CDB["FramePoints"][name]["parent"] == nil then
				SoD_CDB["FramePoints"][name]["parent"] = frame.point.parent
			end
			if SoD_CDB["FramePoints"][name]["x"] == nil then
				SoD_CDB["FramePoints"][name]["x"] = frame.point.x
			end
			if SoD_CDB["FramePoints"][name]["y"] == nil then
				SoD_CDB["FramePoints"][name]["y"] = frame.point.y
			end
		end
		
		local points = SoD_CDB["FramePoints"][name]
		G.dragFrameList[i]:ClearAllPoints()
		G.dragFrameList[i]:SetPoint(points.a1, _G[points.parent], points.a2, points.x, points.y)	
	end
end

T.ResetAll = function()
	for i = 1, #G.dragFrameList do
		local f = G.dragFrameList[i]
		SoD_CDB["FramePoints"][f:GetName()] = {}
		for k, v in pairs (f.point) do
			SoD_CDB["FramePoints"][f:GetName()][k] = v
		end
		CurrentFrame = f:GetName()
		PlaceCurrentFrame()
	end
	CurrentFrame = "NONE"
end

Mover:SetScript("OnEvent", function(self, event, arg1)
	if event == "PLAYER_REGEN_DISABLED" then
		if Mover:IsShown() then
			T.LockAll()
			T.msg(L["进入战斗锁定"])
		end
	elseif event == "PLAYER_REGEN_ENABLED" then
		T.UnlockCurrentBoss()
		self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	elseif event == "ADDON_LOADED" then
		if arg1 == G.addon_name then
			T.PlaceAllFrames()
			self:RegisterEvent("PLAYER_REGEN_DISABLED")
			local boss_table = {}
			for index, data in pairs(G.Encounters) do
				if data.id then
					boss_table[index] = EJ_GetEncounterInfo(data["id"])
				else
					boss_table[index] = L["杂兵"]
				end
			end
			local boss_btn = CreateDropDownButton(L["当前首领"], "boss", "moving_boss", boss_table, "TOP", Mover, "TOP", 0, -10)
			boss_btn.name:Hide()
			boss_btn.text:SetText(boss_table[SoD_CDB["General"]["moving_boss"]])
			boss_btn:SetSize(510, 25)
			for _, btn in pairs(boss_btn.buttons) do
				btn:SetSize(200, 20)
			end
		end
	end
end)

Mover:RegisterEvent("ADDON_LOADED")

-- lock
local LockButton = T.createUIPanelButton(Mover, G.addon_name.."MoverLockButton", 250, 25, L["锁定框体"])
LockButton:SetPoint("LEFT", ResetButton, "RIGHT", 10, 0)
LockButton:SetScript("OnClick", function()
	T.LockAll()
end)