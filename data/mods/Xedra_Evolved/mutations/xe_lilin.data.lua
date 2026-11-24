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

ccb.content.define_mutation {
    id = "LILIN_TURN_INTO_OWL",
    name = ccb.content.text("On Silent Wings"),
    points = 8,
    description = ccb.content.text("You can transform yourself into an owl and take wing on the night air.  You won't be able to drain ruach while you are in this form."),
    starting_trait = false,
    purifiable = false,
    active = true,
    activation_setup_only = true,
    prerequisites = { "LILIN_HOLD_MORE_RUACH_2", "LILIN_HOLD_MORE_RUACH_3" },
    secondary_prerequisites = { "LILIN_AVOID_SLEEP" },
    categories = { "LILIN" },
    activation_message = "",
    on_activate = "lilin_turn_into_owl_on",
    on_deactivate = "lilin_turn_into_owl_off",
}

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

-- Name comes from Genesis 29:17
ccb.content.define_mutation {
    id = "LILIN_TEMPORARY_GLORIOUS",
    name = ccb.content.text("Of Beautiful Form"),
    description = ccb.content.text("You can use your powers to spin a web of illusion around yourself, increasing your attractiveness to a supernatural degree.  While the harsh light of the sun destroys the illusion, you need merely to move back into the shadows to restore it."),
    points = 2,
    purifiable = false,
    prerequisites = { "BEAUTIFUL" },
    secondary_prerequisites = { "LILIN_BONUS_PERSUASION" },
    categories = { "LILIN" },
    replacements = { "LILIN_TEMPORARY_GLORIOUS_2" },
    active = true,
    activation_setup_only = true,
    activation_message = "",
    on_activate = "lilin_temporary_glorious_on",
    on_process = "lilin_temporary_glorious_process",
    on_deactivate = "lilin_temporary_glorious_off",
}

-- Name comes from II Samuel 14:25
ccb.content.define_mutation {
    id = "LILIN_TEMPORARY_GLORIOUS_2",
    name = ccb.content.text("Without Blemish"),
    description = ccb.content.text("You can use your powers to spin a web of illusion around yourself, increasing your attractiveness to a supernatural degree.  While the harsh light of the sun destroys the illusion, you need merely to move back into the shadows to restore it.  You have grown so powerful that this illusion requires almost no effort and can be <color_green>maintained for weeks</color> at a time."),
    points = 2,
    purifiable = false,
    prerequisites = { "LILIN_TEMPORARY_GLORIOUS" },
    secondary_prerequisites = { "LILIN_LIMB_SCORE_BONUSES_AT_NIGHT" },
    categories = { "LILIN" },
    threshold_requirements = { "THRESH_LILIN" },
    active = true,
    activation_setup_only = true,
    activation_message = "",
    on_activate = "lilin_temporary_glorious_on",
    on_process = "lilin_temporary_glorious_process",
    on_deactivate = "lilin_temporary_glorious_off",
}

ccb.content.define_mutation {
    id = "LILIN_ATTRIBUTE_BONUSES",
    name = ccb.content.text("Might of the Nephilim"),
    description = ccb.content.text("Like the monstrous children of angels and humans, your prowess surpasses mortal limits.  Activate this trait to empower yourself."),
    points = 4,
    purifiable = false,
    categories = { "LILIN" },
    active = true,
    activation_setup_only = true,
    activation_message = "",
    on_activate = "lilin_attribute_bonuses_on",
    on_deactivate = "lilin_attribute_bonuses_off",
}

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

ccb.content.define_mutation {
    id = "LILIN_BONUS_HEALING_ACTIVE",
    name = ccb.content.text("The Night's Caress"),
    description = ccb.content.text("Sometimes, you cannot passively wait for your ruach to heal your wounds, you need it to happen immediately.  You may activate this trait to greatly speed your healing at a continual cost of ruach."),
    points = 5,
    starting_trait = false,
    purifiable = false,
    active = true,
    activation_setup_only = true,
    prerequisites = { "LILIN_BONUS_HEALING" },
    secondary_prerequisites = { "LILIN_ATTRIBUTE_BONUSES_STRENGTH" },
    categories = { "LILIN" },
    activation_message = "",
    on_activate = "lilin_bonus_healing_on",
    on_deactivate = "lilin_bonus_healing_off",
}

