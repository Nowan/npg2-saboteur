--[[

]]--
module(...,package.seeall);

function new()
	local parallax = {};

	parallax.backgroundScale = 0.4;
	parallax.foregroundScale = 0.9;

	local background = display.newGroup();
	local background1 = display.newImage( background,"core/assets/textures/far-background.png" )
	background1.width = content.width*1.5; background1.height = content.height;
	background1.x = -background1.width/2;

	local background2 = display.newImage( background,"core/assets/textures/far-background.png" )
	background2.width = content.width*1.5; background2.height = content.height;
	background2.x = background1.x+background2.width; 

	local foreground = display.newGroup();
	local foreground1 = display.newImage( foreground,"core/assets/textures/near-background.png" )
	foreground1.width = content.width*1.5; foreground1.height = content.height;
	foreground1.x = -foreground1.width/2; 

	local foreground2 = display.newImage( foreground,"core/assets/textures/near-background.png" )
	foreground2.width = content.width*1.5; foreground2.height = content.height;
	foreground2.x = foreground1.x+foreground2.width; 


	function parallax:moveBG(x)
		background.x = x*parallax.backgroundScale;
		foreground.x = x*parallax.foregroundScale;

		if(background.x+background1.x+background1.width<-300) then
			background1.x = background2.x+background1.width;
		elseif(background.x+background2.x+background2.width<-300) then
			background2.x = background1.x+background2.width;
		end

		if(foreground.x+foreground1.x+foreground1.width<-300) then
			foreground1.x = foreground2.x+foreground1.width;
		elseif(foreground.x+foreground2.x+foreground2.width<-300) then
			foreground2.x = foreground1.x+foreground2.width;
		end
	end

	function parallax:removeProperly()
		background:removeSelf( );
		foreground:removeSelf( );
	end

	return parallax;
end