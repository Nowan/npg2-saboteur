--[[
    
]]--

local composer = require( "composer" );

local scene = composer.newScene();

local Camera = require("core.modules.Camera");
local m_Terrain = require("core.modules.Terrain");
local physics = require("physics");

function scene:create( event )
    local sceneGroup = self.view;

    local ground = m_Terrain:generateGround(1000);
    ground.y = content.height - ground.height;

    local militaryGroup = require("core.modules.MilitaryGroup").new(5);
    militaryGroup.y = content.height - ground.height - 100;

    local saboteur = require("core.modules.saboteur").new();
    saboteur.x = 100;
    saboteur.y = content.height - ground.height - 100;

    --init physics
    physics.start();
    --physics.setDrawMode( "hybrid" );

    for i=1,#ground.blocks do
        ground.blocks[i]:initPhysics(physics);
    end

    militaryGroup:initPhysics(physics);

    Camera:addToViewport(ground);
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
    Camera:setPosition(Camera.x-Globals.movementSpeed*getDeltaTime(),0);
    
end )

return scene