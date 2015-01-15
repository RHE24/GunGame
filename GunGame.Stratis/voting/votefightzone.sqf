if(!isNil "voteFightZone") exitWith {};
voteFightZone = true;

[] spawn {
	_i = vote_time_location;
	while{_i >= 0 && GAME_progress == 2} do
	{
		player commandChat format["You have %1 seconds to vote for a fight zone", _i];
		sleep 1;
		_i = _i - 1;
	};
};	

while {GAME_progress == 2 && isNil "votedfightzone"} do
{
	_dialog = createDialog "voteFightZone";	
	((findDisplay 485) displayCtrl 3) ctrlSetEventHandler ["LBSelChanged","execVM 'voting\fightzoneCamera.sqf'"];
	_i = 0;
	{
		_sizeText = "";
		_rad = _x select 3;
		_calcedPlayers = 2 + (2 * sqrt((pi * (_rad ^ 2)) / (pi * (70 ^ 2))));
		_sizeText = format["%1-%2 Players",floor(_calcedPlayers * 0.75), floor(_calcedPlayers * 1.25)];
		lbAdd [3, (_x select 1) + " (" + _sizeText + ")"];
		lbSetData[3, _i, _x select 1];
		lbSetTooltip[3, _i, "Size: " + str(_x select 3)];
		_i = _i + 1;
	}foreach ED_locations;
	lbSetCurSel [3, 0];
	waitUntil{GAME_progress != 2};
	if(dialog) then {closeDialog 0};
};
titleText ["", "BLACK OUT", 0.1];