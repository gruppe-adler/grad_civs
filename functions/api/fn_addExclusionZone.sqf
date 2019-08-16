#include "..\..\component.hpp"

_this params [
    ["_trigger", objNull]
];

if (isNull _trigger) exitWith {
    ERROR("got NULL instead of a trigger as parameter");
};

GRAD_CIVS_EXCLUSION_ZONES pushBack _trigger;

INFO_1("added exclusion zone %1", triggerArea _trigger);
