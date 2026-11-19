local ccb = require("ccb")

ccb.content.define_mutation {
    id = "NO_PSIONICS",
    name = ccb.content.text_without_extraction("Headblind"),
    description = ccb.content.text_without_extraction("You have a normal human (lack of) capacity for psionic powers."),
    player_display = false,
    points = 0,
    dummy = true,
    categories = { "HUMAN" },
    cancels = {
        "BIOKIN_NEEDS", "CLAIR_SENSES", "PHOTO_EYES", "PYROKIN_ADAPTATION", "TELEKINETIC_LIFTER_1",
        "TELEPATHIC_SUGGESTION", "TELEPORTER_PROTECT", "VITAKINETIC_HEALTH",
    },
}

ccb.content.define_mutation {
    id = "BIOKIN_NEEDS",
    name = ccb.content.text("Efficient System"),
    points = 1,
    description = ccb.content.text("Thanks to your powers, you need less food and drink than the average person and are more efficient at processing it."),
    player_display = true,
    valid = false,
    purifiable = false,
    enchantments = { "INLINE_ENCH_BIOKIN_NEEDS_0" },
}

ccb.content.define_mutation {
    id = "CLAIR_SENSES",
    name = ccb.content.text("Psionic Senses"),
    points = 1,
    description = ccb.content.text("Your powers protect you from some sensory disruption and allow you to detect creatures from beyond."),
    player_display = true,
    valid = false,
    purifiable = false,
    enchantments = { "INLINE_ENCH_CLAIR_SENSES_0", "INLINE_ENCH_CLAIR_SENSES_1" },
}

ccb.content.define_mutation {
    id = "ELECTRO_SHIELD",
    name = ccb.content.text("Galvanic Armor"),
    points = 1,
    description = ccb.content.text("Your powers help protect you from electrical damage and slightly reduce the intensity of pain you feel."),
    player_display = true,
    valid = false,
    purifiable = false,
    enchantments = { "INLINE_ENCH_ELECTRO_SHIELD_0" },
}

ccb.content.define_mutation {
    id = "PHOTO_EYES",
    name = ccb.content.text("Photon Regulation"),
    points = 1,
    description = ccb.content.text("Your powers passively filter the amount of photons your eyes receive."),
    flags = { "FLASH_PROTECTION", "SEESLEEP", "GLARE_RESIST" },
    integrated_armor = { "integrated_photo_eyes" },
    player_display = true,
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "PYROKIN_ADAPTATION",
    name = ccb.content.text("Internal Fire"),
    points = 1,
    description = ccb.content.text("You naturally heat the air around you slightly, making it more comfortable in the cold.  It also helps prevent you from getting too wet."),
    body_temperature = { 250, 750 },
    enchantments = { "INLINE_ENCH_PYROKIN_ADAPTATION_0" },
    wet_protection = {
        { part = "head", ignored = 10 },
        { part = "leg_l", ignored = 10 },
        { part = "leg_r", ignored = 10 },
        { part = "foot_l", ignored = 10 },
        { part = "foot_r", ignored = 10 },
        { part = "arm_l", ignored = 10 },
        { part = "arm_r", ignored = 10 },
        { part = "hand_l", ignored = 10 },
        { part = "hand_r", ignored = 10 },
        { part = "torso", ignored = 10 },
    },
    player_display = true,
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "TELEKINETIC_GRAB_POCKETS",
    name = ccb.content.text("Grasping Hand"),
    points = 1,
    description = ccb.content.text("Thanks to a minor application of telekinesis, the items you want to grab are always quick to hand."),
    player_display = true,
    valid = false,
    purifiable = false,
    enchantments = { "INLINE_ENCH_TELEKINETIC_GRAB_POCKETS_0" },
}

ccb.content.define_mutation {
    id = "TELEPATHIC_SUGGESTION",
    name = ccb.content.text("Telepathic Suggestion"),
    points = 1,
    description = ccb.content.text("You are subtly influencing the minds of the people you speak to."),
    valid = false,
    player_display = true,
    purifiable = false,
    enchantments = { "INLINE_ENCH_TELEPATHIC_SUGGESTION_0" },
}

ccb.content.define_mutation {
    id = "TELEPORTER_PROTECT",
    name = ccb.content.text("Spacial Recalibration"),
    points = 1,
    description = ccb.content.text("You can keep otherworldly eyes off you to some extent, and you will sometimes instinctively teleport to avoid danger."),
    valid = false,
    player_display = true,
    purifiable = false,
    enchantments = { "INLINE_ENCH_TELEPORTER_PROTECT_0" },
    flags = { "TELESTOP" },
}

ccb.content.define_mutation {
    id = "VITAKINETIC_HEALTH",
    name = ccb.content.text("Bloom of Vitality"),
    points = 1,
    description = ccb.content.text("Your psionic powers speed your healing slightly and increase your overall resilience, and any broken limbs you have mend straight and true."),
    vitamin_intervals = { mutant_toxin = 180 },
    valid = false,
    player_display = true,
    purifiable = false,
    enchantments = { "INLINE_ENCH_VITAKINETIC_HEALTH_0", "INLINE_ENCH_VITAKINETIC_HEALTH_1" },
    flags = { "MEND_ALL" },
}
