--[[
    
]]--

local composer = require( "composer" );

local scene = composer.newScene();

local m_Terrain = require("core.modules.Terrain");

local ground;
local parallax;
local saboteur;
local GUI;
local ObstacleGenerator;

physics = require("physics");

local function touchListener(event)
    if(event.phase=="began") then
        saboteur:startAim(event.x,event.y);
    elseif(event.phase=="moved") then
        saboteur:correctAim(event.x,event.y);
    elseif(event.phase=="ended") then
        saboteur:stopAim();
        saboteur:shoot(event.x,event.y);
    end
end

--spawn recursively
local spawnEnemy;
spawnEnemy = function()
    ObstacleGenerator:generateObstacle();

    Globals.obstacleSpawning = Globals.levelEnd/Globals.playerPosition*200

    --Globals.obstacleSpawning = 
    local nextIteration = math.random( Globals.obstacleSpawning-Globals.obstacleSpawning/3,  Globals.obstacleSpawning+ Globals.obstacleSpawning/3 )

    timer.performWithDelay( nextIteration, function() 
        spawnEnemy();
    end, 1 );
end

local spawnBowl;
spawnBowl = function()
    ObstacleGenerator:generateBowl();

    local nextIteration = math.random( 1200,  3500 );

    timer.performWithDelay( nextIteration, function() 
        spawnBowl();
    end, 1 );
end

function scene:create( event )
    local sceneGroup = self.view;

    local sky = display.newRect( content.centerX, content.centerY, content.width*2, content.height );
    sky.anchorX = 0.5; sky.anchorY = 0.5;
    sky:setFillColor( 0,0.7,0.7 )

    ground = m_Terrain:generateGround(content.width*2);
    ground.initialX = -200;
    ground.y = content.height - ground.height;

    saboteur = require("core.modules.Saboteur").new();
    saboteur.x = 100;
    saboteur.y = content.height - ground.height - 100;

    local militaryGroup = require("core.modules.MilitaryGroup").new(5);

    GUI = require("core.modules.GUI").new();

    ObstacleGenerator = require("core.modules.ObstacleGenerator");

    --militaryGroup.y = content.height - ground.height - 100;

    --init physics
    physics.start(true);
    physics.setGravity( 0, 0 )
    --physics.setDrawMode( "hybrid" );

    militaryGroup:initPhysics();

    timer.performWithDelay( 2000, function() 
        spawnEnemy();
    end, 1 );

    timer.performWithDelay( 1500, function() 
        spawnBowl();
    end, 1 );

    display.currentStage:addEventListener( "touch", touchListener);
end


function scene:show( event )
    local sceneGroup = self.view;
    local phase = event.phase;

    if ( phase == "will" ) then
        
    elseif ( phase == "did" ) then
        
    end
end


function scene:hide( event )
    local sceneGroup = self.view;
    local phase = event.phase;

    if ( phase == "will" ) then
        
    elseif ( phase == "did" ) then
        
    end
end



function scene:destroy( event )
    local sceneGroup = self.view;

end

-- Scene isteners
scene:addEventListener( "create", scene );
scene:addEventListener( "show", scene );
scene:addEventListener( "hide", scene );
scene:addEventListener( "destroy", scene );

local runtime = 0
 
local function getDeltaTime()
    local temp = system.getTimer()  -- Get current game time in ms
    local dt = (temp-runtime) / (1000/60)  -- 60 fps or 30 fps as base
    runtime = temp  -- Store game time
    return dt
end

local groundPointer = 1;

Runtime:addEventListener( "enterFrame", function() 
    local deltaTime = getDeltaTime();
    Globals.playerPosition = Globals.playerPosition + Globals.movementSpeed*deltaTime;
    ground.x = ground.initialX-Globals.playerPosition;

    --Camera:setPosition(Globals.playerPosition,0);

    --ObstacleGenerator:moveObstacles(-Globals.playerPosition,0);

    GUI:updateProgress(  );

    if(ground.blocks[groundPointer]:localToContent( 0, 0 )<ground.initialX) then
        ground.blocks[groundPointer]:removeSelf( );
        m_Terrain:generateGroundBlock(ground,groundPointer);
        if(groundPointer>=#ground.blocks) then
            groundPointer = 1;
        else
            groundPointer = groundPointer+1;
        end
    end
end )

return scene