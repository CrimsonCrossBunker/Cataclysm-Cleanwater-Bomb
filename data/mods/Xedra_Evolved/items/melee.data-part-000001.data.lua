local ccb = require("ccb")

ccb.content.define_spell {
    id = "distant_thunder",
    name = ccb.content.text("Distant Thunder"),
    description = ccb.content.text("Sparks zap at your opponent."),
    valid_targets = { "hostile" },
    flags = { "NO_HANDS", "NO_LEGS" },
    damage_type = "electric",
    min_damage = 8,
    min_range = 1,
    shape = "blast",
    effect = "attack",
}
