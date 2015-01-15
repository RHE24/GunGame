_urbanEnough = false;
_buildingClasses = [];
_config = configFile >> "CfgVehicles";
for[{_i = 0}, {_i < count(_config)}, {_i = _i + 1}] do
{
	_tmp = _config select _i;
	if(isClass _tmp) then
	{
		_simType = getText(_tmp >> "simulation");	
		if(_simType == "house") then
		{
			_scope = getNumber(_tmp >> "scope");
			if(_scope == 1) then
			{
				if(count(_tmp >> "UserActions") > 0) then
				{
				_class = configName(_tmp);
				_buildingClasses = _buildingClasses + [_class];
				};
			};
		};
	};
};
_buildings = count(nearestObjects[fightPosition, [], GUNGAME_wallradius]);
if(count(_buildingClasses) == 0) then
{
	_urbanEnough = true;
};
_fromCenterMult = 0;
while{!_urbanEnough} do
{	
	if(_fromCenterMult < 100) then
	{
	_fromCenterMult = _fromCenterMult + 0.2;
	};
	if((_buildings / (pi * (GUNGAME_wallradius ^ 2))) > (1/(100^2))) exitWith
	{
		_urbanEnough = true;
	};
	
	_x = (fightPosition select 0) + ((_fromCenterMult / 100) * GUNGAME_wallradius * sin(random(360)));
	_y = (fightPosition select 1) + ((_fromCenterMult / 100) * GUNGAME_wallradius * cos(random(360)));
	_pos = [_x, _y, 0];
	
	_newPos = [_pos, 0, 20, 25, 0, 10, 0] call BIS_fnc_findSafePos;	
	_newPos set [2, 0];
	
	if(_newPos select 0 != ED_mapCenter select 0 && _newPos select 1 != ED_mapCenter select 1) then 
	{
		if(_newPos distance fightPosition < GUNGAME_wallradius) then
		{
			_newPos set [2, 0.01];
			_class = _buildingClasses select floor(random(count(_buildingClasses)));
			_building = _class createVehicle _newPos;
			_building setPos _newPos;
			_building setDir random(360);
			_building setVectorUp [0,0,1];
			_buildings = _buildings + 1;	
		};		
	};
};