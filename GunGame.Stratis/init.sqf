enableSaving [false, false];

vote_time_rounds = 5;

vote_time_location = 20;

copyToClipboard "http://steamcommunity.com/sharedfiles/filedetails/?id=263170409";

removeAllWeapons player;

giveScore = "";
_h = execVM "dynamicWeapons.sqf";
waitUntil {scriptDone _h};
_h = execVM "townLocations.sqf";
waitUntil {scriptDone _h};

VOTECAM = "camera" camCreate ED_mapCenter;
showCinemaBorder false;
VOTECAM cameraEffect ["Internal", "Back"];
VOTECAM camSetTarget (ED_locations select (floor(random(count(ED_locations)))) select 2);
VOTECAM camSetRelPos [0,0,200];
VOTECAM camSetFOV .90;
VOTECAM camSetFocus [50, 0];
VOTECAM camCommit 0;


GGSay = {
player sidechat _this;
};

if(isServer) then {
	GAME_progress = 0;
	onPlayerConnected "[_id, _name] execVM ""PlayerConnected.sqf""";
	execVM "wallplacement.sqf";	
	execVM "voting\server.sqf";	
};

[] spawn {
while {GAME_progress < 2} do
{
showCinemaBorder false;
VOTECAM cameraEffect ["Internal", "Back"];
VOTECAM camSetTarget (ED_locations select (floor(random(count(ED_locations)))) select 2);
VOTECAM camCommit 0;
VOTECAM camSetRelPos [0,0,200];
VOTECAM camSetFOV .90;
VOTECAM camSetFocus [50, 0];
VOTECAM camCommit 60;
sleep 60;
};
};

"winner" addPublicVariableEventHandler
{
	[] spawn {
	removeAllWeapons player;
	hint format["%1 won the game!", winner];
	sleep 5;
	"end1" call BIS_fnc_endMission;
	};
};

if(!isServer) then {
	
};

if(!isDedicated) then
{
	player enableSimulation false;
	"GAME_progress" addPublicVariableEventHandler
	{
		switch(GAME_progress) do
		{
		case 0: {execVM "voting\votenumrounds.sqf";};
		case 1: {execVM "voting\votegunprogress.sqf";};
			default {};
		};
	};
	
	execVM "voting\votenumrounds.sqf";

	waitUntil{!isNil "GUNGAME_ROUNDS"};
	player groupChat format["Total rounds: %1", GUNGAME_ROUNDS];
	waitUntil{!isNil "GUNGAME_WEAPONARRAY"};
	waitUntil{!isNil "fightPosition"};
	
	//execVM "spawnpoints_precache.sqf"; //WIP

	player enableSimulation true;	

	"giveScore" addPublicVariableEventHandler
	{
		if (giveScore == getPlayerUID player) then
		{
			giveScore = "";
			call gunGameFunc;
		};
	};
	GUNGAME_WASDEAD = false;
	_h = execVM "gungamefuncs.sqf";
	waitUntil{scriptDone _h};
	_h = execVM "respawn.sqf";
	_h = execVM "regen.sqf";	
	
	_h = execVM "simpleAntiCheat.sqf";
};

CheaterFound = {
_name = _this select 0;
_steamid = _this select 1;
_str = _name + " was found cheating. Steamid: " + _steamid;
hint _str;
diag_log _str;
copyToClipboard _steamid;
};

OnEachFrame {
	if(INACTION) then
	{
		_pos = getPos player;
		_pos set [2, 0];
		if((_pos) distance fightPosition > (GUNGAME_wallradius + 5)) then{player setDamage 1};
	};
};

VOTECAM cameraEffect ["TERMINATE","BACK"];
camDestroy VOTECAM;