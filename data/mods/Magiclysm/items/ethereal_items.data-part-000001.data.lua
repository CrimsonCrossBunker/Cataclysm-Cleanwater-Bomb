local ccb = require("ccb")

ccb.content.define_item {
    id = "finger_firelighter",
    name = ccb.content.plural_text("finger firelighter", "finger firelighters"),
    description = ccb.content.text("This is a small flame you can hold in your hand.  With a thought, you can cause it to light something on fire, or you can throw it to ignite something flammable."),
    mass = "1 g",
    volume = "1 ml",
    price = "0 cent",
    symbol = ",",
    color = "red",
    light = 8,
    flags = { "TRADER_AVOID", "FIRESTARTER", "FLAMING", "WATER_EXTINGUISH" },
    tool = {},
    use_actions = { { kind = "firestarter", moves = 20 } },
    drop_action = { kind = "emit_actor", emissions = { "emit_tiny_fire" } },
}

ccb.content.define_item {
    id = "electric_lighter",
    name = ccb.content.plural_text("stable spark", "stable sparks"),
    description = ccb.content.text("Small electric spark, that does not disappear under your force.  With a thought, you can cause it to light something on fire, or you can throw it to ignite something flammable."),
    mass = "1 g",
    volume = "1 ml",
    price = "0 cent",
    symbol = ",",
    color = "yellow",
    light = 8,
    flags = { "TRADER_AVOID", "FIRESTARTER" },
    tool = {},
    use_actions = { { kind = "firestarter", moves = 20 } },
    drop_action = { kind = "emit_actor", emissions = { "emit_tiny_fire" } },
}
