#include "..\..\component.hpp"

_this params [
    ["_trigger", objNull]
];

if (isNull _trigger) exitWith {
    ERROR("got NULL instead of a trigger as parameter");
};

GVAR(POPULATION_ZONES) pushBack _trigger;

INFO_2("added population zone %1 at %2", triggerArea _trigger, getPos _trigger);
