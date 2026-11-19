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

ccb.content.define_mapgen {
    kind = "nested",
    id = "mi-go_scout_tower_cells",
    weight = 1000000,
    layout = {
        size = { width = 18, height = 18 },
        rows = {
            "vvvvvvvv||vvvvvvvv",
            "vvvvvv||||||vvvvvv",
            "vvvv|||PPPP|||vvvv",
            "vv|||PP    #1|||vv",
            "|||VP  i   ### ||v",
            "|<       P   #2 |v",
            "|>  TnT    i ###||",
            ".|i nnn        #3|",
            ".|i nnn &      # |",
            ".|  TnT      ###||",
            "||        i  #4 |v",
            "|P    P ###  ###|v",
            "|  i    # ####5||v",
            "|||VPPP #7#6 |||vv",
            "..||||||||# ||vvvv",
            ".||vvvvvv||||vvvvv",
            ".vvv..............",
            "..................",
        },
        palettes = { "mi-go_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        npc_glyphs = {
            ["1"] = { id = "mi-go_prisoner" },
            ["2"] = { id = "mi-go_prisoner" },
            ["3"] = { id = "mi-go_prisoner" },
            ["4"] = { id = "mi-go_prisoner" },
            ["6"] = { id = "mi-go_prisoner" },
            ["7"] = { id = "mi-go_prisoner" },
        },
    },
}
