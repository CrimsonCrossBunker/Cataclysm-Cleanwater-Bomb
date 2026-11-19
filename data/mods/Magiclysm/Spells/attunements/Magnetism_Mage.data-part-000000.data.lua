local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "railgun_sparks",
    name = ccb.content.text_without_extraction("Railgun Sparks"),
    description = ccb.content.text_without_extraction("The spark portion of the Railgun spell."),
    valid_targets = { "ground", "hostile", "ally" },
    effect = "attack",
    shape = "line",
    min_aoe = 3,
    max_aoe = 3,
    field = "fd_electricity",
    min_field_intensity = 1,
    max_field_intensity = 1,
    field_chance = 2,
}
