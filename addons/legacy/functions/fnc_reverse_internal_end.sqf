#include "..\script_component.hpp"

params ["_handle", "_vehicle", "", "", "_onDone"];
INFO_2("ending reverse drive! removing 'BACK' PFH %1 from %2 ...", _handle, _vehicle);
[_handle] call CBA_fnc_removePerFrameHandler;
{
    if (_x getVariable ["grad_civs_virtual_ec", false]) then {
        deleteVehicle _x;
    }
} forEach (crew _vehicle);
_vehicle setVariable [QGVAR(abortReverse), nil, true];
_vehicle setEffectiveCommander (driver _vehicle);
[_vehicle] call _onDone;
