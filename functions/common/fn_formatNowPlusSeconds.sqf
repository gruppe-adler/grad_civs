#include "..\..\component.hpp"

private _seconds = _this;
private _date = _seconds call FUNC(nowPlusSeconds);
([_date] call BIS_fnc_timeToString)
