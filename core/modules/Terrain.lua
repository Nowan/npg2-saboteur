--[[

]]--
local Terrain = {};

function Terrain:generateGround(length)
	local ground = display.newGroup( );

	ground.currentLength = 0;

	ground.blocks = {};

	while(ground.currentLength<length) do
		local randValue = math.random( 1, 6 );
		local imagePath = "core/assets/textures/grass-"..tostring(randValue)..".png";

		local groundBlock = display.newImage( ground, imagePath, ground.currentLength, 0 );
		ground.currentLength = ground.currentLength + groundBlock.width;

		ground.blocks[#ground.blocks+1] = groundBlock;
	end

	return ground;
end


function Terrain:generateGroundBlock(ground, index)
	local randValue = math.random( 1, 6 );
	local imagePath = "core/assets/textures/grass-"..tostring(randValue)..".png";
	local groundBlock = display.newImage( ground, imagePath,ground.currentLength, 0 );
	ground.currentLength = ground.currentLength + groundBlock.width;
	ground:insert( groundBlock); 
	ground.blocks[index] = groundBlock;
end

return Terrain;

