---------------------------------------------------------------
-- UINode.lua: Interface node calculations and management
---------------------------------------------------------------
-- Accessory driver to scan a given interface hierarchy and
-- calculate distances and travel path between nodes, where a
-- node is any object in the hierarchy that is considered to be
-- interactive, either by clicking or mousing over it.
-- Calling Node:RunScan(...) with a list of frames will
-- cache all nodes in the hierarchy for later use.
-- See Cursors\Interface.lua.
---------------------------------------------------------------
local KEY = select(2, ...).KEY
local vec2Dlen, abs, huge = function(x,y) return math.sqrt(x * x + y * y) end, math.abs, math.huge
local tinsert, tremove, ipairs, next = tinsert, tremove, ipairs, next
---------------------------------------------------------------
local MAX_X, MAX_Y = UIParent:GetSize()
---------------------------------------------------------------
UIParent:HookScript('OnSizeChanged', function(_, x, y) MAX_X, MAX_Y = x, y end)
---------------------------------------------------------------
-- Node management functions
---------------------------------------------------------------
local Node = {
	-- Compares distance between nodes for eligibility when filtering cached nodes
	distance = {
		[KEY.UP]    = function(_, destY, horz, vert, _, thisY) return (vert > horz and destY > thisY) end;
		[KEY.DOWN]  = function(_, destY, horz, vert, _, thisY) return (vert > horz and destY < thisY) end;
		[KEY.LEFT]  = function(destX, _, horz, vert, thisX, _) return (vert < horz and destX < thisX) end;
		[KEY.RIGHT] = function(destX, _, horz, vert, thisX, _) return (vert < horz and destX > thisX) end;
	};
	-- Compares more generally to catch any nodes located in a given direction
	direction = {
		[KEY.UP]    = function(_, destY, _, _, _, thisY) return (destY > thisY) end;
		[KEY.DOWN]  = function(_, destY, _, _, _, thisY) return (destY < thisY) end;
		[KEY.LEFT]  = function(destX, _, _, _, thisX, _) return (destX < thisX) end;
		[KEY.RIGHT] = function(destX, _, _, _, thisX, _) return (destX > thisX) end;
	};
	-- Frame level quantifiers (each strata has 10k levels)
	level = {
		BACKGROUND        = 0x00000;
		LOW               = 0x02710;
		MEDIUM            = 0x04E20;
		HIGH              = 0x07530;
		DIALOG            = 0x09C40;
		FULLSCREEN        = 0x0C350;
		FULLSCREEN_DIALOG = 0x0EA60;
		TOOLTIP           = 0x11170;
	};
	-- What to consider as interactive nodes by default
	usable = {
		Button      = true;
		CheckButton = true;
		EditBox     = true;
		Slider      = true;
	};
	cache = {}; -- Temporary node cache when calculating cursor movement
	rects = {}; -- Temporary rect cache to calculate intersection between conflicting nodes
	scalar = 3; -- Manhattan distance: scale 2ndary plane to improve intuitive node selection
}
---------------------------------------------------------------

function Node:IsMouseEvent(node)
	return node.GetScript and ( node:GetScript('OnEnter') or node:GetScript('OnMouseDown') ) and true
end

function Node:IsUsable(object)
	return self.usable[object]
end

function Node:IsInteractive(node, object)
	return 	not node.includeChildren
			and node:IsMouseEnabled()
			and ( self:IsUsable(object) or self:IsMouseEvent(node) )
end

function Node:IsRelevant(node)
	return node and not node.ignoreNode and node:IsVisible()
end

function Node:IsTree(node)
	return not node.ignoreChildren
end

function Node:IsDrawn(node, super)
	local x, y = node:GetCenter()
	if self:PointInRange(x, 0, MAX_X) and self:PointInRange(y, 0, MAX_Y) then
		-- assert node isn't clipped inside a scroll child
		if super and super:GetScrollChild() and not node:IsObjectType('Slider') then
			return UIDoFramesIntersect(node, super) --or UIDoFramesIntersect(node, scrollChild)
		else
			return true
		end
	end
end

