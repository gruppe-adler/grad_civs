#include "..\script_component.hpp"

private _category = "GRAD Civs";

[
    _category,
    "Add Exclusion Zone from Area Marker",
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

        [_marker] call EFUNC(common,addExclusionZone);
        _marker setMarkerBrushLocal "BORDER";
        _marker setMarkerColorLocal "ColorUNKNOWN";
    },
    QPATHTOEF(common,ui\icon_module_exclusion_zone_ca.paa)
] call zen_custom_modules_fnc_register;

[
    _category,
    "Add Population Zone from Area Marker",
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

        [_marker] call EFUNC(common,addPopulationZone);
        _marker setMarkerBrushLocal "BORDER";
        _marker setMarkerColorLocal "ColorCIV";
    },
    QPATHTOEF(common,ui\icon_module_population_zone_ca.paa)
] call zen_custom_modules_fnc_register;

[
    _category,
    "Add Car (Voyager)",
    FUNC(module_addCar),
    QPATHTOF(ui\icon_module_addCar.paa)
] call zen_custom_modules_fnc_register;
