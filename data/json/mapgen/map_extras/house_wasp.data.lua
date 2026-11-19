local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_house_wasp",
    layout = {
        nested = {
            { id = "3x3_wasp_pod", x = { 1, 20 }, y = { 1, 20 } },
            { id = "3x3_wasp_pod", x = { 1, 20 }, y = { 1, 20 } },
            { id = "3x3_wasp_pod", x = { 1, 20 }, y = { 1, 20 } },
            { id = "3x3_wasp_pod", x = { 1, 20 }, y = { 1, 20 } },
            { id = "3x3_wasp_pod", x = { 1, 20 }, y = { 1, 20 } },
            { id = "3x3_wasp_pod", x = { 1, 20 }, y = { 1, 20 } },
            { id = "3x3_wasp_pod", x = { 1, 20 }, y = { 1, 20 } },
            { id = "3x3_wasp_pod", x = { 1, 20 }, y = { 1, 20 } },
            { choices = { "3x3_wasp_pod", "null" }, x = { 1, 20 }, y = { 1, 20 } },
            { choices = { "3x3_wasp_pod", "null" }, x = { 1, 20 }, y = { 1, 20 } },
            { choices = { "3x3_wasp_pod", "null" }, x = { 1, 20 }, y = { 1, 20 } },
            { choices = { "3x3_wasp_pod", "null" }, x = { 1, 20 }, y = { 1, 20 } },
        },
        nested_glyphs = {
            [" "] = {
                {
                    choices = { { id = "null", weight = 2 }, { id = "1x1_remove_window", weight = 1 } },
                },
                {
                    choices = { { id = "null", weight = 7 }, { id = "1x1_wall_to_paper", weight = 1 } },
                },
            },
        },
        transform_glyphs = { [" "] = { id = "remove_door" } },
        monster_placements = { { group = "GROUP_WASP_QUEEN", x = { 0, 23 }, y = { 0, 23 } } },
        monster_group_placements = { { group = "GROUP_DERMATIK", chance = 20, x = 22, y = 22, density = 0.1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_remove_window",
    layout = {
        size = { width = 1, height = 1 },
        transform_placements = { { id = "remove_window", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_wall_to_paper",
    layout = {
        size = { width = 1, height = 1 },
        transform_placements = { { id = "wall_to_paper", x = 0, y = 0 } },
    },
}
