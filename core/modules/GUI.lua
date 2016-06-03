--[[

]]--
module(...,package.seeall);

function new()
	local GUI = display.newGroup( );

	GUI.distanceLabel = display.newText( GUI, Globals.playerPosition.."/"..Globals.levelEnd, content.centerX, 0, "Arial" );
	GUI.distanceLabel.anchorX = 0.5;

	function GUI:updateProgress(progress)
		GUI.distanceLabel.text = Globals.playerPosition.."/"..Globals.levelEnd;
	end

	return GUI;
end