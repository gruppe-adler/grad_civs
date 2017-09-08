# GRAD Civilians
This will be able to randomly spawn ambient civilians on the map.

## Dependencies
* [CBA_A3](https://github.com/CBATeam/CBA_A3)

## Installation
### Manually
1. Create a folder in your mission root folder and name it `modules`. Then create one inside there and call it `grad-civs`.
2. Download the contents of this repository ( there's a download link at the side ) and put it into the directory you just created.
3. Append the following lines of code to the `description.ext`:

```sqf
class CfgFunctions {
    #include "modules\grad-civs\cfgFunctions.hpp"
};
```


### Via `npm`
_for details about what npm is and how to use it, look it up on [npmjs.com](https://www.npmjs.com/)_

1. Install package `grad-civs` : `npm install --save grad-civs`
2. Prepend your mission's `description.ext` with `#define MODULES_DIRECTORY node_modules`
3. Append the following lines of code to the `description.ext`:

```sqf
class CfgFunctions {
    #include "node_modules\grad-civs\cfgFunctions.hpp"
};
```

# Config
Add the class `cfgGradCivs` to your `description.ext`. Use the following attributes to configure the module:

## Attributes

Attribute                | Default Value | Explanation
-------------------------|---------------|------------------------------------------------------------------------------------------------------------------------------------------------
autoInit                 | 1             | Toggles on automatic initialization of module on missions start (0/1). Turn this off if you want to use functions to set civs properties first.
maxCivsOnFoot            | 30            | Maximum number of civs on foot.
maxCivsInVehicles        | 10            | Maximum number of civs in vehicles.
spawnDistancesOnFoot     | [1000,4500]   | Minimum and maximum distance to players that civilians on foot can spawn in.
spawnDistancesInVehicles | [1500,6000]   | Minimum and maximum distance to players that civilians in vehicles can spawn in.
debugMode                | 0             | Toggles debug mode (0/1).
onSpawn                  | ""            | Code to execute on civilian spawn. Passed parameters are: [civilian].
onHeldUp                 | ""            | Code to execute when civilian stops because a weapon is pointed at him. Passed parameters are: [civilian].
exitOn                   | ""            | Condition upon which grad-civs loops will stop.
clothes                  | []            | All classnames of clothes that civilians may wear.
faces                    | []            | All classnames of faces that civilians may have.
goggles                  | []            | All classnames of goggles that civilians may wear.
headgear                 | []            | All classnames of headgear that civilians may wear.
backpacks                | []            | All classnames of backpacks that civilians may wear.
vehicles                 | []            | All classnames of vehicles that civilians may drive.
backpackProbability      | 0.5           | Probability that a civilian will wear a backpack.

## Example

```sqf
class CfgGradCivs {
    autoInit = 0;
    maxCivs = 60;
    spawnDistances[] = {1000,4500};
    debugMode = 1;
    exitOn = "";
    onSpawn = "";
    onHeldUp = "";    
    backpackProbability = 0.5;

    clothes[] = {
        "rds_uniform_Worker1",
    	"rds_uniform_Worker2"
    };

    headgear[] = {
        "rds_Villager_cap1",
    	"rds_Villager_cap2"
    };

    faces[] = {
        "PersianHead_A3_01",
    	"PersianHead_A3_02",
    	"PersianHead_A3_03"
    };

    goggles[] = {
        "TRYK_Beard_BK",
       	"TRYK_Beard_BK2",
        "TRYK_Beard_BK3"
    };

    backpacks[] = {
        "rhs_sidor"
    };
};
```

# Functions

## grad_civs_fnc_setClothes
Sets all clothes that civilians may wear. Overwrites `cfgGradCivs` value. Effect is global.

### Syntax
`[clothes] call grad_civs_fnc_setClothes`

Parameter | Explanation
----------|-----------------------------------------------------------
clothes   | Array - All classnames of clothes that civilians may wear.

## grad_civs_fnc_setFaces
Sets all faces that civilians may have. Overwrites `cfgGradCivs` value. Effect is global.

### Syntax
`[faces] call grad_civs_fnc_setFaces`

Parameter | Explanation
----------|---------------------------------------------------------
faces     | Array - All classnames of faces that civilians may have.


## grad_civs_fnc_setGoggles
Sets all goggles that civilians may wear. Overwrites `cfgGradCivs` value. Effect is global.

### Syntax
`[goggles] call grad_civs_fnc_setGoggles`

Parameter | Explanation
----------|-----------------------------------------------------------
goggles   | Array - All classnames of goggles that civilians may wear.

## grad_civs_fnc_setHeadgear
Sets all headgear that civilians may wear. Overwrites `cfgGradCivs` value. Effect is global.

### Syntax
`[headgear] call grad_civs_fnc_setHeadgear`

Parameter | Explanation
----------|-----------------------------------------------------------
headgear  | Array - All classnames of clothes that civilians may wear.

## grad_civs_fnc_setBackpacks
Sets all backpacks that civilians may wear and sets probability. Overwrites `cfgGradCivs` value. Effect is global.

### Syntax
`[backpacks,probability] call grad_civs_fnc_setHeadgear`

Parameter   | Explanation
------------|-----------------------------------------------------------------------
backpacks   | Array - All classnames of clothes that civilians may wear.
probability | Number - Probability that civilian will wear a backpack. Default: 0.5.

## grad_civs_fnc_setVehicles
Sets all vehicles that civilians may drive. Overwrites `cfgGradCivs` value. Effect is global.

### Syntax
`[vehicles] call grad_civs_fnc_setVehicles`

Parameter | Explanation
----------|-------------------------------------------------------------
vehicles  | Array - All classnames of vehicles that civilians may drive.

## grad_civs_fnc_setDebugMode
Sets debug mode. Overwrites `cfgGradCivs` value. Effect is global.

### Syntax
`[debugMode] call grad_civs_fnc_setDebugMode`  

Parameter | Explanation
----------|--------------------------
debugMode | Bool - Debug mode on/off.

## grad_civs_fnc_initModule
Used to manually initialize module. Has to be executed on clients and server. Effect is local.

### Syntax
`[] call grad_civs_fnc_initModule`  
`[] remoteExec ["grad_civs_fnc_initModule",0,true]`

Parameter | Explanation
----------|-----------------------------------------------------------
headgear  | Array - All classnames of clothes that civilians may wear.

## grad_civs_fnc_populateArea
Manually populates an area with civilians. These civilians count towards the maximum amount, but will get cleaned up when no players are near enough.

### Syntax
`[area] call grad_civs_fnc_populateArea`

Parameter | Explanation
----------|-------------------------------------------------------------------------------------------------------------------------------------------------
area      | Array / Object - Area array in format `[a, b, angle, isRectangle]` or array of area arrays or gamelogic synchronzed to one or multiple triggers.
