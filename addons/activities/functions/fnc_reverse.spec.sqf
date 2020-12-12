private _vehicleClasses = [{"C_Offroad_01_repair_F"}, {"C_Quadbike_01_F"}, {"C_Van_01_fuel_F"}];
if (isClass (configFile >> "CfgVehicles" >> "LOP_AFR_Civ_Ural_open")) then {
    _vehicleClasses pushBack {"LOP_AFR_Civ_Ural_open"};
};


[
    "GIVEN a vehicle class %1 with more than one seat",
    _vehicleClasses,
    [
        ["AND I instantiate it",
            {
                private _veh = _this createVehicle [0, 0, 0];
                _veh setDir 0;
                _veh setPos [0, 0, 0];
                _veh
            },
            [
                ["AND I add no crew",
                    {_this},
                    [
                        ["WHEN I let it reverse",
                            {
                                [_this, [0, -50, 0]] call grad_civs_activities_fnc_reverse;
                                _this
                            },
                            [
                                ["THEN it has not moved after 2s",
                                    {
                                        params ["_veh"];
                                        sleep 4;
                                        [(getPos _veh) distance [0, 0, 0], 1] call grad_testing_fnc_assertLessThan;
                                    }
                                ],
                                ["THEN it is not moving after 2s",
                                    {
                                        params  ["_veh"];
                                        sleep 4;
                                        [speed _veh, 0] call grad_testing_fnc_assertEquals;
                                    }
                                ]
                            ]
                        ]
                    ]
                ],
                ["AND I add only the driver",
                    {
                        private _group = createGroup [civilian, true];
                        _group setCombatMode "GREEN";
                        private _a = _group createUnit ["C_Man_1", [0, 10, 0], [], 0, "NONE"];
                        _a moveInDriver _this;
                        _this
                    },
                    [
                        ["WHEN I let it reverse",
                            {
                                [_this, [0, -50, 0]] call grad_civs_activities_fnc_reverse;
                                _this
                            },
                            [
                                ["THEN it has indeed reversed after 2s",
                                    {
                                        sleep 4;
                                        [(getPos _this) select 1, -20, -1] call grad_testing_fnc_assertBetween;
                                    }
                                ],
                                ["THEN it is still moving after 2s",
                                    {
                                        sleep 4;
                                        [speed _this, 0] call grad_testing_fnc_assertLessThan;
                                    }
                                ]
                            ]
                        ]
                    ]
                ],
                ["AND I fill the vehicle with people",
                    {
                        private _group = createGroup [civilian, true];
                        _group setCombatMode "GREEN";
                        private _pos = [0, 0, 0];
                        private _d = _group createUnit ["C_Man_1", _pos, [], 0, "NONE"];
                        _d moveInDriver _this;
                        {
                            if (isNull (_x select 0)) then {
                                private _p = _group createUnit ["C_Man_1", [0, 10, 0], [], 0, "NONE"];
                                _p moveInAny _this;
                            };
                        } forEach (fullCrew [_this, "cargo", true]);
                        _this
                    },
                    [
                        ["WHEN I let it reverse",
                            {
                                [_this, [0, -20, 0]] call grad_civs_activities_fnc_reverse;
                                _this
                            },
                            [
                                ["THEN it has indeed reversed after 2s",
                                    {
                                        sleep 4;
                                        [(getPos _this) select 1, -25, -1] call grad_testing_fnc_assertBetween;
                                    }
                                ],
                                ["THEN it is still moving after 2s",
                                    {
                                        sleep 4;
                                        [speed _this, 0] call grad_testing_fnc_assertLessThan;
                                    }
                                ],
                                ["THEN it is close to the target and stopped after 15s",
                                    {
                                        sleep 12;
                                        [(getPos _this) select 1, -22, -18] call grad_testing_fnc_assertBetween;
                                        [(getPos _this) select 0, -5, 5] call grad_testing_fnc_assertBetween;
                                        [speed _this, 0] call grad_testing_fnc_assertEquals;
                                    }
                                ],
                                ["THEN its effective commander is the driver again (NOTE: works only for civilian vehicles)",
                                    {
                                        sleep 12;
                                        [driver _this, effectiveCommander _this] call grad_testing_fnc_assertEquals;
                                    }
                                ]
                            ]
                        ],
                        ["WHEN I let it reverse 100m AND abort after 2 seconds",
                            {
                                [_this, [0, -100, 0]] call grad_civs_activities_fnc_reverse;
                                sleep 2;
                                [_this] call grad_civs_activities_fnc_reverse_abort;
                                _this
                            },
                            [
                                ["THEN it is stopped 2s later",
                                    {
                                        sleep 2;
                                        [speed _this, 0] call grad_testing_fnc_assertEquals;
                                    }
                                ],
                                ["THEN it is not even close to the target",
                                    {

                                        [(getPos _this) select 1, -20, -1] call grad_testing_fnc_assertBetween;
                                    }
                                ],
                                ["THEN its effective commander is the driver again (NOTE: works only for civilian vehicles)",
                                    {
                                        sleep 1;
                                        [driver _this, effectiveCommander _this] call grad_testing_fnc_assertEquals;
                                    }
                                ]
                            ]
                        ]
                    ]
                ]
            ],
            {
                {
                    _this deleteVehicleCrew _x
                } forEach (crew _this);
                deleteVehicle _this;
                sleep 0.1;
            }
        ]
    ]
] call grad_testing_fnc_executeTest;
