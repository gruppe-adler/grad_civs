#include "..\script_component.hpp"

params [
	["_polygon", [], [[]]],
	["", [], [[]]]
];

_polygon params [
	"",
	"_close",
	"_farAhead",
	"_far"
];

private _lineColor = [1, 0, 1, 1];

(_close createHashMapFromArray _far) apply {
    // we're having AGL values here!
    // be sure to put the higher-above-ground point *first* , else the terrainIntersectAtASL thing will just return the belkow-ground starting point
    drawLine3D [_x, _y, _lineColor];
};
{
    drawLine3D [_x, _close#((_forEachIndex + 1) mod 8), _lineColor];
} forEach _close;
{
    drawLine3D [_x, _far#((_forEachIndex + 1) mod 8), _lineColor];
	drawLine3D [_x, _farAhead, _lineColor];
} forEach _far;
