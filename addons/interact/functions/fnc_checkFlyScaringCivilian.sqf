#include "..\script_component.hpp"

private _vic = vehicle ACE_player;

if (!(_vic isKindOf "Air")) exitWith {
    // FIXME this will trigger when player dies! fix!
    // also after ejecting
    WARNING_1("wtf, %1 not an air vic", _vic);
};

if (!(isEngineOn _vic) && ((getPos _vic)#2 < 0.5)) exitWith {
    LOG_1("vehicle %1 is on the ground, engine off", _vic);
};

private _dangerPolyAirAGL = [_vic] call FUNC(getDangerPolyAir);
_dangerPolyAirAGL params [
	"_center",
	"_close",
	"_farAhead",
	"_far"
];

private _dangerPolyCloseToFar = (_close createHashMapFromArray _far) toArray false;
private _dangerPolyClose = {
    _dangerPolyCloseToFar pushBackUnique [_x, _close#((_forEachIndex + 1) mod 8)]
} forEach _close;
private _dangerPolyFar = {
    _dangerPolyCloseToFar pushBackUnique [_x, _far#((_forEachIndex + 1) mod 8)]
} forEach _far;
private _dangerPolyFarAhead =  {
    _dangerPolyCloseToFar pushBackUnique [_x, _farAhead]
} forEach _far;

private _dangerPolyGround = _dangerPolyCloseToFar apply {
    // we're having AGL values here!
    // be sure to put the higher-above-ground point *first* , else the terrainIntersectAtASL thing will just return the belkow-ground starting point
    if ((_x#0)#2 < (_x#1)#2) then { [(_x#1), (_x#0)]} else {[(_x#0), (_x#1)]}
} select {
    // filter those that do not intersect the ground
    (_x#0)#2 > 0 && (_x#1)#2 < 0
} apply {
    // finally switch to ASL for finding actual ground intersection & do it
    terrainIntersectAtASL [AGLToASL (_x#0), AGLToASL (_x#1)]
} select {
    // should not be necessary now -
    private _yes = (_x isNotEqualTo [0, 0, 0]) && ((ASLToAGL _x)#2 > -0.1);
    if (!_yes) then {
        WARNING("checkFlyScaringCivilian: this should not happen");
    };
    _yes
};

[QGVAR(flyscare_poly), [_dangerPolyAirAGL, _dangerPolyGround]] call CBA_fnc_localEvent;

if (count _dangerPolyGround < 3) exitWith {
    LOG("checkFlyScaringCivilian: no ground intersect");
};

// project onto z := 0
_dangerPolyGround = _dangerPolyGround apply {[_x#0, _x#1, 0]};

private _nearCivs = (_vic nearEntities [["Man"], 200]) arrayIntersect ([] call EFUNC(lifecycle,getGlobalCivs));
private _endangeredCivs = _nearCivs select {
    private _civPosGround = (getPos _x); _civPosGround set [2, 0];
    _civPosGround inPolygon _dangerPolyGround
};
if ((count _endangeredCivs) > 0) then {
    LOG_2("checkFlyScaringCivilian: %1 found of which %2 endangered", count _nearCivs, count _endangeredCivs);
};

{
    [QGVAR(flown_over), [_x, getPos _vic, velocity _vic], [_x]] call CBA_fnc_targetEvent;
} forEach _endangeredCivs;
