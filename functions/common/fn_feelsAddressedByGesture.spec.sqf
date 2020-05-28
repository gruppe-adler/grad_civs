private _bAwareOfAGesturing = [
    "then B will feel addressed by A",
    {
        params ["_a", "_b"];
        [[_a, vectorDirVisual _a, _b] call grad_civs_fnc_feelsAddressedByGesture] call grad_testing_fnc_assertTrue;
    }
];

private _bUnawareOfAGesturing = [
    "then B will not feel addressed by A",
    {
        params ["_a", "_b"];
        [[_a, vectorDirVisual _a, _b] call grad_civs_fnc_feelsAddressedByGesture] call grad_testing_fnc_assertFalse;
    }
];



["given two units A and B",
    {
        private _group = createGroup [civilian, true];
        _group setCombatMode "GREEN";
        private _pos = [0, 0, 0];
        private _a = _group createUnit ["C_Man_1", _pos, [], 0, "NONE"];
        private _b = _group createUnit ["C_Man_1", _pos, [], 0, "NONE"];
        [_a, _b]
    },
    [
        ["who are close with B looking at A",
            {
                params ["_a", "_b"];
                _a setPos [0, 0];
                _b setPos [0, 30];
                _b setDir 180;
                [_a, _b]
            },
            [
                ["who turns directly at him",
                    {
                        params ["_a", "_b"];
                        _a setDir 0;
                        [_a, _b]
                    },
                    [
                        _bAwareOfAGesturing,
                        ["but an obstacle is in between",
                            {
                                params ["_a", "_b"];
                                private _x = createSimpleObject ["Land_VR_Shape_01_cube_1m_F", AGLToASL [0, 15, 1]];
                                [_a, _b, _x]
                            },
                            [_bUnawareOfAGesturing],
                            {
                                params ["", "", "_x"];
                                deleteVehicle _x;
                                sleep 1;
                            }
                        ]
                    ]
                ],
                ["who is turned at 10 deg from him",
                    {
                        params ["_a", "_b"];
                        _a setDir 10;
                        [_a, _b]
                    },
                    [_bAwareOfAGesturing]
                ],
                ["who is turned at 30 deg from him",
                    {
                        params ["_a", "_b"];
                        _a setDir 30;
                        [_a, _b]
                    },
                    [_bUnawareOfAGesturing]
                ],
                ["who is turned at 150 deg from him",
                    {
                        params ["_a", "_b"];
                        _a setDir 150;
                        [_a, _b]
                    },
                    [_bUnawareOfAGesturing]
                ],
                ["who is turned at 180 deg from him",
                    {
                        params ["_a", "_b"];
                        _a setDir 180;
                        [_a, _b]
                    },
                    [_bUnawareOfAGesturing]
                ]
            ]
        ],
        ["who are close with A looking at B",
            {
                params ["_a", "_b"];
                _a setPos [0, 0];
                _a setDir 0;
                _b setPos [0, 30];
                _b setDir 180;
                [_a, _b]
            },
            [
                ["who is turned at 10 deg from him",
                    {
                        params ["_a", "_b"];
                        _b setDir 190;
                        [_a, _b]
                    },
                    [_bAwareOfAGesturing]
                ],
                ["who is turned at 20 deg from him",
                    {
                        params ["_a", "_b"];
                        _b setDir 200;
                        [_a, _b]
                    },
                    [_bAwareOfAGesturing]
                ],
                ["who is turned at 60 deg from him",
                    {
                        params ["_a", "_b"];
                        _b setDir 120;
                        [_a, _b]
                    },
                    [_bAwareOfAGesturing]
                ],
                ["who is turned at 80 deg from him",
                    {
                        params ["_a", "_b"];
                        _b setDir 100;
                        [_a, _b]
                    },
                    [_bUnawareOfAGesturing]
                ],
                ["who is turned at 180 deg from him",
                    {
                        params ["_a", "_b"];
                        _b setDir 0;
                        [_a, _b]
                    },
                    [_bUnawareOfAGesturing]
                ]
            ]
        ],
        ["who are far with B looking at A",
            {
                params ["_a", "_b"];
                _a setPos [0, 0];
                _b setPos [0, 200];
                _b setDir 180;
                [_a, _b]
            },
            [
                ["who turns directly at him",
                    {
                        params ["_a", "_b"];
                        _a setDir 0;
                        [_a, _b]
                    },
                    [_bUnawareOfAGesturing]
                ]
            ]
        ]
    ],
    {
        params ["_a", "_b"];
        private _grp = group _a;
        deleteVehicle _a;
        deleteVehicle _b;
        deleteGroup _grp;
    }
] call grad_testing_fnc_executeTest;
