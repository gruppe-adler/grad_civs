// made for VR

["GIVEN two units A (on foot) and B",
    [
        {
            private _group = createGroup [civilian, true];
            _group setCombatMode "GREEN";
            private _pos = [0, 0, 0];
            private _a = _group createUnit ["C_Man_1", _pos, [], 0, "NONE"];
            private _b = _group createUnit ["C_Man_1", _pos, [], 0, "NONE"];
            [_a, _b]
        }
    ],
    [
        ["WHEN A aims at B",
            {
                params ["_a", "_b"];
                _b setPos [0, 100, 0];
                [_a, _b, [0, 1, 0]]
            },
            [
                ["THEN getAimPrecision is 1",
                    {
                        params ["_a", "_b", "_vectorDir"];
                        sleep 1;
                        [_this call grad_civs_interact_fnc_getAimPrecision, 1]  call grad_testing_fnc_assertEquals;
                    }
                ]
            ]
        ],
        ["WHEN A aims away from B",
            {
                params ["_a", "_b"];
                _b setPos [0, 100, 0];
                [_a, _b, [0, -1, 0]]
            },
            [
                ["THEN getAimPrecision is 0",
                    {
                        params ["_a", "_b", "_vectorDir"];
                        [_this call grad_civs_interact_fnc_getAimPrecision, 0]  call grad_testing_fnc_assertEquals;
                    }
                ]
            ]
        ],
        ["WHEN A aims straight up",
            {
                params ["_a", "_b"];
                _b setPos [0, 100, 0];
                [_a, _b, [0, 0, 1]]
            },
            [
                ["THEN getAimPrecision is 0.5",
                    {
                        params ["_a", "_b"];
                        [_this call grad_civs_interact_fnc_getAimPrecision, 0.5]  call grad_testing_fnc_assertEquals;
                    }
                ]
            ]
        ]
    ],
    {
        params ["_a", "_b"];
        deleteVehicle _a;
        deleteVehicle _b;
    }
] call grad_testing_fnc_executeTest;
