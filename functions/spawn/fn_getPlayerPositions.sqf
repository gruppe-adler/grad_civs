/* blatantly ripped from engima traffic */

#include "..\..\component.hpp"

if (isMultiplayer) then {
	(call CBA_fnc_players) apply {getPos _x}
} else {
	[getPos player]
}
