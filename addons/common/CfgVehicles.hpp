class CfgVehicles
{
	class Logic;
	class Module_F: Logic {
		class AttributesBase {
			class Default;
			class ModuleDescription;
			class Units;
		};
		class ModuleDescription {};
	};
	class GVAR(PopulationZone): Module_F
	{
		scope = 2; // visible in editor
		displayName = "Population Zone";
		icon = QPATHTOF(ui\icon_module_population_zone_ca.paa);
		category = QEGVAR(main,modules);
		function = QFUNC(module_populationZone);
		functionPriority = 0; // first to execute
		isGlobal = 1;
		isTriggerActivated = 0;
		isDisposable = 1; // doesnt get activated repeatably
		is3DEN = 1;

		// Module description. Must inherit from base class, otherwise pre-defined entities won't be available
		class ModuleDescription: ModuleDescription
		{
			description = "GRAD civs : add population zone where civilians may spawn and live."; // Short description, will be formatted as structured text
			sync[] = {}; // Array of synced entities (can contain base classes)
		};
	};
	class GVAR(ExclusionZone): Module_F
	{
		scope = 2; // visible in editor
		displayName = "Exclusion Zone";
		icon = QPATHTOF(ui\icon_module_exclusion_zone_ca.paa);
		category = QEGVAR(main,modules);
		function = QFUNC(module_exclusionZone);
		functionPriority = 0; // first to execute
		isGlobal = 1;
		isTriggerActivated = 0;
		isDisposable = 1; // doesnt get activated repeatably
		is3DEN = 1;

		// Module description. Must inherit from base class, otherwise pre-defined entities won't be available
		class ModuleDescription: ModuleDescription
		{
			description = "GRAD civs : add exclusion zone that civilians are prevented from entering"; // Short description, will be formatted as structured text
		};
	};
};
