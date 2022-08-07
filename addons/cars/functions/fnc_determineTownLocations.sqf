#include "..\script_component.hpp"

private _radius = worldSize / 2;
private _center = [_radius, _radius];
private _townLocationTypes = ["NameCity", "NameCityCapital", "NameVillage", "FlatAreaCity", "FlatAreaCitySmall"];
nearestLocations [
    _center,
    _townLocationTypes,
    _radius
]
