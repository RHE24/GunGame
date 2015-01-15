_weaponArray = []; //classname, description, type, [magazine class, magazine description, magazine icon], picture, attachments
_weaponsConfig = configFile >> "CfgWeapons";
for[{_i = 0},{_i < count(_weaponsConfig)},{_i = _i + 1}] do
{
	_currentWeapon = _weaponsConfig select _i;
	if(isClass _currentWeapon) then {
		if(getNumber(_currentWeapon >> "scope") == 2) then	{
			_className = configName(_currentWeapon);
			_description = getText(_currentWeapon >> "displayName");
			_type = getNumber(_currentWeapon >> "type");
			_muzzles = getArray(_currentWeapon >> "muzzles");
			_magazines = [];
			{
				_currentMagazinesArray = [];
				if(_x != "this") then 
				{
					_currentMagazinesArray = _currentMagazinesArray + getArray(_currentWeapon >> _x >> "magazines");
				} 
				else 
				{
					_currentMagazinesArray = _currentMagazinesArray + getArray(_currentWeapon >> "magazines");
				};
				for[{_k = 0}, {_k < count(_currentMagazinesArray)}, {_k = _k + 1}] do
				{
					_currentMagazine = _currentMagazinesArray select _k;
					_magazineClass = configName(configFile >> "cfgMagazines" >> _currentMagazine);
					_magazineDescription = getText(configFile >> "cfgMagazines" >> _currentMagazine >> "displayName");
					_magazineIcon = getText(configFile >> "cfgMagazines" >> _currentMagazine >> "picture");
					_magazines = _magazines + [_magazineClass, _magazineDescription, _magazineIcon];
				};
			}foreach (_muzzles);
			_ammo = getText(configFile >> "CfgMagazines" >> (_magazines select 0) >> "ammo");
			if(!isNil "_ammo") then {
			_damage = getNumber(configFile >> "CfgAmmo" >> _ammo >> "hit");
			_picture = getText(_currentWeapon >> "picture");	
			_attachments = [];
			{
				_attachments = _attachments + [[getText(_x >> "item"), getText(configfile >> "CfgWeapons" >> getText(_x >> "item") >> "displayName")]];
			} foreach ([(configfile >> "CfgWeapons" >> _className >> "LinkedItems"),0] call BIS_fnc_returnChildren);
			
			if(_damage > 0) then {
				_weaponArray = _weaponArray + [[_className, _description, _type, _magazines, _picture, _attachments]];
			};
			};
		};
	};
};

ED_dynamicWeapons_ThrowPut = []; //0
ED_dynamicWeapons_Primary = []; //1
ED_dynamicWeapons_HandGun = []; //2
ED_dynamicWeapons_LaunchersDetectors = []; //4
ED_dynamicWeapons_MGunCore = []; //5 (mounted on vehicles)
ED_dynamicWeapons_VehicleWeapons = []; //65536 (mounted on vehicles)
ED_dynamicWeapons_Items = []; //131072 (all items like radios, maps, binoculars, clothing, hats, belts)

{
	_type = _x select 2;
	switch (_type) do
	{
	case 0: {ED_dynamicWeapons_ThrowPut = ED_dynamicWeapons_ThrowPut + [_x];};
		
	case 1: {ED_dynamicWeapons_Primary = ED_dynamicWeapons_Primary + [_x];};
		
	case 2: {ED_dynamicWeapons_HandGun = ED_dynamicWeapons_HandGun + [_x];};
		
	case 4: {ED_dynamicWeapons_LaunchersDetectors = ED_dynamicWeapons_LaunchersDetectors + [_x];};
		
	case 5: {ED_dynamicWeapons_MGunCore = ED_dynamicWeapons_MGunCore + [_x];};
		
	case 65536: {ED_dynamicWeapons_VehicleWeapons = ED_dynamicWeapons_VehicleWeapons + [_x];};
		
	case 131072: {ED_dynamicWeapons_Items = ED_dynamicWeapons_Items + [_x];};
	};
}foreach _weaponArray;