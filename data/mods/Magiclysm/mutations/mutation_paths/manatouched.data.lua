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

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "sp_mana_siphon",
    name = ccb.content.text_without_extraction("Mana Siphon"),
    description = ccb.content.text_without_extraction("This is the spell portion of the mana siphon series of mutations.  If you have this spell you probably debugged it in."),
    valid_targets = { "self" },
    min_damage = 5,
    damage_increment = 5.0,
    max_damage = 180,
    max_level = 35,
    effect = "recover_energy",
    effect_data = "MANA",
    shape = "blast",
    flags = { "SILENT", "NO_LEGS", "NO_HANDS" },
}

ccb.content.define_mutation {
    id = "MANA_SIPHON_1",
    name = ccb.content.text("Mana Siphon"),
    points = 1,
    description = ccb.content.text("Violence excites your ley lines.  Whenever you hit an enemy in melee, you have a chance of regaining some mana."),
    categories = { "MANATOUCHED", "DRAGON_BLACK", "SPECIES_ELF" },
    threshold_requirements = { "THRESH_MANA", "THRESH_DRAGON_BLACK", "THRESH_SPECIES_ELF" },
    types = { "MANA_SIPHON" },
    replacements = { "MANA_SIPHON_2" },
    enchantments = { "ench_mana_siphon_1" },
}

ccb.content.define_mutation {
    id = "MANA_SIPHON_2",
    name = ccb.content.text("Mana Drain"),
    points = 2,
    description = ccb.content.text("Violence excites your ley lines.  Whenever you hit an enemy in melee, you have a chance of regaining some mana."),
    categories = { "MANATOUCHED", "DRAGON_BLACK" },
    threshold_requirements = { "THRESH_MANA", "THRESH_DRAGON_BLACK" },
    prerequisites = { "MANA_SIPHON_1" },
    types = { "MANA_SIPHON" },
    replacements = { "MANA_SIPHON_3" },
    enchantments = { "ench_mana_siphon_2" },
}

ccb.content.define_mutation {
    id = "MANA_SIPHON_3",
    name = ccb.content.text("Mana Vortex"),
    points = 3,
    description = ccb.content.text("Violence excites your ley lines.  Whenever you hit an enemy in melee, you have a chance of regaining some mana."),
    categories = { "MANATOUCHED", "DRAGON_BLACK" },
    threshold_requirements = { "THRESH_MANA", "THRESH_DRAGON_BLACK" },
    types = { "MANA_SIPHON" },
    prerequisites = { "MANA_SIPHON_2" },
    secondary_prerequisites = { "MANA_LUM_EXTERNAL", "DRAGON_MAGIC", "DRAGON_SPELLS" },
    enchantments = { "ench_mana_siphon_3" },
}

ccb.content.define_mutation {
    id = "MANA_ADD_MANATOUCHED",
    name = ccb.content.text("Manatouched Mana Efficiency"),
    points = 5,
    description = ccb.content.text("You are able to store a lot more mana in your body than usual."),
    cancels = { "MANA_SUB1", "MANA_SUB2", "MANA_SUB3" },
    threshold_requirements = { "THRESH_MANA" },
    types = { "MANA_ADD" },
    prerequisites = { "MANA_ADD3" },
    categories = { "MANATOUCHED" },
    enchantments = { "INLINE_ENCH_MANA_ADD_MANATOUCHED_0" },
}

ccb.content.define_mutation {
    id = "MANA_REGEN_MANATOUCHED",
    name = ccb.content.text("Manatouched Mana Regeneration"),
    points = 10,
    description = ccb.content.text("Your natural mana regeneration is much faster than normal."),
    prerequisites = { "MANA_REGEN2" },
    cancels = { "BAD_MANA_REGEN1", "BAD_MANA_REGEN2", "BAD_MANA_REGEN3" },
    threshold_requirements = { "THRESH_MANA" },
    types = { "MANA_REGEN" },
    categories = { "MANATOUCHED" },
    enchantments = { "INLINE_ENCH_MANA_REGEN_MANATOUCHED_0" },
}

ccb.content.define_mutation {
    id = "MANA_MULT_MANATOUCHED",
    name = ccb.content.text("Manatouched Mana Sensitivity"),
    points = 10,
    description = ccb.content.text("You can sense the mana in your body much better than normal, allowing you to tap into more of your reserves."),
    cancels = { "BAD_MANA_MULT1", "BAD_MANA_MULT2", "BAD_MANA_MULT3" },
    threshold_requirements = { "THRESH_MANA" },
    types = { "MANA_MULT" },
    categories = { "MANATOUCHED" },
    prerequisites = { "MANA_MULT3" },
    enchantments = { "INLINE_ENCH_MANA_MULT_MANATOUCHED_0" },
}

ccb.content.define_mutation {
    id = "BADBACK",
    copy_from = "BADBACK",
    add = { categories = { "MANATOUCHED", "SPECIES_RAVENFOLK" } },
}

ccb.content.define_mutation {
    id = "LIGHTWEIGHT",
    copy_from = "LIGHTWEIGHT",
    add = { categories = { "MANATOUCHED", "SPECIES_RAVENFOLK" } },
}

ccb.content.define_mutation {
    id = "LIGHT_BONES",
    copy_from = "LIGHT_BONES",
    add = { categories = { "MANATOUCHED", "SPECIES_RAVENFOLK" } },
}

ccb.content.define_mutation { id = "THINSKIN", copy_from = "THINSKIN", add = { categories = { "MANATOUCHED" } } }

ccb.content.define_mutation {
    id = "FASTREADER",
    copy_from = "FASTREADER",
    valid = true,
    add = { categories = { "MANATOUCHED", "SPECIES_RAVENFOLK" } },
}

ccb.content.define_mutation {
    id = "GOODMEMORY",
    copy_from = "GOODMEMORY",
    valid = true,
    add = { categories = { "MANATOUCHED", "SPECIES_LIZARDFOLK", "SPECIES_RAVENFOLK" } },
}

ccb.content.define_mutation {
    id = "LOVES_BOOKS",
    copy_from = "LOVES_BOOKS",
    valid = true,
    add = { categories = { "MANATOUCHED" } },
}

ccb.content.define_mutation { id = "SAVANT", copy_from = "SAVANT", valid = true, add = { categories = { "MANATOUCHED" } } }

ccb.content.define_mutation {
    id = "MORE_PAIN",
    copy_from = "MORE_PAIN",
    valid = true,
    add = { categories = { "MANATOUCHED", "SPECIES_ELF" } },
}
