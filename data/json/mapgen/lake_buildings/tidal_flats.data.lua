local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "tidal_flats_palette",
    layout = {
        terrain = {
            ["."] = {
                { id = "t_sand", copies = 2 },
                { id = "t_water_sh", copies = 1 },
                { id = "t_null", copies = 1 },
            },
            o = {
                { id = "t_shore_boulder", copies = 2 },
                { id = "t_shore_boulder_oyster", copies = 1 },
                { id = "t_sand", copies = 2 },
                { id = "t_null", copies = 1 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_tidal_flat",
    layout = {
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "          ....          ",
            "        ........        ",
            "       ...........      ",
            "      .....ooo.o....    ",
            "      ....ooooo.....    ",
            "     ....o.oooo.....    ",
            "     .....ooooo.....    ",
            "     .....ooooo.....    ",
            "     .....ooooo.....    ",
            "      ....o.oo.....     ",
            "      .....oo......     ",
            "       ....oo......     ",
            "       .....o.....      ",
            "        ...o.....       ",
            "         .......        ",
            "           ...          ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        palettes = { "tidal_flats_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        vehicle_placements = { { id = "canoe", chance = 20, x = 18, y = 18, rotation = 0 } },
    },
}
