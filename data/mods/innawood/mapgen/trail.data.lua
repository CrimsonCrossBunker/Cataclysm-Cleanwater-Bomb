local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = "forest_trail_end",
    layout = {
        fallback_predecessor_mapgen = "forest_thick",
        nested = {
            {
                choices = {
                    { id = "24x24_forest_trail_end_basic", weight = 3 },
                    { id = "24x24_forest_trail_end_spread", weight = 3 },
                    { id = "24x24_forest_trail_end_split", weight = 3 },
                    { id = "24x24_forest_trail_intersection_inna", weight = 1 },
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "forest_trail_tee",
    layout = {
        fallback_predecessor_mapgen = "forest_thick",
        nested = {
            {
                choices = {
                    { id = "24x24_forest_trail_tee_basic", weight = 2 },
                    { id = "24x24_forest_trail_tee_split", weight = 3 },
                    { id = "24x24_forest_trail_intersection_inna", weight = 1 },
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "forest_trail_four_way",
    layout = {
        fallback_predecessor_mapgen = "forest_thick",
        nested = {
            {
                choices = {
                    "24x24_forest_trail_four_way_basic", "24x24_forest_trail_four_way_high_low",
                    "24x24_forest_trail_intersection_inna",
                },
                x = 0,
                y = 0,
            },
        },
    },
}

-- For placing the intersection as part of a special
ccb.content.define_mapgen {
    kind = "overmap",
    id = "forest_trail_intersection",
    layout = {
        predecessor_mapgen = "forest_thick",
        nested = { { id = "24x24_forest_trail_intersection_inna", x = 0, y = 0 } },
    },
}
