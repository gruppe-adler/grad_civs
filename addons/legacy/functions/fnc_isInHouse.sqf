// originall written by KK


private _pos = _this;
if (_this isEqualType objNull) then {
    _pos = getPosASL _this;
};

lineIntersectsSurfaces [
    _pos,
	_pos vectorAdd [0, 0, 50],
	objNull,
    objNull,
    true,
    1,
    "GEOM",
    "NONE"
] select 0 params ["","","","_house"];

if (isNil "_house") exitWith {false};
if (_house isKindOf "House") exitWith {true};

false
