---------------------------------------------------------------
-- Nameplate.lua: Override nameplates to deal with interaction
---------------------------------------------------------------
-- Deals with nameplate clutter due to running TargetAI at full
-- functionality, which requires both friendly and NPC plates
-- enabled. Introduces some vanity to plates, e.g. class color,
-- guild information, or NPC subtitle. not working on WOTLK due to missing
-- stuff from legion.

local FadeIn = select(2, ...).GetFaders()
-- Borrowed fix from Kui Nameplates - I highly recommend the full addon.
-- Generate matching patterns for locale, replace format substitution with match anything
local PATTERNS = {TOOLTIP_UNIT_LEVEL, TOOLTIP_UNIT_LEVEL_TYPE, TOOLTIP_UNIT_LEVEL_CLASS, TOOLTIP_UNIT_LEVEL_CLASS_TYPE}
-------------------------------------------------
for i, pattern in ipairs(PATTERNS) do PATTERNS[i] = ('^%s$'):format(pattern:gsub('%%.%$?s?','.+')) end
-------------------------------------------------

local SCRAPE = CreateFrame('GameTooltip', 'ConsolePortScraper', UIParent, 'GameTooltipTemplate')
SCRAPE[1] = _G[SCRAPE:GetName()..'TextLeft2'];
SCRAPE[2] = _G[SCRAPE:GetName()..'TextLeft3'];

function SCRAPE:ScrapeUnitTitle(unit)
	if UnitIsPlayer(unit) then
		return GetCVarBool('UnitNameFriendlyPlayerName') and self:GetPlayerTitle(unit)
	else
		return self:GetNPCTitle(unit)
	end
end

function SCRAPE:GetNPCTitle(unit)
	self:SetOwner(UIParent)
	self:SetUnit(unit)
	local text = self.Line:GetText()
	self:Hide()
	if text then
		for i, pattern in ipairs(PATTERNS) do
			if text:find(pattern) then return end
		end
		return ('|cffffe00a%s|r'):format(text)
	end
end

function SCRAPE:GetPlayerTitle(unit)
	local title = GetGuildInfo(unit)
	return title ~= 0 and title
end

function SCRAPE:SetLineFocus()
	self.Line = self[1 + GetCVar('colorblindmode')]
end

SCRAPE:SetLineFocus()
SCRAPE:RegisterEvent('CVAR_UPDATE')
SCRAPE:SetScript('OnEvent', SCRAPE.SetLineFocus)

-------------------------------------------------
-- Local cache for nameplate modifications
local cache = {}

local function stringify(object, id)
	return tostring(object) .. tostring(id)
end

local function store(object, id, data)
	local idx = stringify(object, id)
	if not cache[idx] then cache[idx] = data end
	return data
end

local function retrieve(object, id)
	local idx = stringify(object, id)
	return cache[idx], idx
end

local function extract(object, id)
	local data, idx = retrieve(object, id)
	cache[idx] = nil; return data
end

-------------------------------------------------
-- Name plate modifiers
-------------------------------------------------
local object = {}
local nameOnly, showAllEnemies
local textScale, fadeInTime, useCC = 1
local isRetail, isClassic = CPAPI:IsRetailVersion(), CPAPI:IsClassicVersion()
-------------------------------------------------

function object:name(ignore, unit, _, _, isPlayer, isUnitCC)
	extract(self, 'cc')
	if isPlayer or isUnitCC then
		store(self, 'scale', self:GetScale())
		store(self, 'color', {self:GetTextColor()})
		if useCC then
			local cc = {GetClassColor(select(2,UnitClass(unit)))}
			store(self, 'cc', cc)
			self:SetTextColor(unpack(cc))
		end
		self:SetScale(((isUnitCC and not isPlayer) and 0.6 or 0.8) * textScale)
	else
		local scale = extract(self, 'scale')
		local color = extract(self, 'color')
		if scale then self:SetScale(scale) end
		if color then self:SetTextColor(unpack(color)) end
	end
