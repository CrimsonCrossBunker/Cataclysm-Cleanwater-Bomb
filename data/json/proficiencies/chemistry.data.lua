local ccb = require("ccb")

ccb.content.define_proficiency {
    id = "prof_intro_chemistry",
    category = "prof_chem",
    name = ccb.content.text("Principles of Chemistry"),
    description = ccb.content.text("You are beginning to grasp a general idea of how elements and compounds react with each other."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.4,
    time_to_learn = "12 h",
}

ccb.content.define_proficiency {
    id = "prof_gross_anatomy",
    category = "prof_chem",
    name = ccb.content.text("Gross Anatomy"),
    description = ccb.content.text("You've identified the key organs within several creatures and their locations with the goal of attacking them in combat."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.4,
    time_to_learn = "30 m",
}

ccb.content.define_proficiency {
    id = "prof_intro_biology",
    category = "prof_chem",
    name = ccb.content.text("Principles of Biology"),
    description = ccb.content.text("You are beginning to gain a general idea of how various living beings function."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.4,
    time_to_learn = "12 h",
}

ccb.content.define_proficiency {
    id = "prof_organic_chemistry",
    category = "prof_chem",
    name = ccb.content.text("Organic Chemistry"),
    description = ccb.content.text("Knowledge of the branch of chemistry that studies and uses carbon-containing compounds."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.25,
    requires = { "prof_intro_chemistry" },
    time_to_learn = "8 h",
}

ccb.content.define_proficiency {
    id = "prof_inorganic_chemistry",
    category = "prof_chem",
    name = ccb.content.text("Inorganic Chemistry"),
    description = ccb.content.text("Knowledge of the branch of chemistry that studies and uses compounds not containing carbon."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.25,
    requires = { "prof_intro_chemistry" },
    time_to_learn = "8 h",
}

ccb.content.define_proficiency {
    id = "prof_mycology",
    category = "prof_chem",
    name = ccb.content.text("Mycology"),
    description = ccb.content.text("Knowledge of the esoteric biology of fungi."),
    can_learn = true,
    requires = { "prof_intro_biology" },
    time_to_learn = "8 h",
}

ccb.content.define_proficiency {
    id = "prof_mycology_advanced",
    category = "prof_chem",
    name = ccb.content.text("Doctorate of Mycology"),
    description = ccb.content.text("Extensive and detailed knowledge of the esoteric biology of fungi, to an extremely nerdy degree."),
    can_learn = false,
    requires = { "prof_mycology" },
    time_to_learn = "18 h",
}

ccb.content.define_proficiency {
    id = "prof_biochemistry",
    category = "prof_chem",
    name = ccb.content.text("Biochemistry"),
    description = ccb.content.text("The understanding of the chemistry of living things."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.25,
    requires = { "prof_organic_chemistry", "prof_intro_biology" },
    time_to_learn = "8 h",
}

ccb.content.define_proficiency {
    id = "prof_physiology",
    category = "prof_weakpoint",
    name = ccb.content.text("Physiology"),
    description = ccb.content.text("An in-depth understanding of how humans and animals operate."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.25,
    requires = { "prof_intro_biology" },
    time_to_learn = "12 h",
    weakpoint_bonus = 2,
    weakpoint_penalty = 0,
}

ccb.content.define_proficiency {
    id = "prof_xenology",
    category = "prof_weakpoint",
    name = ccb.content.text("Xenology"),
    description = ccb.content.text("You are beginning to grasp a general idea of how alien and post-Cataclysm mutated creatures function and operate."),
    can_learn = true,
    time_multiplier = 2.0,
    skill_penalty = 0.3,
    requires = { "prof_intro_biology" },
    time_to_learn = "12 h",
    weakpoint_bonus = 4,
    weakpoint_penalty = -2,
}

ccb.content.define_proficiency {
    id = "prof_intro_chem_synth",
    category = "prof_chem",
    name = ccb.content.text("Principles of Chemical Synthesis"),
    description = ccb.content.text("You're beginning to grasp the basics of chemical production."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.5,
    requires = { "prof_intro_chemistry" },
    time_to_learn = "12 h",
}

ccb.content.define_proficiency {
    id = "prof_chem_synth",
    category = "prof_chem",
    name = ccb.content.text("Complex Chemical Synthesis"),
    description = ccb.content.text("The proper understanding of safe chemical synthesization and how to clean your tools used for the next batch."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.25,
    requires = { "prof_intro_chem_synth" },
    time_to_learn = "16 h",
}

ccb.content.define_proficiency {
    id = "prof_distilling",
    category = "prof_chem",
    name = ccb.content.text("Distillation"),
    description = ccb.content.text("The process of separating two mixed liquids by their different boiling points."),
    can_learn = true,
    time_multiplier = 1.1,
    skill_penalty = 0.5,
    time_to_learn = "6 h",
}

ccb.content.define_proficiency {
    id = "prof_metallurgy",
    category = "prof_chem",
    name = ccb.content.text("Metallurgy"),
    description = ccb.content.text("An understanding of the chemistry of metalworking and alloys."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.25,
    time_to_learn = "6 h",
}

ccb.content.define_proficiency {
    id = "prof_pharmaceutical",
    category = "prof_chem",
    name = ccb.content.text("Pharmaceutical Production"),
    description = ccb.content.text("An understanding of how to produce various natural and chemical substances pure enough for human consumption."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.25,
    requires = { "prof_intro_chemistry", "prof_intro_biology" },
    time_to_learn = "8 h",
}
