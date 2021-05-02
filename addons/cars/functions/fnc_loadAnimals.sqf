#include "..\script_component.hpp"

params [
    ["_vehicle", objNull, [objNull]],
    ["_chance", 0, [0]]
];

if (isNull _vehicle) exitWith {
    ERROR("cannot load animals, passed vehicle is null");
};

if ((random 1) >= _chance) exitWith {};

if (isNil "grad_animalTransport_fnc_getSupportedAnimalConfigs") exitWith {
    WARNING("grad_animalTransport does not exist, not spawning animals");
    grad_animalTransport_fnc_getSupportedAnimalConfigs = {[]}; // yes this is evil, but this way the warning will be printed once only.
};

if ((GVAR(animalTransportVehicles) isNotEqualTo []) && !([GVAR(animalTransportVehicles), {_vehicle isKindOf _this#0}] call EFUNC(common,arraySome))) exitWith {
    TRACE_1("animalTransportVehicles does not contain vehicle of type %1", typeOf _vehicle);
};

private _supportedAnimalConfigs = [] call grad_animalTransport_fnc_getSupportedAnimalConfigs;
if (_supportedAnimalConfigs isEqualTo []) exitWith {};

private _animalConfig = selectRandom _supportedAnimalConfigs;
private _animalClassName = configName _animalConfig;

private _spaces = [_vehicle, _animalClassName] call grad_animalTransport_fnc_findSuitableSpaces;
if (count _spaces == 0) exitWith {};

for "_i" from 0 to ((floor random count _spaces) + 1) do {
    private _a = createAgent [_animalClassName, [0, 0, 0], [], 5, "CAN_COLLIDE"];
    [_vehicle, _a] call grad_animalTransport_fnc_vehicle_loadAnimal;
};
