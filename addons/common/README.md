# grad\_civs\_common

Generic library. Probably nothing of interest unless you're a developer.

## API

### grad_civs_common_fnc_addExclusionZone and grad_civs_common_fnc_addPopulationZone

Prevent civilians from entering areas.

Optionally whitelist areas using `[_area] call grad_civs_common_fnc_addPopulationZone` , then forbid parts of them using `[_area] call grad_civs_common_fnc_addExclusionZone` .

*known issues: pathing through area is not checked. To minimize that problem, define exclusionZones with large diameter.*

#### Syntax

`[_trigger] call grad_civs_common_fnc_addExclusionZone;`  