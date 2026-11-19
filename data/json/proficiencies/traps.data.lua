local ccb = require("ccb")

ccb.content.define_proficiency {
    id = "prof_lockpicking",
    category = "prof_devices",
    name = ccb.content.text("Lockpicking"),
    description = ccb.content.text("You know how to pick a lock, at least in theory."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.5,
    time_to_learn = "2 h",
}

ccb.content.define_proficiency {
    id = "prof_lockpicking_expert",
    category = "prof_devices",
    name = ccb.content.text("Locksmith"),
    description = ccb.content.text("You can pick a lock in the dark, blindfolded.  Although that doesn't make it all that much harder.  You're good at locks, OK?"),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.25,
    time_to_learn = "14 h",
    requires = { "prof_lockpicking" },
}

ccb.content.define_proficiency {
    id = "prof_safecracking",
    category = "prof_devices",
    name = ccb.content.text("Safecracking"),
    description = ccb.content.text("Opening safes is an exacting skill, one that you are proficient at."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.25,
    time_to_learn = "10 h",
}

ccb.content.define_proficiency {
    id = "prof_traps",
    category = "prof_devices",
    name = ccb.content.text("Principles of Trapping"),
    description = ccb.content.text("You know the basics of setting and taking down traps safely."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.25,
    time_to_learn = "3 h",
}

ccb.content.define_proficiency {
    id = "prof_trapsetting",
    category = "prof_devices",
    name = ccb.content.text("Trap Setting"),
    description = ccb.content.text("You're specifically quite skilled at setting effective traps."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.2,
    time_to_learn = "8 h",
    requires = { "prof_traps" },
}

ccb.content.define_proficiency {
    id = "prof_disarming",
    category = "prof_devices",
    name = ccb.content.text("Trap Disarming"),
    description = ccb.content.text("You know how to take down a trap safely."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.3,
    time_to_learn = "8 h",
    requires = { "prof_traps" },
}

ccb.content.define_proficiency {
    id = "prof_spotting",
    category = "prof_survival",
    name = ccb.content.text("Spotting and Awareness"),
    description = ccb.content.text("You are skilled at spotting things out of the ordinary, like traps or ambushes."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.3,
    time_to_learn = "3 h",
}
