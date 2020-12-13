#include "..\script_component.hpp"

private _stoppeds = (_objects call FUNC(selectGradCivs)) select {
    _x call EFUNC(activities,isStopped)
};

count _stoppeds > 0
