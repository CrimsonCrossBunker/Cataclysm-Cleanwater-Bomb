local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "shipwrecker_push",
    name = ccb.content.text_without_extraction("Shipwrecker Push"),
    description = ccb.content.text_without_extraction("Push monsters around the player.  You can see it only in debug mode."),
    effect = "area_push",
    shape = "cone",
    valid_targets = { "ally", "hostile", "item", "ground" },
    flags = { "EVOCATION_SPELL", "SILENT", "NO_EXPLOSION_SFX" },
    max_level = 25,
    min_aoe = 60,
    max_aoe = 180,
    aoe_increment = 5,
    min_range = 5,
    max_range = 12,
    range_increment = 0.3,
}
