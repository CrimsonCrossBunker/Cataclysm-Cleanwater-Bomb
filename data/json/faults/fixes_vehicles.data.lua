local ccb = require("ccb")

ccb.content.define_fault_fix {
    id = "mend_fault_engine_belt_drive_replace",
    name = ccb.content.text("Replace worn drive belt"),
    success_message = ccb.content.text("You replace the worn drive belt of the %s."),
    duration = "5 m",
    removes = { "fault_engine_belt_drive" },
    skills = { mechanics = 2 },
    requirements = {
        {
            qualities = { { id = "WRENCH", level = 1 } },
            components = { { { "drivebelt", 1 }, { "drivebelt_makeshift", 1 } } },
        },
    },
}

ccb.content.define_fault_fix {
    id = "mend_fault_engine_glow_plug_replace",
    name = ccb.content.text("Replace faulty glow plugs"),
    success_message = ccb.content.text("You replace the faulty glow plugs of the %s."),
    duration = "40 m",
    removes = { "fault_engine_glow_plug" },
    skills = { mechanics = 4 },
    requirements = {
        { qualities = { { id = "WRENCH_FINE", level = 1 } }, components = { { { "glowplug", 1 } } } },
    },
}

ccb.content.define_fault_fix {
    id = "mend_fault_engine_immobiliser_deactivate",
    name = ccb.content.text("Deactivate immobilizer"),
    success_message = ccb.content.text("You successfully deactivate the immobilizer of the %s."),
    duration = "5 m",
    removes = { "fault_engine_immobiliser" },
    skills = { mechanics = 2, electronics = 5 },
    requirements = { { qualities = { { id = "SCREW_FINE", level = 1 } } } },
}

ccb.content.define_fault_fix {
    id = "mend_fault_engine_pump_diesel_replace",
    name = ccb.content.text("Replace faulty diesel pump"),
    success_message = ccb.content.text("You replace the faulty diesel pump of the %s."),
    duration = "40 m",
    removes = { "fault_engine_pump_diesel" },
    skills = { mechanics = 4 },
    requirements = {
        { qualities = { { id = "WRENCH_FINE", level = 1 } }, components = { { { "pump_complex", 1 } } } },
    },
}

ccb.content.define_fault_fix {
    id = "mend_fault_engine_filter_air_replace",
    name = ccb.content.text("Replace expired air filter"),
    success_message = ccb.content.text("You replace the expired air filter of the %s."),
    duration = "5 m",
    removes = { "fault_engine_filter_air" },
    skills = { mechanics = 1 },
    requirements = {
        {
            qualities = { { id = "SCREW", level = 1 } },
            components = { { { "filter_air", 1 }, { "filter_air_makeshift", 1 } } },
        },
    },
}

ccb.content.define_fault_fix {
    id = "mend_fault_engine_filter_fuel_replace",
    name = ccb.content.text("Replace expired fuel filter"),
    success_message = ccb.content.text("You replace the expired fuel filter of the %s."),
    duration = "5 m",
    removes = { "fault_engine_filter_fuel" },
    skills = { mechanics = 1 },
    requirements = {
        {
            qualities = { { id = "SCREW", level = 1 } },
            components = { { { "filter_liquid", 1 }, { "filter_liquid_makeshift", 1 } } },
        },
    },
}

ccb.content.define_fault_fix {
    id = "mend_fault_engine_pump_fuel_replace",
    name = ccb.content.text("Replace faulty fuel pump"),
    success_message = ccb.content.text("You replace the faulty fuel pump of the %s."),
    duration = "40 m",
    removes = { "fault_engine_pump_fuel" },
    skills = { mechanics = 4 },
    requirements = {
        { qualities = { { id = "WRENCH_FINE", level = 1 } }, components = { { { "well_pump", 1 } } } },
    },
}

ccb.content.define_fault_fix {
    id = "mend_fault_engine_starter_replace",
    name = ccb.content.text("Replace faulty starter motor"),
    success_message = ccb.content.text("You replace the faulty starter motor of %s."),
    duration = "10 m",
    removes = { "fault_engine_starter" },
    skills = { mechanics = 3 },
    requirements = {
        { qualities = { { id = "WRENCH_FINE", level = 1 } }, components = { { { "motor_tiny", 1 } } } },
    },
}

-- implement something similar to calc_lift_requirements()?
ccb.content.define_fault_fix {
    id = "mend_fault_punctured_tires_kit",
    name = ccb.content.text("Plug the hole in tire"),
    success_message = ccb.content.text("You take the wheel off, localize the puncture using soapy water, and plug it with plug and glue mix from repair kit."),
    duration = "90 m",
    removes = { "fault_punctured_tires" },
    mod_degradation = 1500,
    skills = { mechanics = 1 },
    requirements = {
        {
            qualities = {
                { id = "JACK", level = 3 },
                { id = "WRENCH", level = 2 },
                { id = "PRESSURIZATION", level = 1 },
            },
            components = { { { "tire_repair_kit", 1 } } },
        },
    },
}
