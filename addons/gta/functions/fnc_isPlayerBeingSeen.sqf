#include "..\script_component.hpp"

params [
	["_maxDistance", 0, [0]],
	["_visibility", 0.5, [0]]
];

private _civClasses = call EFUNC(common,config_getCivClasses);

-1 != ((ACE_player nearEntities [_civClasses, _maxDistance]) findIf {([vehicle ACE_player, "VIEW"] checkVisibility [eyePos _x, getPosASL ACE_player]) > _visibility})