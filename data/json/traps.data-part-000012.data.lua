local ccb = require("ccb")

ccb.content.define_trap {
    id = "tr_nl_stairs_1_to_2",
    name = ccb.content.text("mysterious staircase"),
    symbol = "#",
    color = "white",
    action = "none",
    visibility = 1000,
    avoidance = 99,
    difficulty = 99,
    trap_radius = 2,
    flags = { "UNDODGEABLE", "AVATAR_ONLY", "CONSUME_ON_TRIGGER" },
    always_invisible = true,
    trigger_handler = "labyrinth_stairs_down",
}

ccb.content.define_trap {
    id = "tr_nl_stairs_2_to_1",
    name = ccb.content.text("mysterious staircase"),
    symbol = "#",
    color = "white",
    action = "none",
    visibility = 1000,
    avoidance = 99,
    difficulty = 99,
    trap_radius = 2,
    flags = { "UNDODGEABLE", "AVATAR_ONLY", "CONSUME_ON_TRIGGER" },
    always_invisible = true,
    trigger_handler = "labyrinth_stairs_up",
}

ccb.content.define_trap {
    id = "tr_lixa_fall_down",
    symbol = "#",
    name = ccb.content.text("open air"),
    color = "dark_gray",
    action = "none",
    visibility = 1000,
    avoidance = 99,
    difficulty = 99,
    trap_radius = 2,
    flags = { "UNDODGEABLE", "AVATAR_ONLY", "CONSUME_ON_TRIGGER" },
    always_invisible = true,
    trigger_handler = "lixa_step_off_ledge",
}

ccb.content.define_trap {
    id = "tr_lixa_climbing_fall_down",
    symbol = "#",
    name = ccb.content.text("open air"),
    color = "dark_gray",
    action = "none",
    visibility = 1000,
    avoidance = 99,
    difficulty = 99,
    trap_radius = 2,
    flags = { "UNDODGEABLE", "AVATAR_ONLY", "CONSUME_ON_TRIGGER" },
    always_invisible = true,
    trigger_handler = "lixa_lose_grip",
}
