--[[

]]--
module(..., package.seeall);

function new()
	local bowl = display.newImage( "core/assets/textures/barrel.png")

	bowl.width = 30;
	bowl.height = 50;

	function bowl:initPhysics()
		physics.addBody( bowl, "dynamic");
		bowl.name = "bowl"
		bowl.isSensor = true
		bowl:setLinearVelocity( -300, 0 );
	end

	function bowl:explode()
		bowl.explosionCollider = display.newCircle( bowl.x-100, bowl.y-100, 200 );
		bowl.explosionCollider.alpha = 0;

		timer.performWithDelay( 1, function() 
			physics.addBody( bowl.explosionCollider, "dynamic", {radius=200} );
			bowl.explosionCollider.isSensor = true;
			bowl.explosionCollider.name = "explosion";

			timer.performWithDelay( 1, function() 
				bowl.explosionCollider:removeSelf( );
				bowl.explosionCollider = nil;
				bowl:removeSelf();
				bowl = nil;
			end, 1 )
		end, 1 )

	end

	return bowl;
end