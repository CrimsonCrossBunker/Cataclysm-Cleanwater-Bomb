local ccb = require("ccb")

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
