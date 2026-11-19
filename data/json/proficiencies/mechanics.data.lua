local ccb = require("ccb")

ccb.content.define_proficiency {
    id = "prof_basic_engines",
    category = "prof_mechanic",
    name = ccb.content.text("Simple Engines"),
    description = ccb.content.text("Maintaining and building simple engines."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.25,
    time_to_learn = "8 h",
}

ccb.content.define_proficiency {
    id = "prof_high_pressure_systems",
    category = "prof_mechanic",
    name = ccb.content.text("High Pressure Systems"),
    description = ccb.content.text("You know how to safely and efficiently build, repair, maintain and use various appliances that make use of high pressure."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.25,
    time_to_learn = "12 h",
    requires = { "prof_plumbing", "prof_basic_engines", "prof_appliance_repair", "prof_pneumatics" },
}

ccb.content.define_proficiency {
    id = "prof_chemical_engineering",
    category = "prof_mechanic",
    name = ccb.content.text("Chemical Engineering"),
    description = ccb.content.text("You know how to safely and efficiently build, repair, maintain and use various complex machinery that makes use of chemical processes."),
    can_learn = true,
    time_multiplier = 2.5,
    skill_penalty = 0.5,
    time_to_learn = "20 h",
    requires = { "prof_high_pressure_systems", "prof_chem_synth" },
}

ccb.content.define_proficiency {
    id = "prof_pneumatics",
    category = "prof_mechanic",
    name = ccb.content.text("Pneumatics"),
    description = ccb.content.text("Maintaining and building compressed-air powered machines."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.4,
    time_to_learn = "8 h",
}

ccb.content.define_proficiency {
    id = "prof_aircraft_mechanic",
    category = "prof_mechanic",
    name = ccb.content.text("Airframe and Powerplant Mechanic"),
    description = ccb.content.text("You've been trained and certified to repair aircraft.  You're not really sure how that could help you survive now."),
    can_learn = false,
}
