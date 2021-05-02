params [
	["_arr", [], [[]]], 
	["_callback", {false}, [{}]] // function that receives array value, array index and returns boolean
];

{
	if ([_x, _forEachIndex] call _callback) exitWith {true};
	false
} forEach _arr;
