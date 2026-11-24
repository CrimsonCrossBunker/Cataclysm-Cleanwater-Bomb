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

ccb.content.define_spell {
    id = "classless_specific_concentration_end",
    skill = "metaphysics",
    shape = "blast",
    name = "[Ψ]Stop Concentrating (Individual)",
    description = "End your concentration on a specific power.\n\nChanneling this power <color_green>always succeeds</color>.",
    message = "You stop concentrating on one of your powers.",
    teachable = false,
    flags = { "PSIONIC", "NO_FAIL", "NON_MAGICAL", "SILENT", "NO_HANDS", "NO_LEGS" },
    valid_targets = { "self" },
    energy_source = "STAMINA",
    base_energy_cost = 0,
    max_level = 1,
    base_casting_time = 0,
    impact_handler = "w16b_sp_imp_mindovermatter_8b449923af60",
}
