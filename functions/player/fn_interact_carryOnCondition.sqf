#include "..\..\component.hpp"

alive _target &&
    (_target getVariable ["grad_civs_primaryTask", ""] != "") &&
    (_target getVariable [QGVAR(customActivity_id), ""] != "")
