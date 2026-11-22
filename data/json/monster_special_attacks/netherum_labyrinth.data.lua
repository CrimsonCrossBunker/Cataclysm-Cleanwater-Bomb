local ccb = require("ccb")

ccb.content.define_spell {
    id = "nl_phase_goo",
    shape = "blast",
    name = "Nether Phase Goo",
    description = "Phase Goo effect in labyrinthine structures.",
    valid_targets = { "hostile" },
    min_damage = 0,
    max_damage = 0,
    min_range = 0,
    max_range = 25,
    min_aoe = 1,
    max_aoe = 1,
    impact_handler = "w16b_sp_imp_dda_bc131e866afc",
}
