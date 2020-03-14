["a civilian",
    {
        call grad_civs_fnc_clearExclusionZones;
        private _group = createGroup [civilian, true];
        _group setCombatMode "GREEN";
        private _pos = [0, 0, 0];
        private _civ = _group createUnit ["C_Man_1", _pos, [], 0, "NONE"];
        _civ setPos _pos;
        [_civ]
    },
    [
        ["(homeless or not)",
            [
                {
                    params [["_civ", objNull]];
                    private _grp = (group _civ);
                    private _house = "Land_Lighthouse_small_F" createVehicle [0, 0, 0];
                    _house setPos (getPos _civ);
                    _grp setVariable ["grad_civs_home", _house];
                    [_civ]
                },
                {
                    _this
                }
            ],
            [
                ["who is tasked to patrol on foot",
                    {
                        params [["_civ", objNull]];
                        [_civ,  getPos _civ, 250, 3] call grad_civs_fnc_taskPatrol;
                        [_civ]
                    },
                    [
                        ["has at least number of desired MOVE waypoints",
                            {
                                params [["_civ", objNull]];
                                private _grp = (group _civ);
                                private _wps = waypoints _grp;
                                private _moveWps = { (waypointType _x) == "MOVE"} count _wps;
                                [_moveWps, 2] call grad_testing_fnc_assertGreaterThan;
                            }
                        ],
                        ["has at most desired MOVE wps, plus one for home",
                            {
                                params [["_civ", objNull]];
                                private _grp = (group _civ);
                                private _wps = waypoints _grp;
                                private _moveWps = { (waypointType _x) == "MOVE"} count _wps;
                                [_moveWps, 5] call grad_testing_fnc_assertLessThan;
                            }
                        ],
                        ["has a CYCLE waypoint as last waypoint",
                            {
                                params [["_civ", objNull]];
                                private _grp = (group _civ);
                                private _wps = waypoints _grp;
                                private _lastWp = _wps select ((count _wps) - 1);

                                [waypointType _lastWp, "CYCLE"] call grad_testing_fnc_assertEquals;
                            }
                        ],
                        ["has waypoints not too close",
                            {
                                params [["_civ", objNull]];
                                private _grp = (group _civ);
                                private _wps = waypoints _grp;

                                private _totalDistance = 0;
                                {
                                    private _prevIndex = if (_forEachIndex == 0) then {
                                        (count _wps - 1)
                                    } else {
                                        _forEachIndex - 1
                                    };
                                    private _distance = (waypointPosition _x) distance (waypointPosition  (_wps select _prevIndex));
                                    _totalDistance = _totalDistance + _distance;
                                } forEach _wps;

                                [_totalDistance, 100] call grad_testing_fnc_assertGreaterThan;
                            }
                        ]
                    ]
                ]
            ],
            {
                params [["_civ", objNull]];
                private _grp = (group _civ);

                private _house = _grp getVariable ["grad_civs_home", objNull];
                if (isNull _house) exitWith {};
                _grp setVariable ["grad_civs_home", objNull];
                deleteVehicle _house;
            }
        ],
        ["surrounded by exclusion zones on three sides",
            {
                params [["_civ", objNull]];

                private _trgW = createTrigger ["EmptyDetector", (getPos _civ) vectorAdd [-250, 150, 0]];
                _trgW setTriggerArea [150, 250, 0, true];
                [_trgW] call grad_civs_fnc_addExclusionZone;

                private _trgS = createTrigger ["EmptyDetector", (getPos _civ) vectorAdd [0, -250, 0]];
                _trgS setTriggerArea [200, 150, 0, true];
                [_trgS] call grad_civs_fnc_addExclusionZone;

                private _trgE = createTrigger ["EmptyDetector", (getPos _civ) vectorAdd [250, 150, 0]];
                _trgE setTriggerArea [150, 250, 0, true];
                [_trgE] call grad_civs_fnc_addExclusionZone;

                [_civ]
            },
            [
                ["and tasked to patrol",
                    {
                        params [["_civ", objNull]];
                        [_civ,  getPos _civ, 250, 3] call GRAD_CIVS_fnc_taskPatrol;
                        [_civ]
                    },
                    [
                        ["will avoid exclusion zones as waypoints",
                            {
                                params [["_civ", objNull]];

                                private _waypointPositions = (waypoints group _civ) apply {
                                    waypointPosition _x
                                };
                                {
                                    private _exclusionZone = _x;
                                    private _exclusionZoneIdx = _forEachIndex;
                                    {
                                        [
                                            _x inArea _exclusionZone,
                                            format ["waypoint %1 at %2 is not in exclusion zone at %3 (%4)", _forEachIndex, _x, getPos _exclusionZone, triggerArea _exclusionZone]
                                        ] call grad_testing_fnc_assertFalse;
                                    } forEach _waypointPositions;
                                } forEach (call grad_civs_fnc_getExclusionZones);
                            }
                        ],
                        ["will avoid crossing exclusion zones",
                            {
                                ["TODO"] call grad_testing_fnc_skipTest;
                            }
                        ]
                    ]
                ]
            ],
            grad_civs_fnc_clearExclusionZones
        ]
    ],
    {
        params [["_civ", objNull]];
        deleteVehicle _civ;
    }
] call grad_testing_fnc_executeTest;
