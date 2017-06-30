#include "..\..\component.hpp"

params ["_pos"];

private _marker = createMarker [format["%1", toString _pos],_pos];

_marker setMarkerShape "ICON";
_marker setMarkerType "hd_dot";
_marker setMarkerAlpha 1;
_marker setMarkerColor "ColorYellow";
_marker setMarkerText "GRAD_CIV";
