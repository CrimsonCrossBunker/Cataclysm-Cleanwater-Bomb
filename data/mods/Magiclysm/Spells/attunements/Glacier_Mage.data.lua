local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "frozen_winds_push",
    name = ccb.content.text_without_extraction("Frozen Winds Push Effect"),
    description = ccb.content.text_without_extraction("This is the push effect portion of the Frozen Winds spell."),
    effect = "directed_push",
    shape = "line",
    flags = { "EVOCATION_SPELL" },
    valid_targets = { "hostile", "ground" },
    max_level = 35,
    min_damage = 3,
    max_damage = 5,
    damage_increment = 0.07,
    min_aoe = 3,
    max_aoe = 6,
    aoe_increment = 0.1,
    min_range = 12,
    max_range = 24,
    range_increment = 0.5,
    spell_class = "GLACIER_MAGE",
}
