--[[

	Group of soldiers saboteur accompanies
	
]]--
module(...,package.seeall);

local m_AllySoldier = require("core.modules.AllySoldier");

--spawn recursively
local spawnAlly;
spawnAlly = function(militaryGroup)
    
    militaryGroup.soldiers[#militaryGroup.soldiers+1] = m_AllySoldier.new();
    militaryGroup.soldiers[#militaryGroup.soldiers]:initPhysics();
    militaryGroup.soldiers[#militaryGroup.soldiers].x = -400;

    Globals.groupSize = Globals.groupSize + 1;

    militaryGroup.spawningTimer = timer.performWithDelay( 5000, function() 
        spawnAlly(militaryGroup);
    end, 1 );
end

function new(size)
	local militaryGroup = {};

	Globals.groupSize = size;

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

	militaryGroup.spawningTimer = timer.performWithDelay( 2000, function() 
        spawnAlly(militaryGroup);
    end, 1 );

	return militaryGroup;
end

