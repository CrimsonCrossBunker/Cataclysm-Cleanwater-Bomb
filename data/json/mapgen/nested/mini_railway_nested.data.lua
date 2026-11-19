local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "trolley_problem",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "*****",
            ".....",
            ".....",
            "==*==",
            ".....",
        },
        terrain = {
            ["."] = "t_region_groundcover_urban",
            ["*"] = "t_railroad_track_small",
            ["="] = "t_railroad_track_small",
        },
        item_spawns = { ["*"] = { id = "talking_doll", chance = 100 } },
    },
}
