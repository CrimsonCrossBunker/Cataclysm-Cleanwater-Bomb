local ccb = require("ccb")

-- basic basement with a utility room, 2-3 bedrooms, possibly an office, and a large tv/rec room.
ccb.content.define_mapgen {
    kind = "overmap",
    id = "house_04_basement",
    layout = {
        rows = {
            "^^^^^^^^^^^^^^^^^^^^^^^^",
            "^######################^",
            "^#||||||||||||||||||||#^",
            "^#|9..|....CCCNNNUUUU|#^",
            "^#|...+.............U|#^",
            "^#|tCS|.............U|#^",
            "^#||||||...CCCCCCUUUU|#^",
            "^#|....||+|####|||||||#^",
            "^#|....|....<<.......|#^",
            "^#|....+.............|#^",
            "^#|....|.............|#^",
            "^#||||||.............|#^",
            "^#|....|.............|#^",
            "^#|....+.............|#^",
            "^#|....|.............|#^",
            "^#|....|.............|#^",
            "^#||||||.............|#^",
            "^#|....|.............|#^",
            "^#|....+.............|#^",
            "^#|....|.............|#^",
            "^#|....|.............|#^",
            "^#||||||||||||||||||||#^",
            "^######################^",
            "^^^^^^^^^^^^^^^^^^^^^^^^",
        },
        palettes = { "standard_domestic_palette", "standard_domestic_basement_palette" },
        fill_terrain = "t_thconc_floor",
        nested = {
            {
                choices = { { id = "utility_3x3_N", weight = 10 }, { id = "utility_3x3_S", weight = 5 } },
                x = 7,
                y = 3,
            },
            {
                choices = {
                    { id = "bedroom_4x4_adult_1_W", weight = 5 },
                    { id = "bedroom_4x4_adult_3_S", weight = 5 },
                    { id = "home_office_4x4_N", weight = 10 },
                    { id = "home_office_4x4_S", weight = 10 },
                },
                x = 3,
                y = 7,
            },
            {
                choices = {
                    { id = "bedroom_4x4_adult_1_N", weight = 5 },
                    { id = "bedroom_4x4_adult_1_W", weight = 10 },
                    { id = "bedroom_4x4_adult_1_S", weight = 5 },
                    { id = "bedroom_4x4_adult_3_S", weight = 10 },
                    { id = "bedroom_4x4_adult_3_N", weight = 10 },
                },
                x = 3,
                y = 12,
            },
            {
                choices = {
                    { id = "bedroom_4x4_adult_1_N", weight = 5 },
                    { id = "bedroom_4x4_adult_1_W", weight = 10 },
                    { id = "bedroom_4x4_adult_1_S", weight = 5 },
                    { id = "bedroom_4x4_adult_3_S", weight = 10 },
                    { id = "bedroom_4x4_adult_3_N", weight = 10 },
                },
                x = 3,
                y = 17,
            },
            {
                choices = {
                    { id = "recroom_12x12", weight = 5 },
                    { id = "tvroom_12x12", weight = 15 },
                    { id = "workoutroom_12x12", weight = 5 },
                },
                x = 9,
                y = 9,
            },
        },
    },
}
