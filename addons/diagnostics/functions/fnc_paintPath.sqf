#include "..\script_component.hpp"

params [
    ["_path", [], [[]]],
    ["_color", "", [""]]
];

ISNILS(GVAR(pathMarkers), []);

private _id = count GVAR(pathMarkers);
private _idx = -1;
GVAR(pathMarkers) pushBack (_path apply {
    INC(_idx);
    private _name = format ["marker_path_%1_%2", _id, _idx];
    private _mrk = createMarker [_name, _x];
    _mrk setMarkerType "mil_dot";
    _mrk setMarkerColor _color;
    _mrk setMarkerText str _idx;

    _mrk
});
