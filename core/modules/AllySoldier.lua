--[[
	
	One of the ally soldiers in the group

]]--
module(..., package.seeall);

local sheetOptions =
{
    width = 200,
    height = 150,
    numFrames = 23
}

local spriteSheet = graphics.newImageSheet( "core/assets/sprites/enemy.png", sheetOptions );

-- sequences table
local sheetSequences = {
    -- first sequence (consecutive frames)
    {
        name = "sitting",
        start = 2,
        count = 4,
        time = 950,
        loopCount = 0
    },
    -- next sequence (non-consecutive frames)
    {
        name = "standingUp",
        --frames = { 1,3,5,7 },
        start = 5,
        count = 5,
        time = 550,
        loopCount = 1
    },
    {
        name = "firing",
        --frames = { 1,3,5,7 },
        start = 9,
        count = 9,
        time = 500,
        loopCount = 0
    },
}

function new()
	local allySoldier = {};

	local sprite = display.newSprite( spriteSheet, sheetSequences );
	sprite.x = display.contentCenterX;
	sprite.y = display.contentCenterY;
	sprite.xScale = -1;
	sprite:setSequence( "firing" );
	sprite:play();
	print("Ally spawned");
	return allySoldier;
end