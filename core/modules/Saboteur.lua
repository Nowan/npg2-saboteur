--[[

]]--
module(...,package.seeall);

local m_Bullet = require("core.modules.Bullet");

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

	Saboteur.gunpoint = {};
	Saboteur.gunpoint.x = Saboteur.x+170;
	Saboteur.gunpoint.y = Saboteur.y+50;

	function Saboteur:initPhysics()
		
	end

	local aim = {};

	function Saboteur:startAim(x,y)
		aim.line = display.newLine( Saboteur.x+170, Saboteur.y+50, x, y );
		aim.line:setStrokeColor( 0, 0, 0, 0.5 )
		aim.line.strokeWidth = 2

		aim.pointer = display.newImage( "core/assets/textures/pointer.png" );
		aim.pointer.width = 200; aim.pointer.height = 200;
		aim.pointer.anchorX = 0.5; aim.pointer.anchorY = 0.5;
		aim.pointer.x = x; aim.pointer.y = y;
	end

	function Saboteur:correctAim(x,y)
		aim.line:removeSelf( );

		aim.line = display.newLine( Saboteur.x+170, Saboteur.y+50, x, y );
		aim.line:setStrokeColor( 0.2, 0.2, 0.2, 0.5 )
		aim.line.strokeWidth = 2

		aim.pointer.x = x; aim.pointer.y = y;
	end

	function Saboteur:stopAim()
		aim.line:removeSelf( );
		aim.pointer:removeSelf();
	end

	function Saboteur:shoot(x,y)
		m_Bullet.new("saboteur",Saboteur.x+170,Saboteur.y+50,x,y);
	end

	return Saboteur;
end