ccb.content.define_mutation {
    id = "LILIN_HOLD_MORE_RUACH",
    name = ccb.content.text("Ruach Spring"),
    description = ccb.content.text("Your powers have expanded and you are now capable of holding more ruach."),
    points = 2,
    starting_trait = false,
    purifiable = false,
    prerequisites = { "LILIN_GAIN_MORE_FOCUS" },
    replacements = { "LILIN_HOLD_MORE_RUACH_2" },
    categories = { "LILIN" },
}

ccb.content.define_mutation {
    id = "LILIN_HOLD_MORE_RUACH_2",
    name = ccb.content.text("Ruach Well"),
    description = ccb.content.text("Your powers have expanded and you are now capable of holding even more ruach."),
    points = 6,
    starting_trait = false,
    purifiable = false,
    prerequisites = { "LILIN_HOLD_MORE_RUACH" },
    secondary_prerequisites = {
        "LILIN_ATTRIBUTE_BONUSES_STRENGTH", "LILIN_ATTRIBUTE_BONUSES_DEXTERITY",
        "LILIN_ATTRIBUTE_BONUSES_PERCEPTION",
    },
    replacements = { "LILIN_HOLD_MORE_RUACH_3" },
    categories = { "LILIN" },
}

ccb.content.define_mutation {
    id = "LILIN_HOLD_MORE_RUACH_3",
    name = ccb.content.text("Ruach Sea"),
    description = ccb.content.text("Your powers have expanded and you are now capable of holding an enormous amount of ruach."),
    points = 10,
    starting_trait = false,
    purifiable = false,
    prerequisites = { "LILIN_HOLD_MORE_RUACH_2" },
    categories = { "LILIN" },
    threshold_requirements = { "THRESH_LILIN" },
}

-- This is a reference to Proverbs 23:5
ccb.content.define_mutation {
    id = "LILIN_RUACH_EFFICIENCY",
    name = ccb.content.text("Glancing at Riches"),
    description = ccb.content.text("You've learned how to more efficiently use your ruach, greedily keeping some behind for yourself when you activate your powers.  Powers that cost ruach have their initial and periodic costs reduced by 15%.  This does not reduce the continual ruach cost of staying alive."),
    points = 5,
    starting_trait = false,
    purifiable = false,
    prerequisites = { "LILIN_HOLD_MORE_RUACH", "LILIN_HOLD_MORE_RUACH_2", "LILIN_HOLD_MORE_RUACH_3" },
    secondary_prerequisites = { "LILIN_GAIN_MORE_FOCUS" },
    replacements = { "LILIN_RUACH_EFFICIENCY_UPGRADE" },
    categories = { "LILIN" },
}

-- This is a reference to Jeremiah 5:27
ccb.content.define_mutation {
    id = "LILIN_RUACH_EFFICIENCY_UPGRADE",
    name = ccb.content.text("Like a Cage Full of Birds"),
    description = ccb.content.text("You jealously parcel out your ruach, only spending exactly as much as you need and no more.  Powers that cost ruach have their initial and periodic costs reduced by 15%, with an additional reduction that grows based on your total amount of ruach, to a maximum reduction of 33%.  This does not reduce the continual ruach cost of staying alive."),
    points = 10,
    starting_trait = false,
    purifiable = false,
    prerequisites = { "LILIN_TEMPORARY_GLORIOUS_2" },
    secondary_prerequisites = { "LILIN_RUACH_EFFICIENCY" },
    categories = { "LILIN" },
    threshold_requirements = { "THRESH_LILIN" },
}

-- This is a reference to Psalms 139:12
ccb.content.define_mutation {
    id = "LILIN_READ_CRAFT_IN_DARKNESS",
    name = ccb.content.text("The Darkness is not Dark to You"),
    description = ccb.content.text("You have adapted so well to the night that it doesn't hinder your actions at all.  You can read and craft in any light levels."),
    points = 4,
    purifiable = false,
    prerequisites = { "LILIN_NIGHT_VISION" },
    categories = { "LILIN" },
    threshold_requirements = { "THRESH_LILIN" },
    flags = { "CRAFT_IN_DARKNESS", "READ_IN_DARKNESS" },
}

