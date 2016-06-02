--[[

]]--
local Camera = {};

Camera.viewport = display.newGroup( );
Camera.x = 0;
Camera.y = 0;

function Camera:addToViewport(object)
	Camera.viewport:insert( object );
end

function Camera:setPosition(x,y)
	Camera.x = x;
	Camera.y = y;
	Camera.viewport.x = x;
	Camera.viewport.y = y;
end

return Camera;