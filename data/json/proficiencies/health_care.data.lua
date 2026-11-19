local ccb = require("ccb")

ccb.content.define_proficiency {
    id = "prof_wound_care",
    category = "prof_firstaid",
    name = ccb.content.text("Wound Care"),
    description = ccb.content.text("You know how to bandage wounds and understand basic principles of wound care."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.5,
    time_to_learn = "2 h",
}

ccb.content.define_proficiency {
    id = "prof_wound_care_expert",
    category = "prof_firstaid",
    name = ccb.content.text("Wound Care Expert"),
    description = ccb.content.text("Your extensive field experience in bandaging and wound care is on par with that of a paramedic."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.25,
    time_to_learn = "14 h",
    requires = { "prof_wound_care" },
}

ccb.content.define_proficiency {
    id = "prof_burn_care",
    category = "prof_firstaid",
    name = ccb.content.text("Burn Care"),
    description = ccb.content.text("You have some basic understanding of how burns work and (potentially) how they could be treated."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.25,
    time_to_learn = "12 h",
    requires = { "prof_wound_care" },
}

ccb.content.define_proficiency {
    id = "prof_dissect_humans",
    category = "prof_firstaid",
    name = ccb.content.text("Human Autopsies"),
    description = ccb.content.text("You have been trained such that you are desensitized to the sight of a human's innards, and can dissect human corpses without penalty."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.25,
    time_to_learn = "125 h",
    requires = { "prof_physiology" },
}
