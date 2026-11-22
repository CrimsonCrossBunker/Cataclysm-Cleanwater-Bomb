local ccb = require("ccb")

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
