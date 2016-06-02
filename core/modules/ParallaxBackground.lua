--[[

]]--
module(...,package.seeall);

function new()
	local parallax = display.newContainer( content.width*2, content.height );
	parallax.anchorX = 0.5; parallax.anchorY = 0.5;

	local bg = display.newRect( parallax, 0, 0, parallax.width, parallax.height )

	return parallax;
end