#include "..\script_component.hpp"


if (speed _this == 0) then {
    private _targetPos = _this getVariable [QGVAR(targetPos), getPos _this];
    LOG_2("%1 : Ordering myself to move to %2 as my speed was 0 during housemove", _this, _targetPos);
    _this moveTo _pos;
};
