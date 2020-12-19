# grad\_civs\_cba\_statemachine

Some extensions to the CBA statemachine module. Probably nothing of interest unless you're a developer.

### state stot wot?

worry not, here comes a friendly introduction:

**CBA state machine for dummies**

#### what are state machines

A state machine is a construct made of states and transitions between states. It can be visualized very easily as a directed graph with nodes (states) and edges (transitions). The state machine gets fed with a bunch of entities that inhabit the states. It periodically checks the states and moves the entities along the transitions from one state to the next.

#### how do they look like with CBA

Let's have a very simple example:

```sqf
MY_CIV_LIST = ["C_Offroad_01_F" createVehicle position player];
_machine = [{MY_CIV_LIST}] call CBA_statemachine_fnc_create;
_state_init = [_machine, { diag_log "init"; }, { diag_log "onEnter_init" }, { diag_log "onExit_init" }] call grad_civs_cba_statemachine_fnc_addState;
_state_stuff = [_machine, {diag_log "wörk" }, {diag_log "onEnter_wörk"}, {}] call grad_civs_cba_statemachine_fnc_addState;
_transition = [_machine, _state_init, _state_stuff, {CBA_missionTime > 30}, {diag_log "changing state" }] call grad_civs_cba_statemachine_fnc_addTransition;
```

this will print something like this to RPT:

```
onEnter_init
init
# … (until CBA_missionTime > 30)
init
onExit_init
changing state
onEnter_wörk
wörk
wörk
# …
```
