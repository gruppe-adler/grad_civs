#include "..\script_component.hpp"

params [
    ["_unit", objNull, [objNull]]
];

assert(!isNull _unit);


private _reclotheHim = {
	params ["_unit", "_loadout"];

	_unit setUnitLoadout _loadout;
    private _faces = parseSimpleArray ([QGVAR(faces)] call cba_settings_fnc_get);
	if (count _faces > 0) then {
		[_unit, selectRandom _faces] remoteExec ["setFace", 0, _unit];
	};
};

private _addBeard = {
	params ["_unit"];
    private _goggles = parseSimpleArray ([QGVAR(goggles)] call cba_settings_fnc_get);
	if (count _goggles > 0) then {
		_unit addGoggles selectRandom _goggles;
	};
};

private _addBackpack = {
	params ["_unit"];

    private _backpacks = parseSimpleArray ([QGVAR(backpacks)] call cba_settings_fnc_get);
    private _backpackProbability = [QGVAR(backpackProbability)] call cba_settings_fnc_get;
	if ((_backpackProbability > (random 1)) && {count _backpacks > 0}) then {
		_unit addBackpackGlobal selectRandom _backpacks;
	};
};

private _clothes = parseSimpleArray ([QGVAR(clothes)] call cba_settings_fnc_get);
private _headgear = parseSimpleArray ([QGVAR(headgear)] call cba_settings_fnc_get);
if ((count _clothes > 0) && (count _headgear > 0)) then {
	private _unitLoadout = [[],[],[],[selectRandom _clothes,[]],[],[],selectRandom _headgear,"""",[],["""","""","""","""","""",""""]];
	[_unit, _unitLoadout] call _reclotheHim;
};


[_unit] call _addBeard;
[_unit] call _addBackpack;
