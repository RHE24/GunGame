if(!isNil "voteGunProgress") exitWith {};
voteGunProgress = true;

[] spawn {
	_i = vote_time_guns;
	while{_i >= 0 && GAME_progress == 1} do
	{
		player commandChat format["You have %1 seconds to vote for a gun progression", _i];
		sleep 1;
		_i = _i - 1;
	};
};

while {GAME_progress == 1 && isNil "gungameroundsvoted"} do
{
	voteGun_handGun = ED_dynamicWeapons_HandGun;
	voteGun_primary = ED_dynamicWeapons_Primary;
	_dialog = createDialog "voteGunProgress";	
	lbAdd [3, "Handguns"];
	lbSetData[3, 0, "hand"];
	lbAdd [3, "Primary"];
	lbSetData[3, 1, "primary"];
	lbSetCurSel [3, 0];
	
	((findDisplay 482) displayCtrl 3) ctrlSetEventHandler ["LBSelChanged","execVM 'populateWeapons.sqf'"];
	execVM 'populateWeapons.sqf';
	((findDisplay 482) displayCtrl 4) ctrlSetEventHandler ["LBSelChanged","execVM 'loadpicture.sqf'"];
	
	waitUntil{GAME_progress != 1};
	if(dialog) then {closeDialog 0};
};


waitUntil {GAME_progress == 2};
execVM "voting\votefightzone.sqf";