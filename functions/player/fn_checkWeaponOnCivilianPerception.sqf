params [
    ["_pointer", objNull],
    ["_pointee", objNull]
];

private _dist = _pointer distance _pointee;

/*

assumptions:

* direction you point in equals your unit direction
* to be perceiving you ("pointer") pointing at him, the person pointed at ("pointee")
  must look in roughly the opposite direction, plus a bit lateral perception
* lateral perception of being pointed at and threatened depends on your _relative_ speed! example:
    * if you're standing still, s/o pointing at you from beside you (90° angle) is definitely causing you to raise your hands
    * if you're driving at 150km/h, you dont even notice someone at a 60° angle, because you're focused on the road
*/

// angleDiff is the deviation of the actual directions from a "being opposite" stance
private _angleDiff = abs(abs((getDir _pointee) - (getDir _pointer)) - 180);

// speedDiff is the _relative_ speed.
// So if pointer and pointee are running into the same direction, it will be close to 0,
// while moving in opposite directions will double the value
private _speedDiff = (velocity _pointer) vectorDistance (velocity _pointee);

// for simplicity's sake, assume linear relation between angular perception and speed
// NOTE: speedDiff value is in m/s !
private _perceptionAngleDiff = linearConversion [0, 50, _speedDiff, 90, 15, true];

// as with the angular perception, linear conversion is a bit too simple here, but better than nothing
private _minPerceptionDistance = linearConversion [5, 50, _speedDiff, 0, 50, true]; /* = if speed diff is larger than 5m/s, the min perception distance increases from 0m to 50m at a speed of 50m/s*/
private _maxPerceptionDistance = linearConversion [5, 50, _speedDiff, 50, 300, true];

if (_angleDiff > _perceptionAngleDiff) exitWith {false};

if (_dist > _maxPerceptionDistance) exitWith {false};

if (_dist < _minPerceptionDistance) exitWith {false};

true
