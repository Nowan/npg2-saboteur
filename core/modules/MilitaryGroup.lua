--[[

	Group of soldiers saboteur accompanies
	
]]--
module(...,package.seeall);

local m_AllySoldier = require("core.modules.AllySoldier");

function new(size)
	local militaryGroup = display.newGroup();

	militaryGroup.size = size;
	militaryGroup.soldiers = {};

	--spawn allies
	for i=1,size do
		militaryGroup.soldiers[i] = m_AllySoldier.new();
	end

	return militaryGroup;
end

