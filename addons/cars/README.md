# grad\_civs\_cars

Basic handling of civs driving cars. 

As a user, see transit and voyage modules to actually get civs driving on the streets.

## Config settings

Attribute                | Default Value | Explanation
-------------------------|---------------|------------------------------------------------------------------------------------------------------------------------------------------------
animalTransportChance    | 0.4           | Probability that a suitable vehicle will carry some animals as cargo.
automaticVehicleGroupSize| 1             | Allow vehicles to be filled according to capacity, ignoring *initialGroupSize* (0,1).
vehicles                 | ["C_Van_01_fuel_F", "C_Hatchback_01_F", "C_Offroad_02_unarmed_F", "C_Truck_02_fuel_F", "C_Truck_02_covered_F", "C_Offroad_01_F", "C_SUV_01_F", "C_Van_01_transport_F", "C_Van_01_box_F"]            | All classnames of vehicles that civilians may drive.

## API

### grad_civs_cars_fnc_setVehicles

Sets all vehicles that civilians may drive. Overwrites value from CBA settings. Execute globally

#### Example

```sqf
private _vehicles = ["C_Van_01_Fuel_F"];
[_vehicles] call grad_civs_cars_fnc_setVehicles
```

Parameter | Explanation
----------|-------------------------------------------------------------
vehicles  | Array - All classnames of vehicles that civilians may drive.
