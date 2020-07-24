#include "..\script_component.hpp"

ISNILS(GVAR(gunpointees), [ARR_2([], 0)] call cba_fnc_hashCreate);

private _depoint = {
    {
        private _counter = [GVAR(gunpointees), _x] call CBA_fnc_hashGet;
        if (_counter > 0) then {
            _counter = 0 max (_counter - 1);
            [GVAR(gunpointees), _x, _counter] call CBA_fnc_hashSet;
            if (_counter == 1) then {
                [QEGVAR(common,pointed_at_dec), [_x], [_x]] call CBA_fnc_targetEvent;
                [QGVAR(depointing), _x] call CBA_fnc_localEvent;
            };
        };
    } forEach _this;
};

private _point = {
    {
        private _counter = [GVAR(gunpointees), _x] call CBA_fnc_hashGet;
        if (_counter < 2) then {
            _counter = 2 min (_counter + 1);
            [GVAR(gunpointees), _x, _counter] call CBA_fnc_hashSet;
            if (_counter == 2) then {
                [QEGVAR(common,pointed_at_inc), [_x], [_x]] call CBA_fnc_targetEvent;
                [QGVAR(pointing), _this] call CBA_fnc_localEvent;
            };
        };
    } forEach _this;
};

// NOTE: we need to use animationState, as !weaponLowered does *not* mean "weaponRaised"
private _weaponRaisedOnFoot = (alive player) &&
    {!weaponLowered player} &&
    {vehicle player == player} &&
    {"sras" in (animationState player)};

//([GVAR(gunpointees), {_value > 0}] call CBA_fnc_hashFilter;  // not necessary due to https://github.com/CBATeam/CBA_A3/issues/1358
private _pointees = ([GVAR(gunpointees)] call CBA_fnc_hashKeys);

if (!_weaponRaisedOnFoot) exitWith {
    // I lowered my weapon. Everyone feels free to go. No one is added.
    _pointees call _depoint;
};

// I have my weapon raised. Check existing targets if they still feel threatened
private _scaredPointees = _pointees select {
    [player, _x] call FUNC(checkWeaponOnCivilianPerception);
};
(_pointees - _scaredPointees) call _depoint;
_scaredPointees call _point;

// maybe someone new here I can threaten?
private _possibleCiv = driver cursorTarget;
if (!(_possibleCiv in _pointees)) then {
    if (
        ((side _possibleCiv) == civilian) &&
        {alive _possibleCiv} &&
        {[player, _possibleCiv] call FUNC(checkWeaponOnCivilianPerception)}
    ) then {
        [_possibleCiv] call _point;
    };
};
