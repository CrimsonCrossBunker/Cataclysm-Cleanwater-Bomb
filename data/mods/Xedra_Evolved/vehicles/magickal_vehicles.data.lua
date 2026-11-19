local ccb = require("ccb")

ccb.content.define_vehicle {
    id = "wave_rider_kayak",
    name = ccb.content.text("wave rider kayak"),
    blueprint = { { "<O>" } },
    mounts = {
        {
            x = 0,
            y = 0,
            parts = {
                "xlframe#horizontal",
                "seat",
                "wave_rider_engine",
                "carbonfiber_boat_hull",
                "alternator_motorbike",
            },
        },
        { x = 0, y = 0, parts = { "controls", "controls_electronic" } },
        { x = 1, y = 0, parts = { "xlframe#horizontal", "carbonfiber_boat_hull" } },
        { x = -1, y = 0, parts = { "xlframe#horizontal", "carbonfiber_boat_hull", "battery_motorbike" } },
    },
}

ccb.content.define_vehicle {
    id = "arvore_floral_boat",
    name = ccb.content.text("viridescent vessel"),
    blueprint = { { "<O>" } },
    mounts = {
        { x = 0, y = 0, parts = { "floralframe", "floral_engine", "floral_boat_hull", "floral_controls" } },
        { x = 0, y = 1, parts = { "floralframe", "floral_boat_hull" } },
        { x = 0, y = -1, parts = { "floralframe", "floral_boat_hull" } },
        { x = 1, y = 0, parts = { "floralframe", "floral_boat_hull" } },
        { x = 1, y = 1, parts = { "floralframe", "floral_boat_hull" } },
        { x = 1, y = -1, parts = { "floralframe", "floral_boat_hull" } },
        { x = -1, y = 0, parts = { "floralframe", "floral_boat_hull" } },
        { x = -1, y = 1, parts = { "floralframe", "floral_boat_hull" } },
        { x = -1, y = -1, parts = { "floralframe", "floral_boat_hull" } },
    },
}
