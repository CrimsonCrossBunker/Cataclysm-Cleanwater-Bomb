local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "lava_bomb_heat",
    name = ccb.content.text_without_extraction("Lava Bomb Heat"),
    description = ccb.content.text_without_extraction("This is a sub spell for the Lava Bomb spell."),
    flags = { "EVOCATION_SPELL", "RANDOM_DAMAGE", "SPLIT_DAMAGE" },
    effect = "attack",
    shape = "blast",
    valid_targets = { "hostile", "ally", "self", "ground" },
    damage_type = "heat",
    max_level = 35,
    min_damage = { handler = "scaled_lava_bomb_heat_min_damage", fallback = 1.0 },
    max_damage = { handler = "scaled_lava_bomb_heat_max_damage", fallback = 5.0 },
    min_aoe = 3,
    max_aoe = 5,
    aoe_increment = 0.1,
}
