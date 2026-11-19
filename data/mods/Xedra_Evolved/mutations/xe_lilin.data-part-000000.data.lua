local ccb = require("ccb")

-- Lilin powers should deal with darkness, disease, night, the moon, and owls.  They specifically should not have powers that make them physically tougher, such as armor- or hp-increasing powers, or powers that do large amounts of direct damage.
-- The push and pull of Lilin powers is that they have active powers that require them to spend ruach, and passive powers that scale based on how much ruach they have (some active powers also do this)
-- An umbrella cannot protect you because this is a mystical weakness.
ccb.content.define_mutation {
    id = "THRESH_LILIN",
    name = ccb.content.text("One with the Night"),
    points = 0,
    description = ccb.content.text("You have ascended in power and can rival the mighty night-creatures of old.  The night is your home, now, out of the light of the sun."),
    purifiable = false,
    threshold = true,
    enchantments = { "INLINE_ENCH_THRESH_LILIN_0", "INLINE_ENCH_THRESH_LILIN_1", "INLINE_ENCH_THRESH_LILIN_2" },
}

ccb.content.define_mutation {
    id = "LILIN_DRAIN_RUACH_MELEE",
    name = ccb.content.text("Enervating Touch"),
    description = ccb.content.text("With but a touch, you can drain the vitality and spiritual essence from your targets."),
    points = 2,
    valid = false,
    starting_trait = false,
    purifiable = false,
    replacements = { "LILIN_DRAIN_RUACH_DISTANCE" },
    categories = { "LILIN" },
    spells_learned = { lilin_drain_ruach_melee_spell = 1 },
}

ccb.content.define_mutation {
    id = "LILIN_DRAIN_RUACH_DISTANCE",
    name = ccb.content.text("Breath Stealer"),
    description = ccb.content.text("You no longer need to touch your targets to drain their ruach; you can do it at a short distance through their breath."),
    points = 4,
    starting_trait = false,
    purifiable = false,
    prerequisites = { "LILIN_DRAIN_RUACH_MELEE" },
    replacements = { "LILIN_DRAIN_RUACH_LONG_DISTANCE" },
    categories = { "LILIN" },
    spells_learned = { lilin_drain_ruach_short_ranged_spell = 1, lilin_drain_ruach_melee_spell = 1 },
}

-- Ruach is the Hebrew word for 'breath,' but it can also mean 'spirit'
ccb.content.define_mutation {
    id = "LILIN_DRAIN_RUACH_LONG_DISTANCE",
    name = ccb.content.text("Ruach Drinker"),
    description = ccb.content.text("You no longer need to touch your targets to drain their ruach; you can do it at a great distance through their breath."),
    points = 6,
    starting_trait = false,
    purifiable = false,
    prerequisites = { "LILIN_DRAIN_RUACH_DISTANCE" },
    categories = { "LILIN" },
    threshold_requirements = { "THRESH_LILIN" },
    spells_learned = { lilin_drain_ruach_long_ranged_spell = 1, lilin_drain_ruach_melee_spell = 1 },
}

-- This is a reference to Psalm 132:4
ccb.content.define_mutation {
    id = "LILIN_GAIN_EXTRA_RUACH_FROM_SLEEPY_PEOPLE",
    name = ccb.content.text("Given Sleep to Their Eyes"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("In sleep, a person's defenses are down and it is easier for the things in the night to prey upon them.  You gain additional ruach from sleeping targets."),
    prerequisites = { "LILIN_SLEEP_EASY_DURING_DAY" },
    secondary_prerequisites = { "LILIN_ATTRIBUTE_BONUSES_PERCEPTION" },
    categories = { "LILIN" },
}

-- This is a reference to Job 22:14
ccb.content.define_mutation {
    id = "LILIN_CHANGE_WEATHER_FOG",
    name = ccb.content.text("Thick Clouds A Covering"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Call up thick clouds of fog, allowing you to hide from your enemies.  This power <color_green>lasts longer</color> when closer to the new moon."),
    categories = { "LILIN" },
    spells_learned = { lilin_change_weather_fog_spell = 1 },
}

ccb.content.define_mutation {
    id = "LILIN_THE_EVIL_EYE",
    name = ccb.content.text("The Evil Eye"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("With a baleful gaze and a heart full of malice, curse a single target with misfortune."),
    categories = { "LILIN" },
    spells_learned = { lilin_evil_eye_spell = 1 },
    flags = { "EVIL_EYE_IMMUNE" },
}

ccb.content.define_mutation {
    id = "LILIN_AOE_DAZE",
    name = ccb.content.text("Cry of the Night-Bird"),
    points = 3,
    purifiable = false,
    description = ccb.content.text("Let out a piercing cry, disorienting both enemies and allies nearby."),
    prerequisites = { "LILIN_THE_EVIL_EYE" },
    secondary_prerequisites = { "LILIN_NIGHT_VISION", "LILIN_NIGHT_VISION_UPGRADE" },
    categories = { "LILIN" },
    spells_learned = { lilin_aoe_daze_spell = 1 },
}
