local ccb = require("ccb")

ccb.content.define_spell {
    id = "remove_opponents",
    name = ccb.content.text("Debug Opponent Kill"),
    description = ccb.content.text("."),
    effect = "attack",
    shape = "blast",
    valid_targets = { "hostile" },
    flags = { "NO_LEGS", "PERCENTAGE_DAMAGE" },
    min_damage = 300,
    max_damage = 300,
    min_aoe = 10,
    max_aoe = 10,
    min_range = 0,
    max_range = 0,
    damage_type = "pure",
}