-- This is a reference to Psalms 139:12
ccb.content.define_mutation {
    id = "LILIN_NIGHT_VISION_UPGRADE",
    name = ccb.content.text("The Night Shines Like the Day"),
    description = ccb.content.text("Your eyes have fully adapted to the darkness, allowing you to see as well in the dark as humans see in the light.  However, the light of the sun is dazzling now."),
    points = 7,
    mixed_effect = true,
    purifiable = false,
    prerequisites = { "LILIN_NIGHT_VISION" },
    secondary_prerequisites = { "LILIN_READ_CRAFT_IN_DARKNESS" },
    categories = { "LILIN" },
    threshold_requirements = { "THRESH_LILIN" },
    enchantments = { "INLINE_ENCH_LILIN_NIGHT_VISION_UPGRADE_0", "INLINE_ENCH_LILIN_NIGHT_VISION_UPGRADE_1" },
    flags = { "MYOPIC_IN_LIGHT_SUPERNATURAL" },
}

-- This is a reference to Jeremiah 31:35
-- prerequisites are having at least one power amplified by the moon.  As this is written, only one such power exists.
ccb.content.define_mutation {
    id = "LILIN_STRONGER_MOON",
    name = ccb.content.text("The Moon Shall Shine at Night"),
    description = ccb.content.text("You are closely attuned to the moon, and some of your powers grow stronger with it.  Any ability you have that is amplified the fuller the moon is will not be weakened as much by an incomplete but non-new moon."),
    points = 3,
    purifiable = false,
    prerequisites = { "LILIN_UNARMED_EXTRA_DAMAGE" },
    categories = { "LILIN" },
    threshold_requirements = { "THRESH_LILIN" },
}

ccb.content.define_mutation {
    id = "LILIN_OWL_FORM_PASS_THROUGH_WALLS",
    name = ccb.content.text("Like an Unclean Spirit"),
    description = ccb.content.text("Your owl form is half spirit and half flesh.  You have a high chance to dodge any attacks against you, and may pass straight through walls as long as it is night."),
    points = 6,
    purifiable = false,
    prerequisites = { "LILIN_TURN_INTO_OWL" },
    secondary_prerequisites = { "LILIN_UNCANNY_DODGE_WHILE_REAPING" },
    categories = { "LILIN" },
    threshold_requirements = { "THRESH_LILIN" },
}

ccb.content.define_mutation {
    id = "LILIN_LIMB_SCORE_BONUSES_AT_NIGHT",
    name = ccb.content.text("The Night-Hunter"),
    description = ccb.content.text("You are at home in the night, and your prowess is heightened while the moon is up as long as you have any ruach within you."),
    points = 8,
    starting_trait = false,
    purifiable = false,
    prerequisites = { "LILIN_UNARMED_EXTRA_DAMAGE", "LILIN_SPEED_DODGE_BOOST" },
    secondary_prerequisites = { "LILIN_READ_CRAFT_IN_DARKNESS" },
    categories = { "LILIN" },
    threshold_requirements = { "THRESH_LILIN" },
    enchantments = { "INLINE_ENCH_LILIN_LIMB_SCORE_BONUSES_AT_NIGHT_0" },
}

ccb.content.define_mutation {
    id = "LILIN_TRANSFORM_INTO_WAR_OWL_FORM",
    name = ccb.content.text("The Strix's Wrath"),
    points = 10,
    description = ccb.content.text("You can combine your forms, transforming into a large owl-human hybrid with wings, rending talons, and a deadly beak.  You won't be able to drain ruach while you are in this form."),
    starting_trait = false,
    purifiable = false,
    active = true,
    activation_setup_only = true,
    prerequisites = { "LILIN_SPEED_DODGE_BOOST" },
    secondary_prerequisites = { "LILIN_TURN_INTO_OWL" },
    categories = { "LILIN" },
    threshold_requirements = { "THRESH_LILIN" },
    activation_message = "",
    on_activate = "lilin_war_owl_on",
    on_deactivate = "lilin_war_owl_off",
}

ccb.content.define_mutation {
    id = "LILIN_WAR_OWL_FORM_LEAPER",
    name = ccb.content.text("Strix's Leap"),
    description = ccb.content.text("While you cannot fly, with your bird-like legs and your wings, you can leap quite a distance."),
    valid = false,
    points = 0,
    active = true,
    activation_setup_only = false,
    activation_message = "",
    on_activate = "lilin_strix_leap",
}

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
