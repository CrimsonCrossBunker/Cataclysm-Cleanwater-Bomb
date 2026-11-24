local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_spaceship_kitchenette",
    name = ccb.content.text("habitat kitchenette"),
    symbol = "#",
    looks_like = "f_oven",
    description = ccb.content.text("A tiny cooking surface only big enough to fit an induction top, placed above and below many integrated storage units.  The minimal space in which you could technically cook."),
    color = "blue",
    move_cost_mod = -1,
    coverage = 55,
    required_strength = -1,
    flags = {
        "FLAMMABLE_ASH",
        "USABLE_FIRE",
        "CONTAINER",
        "PLACE_ITEM",
        "ORGANIC",
        "MOUNTABLE",
        "FLAT_SURF",
        "NO_SELF_CONNECT",
    },
    connect_groups = "COUNTER",
    connects_to = "COUNTER",
    deconstruct = {
        drops = {
            { item = "plastic_chunk", count = 3 },
            { item = "rigid_plastic_sheet", count = 1 },
            { item = "polycarbonate_sheet", count = { 2, 8 } },
        },
    },
}

ccb.content.define_furniture {
    id = "f_your_ship_panel",
    looks_like = "f_security_panel",
    name = ccb.content.text("control panel"),
    symbol = "e",
    description = ccb.content.text("A slim wall mounted metal panel with several buttons, sliders, and displays.  Can be used to control secondary systems of the ship."),
    color = "blue",
    move_cost_mod = 1,
    required_strength = -1,
    flags = { "TRANSPARENT" },
    examine_handler = "examine_f_your_ship_panel",
}

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
