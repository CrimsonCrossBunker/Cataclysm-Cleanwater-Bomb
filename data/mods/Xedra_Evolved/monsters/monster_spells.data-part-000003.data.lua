local ccb = require("ccb")

ccb.content.define_spell {
    id = "solar_spirit_flare_spell_monster",
    shape = "blast",
    name = ccb.content.text_without_extraction("Solar spirit flare"),
    description = ccb.content.text_without_extraction("Unleashes a flare if you are a solar spirit."),
    flags = { "SILENT" },
    valid_targets = { "ground", "hostile" },
    min_aoe = 45,
    max_aoe = 45,
    impact_handler = "w16b_sp_imp_xedra_evolved_ff77be41e4cd",
}
