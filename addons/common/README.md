# grad\_civs\_common

Common code. Basic configuration.

## 3DEN Modules

### Population Zone

Define areas where civilians may spawn. If no Ppopulation Zone is placed, the whole terrain is assumed to be one big Population Zone.

#### Usage

* place a trigger to define an area (no other trigger settings needed!)
* place Population Zone module
* sync Population Zone module to the trigger
* _optional:_ place civilians and/or civilian vehicles to define the types (classes) of civilians that are allowed to spawn in the respective population zone, and sync them to either the Population Zone trigger or to the Population Zone module


### Exclusion Zone

From existing Population Zones, subtract areas  where civilian may *not* spawn.

#### Usage

* place a trigger to define an area (no other trigger settings needed!)
* place Exclusion Zone module
* sync module to trigger


## API

### `grad_civs_common_fnc_addExclusionZone` and `grad_civs_common_fnc_addPopulationZone`

Whitelist areas or prevent civilians from spawning in areas (area = trigger area).

*known issues: pathing through area is not checked. To minimize that problem, define exclusionZones with large diameter.*

#### Syntax

* `[_trigger, _civClasses, _vehicleClasses] call grad_civs_common_fnc_addPopulationZone` , then forbid parts of them using `[_area] call grad_civs_common_fnc_addExclusionZone`
* `[_trigger] call grad_civs_common_fnc_addExclusionZone;`  