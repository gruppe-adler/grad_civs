#include "..\script_component.hpp"

params [
    ["_vehicle", objNull, [objNull]],
    ["_chance", 0, [0]]
];

assert(!(isNull _vehicle));

if ((random 1) >= _chance) exitWith {};

if (isNil "grad_animalTransport_fnc_findSuitableSpaces") exitWith {
    WARNING("grad_animalTransport_fnc_findSuitableSpaces does not exist, not spawning animals");
};


private _animalConfig = selectRandom ([] call grad_animalTransport_fnc_getSupportedAnimalConfigs);
private _animalClassName = configName _animalConfig;

private _spaces = [_vehicle, _animalClassName] call grad_animalTransport_fnc_findSuitableSpaces;
if (count _spaces == 0) exitWith {};

for "_i" from 0 to ((floor random count _spaces) + 1) do {
    private _a = createAgent [_animalClassName, [0, 0, 0], [], 5, "CAN_COLLIDE"];
    [_vehicle, _a] call grad_animalTransport_fnc_vehicle_loadAnimal;
};
