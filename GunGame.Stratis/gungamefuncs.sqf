gunGamePrevScore = -1;
gunGameFunc = {
	call spawnGuns;
};

spawnGuns = 
{
	if((score player) > gunGamePrevScore)
	then {
		GUNGAME_SCORE = score player;
	} else {
		GUNGAME_SCORE = gunGamePrevScore + 1;
		if(GUNGAME_WASDEAD) then {GUNGAME_SCORE = GUNGAME_SCORE - 1;};
		GUNGAME_WASDEAD = false;
	};
	
	removeAllWeapons player;
	if(GUNGAME_SCORE < count(GUNGAME_WEAPONARRAY)) then {
		_gun = GUNGAME_WEAPONARRAY select GUNGAME_SCORE;
		player addMagazine (((_gun) select 3) select 0);
		player addMagazine (((_gun) select 3) select 0);
		player addMagazine (((_gun) select 3) select 0);
		player addMagazine (((_gun) select 3) select 0);
		player addWeapon (_gun select 0);
		player switchMove "";
		
		if(GUNGAME_SCORE < (count(GUNGAME_WEAPONARRAY) - 1)) then {
			_gun = GUNGAME_WEAPONARRAY select (GUNGAME_SCORE + 1);
			_gunpicture = _gun select 4;
			hint parseText format["Next Gun<br/><img size='5' image='%1'/>", _gunpicture];
		};
	}
	else 
	{		
		if (GUNGAME_SCORE >= GUNGAME_ROUNDS) then	
		{
			hint "you won!";
			winner = name player;
			publicVariable "winner";
			[] spawn {
				sleep 10;
				endMission "END1";
			};
		};
	};
	[] spawn {
		waitUntil {gunGamePrevScore < score player};
		gunGamePrevScore = score player;
	};
};

killFunc = {			
	_killer = _this;
	giveScore = getPlayerUID _killer;
	publicVariable "giveScore";
	giveScore = "";
	[_killer] spawn
	{
		KILLCAM = "camera" camCreate (getPos player);
		showCinemaBorder false;
		KILLCAM cameraEffect ["Internal", "Back"];
		KILLCAM camSetTarget player;
		KILLCAM camSetRelPos [0,0,1.6];
		KILLCAM camSetPos getPos player;
		KILLCAM camSetFOV .90;
		KILLCAM camSetFocus [50, 0];
		KILLCAM camCommit 0;
		KILLCAM camSetTarget (_this select 0);
		KILLCAM camCommit 0;
		_playerPos = getPos player;
		_direction = ((_playerPos select 0) - ((getPos (_this select 0)) select 0)) atan2 ((_playerPos select 1) - ((getPos (_this select 0)) select 1));
		KILLCAM camSetRelPos [5 * sin(_direction),5 * cos(_direction),1.6];
		KILLCAM camCommit 3;
		waitUntil{INACTION};
		KILLCAM cameraEffect ["TERMINATE","BACK"];
		camDestroy KILLCAM;
	};
};