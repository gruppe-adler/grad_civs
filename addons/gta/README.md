# GTA module

## Description

Serves to create events around civilian-owned vehicles getting stolen by players

## Features

* GIVEN a vehicle belonging to a civilian 
    * AND it is not registered as stolen
        * AND it is empty
            * WHEN a player gets in as driver
                * AND LATER a civilian within 200m has clear sight of the place the vehicle was at when the player got in
                    * THEN ONCE a global event will be triggered: `"grad_civs_vehicleTheft", [_vehicle, objNull]`
                    * AND LATER a civilian within 200m has clear line of sight of the vehicle
                        * THEN ONCE a global event will be triggered: `"grad_civs_vehicleTheft", [_vehicle, player]`
                * AND LATER a civilian within 200m has clear line of sight of the vehicle
                    * THEN ONCE a global event will be triggered: `"grad_civs_vehicleTheft", [_vehicle, player]`
                    * AND LATER a civilian within 200m has clear sight of the place the vehicle was at when the player got in
                        * THEN no more events will have been triggered
                * AND LATER the player gets out again
                    * AND LATER a civilian has clear line of sight of the vehicle
                        * THEN LATER no event will have been triggered
                    * AND LATER a civilian has clear line of sight of the player
                        * THEN LATER no event will have been triggered
        * AND it is occupied with a civilian driver
            * WHEN a player gets in a cargo slot
                * THEN LATER no event will have been triggered
                * AND the player switches seats with the driver
                    * THEN ONCE a global event will be triggered: `"grad_civs_vehicleTheft", [_vehicle, player]`
