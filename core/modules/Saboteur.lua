--[[

]]--
module(...,package.seeall);

local sheetData1 = { width=86, height=56, numFrames=6 };
local sheet1 = graphics.newImageSheet( "core/assets/sprites/ally-running.png", sheetData1 );

local sequenceData = {
	{ name="running", sheet=sheet1, start=1, count=4, time=450, loopCount=0 }
}

function new()
	local Saboteur = display.newGroup( );

	local sprite = display.newSprite( Saboteur, sheet1, sequenceData );
	sprite.xScale = 2;
	sprite.yScale = 2;
	sprite:setSequence( "running" );
	sprite:setFillColor( 0.4,0.4,0.4 );
	sprite:play();
	Saboteur.sprite = sprite;

	function Saboteur:initPhysics(physics)
		Saboteur.physicBody = display.newRect( Saboteur,10, 0, 100, 100 );
		Saboteur.physicBody.alpha = 0;

		physics.addBody( Saboteur.physicBody, "static", { friction=0.5, bounce=0.3 } );
		Saboteur.physicBody.isSensor = true;
	end

	return Saboteur;
end