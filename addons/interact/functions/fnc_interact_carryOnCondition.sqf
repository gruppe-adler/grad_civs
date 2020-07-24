#include "..\script_component.hpp"

alive _target &&
    (_target getVariable ["grad_civs_primaryTask", ""] != "") &&
    (_target getVariable [QEGVAR(legacy,customActivity_id), ""] != "") // TODO isStopped maybe? hmm
