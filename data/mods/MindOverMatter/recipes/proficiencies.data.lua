local ccb = require("ccb")

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
    description = ccb.content.text("You can maintain your concentration even if outside in winter without a coat or while in combat with a zombie."),
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

ccb.content.define_proficiency_category {
    id = "prof_contemplation",
    name = ccb.content.text("Contemplation"),
    description = ccb.content.text("Proficiencies that help with discovering new powers or improving existing ones."),
}

ccb.content.define_proficiency {
    id = "prof_contemplation_biokinesis",
    category = "prof_contemplation",
    name = ccb.content.text("Biokinetic Insight"),
    description = ccb.content.text("You have an understanding of how biokinesis functions and unlocking new powers is easier for you."),
    can_learn = true,
    time_multiplier = 1.0,
    skill_penalty = 0.2,
    time_to_learn = "32 h",
}

ccb.content.define_proficiency {
    id = "prof_contemplation_clairsentience",
    category = "prof_contemplation",
    name = ccb.content.text("Clairsentient Insight"),
    description = ccb.content.text("You have an understanding of how clairsentience functions and unlocking new powers is easier for you."),
    can_learn = true,
    time_multiplier = 1.0,
    skill_penalty = 0.2,
    time_to_learn = "32 h",
}

ccb.content.define_proficiency {
    id = "prof_contemplation_electrokinesis",
    category = "prof_contemplation",
    name = ccb.content.text("Electrokinetic Insight"),
    description = ccb.content.text("You have an understanding of how electrokinesis functions and unlocking new powers is easier for you."),
    can_learn = true,
    time_multiplier = 1.0,
    skill_penalty = 0.2,
    time_to_learn = "32 h",
}

ccb.content.define_proficiency {
    id = "prof_contemplation_photokinesis",
    category = "prof_contemplation",
    name = ccb.content.text("Photokinetic Insight"),
    description = ccb.content.text("You have an understanding of how photokinesis functions and unlocking new powers is easier for you."),
    can_learn = true,
    time_multiplier = 1.0,
    skill_penalty = 0.2,
    time_to_learn = "32 h",
}

ccb.content.define_proficiency {
    id = "prof_contemplation_pyrokinesis",
    category = "prof_contemplation",
    name = ccb.content.text("Pyrokinetic Insight"),
    description = ccb.content.text("You have an understanding of how pyrokinesis functions and unlocking new powers is easier for you."),
    can_learn = true,
    time_multiplier = 1.0,
    skill_penalty = 0.2,
    time_to_learn = "32 h",
}

ccb.content.define_proficiency {
    id = "prof_contemplation_telekinesis",
    category = "prof_contemplation",
    name = ccb.content.text("Telekinetic Insight"),
    description = ccb.content.text("You have an understanding of how telekinesis functions and unlocking new powers is easier for you."),
    can_learn = true,
    time_multiplier = 1.0,
    skill_penalty = 0.2,
    time_to_learn = "32 h",
}

ccb.content.define_proficiency {
    id = "prof_contemplation_telepathy",
    category = "prof_contemplation",
    name = ccb.content.text("Telepathic Insight"),
    description = ccb.content.text("You have an understanding of how telepathy functions and unlocking new powers is easier for you."),
    can_learn = true,
    time_multiplier = 1.0,
    skill_penalty = 0.2,
    time_to_learn = "32 h",
}

ccb.content.define_proficiency {
    id = "prof_contemplation_teleportation",
    category = "prof_contemplation",
    name = ccb.content.text("Teleportation Insight"),
    description = ccb.content.text("You have an understanding of how teleportation functions and unlocking new powers is easier for you."),
    can_learn = true,
    time_multiplier = 1.0,
    skill_penalty = 0.2,
    time_to_learn = "32 h",
}

ccb.content.define_proficiency {
    id = "prof_contemplation_vitakinesis",
    category = "prof_contemplation",
    name = ccb.content.text("Vitakinetic Insight"),
    description = ccb.content.text("You have an understanding of how vitakinesis functions and unlocking new powers is easier for you."),
    can_learn = true,
    time_multiplier = 1.0,
    skill_penalty = 0.2,
    time_to_learn = "32 h",
}

ccb.content.define_proficiency_category {
    id = "prof_psionic",
    name = ccb.content.text("Psionic Crafting"),
    description = ccb.content.text("Proficiencies that help with channeling psionic energy into physical objects or into more esoteric applications."),
}

ccb.content.define_proficiency {
    id = "prof_psionic_minimum_requirements",
    category = "prof_psionic",
    name = ccb.content.text("Noetic Crafting"),
    description = ccb.content.text("You are capable of using psi and can undertake crafts that require active psionic channeling."),
    can_learn = false,
    teachable = false,
    time_multiplier = 1,
    time_to_learn = "1 h",
}

