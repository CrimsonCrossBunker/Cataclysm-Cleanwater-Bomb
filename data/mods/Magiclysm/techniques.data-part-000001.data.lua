local ccb = require("ccb")

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
