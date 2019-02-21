#include "..\..\component.hpp"

_allPlayers = (call CBA_fnc_players);

if (GRAD_CIVS_ENABLEDONFOOT) then {
    if ((count GRAD_CIVS_ONFOOTUNITS) < GRAD_CIVS_MAXCIVSONFOOT) then {
        [_allPlayers] call grad_civs_fnc_addFootsy;
    };
};

if (GRAD_CIVS_ENABLEDINVEHICLES) then {
    assert(count GRAD_CIVS_VEHICLES > 0);
    if ((count GRAD_CIVS_INVEHICLESUNITS) < GRAD_CIVS_MAXCIVSINVEHICLES) then {
        [_allPlayers] call grad_civs_fnc_addCarCrew;
    };
};
