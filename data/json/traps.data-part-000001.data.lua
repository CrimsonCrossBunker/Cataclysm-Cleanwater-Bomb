local ccb = require("ccb")

-- netherum labyrinth trap that takes you out of the dungeon when you fall into a chasm
ccb.content.define_trap {
    id = "tr_nl_chasm",
    name = ccb.content.text("sparkling chasm"),
    color = "dark_gray",
    visibility = 1000,
    always_invisible = true,
    action = "none",
    extend_flags = { "CONSUME_ON_TRIGGER" },
    trigger_handler = "trigger_labyrinth_chasm",
    copy_from = "tr_swirling_vortex",
}
