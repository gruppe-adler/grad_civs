params ["_path", "_color"];

{ 
            private _mrk = createMarker [format ["bmarker_%1_%2"], _path, _forEachIndex];
            _mrk setMarkerType "mil_dot";
            _mrk setMarkerColor _color;
            _mrk setMarkerText str _forEachIndex; 
} forEach _path;