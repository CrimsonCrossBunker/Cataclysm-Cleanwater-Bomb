local ccb = require("ccb")

ccb.content.define_spell {
    id = "yellow_maintenance_check",
    shape = "line",
    name = ccb.content.text_without_extraction("Ocher Maintenance Badge Trait"),
    description = ccb.content.text_without_extraction("Adds trait for badge check."),
    message = "the drone scans for your ID badge.",
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "hostile" },
    min_damage = 10000,
    max_damage = 10000,
    min_range = 15,
    max_range = 15,
    max_level = 1,
    impact_handler = "w16b_sp_imp_dda_3d7c5813cf5e",
}
