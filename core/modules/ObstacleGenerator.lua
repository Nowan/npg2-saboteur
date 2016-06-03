--[[

	obstacle - enemy soldiers/towers/etc
]]--
local ObstacleGenerator = {};

local m_EnemySoldier = require("core.modules.EnemySoldier");

ObstacleGenerator.obstacles = display.newGroup();

ObstacleGenerator.freeSlots = 1;

function ObstacleGenerator:generateObstacle()
	local obstacle = display.newGroup( );

	local enemySoldier = m_EnemySoldier.new();
	enemySoldier.y = content.height-190;
	enemySoldier:initPhysics(physics);
	
	obstacle:insert( enemySoldier );
	obstacle.x = Globals.playerPosition+content.width*1.5;

	ObstacleGenerator.obstacles:insert( obstacle );
	ObstacleGenerator.obstacles[#ObstacleGenerator.obstacles+1] = obstacle;

	return obstacle;
end

local obstacleIterator = 1;

function ObstacleGenerator:moveObstacles(x,y)
	ObstacleGenerator.obstacles.x = x;
	ObstacleGenerator.obstacles.y = y;
end

return ObstacleGenerator;