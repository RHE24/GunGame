if (isNil "votedfightzone") then
{
	votedfightzone = true;
	if(GAME_progress == 2) then
	{
	
		castVoteZone = lbData [3, lbCurSel 3];
		[format["%1 voted for %2", name player, castVoteZone], "GGSay"] spawn BIS_fnc_MP;
		if(!isServer) then
		{
			publicVariableServer "castVoteZone";
		}
		else
		{
			GUNGAMEVOTES_ZONE = GUNGAMEVOTES_ZONE + [castVoteZone];
		};
	};
	closeDialog 0;
};