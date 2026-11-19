local ccb = require("ccb")

ccb.content.define_mutation {
    id = "ARVORE_MIND_CONTROL_POLLEN_ON",
    name = ccb.content.text_without_extraction("Enchanting Aroma (active)"),
    points = 4,
    visibility = 0,
    ugliness = -8,
    description = ccb.content.text_without_extraction("The active version of Enchanting Aroma.  Should not be player visible."),
    categories = { "ARVORE" },
    purifiable = false,
    threshold_requirements = { "THRESH_ARVORE" },
    scent_type = "sc_flower",
    scent_intensity = 1200,
    social_modifiers = { persuade = 25, lie = 10 },
    valid = false,
    player_display = false,
}

ccb.content.define_mutation {
    id = "ARVORE_HEAL_LIMB_REGEN",
    name = ccb.content.text("Leaves Return When Winter Ends"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("When in wild areas, you can draw on the revitalizing power of the land to heal yourself.  When in natural areas, your limbs will heal much faster."),
    prerequisites = { "ARVORE_SKIN_2", "ARVORE_SKIN_3" },
    secondary_prerequisites = { "ARVORE_VERDANT_INFUSION" },
    categories = { "ARVORE" },
    purifiable = false,
    threshold_requirements = { "THRESH_ARVORE" },
    types = { "HEALING" },
    flags = { "MEND_ALL" },
    enchantments = { "ench_arvore_wilds_super_mending" },
}
