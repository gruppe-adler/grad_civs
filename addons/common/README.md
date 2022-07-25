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

## grad_civs_common_fnc_addPopulationZone

Whitelist areas to allow civilians to spawn in those areas (area = trigger area).

**Syntax**
```sqf
[_trigger, _civClasses, _vehicleClasses] call grad_civs_common_fnc_addPopulationZone
```

## grad_civs_common_fnc_addExclusionZone

Prevent civilians from being spawned in specific areas.

**Syntax**
```sqf
[_trigger] call grad_civs_common_fnc_addExclusionZone;
```

**Alternative syntax**
```sqf
[
    [
        [x, y, z], // Coordinates
        150, // X Radius
        150, // Y Radius
        0, // Angle
        false // True if area is Rectangle. False for Ellipse
    ]
] call grad_civs_common_fnc_addExclusionZone;
```

*known issues: pathing through area is not checked. To minimize that problem, define exclusionZones with large diameter.*