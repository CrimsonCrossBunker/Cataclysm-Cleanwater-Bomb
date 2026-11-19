local ccb = require("ccb")

ccb.content.define_proficiency {
    id = "prof_gunsmithing_basic",
    category = "prof_gunmaking",
    name = ccb.content.text("Principles of Gunsmithing"),
    description = ccb.content.text("A basic understanding of how guns are put together and what tools and materials are needed for the job."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.5,
    time_to_learn = "4 h",
}

-- Intentionally does not require basic gunsmithing
ccb.content.define_proficiency {
    id = "prof_gunsmithing_improv",
    category = "prof_gunmaking",
    name = ccb.content.text("Improvised Gunmaking"),
    description = ccb.content.text("You've become an expert at putting together guns and launchers from makeshift parts."),
    can_learn = true,
    time_multiplier = 2.5,
    skill_penalty = 0.25,
    time_to_learn = "10 h",
}

ccb.content.define_proficiency {
    id = "prof_gunsmithing_antique",
    category = "prof_gunmaking",
    name = ccb.content.text("Antique Gunsmithing"),
    description = ccb.content.text("You're specifically skilled at building and repairing antique guns."),
    can_learn = true,
    time_multiplier = 2.5,
    skill_penalty = 0.3,
    time_to_learn = "10 h",
    requires = { "prof_metalworking", "prof_gunsmithing_basic" },
}

ccb.content.define_proficiency {
    id = "prof_gunsmithing_spring",
    category = "prof_gunmaking",
    name = ccb.content.text("Spring-powered Guns and Crossbows"),
    description = ccb.content.text("Similar to bowyery, the art of making guns that are powered by elastic mechanisms."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.4,
    time_to_learn = "6 h",
}

ccb.content.define_proficiency {
    id = "prof_gunsmithing_revolver",
    category = "prof_gunmaking",
    name = ccb.content.text("Revolver Gunsmithing"),
    description = ccb.content.text("You've got the know-how to make a classic Western revolver, and its many variants."),
    can_learn = true,
    time_multiplier = 2.5,
    skill_penalty = 0.3,
    time_to_learn = "10 h",
    requires = { "prof_gunsmithing_basic" },
}

ccb.content.define_proficiency {
    id = "prof_gun_cleaning",
    category = "prof_gunmaking",
    name = ccb.content.text("Firearm Cleaning"),
    description = ccb.content.text("You know how to quickly disassemble guns, clean them, and reassemble them in the field."),
    can_learn = true,
    time_multiplier = 2.0,
    skill_penalty = 0.1,
    time_to_learn = "10 h",
}
