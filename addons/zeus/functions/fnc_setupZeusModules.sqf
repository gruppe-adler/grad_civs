#include "..\script_component.hpp"

if (isNil "zen_custom_modules_fnc_register") exitWith {
    WARNING("ZEN mod does not seem to be loaded: will not define ZEN context functions");
};

private _category = "GRAD Civilians";

[
    _category,
    "From Area Marker, Add Exclusion Zone",
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
    "From Area Marker, Add Population Zone",
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
    "Add Civilian Car (Voyager)",
    FUNC(module_addCar),
    QPATHTOF(ui\icon_module_addCar.paa)
] call zen_custom_modules_fnc_register;

[
    _category,
    "Add Civilian Patrol",
    FUNC(module_addPatrol),
    QPATHTOF(ui\icon_module_addPatrol.paa)
] call zen_custom_modules_fnc_register;

[
    _category,
    "Add Civilian Resident",
    FUNC(module_addResident),
    QPATHTOF(ui\icon_module_addResident.paa)
] call zen_custom_modules_fnc_register;
