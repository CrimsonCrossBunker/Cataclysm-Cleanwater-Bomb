local ccb = require("ccb")

ccb.content.define_ascii_art {
    id = "light_minus_atomic_battery_cell",
    lines = { "<color_light_green>()" },
}

ccb.content.define_ascii_art {
    id = "light_atomic_battery_cell",
    lines = {
        "<color_light_green>╓<color_light_gray>▬</color>╖",
        "╠<color_white>L</color>╣",
        "<color_light_gray>╙─╜",
    },
}

ccb.content.define_ascii_art {
    id = "medium_atomic_battery_cell",
    lines = { "<color_red>,<color_dark_gray>/]===__", "|<color_light_green>< MP  ></color>|", "'───────'" },
}
