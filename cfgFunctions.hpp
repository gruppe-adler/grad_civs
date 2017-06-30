#ifndef MODULES_DIRECTORY
    #define MODULES_DIRECTORY modules
#endif

class grad_civs {

	class behaviour {
        file = MODULES_DIRECTORY\grad-civs\functions\behaviour;

        class flee {};
        class stopCiv {};
		class taskPatrol {};
    };

    class common {
        file = MODULES_DIRECTORY\grad-civs\functions\common;

        class findPositionOfInterest {};
        class findRandomPos {};
        class setBackpacks {};
        class setClothes {};
        class setDebugMode {};
        class setFaces {};
        class setGoggles {};
        class setHeadgear {};
    };

	class debug {
		file = MODULES_DIRECTORY\grad-civs\functions\debug;

        class createDebugMarker {};
        class showWhatTheyThink {};
    };

    class init {
        file = MODULES_DIRECTORY\grad-civs\functions\init;

        class initModule {preInit = 1;};
    };

    class player {
        file = MODULES_DIRECTORY\grad-civs\functions\player;

        class addPointerTick {};
        class checkWeaponOnCivilianPointer {};
        class playerLoop {};
        class removePointerTick {};
    };

    class spawn {
        file = MODULES_DIRECTORY\grad-civs\functions\spawn;

        class addNewCivilian {};
		class dressAndBehave {};
        class findSpawnSegment {};
        class getPlayerPositions {};
        class serverLoop {};
    };
};
