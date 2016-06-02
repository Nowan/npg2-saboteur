--[[

]]--
local Terrain = {};

function Terrain:generateGround(length)
	local ground = display.newGroup( );

	local currentLength = 0;

	ground.blocks = {};

	while(currentLength<length) do
		local randValue = math.random( 1, 6 );
		local imagePath = "core/assets/textures/grass-"..tostring(randValue)..".png";

		local groundBlock = display.newImage( ground, imagePath, currentLength, 0 );
		currentLength = currentLength + groundBlock.width;

		ground.blocks[#ground.blocks+1] = groundBlock;
	end

	return ground;
end

return Terrain;

