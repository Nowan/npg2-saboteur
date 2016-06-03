--[[
	
]]--
module(..., package.seeall);

local m_Bullet = require("core.modules.Bullet");

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
	{ name="reloading", sheet=sheet4, start=2, count=7, time=1050, loopCount=0 }
}

function new()
	local enemySoldier = display.newGroup();

	enemySoldier.maxHealth = 100;
	enemySoldier.currentHealth = enemySoldier.maxHealth;

	local sprite = display.newSprite( enemySoldier, sheet1, sequenceData );
	sprite.xScale = -2.5;
	sprite.yScale = 2.5;
	sprite:setSequence( "firing" );
	sprite:play();
	sprite:addEventListener( "sprite", function(event) 
		if(event.phase=="loop") then
			if(sprite.sequence=="firing") then
				--sprite:setSequence("reloading");
				--sprite:play();
			elseif(sprite.sequence=="reloading") then
				--sprite:setSequence("firing");
				--sprite:play();
			end
		end
	end );

	enemySoldier.sprite = sprite;

	function enemySoldier:initPhysics(physics)
		enemySoldier.physicBody = display.newRect( enemySoldier,-60, 40, 50, 100 );
		enemySoldier.physicBody.alpha = 0;
		enemySoldier.physicBody.name = "enemy";

		physics.addBody( enemySoldier.physicBody, "dynamic" );
		enemySoldier.physicBody.isSensor = true;
	end

	function enemySoldier:takeDamage(damage)
		enemySoldier.currentHealth = enemySoldier.currentHealth - damage;

		if(enemySoldier.currentHealth<=0) then
			print("DIE")
		else

		end
	end

	--fire in loop
	local infiniteFiring = timer.performWithDelay( 1000, function() 

		local gunX, gunY = enemySoldier:localToContent( 0, 60 );

		local missleRange = 50;
		local missle = math.random( -missleRange, 20 );
		m_Bullet.new("enemy",gunX-60, gunY, gunX-200, 650+missle);
		
	end, -1 );

	

	return enemySoldier;
end