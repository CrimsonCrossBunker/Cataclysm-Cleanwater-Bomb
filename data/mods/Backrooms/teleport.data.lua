local ccb = require("ccb")

ccb.content.define_spell {
    id = "prim_warp",
    name = ccb.content.text("Red Room Recall"),
    description = ccb.content.text("Transports the user to a viable landing pad via strange forces."),
    valid_targets = { "self", "ally", "hostile" },
    effect = "translocate",
    shape = "blast",
    difficulty = 0,
    max_level = 25,
    base_casting_time = 9000,
    base_energy_cost = 0,
    energy_source = "STAMINA",
    spell_class = "NONE",
}
