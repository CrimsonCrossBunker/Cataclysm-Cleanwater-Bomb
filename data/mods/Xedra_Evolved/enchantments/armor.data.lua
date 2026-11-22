local ccb = require("ccb")

ccb.content.define_spell {
    id = "increase_berserking",
    shape = "blast",
    name = ccb.content.text_without_extraction("Berserking"),
    description = ccb.content.text_without_extraction("Increase the berserker variable."),
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "self" },
    impact_handler = "w16b_sp_imp_xedra_evolved_3bcfc4664182",
}
