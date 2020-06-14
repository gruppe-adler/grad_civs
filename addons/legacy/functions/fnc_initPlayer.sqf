#include "..\script_component.hpp"

if (hasInterface) then {

    [] call FUNC(playerLoop);
    [] call FUNC(addCivInteractions);
    [] call FUNC(setupZeusModules);
    if (([QGVAR(debugCivState)] call CBA_settings_fnc_get)) then {
        [] call FUNC(showWhatTheyThink);

        [{!isNull (findDisplay 12)}, {[] call FUNC(mapMarkers)}, []] call CBA_fnc_waitUntilAndExecute;
    };
};
