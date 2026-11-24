local ccb = require("ccb")

-- VORPAL in fact, but with another weight (-250 -> 99)
ccb.content.define_technique {
    id = "DIVIDE",
    name = ccb.content.text("The Great Divide"),
    melee_allowed = true,
    mult_bonuses = { { stat = "damage", damage_type = "cut", scale = 2 } },
    crit_tec = true,
    weighting = 0,
    messages = {
        ccb.content.text("Snicker-snack!  You slice through %s like a hot knife slices through butter"),
        ccb.content.text("Snicker-snack!  <npcname> slices through %s like a hot knife slices through butter"),
    },
    description = ccb.content.text("Cut damage multiply by 2, crit only"),
    attack_vectors = { "vector_null" },
}

ccb.content.define_technique {
    id = "HYBRASIL_ENCHANTMENT",
    name = ccb.content.text("Hy-Brasil Enchantment"),
    melee_allowed = true,
    crit_tec = true,
    skills = { { id = "melee", level = 4 } },
    description = ccb.content.text("Casts different spells on crit depending on user hp."),
    attack_vectors = { "vector_null" },
    on_apply = "hybrasil_rod_spell",
}
