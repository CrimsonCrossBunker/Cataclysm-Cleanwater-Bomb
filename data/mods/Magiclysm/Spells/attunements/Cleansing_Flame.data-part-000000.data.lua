local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "immolate_transform",
    name = ccb.content.text_without_extraction("Immolate Transform"),
    description = ccb.content.text_without_extraction("The part of the Immolate spell that causes the transform."),
    valid_targets = { "ally", "hostile", "ground" },
    effect = "ter_transform",
    effect_data = "immolate_transform",
    shape = "blast",
    min_aoe = 3,
    max_aoe = 5,
    aoe_increment = 0.07,
}
