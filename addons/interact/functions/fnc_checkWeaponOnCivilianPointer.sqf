#include "..\script_component.hpp"

ISNILS(GVAR(gunpointees), [ARR_2([], 0)] call cba_fnc_hashCreate);

private _depoint = {
    {
        private _counter = [GVAR(gunpointees), _x] call CBA_fnc_hashGet;
        if (_counter > 0) then {
            _counter = 0 max (_counter - 1);
            [GVAR(gunpointees), _x, _counter] call CBA_fnc_hashSet;
            if (_counter == 1) then {
                [QGVAR(pointed_at_dec), [_x], [_x]] call CBA_fnc_targetEvent;
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
                [QGVAR(pointed_at_inc), [_x, player], [_x]] call CBA_fnc_targetEvent;
                [QGVAR(pointing), _x] call CBA_fnc_localEvent;
            };
        };
    } forEach _this;
};

// NOTE: we need to use animationState, as !weaponLowered does *not* mean "weaponRaised"
private _weaponRaisedOnFoot = (alive player) &&
    {!weaponLowered player} &&
    {vehicle player == player} &&
    {"sras" in (animationState player)};

// ----------------------------------------------------------------

//([GVAR(gunpointees), {_value > 0}] call CBA_fnc_hashFilter;  // not necessary due to https://github.com/CBATeam/CBA_A3/issues/1358
private _pointees = ([GVAR(gunpointees)] call CBA_fnc_hashKeys);

if (!_weaponRaisedOnFoot) exitWith {
    // I lowered my weapon. Everyone feels free to go. No one is added.
    _pointees call _depoint;
};

private _target = cursorTarget; // TODO cursorObject might be a better choice for when cursorTarget doesnt give results.

// I have my weapon raised. Check existing targets if they still feel threatened

// also , do *not* depoint ppl that belong to the car that im' pointing at, (if i'm pointing at a car)
// under the assumption that those were mounted before (else they wouldnt be in the pointee group!) this will work out fine :)

private _unitsFromCar = [];
if (_target isKindOf "Car") then {
    _unitsFromCar = units (_target getVariable ["grad_civs_owner", grpNull]);
};

private _scaredPointees = _pointees select {
    (_x in _unitsFromCar) || {[player, _x] call FUNC(checkWeaponOnCivilianPerception)};
};


(_pointees - _scaredPointees) call _depoint;
_scaredPointees call _point;

// maybe someone new here I can threaten?
private _possibleCivs = [];
if (((_target isKindOf "Car") || (_target isKindOf "Man")) && {[player, _target] call FUNC(checkWeaponOnCivilianPerception)}) then {    
    _possibleCivs = (crew _target);
};

private _newlyScaredCivs = (_possibleCivs - _pointees) select {
    private _possibleCiv = _x;
    ((side _possibleCiv) == civilian) && {alive _possibleCiv};
};

_newlyScaredCivs call _point;
