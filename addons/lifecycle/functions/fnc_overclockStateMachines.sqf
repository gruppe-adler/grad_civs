#include "..\script_component.hpp"

ISNILS(GVAR(efIDs), []);

for "_i" from 2 to (round GVAR(smMultiplicator)) do {
    GVAR(efIDs) pushBack (addMissionEventHandler ["EachFrame", {call cba_statemachine_fnc_clockwork}]);
};
INFO_1("CBA statemachines are running %1 more ticks per frame now", count GVAR(efIDs));
