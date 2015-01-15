while{true} do
{
	waitUntil{alive player};
	_playerCount = 0;
	{
	if(isPlayer _x) then {_playerCount = _playerCount + 1};
	}foreach playableUnits;

	_moddedRadius =  sqrt(_playerCount * (100 ^ 2) / pi);
	if(_moddedRadius > GUNGAME_wallradius) then 
	{
		_moddedRadius = GUNGAME_wallradius;
	};
	
	player enableSimulation false;
	call spawnGuns;
	player addRating -100000;
	player addEventHandler["killed", {(_this select 1) call killFunc}];
	_spawning = true;
	_promoteModifier = 0;
	
	_countPlayersInFight = 0;
	_Xtotal = 0;
	_Ytotal = 0;
	_disTotal = 0;
	{
		if(isPlayer _x) then {
		if(alive _x) then {
		_posX = getPos _x;
		_posX set [2, 0];
		if(_posX distance fightPosition < GUNGAME_wallradius) then
		{
			_countPlayersInFight = _countPlayersInFight + 1;
			_Xtotal = _Xtotal + (_posX select 0);
			_Ytotal = _Ytotal + (_posX select 1);
			_disPlayer = _posX distance fightPosition;
			if(_disPlayer > _moddedRadius) then {_disPlayer = _moddedRadius;};
			_disTotal = _disTotal + _disPlayer;
		};
		};
		};
	}foreach playableUnits;
	
	if(_Xtotal == 0) then {_Xtotal = fightPosition select 0;};
	if(_Ytotal == 0) then {_Ytotal = fightPosition select 1;};
	if(_countPlayersInFight == 0) then {_countPlayersInFight = 1;}; 
	_avgPos = [(_Xtotal / _countPlayersInFight), (_Ytotal / _countPlayersInFight), 0];
	_avgDis = _disTotal / _countPlayersInFight;
	_avgDeg = ((fightPosition select 0) - (_avgPos select 0)) atan2 ((fightPosition select 1) - (_avgPos select 1));
	_moddedDistance = (_moddedRadius - _avgDis) * sqrt(_playerCount);
	if(_moddedDistance > _moddedRadius) then {_moddedDistance = _moddedRadius;};
	_didInv = false;
	_calcs = 0;
	while {_spawning} do
	{	
		_calcs = _calcs + 1;
		
		if(_calcs > (100 / _playerCount)) then 
		{
			if(!_didInv) then
			{
				_avgDeg = _avgDeg + 180;
				_didInv = true;
			};
		};
		
		if(_calcs > (200 / _playerCount)) then
		{
			_moddedDistance = random(_moddedRadius);
			_avgDeg = random(360);
		};
		_x = (fightPosition select 0) + ((_moddedDistance - 30 + random(30)) * sin(_avgDeg - 30 + random(60)));
		_y = (fightPosition select 1) + ((_moddedDistance - 30 + random(30)) * cos(_avgDeg - 30 + random(60)));
		_pos = [_x, _y, 0];
		_newPos = [_pos, 0, 30, 5, 0, 50, 0] call BIS_fnc_findSafePos;	
		//Buildings//////////////////////////////////////////////////////////////////////////////////////////
		_buildings = nearestObjects[_pos, ["House"], 30];
		if(_newPos distance _pos > 30) then
		{
			_buildingsPositions = [];		
			{
				_building = _x;
				_endloop = false;
				_poscount = 0;
				while {!_endloop} do 
				{
					if(((_building buildingPos _poscount) select 0) != 0 && ((_building buildingPos _poscount) select 1) != 0) then {
						_tmp = _building buildingPos _poscount;
						_tmp set [2, 0];
						if(_tmp distance _pos < 30) then
						{
							_buildingsPositions = _buildingsPositions + [_building buildingPos _poscount];
						};
						_poscount = _poscount + 1;
					} else 
					{
						_endloop = true;
					};
				};			
			}foreach _buildings;
			if(count(_buildingsPositions) > 0) then
			{
				_newPos = _buildingsPositions select (floor(random(count(_buildingsPositions))));
			};					

		};
		//////////////////////////////////////////////////////////////////////////////////////////////////////
		if((_newPos distance fightPosition) < (GUNGAME_wallradius * 0.95)) then 
		{		
			_isLos = false;
			_testLosPos = _newPos;
			if(count(_testLosPos) != 3) then 
			{
				_testLosPos = [_testLosPos select 0, _testLosPos select 1, 0];
			};
			_testLosPos = ATLtoASL _testLosPos;
			_testLosPos set [2, (_testLosPos select 2) + 1.6];
			{
				if(isPlayer _x) then
				{
					if(_x != player) then
					{
						if(alive _x) then
						{
							if((!lineIntersects [eyePos _x, _testLosPos, _x]) && (!terrainIntersectASL [eyePos _x, _testLosPos])) then
							{
								_isLos = true;
							};
						};
					};
				};
				if(_isLos) exitWith{};
			} foreach playableUnits;
			if(!_isLos || _calcs > (300 / _playerCount)) then
			{
				_spawning = false;
				player setPos _newPos select 0;
				player setDir random(360);
				player enableFatigue false;	
			};			
		};
	};
	titleText ["", "BLACK IN", 0.1];
	player enableSimulation true;
	RESPAWNING = false;
	INACTION = true;
	waitUntil{!alive player};
	INACTION = false;
	RESPAWNING = true;
	hideBody player;
	GUNGAME_WASDEAD = true;
	gunGamePrevScore = gunGamePrevScore - 1;
};