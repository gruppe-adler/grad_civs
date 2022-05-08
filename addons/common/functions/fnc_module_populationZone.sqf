#include "..\script_component.hpp"

INFO_1("plogic is called with: %1", _this);

private _mode = param [0,"",[""]];
private _input = param [1,[],[[]]];

scopeName "main";

private _getClasses = {
		private _civs = _this select { _x isKindOf "Man" };
		private _civClasses = _civs apply { typeOf _x };

		private _cars = _this select { _x isKindOf "Car" };
		private _carClasses = _cars apply { typeOf _x };

		{ deleteVehicle _x } forEach (_civs + _cars);

		[_civClasses, _carClasses]
};

switch _mode do {
	// Default object init
	case "init": {
		private _logic = _input param [0,objNull,[objNull]]; // Module logic


		private _synchronizedObjects = synchronizedObjects _logic;

		(_synchronizedObjects call _getClasses) params ["_moduleCivClasses", "_moduleCarClasses"];

		_synchronizedObjects select {
			_x isKindOf "EmptyDetector"
		} apply {
			((synchronizedObjects _x) call _getClasses) params ["_areaCivClasses", "_areaCarClasses"];
			[_x, _moduleCivClasses + _areaCivClasses, _moduleCarClasses + _areaCarClasses] call FUNC(addPopulationZone);
		};
	};
};
true
