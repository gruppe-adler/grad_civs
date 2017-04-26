/* blatantly ripped from engima traffic */

#include "..\..\component.hpp"

_allPlayerPositionsTemp = [];
_allPlayerPositions = [];

if (isMultiplayer) then {
	{
		if (isPlayer _x) then {
			_allPlayerPositionsTemp = _allPlayerPositionsTemp + [position vehicle _x];
		};
	} foreach (playableUnits);
}
else {
	_allPlayerPositionsTemp = [position vehicle player];
};

if (count _allPlayerPositionsTemp > 0) then {
	_allPlayerPositions = _allPlayerPositionsTemp;
};

_allPlayerPositions