---------------------------------------------------------------
-- Attachments
---------------------------------------------------------------
function Node:GetSuperNode(super, node)
	return node:IsObjectType('ScrollFrame') and node or super
end

function Node:GetScrollButtons(node)
	if node then
		if node:IsMouseWheelEnabled() then
			for _, frame in pairs({node:GetChildren()}) do
				if frame:IsObjectType("Slider") then
					return frame:GetChildren()
				end
			end
		elseif node:IsObjectType("Slider") then
			return node:GetChildren()
		else
			return self:GetScrollButtons(node:GetParent())
		end
	end
end

---------------------------------------------------------------
-- Recursive scanner
---------------------------------------------------------------
function Node:Scan(super, node, sibling, ...)
	if self:IsRelevant(node) then
		local object, level = node:GetObjectType(), self:GetFrameLevel(node)
		if self:IsDrawn(node, super) then
			if self:IsInteractive(node, object) then
				self:CacheItem(node, object, super, level)
			elseif node:IsMouseEnabled() then
				self:CacheRect(node, level)
			end
		end
		if self:IsTree(node) then
			self:Scan(self:GetSuperNode(super, node), node:GetChildren())
		end
	end
	if sibling then
		self:Scan(super, sibling, ...)
	end
end

function Node:ScrubCache(i, item)
	while item do
		local node, level = item.node, item.level
		for l, rect in self:IterateRects() do
			if not self:CanLevelsIntersect(level, rect.level) then
				break
			end
			if self:DoNodeAndRectIntersect(node, rect.node) then
				i = self:RemoveCacheItem(i)
				break
			end
		end
		i, item = self:GetNextCacheItem(i)
	end
end

-- @param  varargs : list of frames to scan recursively
-- @return cache   : table of nodes on screen
function Node:RunScan(...)
	self:Scan(nil, ...)
	self:ScrubCache(self:GetNextCacheItem(nil))
	return self.cache
end

---------------------------------------------------------------
-- Cache control
---------------------------------------------------------------
function Node:CacheItem(node, object, super, level)
	self:CacheRect(node, level)
	tinsert(self.cache, node.hasPriority and 1 or #self.cache + 1, {
		node   = node;
		object = object;
		super  = super;
		level  = level;
	});
end

function Node:CacheRect(node, level)
	tinsert(self.rects, self:GetRectLevelIndex(level), {
		node  = node;
		level = level;
	});
end

function Node:RemoveCacheItem(cacheIndex)
	tremove(self.cache, cacheIndex)
	return cacheIndex - 1
end

function Node:ClearCache()
	wipe(self.cache)
	wipe(self.rects)
end

function Node:HasItems()
	return #self.cache > 0
end

function Node:GetNextCacheItem(i)
	return next(self.cache, i and i > 0 and i or nil)
end

function Node:GetFirstEligibleCacheItem()
	for _, item in self:IterateCache() do
		local node = item.node
		if node:IsVisible() and self:IsDrawn(node, item.super) then
			return item
		end
	end
end

function Node:GetRectLevelIndex(level)
	for index, item in self:IterateRects() do
		if (item.level < level) then
			return index
		end 		
	end
	return #self.rects+1
end

function Node:IterateCache()
	return ipairs(self.cache)
end

function Node:IterateRects()
	return ipairs(self.rects)
end

---------------------------------------------------------------
-- Vector calculations
---------------------------------------------------------------
function Node:GetDistance(x1, y1, x2, y2)
	return abs(x1 - x2), abs(y1 - y2)
end

function Node:GetDistanceSum(...)
	local x, y = self:GetDistance(...)
	return x + y
end

function Node:GetFrameLevel(node)
	return self.level[node:GetFrameStrata()] + node:GetFrameLevel()
end

function Node:IsCloser(hz1, vt1, hz2, vt2)
	return vec2Dlen(hz1, vt1) < vec2Dlen(hz2, vt2)
end

function Node:PointInRange(pt, min, max)
	return pt and pt >= min and pt <= max
end

function Node:CanLevelsIntersect(level1, level2)
	return level1 < level2
end

function Node:DoNodeAndRectIntersect(node, rect)
	local x, y = node:GetCenter()
	return self:PointInRange(x, rect:GetLeft(), rect:GetRight()) and
		   self:PointInRange(y, rect:GetBottom(), rect:GetTop())
