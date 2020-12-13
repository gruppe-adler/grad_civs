#include "..\script_component.hpp"

// generate some kind of weak UID

toString(("1234567890" splitString "") apply {
    private _n = (floor random  16);
    if (_n < 10) then {
        _n + 48 /*48 is offset for "0"-"9"*/
    } else {
        _n + 87 /*97 is offset for "a"-"f"*/
    }
})
