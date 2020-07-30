#include "..\script_component.hpp"

params [
    ["_path", [], [[]]],
    ["_color", "", [""]]
];

ISNILS(GVAR(pathMarkers), []);

GVAR(pathMarkers) pushBack (_path apply {
    private _name = format [format ["marker_path_%1_%2"], _x, _forEachIndex];
    private _mrk = createMarker [_name, _x];
    _mrk setMarkerType "mil_dot";
    _mrk setMarkerColor _color;
    _mrk setMarkerText str _forEachIndex;

    _mrk
});
