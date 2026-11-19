local ccb = require("ccb")

ccb.content.define_spell {
    id = "blood_tendrils",
    name = ccb.content.text("Blood Tendrils"),
    description = ccb.content.text("Brownish reddish tendrils connect from the club to your enemies."),
    valid_targets = { "hostile" },
    flags = { "NO_HANDS", "NO_LEGS" },
    damage_type = "biological",
    min_damage = 8,
    min_range = 2,
    shape = "blast",
    effect = "attack",
}
