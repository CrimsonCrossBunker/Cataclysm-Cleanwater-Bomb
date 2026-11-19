local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "ravine",
    layout = {
        nested_glyphs = {
            ["#"] = {
                { levels = { 0 }, id = "1x1_ground" },
                { levels = { -1 }, id = "1x1_under_soil" },
                { levels = { -2 }, id = "1x1_under_stone" },
            },
            [" "] = { levels = { 0 }, id = "1x1_open_air" },
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "ravine_straight_parameters",
    layout = {
        parameters = {
            variant = {
                value_type = "nested_mapgen",
                default = { weighted = { "24x24_ravine_straight_v1", "24x24_ravine_straight_v2" } },
                scope = "map_stack",
            },
        },
    },
}
