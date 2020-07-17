[
    "GIVEN parseCsv func",
    {
        grad_civs_common_fnc_parseCsv
    },
    [
        ["WHEN I pass an empty string",
            { "" call _this },
            [["THEN it will return empty array", { [_this, []] call grad_testing_fnc_assertEquals; }]]
        ],
        ["WHEN I pass brackets",
            { "[]" call _this },
            [["THEN it will return empty array", { [_this, []] call grad_testing_fnc_assertEquals; }]]
        ],
        ["WHEN I pass a stringified mixed array",
            { "[""hello"",false,""where,are,you"",4]" call _this },
            [["THEN it will return the parsed array", { [_this, ["hello", false, "where,are,you",4]] call grad_testing_fnc_assertEquals; }]]
        ],
        ["WHEN I pass a stringified string array",
            { "[""hello"",""where,are,you""]" call _this },
            [["THEN it will return the parsed array", { [_this, ["hello", "where,are,you"]] call grad_testing_fnc_assertEquals; }]]
        ],
        ["WHEN I pass a comma separated quoted list with commas in the values",
            { """hello"",""where,are,you""" call _this },
            [["THEN it will return the parsed list", { [_this, ["hello", "where,are,you"]] call grad_testing_fnc_assertEquals; }]]
        ],
        ["WHEN I pass a mixed comma separated unquoted list",
            { "hello,false,where,are,you,6" call _this },
            [["THEN it will return the list, every value a string", { [_this, ["hello", "false", "where","are","you","6"]] call grad_testing_fnc_assertEquals; }]]
        ],
        ["WHEN I pass a numeric comma separated unquoted list",
            { "1,3,3,7" call _this },
            [["THEN it will return the list, every value a number", { [_this, [1,3,3,7]] call grad_testing_fnc_assertEquals; }]]
        ]
    ]
] call grad_testing_fnc_executeTest;
