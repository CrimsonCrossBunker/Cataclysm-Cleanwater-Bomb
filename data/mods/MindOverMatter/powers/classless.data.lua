local ccb = require("ccb")

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
