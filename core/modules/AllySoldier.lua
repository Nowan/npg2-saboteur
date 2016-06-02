--[[
	
	One of the ally soldiers in the group

]]--
module(..., package.seeall);


local sheetData1 = { width=86, height=56, numFrames=6 };
local sheet1 = graphics.newImageSheet( "core/assets/sprites/ally-running.png", sheetData1 );

local sequenceData = {
	{ name="running", sheet=sheet1, start=1, count=4, time=450, loopCount=0 }
}

function new()
	local allySoldier = display.newGroup();

	local sprite = display.newSprite( allySoldier, sheet1, sequenceData );
	sprite.xScale = 2;
	sprite.yScale = 2;
	sprite:setSequence( "running" );
	sprite:play();
	allySoldier.sprite = sprite;

	function allySoldier:initPhysics(physics)
		allySoldier.physicBody = display.newRect( allySoldier,10, 0, 100, 100 );
		allySoldier.physicBody.alpha = 0;
		allySoldier.physicBody.name = "ally";

		physics.addBody( allySoldier.physicBody, "dynamic" );
		allySoldier.physicBody.isSensor = true;
	end

	-- don't stay in one place
	local changePosition;
	changePosition = function()
		local newX = math.random( 0, Globals.allyMovementRange );
		local time = math.random(1500,3500);
		allySoldier.movingTransition = transition.to(allySoldier, {time=time, x=newX, onComplete=changePosition});
	end
	changePosition();

	print("Ally spawned");

	return allySoldier;
end