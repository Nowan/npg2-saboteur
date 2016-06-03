--[[

]]--
module(...,package.seeall);

function new()
	local GUI = display.newGroup( );

	local distancePanel = display.newGroup( );
	distancePanel.background = display.newImage( distancePanel, "core/assets/textures/progressbar-background.png")
	distancePanel.background.anchorX = 0.5;

	distancePanel.progressContainer = display.newContainer( distancePanel, distancePanel.background.width, distancePanel.background.height );
	distancePanel.progressContainer.x = -distancePanel.progressContainer.width/2;
	distancePanel.progress = display.newImage( distancePanel.progressContainer,  "core/assets/textures/progressbar-progress.png" )
	distancePanel.progress.y = -distancePanel.progress.height/2;
	distancePanel.progress.x = -distancePanel.progressContainer.width/2+1;
	--distancePanel.foreground = display.newImage( distancePanel, "core/assets/textures/progressbar-foreground.png")
	--distancePanel.foreground.anchorX = 0.5;

	distancePanel.anchorX = 0.5;
	distancePanel.x = content.centerX;

	function GUI:updateProgress(progress)
		distancePanel.progressContainer.width = Globals.playerPosition*(distancePanel.progress.width/Globals.levelEnd);
	end

	return GUI;
end