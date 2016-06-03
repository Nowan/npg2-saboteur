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
local militaryGroup;

local bowlSpawnTimer;
local enemySpawnTimer;

physics = require("physics");

local runtime = 0
 
local function getDeltaTime()
    local temp = system.getTimer()  -- Get current game time in ms
    local dt = (temp-runtime) / (1000/60)  -- 60 fps or 30 fps as base
    runtime = temp  -- Store game time
    return dt
end

local groundPointer = 1;

local function frameListener()
    if(Globals.playerPosition>=Globals.levelEnd) then
        finishGame("YOU LOST", "As a saboteur. you must have prevented your allies on getting to the base");
    end
    local deltaTime = getDeltaTime();
    Globals.playerPosition = Globals.playerPosition + Globals.movementSpeed*deltaTime;
    ground.x = ground.initialX-Globals.playerPosition;

    parallax:moveBG(-Globals.playerPosition);

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
end

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

function finishGame(title,message)
    Globals.gameFinished = true;
    timer.performWithDelay( 1, function() 
        physics.pause( );
        if(militaryGroup and militaryGroup.spawningTimer) then timer.cancel( militaryGroup.spawningTimer ) end;
        militaryGroup:removeProperly();

        if(GUI) then
            GUI:showMessage(title,message);
        end

        display.currentStage:removeEventListener( "touch", touchListener);
        Runtime:removeEventListener( "enterFrame", frameListener );

        if(enemySpawnTimer) then timer.cancel( enemySpawnTimer ); enemySpawnTimer=nil end;
        if(bowlSpawnTimer) then timer.cancel( bowlSpawnTimer ); bowlSpawnTimer=nil end;

        --cleaning resources
        ground=nil;
        --saboteur:removeSelf( );
        saboteur=nil;
        if(ObstacleGenerator and ObstacleGenerator.obstacles) then
            ObstacleGenerator.obstacles:removeSelf( );
            ObstacleGenerator.obstacles = nil
        end
        ObstacleGenerator=nil;

        GUI:removeSelf( );
        GUI=nil;

        parallax:removeProperly( );
    end, 1 )
end

--spawn recursively
local spawnEnemy;
spawnEnemy = function()
    if( not ObstacleGenerator) then return end;
    ObstacleGenerator:generateObstacle(GUI);

    Globals.obstacleSpawning = Globals.levelEnd/Globals.playerPosition*200

    --Globals.obstacleSpawning = 
    local nextIteration = math.random( Globals.obstacleSpawning-Globals.obstacleSpawning/3,  Globals.obstacleSpawning+ Globals.obstacleSpawning/3 )

    enemySpawnTimer = timer.performWithDelay( nextIteration, function() 
        spawnEnemy();
    end, 1 );
end

local spawnBowl;
spawnBowl = function()
    if( not ObstacleGenerator) then return end;
    ObstacleGenerator:generateBowl();

    local nextIteration = math.random( 1200,  3500 );

    bowlSpawnTimer = timer.performWithDelay( nextIteration, function() 
        spawnBowl();
    end, 1 );
end


function startGame(title,message)
    Globals.gameFinished = false;
    Globals.playerPosition = 0;

    parallax = require("core.modules.ParallaxBackground").new();

    ground = m_Terrain:generateGround(content.width*2);
    ground.initialX = -200;
    ground.y = content.height - ground.height;

    saboteur = require("core.modules.Saboteur").new();
    saboteur.x = 100;
    saboteur.y = content.height - ground.height - 100;

    militaryGroup = require("core.modules.MilitaryGroup").new(5,GUI);

    ObstacleGenerator = require("core.modules.ObstacleGenerator");
    ObstacleGenerator:new();

    --militaryGroup.y = content.height - ground.height - 100;

    --init physics
    physics.start(true);
    physics.setGravity( 0, 0 )
    --physics.setDrawMode( "hybrid" );

    militaryGroup:initPhysics();
    saboteur:initPhysics();

    timer.performWithDelay( 2000, function() 
        enemySpawnTimer= spawnEnemy();
    end, 1 );

    timer.performWithDelay( 1500, function() 
        bowlSpawnTimer = spawnBowl();
    end, 1 );

    GUI = require("core.modules.GUI").new();

    display.currentStage:addEventListener( "touch", touchListener);

    Runtime:addEventListener( "enterFrame", frameListener );
    --finishGame("title","message asdf asd fasd fa sdfas dhfaskd hfaklsdh flkasdh flaskhdf poiuaehrpqwhe fsad hfpuaoisdhf skadlf h");
end

function scene:create( event )
    local sceneGroup = self.view;

    local sky = display.newRect( content.centerX, content.centerY, content.width*2, content.height );
    sky.anchorX = 0.5; sky.anchorY = 0.5;
    sky:setFillColor( 0,0.7,0.7 )

    startGame();
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

return scene