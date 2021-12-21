params [
	["_civ", objNull, [objNull]]
];

_this call FUNC(arrowDelete);

private _arrow = createSimpleObject ["Sign_Arrow_Large_Pink_F", [0, 0, 0]];
_arrow attachTo [_civ, [0, 0, 5]];
