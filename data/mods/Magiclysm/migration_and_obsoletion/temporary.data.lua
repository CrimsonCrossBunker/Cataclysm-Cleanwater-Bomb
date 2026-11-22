local ccb = require("ccb")

ccb.content.define_spell {
    id = "druid_raven_form_fly_upward",
    skill = "deduction",
    shape = "blast",
    name = "(Raven Form) Ascend",
    description = "Flap your wings and fly upward.",
    message = "",
    teachable = false,
    flags = { "NO_HANDS", "NO_LEGS", "NON_MAGICAL", "SILENT", "NO_FAIL" },
    valid_targets = { "self" },
    base_casting_time = 75,
    impact_handler = "w16b_sp_imp_magiclysm_1289c8fc51e9",
}
