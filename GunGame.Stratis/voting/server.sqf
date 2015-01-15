GUNGAMEVOTES_ROUNDS = [];
GUNGAMEVOTES_WEAPONS = [];
GUNGAMEVOTES_ZONE = [];

/*"castVote" addPublicVariableEventHandler
{
	if(GAME_progress == 0) then
	{
		GUNGAMEVOTES_ROUNDS = GUNGAMEVOTES_ROUNDS + [castVote];
		castVote = "";
	}
	else 
	{
		if(GAME_progress == 1) then
		{
			GUNGAMEVOTES_WEAPONS = GUNGAMEVOTES_WEAPONS + [castVote];
			castVote = "";
		}
		else
		{
			if(GAME_progress == 2) then 
			{
				GUNGAMEVOTES_ZONE = GUNGAMEVOTES_ZONE + [castVote];
				castVote = "";
			};
		};
	};
};*/

"castVoteRounds" addPublicVariableEventHandler
{
	if(GAME_progress == 0) then
	{
		GUNGAMEVOTES_ROUNDS = GUNGAMEVOTES_ROUNDS + [castVoteRounds];
		castVote = "";
	};
};

"castVoteWeapons" addPublicVariableEventHandler
{
	if(GAME_progress == 1) then
	{
		GUNGAMEVOTES_WEAPONS = GUNGAMEVOTES_WEAPONS + [castVoteWeapons];
		castVote = "";
	};
};

"castVoteZone" addPublicVariableEventHandler
{
	if(GAME_progress == 2) then
	{
		GUNGAMEVOTES_ZONE = GUNGAMEVOTES_ZONE + [castVoteZone];
		castVote = "";
	};
};
//////////////////////////////////////////////////////////

publicVariable "GAME_progress";
sleep vote_time_rounds;


_rounds = 10;
_roundvotes = [0,0,0];
_highest = 0;
{
	switch (_x) do {
	case 10: {_roundvotes = [(_roundvotes select 0) + 1, _roundvotes select 1, _roundvotes select 2];};
	case 20: {_roundvotes = [(_roundvotes select 0), (_roundvotes select 1) + 1, _roundvotes select 2];};
	case 30: {_roundvotes = [(_roundvotes select 0), _roundvotes select 1, (_roundvotes select 2) + 1];};
		default {};
	};
}foreach GUNGAMEVOTES_ROUNDS;

if((_roundvotes select 1) > (_roundvotes select 0)) then
{
	_rounds = 20;
	_highest = (_roundvotes select 1)
};

if((_roundvotes select 2) > _highest) then
{
	_rounds = 30;
};

GUNGAME_ROUNDS = _rounds;
publicVariable "GUNGAME_ROUNDS";
vote_time_guns = GUNGAME_ROUNDS * 1.5;
publicVariable "vote_time_guns";

///////////////////////////////////////////////////////////////////////////////////////
getDynamicWeaponInfo = {
	_ar = [];
	{
		if((_x select 0) == _this) exitWith
		{
			_ar = _x;
		};
	}foreach (ED_dynamicWeapons_Primary + ED_dynamicWeapons_HandGun);
	_ar;
};

