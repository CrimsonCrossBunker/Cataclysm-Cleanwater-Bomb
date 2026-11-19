local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "immolate_push",
    name = ccb.content.text_without_extraction("Immolate Push Effect"),
    description = ccb.content.text_without_extraction("The immolate spell is powerful enough to push targets from its epicenter."),
    effect = "directed_push",
    shape = "blast",
    valid_targets = { "ally", "hostile", "ground" },
    max_level = 35,
    min_damage = 0,
    max_damage = 2,
    damage_increment = 0.07,
    min_aoe = 1,
    max_aoe = 3,
    aoe_increment = 0.07,
    min_range = 4,
    max_range = 8,
    range_increment = 0.12,
}
