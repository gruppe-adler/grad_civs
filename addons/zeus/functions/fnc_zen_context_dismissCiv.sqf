#include "..\script_component.hpp"

INFO_2("yay dismiss civ module called with %1 (type %2)", _this, typeName _this);
{

    [_x] call EFUNC(common,dismissCiv);
} forEach _this;
