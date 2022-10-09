# grad\_civs\_lifecycle

Controls all spawning & despawning of civilians, as well as incapacitation & death.

## Settings

| Attribute                  | Default Value | Explanation                                                                                                                                                                                                                                                                                                   |
| -------------------------- | ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| civClasses                 | ["C_Man_1"]   | Unit classes to use for spawning civilians                                                                                                                                                                                                                                                                    |
| cleanupCorpses             | true          | If `corpseManagerMode` should be supported by adding dead units using `addToRemainsCollector`.                                                                                                                                                                                                                |
| minCivOwnerFps             | 30            | Spawn new civilians only on machines that have at least `N` fps.                                                                                                                                                                                                                                              |
| minCivUpdateTime           | 2             | Spawn new civilians only if their beheviour states get updated at least every N seconds. NOTE: each frame only one civ gets updated. Example: With 40fps and minCivUpdateTime=2, not more than 80 civs will be alive at any given time. This setting is meant to prevent civs from becoming too unresponsive. |
| minServerFps               | 40            | Spawn new civilians only if server fps are at or above `N`.                                                                                                                                                                                                                                                   |
| smMultiplicator            | 1             | Speed multiplicator for state machines on HC. Will reduce both civ update times and fps on the respective HC.                                                                                                                                                                                                 |
| spawnOnlyWithPlayers       | true          | Spawn civilians only if players are connected.                                                                                                                                                                                                                                                                |
| spawnCandidateLimitEnabled | true          | Enable the spawn candidate limiter that limits which players will have civilians in a radius around them. Improves performance by preventing civilians from spawning around fast moving players.                                                                                                              |
| spawnCandidateHeightLimit  | 200           | Sets the maximum height that players can be at before civilians will no longer spawn around them. Only used when the spawn candidate limiter is enabled.                                                                                                                                                       |
| spawnCandidateSpeedLimit   | 100           | Sets the maximum speed that players can travel at before civilians will no longer spawn around them. Only used when the spawn candidate limiter is enabled.                                                                                                                                                   |

## API

## grad_civs_lifecycle_fnc_setCivilians

Sets the classnames that civilians will spawn as. Overwrites value from CBA settings. Execute globally

#### Example

```sqf
private _civClasses = ["C_Man_01"];
[_civClasses] call grad_civs_lifecycle_fnc_setCivilians
```

| Parameter  | Explanation                                          |
| ---------- | ---------------------------------------------------- |
| civClasses | Array - All classnames that civilians will spawn as. |

## Events 

**NOTE:** event names are prefixed with `grad_civs_lifecycle_`

#### `civ_added` , `civ_removed`

If civilians come under the control of grad-civs or are removed from grad-civs control, respectively.
Argument is an *array of* civilians (i.e. units)

```sqf
["grad_civs_lifecycle_civ_added", { systemChat format ["new civs: %1", _this]}] call CBA_fnc_addEventHandler; 
```

#### `grad_civs_civKilled`

```sqf 
["grad_civs_civKilled", { params ["_deathPos", "_killer", "_civilian"]; }] call CBA_fnc_addEventHandler;
```
