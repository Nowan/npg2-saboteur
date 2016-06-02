--[[
    
]]--

local composer = require( "composer" );

local scene = composer.newScene();

local Camera = require("core.modules.Camera");

function scene:create( event )
    local sceneGroup = self.view;

    --local exampleObject = display.newRect( 100, 100, 100, 100 );
    --Camera:addToViewport(exampleObject);
    local militaryGroup = require("core.modules.MilitaryGroup").new(5);
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

Runtime:addEventListener( "enterFrame", function() 
    Camera:setPosition(Camera.x+1,Camera.y);
end )

return scene