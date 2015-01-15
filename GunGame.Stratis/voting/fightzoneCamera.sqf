_town = lbData [3, lbCurSel 3];
{
	if(_x select 1 == _town) exitWith
	{
		VOTECAM cameraEffect ["Internal", "Back"];
		VOTECAM camSetTarget [(_x select 2) select 0, (_x select 2) select 1,0];	
		VOTECAM camSetRelPos [-80,80,50];
		VOTECAM camSetFOV .90;
		VOTECAM camSetFocus [50, 0];
		VOTECAM camCommit 0;
		VOTECAM camSetRelPos [80,40,100];
		VOTECAM camCommit 5;
	};
}foreach ED_locations;