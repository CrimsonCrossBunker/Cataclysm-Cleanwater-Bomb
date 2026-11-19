local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = "natural_spring",
    layout = {
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "          wWWw          ",
            "         wWWWWw         ",
            "         WWWWWW         ",
            "         WWWWWW         ",
            "         wWWWWw         ",
            "          wWWw          ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        terrain = { W = "t_water_sh", w = { { id = "t_water_sh" }, { id = "t_region_groundcover" } } },
        rotation = { 0, 3 },
        predecessor_mapgen = "forest_thick",
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested_glyphs = {
            W = {
                choices = { { id = "pond_water_furniture", weight = 1 }, { id = "null", weight = 6 } },
            },
            w = {
                choices = { { id = "pond_water_furniture", weight = 1 }, { id = "null", weight = 4 } },
            },
        },
    },
}
