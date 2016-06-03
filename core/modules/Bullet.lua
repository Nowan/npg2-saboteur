--[[

]]--
module(...,package.seeall);

function new(owner,gunpointX,gunpointY,targetX,targetY)
	local bullet = display.newImage( "core/assets/textures/bullet.png" );

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

	local bulletVelocity = 1000;

	local velX = dX*(bulletVelocity/hypoten);
	local velY = dY*(bulletVelocity/hypoten);

	bullet:setLinearVelocity( velX, velY );

	--print(targetX,targetY);
	return bullet;
end