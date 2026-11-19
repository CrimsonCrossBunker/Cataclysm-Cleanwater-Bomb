local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "communal_shower",
    layout = {
        item_groups = { L = { { group = "locker_gym", chance = 50, repetitions = 3 } } },
        palettes = { "base" },
        furniture = { s = "f_shower", L = "f_locker" },
        terrain = { ["."] = "t_linoleum_white" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "11x11_communal_showers_n",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "####+#+####",
            "#s.#.#.#.s#",
            "##.#.#.#.##",
            "#s.#.#.#.s#",
            "##.#.#.#.##",
            "#s.#.#.#.s#",
            "##.#.#.#.##",
            "#..#.#.#..#",
            "#....#....#",
            "#LLLL#LLLL#",
            "###########",
        },
        palettes = { "communal_shower" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "11x11_communal_showers_n",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "####+#+####",
            "#s.#.#.#.s#",
            "#s.#.#.#.s#",
            "#s.#.#.#.s#",
            "#s.#.#.#.s#",
            "#s.#.#.#.s#",
            "#s.#.#.#.s#",
            "#s.#.#.#.s#",
            "#....#....#",
            "#LLLL#LLLL#",
            "###########",
        },
        palettes = { "communal_shower" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "11x11_communal_showers_e",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "###########",
            "#L..#s#s#s#",
            "#L........#",
            "#L.########",
            "#L........+",
            "###########",
            "#L........+",
            "#L.########",
            "#L........#",
            "#L..#s#s#s#",
            "###########",
        },
        palettes = { "communal_shower" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "11x11_communal_showers_e",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "###########",
            "#L.sssssss#",
            "#L........#",
            "#L.########",
            "#L........+",
            "###########",
            "#L........+",
            "#L.########",
            "#L........#",
            "#L.sssssss#",
            "###########",
        },
        palettes = { "communal_shower" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "11x11_communal_showers_s",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "###########",
            "#LLLL#LLLL#",
            "#....#....#",
            "#..#.#.#..#",
            "##.#.#.#.##",
            "#s.#.#.#.s#",
            "##.#.#.#.##",
            "#s.#.#.#.s#",
            "##.#.#.#.##",
            "#s.#.#.#.s#",
            "####+#+####",
        },
        palettes = { "communal_shower" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "11x11_communal_showers_s",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "###########",
            "#LLLL#LLLL#",
            "#....#....#",
            "#s.#.#.#.s#",
            "#s.#.#.#.s#",
            "#s.#.#.#.s#",
            "#s.#.#.#.s#",
            "#s.#.#.#.s#",
            "#s.#.#.#.s#",
            "#s.#.#.#.s#",
            "####+#+####",
        },
        palettes = { "communal_shower" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "11x11_communal_showers_w",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "###########",
            "#s#s#s#..L#",
            "#........L#",
            "########.L#",
            "+........L#",
            "###########",
            "+........L#",
            "########.L#",
            "#........L#",
            "#s#s#s#..L#",
            "###########",
        },
        palettes = { "communal_shower" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "11x11_communal_showers_w",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "###########",
            "#sssssss.L#",
            "#........L#",
            "########.L#",
            "+........L#",
            "###########",
            "+........L#",
            "########.L#",
            "#........L#",
            "#sssssss.L#",
            "###########",
        },
        palettes = { "communal_shower" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}
