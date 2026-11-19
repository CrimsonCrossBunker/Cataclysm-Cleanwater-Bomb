local ccb = require("ccb")

-- monster holding cell
ccb.content.define_mapgen {
    kind = "nested",
    id = "mi-go_encampment1_room14",
    weight = 1000000,
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            ".|||..",
            "|| +..",
            "|##|||",
            "|1  P|",
            "|  1||",
            "|||||;",
        },
        palettes = { "mi-go_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        monster_group_placements = { { group = "GROUP_ZOMBIE", x = { 1, 3 }, y = { 3, 4 }, repetitions = { 1, 2 } } },
    },
}
