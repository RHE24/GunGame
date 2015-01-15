if (isNil "votednumrounds") then
{
	votednumrounds = true;
	if(GAME_progress == 0) then
	{
	
		castVoteRounds = parseNumber(lbData [3, lbCurSel 3]);
		
		if(!isServer) then
		{
			publicVariableServer "castVoteRounds";
		}
		else
		{
			GUNGAMEVOTES_ROUNDS = GUNGAMEVOTES_ROUNDS + [castVoteRounds];
		};
	};
	closeDialog 0;
};