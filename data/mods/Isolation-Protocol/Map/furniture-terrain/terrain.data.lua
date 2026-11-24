local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_iso_chasm",
    name = ccb.content.text("chasm"),
    description = ccb.content.text("The surrounding walls drop into an abyss that sparkles with otherworldly light.  Falling into it would likely mean certain death."),
    symbol = "*",
    looks_like = "t_open_air",
    color = "dark_gray",
    move_cost = -1,
    coverage = 0,
    trap = "tr_iso_chasm",
    flags = { "TRANSPARENT", "EMPTY_SPACE", "DESTROY_ITEM", "NOCOLLIDE", "MON_AVOID_STRICT" },
}

ccb.content.define_terrain {
    id = "t_iso_bossfight_door",
    copy_from = "t_abstract_wall_metal",
    name = ccb.content.text("closed metal door"),
    description = ccb.content.text("A galvanized steel door, forged to withstand punishment and impede anyone or anything.  Typically used in conjunction with automated electronic locking mechanisms that require an external source to unlock."),
    color = "light_gray",
    looks_like = "t_door_metal_locked",
}

ccb.content.define_trap {
    id = "tr_iso_chasm",
    name = ccb.content.text("sparkling chasm"),
    color = "dark_gray",
    copy_from = "tr_swirling_vortex",
    action = "none",
    visibility = 1000,
    always_invisible = true,
    trigger_handler = "fall_into_chasm",
}
