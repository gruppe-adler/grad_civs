["given a point surrounded by exclusion zones on three sides",
    {
        private _trgW = createTrigger ["EmptyDetector", [-250, 150, 0]];
        _trgW setTriggerArea [150, 250, 0, true];
        [_trgW] call grad_civs_fnc_addExclusionZone;

        private _trgS = createTrigger ["EmptyDetector", [0, -250, 0]];
        _trgS setTriggerArea [200, 150, 0, true];
        [_trgS] call grad_civs_fnc_addExclusionZone;

        private _trgE = createTrigger ["EmptyDetector", [250, 150, 0]];
        _trgE setTriggerArea [150, 250, 0, true];
        [_trgE] call grad_civs_fnc_addExclusionZone;
    },
    [
        ["when a patrol path is created",
            {
                [([[0, 0, 0], 250, 3] call grad_civs_fnc_taskPatrolFindWaypoints)]
            },
            [
                ["three positions are returned as requested",
                    {
                        params [["_positions", []]];
                        [3, count _positions] call grad_testing_fnc_assertEquals;
                    }
                ],
                ["will avoid exclusion zones as waypoints",
                    {
                        params [["_positions", []]];

                        {
                            private _exclusionZone = _x;
                            private _exclusionZoneIdx = _forEachIndex;
                            {
                                [
                                    _x inArea _exclusionZone,
                                    format ["waypoint %1 at %2 is not in exclusion zone at %3 (%4)", _forEachIndex, _x, getPos _exclusionZone, triggerArea _exclusionZone]
                                ] call grad_testing_fnc_assertFalse;
                            } forEach _positions;
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
] call grad_testing_fnc_executeTest;
