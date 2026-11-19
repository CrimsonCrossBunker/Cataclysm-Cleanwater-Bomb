local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "SCENARIO_BLOOD",
    layout = {
        field_placements = {
            {
                id = "fd_blood",
                x = { 5, 20 },
                y = { 5, 20 },
                intensity = { 1, 3 },
                repetitions = 10,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "SCENARIO_FIRE",
    layout = {
        field_placements = { { id = "fd_fire", x = { 3, 20 }, y = { 3, 20 }, intensity = { 1, 3 }, repetitions = 15 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "SCENARIO_SMOKE",
    layout = {
        field_placements = {
            {
                id = "fd_smoke",
                x = { 3, 20 },
                y = { 3, 20 },
                intensity = { 1, 3 },
                repetitions = 60,
            },
        },
    },
}
