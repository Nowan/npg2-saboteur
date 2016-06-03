--[[

]]--
module("Globals",package.seeall);

Globals.allyMovementRange = 400; --max distance ally soldiers can run from saboteur

Globals.movementSpeed = 4.5; -- dp per second
Globals.playerPosition = 0; 

Globals.levelEnd = 15000; -- end of the level

Globals.maxLoyalty = 100;
Globals.currentLoyalty = 100;

Globals.obstacleSpawning = 10000; -- time period of obstacle being spawned

Globals.saboteurDamage = 33.5;

Globals.groupSize = 5;

Globals.gameFinished = false;