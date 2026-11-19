local ccb = require("ccb")

ccb.content.define_vehicle {
    id = "oa_work_light",
    name = ccb.content.text("work light"),
    blueprint = { "^" },
    mounts = {
        { x = 0, y = 0, parts = { "xlframe#vertical_2" } },
        { x = 0, y = 0, parts = { "wheel_caster" } },
        { x = 0, y = 0, parts = { "small_storage_battery" } },
        { x = 0, y = 0, parts = { "floodlight" } },
        { x = 0, y = 0, parts = { "controls_electronic" } },
    },
}
