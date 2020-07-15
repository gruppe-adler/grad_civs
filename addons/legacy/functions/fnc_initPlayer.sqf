#include "..\script_component.hpp"

if (hasInterface) then {

    [] call FUNC(playerLoop);
    [] call FUNC(addCivInteractions);
    if ((GVAR(debugCivState))) then {
        [] call FUNC(showWhatTheyThink);

        [{!isNull (findDisplay 12)}, {[] call FUNC(mapMarkers)}, []] call CBA_fnc_waitUntilAndExecute;
    };
};
