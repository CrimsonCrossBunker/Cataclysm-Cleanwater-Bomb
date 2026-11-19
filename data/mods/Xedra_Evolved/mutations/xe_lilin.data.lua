local ccb = require("ccb")

-- This is a reference to Exodus 16:12
ccb.content.define_mutation {
    id = "LILIN_REDUCED_NEEDS_WITH_RUACH_AND_KCAL_DRAIN",
    name = ccb.content.text("Eating Meat at Twilight"),
    description = ccb.content.text("When filled with ruach, no other food or drink compares.  The more ruach you have, the less mundane hunger or thirst troubles you.  In addition, drinking ruach from your victims assuages your hunger and thirst.  However, mortal foods are no longer as satisfying, and you do not gain as many calories from them."),
    points = 6,
    starting_trait = false,
    purifiable = false,
    mixed_effect = true,
    prerequisites = { "LILIN_REDUCED_NEEDS_WITH_RUACH" },
    secondary_prerequisites = { "LILIN_BONUS_HEALING_ACTIVE" },
    categories = { "LILIN" },
    threshold_requirements = { "THRESH_LILIN" },
    enchantments = { "INLINE_ENCH_LILIN_REDUCED_NEEDS_WITH_RUACH_AND_KCAL_DRAIN_0" },
}

ccb.content.define_mutation {
    id = "LILIN_DISEASE_MELEE_STRIKES",
    name = ccb.content.text("Touch of Contagion"),
    description = ccb.content.text("When you wish it, your very touch bears the contamination of plague.  Your unarmed attacks have a chance to infect your targets, scaling with the amount of ruach you have.  However, mortals who spend too long in your presence have a chance of falling ill."),
    points = 10,
    purifiable = false,
    mixed_effect = true,
    prerequisites = { "LILIN_DISEASE_ENHANCEMENT_DAMAGE" },
    categories = { "LILIN" },
    threshold_requirements = { "THRESH_LILIN" },
}

-- This is a reference to Isaiah 45:3
-- This enchantment removes the effect if the Lilit is outside at day.
ccb.content.define_mutation {
    id = "LILIN_INCREMENTAL_SPEED_BOOST",
    name = ccb.content.text("The Treasures of Darkness"),
    description = ccb.content.text("You are a being of darkness, closer to it than almost anything else is.  It quickens your essence, and with it your actions, the longer you stay in it.  Each night, you receive an increase to your speed that is higher for each consecutive day spent without being exposed to the sun, up to ten.  The light of the sun breaks this quickening, forcing you to wait once more for the shadows to empower you in this way."),
    points = 8,
    starting_trait = false,
    purifiable = false,
    prerequisites = { "LILIN_SPEED_DODGE_BOOST" },
    secondary_prerequisites = { "LILIN_LIMB_SCORE_BONUSES_AT_NIGHT" },
    categories = { "LILIN" },
    threshold_requirements = { "THRESH_LILIN" },
    enchantments = { "INLINE_ENCH_LILIN_INCREMENTAL_SPEED_BOOST_0" },
}

ccb.content.define_mutation {
    id = "LILIN_INSTANT_HEAL",
    name = ccb.content.text("The Moon to Rule the Night"),
    points = 9,
    purifiable = false,
    description = ccb.content.text("At night, under the moonlight, you can knit grievous wounds together in seconds with a great expenditure of ruach."),
    prerequisites = { "LILIN_LIMB_SCORE_BONUSES_AT_NIGHT" },
    secondary_prerequisites = { "LILIN_BONUS_HEALING_ACTIVE" },
    categories = { "LILIN" },
    threshold_requirements = { "THRESH_LILIN" },
    spells_learned = { lilin_instant_heal_spell = 1 },
}

-- This is a reference to Isaiah 66:24
ccb.content.define_mutation {
    id = "LILIN_PREVENT_DEATH_TRIGGER",
    name = ccb.content.text("Their Worm Shall Not Die"),
    points = 15,
    purifiable = false,
    description = ccb.content.text("When taking fatal damage, instead of dying you assume the form of an owl, allowing you to fly away from danger and recover.  This does not function during the day, if you are out of ruach, or if you are killed by fire."),
    prerequisites = { "LILIN_INSTANT_HEAL" },
    secondary_prerequisites = { "LILIN_OWL_FORM_PASS_THROUGH_WALLS" },
    categories = { "LILIN" },
    threshold_requirements = { "THRESH_LILIN" },
}
