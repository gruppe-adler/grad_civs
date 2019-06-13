params ["_path", "_color"];

{   
            private _name = format [format ["marker_path_%1_%2"], _x, _forEachIndex];
            private _mrk = createMarker [_name, _x];
            _mrk setMarkerType "mil_dot";
            _mrk setMarkerColor _color;
            _mrk setMarkerText str _forEachIndex; 
} forEach _path;