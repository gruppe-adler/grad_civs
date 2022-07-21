#include "script_component.hpp"

if (!(EGVAR(main,enabled))) exitWith {};

GVAR(houseworkAnimationSetsInhouseNight) = [
    "PRONE_INJURED_U1", // lies on back
    "PRONE_INJURED_U2", // lies on back
    "SIT_LOW_U" // sit on floor
];

GVAR(houseworkAnimationSetsInhouseDay) = [
    "STAND_U1", // stands bored
    "STAND_U2", // stands bored
    "STAND_U3", // stands bored
    "GUARD", // hands back
    "LISTEN_BRIEFING", // hands back
    "REPAIR_VEH_KNEEL",
    "REPAIR_VEH_STAND",
    "KNEEL_TREAT",
    "BRIEFING",
    "BRIEFING_POINT_TABLE",
    "REPAIR_VEH_PRONE", // lies on back
    "SIT_LOW_U" // sit on floor
];

GVAR(houseworkAnimationSetsOutdoors) = [
    "STAND_U1", // stands bored
    "STAND_U2", // stands bored
    "STAND_U3", // stands bored
    "WATCH", // looking left to right
    "WATCH2", // more straight ahead
    "GUARD", // hands back
    "LISTEN_BRIEFING", // hands back
    "REPAIR_VEH_KNEEL",
    "KNEEL_TREAT"
];

GVAR(houseworkTimesDay) = [5, 30, 120];
GVAR(houseworkTimesNight) = [120, 240, 900];

if (isServer || CBA_isHeadlessClient) then {
    [
        QEGVAR(lifecycle,localSpawn),
        {
            ISNILS(GVAR(maxCivsResidents), GVAR(maxCivsResidents));
            if ((count (["reside"] call EFUNC(lifecycle,getGlobalCivs))) < GVAR(maxCivsResidents)) then {
                [ALL_HUMAN_PLAYERS] call FUNC(addResident);
            };
        }
    ] call CBA_fnc_addEventHandler;

    private _spawnDistances = [GVAR(spawnDistancesResidents)] call EFUNC(common,parseCsv);
    [
        "reside",
        _spawnDistances#1 * 1.2
    ] call EFUNC(common,registerCivTaskType);

    ["business", ["bus_rally"], FUNC(sm_business)] call EFUNC(common,augmentStateMachine);
};
