--[[

	obstacle - enemy soldiers/towers/etc
]]--
local ObstacleGenerator = {};

local m_EnemySoldier = require("core.modules.EnemySoldier");
local m_Bowl = require("core.modules.Bowl");

ObstacleGenerator.obstacles = display.newGroup();

ObstacleGenerator.freeSlots = 1;

function ObstacleGenerator:new()
	ObstacleGenerator.obstacles = display.newGroup();
end

function ObstacleGenerator:generateObstacle(GUI)
	local obstacle = display.newGroup( );

	local enemySoldier = m_EnemySoldier.new(GUI);
	--enemySoldier.y = content.height-190;
	enemySoldier.x = Globals.playerPosition+content.width*1.5;
	enemySoldier.y = content.height-190;
	enemySoldier:initPhysics(physics);

	ObstacleGenerator.obstacles:insert( enemySoldier );
	ObstacleGenerator.obstacles[#ObstacleGenerator.obstacles+1] = obstacle;

	return obstacle;
end

function ObstacleGenerator:generateBowl()
	local obstacle = display.newGroup( );

	local bowl = m_Bowl.new();
	bowl.x = Globals.playerPosition+content.width*1.5;
	bowl.y = content.height-100;

	bowl:initPhysics();

	return obstacle;
end

local obstacleIterator = 1;

function ObstacleGenerator:moveObstacles(x,y)
	--ObstacleGenerator.obstacles.x = x;
	--ObstacleGenerator.obstacles.y = y;
end

return ObstacleGenerator;