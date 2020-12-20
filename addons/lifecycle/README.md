# grad\_civs\_lifecycle

Controls all spawning & despawning of civilians, as well as incapacitation & death.

## API

### Events 

**NOTE:** event names are prefixed with `grad_civs_lifecycle_`

#### `civ_added` , `civ_removed`

If civilians come under the control of grad-civs or are removed from grad-civs control, respectively.
Argument is an *array of* civilians (i.e. units)
