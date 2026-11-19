local ccb = require("ccb")

ccb.content.define_proficiency_category {
    id = "prof_afs_social",
    name = ccb.content.text("Social Standing"),
    description = ccb.content.text("Proficiencies related to your status within spacefaring culture in all its forms."),
}

ccb.content.define_proficiency {
    id = "prof_armament_license",
    category = "prof_afs_social",
    name = ccb.content.text("Armament License"),
    can_learn = false,
    description = ccb.content.text("You have a license to own and operate military grade weaponry and can legally purchase such items without any difficulty."),
}

ccb.content.define_proficiency_category {
    id = "prof_concentration",
    name = ccb.content.text("Concentration"),
    description = ccb.content.text("Proficiencies that help with maintaining concentration even in the face of distractions."),
}

ccb.content.define_proficiency {
    id = "prof_concentration_basic",
    category = "prof_concentration",
    name = ccb.content.text("Concentration (Beginner)"),
    description = ccb.content.text("You are capable of holding the same thing in mind even when sitting in an uncomfortable position or after skipping a meal."),
    can_learn = true,
    time_to_learn = "16 h",
    time_multiplier = 2,
    skill_penalty = 0.2,
}

ccb.content.define_proficiency {
    id = "prof_concentration_intermediate",
    category = "prof_concentration",
    name = ccb.content.text("Concentration (Expert)"),
    description = ccb.content.text("You can maintain your concentration even if outside in winter without a coat or in the middle of a fight."),
    can_learn = true,
    time_to_learn = "32 h",
    time_multiplier = 2.5,
    skill_penalty = 0.25,
    requires = { "prof_concentration_basic" },
}

ccb.content.define_proficiency {
    id = "prof_concentration_master",
    category = "prof_concentration",
    name = ccb.content.text("Concentration (Master)"),
    description = ccb.content.text("You can maintain your concentration even when suffering crippling injuries or while on mind-altering substances."),
    can_learn = true,
    time_to_learn = "64 h",
    time_multiplier = 3,
    skill_penalty = 0.3,
    requires = { "prof_concentration_intermediate" },
}
