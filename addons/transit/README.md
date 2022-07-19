# grad\_civs\_transit

Add fixed transit routes along which cvilians travel the whole width of the map

## configuration notes

vehicle classes being used are with falling priority:
* vehicles synced to the Transit Source module
* in the "transitSource" `vehicles` module variables in 3DEN
* in the CBA settings for GRAD Civilians/transit
* in the CBA settings for GRAD Civilians/cars

## 3DEN Modules

### Transit Source

Define positions where civilian vehicles will spawn and start their routes.

#### Usage

* place Transit Source module
* _optional:_ place civilians and/or civilian vehicles to define the types (classes) of civilians that are allowed to spawn in the respective population zone, and sync them to the Transit Source module
* sync to one or more Transit Sink modules

### Transit Sink

Define positions where civilian vehicles will end their routes and despawn.
Can be synced to one or more Transit Source modules.
