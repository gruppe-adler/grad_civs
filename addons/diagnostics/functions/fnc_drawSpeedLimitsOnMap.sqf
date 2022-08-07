#include "..\script_component.hpp"

params [
    ["_mode", "update", [""]]
];

ISNILS(GVAR(speedLimitMarkers), []);
{
    deleteMarkerLocal _x;
} forEach GVAR(speedLimitMarkers);
GVAR(speedLimitMarkers) = [];

if (_mode == "delete") exitWith {};

private _speedLimits = call EFUNC(cars,determineSpeedLimits);

{
    _x params ["_location", "_speedLimit"];

    private _circle = createMarkerLocal [format ["speed_limit_town_%1_circle", _forEachIndex], position _location];
    _circle setMarkerShapeLocal "ELLIPSE";
    _circle setMarkerSizeLocal (size _location);
    _circle setMarkerBrushLocal "SolidBorder";
    _circle setMarkerColorLocal "ColorBlue";
    _circle setMarkerAlphaLocal 0.5;

    private _text = createMarkerLocal [format ["speed_limit_town_%1_text", _forEachIndex], position _location];
    _text setMarkerShapeLocal "ICON";
    _text setMarkerTypeLocal "mil_circle_noShadow";
    _text setMarkerColorLocal "ColorBlue";
    _text setMarkerTextLocal (format ["%1 km/h", _speedLimit]);


    GVAR(speedLimitMarkers) pushBack _circle;
    GVAR(speedLimitMarkers) pushBack _text;

} forEach _speedLimits;
