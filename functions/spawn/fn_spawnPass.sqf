#include "..\..\component.hpp"

_allPlayers = allPlayers - (entities "HeadlessClient_F");
if (_allPlayers isEqualTo []) exitWith {};

private _fps = diag_fps;
if (_fps < GRAD_CIVS_MINFPS) exitWith {INFO_2("not spawning additional civs: less FPS than required (%1/%2)", _fps, GRAD_CIVS_MINFPS)};
if ((_fps * GRAD_CIVS_MINCIVUPDATETIME) < (count GRAD_CIVS_LOCAL_CIVS)) exitWith {INFO_3("not spawning additional civs: cannot guarantee update times less than %1 for %2 civs with %3 fps", GRAD_CIVS_MINCIVUPDATETIME, count GRAD_CIVS_LOCAL_CIVS, _fps)};

if (GRAD_CIVS_ENABLEDONFOOT) then {
    if ((count (["patrol"] call grad_civs_fnc_getGlobalCivs)) < GRAD_CIVS_MAXCIVSONFOOT) then {
        [_allPlayers] call grad_civs_fnc_addFootsy;
    };
};

if (GRAD_CIVS_ENABLEDINVEHICLES) then {
    assert(count GRAD_CIVS_VEHICLES > 0);
    if ((count (["voyage"] call grad_civs_fnc_getGlobalCivs)) < GRAD_CIVS_MAXCIVSINVEHICLES) then {
        [_allPlayers] call grad_civs_fnc_addCarCrew;
    };
};

if ((count (["reside"] call grad_civs_fnc_getGlobalCivs)) < GRAD_CIVS_MAXCIVSRESIDENTS) then {
    [_allPlayers] call grad_civs_fnc_addResident;
};
