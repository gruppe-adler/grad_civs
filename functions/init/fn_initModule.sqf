#include "..\..\component.hpp"

INFO("running full grad-civs initialization now!");

[] call grad_civs_fnc_initConfig;
[] call grad_civs_fnc_initServer;
[] call grad_civs_fnc_initHCs;
[] call grad_civs_fnc_initPlayer;
