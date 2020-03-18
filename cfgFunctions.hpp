#ifndef MODULES_DIRECTORY
    #define MODULES_DIRECTORY modules
#endif

class grad_civs {

    class accessors {
        file = MODULES_DIRECTORY\grad-civs\functions\accessors;

        class clearCurrentlyThinking {};
        class forceBusinessSpeed {};
        class forcePanicSpeed {};
        class getCurrentlyThinking {};
        class getGroupVehicle {};
        class setCurrentlyThinking {};
        class setGroupVehicle {};
    };

    class api {
        file = MODULES_DIRECTORY\grad-civs\functions\api;

        class addExclusionZone {};
        class clearExclusionZones {};
        class getExclusionZones {};
        class addPopulationZone {};
        class clearPopulationZones {};
        class getPopulationZones {};
        class populateArea {};
        class setBackpacks {};
        class setClothes {};
        class setDebugMode {};
        class setFaces {};
        class setGoggles {};
        class setHeadgear {};
        class setVehicles {};
    };

	class behaviour {
        file = MODULES_DIRECTORY\grad-civs\functions\behaviour;

        class addCycleWaypoint {};
		class taskPatrol {};
        class taskPatrolAddWaypoint {};
        class taskPatrolFindWaypoints {};
        class taskPatrolFindWaypoint {};
    };

    class common {
        file = MODULES_DIRECTORY\grad-civs\functions\common;

        class arrayContains {};
        class compare {};
        class findBuildings {};
        class findPositionOfInterest {};
        class findRandomPos {};
        class findRandomPosArea {};
        class formatNowPlusSeconds {};
        class getCurrentState {};
        class getGlobalCivs {};
        class isInHouse {};
        class nowPlusSeconds {};
        class isInPopulatedZone {};
        class removeFromStateMachine {};
    };

	class debug {
		file = MODULES_DIRECTORY\grad-civs\functions\debug;

        class drawCivs {};
        class mapMarkers {};
        class showWhatTheyThink {};
        class updateInfoLine {};
    };

    class init {
        file = MODULES_DIRECTORY\grad-civs\functions\init;

        class initConfig {preInit = 1;};
        class initHCs {postInit = 1;};
        class initModule {};
        class initPlayer {postInit = 1;};
        class initServer {postInit = 1;};
    };

    class player {
        file = MODULES_DIRECTORY\grad-civs\functions\player;

        class checkHonkingOnCivilian {};
        class checkWeaponOnCivilianPerception {};
        class checkWeaponOnCivilianPointer {};
        class isPlayerHonking {};
        class playerLoop {};
        class registerAceInteractionHandler {};
        class showCivHint {};
    };

    class sm_activities {
        file = MODULES_DIRECTORY\grad-civs\functions\sm_activities;

        class sm_activities {};
        class sm_activities_helper_freeCondition {};
        class sm_activities_helper_surrenderCondition {};
        class sm_activities_state_asOrdered_enter {};
        class sm_activities_state_asOrdered_exit {};
        class sm_activities_state_panic_enter {};
        class sm_activities_state_panic_exit {};
        class sm_activities_state_surrendered_enter {};
        class sm_activities_state_surrendered_exit {};
        class sm_activities_trans_business_panic_condition {};
        class sm_activities_trans_business_surrendered_condition {};
        // class sm_activities_trans_panic_business_condition {}; // event transition
        class sm_activities_trans_surrendered_business_condition {};
        class sm_activities_trans_surrendered_panic_condition {};
    };

    class sm_business {
        file = MODULES_DIRECTORY\grad-civs\functions\sm_business;

        class sm_business {};
        class sm_business_state_dismount_enter {};
        class sm_business_state_mountUp_enter {};

        class sm_business_state_chat_enter {};
        class sm_business_state_chat_exit {};
        class sm_business_state_chat_loop {};
        class sm_business_state_housework_enter {};
        class sm_business_state_housework_exit {};
        class sm_business_state_meetNeighbor_enter {};
        class sm_business_state_meetNeighbor_exit {};
        class sm_business_state_meetNeighbor_loop {};

        class sm_business_state_mountUp_exit {};
        class sm_business_state_patrol_enter {};
        class sm_business_state_patrol_exit {};
        class sm_business_state_rally_enter {};
        class sm_business_state_rally_loop {};
        class sm_business_state_voyage_enter {};
        class sm_business_state_voyage_exit {};
        class sm_business_state_voyage_loop {};
        class sm_business_trans_chat_housework_condition {};
        class sm_business_trans_dismount_rally_condition {};
        class sm_business_trans_housework_housework_condition {};
        class sm_business_trans_housework_meetNeighbor_condition {};
        class sm_business_trans_meetNeighbor_chat_condition {};
        class sm_business_trans_mountUp_voyage_condition {};
        class sm_business_trans_mountUp_dismount_condition {};
        class sm_business_trans_rally_housework_condition {};
        class sm_business_trans_rally_mountUp_condition {};
        class sm_business_trans_rally_patrol_condition {};
        class sm_business_trans_voyage_dismount_condition {};
    };

    class sm_lifecycle {
        file = MODULES_DIRECTORY\grad-civs\functions\sm_lifecycle;

        class sm_lifecycle {};
        class sm_lifecycle_state_death_enter {};
        class sm_lifecycle_state_despawn_enter {};
        class sm_lifecycle_state_life_enter {};
        class sm_lifecycle_state_life_exit {};
        class sm_lifecycle_trans_life_despawn_condition {};
        class sm_lifecycle_state_spawn_enter {};
    };

    class sm_emotions {
        file = MODULES_DIRECTORY\grad-civs\functions\sm_emotions;

        class sm_emotions {};
    };

    class sm_panic {
        file = MODULES_DIRECTORY\grad-civs\functions\sm_panic;

        class sm_panic {};
        class sm_panic_state_flight_loop {};
        class sm_panic_state_flight_enter {};
        class sm_panic_state_hidden_enter {};
        class sm_panic_state_hide_enter {};
        class sm_panic_state_hide_exit {};
        class sm_panic_trans_hide_hidden_condition {};
        class sm_panic_trans_hide_hidden_handler {};
    };

    class spawn {
        file = MODULES_DIRECTORY\grad-civs\functions\spawn;

        class addCarCrew {};
        class addFootsy {};
        class addResident {};
        class createInfoChannel {};
        class createSideRoadVehicles {};
        class deleteIfDamaged {};
        class findUnclaimedHouse {};
        class findSpawnPosition {};
        class findSpawnRoadSegment {};
        class isInDistanceFromOtherPlayers {};
        class serverLoop {};
        class spawnCivilian {};
        class spawnCivilianGroup {};
        class spawnPass {};
        class spawnVehicle {};
    };

    class statemachine {
        file = MODULES_DIRECTORY\grad-civs\functions\statemachine;

        class addCompoundState {};
        class addState {};
        class addToStateMachine {};
        class addTransition {};
    };
};
