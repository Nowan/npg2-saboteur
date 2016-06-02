--[[

	Group of soldiers saboteur accompanies
	
]]--
module(...,package.seeall);

local m_AllySoldier = require("core.modules.AllySoldier");

local spriteSequence = {
	-- first sequence (consecutive frames)
    {
        name = "walkUp",
        start = 2,
        count = 8,
        time = 800,
        loopCount = 0
    }
}

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

