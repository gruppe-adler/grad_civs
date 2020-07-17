#include "..\script_component.hpp"

private _mode = param [0,"",[""]];
private _input = param [1,[],[[]]];

scopeName "main";

switch _mode do {
	// Default object init
	case "init": {
		if (!isServer) exitWith {};

		private _logic = _input param [0,objNull,[objNull]]; // Module logic
		private _isActivated = _input param [1,true,[true]]; // True when the module was activated, false when it's deactivated
		private _isCuratorPlaced = _input param [2,false,[true]]; // True if the module was placed by Zeus

        private _sinks = (synchronizedObjects _logic) select {
            _x isKindOf QGVAR(transitSink)
        };

		private _vics = [_logic getVariable ["Vehicles", ""]] call EFUNC(common,parseCsv);

		[
			getPos _logic,
			getDir _logic,
			_sinks apply {getPos _x},
			_logic getVariable "Interval",
			_vics
		] call FUNC(addTransitRoute);
	};
	// When some attributes were changed (including position and rotation)
	case "attributesChanged3DEN": {
		private _logic = _input param [0,objNull,[objNull]];
		// ... code here...
	};
	// When added to the world (e.g., after undoing and redoing creation)
	case "registeredToWorld3DEN": {
		private _logic = _input param [0,objNull,[objNull]];
		// ... code here...
	};
	// When removed from the world (i.e., by deletion or undoing creation)
	case "unregisteredFromWorld3DEN": {
		private _logic = _input param [0,objNull,[objNull]];
		// ... code here...
	};
	// When connection to object changes (i.e., new one is added or existing one removed)
	case "connectionChanged3DEN": {
		private _logic = _input param [0,objNull,[objNull]];
		// ... code here...
	};
	// When object is being dragged
	case "dragged3DEN": {
		private _logic = _input param [0,objNull,[objNull]];
		// ...code here...
	};
};
true
