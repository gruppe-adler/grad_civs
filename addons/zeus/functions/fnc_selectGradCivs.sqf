#include "..\script_component.hpp"

_this select {
    (_x isKindOf "Man") && {_x getVariable ["grad_civs_primaryTask", ""] != ""}
}
