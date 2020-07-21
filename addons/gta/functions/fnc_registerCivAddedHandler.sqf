#include "..\script_component.hpp"

[
    QEGVAR(legacy,civ_added),
    {
        params [
            ["_civ", objNull, [objNull]]
        ];
        if (!local _civ) exitWith {};

        if (!((_civ getVariable ["grad_civs_primaryTask", ""]) in ["reside", "patrol"])) exitWith {};

        if (random 1 > (GVAR(carOwnershipRatio))) exitWith {};

        [_civ] call FUNC(createMyVehicle);
    }
] call CBA_fnc_addEventHandler;
