local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "house_quiverfull" },
    layout = {
        rows = {
            "....----p...........YYY.",
            ".####**####oo##########.",
            ".#sEL   H|S  Q| hffh 6#.",
            ".#E     H|t  B| hffh 6#.",
            "%#      H|y  B| hffh 6#.",
            "%or     H|8  8| hffh 7#.",
            "%or      ||+||| hffh F#^",
            "%or     E|R  y|   h  F#.",
            "%#       +    +      O#.",
            ".#     |||R  R|J     5o.",
            ".#HHsHH|>    R|n     4o.",
            ".#|||||| |R  R|JJé 123#.",
            ".#q+          ||||+|||#.",
            ".#q+          +      d#.",
            ".#||+|||||||+||D    @@o.",
            ".#d   d@d@d@ T|I    @@o.",
            ".#@@   @ @ @  |Ih    d#.",
            ".#d           |IrRR   #.",
            ".#@@        @@||||||+|#.",
            ".#d          d|BB8Q  Q#.",
            ".#@@   h h  @@|t      #.",
            ".#     IIII  d|S   8BB#.",
            ".####oo#########oo#####.",
            "...%%%%%.....^..........",
        },
        palettes = { "domestic_general_and_variant_palette" },
        terrain = {
            Y = "t_region_groundcover_urban",
            ["%"] = {
                { id = "t_region_shrub" },
                { id = "t_region_shrub_fruit" },
                { id = "t_region_shrub_decorative" },
            },
        },
        fill_terrain = "t_floor",
        nested = {
            { id = "rolling_trash_can_1x1", x = 2, y = 0 },
            { id = "rolling_trash_can_1x1", x = 3, y = 0 },
        },
        loot_placements = {
            { id = "american_flag", x = { 2, 2 }, y = { 5, 5 }, chance = 100 },
            { group = "book_house_quiverfull_bible", x = { 2, 2 }, y = { 6, 6 }, chance = 100 },
            { id = "quiver_large", x = { 2, 2 }, y = { 7, 7 }, chance = 100 },
        },
        monster_group_placements = {
            { group = "GROUP_ZOMBIE", x = { 2, 21 }, y = { 2, 21 }, chance = 2 },
            { group = "GROUP_QUIVERFULL", x = { 2, 14 }, y = { 15, 21 }, chance = 1 },
        },
        vehicle_placements = {
            { id = "tricycle", x = 10, y = 8, chance = 50, status = 0 },
            { id = "tricycle", x = 4, y = 21, chance = 50, status = 0 },
        },
    },
}
