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
	local enemySoldier = display.newGroup( );
	enemySoldier.sprite = display.newSprite( sheet1, sequenceData );
	enemySoldier.sprite.xScale = -2.5;
	enemySoldier.sprite.yScale = 2.5;
	enemySoldier.sprite:setSequence( "firing" );
	enemySoldier.sprite:play();
	enemySoldier.sprite:addEventListener( "sprite", function(event) 
		if(event.phase=="loop") then
			if(enemySoldier.sequence=="firing") then
				--sprite:setSequence("reloading");
				--sprite:play();
			elseif(enemySoldier.sequence=="reloading") then
				--sprite:setSequence("firing");
				--sprite:play();
			end
		end
	end );
	enemySoldier:insert(enemySoldier.sprite);

	enemySoldier.maxHealth = 100;
	enemySoldier.currentHealth = enemySoldier.maxHealth;

	enemySoldier.healthBarBG = display.newRect( -90, -30, enemySoldier.maxHealth, 10 );
	enemySoldier.healthBarBG:setFillColor( 0.3,0.3,0.3 );
	enemySoldier.healthBar = display.newRect( -90, -30, enemySoldier.currentHealth, 10 );
	enemySoldier.healthBar:setFillColor( 0.7,0.3,0.3 );

	enemySoldier:insert( enemySoldier.healthBarBG )
	enemySoldier:insert(enemySoldier.healthBar);

	function enemySoldier:initPhysics()
		local offsetRectParams = { halfWidth=40, halfHeight=70, x=-40, y=70 }
		physics.addBody( enemySoldier, "dynamic", {box=offsetRectParams} );
		enemySoldier.name = "enemy"
		--enemySoldier.box.halfWidth = 50;
		enemySoldier.isSensor = true
		--enemySoldier.physicBody.isSensor = true;
		enemySoldier:setLinearVelocity( -300, 0 );

		enemySoldier:addEventListener( "collision", function(event) 
			if(event.phase=="began") then
				if(event.other.name=="explosion") then
					enemySoldier:takeDamage(100);
				end
			end
		end )
	end

	function enemySoldier:takeDamage(damage)
		enemySoldier.currentHealth = enemySoldier.currentHealth - damage;

		if(enemySoldier.currentHealth<=0) then
			print("DIE")
			enemySoldier:removeSelf( );
			enemySoldier = nil;
		else
			enemySoldier.healthBar.width = enemySoldier.currentHealth;
		end
	end

	--fire in loop
	enemySoldier.infiniteFiring = timer.performWithDelay( 1000, function() 
		if(not enemySoldier) then return end;
		local gunX, gunY = enemySoldier:localToContent( 0, 0 );

		local missleRange = 40;
		local missle = math.random( -missleRange, 20 );
		m_Bullet.new("enemy",gunX-170, gunY+60, gunX-300, 650+missle);
		
	end, -1 );

	

	return enemySoldier;
end