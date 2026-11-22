local ccb = require("ccb")

ccb.content.define_spell {
    id = "mon_reflection_revive",
    shape = "blast",
    name = ccb.content.text_without_extraction("Reflection Revive"),
    description = ccb.content.text_without_extraction("Revives the reflection."),
    flags = { "SILENT", "NO_HANDS", "NO_LEGS", "NO_EXPLOSION_SFX" },
    valid_targets = { "self", "ground" },
    min_range = 15,
    max_range = 15,
    max_level = 1,
    base_casting_time = 75,
    impact_handler = "w16b_sp_imp_dda_347de7b10c96",
}
