#include "..\script_component.hpp"

// monitor player for entering or exiting vehicles owned by someone *as driver*. send event in that cases
// while in vehicle, check if someone's seeing me. if yes, send event.
// THIS SHOULD BE DONE SERVER-SIDE, BUT IS PROBABLY THAT MUCH CHEAPER TO DO ON-CLIENT
// "SeatSwitchedMan"
player addEventHandler [
    "GetInMan",
    {
        params ["_unit", "_role", "_vehicle", "_turret"];
        private _civOwner = _vehicle getVariable ["grad_civs_owner", objNull];
        if (isNull _civOwner) exitWith {
            INFO("no owner");
        };
        private _knownThief = _vehicle getVariable ["grad_civs_knownThief", objNull];
        if (!isNull _knownThief) exitWith {
            INFO_1("thief is known: %1", _knownThief);
        };

        if (_vehicle getVariable ["grad_civs_parkingPos", []] isEqualTo []) then {
            INFO_1("determining parking pos as %1", getPos _vehicle);
            _vehicle setVariable ["grad_civs_parkingPos", getPos _vehicle, true];
        };

        INFO("starting pfh");
        GVAR(stolenVehiclePfh) = [
            {
                params [
                    ["_args", [], []],
                    ["_handle", 0, [0]]
                ];
                _args params [
                    ["_vehicle", objNull, [objNull]]
                ];
                // this would lead to potentially multiple people being identified as thief if we were not stopping the whole thing
                // if (!(isNull driver _vehicle) && (player != driver _vehicle)) exitWith {}; // responsibility lies with the driver
                private _knownThief = _vehicle getVariable ["grad_civs_knownThief", objNull];
                if (!isNull _knownThief) exitWith {
                    INFO("known thief. stopping pfh");
                    [GVAR(stolenVehiclePfh)] call CBA_fnc_removePerFrameHandler;
                };
                private _civClasses = call EFUNC(common,config_getCivClasses);
                private _hasBeenSeen = -1 != ((player nearEntities [_civClasses, 200]) findIf {
                    private _knows = (([vehicle player, "VIEW"] checkVisibility [eyePos _x, getPosASL player]) > 0.5);
                    if (_knows) then {
                        ["grad_civs_vehicleTheft", [_vehicle, player]] call CBA_fnc_globalEvent;
                        INFO("setting known thief");
                        _vehicle setVariable ["grad_civs_knownThief", player, true];
                        _vehicle setVariable ["grad_civs_knownStolen", true, true];
                    };
                    _knows
                });
                private _knownStolen = _vehicle getVariable ["grad_civs_knownStolen", false];
                if (!_hasBeenSeen && !_knownStolen) then {
                    INFO("not been seen or known as stolen. looking through owners");
                    private _civOwners = units (_vehicle getVariable ["grad_civs_owner", objNull]);
                    private _parkingPos = _vehicle getVariable ["grad_civs_parkingPos", [0, 0, 0]];
                    _civOwners findIf {
                        private _civOwner = _x;
                        if (([objNull, "VIEW"] checkVisibility [eyePos leader _civOwner, _parkingPos]) > 0.5) then {
                            INFO("setting known stolen");
                            _vehicle setVariable ["grad_civs_knownStolen", true, true];
                            ["grad_civs_vehicleTheft", [_vehicle, objNull]] call CBA_fnc_globalEvent;
                            true
                        } else {
                            false
                        };
                    };
                };
            },
            2,
            [_vehicle]
        ] call CBA_fnc_addPerFrameHandler;
    }
];
player addEventHandler [
    "GetOutMan",
    {
        if (isNil QGVAR(stolenVehiclePfh)) exitWith {};
        INFO("get out: stopping pfh");
        [GVAR(stolenVehiclePfh)] call CBA_fnc_removePerFrameHandler;
    }
];
