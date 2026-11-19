local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "lava_bomb_ter",
    name = ccb.content.text_without_extraction("Lava Bomb Terrain"),
    description = ccb.content.text_without_extraction("This is a sub spell for the Lava Bomb spell."),
    effect = "ter_transform",
    effect_data = "lava_bomb",
    shape = "blast",
    max_level = 35,
    min_aoe = 0,
    max_aoe = 2,
    aoe_increment = 0.15,
    valid_targets = { "hostile", "ally", "self", "ground" },
}
