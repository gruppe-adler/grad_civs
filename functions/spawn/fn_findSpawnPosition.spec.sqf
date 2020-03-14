["given a bunch of players",
    {
        private _allPlayers = [];
        private _offset = [0, 0, 0]; // TODO

        {
            private _group = createGroup civilian;
            private _unit = _group createUnit ["C_Man_1", (_x vectorAdd _offset), [], 0, "CAN_COLLIDE"];
            _allPlayers pushBack _unit;
        } forEach [
            [-50, 0, 0],
            [0, 0, 0],
            [50, 0, 0]
        ];

        [_allPlayers]
    },
    [
        ["no exclusion zones, and houses in various distances",
            {
                params [["_allPlayers", []]];
                private _houses =  [
                    [  0, -65,0], // good house
                    [-50,-100,0], // too far from everyone
                    [-40,   0,0] // too close to left player
                ] apply {
                    "Land_Lighthouse_small_F" createVehicle _x;
                };
                diag_log (_houses#0 buildingPos -1);

                GRAD_CIVS_EXCLUSION_ZONES = [];
                sleep 1;
                [_allPlayers, _houses]
            },
            [
                ["when i look for a resident spawn house",
                    {
                        params [
                            ["_allPlayers", []]
                        ];
                        private _house = objNull;
                        for "_i" from 0 to 10 do
                        {
                            _house = [_allPlayers, 50, 100, "house"] call grad_civs_fnc_findSpawnPosition;
                            if (!(isNull _house)) exitWith {};
                        };

                        [_allPlayers, _house]
                    },
                    [
                        ["a house is found not too far away from them",
                            {
                                params [["_allPlayers", []], ["_house", objNull]];
                                [_house] call grad_testing_fnc_assertNotNull;
                                {
                                    [_house distance _x, 101] call grad_testing_fnc_assertLessThan;
                                } forEach _allPlayers;
                            }
                        ],
                        ["a house is found not too close to them",
                            {
                                params [["_allPlayers", []], ["_house", objNull]];
                                [_house] call grad_testing_fnc_assertNotNull;
                                {
                                    [_house distance _x, 49] call grad_testing_fnc_assertGreaterThan;
                                } forEach _allPlayers;
                            }
                        ]
                    ]
                ]
            ],
            {
                params ["_allPlayers", "_houses"];
                {
                    deleteVehicle _x;
                } forEach _houses;
            }
        ]
    ],
    {
        params [["_allPlayers", []]];
        {
            deleteVehicle _x;
        } forEach _allPlayers;
    }
] call grad_testing_fnc_executeTest;
