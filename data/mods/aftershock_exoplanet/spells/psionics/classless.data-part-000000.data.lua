local ccb = require("ccb")

ccb.content.define_magic_type {
    id = "aftershock_psionics",
    energy_source = "STAMINA",
    cannot_cast_flags = "NO_PSIONICS",
    cannot_cast_message = ccb.content.text("You can't channel any of the powers you know!"),
    failure_cost_fraction = 1,
    on_failure = "psi_channel_failure",
    casting_xp_formula = "psionic_power_experience_formula_channeling",
    failure_chance_formula = "psionic_power_success_formula",
}
