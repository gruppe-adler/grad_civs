#include "..\script_component.hpp"

INFO_1("plogic is called with: %1", _this);

private _mode = param [0,"",[""]];
private _input = param [1,[],[[]]];

scopeName "main";

switch _mode do {
	// Default object init
	case "init": {
		private _logic = _input param [0,objNull,[objNull]]; // Module logic


		private _synchronizedObjects = synchronizedObjects _logic;

		private _civs = _synchronizedObjects select { _x isKindOf "Man" };
		private _civClasses = _civs apply { typeOf _x };

		private _cars = _synchronizedObjects select { _x isKindOf "Car" };
		private _carClasses = _cars apply { typeOf _x };

		_synchronizedObjects select {
			_x isKindOf "EmptyDetector"
		} apply {
			[_x, _civClasses, _carClasses] call FUNC(addPopulationZone);
		};

		{ deleteVehicle _x } forEach (_civs + _cars);
	};
};
true
