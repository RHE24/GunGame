if(isNil "CustomTowns") then {CustomTowns = []};
_type = "Custom";
_pos = getPos (_this select 1);
_pos set [2, 0];
_name = _this select 0;
_size = _this select 2;
CustomTowns = CustomTowns + [[_type, _name, _pos, _size]];