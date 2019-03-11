#include "..\..\component.hpp"

_allPlayers = (call CBA_fnc_players);
if (count _allPlayers == 0) exitWith {};

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
