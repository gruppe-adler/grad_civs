class CfgVehicles
{
    class Logic;
    class Module_F: Logic {
        class AttributesBase {
            class Default;
            class ModuleDescription;
            class Units;
            class Combo;
            class Edit;
        };
        class ModuleDescription {};
    };
    class GVAR(transitSource): Module_F
    {
        scope = 2; // visible in editor
        displayName = "Transit Traffic Source";
        icon = QPATHTOF(ui\icon_module_transit_source_ca.paa);
        category = QEGVAR(main,modules);
        function = QFUNC(module_transitSource);
        functionPriority = 0; // first to execute
        isGlobal = 1;
        isTriggerActivated = 0;
        isDisposable = 1; // doesnt get activated repeatably
        is3DEN = 1;

        class Attributes: AttributesBase
        {
            class Interval: Combo
            {
                property = QGVAR(transitSource_interval);
                displayName = "Spawn interval";
                tooltip = "How often (on average) should vehicles spawn";
                typeName = "NUMBER";
                defaultValue = "60";
                class Values
                {
                    class 5s	{name = "5s";	value = 5;};
                    class 15s	{name = "15s"; value = 15;};
                    class 30s	{name = "30s"; value = 30;};
                    class 60s	{name = "1m"; value = 60;};
                    class 120s	{name = "2m"; value = 120;};
                    class 240s	{name = "4m"; value = 240;};
                    class 600s	{name = "10m"; value = 600;};
                    class 1200s	{name = "20m"; value = 1200;};
                };
            };
            class Vehicles: Edit
            {
                property = QGVAR(transitSource_vehicles);
                displayName = "Special vehicle classes";
                tooltip = "Separate vehicle classes if so desired";
                defaultValue = "[]";
            };
        };

        class ModuleDescription: ModuleDescription
        {
            description = "GRAD Civs : add location where transit traffic spawns";
            sync[] = {QGVAR(transitSink)};
        };
    };
    class GVAR(transitSink): Module_F
    {
        scope = 2; // visible in editor
        displayName = "Transit Traffic Sink";
        icon = QPATHTOF(ui\icon_module_transit_sink_ca.paa);
        category = QEGVAR(main,modules);
        function = QFUNC(module_transitSink);
        functionPriority = 0; // first to execute
        isGlobal = 1;
        isTriggerActivated = 0;
        isDisposable = 1; // doesnt get activated repeatably
        is3DEN = 1;

        class ModuleDescription: ModuleDescription
        {
            description = "GRAD Civs : add location where transit traffic goes to and despawns";
        };
    };
};
