local ccb = require("ccb")

ccb.content.define_magic_type {
    id = "mom_psionics",
    energy_source = "STAMINA",
    cannot_cast_flags = "NO_PSIONICS",
    cannot_cast_message = ccb.content.text("You can't channel any of the powers you know!"),
    failure_cost_fraction = 0.5,
    failure_experience_fraction = 0.3,
    max_book_level = 0,
    casting_xp_formula = "psionic_power_experience_formula_channeling",
    failure_chance_formula = "psionic_power_success_formula",
}