end
--[==[]]
hooksecurefunc('CompactUnitFrame_UpdateName', function(self)
	if nameOnly and not UnitIsUnit(self.displayedUnit, 'mouseover') then
		local cc = retrieve(self.name, 'cc')
		if cc then
			self.name:SetVertexColor(unpack(cc))
		end
	end
end)
--]==]

-------------------------------------------------

function object:statusText(ignore, unit, _, _, isPlayer, isUnitCC, _, isActive)
	if isActive and not ignore and not isUnitCC then
		if isClassic then store(self, 'point', {self:GetPoint()}) end
		store(self, 'alpha', self:GetAlpha())
		store(self, 'scale', self:GetScale())
		self:SetAlpha(isPlayer and 0.5 or 1)
		self:SetScale(0.75 * textScale)
		self:ClearAllPoints()
		self:SetPoint('CENTER', 0, -4 * textScale)
		self:SetText(SCRAPE:ScrapeUnitTitle(unit))
		self:Show()
	else
		local scale = extract(self, 'cache')
		local point = extract(self, 'point')
		local alpha = extract(self, 'alpha')
		if alpha then self:SetAlpha(alpha) end
		if scale then self:SetScale(scale) end
		if point then
			self:ClearAllPoints()
			self:SetPoint(unpack(point))
		end
	end
end

-------------------------------------------------

function object:healthBar(ignore)
	CPAPI.SetShown(self, ignore)
end

-------------------------------------------------

function object:LevelFrame(ignore)
	CPAPI.SetShown(self, ignore)
end

-------------------------------------------------

function object:ClassificationFrame(_, _, _, _, _, _, _, isActive)
	if not isActive then
		self:Hide()
	end
end

-------------------------------------------------

function object:CustomProcedures(...)
	if isRetail then
		local statusText = retrieve(self, 'statusText')
		if not statusText then
			statusText = store(self, 'statusText', self:CreateFontString(nil, 'ARTWORK', 'GameFontDisable'))
		end
		statusText:Hide()
		object.statusText(statusText, ...)
	end
end

function object:RunModifications(...)
	object.CustomProcedures(self, ...)

	-- modify base objects
	for idx, modify in pairs(object) do
		local frame = self[idx]
		if frame then
			modify(frame, ...)
		end
	end
end

-------------------------------------------------

function object:UnitFrame(unit)
	local isFriend = UnitIsFriend('player', unit)
	local isTarget = UnitIsUnit('target', unit)
	local isPlayer = UnitIsPlayer(unit)
	local isUnitCC =  not isPlayer
	local isActive = self.name and self.name:IsShown()
	local inCombat = showAllEnemies and UnitCanAttack('player', unit) or CPAPI:UnitThreatSituation('player', unit)
	local ignore   = inCombat or not (isFriend or not isTarget)
	
	if not (isTarget or inCombat) then
		FadeIn(self, fadeInTime or 0, 0, 1)
	end

	object.RunModifications(self, ignore, unit, isFriend, isTarget, isPlayer, isUnitCC, inCombat, isActive)
end


function ConsolePort:SetNameOnlyForUnit(unit)
	--CPAPI.TimerAfter(0.1, function()
		if nameOnly and not UnitIsUnit('player', unit) then  
			--local nameplate = CP_SearchNameplateByUnit(unit)
			local unitFrame = nameplate  
			if unitFrame then
				object.UnitFrame(unitFrame, unit)
			end 
		end
	--end)
end


-------------------------------------------------
ConsolePort:RegisterVarCallback('nameplateCC', function(value) useCC = value end)
ConsolePort:RegisterVarCallback('nameplateFadeIn', function(value) fadeInTime = value end)
ConsolePort:RegisterVarCallback('nameplateNameOnly', function(value) nameOnly = value end)
ConsolePort:RegisterVarCallback('nameplateTextScale', function(value) textScale = value end)
ConsolePort:RegisterVarCallback('nameplateShowAllEnemies', function(value) showAllEnemies = value end)