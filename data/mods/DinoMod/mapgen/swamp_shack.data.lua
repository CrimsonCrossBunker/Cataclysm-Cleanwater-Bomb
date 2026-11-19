local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "cattail",
    layout = {
        rows = {
            "i",
        },
        furniture = { i = "f_cattails" },
        size = { width = 1, height = 1 },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "hunter_shack" },
    layout = {
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "       -----------      ",
            "       -CSn.....D-      ",
            "       -....--+---      ",
            "       -B..d-@..L-      ",
            "       -B...-@..L-      ",
            "       -bbTc-s.ss-      ",
            "       ---o---+---      ",
            "       ;=V;;^;;;=       ",
            "       ;;;;;;;;X=       ",
            "       ;=&&;xxXX=       ",
            "        =========       ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        palettes = { "swampshack_palette" },
        terrain = { V = "t_region_soil", x = "t_region_soil", X = "t_region_soil" },
        predecessor_mapgen = "forest_water",
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { id = "NC_Yoshimi_spawn", x = { 10 }, y = { 9 } } },
        loot_placements = {
            { id = "net", x = 11, y = 14, chance = 100 },
            { id = "stepladder", x = 11, y = 16, chance = 50 },
        },
    },
}
