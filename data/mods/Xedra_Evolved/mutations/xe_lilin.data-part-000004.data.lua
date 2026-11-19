local ccb = require("ccb")

ccb.content.define_mutation {
    id = "LILIN_ATTRIBUTE_BONUSES_STRENGTH",
    name = ccb.content.text_without_extraction("The Cedars of Lebanon"),
    description = ccb.content.text_without_extraction("Adds a Strength Bonus to Might of the Nephilim.  Should not be player-visible."),
    points = 2,
    purifiable = false,
    player_display = false,
    prerequisites = { "LILIN_ATTRIBUTE_BONUSES" },
    categories = { "LILIN" },
}

-- This is a reference to Proverbs 30:15
-- Use a more appropriate damage type once enchantments support custom damage types. Also, a light level check wound be better than is_day/is_outside
ccb.content.define_mutation {
    id = "LILIN_UNARMED_EXTRA_DAMAGE",
    name = ccb.content.text("Alukah's Daughter"),
    description = ccb.content.text("You can drain essence from your targets with your unarmed attacks.  Not well enough to absorb their ruach, should they have any, but enough to cause additional damage at night.  This damage is strongest during the half to full moon and weakest during the new moon.  It functions only slightly during the day."),
    points = 3,
    purifiable = false,
    prerequisites = { "LILIN_ATTRIBUTE_BONUSES_STRENGTH" },
    secondary_prerequisites = { "LILIN_DRAIN_RUACH_DISTANCE", "LILIN_DRAIN_RUACH_LONG_DISTANCE" },
    categories = { "LILIN" },
    enchantments = {
        "INLINE_ENCH_LILIN_UNARMED_EXTRA_DAMAGE_0", "INLINE_ENCH_LILIN_UNARMED_EXTRA_DAMAGE_1",
        "INLINE_ENCH_LILIN_UNARMED_EXTRA_DAMAGE_2", "INLINE_ENCH_LILIN_UNARMED_EXTRA_DAMAGE_3",
        "INLINE_ENCH_LILIN_UNARMED_EXTRA_DAMAGE_4",
    },
}

ccb.content.define_mutation {
    id = "LILIN_ATTRIBUTE_BONUSES_DEXTERITY",
    name = ccb.content.text_without_extraction("The Leaping Faun"),
    description = ccb.content.text_without_extraction("Adds a Dexterity/Dodge Bonus to Might of the Nephilim.  Should not be player-visible."),
    points = 2,
    purifiable = false,
    player_display = false,
    prerequisites = { "LILIN_ATTRIBUTE_BONUSES" },
    categories = { "LILIN" },
}

ccb.content.define_mutation {
    id = "LILIN_SPEED_DODGE_BOOST",
    name = ccb.content.text("Reaping the Whirlwind"),
    description = ccb.content.text("With an expenditure of ruach you can drastically enhance your speed for a short period of time."),
    points = 4,
    starting_trait = false,
    purifiable = false,
    prerequisites = { "LILIN_ATTRIBUTE_BONUSES_DEXTERITY" },
    secondary_prerequisites = { "DEFT" },
    categories = { "LILIN" },
    spells_learned = { lilin_speed_dodge_boost_spell = 1 },
}

ccb.content.define_mutation {
    id = "LILIN_UNCANNY_DODGE_WHILE_REAPING",
    name = ccb.content.text("From Shadow to Shadow"),
    description = ccb.content.text("You can leap away from attacks like shadows dancing in candlelight.  You gain Uncanny Dodge while under the effects of Reaping the Whirlwind."),
    points = 6,
    starting_trait = false,
    purifiable = false,
    prerequisites = { "LILIN_SPEED_DODGE_BOOST" },
    secondary_prerequisites = { "LILIN_UNARMED_EXTRA_DAMAGE" },
    categories = { "LILIN" },
}

ccb.content.define_mutation {
    id = "LILIN_ATTRIBUTE_BONUSES_PERCEPTION",
    name = ccb.content.text_without_extraction("And All the People Saw the Sounds"),
    description = ccb.content.text_without_extraction("Adds a Perception Bonus to Might of the Nephilim.  Should not be player-visible."),
    points = 2,
    purifiable = false,
    player_display = false,
    prerequisites = { "LILIN_ATTRIBUTE_BONUSES" },
    categories = { "LILIN" },
}

ccb.content.define_mutation {
    id = "LILIN_NIGHT_VISION",
    name = ccb.content.text("Strigine Gaze"),
    description = ccb.content.text("Your eyes have adapted to the darkness of the night, allowing you to see further through the shadows.  This is most effective out under the moon but still has an effect indoors."),
    points = 3,
    purifiable = false,
    replacements = { "LILIN_NIGHT_VISION_UPGRADE" },
    prerequisites = { "LILIN_ATTRIBUTE_BONUSES_PERCEPTION" },
    secondary_prerequisites = { "LILIN_THE_EVIL_EYE" },
    categories = { "LILIN" },
    enchantments = {
        "INLINE_ENCH_LILIN_NIGHT_VISION_0",
        "INLINE_ENCH_LILIN_NIGHT_VISION_1",
        "INLINE_ENCH_LILIN_NIGHT_VISION_2",
    },
}