ccb.content.define_proficiency {
    id = "prof_psionic_minimum_requirements_biokinesis",
    category = "prof_psionic",
    name = ccb.content.text("Biokinetic Crafting"),
    description = ccb.content.text("You are a biokinetic and can undertake crafts that require biokinesis to create."),
    can_learn = false,
    teachable = false,
    time_multiplier = 1,
    time_to_learn = "1 h",
    requires = { "prof_psionic_minimum_requirements" },
}

ccb.content.define_proficiency {
    id = "prof_psionic_minimum_requirements_pyrokinesis",
    category = "prof_psionic",
    name = ccb.content.text("Pyrokinetic Crafting"),
    description = ccb.content.text("You are a pyrokinetic and can undertake crafts that require pyrokinesis to create."),
    can_learn = false,
    teachable = false,
    time_multiplier = 1,
    time_to_learn = "1 h",
    requires = { "prof_psionic_minimum_requirements" },
}

ccb.content.define_proficiency {
    id = "prof_psionic_minimum_requirements_teleportation",
    category = "prof_psionic",
    name = ccb.content.text("Teleportation Crafting"),
    description = ccb.content.text("You are a teleporter and can undertake crafts that require teleportation to create."),
    can_learn = false,
    teachable = false,
    time_multiplier = 1,
    time_to_learn = "1 h",
    requires = { "prof_psionic_minimum_requirements" },
}

ccb.content.define_proficiency {
    id = "prof_psionic_minimum_requirements_vitakinesis",
    category = "prof_psionic",
    name = ccb.content.text("Vitakinetic Crafting"),
    description = ccb.content.text("You are a vitakinetic and can undertake crafts that require vitakinesis to create."),
    can_learn = false,
    teachable = false,
    time_multiplier = 1,
    time_to_learn = "1 h",
    requires = { "prof_psionic_minimum_requirements" },
}

ccb.content.define_proficiency {
    id = "prof_psionic_basic",
    category = "prof_psionic",
    name = ccb.content.text("Psionic Channeling"),
    description = ccb.content.text("You know the basics of focusing your powers into material items."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.3,
    time_to_learn = "12 h",
    requires = { "prof_psionic_minimum_requirements" },
}

ccb.content.define_proficiency {
    id = "prof_psionic_ritual",
    category = "prof_psionic",
    name = ccb.content.text("Thought-form Construction"),
    description = ccb.content.text("You are adept at the focused concentration and elaborate mental exercises required to practice more esoteric psionic abilities."),
    can_learn = true,
    time_multiplier = 1.2,
    skill_penalty = 0.4,
    time_to_learn = "20 h",
    requires = { "prof_psionic_minimum_requirements" },
}

ccb.content.define_proficiency {
    id = "prof_psionic_warping",
    category = "prof_psionic",
    name = ccb.content.text("Dimensional Metaphysics"),
    description = ccb.content.text("You are familiar with how psionic power flows between dimensions and can manipulate that flow."),
    can_learn = true,
    time_multiplier = 1.6,
    skill_penalty = 0.2,
    time_to_learn = "20 h",
    requires = { "prof_psionic_basic", "prof_psionic_containment" },
}

ccb.content.define_proficiency {
    id = "prof_psionic_containment",
    category = "prof_psionic",
    name = ccb.content.text("Energy Containment"),
    description = ccb.content.text("You are proficient in preventing stray substances or thoughts from contaminating your work."),
    can_learn = true,
    time_multiplier = 1.2,
    skill_penalty = 0.8,
    time_to_learn = "16 h",
    requires = { "prof_psionic_basic" },
}

ccb.content.define_proficiency {
    id = "prof_psionic_morphic",
    category = "prof_psionic",
    name = ccb.content.text("Morphology Alteration"),
    description = ccb.content.text("You have mastered using psionics to affect the form of living beings."),
    can_learn = true,
    time_multiplier = 1.6,
    skill_penalty = 0.4,
    time_to_learn = "18 h",
    requires = { "prof_psionic_basic", "prof_psionic_containment" },
}

ccb.content.define_proficiency_category {
    id = "prof_matrix_technology",
    name = ccb.content.text("Matrix Technology"),
    description = ccb.content.text("Proficiencies that help with making materials whose capabilities or functions are possible due to the existence of psionics, but which do not require its use in their creation."),
}

-- This should not be used in any recipe that requires actual psionics to create
ccb.content.define_proficiency {
    id = "prof_matrix_technology_beginner",
    category = "prof_matrix_technology",
    name = ccb.content.text("Principles of Matrix Technology"),
    description = ccb.content.text("You know the basics of creating items using matrix crystals that don't require you to personally to use psi in the crafting process."),
    can_learn = true,
    time_multiplier = 2,
    skill_penalty = 0.3,
    time_to_learn = "8 h",
}
