local ccb = require("ccb")

-- Test vehicle for dimensional travel
ccb.content.define_vehicle {
    id = "dimensional_bathyscape",
    name = ccb.content.text("Sir Pemberton Smythe's Dimensional Bathyscape"),
    blueprint = { { "---" }, { "+#|" }, { "---" } },
    mounts = {
        { x = -1, y = -1, parts = { "hdframe", "board", "roof" } },
        { x = -1, y = 0, parts = { "hdframe", { part = "tank", fuel = "gasoline" }, "roof" } },
        { x = -1, y = 1, parts = { "hdframe", "engine_v6", "alternator_car", "roof" } },
        { x = 0, y = -1, parts = { "hdframe", "door", "roof", "battery_car" } },
        { x = 0, y = 0, parts = { "hdframe", "seat", "controls" } },
        { x = 0, y = 1, parts = { "hdframe", "roof", "dimensional_perambulator" } },
        { x = 1, y = -1, parts = { "hdframe", "board", "roof" } },
        { x = 1, y = 0, parts = { "hdframe", "board", "roof" } },
        { x = 1, y = 1, parts = { "hdframe", "board", "roof" } },
    },
}
