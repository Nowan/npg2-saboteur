--[[

]]--
module(...,package.seeall);

function new()
	local parallax = display.newContainer( content.width*2, content.height );
	parallax.anchorX = 0.5; parallax.anchorY = 0.5;
	parallax.x = content.centerX; parallax.y = content.centerY;

	local bg = display.newRect( parallax, -parallax.width/2, -parallax.height/2, parallax.width, parallax.height )

	return parallax;
end