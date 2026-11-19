local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = "island_forest",
    layout = {
        predecessor_mapgen = "forest",
        nested = {
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "roof_4x4_survivor", weight = 3 },
                    { id = "roof_3x3_wine", weight = 3 },
                    { id = "roof_6x6_survivor", weight = 4 },
                    { id = "small_camp_8x8", weight = 5 },
                    { id = "gone_fishing_3x3", weight = 5 },
                },
                x = { 3, 16 },
                y = { 3, 16 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "island_forest_thick",
    layout = {
        predecessor_mapgen = "forest_thick",
        nested = {
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "roof_4x4_survivor", weight = 3 },
                    { id = "roof_3x3_wine", weight = 3 },
                    { id = "roof_6x6_survivor", weight = 4 },
                    { id = "small_camp_8x8", weight = 5 },
                    { id = "gone_fishing_3x3", weight = 5 },
                },
                x = { 3, 16 },
                y = { 3, 16 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "island_forest_water",
    layout = {
        predecessor_mapgen = "forest_water",
        nested = {
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "roof_4x4_survivor", weight = 3 },
                    { id = "roof_3x3_wine", weight = 3 },
                    { id = "roof_6x6_survivor", weight = 4 },
                    { id = "small_camp_8x8", weight = 5 },
                    { id = "gone_fishing_3x3", weight = 5 },
                },
                x = { 3, 16 },
                y = { 3, 16 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "island_field",
    layout = {
        predecessor_mapgen = "field",
        nested = {
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "roof_4x4_survivor", weight = 3 },
                    { id = "roof_3x3_wine", weight = 3 },
                    { id = "roof_6x6_survivor", weight = 4 },
                    { id = "small_camp_8x8", weight = 5 },
                    { id = "gone_fishing_3x3", weight = 5 },
                },
                x = { 3, 16 },
                y = { 3, 16 },
            },
        },
    },
}
