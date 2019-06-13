/*  Creates random voyage for vehicle
*
*   [group,position,radius,count] call grad_civs_taskPatrol;
*
*   Params:
*   0: group        group or vehicle
*   1: position     position or object - if object, position of object is used
*   2: radius       number or array - if array, random radius between first and second element is used
*   3: count        number > 1, or array - amount of waypoints to generate, if array, random amount between first and second element is used
*/

params ["_groupOrUnit","_centerPositionOrObject","_radius","_count"];

if (!canSuspend) exitWith {
    [_groupOrUnit,_centerPositionOrObject,_radius,_count] spawn grad_civs_taskVoyage;
};

private _group = if (typeName _groupOrUnit == "OBJECT") then {group _groupOrUnit} else {_groupOrUnit};
private _centerPosition = if (typeName _centerPositionOrObject == "OBJECT") then {getPos _centerPositionOrObject} else {_centerPositionOrObject};
_radius = if (typeName _radius == "ARRAY") then {(random ((_radius select 1) - (_radius select 0))) + (_radius select 1)} else {_radius};
_count = if (typeName _count == "ARRAY") then {(random ((_count select 1) - (_count select 0))) + (_count select 1)} else {_count};
private _position = _centerPosition;

private _edgePoints = [getPos _group];

for [{_i=0}, {_i<_count}, {_i=_i+1}] do {
    private _searchPosition = [_centerPosition,[_radius / 2 ,_radius],[0,360],nil,_findWaterPos,_findRoadPos] call grad_civs_fnc_findRandomPos;

    if (count _searchPosition > 0) then {
        _edgePoints pushBackUnique _searchPosition;
    };
};



{
    // exit last loop as path is already drawn to it
    if (_forEachIndex == count _edgePoints) exitWith {
         [missionNamespace getVariable ["GRAD_CIVS_CALCPATH_RESULT", []], "colorGreen"] call grad_civs_fnc_renderPath;
    };

    private _startPoint = _edgePoints select _x;
    private _nextPoint = _edgePoints select (_forEachIndex + 1);


    private _agent = (calculatePath ["man","safe",_startPoint,_nextPoint]);
    _agent addEventHandler ["PathCalculated",{
        params ["_agent", "_path"];

        [_path, "colorRed"] call grad_civs_fnc_renderPath;

        missionNamespace setVariable ["GRAD_CIVS_CALCPATH_CACHE", _path select 1];
    }];


    waitUntil {
        sleep 2;
        count (missionNamespace getVariable ["GRAD_CIVS_CALCPATH_CACHE", []]) > 0
    };

    // retrieve and clear cache
    private _currentPath = missionNamespace getVariable ["GRAD_CIVS_CALCPATH_CACHE", []];
    missionNamespace setVariable ["GRAD_CIVS_CALCPATH_CACHE", []];

    if ([_currentPath] call GRAD_civs_fnc_isInRestrictedArea) exitWith {
        [_groupOrUnit,_centerPositionOrObject,_radius,_count] spawn grad_civs_taskVoyage;
        diag_log format ["GRAD-civs: starting new try to find path at loop %1", _forEachIndex];
    };

    [_currentPath, "colorBlack"] call grad_civs_fnc_renderPath;

    private _result = missionNamespace getVariable ["GRAD_CIVS_CALCPATH_RESULT", []];
    _result pushBack _currentPath;
    missionNamespace setVariable ["GRAD_CIVS_CALCPATH_RESULT", _result];

} forEach _edgePoints;