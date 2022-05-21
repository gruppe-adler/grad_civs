#include "..\script_component.hpp"

INFO_1("popzone logic is called with: %1", _this);

private _mode = param [0,"",[""]];
private _input = param [1,[],[[]]];

switch _mode do {
    // Default object init
    case "init": {
        private _logic = _input param [0,objNull,[objNull]]; // Module logic


        private _synchronizedObjects = synchronizedObjects _logic;

        ([_logic] call FUNC(consumeSynchronizedClasses)) params ["_moduleCivClasses", "_moduleCarClasses"];

        _synchronizedObjects select {
            _x isKindOf "EmptyDetector"
        } apply {
            ([_x] call FUNC(consumeSynchronizedClasses)) params ["_areaCivClasses", "_areaCarClasses"];
            [_x, _moduleCivClasses + _areaCivClasses, _moduleCarClasses + _areaCarClasses] call FUNC(addPopulationZone);
        };
    };
};
true