GAME_progress = 1;
publicVariable "GAME_progress";
sleep vote_time_guns;
_h = execVM "dynamicWeapons.sqf";
waitUntil {scriptDone _h};
_numvoteprogressions = count(GUNGAMEVOTES_WEAPONS);
_gungamevotedweaponarray = [];
_gungameweaponarray = [];
if(_numvoteprogressions > 0) then {

////

for[{_o = 0},{_o < count(GUNGAMEVOTES_WEAPONS)},{_o = _o + 1}] do
{
	for[{_i = 0},{_i < count(GUNGAMEVOTES_WEAPONS select _o)},{_i = _i + 1}] do
	{
		_found = false;
		for[{_a = 0},{_a < count(_gungamevotedweaponarray)},{_a = _a + 1}] do
		{
			if(((GUNGAMEVOTES_WEAPONS select _o) select _i) == ((_gungamevotedweaponarray select _a) select 0)) exitWith
			{
				_gungamevotedweaponarray set [_a, [_gungamevotedweaponarray select _a select 0, (_gungamevotedweaponarray select _a select 1) + 1]];
				_found = true;
			};
		};
	
		if(!_found) then
		{
			_gungamevotedweaponarray = _gungamevotedweaponarray + [[GUNGAMEVOTES_WEAPONS select _o select _i, 1]];
		};
	};
};
//Sort array from most voted to least voted
for[{_o = 0},{_o < count(_gungamevotedweaponarray)},{_o = _o + 1}] do
{
	for[{_i = 0},{_i < count(_gungamevotedweaponarray)},{_i = _i + 1}] do
	{
		if((_gungamevotedweaponarray select _o select 1) > (_gungamevotedweaponarray select _i select 1)) then
		{
			_a = _gungamevotedweaponarray select _o;
			_b = _gungamevotedweaponarray select _i;
			_gungamevotedweaponarray set [_o, _b];
			_gungamevotedweaponarray set [_i, _a];
		};
	};
};
////

for[{_i = 0}, {count(_gungameweaponarray) < GUNGAME_ROUNDS}, {_i = _i + 1}] do
{
	if(_i < count(_gungamevotedweaponarray)) then
	{
		if(count(((_gungamevotedweaponarray select _i) select 0) call getDynamicWeaponInfo) > 0) then
		{		
			_gungameweaponarray = _gungameweaponarray + [((_gungamevotedweaponarray select _i) select 0) call getDynamicWeaponInfo];
		};
	}
	else
	{
		_gungameweaponarray = _gungameweaponarray + [(ED_dynamicWeapons_Primary + ED_dynamicWeapons_HandGun) 
			select floor(random(count(ED_dynamicWeapons_Primary + ED_dynamicWeapons_HandGun)))];
	}
};
////
} 
else
{
	for "_i" from 0 to GUNGAME_ROUNDS do {
		_gungameweaponarray = _gungameweaponarray + [(ED_dynamicWeapons_Primary + ED_dynamicWeapons_HandGun) 
		select floor(random(count(ED_dynamicWeapons_Primary + ED_dynamicWeapons_HandGun)))];
	};
};
GUNGAME_WEAPONARRAY = _gungameweaponarray;
publicVariable "GUNGAME_WEAPONARRAY";
//////////////////////////////////////////////////////////////////////////////////////////
GAME_progress = 2;
publicVariable "GAME_progress";
sleep vote_time_location;

_zone = "";
_highest = 0;
_zoneVotes = [];
{
	_i = 0;
	_found = false;
	while{_i < count(_zoneVotes) && !_found} do
	{
		_i = _i + 1;
		if(_x == (_zoneVotes select _i) select 0) then
		{
			_zoneVotes set [_i,[_x, ((_zoneVotes select _i) select 1) + 1]];
			_found = true;
		};
	};
	if(!_found) then 
	{
		_zoneVotes = _zoneVotes + [[_x, 1]];
	};
}foreach GUNGAMEVOTES_ZONE;

_zoneWin = ED_locations select (floor(random(count(ED_locations)))) select 1;

for[{_o = 0},{_o < count(_zoneVotes)},{_o = _o + 1}] do
{
	for[{_i = 0},{_i < count(_zoneVotes)},{_i = _i + 1}] do
	{
		if((_zoneVotes select _o select 1) > (_zoneVotes select _i select 1)) then
		{
			_a = _zoneVotes select _o;
			_b = _zoneVotes select _i;
			_zoneVotes set [_o, _b];
			_zoneVotes set [_i, _a];
		};
	};
};

for[{_i = 0},{_i < count(_zoneVotes)},{_i = _i + 1}] do
{
	{
		if(_x select 1 == _zoneVotes select _i select 0) exitWith
		{
			fightPosition = _x select 2;
			GUNGAME_wallradius = _x select 3;
		};
	}foreach ED_locations;
	if(!isNil "fightPosition") exitWith{};
};
if(isNil "fightPosition") then 
{
	_rnd = floor(random(count(ED_locations)));
	fightPosition = ED_locations select _rnd select 2;
	GUNGAME_wallradius = ED_locations select _rnd select 3;
};
publicVariable "fightPosition";
publicVariable "GUNGAME_wallradius";
//////////////////////////////////////////////////////////////////
execVM "buildingPlaceMent.sqf";
GAME_progress = 3;
publicVariable "GAME_progress";

_marker = createMarker ["FightZone", fightPosition];
"FightZone" setMarkerBrush "DIAGGRID";
"FightZone" setMarkerColor "ColorRed";
"FightZone" setMarkerShape "ELLIPSE";
"FightZone" setMarkerSize [GUNGAME_wallradius, GUNGAME_wallradius];
"FightZone" setMarkerAlpha 0.5;