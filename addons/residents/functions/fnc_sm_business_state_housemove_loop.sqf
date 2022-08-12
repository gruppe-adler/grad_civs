#include "..\script_component.hpp"

if (speed _this == 0) then {
    private _targetPos = _this getVariable [QGVAR(targetPos), getPos _this];
    LOG_3("%1 : Ordering myself to move from %2 to %3 as my speed was 0 during housemove", _this, getPos _this, _targetPos);
    _this moveTo _targetPos;
};
