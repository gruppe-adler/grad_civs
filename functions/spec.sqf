["a civilian",
    {
        private _group = createGroup [civilian, true];
        _group setCombatMode "GREEN";
        private _pos = getPos player;
        private _civ = _group createUnit ["C_Man_1", _pos, [], 0, "NONE"];
        _civ setPos (getPos player);
        [_civ]
    },
    [
        ["who is tasked to patrol",
            {
                params [["_civ", objNull]];
                [_civ,  getPos _civ, 250, 3] call GRAD_CIVS_fnc_taskPatrol;
                [_civ]
            },
            [
                ["gets all waypoints",
                    {
                        params [["_civ", objNull]];
                        private _grp = (group _civ);
                        private _wps = waypoints _grp;
                        [count _wps, 3] call grad_testing_fnc_assertGreaterThan;
                    }
                ]
            ]

        ]
    ],
    {
        params [["_civ", objNull]];
        deleteVehicle _civ;
    }
] call grad_testing_fnc_executeTest;
