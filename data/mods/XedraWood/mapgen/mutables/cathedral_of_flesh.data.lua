local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = "pillar_of_flesh",
    layout = {
        rows = {
            "           ##           ",
            "          ####          ",
            "         ######         ",
            "        ########        ",
            "       ##########       ",
            "      ############      ",
            "     ##############     ",
            "    ################    ",
            "   ##################   ",
            "  ####################  ",
            " ###################### ",
            " ###################### ",
            " ###################### ",
            " ###################### ",
            "  ####################  ",
            "   ##################   ",
            "    ################    ",
            "     ##############     ",
            "      ############      ",
            "       ##########       ",
            "        ########        ",
            "         ######         ",
            "          ####          ",
            "           ##           ",
        },
        palettes = { "cathedral_of_flesh_monster_surface_palette" },
        fill_terrain = "t_region_groundcover",
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "temple_of_flesh",
    layout = {
        rows = {
            "                        ",
            "                        ",
            "     ##          ##     ",
            "     =##        ##=     ",
            "    ===##      ##===    ",
            "  #=====########=====#  ",
            "  ##===T========T===##  ",
            "   ##=T==========T=##   ",
            "    ##==T======T==##    ",
            "     #====T==T====#     ",
            "     #===T====T===#     ",
            "     #=====<<=====#     ",
            "     #=====<<=====#     ",
            "     #===T====T===#     ",
            "     #====T==T====#     ",
            "    ##==T======T==##    ",
            "   ##=T==========T=##   ",
            "  ##===T========T===##  ",
            "  #=====########=====#  ",
            "    ===##      ##===    ",
            "     =##        ##=     ",
            "     ##          ##     ",
            "                        ",
            "                        ",
        },
        palettes = { "cathedral_of_flesh_monster_surface_palette" },
        fill_terrain = "t_region_groundcover",
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "nest_cathedral_of_flesh_wall_flesh_roof",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "%",
        },
        terrain = { ["%"] = "t_nm_wall_flesh" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            { id = "nest_cathedral_of_flesh_wall_flesh_roof_unnested", x = 0, y = 0, z = 1 },
            { id = "nest_cathedral_of_flesh_wall_flesh_roof_unnested", x = 0, y = 0, z = 2 },
            { id = "nest_cathedral_of_flesh_wall_flesh_roof_unnested", x = 0, y = 0, z = 3 },
            { id = "nest_cathedral_of_flesh_wall_flesh_roof_unnested", x = 0, y = 0, z = 4 },
            { id = "nest_cathedral_of_flesh_wall_flesh_roof_unnested", x = 0, y = 0, z = 5 },
            { id = "nest_cathedral_of_flesh_wall_flesh_roof_unnested", x = 0, y = 0, z = 6 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "nest_cathedral_of_flesh_wall_flesh_roof_unnested",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "%",
        },
        terrain = { ["%"] = "t_nm_wall_flesh" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}
