params ["_pos"];

_marker = createMarker [format["%1", toString _pos],_pos];
// diag_log format ["GRAD_CIV_DEBUG: Marker %1 created", _marker];
_marker setMarkerShape "ICON";
_marker setMarkerType "hd_dot";
_marker setMarkerAlpha 1;
_marker setMarkerColor "ColorYellow";
_marker setMarkerText "GRAD_CIV";