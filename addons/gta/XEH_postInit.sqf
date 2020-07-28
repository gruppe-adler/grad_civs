#include "script_component.hpp"

if (!(EGVAR(main,enabled))) exitWith {};

if (isServer || CBA_isHeadlessClient) then {
    [] call FUNC(registerCivAddedHandler);
};

if (hasInterface) then {
    [] call FUNC(registerPlayerTheftHandler);
};
