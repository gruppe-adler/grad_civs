/*

b  < a => -1
b  > a =>  1
b == a =>  0
*/

params ["_a", "_b"];

private _strB = str _b;
private _both = [str _a, _strB];

_both sort true;
if ((_both select 0) == _strB) exitWith {-1};

_both sort false;
if ((_both select 0) == _strB) exitWith {1};

0
