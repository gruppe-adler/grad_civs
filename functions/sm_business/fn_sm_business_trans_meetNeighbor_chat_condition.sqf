private _neighbor = _this getVariable ["grad_civs_neighborToMeet", objNull];
if (isNull _neighbor) exitWith {true}; // go to chat only so that chat can lead  to housework in the next tick
if (!(alive _neighbor)) exitWith {true};

/*get closer than 2m to have a conversation*/
(_this distance _neighbor) < 2 || ((_thisStateTime + 90) < CBA_missionTime)
