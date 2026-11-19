local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "bramble_spear_slow",
    name = ccb.content.text_without_extraction("Bramble spear slow"),
    description = ccb.content.text_without_extraction("Sticky sap coats your enemies."),
    valid_targets = { "hostile" },
    flags = { "RANDOM_DAMAGE" },
    shape = "blast",
    effect = "mod_moves",
    min_damage = -25,
    max_damage = -75,
    min_range = 2,
    max_range = 2,
}
