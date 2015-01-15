lbClear 4;
if((lbData [3, lbCurSel 3]) == "hand") then
{
	_count = 0;
	{
	_attachments = "";
	for[{_i = 0},{_i < count(_x select 5)},{_i = _i + 1}] do
		{
			_attachments = _attachments + " " + format["%1", (((_x select 5) select _i) select 1)];
		};	
		lbAdd [4, (_x select 1) + _attachments];	
        lbSetToolTip [4, _count, (_x select 1) + _attachments];		
		lbSetData[4, _count, _x select 0];
		_count = _count + 1;
	} foreach voteGun_handGun;
} else {
	_count = 0;
	{	
	_attachments = "";
		for[{_i = 0},{_i < count(_x select 5)},{_i = _i + 1}] do
		{
			_attachments = _attachments + " " + format["%1", (((_x select 5) select _i) select 1)];
		};		
		lbAdd [4, (_x select 1) + _attachments];
		lbSetToolTip [4, _count, (_x select 1) + _attachments];	
		lbSetData[4, _count, _x select 0];
		_count = _count + 1;
	} foreach voteGun_primary;
};
lbSetCurSel [4, 0];