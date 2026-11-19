local ccb = require("ccb")

ccb.content.define_vehicle {
    id = "magic_motorcycle",
    name = ccb.content.text("Mojocycle"),
    blueprint = { "o#>o" },
    mounts = {
        { x = 0, y = 0, parts = { "frame#vertical_2", "saddle#motor", "motorcycle_kickstand" } },
        { x = 1, y = 0, parts = { "frame_handle" } },
        { x = -1, y = 0, parts = { "frame#vertical", "wheel_mount_light", "wheel_motorbike" } },
        { x = 2, y = 0, parts = { "frame#vertical", "wheel_mount_light_steerable", "wheel_motorbike" } },
        { x = 0, y = 0, parts = { "controls_technomancer", "controls_electronic", "vehicle_alarm" } },
        { x = 0, y = 0, parts = { "horn_car", "engine_vtwin_magic", "alternator_motorbike" } },
        { x = 1, y = 0, parts = { "headlight", "battery_motorbike" } },
        { x = -1, y = 0, parts = { "muffler", "box" } },
    },
}

ccb.content.define_vehicle {
    id = "magic_comcycle",
    copy_from = "magic_motorcycle",
    name = ccb.content.text("Co-op cycle"),
    blueprint = { { "o#>o" }, { " #> " } },
    mounts = {
        { x = 0, y = 1, parts = { "frame#cross", "wheel_mount_light", "wheel_motorbike", "seat" } },
        { x = 1, y = 1, parts = { "frame_handle", "box" } },
    },
}
