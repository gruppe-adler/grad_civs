#include "..\script_component.hpp"

ISNILS(GVAR(pathMarkers), []);

while {(count GVAR(pathMarkers)) > GVAR(maxMarkedPaths)} do {
    {
        deleteMarker _x;
    } forEach (GVAR(pathMarkers) deleteAt 0);
    ;
};
