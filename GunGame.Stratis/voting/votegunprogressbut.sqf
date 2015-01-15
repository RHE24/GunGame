if((lbSize 6) <= GUNGAME_ROUNDS) then
{
	_gunText = lbText [4, lbCurSel 4];
	_gunClass = lbData [4, lbCurSel 4];
	if(!isClass (configFile >> "cfgWeapons" >> _gunClass)) exitWith {player groupChat "No gun selected"};
	lbAdd[6, _gunText];
	lbSetData [6, (lbSize 6) - 1, _gunClass];
	lbDelete [4, lbCurSel 4];
	
	for "_i" from 0 to (count(voteGun_handGun) -1) do {
		if(_gunClass == (voteGun_handGun select _i) select 0) then {
			voteGun_handGun set [_i, 0];
			voteGun_handGun = voteGun_handGun - [0];
		};
	};
	
	for "_i" from 0 to (count(voteGun_primary) -1) do {
		if(_gunClass == (voteGun_primary select _i) select 0) then {
			voteGun_primary set [_i, 0];
			voteGun_primary = voteGun_primary - [0];
		};
	};
	
	castVoteWeapons = [_gunClass];
	if(!isServer) then
	{
		publicVariableServer "castVoteWeapons";
	}
	else
	{
		GUNGAMEVOTES_WEAPONS = GUNGAMEVOTES_WEAPONS + [castVoteWeapons];
	};
	
	if((lbSize 6) == GUNGAME_ROUNDS) then
	{	
		/*castVoteWeapons = [];
		for "_i" from 0 to (GUNGAME_ROUNDS - 1) do {
			castVoteWeapons = castVoteWeapons + [lbData[6,_i]];
		};
	
		if(!isServer) then
		{
			publicVariableServer "castVoteWeapons";
		}
		else
		{
			GUNGAMEVOTES_WEAPONS = GUNGAMEVOTES_WEAPONS + [castVoteWeapons];
		};*/
		closeDialog 0;
		gungameroundsvoted = true;
		player groupChat "Waiting for server to tally votes";
	};	
};