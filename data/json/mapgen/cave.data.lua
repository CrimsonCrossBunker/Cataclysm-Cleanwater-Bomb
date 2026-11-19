local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "nest_rock_roof",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "%",
        },
        terrain = { ["%"] = "t_rock_floor_no_roof" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "nest_region_groundcover_forest",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "%",
        },
        terrain = { ["%"] = "t_region_groundcover_forest" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "nest_rock_wall_roof",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "%",
        },
        terrain = { ["%"] = "t_rock" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { id = "nest_rock_roof", x = 0, y = 0, z = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "nest_rock_floor_roof",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "%",
        },
        terrain = { ["%"] = "t_rock_floor" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { id = "nest_rock_roof", x = 0, y = 0, z = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "nest_region_soil_rock_roof",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "%",
        },
        terrain = { ["%"] = "t_region_soil" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { id = "nest_rock_roof", x = 0, y = 0, z = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "nest_slope_down_rock_roof",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "%",
        },
        terrain = { ["%"] = "t_slope_down" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { id = "nest_rock_roof", x = 0, y = 0, z = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "cave_rat_underground" },
    layout = {
        rows = {
            "1...........2...........",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........... ............",
            "........... ............",
            "........... ............",
            "......     >............",
            "3...........4...........",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "......................  ",
            "...................... <",
        },
        terrain = {
            ["."] = "t_soil",
            [" "] = "t_dirt_underground",
            [">"] = "t_slope_up",
            ["<"] = "t_slope_down",
        },
        furniture = {},
        fill_terrain = "t_dirt_underground",
        rotation = { 0, 3 },
        nested_glyphs = {
            ["1"] = { id = "cave_nw" },
            ["2"] = { id = "cave_ne" },
            ["3"] = { id = "cave_sw" },
            ["4"] = { id = "cave_se" },
        },
    },
}
