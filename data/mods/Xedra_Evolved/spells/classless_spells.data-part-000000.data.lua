local ccb = require("ccb")

ccb.content.define_magic_type {
    id = "xedra_magic_generic",
    energy_source = "MANA",
}

ccb.content.define_magic_type {
    id = "xedra_dream_magic",
    energy_source = "MANA",
    get_level_formula = "xedra_dream_formula_get_level",
    exp_for_level_formula = "xedra_dream_formula_exp_for_level",
    casting_xp_formula = "xedra_dream_casting_xp_formula",
    failure_cost_fraction = 0.1,
    failure_experience_fraction = 1,
    max_book_level = 0,
}
