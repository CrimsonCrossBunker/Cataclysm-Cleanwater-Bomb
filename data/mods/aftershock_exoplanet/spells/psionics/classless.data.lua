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

ccb.content.define_spell {
    id = "afs_classless_toggleable_concentration_end",
    skill = "metaphysics",
    shape = "blast",
    magic_type = "aftershock_psionics",
    name = "[Ψ]Stop Concentrating",
    description = "End your concentration on all of your maintained powers.\n\nChanneling this power <color_green>always succeeds</color>.",
    message = "You stop concentrating.",
    teachable = false,
    flags = { "PSIONIC", "NO_FAIL", "SILENT", "NO_HANDS", "NO_LEGS" },
    valid_targets = { "self" },
    base_energy_cost = 0,
    max_level = 1,
    base_casting_time = 0,
    impact_handler = "w16b_sp_imp_aftershock_exoplanet_c9857e9c31c8",
}
