local ccb = require("ccb")

ccb.content.define_magic_type {
    id = "xedra_chronomancy_magic",
    energy_source = "MANA",
    get_level_formula = "xedra_chronomancer_formula_get_level",
    exp_for_level_formula = "xedra_chronomancer_formula_exp_for_level",
    casting_xp_formula = "xedra_chronomancer_formula_exp_per_cast",
}
