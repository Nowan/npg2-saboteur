--[[

]]--
module(...,package.seeall);

function new(owner,gunpointX,gunpointY,targetX,targetY)
	local bullet = display.newImage( "core/assets/textures/bullet.png" );

	bullet.owner = owner;
	--bullet.width = 200;
	--bullet.height = 20;
	bullet.anchorX = 0.5;
	bullet.anchorY = 0.5;

	bullet.x = gunpointX;
	bullet.y = gunpointY;

	--calculate rotation
	local dX = targetX - gunpointX;
	local dY = targetY - gunpointY;
	local angle = math.atan(dY/dX)*180/math.pi;
	bullet.rotation = angle;
	local hypoten = math.sqrt(dY*dY+dX*dX);

	physics.addBody( bullet, "dynamic" );
	bullet.isSensor = true;

	bullet.name="bullet";

	local bulletVelocity = 1000;

	local velX = dX*(bulletVelocity/hypoten);
	local velY = dY*(bulletVelocity/hypoten);

	bullet:setLinearVelocity( velX, velY );

	bullet:addEventListener( "collision", function(event) 
		if(event.phase=="began") then
			print("bullet collision with "..event.other.name);
			if(bullet.owner=="saboteur" and event.other.name=="enemy") then
				bullet:removeSelf( );
				bullet = nil;
				--event.other:takeDamage(Globals.saboteurDamage);
			end
		end
	end );

	--destroy bullet after some time
	timer.performWithDelay( 2000, function() 
		if(bullet) then
			bullet:removeSelf( );
			bullet = nil;
		end
	end, 1 );

	--print(targetX,targetY);
	return bullet;
end