local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "fbmc_firestation1_palette_white_wall",
    layout = {
        terrain = { ["|"] = "t_wall_w", d = "t_door_c" },
        furniture = { ["|"] = "f_clear", d = "f_clear" },
    },
}

ccb.content.define_mapgen_palette {
    id = "fbmc_firestation1_palette_log",
    layout = {
        terrain = { ["|"] = "t_wall_log", d = "t_door_c" },
        furniture = { ["|"] = "f_clear", d = "f_clear" },
    },
}

ccb.content.define_mapgen_palette {
    id = "fbmc_firestation1_palette_metal",
    layout = {
        terrain = { ["|"] = "t_scrap_wall", d = "t_door_c" },
        furniture = { ["|"] = "f_clear", d = "f_clear" },
    },
}

ccb.content.define_mapgen_palette {
    id = "fbmc_firestation1_palette_migo",
    layout = {
        terrain = { d = "t_door_c", ["|"] = "t_wall_resin" },
        furniture = { ["|"] = "f_clear", d = "f_clear" },
    },
}

ccb.content.define_mapgen_palette {
    id = "fbmc_firestation1_palette_rammed_earth",
    layout = {
        terrain = { d = "t_door_makeshift_c", ["|"] = "t_wall_rammed_earth" },
        furniture = { ["|"] = "f_clear", d = "f_clear" },
    },
}

ccb.content.define_mapgen_palette {
    id = "fbmc_firestation1_palette_rock",
    layout = {
        terrain = { ["|"] = "t_rock_wall", d = "t_door_c" },
        furniture = { ["|"] = "f_clear", d = "f_clear" },
    },
}

ccb.content.define_mapgen_palette {
    id = "fbmc_firestation1_palette_wad",
    layout = {
        terrain = { d = "t_door_makeshift_c", ["|"] = "t_wall_wattle" },
        furniture = { ["|"] = "f_clear", d = "f_clear" },
    },
}

ccb.content.define_mapgen_palette {
    id = "fbmc_firestation1_palette_wood",
    layout = {
        terrain = { ["|"] = "t_wall_wood", d = "t_door_c" },
        furniture = { ["|"] = "f_clear", d = "f_clear" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_firestation1_living_area",
    layout = {
        nested = { { id = "fbmc_firestation1_living_quarters", x = 10, y = 9 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_firestation1_living_quarters",
    layout = {
        size = { width = 13, height = 13 },
        rows = {
            "    |        ",
            "    |        ",
            "    |        ",
            "    d        ",
            "    |        ",
            "   ||||| ||||",
            "   |   | |   ",
            "   |   d d   ",
            "   |   | |   ",
            "   ||||| ||||",
            "   |   | |   ",
            "   |   d d   ",
            "   |   | |   ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        parameters = {
            fbmc_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        "fbmc_firestation1_palette_white_wall", "fbmc_firestation1_palette_log",
                        "fbmc_firestation1_palette_metal", "fbmc_firestation1_palette_migo",
                        "fbmc_firestation1_palette_rammed_earth", "fbmc_firestation1_palette_rock",
                        "fbmc_firestation1_palette_wad", "fbmc_firestation1_palette_wood",
                    },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmc_construction_palette" } },
    },
}