end

function Node:GetCandidateVectorForCurrent(cur)
	local x, y = cur.node:GetCenter()
	return {x = x; y = y; h = huge; v = huge}
end 

function Node:GetCandidatesForVector(vector, comparator, candidates)
	local thisX, thisY = vector.x, vector.y
	for i, destination in self:IterateCache() do
		local candidate = destination.node
		local destX, destY = candidate:GetCenter()
		local distX, distY = self:GetDistance(thisX, thisY, destX, destY)

		if comparator(destX, destY, distX, distY, thisX, thisY) then
			candidates[destination] = { 
				x = destX; y = destY; h = distX; v = distY;
			}
		end
	end 
	return candidates
end

---------------------------------------------------------------
-- Get the best candidate to a given origin and direction
---------------------------------------------------------------
-- This method uses vectors over manhattan distance, stretching 
-- from an origin node to new candidate nodes, using direction.
-- The vectors are artificially inflated in the secondary plane
-- to the travel direction (X for up/down, Y for left/right),
-- prioritizing candidates more linearly aligned to the origin.
-- Comparing Euclidean distance on vectors yields the best node.

function Node:GetBestCandidate(cur, key, curNodeChanged)
	if cur and self.distance[key] then
		local this = self:GetCandidateVectorForCurrent(cur)
		local candidates = self:GetCandidatesForVector(this, self.distance[key], {})

		local hMult = (key == KEY.UP or key == KEY.DOWN) and self.scalar or 1
		local vMult = (key == KEY.LEFT or key == KEY.RIGHT) and self.scalar or 1

		for candidate, vector in pairs(candidates) do
			if self:IsCloser(vector.h * hMult, vector.v * vMult, this.h, this.v) then
				this = vector; this.h = (this.h * hMult); this.v = (this.v * vMult);
				cur = candidate
				curNodeChanged = true
			end
		end
		return cur, curNodeChanged
	end
end

---------------------------------------------------------------
-- Set the closest candidate to a given origin
---------------------------------------------------------------
-- Used as a fallback method when a proper candidate can't be
-- located using both direction and distance-based vectors,
-- instead using only shortest path as the metric for movement.

function Node:GetClosestCandidate(cur, key, curNodeChanged)
	if cur and self.direction[key] then
		local this = self:GetCandidateVectorForCurrent(cur)
		local candidates = self:GetCandidatesForVector(this, self.direction[key], {})

		for candidate, vector in pairs(candidates) do
			if self:IsCloser(vector.h, vector.v, this.h, this.v) then
				this = vector; cur = candidate
			end
		end
		return cur, curNodeChanged
	end
end

---------------------------------------------------------------
-- Get an arbitrary candidate based on priority mapping
---------------------------------------------------------------
function Node:GetArbitraryCandidate(cur, old, x, y)
	-- (1) attempt to return the last node before the cache was wiped
	-- (2) attempt to return the current node if it's still drawn
	-- (3) return the first item in the cache if there are no origin coordinates
	-- (4) return any node that's close to the origin coordinates or has priority
	return 	( old and self:IsRelevant(old.node) and self:IsDrawn(old.node) ) and old or
			( cur and self:IsRelevant(cur.node) and self:IsDrawn(cur.node) ) and cur or
			( not x or not y ) and self:GetFirstEligibleCacheItem() or
			( self:HasItems() ) and self:GetPriorityCandidate(x, y)
end

function Node:GetPriorityCandidate(x, y)
	local targNode, targDist, targPrio
	for _, this in self:IterateCache() do
		local thisDist = self:GetDistanceSum(x, y, this.node:GetCenter())
		local thisPrio = this.node.hasPriority

		if thisPrio and not targPrio then
			targNode = this
			break
		elseif not targNode or ( not targPrio and thisDist < targDist ) then
			targNode = this
			targDist = thisDist
			targPrio = thisPrio
		end
	end
	return targNode
end

---------------------------------------------------------------
-- Get the driver externally
---------------------------------------------------------------
function ConsolePortUI:GetNodeDriver() return Node end