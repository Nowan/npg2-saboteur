--[[
    
]]--

local composer = require( "composer" );

local scene = composer.newScene();

local Camera = require("core.modules.Camera");
local m_Terrain = require("core.modules.Terrain");
local physics = require("physics");

local ground;
local parallax;

function scene:create( event )
    local sceneGroup = self.view;

    local sky = display.newRect( content.centerX, content.centerY, content.width*2, content.height );
    sky.anchorX = 0.5; sky.anchorY = 0.5;

    ground = m_Terrain:generateGround(content.width*2);
    ground.initialX = -200;
    ground.y = content.height - ground.height;

    local militaryGroup = require("core.modules.MilitaryGroup").new(5);
    militaryGroup.y = content.height - ground.height - 100;

    local saboteur = require("core.modules.saboteur").new();
    saboteur.x = 100;
    saboteur.y = content.height - ground.height - 100;

    --init physics
    physics.start();
    physics.setDrawMode( "hybrid" );

    for i=1,#ground.blocks do
        ground.blocks[i]:initPhysics(physics);
    end

    militaryGroup:initPhysics(physics);
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

Runtime:addEventListener( "enterFrame", function() 
    --Camera:setPosition(Camera.x-Globals.movementSpeed*getDeltaTime(),0);
    local deltaTime = getDeltaTime();
    Globals.playerPosition = Globals.playerPosition + Globals.movementSpeed*deltaTime;
    ground.x = ground.initialX-Globals.playerPosition;
end )

return scene