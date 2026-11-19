local ccb = require("ccb")

ccb.content.define_mutation {
    id = "VAMPIRIC_STRENGTH_REFINEMENT_SMASHING_TILES",
    points = 3,
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = true,
    name = ccb.content.text("Unholy Devastation"),
    description = ccb.content.text("Your ability to smash inanimate objects increases when you have Vigor Mortis active."),
}

ccb.content.define_mutation {
    id = "BLOODHASTE_REFINEMENT_WATER_RUN",
    points = 3,
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = true,
    name = ccb.content.text("Zephyr"),
    description = ccb.content.text("You can run across water when you have Blood-driven Speed active."),
}

ccb.content.define_mutation {
    id = "VAMPIRIC_RESILIENCE_REFINEMENT_INVINCIBILITY",
    points = 3,
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = true,
    name = ccb.content.text("Flesh of Marble"),
    description = ccb.content.text("The first attack after activating Sanguine Resilience does no damage."),
}

ccb.content.define_mutation {
    id = "VAMPIRE_HEIGHTENED_SENSES_REFINEMENT_SEE_INVISIBLE",
    points = 3,
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = true,
    name = ccb.content.text("Soulsight"),
    description = ccb.content.text("You can see invisible creatures."),
    flags = { "TRUE_SEEING" },
}

ccb.content.define_mutation {
    id = "VAMPIRE_TORPOR_REFINEMENT_FEIGN_DEATH",
    points = 3,
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = true,
    name = ccb.content.text("Corpse's Torpor"),
    description = ccb.content.text("You gain some of Torpor's benefits while using Corpse's Countenance and benefit from the effects of Corpse's countenance while in torpor."),
}

ccb.content.define_mutation {
    id = "VAMPIRE_BLOOD_TEMPORARY_BOOST_REFINEMENT_MIND_BOOST",
    points = 3,
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = true,
    name = ccb.content.text("Carmine Clarity"),
    description = ccb.content.text("The bonuses gained from Carmine Vitality also apply to your intelligence and perception."),
}

ccb.content.define_mutation {
    id = "VAMPIRE_BAT_FORM_REFINEMENT_SWARM",
    points = 3,
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = true,
    name = ccb.content.text("Shape of the Night Fliers' Swarm"),
    description = ccb.content.text("Your hit points aren't reduced while in bat form."),
}

ccb.content.define_mutation {
    id = "VAMPIRE_CARDIO_BONUS_REFINEMENT_STAMINAFORBLOOD",
    points = 3,
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = true,
    name = ccb.content.text("Incarnadine Relentlessness"),
    description = ccb.content.text("You gain a temporary stackable cardio boost when using Unholy Endurance."),
}

ccb.content.define_mutation {
    id = "VAMPIRE_WALK_ON_WALLS_REFINEMENT_LOW_GRAVITY",
    points = 3,
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = true,
    name = ccb.content.text("Light as a Spider's Thread"),
    description = ccb.content.text("Your gravity has been reduced further, increasing your carry capacity by 25% and granting you the ability to glide down from heights."),
    enchantments = { "INLINE_ENCH_VAMPIRE_WALK_ON_WALLS_REFINEMENT_LOW_GRAVITY_0" },
    flags = { "GLIDE" },
}

ccb.content.define_mutation {
    id = "VAMPIRE_EARTH_SLUMBER_REFINEMENT_CREATE_PITS",
    points = 3,
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = true,
    name = ccb.content.text("Earthen Grave"),
    description = ccb.content.text("You can part the earth near you to create holes for your foes to fall into."),
    spells_learned = { vampire_create_pits = 1 },
}
