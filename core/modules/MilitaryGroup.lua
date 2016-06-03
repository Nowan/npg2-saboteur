--[[

	Group of soldiers saboteur accompanies
	
]]--
module(...,package.seeall);

local m_AllySoldier = require("core.modules.AllySoldier");

function new(size)
	local militaryGroup = {};

	militaryGroup.size = size;
	militaryGroup.soldiers = {};

	--spawn allies
	for i=1,size do
		militaryGroup.soldiers[i] = m_AllySoldier.new();
	end

	function militaryGroup:initPhysics()
		print(#militaryGroup.soldiers);
		for i=1,#militaryGroup.soldiers do
			militaryGroup.soldiers[i]:initPhysics();
		end
	end

	return militaryGroup;
end

