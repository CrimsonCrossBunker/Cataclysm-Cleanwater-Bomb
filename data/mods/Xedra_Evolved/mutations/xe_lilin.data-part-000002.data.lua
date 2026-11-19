local ccb = require("ccb")

-- This is a reference to Samuel 2:9
ccb.content.define_mutation {
    id = "LILIN_SILENT_AT_NIGHT",
    name = ccb.content.text("Silent in Darkness"),
    description = ccb.content.text("When shrouded in shadows, you make as little noise as one.  Your movement is fully silent at night unless you're out of ruach."),
    points = 2,
    starting_trait = false,
    purifiable = false,
    categories = { "LILIN" },
    enchantments = { "INLINE_ENCH_LILIN_SILENT_AT_NIGHT_0" },
}

-- This is a reference to Genesis 1:5
ccb.content.define_mutation {
    id = "LILIN_SLEEP_EASY_DURING_DAY",
    purifiable = false,
    name = ccb.content.text("And There Was Evening"),
    points = 2,
    description = ccb.content.text("You were born to walk the night, and have a much easier time sleeping during the day."),
    categories = { "LILIN" },
    enchantments = { "INLINE_ENCH_LILIN_SLEEP_EASY_DURING_DAY_0" },
}

-- This is a reference to Psalms 121:4
ccb.content.define_mutation {
    id = "LILIN_AVOID_SLEEP",
    name = ccb.content.text("Neither Sleep Nor Slumber"),
    points = 4,
    purifiable = false,
    description = ccb.content.text("While sleep is restful, the ruach you gain fills you with more energy than even a good night's rest.  You may spend ruach to alleviate your sleepiness."),
    prerequisites = { "LILIN_SLEEP_EASY_DURING_DAY" },
    categories = { "LILIN" },
    spells_learned = { lilin_avoid_sleep_spell = 1 },
}

-- This is a reference to Proverbs 5:3
ccb.content.define_mutation {
    id = "LILIN_BONUS_PERSUASION",
    name = ccb.content.text("Smoother than Oil"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Your presence is intoxicating, and humans have a hard time resisting your charms.  You gain a bonus to your persuasion chance as long as you aren't empty of ruach."),
    prerequisites = { "PRETTY", "BEAUTIFUL" },
    categories = { "LILIN" },
    enchantments = { "INLINE_ENCH_LILIN_BONUS_PERSUASION_0" },
}

-- This is a reference to Exodus 20:16
ccb.content.define_mutation {
    id = "LILIN_BONUS_LYING",
    name = ccb.content.text("The False Witness"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("You have a much easier time spinning lies and making people believe them.  You gain a bonus to your lying chance as long as you aren't empty of ruach."),
    prerequisites = { "PRETTY", "BEAUTIFUL" },
    categories = { "LILIN" },
    enchantments = { "INLINE_ENCH_LILIN_BONUS_LYING_0" },
}

-- This is a reference to Jeremiah 10:14
ccb.content.define_mutation {
    id = "LILIN_MESMERIZE_TARGET",
    name = ccb.content.text("Senseless and Without Knowledge"),
    points = 5,
    purifiable = false,
    description = ccb.content.text("You can temporarily beguile a single human, fey, or avian target, causing them to stand senseless or wander in a daze.  Any damage will bring the target out of their trance."),
    prerequisites = { "LILIN_BONUS_PERSUASION" },
    secondary_prerequisites = { "LILIN_TEMPORARY_GLORIOUS", "LILIN_TEMPORARY_GLORIOUS_2" },
    categories = { "LILIN" },
    spells_learned = { lilin_mesmerize_target_spell = 1 },
}

-- For now life extenders such as this one grant MEND_ALL.  When the new wound system will be implemented, their function will be to always allow you to fully heal from your wounds (no scars, etc).
-- This is a reference to Daniel 12:2
ccb.content.define_mutation {
    id = "LILIN_ETERNAL_YOUTH",
    name = ccb.content.text("For Everlasting Life"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Your body has now stopped aging, massively extending your longevity.  You can still be killed but as long as your body can heal, all your wounds will eventually fully heal no matter how severe they are."),
    prerequisites = { "LILIN_DRAIN_RUACH_DISTANCE", "LILIN_DRAIN_RUACH_LONG_DISTANCE" },
    categories = { "LILIN" },
    flags = { "MEND_ALL" },
}

-- This is a reference to Psalms 72:5
ccb.content.define_mutation {
    id = "LILIN_STEADY_SPEED",
    name = ccb.content.text("Enduring Through All Generations"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("With eternal youth comes the strength to endure past anything one could face.  Your speed won't be lower than its default as long as you have some ruach in you."),
    prerequisites = { "LILIN_ETERNAL_YOUTH" },
    categories = { "LILIN" },
    enchantments = { "INLINE_ENCH_LILIN_STEADY_SPEED_0" },
}

ccb.content.define_mutation {
    id = "LILIN_AOE_LINE_DISEASE",
    name = ccb.content.text("Unleash the Night-Wind"),
    points = 4,
    purifiable = false,
    description = ccb.content.text("You may unleash a foul miasma on your enemies, sickening them."),
    prerequisites = { "DISRESISTANT", "DISIMMUNE" },
    secondary_prerequisites = { "LILIN_DRAIN_RUACH_DISTANCE", "LILIN_DRAIN_RUACH_LONG_DISTANCE" },
    replacements = { "LILIN_DISEASE_ENHANCEMENT_DAMAGE" },
    categories = { "LILIN" },
    spells_learned = { lilin_aoe_line_disease_spell = 1 },
}

-- This is a reference to Deuteronomy 28:59.  Note that it's not a positive statement in context
ccb.content.define_mutation {
    id = "LILIN_RESIST_INFECTIONS_CURE_DISEASE",
    name = ccb.content.text("Make Thy Plagues Wonderful"),
    points = 4,
    purifiable = false,
    description = ccb.content.text("With your power over plague comes the ability to alleviate sickness as well.  You may touch a target and cure minor illnesses as well as pause any infections they have in their tracks.  While this power is in effect, the target gains a bonus to their chance of recovery."),
    prerequisites = { "LILIN_AOE_LINE_DISEASE" },
    categories = { "LILIN" },
    spells_learned = { lilin_resist_infections_spell = 1 },
}

ccb.content.define_mutation {
    id = "LILIN_DISEASE_ENHANCEMENT_DAMAGE",
    name = ccb.content.text("Devoured by Pestilence"),
    points = 6,
    purifiable = false,
    mixed_effect = true,
    description = ccb.content.text("You may greatly enhance the power of the miasma from Unleash the Night-Wind, doing serious damage and crippling your target.  However, mortals who spend too long in your presence have a chance of falling ill."),
    prerequisites = { "LILIN_AOE_LINE_DISEASE" },
    secondary_prerequisites = { "LILIN_STEALTH_MODIFIER_IN_DARKNESS" },
    categories = { "LILIN" },
    spells_learned = { lilin_aoe_line_disease_spell = 1, lilin_disease_enhancement_damage_spell = 1 },
}

ccb.content.define_mutation {
    id = "LILIN_BLINDING_TARGET",
    name = ccb.content.text("Dwelling in Deep Darkness"),
    points = 4,
    purifiable = false,
    description = ccb.content.text("You may cut a single target off from light, completely blinding them.  You may only do this at night, and only indoors or out in the wilderness."),
    prerequisites = { "LILIN_THE_EVIL_EYE" },
    categories = { "LILIN" },
    spells_learned = { lilin_blinding_target_spell = 1 },
}
