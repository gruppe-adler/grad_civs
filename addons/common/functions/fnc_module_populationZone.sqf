#include "..\script_component.hpp"

INFO_1("plogic is called with: %1", _this);

private _mode = param [0,"",[""]];
private _input = param [1,[],[[]]];

scopeName "main";

switch _mode do {
	// Default object init
	case "init": {
		private _logic = _input param [0,objNull,[objNull]]; // Module logic

		(synchronizedObjects _logic) select {
			_x isKindOf "EmptyDetector"
		} apply {
			[_x] call FUNC(addPopulationZone);
		};
	};
};
true
