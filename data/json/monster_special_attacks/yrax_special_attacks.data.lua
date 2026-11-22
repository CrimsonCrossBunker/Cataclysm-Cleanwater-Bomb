local ccb = require("ccb")

ccb.content.define_spell {
    id = "quadraphract_control",
    shape = "blast",
    name = ccb.content.text_without_extraction("Quadraphract control"),
    description = ccb.content.text_without_extraction("Quadraphracts control themselves using this one."),
    message = "",
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "self" },
    min_range = 1,
    max_range = 1,
    impact_handler = "w16b_sp_imp_dda_9666e364e037",
}
