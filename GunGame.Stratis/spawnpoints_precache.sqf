//Instead of calculating spawn points after dying, let the server give a list of possible points to choose from.

//Sign_Arrow_Blue_F

waitUntil{!isNil "fightPosition"};

SpawnCacheArray = [];
SCthreads = 0;

for[{_i = -GUNGAME_wallradius}, {_i <= GUNGAME_wallradius}, {_i = _i + 10}] do
{
	SCthreads = SCthreads + 1;
	[_i] spawn 
	{
	_i = _this select 0;
	for[{_k = -GUNGAME_wallradius}, {_k <= GUNGAME_wallradius}, {_k = _k + 10}] do
	{
		_x = (fightPosition select 0) + _i;
		_y = (fightPosition select 1) + _k;
		_pos = [_x, _y, 0];
		if((_pos distance [fightPosition select 0, fightPosition select 1, 0]) < (GUNGAME_wallradius - 10)) then
		{
			_newpos = [_pos, 0, 1, 1, 0, 50, 0] call BIS_fnc_findSafePos;
			_buildings = nearestObjects[_pos, ["House"], GUNGAME_wallradius];
			_buildingsPosition = [0,0,0];		
			{
				
				_building = _x;
				_endloop = false;
				_poscount = 0;
				while {!_endloop} do {
					if(((_building buildingPos _poscount) select 0) != 0 && ((_building buildingPos _poscount) select 1) != 0) then {
						_buildingsPosition = _building buildingPos _poscount;
						_poscount = _poscount + 1;
						if(([_newpos select 0, _newpos select 1, 0] distance _pos ) > ([_buildingsPosition select 0, _buildingsPosition select 1, 0] distance _pos)) then
						{
							_newpos = _buildingsPosition;
						};
					} else {
						_endloop = true;
					};
				};			
			}foreach _buildings;
			if(_newpos distance _pos < 20 && _newpos distance fightPosition < GUNGAME_wallradius - 10) then
			{
				SpawnCacheArray = SpawnCacheArray + [_newpos];
			};
		};
	player groupchat ("Calculating spawns " + str(_i) + " " + str (100 * ((GUNGAME_wallradius + _k)/(GUNGAME_wallradius * 2))));		
	};	
	SCthreads = SCthreads - 1;
	};
	waitUntil{SCthreads < 2};
};


player groupchat str (count(SpawnCacheArray));
{
	_v = "Sign_Arrow_Blue_F" createVehicle _x;
	_v setPos _x;
}foreach SpawnCacheArray;