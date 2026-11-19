local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_nm_tube",
    name = ccb.content.text("decaying tube"),
    description = ccb.content.text("A decomposing fleshy stalagmite extends from the ceiling to the floor."),
    looks_like = "f_alien_gasper",
    symbol = "|",
    color = "magenta",
    move_cost_mod = 6,
    coverage = 50,
    required_strength = -1,
    flags = { "TRANSPARENT" },
}

ccb.content.define_furniture {
    id = "f_nm_tube_emitter",
    name = ccb.content.text("glowing decaying tube"),
    description = ccb.content.text("A decomposing fleshy stalagmite extends from the ceiling to the floor.  Countless glowing spores weft from within, coating everything nearby."),
    looks_like = "f_alien_gasper",
    symbol = "|",
    color = "magenta_red",
    move_cost_mod = 6,
    coverage = 50,
    required_strength = -1,
    flags = { "TRANSPARENT" },
    emissions = { "emit_monster_gas_1", "emit_monster_gas_2" },
}
