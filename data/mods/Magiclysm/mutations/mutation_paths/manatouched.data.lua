local ccb = require("ccb")

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
