#include "..\script_component.hpp"

/*
 * if a civ gets moved to the HC for some reason (for example by acex_headless) take care to grab them
 * this *should not happen, as we're setting the acex exlusion var, but you never know...
 */

private _civClasses = call EFUNC(lifecycle,config_getCivClasses);
private _allCivs = entities [_civClasses, [], true, true];
private _myCivs = _allCivs select { local _x && (_x getVariable ["grad_civs_primaryTask", ""] != "")};
private _orphanedCivs = _myCivs - GVAR(localCivs);
if (count _orphanedCivs > 0) then {
    WARNING_1("%1 orphaned civs - putting them into my own array. this should not happen.", count _orphanedCivs);
    GVAR(localCivs) = GVAR(localCivs) + _orphanedCivs;
};
