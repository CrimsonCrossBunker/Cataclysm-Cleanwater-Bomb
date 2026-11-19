local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_spaceship_fridge",
    name = ccb.content.text("fridge"),
    description = ccb.content.text("A compact refrigerator and freezer unit.  Its plugged into a ship's power supply, so it should be expected to work for a very long time."),
    looks_like = "f_fridge",
    move_cost_mod = -1,
    required_strength = -1,
    flags = { "FLAMMABLE_ASH", "CONTAINER", "SUPPORTS_ROOF", "PLACE_ITEM", "NO_SPOIL" },
    symbol = "O",
    color = "white",
}

ccb.content.define_furniture {
    id = "f_landing_hydraulic",
    name = ccb.content.text("hydraulic cylinder"),
    description = ccb.content.text("A large cylindrical actuator that extends and retracts the landing gear of the ship."),
    symbol = "I",
    looks_like = "t_sewage_pipe",
    color = "yellow",
    move_cost_mod = 2,
    required_strength = -1,
    flags = { "TRANSPARENT", "NOITEM", "PERMEABLE", "THIN_OBSTACLE" },
}

ccb.content.define_furniture {
    id = "f_landing_skid",
    name = ccb.content.text("landing skid"),
    description = ccb.content.text("Retractable landing gear for a spaceship, hydraulically actuated and designed to absorb the impact of landing."),
    symbol = "f",
    color = "light_cyan",
    move_cost_mod = 10,
    coverage = 80,
    required_strength = -1,
    looks_like = "t_column",
}
