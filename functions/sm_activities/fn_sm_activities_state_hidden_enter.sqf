private _animationHiding = ["Acts_CivilHiding_1", "Acts_CivilHiding_2"];
_this playMoveNow (selectRandom _animationHiding);
_this enableDynamicSimulation true; // TODO clarify why we need enableDynamicSimulation for… anything, really. we do have a despawn loop, after all?
