local ccb = require("ccb")

ccb.content.define_mutation {
    id = "THRESH_MANA",
    name = ccb.content.text("Manatouched"),
    points = 1,
    description = ccb.content.text("Magic is in you.  Magic is you."),
    enchantments = { "INLINE_ENCH_THRESH_MANA_0" },
    valid = false,
    purifiable = false,
    threshold = true,
}

ccb.content.define_mutation {
    id = "MANA_CRYST_MANA",
    name = ccb.content.text("Mana Solidification"),
    points = 1,
    categories = { "MANATOUCHED" },
    threshold_requirements = { "THRESH_MANA" },
    description = ccb.content.text("Your internal ley lines have become much easier for you to control, resulting in you being able to naturally create crystallized mana."),
    spells_learned = { crystallize_mana = 1 },
}

ccb.content.define_mutation {
    id = "MANA_SEEKER_BOLTS",
    name = ccb.content.text("Seeker Bolts"),
    description = ccb.content.text("Your hands glow with mana energy.  You can fire seeker bolts from your fingertips."),
    points = 2,
    enchantments = { "INLINE_ENCH_MANA_SEEKER_BOLTS_0" },
    body_light = { hand_r = 8, hand_l = 8 },
    prerequisites = { "MANA_LUM" },
    categories = { "MANATOUCHED" },
    threshold_requirements = { "THRESH_MANA" },
    spells_learned = { manatouched_seeker_bolts = 0 },
}

ccb.content.define_mutation {
    id = "MANA_SUBTLE_SPELL",
    name = ccb.content.text("Subtle Spell"),
    description = ccb.content.text("You no longer need to move your arms to cast spells, due to your ley lines becoming untethered from your arms.  Hand and arm encumbrance no longer applies to spells, and you can cast regardless of wielded objects."),
    points = 3,
    body_light = { arm_r = 4, arm_l = 4 },
    threshold_requirements = { "THRESH_MANA" },
    prerequisites = { "MANA_LUM" },
    categories = { "MANATOUCHED" },
    flags = { "SUBTLE_SPELL" },
}

ccb.content.define_mutation {
    id = "MANA_SILENT_SPELL",
    name = ccb.content.text("Silent Spell"),
    description = ccb.content.text("You no longer need to use your voice to enforce your will upon the world.  Verbal spells do not require an incantation, and mouth encumbrance no longer applies to spell failure chance."),
    points = 3,
    body_light = { mouth = 4 },
    threshold_requirements = { "THRESH_MANA" },
    prerequisites = { "MANA_LUM" },
    categories = { "MANATOUCHED" },
    flags = { "SILENT_SPELL" },
}

ccb.content.define_mutation {
    id = "WEAK",
    name = ccb.content.text("Weak"),
    enchantments = { "INLINE_ENCH_WEAK_0" },
    points = -1,
    description = ccb.content.text("Your body is unnaturally weak.  -2 Strength."),
    types = { "STR" },
    categories = { "MANATOUCHED", "RAT", "BIRD", "SLIME", "SPECIES_ELF" },
    cancels = { "STR_UP", "STR_UP_2", "STR_UP_3", "STR_UP_4", "STR_ALPHA" },
}

ccb.content.define_mutation {
    id = "STR_UP",
    copy_from = "STR_UP",
    add = { cancels = { "WEAK" }, categories = { "SPECIES_LIZARDFOLK", "SPECIES_DWARF" } },
}

ccb.content.define_mutation {
    id = "STR_UP_2",
    copy_from = "STR_UP_2",
    add = { cancels = { "WEAK" }, categories = { "SPECIES_DWARF" } },
}

ccb.content.define_mutation { id = "STR_UP_3", copy_from = "STR_UP_3", add = { cancels = { "WEAK" } } }

ccb.content.define_mutation { id = "STR_UP_4", copy_from = "STR_UP_4", add = { cancels = { "WEAK" } } }

ccb.content.define_mutation { id = "STR_ALPHA", copy_from = "STR_ALPHA", add = { cancels = { "WEAK" } } }

ccb.content.define_mutation {
    id = "MANA_LUM",
    name = ccb.content.text("Mana Luminance"),
    points = 0,
    mixed_effect = true,
    body_temperature = { 100, 100 },
    description = ccb.content.text("The constant thrum of mana makes your ley lines visibly glow beneath the skin of your torso and limbs, shedding a small amount of light.  However, it also makes you slightly warmer."),
    categories = { "MANATOUCHED" },
    body_light = { torso = 3, arm_l = 3, arm_r = 3, leg_l = 3, leg_r = 3 },
}

ccb.content.define_mutation {
    id = "MANA_LUM_FLASH",
    name = ccb.content.text("Mana Flares"),
    points = -1,
    description = ccb.content.text("Casting a spell sometimes causes your mana to grow overexcited, making the normally-dim glow of your ley lines much brighter.  This extends the glow to your entire body."),
    prerequisites = { "MANA_LUM" },
    secondary_prerequisites = { "MANA_REGEN2", "MANA_REGEN_MANATOUCHED" },
    categories = { "MANATOUCHED" },
    enchantments = { "INLINE_ENCH_MANA_LUM_FLASH_0" },
}

ccb.content.define_mutation {
    id = "MANA_LUM_FLASH_ACTIVE",
    name = ccb.content.text_without_extraction("Mana Flares Active"),
    points = -1,
    description = ccb.content.text_without_extraction("Mana Flares Active"),
    valid = false,
    player_display = false,
    categories = { "MANATOUCHED" },
    body_light = {
        head = 15,
        torso = 15,
        arm_l = 15,
        arm_r = 15,
        hand_l = 15,
        hand_r = 15,
        leg_l = 15,
        leg_r = 15,
        foot_l = 15,
        foot_r = 15,
    },
}

ccb.content.define_mutation {
    id = "MANA_LUM_EXTERNAL",
    name = ccb.content.text("Eldritch Glow"),
    points = -3,
    description = ccb.content.text("Your mana sometimes swirls off your leylines and excites the air, creating a eldritch glow around you, occasionally happening when you cast or a spell or when your mana is high enough.  All you can do when it happens is wait for it to subside."),
    prerequisites = { "MANA_LUM_FLASH" },
    secondary_prerequisites = { "MANA_SIPHON_1", "MANA_SIPHON_2" },
    categories = { "MANATOUCHED" },
    threshold_requirements = { "THRESH_MANA" },
}

ccb.content.define_mutation {
    id = "PALE",
    copy_from = "PALE",
    add = { categories = { "MANATOUCHED", "SPECIES_ELF" } },
    visibility = 0,
    ugliness = 0,
    starting_trait = true,
}

ccb.content.define_mutation { id = "ALBINO", copy_from = "ALBINO", add = { categories = { "MANATOUCHED" } } }

ccb.content.define_mutation { id = "ROT1", copy_from = "ROT1", add = { categories = { "MANATOUCHED" } } }

ccb.content.define_mutation { id = "ROT2", copy_from = "ROT2", add = { categories = { "MANATOUCHED" } } }
