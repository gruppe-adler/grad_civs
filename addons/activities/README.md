# Activities

## Description

Manages basic life states. Emotions, special activities, 

## API

### grad_civs_activities_fnc_doCustomActivity

Let civilians break from their usual activity and do something else for a limited time.

Example:

```sqf
[
    _civ,                               
    { _this#0 setBehaviour "STEALTH" },
    { _this#0 setBehaviour "CARELESS" },
    600,                                
    [],                                 
    "hiding",                           
    "pooped my pants, hiding for ten minutes"
] call grad_civs_activities_fnc_doCustomActivity;
```

**NOTE**: this whole thing will *NOT* work while they are panicking.

**NOTE**: do clean up after yourself in the `doEnd` parameter (reset AI stuff, animations etc)!

#### Parameters

Parameter           | Explanation
--------------------|-----------------------------------------------------------
civ                 | unit - civilian to apply to
doStart             | code - execute desired behavior. gets `civ` as first parameter, and the elements of `moreParameters`
doEnd               | code - end desired behavior. gets `civ` as first parameter, and the elements of `moreParameters`.
timeoutOrCondition  | number or code - behavior length in seconds, or condition to end behavior
moreParameters      | array (optional) - more parameters to be passed to doStart and doEnd
name                | string (optional) - behavior name
description         | string (optional) - behavior description
