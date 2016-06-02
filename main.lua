--[[

    Start point of an application

]]--

------------------------------- global parameters -----------------------------------

content = {};
content.width = display.contentWidth;
content.height = display.contentHeight;
content.centerX = display.contentCenterX;
content.centerY = display.contentCenterY;

require("core.modules.Globals");

----------------------------------- defaults ----------------------------------------

display.setDefault( "anchorX", 0 );
display.setDefault( "anchorY", 0 );

--------------------------------- starter screen -----------------------------------
local composer = require("composer");

composer.gotoScene("core.GameScene");