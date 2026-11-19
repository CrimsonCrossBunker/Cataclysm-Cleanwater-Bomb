local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = { { "lodge_basement_residential3", "lodge_basement_residential4" } },
    layout = {
        rows = {
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                         ##############         ",
            "                         #__________RR#         ",
            "                         #____________#         ",
            "                         #____________#         ",
            "                         #____________#         ",
            "                         #____________#         ",
            "                         #____________#         ",
            "                         ###______#####         ",
            "                         #<#______#             ",
            "                         #_+______#             ",
            "                         ##########             ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
        },
        palettes = { "standard_domestic_basement_palette" },
        terrain = { _ = "t_carpet_green", R = "t_carpet_green" },
        fill_terrain = "t_soil",
        nested = {
            {
                choices = {
                    { id = "room_6x6_woodworker", weight = 5 },
                    { id = "room_6x6_bike", weight = 15 },
                    { id = "room_6x6_office_E", weight = 5 },
                },
                x = 26,
                y = 10,
            },
        },
    },
}
