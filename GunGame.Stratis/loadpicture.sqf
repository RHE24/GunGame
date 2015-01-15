_class = lbData [4, lbCurSel 4];
_picture = getText(configFile >> "CfgWeapons" >> _class >> "picture");
((findDisplay 482) displayCtrl 5) ctrlSetText _picture; 