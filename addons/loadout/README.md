# grad\_civs\_loadout

Determine clothing etc for civilians

## API


### grad_civs_loadout_fnc_setClothes

Sets all clothes that civilians may wear. Overwrites value from CBA settings. Execute globally

#### Syntax
`[clothes] call grad_civs_loadout_fnc_setClothes`

Parameter | Explanation
----------|-----------------------------------------------------------
clothes   | Array - All classnames of clothes that civilians may wear.

### grad_civs_loadout_fnc_setFaces
Sets all faces that civilians may have.  Overwrites value from CBA settings. Execute globally

#### Syntax
`[faces] call grad_civs_loadout_fnc_setFaces`

Parameter | Explanation
----------|---------------------------------------------------------
faces     | Array - All classnames of faces that civilians may have.


### grad_civs_loadout_fnc_setGoggles
Sets all goggles that civilians may wear.  Overwrites value from CBA settings. Execute globally

#### Syntax
`[goggles] call grad_civs_loadout_fnc_setGoggles`

Parameter | Explanation
----------|-----------------------------------------------------------
goggles   | Array - All classnames of goggles that civilians may wear.

### grad_civs_loadout_fnc_setHeadgear
Sets all headgear that civilians may wear.  Overwrites value from CBA settings. Execute globally

#### Syntax
`[headgear] call grad_civs_loadout_fnc_setHeadgear`

Parameter | Explanation
----------|-----------------------------------------------------------
headgear  | Array - All classnames of clothes that civilians may wear.

### grad_civs_loadout_fnc_setBackpacks
Sets all backpacks that civilians may wear and sets probability. Overwrites value from CBA settings. Execute globally

#### Syntax
`[backpacks,probability] call grad_civs_loadout_fnc_setHeadgear`

Parameter   | Explanation
------------|-----------------------------------------------------------------------
backpacks   | Array - All classnames of clothes that civilians may wear.
probability | Number - Probability that civilian will wear a backpack. Default: 0.5.
