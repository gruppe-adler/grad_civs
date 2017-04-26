# GRAD Civilians (WIP)
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

# Pictures
