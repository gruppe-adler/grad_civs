#include "..\script_component.hpp"

#define IDD_MAIN_MAP 12
#define IDC_CONTROLS_BACKGROUND_MAP 51

#define IDD_RSCDISPLAYCURATOR 312
#define IDC_RSCDISPLAYCURATOR_MAINMAP 50


ISNILS(GVAR(unitsOnMapEhs), []);
{
	_x params ["_id", "_eventType", "_control"];
	_control ctrlRemoveEventHandler [_eventType, _id];
}forEach GVAR(unitsOnMapEhs)

{
	[_x, _y] call FUNC(showOnMap);
} forEach createHashMapFromArray [
	[IDD_MAIN_MAP, IDC_CONTROLS_BACKGROUND_MAP],
	[IDD_RSCDISPLAYCURATOR, IDC_RSCDISPLAYCURATOR_MAINMAP]
];