ccb.content.define_mutation {
    id = "LILIN_GAIN_MORE_FOCUS",
    name = ccb.content.text("Owl's Wisdom"),
    description = ccb.content.text("The owl is a symbol of wisdom in culture after culture, and you are the heir to that wisdom.  You find it easier to learn things, and even easier the more ruach you're holding on to."),
    points = 1,
    purifiable = false,
    prerequisites = { "LILIN_SLEEP_EASY_DURING_DAY" },
    categories = { "LILIN" },
    enchantments = { "INLINE_ENCH_LILIN_GAIN_MORE_FOCUS_0" },
}

ccb.content.define_mutation {
    id = "LILIN_EASIER_WEAKPOINT_ATTACKS",
    name = ccb.content.text("Shattering the Broken Vessels"),
    description = ccb.content.text("Attuned to darkness and disease, you can easily spot the cracks in your enemies' defenses.  You have an easier chance to hit enemy weakpoints, increasing as your ruach rises."),
    points = 4,
    purifiable = false,
    prerequisites = { "LILIN_GAIN_MORE_FOCUS" },
    secondary_prerequisites = { "LILIN_NIGHT_VISION", "LILIN_NIGHT_VISION_UPGRADE" },
    categories = { "LILIN" },
    enchantments = { "INLINE_ENCH_LILIN_EASIER_WEAKPOINT_ATTACKS_0" },
}

-- This is a reference to Psalms 91:6
-- A light level check would be better than is_day/is_outside
ccb.content.define_mutation {
    id = "LILIN_STEALTH_MODIFIER_IN_DARKNESS",
    name = ccb.content.text("The Pestilence that Stalks in Darkness"),
    description = ccb.content.text("You are at home in the darkness and it clings to you to cover your movements.  In a half- or smaller moon, and when out of the daylight, it is harder for your enemies to spots you.  However, infused with plague as you are, mortals who spend too long in your presence have a chance of falling ill."),
    points = 3,
    purifiable = false,
    mixed_effect = true,
    prerequisites = { "LILIN_AVOID_SLEEP" },
    categories = { "LILIN" },
    enchantments = {
        "INLINE_ENCH_LILIN_STEALTH_MODIFIER_IN_DARKNESS_0",
        "INLINE_ENCH_LILIN_STEALTH_MODIFIER_IN_DARKNESS_1",
        "INLINE_ENCH_LILIN_STEALTH_MODIFIER_IN_DARKNESS_2",
    },
}

-- This is a reference to Psalm 147:17
ccb.content.define_mutation {
    id = "LILIN_RESIST_COLD",
    name = ccb.content.text("Stand Before the Cold"),
    description = ccb.content.text("As a hunter in the night, you are well-conditioned to the cold after the sun goes down.  You are resistant to chill temperatures, and more so the more ruach you have."),
    points = 2,
    starting_trait = false,
    purifiable = false,
    categories = { "LILIN" },
    enchantments = { "INLINE_ENCH_LILIN_RESIST_COLD_0" },
}

-- This is a reference to Proverbs 25:16
ccb.content.define_mutation {
    id = "LILIN_REDUCED_NEEDS_WITH_RUACH",
    name = ccb.content.text("Eating Drops of Honey"),
    description = ccb.content.text("When filled with ruach, no other food or drink compares.  The more ruach you have, the less mundane hunger or thirst troubles you.  However, mortal foods are no longer as satisfying, and you do not gain as many calories from them."),
    points = 6,
    starting_trait = false,
    purifiable = false,
    mixed_effect = true,
    replacements = { "LILIN_REDUCED_NEEDS_WITH_RUACH_AND_KCAL_DRAIN" },
    prerequisites = { "LILIN_ATTRIBUTE_BONUSES" },
    secondary_prerequisites = { "LILIN_DRAIN_RUACH_DISTANCE", "LILIN_DRAIN_RUACH_LONG_DISTANCE" },
    categories = { "LILIN" },
    enchantments = { "INLINE_ENCH_LILIN_REDUCED_NEEDS_WITH_RUACH_0" },
}

ccb.content.define_mutation {
    id = "LILIN_BONUS_HEALING",
    name = ccb.content.text("Warm Breath"),
    description = ccb.content.text("Your stolen ruach speeds your healing in proportion to how much of it you have."),
    points = 3,
    starting_trait = false,
    purifiable = false,
    prerequisites = { "LILIN_SLEEP_EASY_DURING_DAY" },
    categories = { "LILIN" },
    enchantments = { "INLINE_ENCH_LILIN_BONUS_HEALING_0" },
}
