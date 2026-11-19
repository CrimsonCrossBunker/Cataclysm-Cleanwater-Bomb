local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "abyssal_hunger_palette",
    layout = {
        terrain = {
            ["0"] = "t_abyssal_flesh_floor",
            ["1"] = "t_abyssal_flesh_wall",
            B = "t_abyssal_brain",
            a = "t_open_air",
        },
        furniture = { T = "f_shard_location" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "abyssal_hunger_roof",
    layout = {
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN", "NO_UNDERLYING_ROTATE" },
        tile_edits = {
            {
                shape = "rectangle",
                operation = "terrain",
                id = "t_abyssal_flesh_roof",
                x = 0,
                y = 0,
                end_x = 23,
                end_y = 23,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "abyssal_hunger_dungeon",
    layout = {
        rows = {
            "111111111111111111111111",
            "100000000000000000000001",
            "100000000000000000000001",
            "100000000000000000000001",
            "100000000000000000000001",
            "100000000000000000000001",
            "100000000000000000000001",
            "100000000000000000000001",
            "100000000000000000000001",
            "100000000000000000000001",
            "100000000000000000000001",
            "100000000000000000000001",
            "100000000000000000000001",
            "100000000000000000000001",
            "100000000000000000000001",
            "100000000000000000000001",
            "100000000000000000000001",
            "100000000000000000000001",
            "100000000000000000000001",
            "100000000000000000000001",
            "100000000000000000000001",
            "100000000000000000000001",
            "100000000000000000000001",
            "111111111111111111111111",
        },
        palettes = { "abyssal_hunger_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN", "NO_UNDERLYING_ROTATE" },
        tile_edits = {
            {
                shape = "rectangle",
                operation = "furniture",
                id = "f_null",
                x = 0,
                end_x = 23,
                y = 0,
                end_y = 23,
            },
            { shape = "point", operation = "remember_position", id = "dungeon_start", x = 1, y = 2 },
            {
                shape = "point",
                operation = "trap",
                id = "tr_abyssal_hunger_next_level",
                x = { 1, 22 },
                y = 22,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "abyssal_hunger_brain",
    layout = {
        rows = {
            "111111111111111111111111",
            "100000000000000000000001",
            "100000000000000000000001",
            "100000000000000000000001",
            "100000000000000000000001",
            "100000000000000000000001",
            "100000000000000000000001",
            "100000000000000000000001",
            "110000000000000000000011",
            "111000000000000000000111",
            "111000000000000000000111",
            "111000000BB00BB000000111",
            "11100000BBB00BBB00000111",
            "11100000BBBTTBBB00000111",
            "11100000BBBBBBBB00000111",
            "11100000BBBBBBBB00000111",
            "11100000BBBBBBBB00000111",
            "111000000BBBBBB000000111",
            "111110000000000000011111",
            "111111111111111111111111",
            "111111111111111111111111",
            "111111111111111111111111",
            "111111111111111111111111",
            "111111111111111111111111",
        },
        palettes = { "abyssal_hunger_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN", "NO_UNDERLYING_ROTATE" },
        tile_edits = {
            {
                shape = "rectangle",
                operation = "furniture",
                id = "f_null",
                x = 0,
                end_x = 23,
                y = 0,
                end_y = 23,
            },
            { shape = "point", operation = "remember_position", id = "dungeon_start", x = 1, y = 2 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "abyssal_hunger_cleanup",
    layout = {
        flags = { "NO_UNDERLYING_ROTATE" },
        tile_edits = {
            {
                shape = "rectangle",
                operation = "remove_items",
                x = 0,
                y = 0,
                end_x = 23,
                end_y = 23,
            },
            {
                shape = "rectangle",
                operation = "remove_trap",
                id = "tr_null",
                x = 0,
                y = 0,
                end_x = 23,
                end_y = 23,
            },
            {
                shape = "rectangle",
                operation = "remove_creatures",
                x = 0,
                y = 0,
                end_x = 23,
                end_y = 23,
            },
        },
    },
}
