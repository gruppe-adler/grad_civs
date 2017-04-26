#ifndef MODULES_DIRECTORY
    #define MODULES_DIRECTORY modules
#endif

class GRAD_civs {

	class behaviour {
        file = MODULES_DIRECTORY\grad-civs\functions\behaviour;

        class findPositionOfInterest {};
        class fleeAndFake {};
        class fleeYouFool {};
        class stopCiv {};
		class taskPatrol {};
    };

	class debug {
		file = MODULES_DIRECTORY\grad-civs\functions\debug;

        class createDebugMarker {};
        class showWhatTheyThink {};
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
        class clothDefinitions {};
		class dressAndBehave {};
        class findSpawnSegment {};
        class getPlayerPositions {};
        class serverLoop {};
    };
};
