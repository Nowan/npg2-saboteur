--[[

]]--
module(..., package.seeall);

-- Require the JSON library for decoding purposes
	local json = require( "json" )

function new()
	local bowl = display.newImage( "core/assets/textures/barrel.png")

	bowl.width = 30;
	bowl.height = 50;
	 
	-- Read the exported Particle Designer file (JSON) into a string
	local filePath = system.pathForFile( "emitter33980.rg" )
	local f = io.open( filePath, "r" )
	local fileData = f:read( "*a" )
	f:close()
	 
	-- Decode the string
	local emitterParams = json.decode( fileData )

	local emitter = display.newEmitter( emitterParams );
	emitter:stop();

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
			
			emitter.x = bowl.x
			emitter.y = bowl.y

			timer.performWithDelay( 1, function() 
				bowl.explosionCollider:removeSelf( );
				bowl.explosionCollider = nil;
				bowl:removeSelf();
				bowl = nil;
			end, 1 )
		end, 1 )

		emitter:start();

		timer.performWithDelay( 200, function() 
			emitter:stop( );
		end ,1 )

	end

	return bowl;
end