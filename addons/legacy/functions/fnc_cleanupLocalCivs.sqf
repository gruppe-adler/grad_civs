#include "..\script_component.hpp"
// clean up objNull references in civs array - that happens for example when a zeus person deletes them
{
    GVAR(localCivs) = GVAR(localCivs) select {
        // NOTE: do not handle `alive` here, we've got a transition & state for proper disposal of dead civilians
        if (isNull _x) then {
            INFO_1("abandoning civilian %1 they have become NULL (deleted?)", _x);
            false
        } else {
            if (local _x) then {
                true
            } else {
                WARNING_1("abandoning civilian %1 as they are not local any more", _x);
                false
            };
        };
    };
}
