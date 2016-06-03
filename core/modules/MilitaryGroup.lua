--[[

	Group of soldiers saboteur accompanies
	
]]--
module(...,package.seeall);

local m_AllySoldier = require("core.modules.AllySoldier");

--spawn recursively
local spawnAlly;
spawnAlly = function(militaryGroup,GUI)
    
    militaryGroup.soldiers[#militaryGroup.soldiers+1] = m_AllySoldier.new(GUI);
    militaryGroup.soldiers[#militaryGroup.soldiers]:initPhysics();
    militaryGroup.soldiers[#militaryGroup.soldiers].x = -400;

    Globals.groupSize = Globals.groupSize + 1;

    militaryGroup.spawningTimer = timer.performWithDelay( 5000, function() 
        spawnAlly(militaryGroup,GUI);
    end, 1 );
end

function new(size,GUI)
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
        spawnAlly(militaryGroup,GUI);
    end, 1 );

    function militaryGroup:removeProperly()
		for i=1,Globals.groupSize do
			if(militaryGroup and militaryGroup.soldiers and militaryGroup.soldiers[i].isVisible) then militaryGroup.soldiers[i]:removeSelf( ); militaryGroup.soldiers[i]=nil end
		end

		militaryGroup.soldiers = nil;
    end

	return militaryGroup;
end

