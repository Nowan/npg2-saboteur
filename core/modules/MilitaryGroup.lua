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
		militaryGroup:insert( militaryGroup.soldiers[i] );
	end

	function militaryGroup:initPhysics(physics)
		for i=1,militaryGroup.size do
			militaryGroup.soldiers[i]:initPhysics(physics);
		end
	end

	return militaryGroup;
end

