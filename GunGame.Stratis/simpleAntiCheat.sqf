while{true} do
{
	sleep 1;
	//Toxic, you have so much talent. Why not use it for good? You would easily make the next best ArmA mission without any effort.
	//This is the best scripters can do to remove public hax kids.
	if(!isNil "Wookie_Init_Menu" || !isNil "W_O_O_K_I_E_Init_Menu") exitWith
	{
		[[name player, getPlayerUid player],"CheaterFound",nil,true] call BIS_fnc_MP;	
		endMission "END1";
	}
}