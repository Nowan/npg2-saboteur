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

	local loyaltyIcon = display.newImage( GUI, "core/assets/textures/loyalty.png" );
	loyaltyIcon.width =150; loyaltyIcon.height = 75;
	loyaltyIcon.x = content.width - loyaltyIcon.width;
	loyaltyIcon.y = content.height - loyaltyIcon.height-30

	local loyaltyText = display.newText( GUI, Globals.currentLoyalty.."/"..Globals.maxLoyalty, 0, 0, "Arial" );
	loyaltyText.x = loyaltyIcon.x+loyaltyIcon.width/2 - loyaltyText.width/2;
	loyaltyText.y = loyaltyIcon.y - 40;
	loyaltyText:setFillColor( 0.2, 1,1 );

	function GUI:updateProgress()
		distancePanel.progressContainer.width = Globals.playerPosition*(distancePanel.progress.width/Globals.levelEnd);
	end

	function GUI:updateLoyalty()
		loyaltyText.text = Globals.currentLoyalty.."/"..Globals.maxLoyalty;
		if(Globals.currentLoyalty>70) then
			loyaltyText:setFillColor( 0.2, 1,1 );
		elseif(Globals.currentLoyalty>30) then
			loyaltyText:setFillColor( 1, 1,0.2 );
		else
			loyaltyText:setFillColor( 1, 0.2,0.2 );
		end
	end

	local messageGroup;

	function GUI:showMessage(title,message)
		messageGroup = display.newGroup(  );
		local messageBG = display.newRect( messageGroup, content.centerX, content.centerY, content.width*2, content.height )
		messageBG.anchorX=0.5; messageBG.anchorY=0.5;
		messageBG:setFillColor( 0,0,0 );
		local messageWindow = display.newRect( messageGroup, content.centerX, content.centerY, 800, 500 );
		messageWindow.anchorX=0.5; messageWindow.anchorY=0.5;

		local title = display.newText( messageGroup, title, content.centerX, 170,"Arial", 40 );
		title.anchorX=0.5;
		title:setFillColor( 0,0,0 )

		local message = display.newText( messageGroup, message, content.centerX, 270, 700, 300, "Arial" );
		message.anchorX=0.5;
		message:setFillColor( 0,0,0 )

		local buttonBG = display.newRect( messageGroup, content.centerX, 500, 500, 100 );
		buttonBG.anchorX = 0.5;
		buttonBG:setFillColor( 0,0,0 );
		buttonBG:addEventListener( "tap", function() 
			messageGroup:removeSelf( );
			messageGroup=nil;
			startGame();
		end );

		local buttonTxt = display.newText( messageGroup, "RESTART", content.centerX, 530,"Arial" );
		buttonTxt.anchorX = 0.5;
	end

	return GUI;
end