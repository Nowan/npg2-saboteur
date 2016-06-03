--[[
	
	One of the ally soldiers in the group

]]--
module(..., package.seeall);

local painSound1 = audio.loadSound( "core/sounds/pain1.wav");
local painSound2 = audio.loadSound( "core/sounds/pain2.wav");

local sheetData1 = { width=86, height=56, numFrames=6 };
local sheet1 = graphics.newImageSheet( "core/assets/sprites/ally-running.png", sheetData1 );

local sequenceData = {
	{ name="running", sheet=sheet1, start=1, count=4, time=450, loopCount=0 }
}

function new(GUI)
	local allySoldier = display.newGroup( );
	allySoldier.sprite = display.newSprite( sheet1, sequenceData );
	allySoldier.sprite.xScale = 2;
	allySoldier.sprite.yScale = 2;
	allySoldier.sprite:setSequence( "running" );
	allySoldier.sprite:play();
	allySoldier:insert( allySoldier.sprite );

	allySoldier.maxHealth = 100;
	allySoldier.currentHealth = allySoldier.maxHealth;

	allySoldier.healthBarBG = display.newRect( 0, -30, allySoldier.maxHealth, 10 );
	allySoldier.healthBarBG:setFillColor( 0.3,0.3,0.3 );
	allySoldier.healthBar = display.newRect( 0, -30, allySoldier.currentHealth, 10 );
	allySoldier.healthBar:setFillColor( 0.7,0.3,0.3 );

	allySoldier:insert( allySoldier.healthBarBG )
	allySoldier:insert(allySoldier.healthBar);

	function allySoldier:initPhysics()
		local offsetRectParams = { halfWidth=30, halfHeight=50, x=50, y=50 }
		physics.addBody( allySoldier, "dynamic", {box=offsetRectParams} );
		allySoldier.name = "ally";
		allySoldier.isSensor = true;

		allySoldier:addEventListener( "collision", function(event) 
			if(event.phase=="began") then
				if(event.other.name=="explosion") then
					allySoldier:takeDamage(60);
				end
			end
		end )
	end

	-- don't stay in one place
	local changePosition;
	changePosition = function()
		if(not allySoldier) then return end;
		local newX = math.random( 0, Globals.allyMovementRange );
		local time = math.random(1500,3500);
		allySoldier.movingTransition = transition.to(allySoldier, {time=time, x=newX, onComplete=changePosition});
	end
	changePosition();

	allySoldier.y = content.height - 150;

	function allySoldier:takeDamage(damage,source)
		allySoldier.currentHealth = allySoldier.currentHealth - damage;

		if(allySoldier.currentHealth<=0) then
			print("DIE")
			allySoldier:removeSelf( );
			allySoldier = nil;
			
			if(Globals.gameFinished) then return end
			Globals.groupSize = Globals.groupSize - 1;

			if(Globals.groupSize<=0) then
				finishGame("LEVEL FAILED - YOU WON", "You have successfully przevented your group from getting to the basement");
				return
			end

			if(source=="enemy")then return end
			Globals.currentLoyalty = Globals.currentLoyalty - 20;
			if(Globals.currentLoyalty>=0) then
				finishGame("FAILURE", "You saboteur actions were too obvious, therefore you have been captured");
				return
			end
			GUI:updateLoyalty();
		else
			local audioChoose = math.random( 1,2 );
			if(audioChoose==1) then
				audio.play(painSound1)
			else
				audio.play(painSound2)
			end
			allySoldier.healthBar.width = allySoldier.currentHealth;
		end
	end



	return allySoldier;
end