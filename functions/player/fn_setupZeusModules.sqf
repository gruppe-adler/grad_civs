#include "..\..\component.hpp"

["GRAD-CIVS","ADD EXCLUSION ZONE (click within existing area marker!)",
    {
        params [
            ["_clickPos", [0, 0, 0]]
        ];
        private _areaMarkersAtPos = allMapMarkers select {
            (["RECTANGLE", "ELLIPSE"] find (markerShape _x)) > -1
        } select {
            _clickPos inArea _x
        };

        private _distances = _areaMarkersAtPos apply { (markerPos _x) distance _clickPos };
        private _minDistanceAndIndex = _distances call CBA_fnc_findMin;

        if (isNil "_minDistanceAndIndex") exitWith {
            systemChat format["no area marker at position %1", _clickPos];
        };
        private _marker = _areaMarkersAtPos select (_minDistanceAndIndex#1);

        [_marker] call FUNC(addExclusionZone);
        _marker setMarkerBrushLocal "BORDER";
        _marker setMarkerColorLocal "ColorUNKNOWN";
    }
] call zen_custom_modules_fnc_register;

["GRAD-CIVS","ADD POPULATION ZONE (click within existing area marker!)",
    {
        params [
            ["_clickPos", [0, 0, 0]]
        ];
        private _areaMarkersAtPos = allMapMarkers select {
            (["RECTANGLE", "ELLIPSE"] find (markerShape _x)) > -1
        } select {
            _clickPos inArea _x
        };

        private _distances = _areaMarkersAtPos apply { (markerPos _x) distance _clickPos };
        private _minDistanceAndIndex = _distances call CBA_fnc_findMin;

        if (isNil "_minDistanceAndIndex") exitWith {
            systemChat format["no area marker at position %1", _clickPos];
        };
        private _marker = _areaMarkersAtPos select (_minDistanceAndIndex#1);

        [_marker] call FUNC(addPopulationZone);
        _marker setMarkerBrushLocal "BORDER";
        _marker setMarkerColorLocal "ColorCIV";
    }
] call zen_custom_modules_fnc_register;
