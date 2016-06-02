--[[
	
	One of the ally soldiers in the group

]]--
module(..., package.seeall);


local sheetData1 = { width=50, height=62, numFrames=5 };
local sheet1 = graphics.newImageSheet( "core/assets/sprites/enemy-sitting.png", sheetData1 );
local sheetData2 = { width=40, height=58, numFrames=3 };
local sheet2 = graphics.newImageSheet( "core/assets/sprites/enemy-standing-up.png", sheetData2 );
local sheetData3 = { width=80, height=60, numFrames=14 };
local sheet3 = graphics.newImageSheet( "core/assets/sprites/enemy-firing.png", sheetData3 );
local sheetData4 = { width=52, height=60, numFrames=8 };
local sheet4 = graphics.newImageSheet( "core/assets/sprites/enemy-reloading.png", sheetData4 );

local sequenceData = {
	{ name="sitting", sheet=sheet1, start=1, count=4, time=450, loopCount=0, loopDirection="bounce" },
	{ name="standingUp", sheet=sheet2, start=1, count=3, time=450, loopCount=0 },
	{ name="firing", sheet=sheet3, start=1, count=14, time=1050, loopCount=0 },
	{ name="reloading", sheet=sheet4, start=2, count=8, time=1050, loopCount=0 }
}

function new()
	local allySoldier = {};

	local sprite = display.newSprite( sheet1, sequenceData );
	sprite.xScale = -2;
	sprite.yScale = 2;
	sprite.x = display.contentCenterX;
	sprite.y = display.contentCenterY;
	sprite:setSequence( "reloading" );
	sprite:play();
	print("Ally spawned");
	return allySoldier;
end