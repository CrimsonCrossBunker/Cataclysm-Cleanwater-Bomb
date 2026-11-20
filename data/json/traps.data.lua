local ccb = require("ccb")

ccb.content.define_trap {
    id = "tr_inner_cabins_exit_portal",
    name = ccb.content.text("swirling vortex"),
    symbol = "O",
    color = "magenta",
    action = "none",
    visibility = 1000,
    avoidance = 99,
    difficulty = 99,
    trap_radius = 2,
    flags = { "UNDODGEABLE", "AVATAR_ONLY", "CONSUME_ON_TRIGGER" },
    always_invisible = true,
    trigger_handler = "step_out_of_inner_cabins",
}

ccb.content.define_trap {
    id = "tr_string_dimension_ka_moonpool",
    name = ccb.content.text("strange moonpool"),
    symbol = "~",
    color = "blue",
    action = "none",
    visibility = 1000,
    avoidance = 99,
    difficulty = 99,
    trap_radius = 2,
    flags = { "UNDODGEABLE", "AVATAR_ONLY", "CONSUME_ON_TRIGGER" },
    always_invisible = true,
    trigger_handler = "enter_ka_moonpool",
}

ccb.content.define_trap {
    id = "tr_string_dimension_ka_moonpool_exit",
    name = ccb.content.text("1D plane"),
    symbol = ".",
    color = "blue",
    action = "none",
    visibility = 1000,
    avoidance = 99,
    difficulty = 99,
    trap_radius = 2,
    flags = { "UNDODGEABLE", "AVATAR_ONLY", "CONSUME_ON_TRIGGER" },
    always_invisible = true,
    trigger_handler = "leave_ka_moonpool",
}

ccb.content.define_trap {
    id = "tr_ls_sd_tunnel_portal",
    name = ccb.content.text(" "),
    symbol = "#",
    color = "white",
    action = "none",
    visibility = 1000,
    avoidance = 99,
    difficulty = 99,
    trap_radius = 2,
    flags = { "UNDODGEABLE", "AVATAR_ONLY", "CONSUME_ON_TRIGGER" },
    always_invisible = true,
    trigger_handler = "labyrinth_string_tunnel",
}

ccb.content.define_trap {
    id = "tr_ls_scarlet_tunnel_portal",
    name = ccb.content.text(" "),
    symbol = "#",
    color = "white",
    action = "none",
    visibility = 1000,
    avoidance = 99,
    difficulty = 99,
    trap_radius = 2,
    flags = { "UNDODGEABLE", "AVATAR_ONLY", "CONSUME_ON_TRIGGER" },
    always_invisible = true,
    trigger_handler = "labyrinth_scarlet_tunnel",
}
