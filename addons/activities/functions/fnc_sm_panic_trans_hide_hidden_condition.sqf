#include "..\script_component.hpp"

// within 2m of hidepoint (if one exists)
private _hidepoint = _this getVariable ["grad_civs_hidepoint", [0, 0, 0]];
(_this distance _hidepoint) < 2 || (_this distance2D _hidepoint) < 1
