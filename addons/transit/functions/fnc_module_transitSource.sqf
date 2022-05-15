#include "..\script_component.hpp"

private _mode = param [0,"",[""]];
private _input = param [1,[],[[]]];

scopeName "main";

switch _mode do {
    // Default object init
    case "init": {
        if (!isServer) exitWith {};

        private _logic = _input param [0,objNull,[objNull]]; // Module logic

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
};
true
