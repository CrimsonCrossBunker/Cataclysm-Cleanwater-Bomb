local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_ravine_straight_v1",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "                        ",
            "###                 ####",
            "######          ########",
            "########################",
            "########################",
            "########################",
            "########################",
            "########################",
            "########################",
            "########################",
            "########################",
            "########################",
            "########################",
            "########################",
            "########################",
            "########################",
            "########################",
            "########################",
            "########################",
            "########################",
            "########################",
            "########################",
            "########################",
            "########################",
        },
        palettes = { "ravine" },
        nested = {
            {
                choices = { { id = "null", weight = 200 }, { id = "innawood_ravine_cave", weight = 1 } },
                x = 1,
                y = 3,
                z = -2,
                neighbors = { above = "open_air", below = "ravine_straight" },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_ravine_straight_v2",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "                #####   ",
            "##          ############",
            "######    ##############",
            "########################",
            "########################",
            "########################",
            "########################",
            "########################",
            "########################",
            "########################",
            "########################",
            "########################",
            "########################",
            "########################",
            "########################",
            "########################",
            "########################",
            "########################",
            "########################",
            "########################",
            "########################",
            "########################",
            "########################",
            "########################",
        },
        palettes = { "ravine" },
        nested = {
            {
                choices = { { id = "null", weight = 200 }, { id = "innawood_ravine_cave", weight = 1 } },
                x = 1,
                y = 3,
                z = -2,
                neighbors = { above = "open_air", below = "ravine_straight" },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "innawood_ravine_cave",
    layout = {
        size = { width = 15, height = 15 },
        rows = {
            "#####..########",
            "#####...#######",
            "######..#######",
            "#####...#######",
            "#####.#########",
            "###############",
            "###############",
            "###############",
            "###############",
            "###############",
            "###############",
            "###############",
            "###############",
            "###############",
            "###############",
        },
        terrain = { ["#"] = "t_rock", ["."] = "t_rock_floor" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "innawood_ravine_cave",
    weight = 150,
    layout = {
        size = { width = 15, height = 15 },
        rows = {
            "######..#######",
            "#####.....#####",
            "#..###...######",
            "#..##....######",
            "##....##...####",
            "####..####.####",
            "###..####..#..#",
            "###..#####...##",
            "##....###..####",
            "##..####..#####",
            "#..####..######",
            "#####......####",
            "######......###",
            "#######..#..###",
            "###############",
        },
        terrain = { ["#"] = "t_rock", ["."] = "t_rock_floor" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_ravine_corner_v1",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "                        ",
            "###                     ",
            "#####                   ",
            "########                ",
            "##########              ",
            "############            ",
            "#############           ",
            "##############          ",
            "##############          ",
            "###############         ",
            "################        ",
            "#################       ",
            "###################     ",
            "####################    ",
            "####################    ",
            "#####################   ",
            "#####################   ",
            "#####################   ",
            "######################  ",
            "######################  ",
            "######################  ",
            "####################### ",
            "####################### ",
            "####################### ",
        },
        palettes = { "ravine" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_ravine_corner_v2",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "                        ",
            "                        ",
            "#                       ",
            "##                      ",
            "###                     ",
            "####                    ",
            "####                    ",
            "#####                   ",
            "#######                 ",
            "########                ",
            "##########              ",
            "###########             ",
            "############            ",
            "############            ",
            "#############           ",
            "##############          ",
            "##############          ",
            "###############         ",
            "################        ",
            "##################      ",
            "###################     ",
            "#####################   ",
            "######################  ",
            "######################  ",
        },
        palettes = { "ravine" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_ravine_2way_v1",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            " ###################### ",
            " ###################### ",
            "  ####################  ",
            "  ####################  ",
            "  ####################  ",
            "   ##################   ",
            "   ##################   ",
            "    #################   ",
            "    #################   ",
            "    #################   ",
            "    #################   ",
            "    ################    ",
            "   #################    ",
            "   #################    ",
            "   #################    ",
            "  ##################    ",
            "  ##################    ",
            "  ###################   ",
            "  ###################   ",
            "  ###################   ",
            "  ####################  ",
            " #####################  ",
            " ###################### ",
            " ###################### ",
        },
        palettes = { "ravine" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_ravine_2way_v2",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            " ###################### ",
            " ###################### ",
            " #####################  ",
            "  ####################  ",
            "  ###################   ",
            "  ###################   ",
            "  ###################   ",
            "  ##################    ",
            "  ##################    ",
            "   #################    ",
            "   #################    ",
            "   #################    ",
            "    ################    ",
            "    #################   ",
            "    #################   ",
            "    #################   ",
            "    #################   ",
            "   ##################   ",
            "   ##################   ",
            "  ####################  ",
            "  ####################  ",
            "  ####################  ",
            " ###################### ",
            " ###################### ",
        },
        palettes = { "ravine" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_ravine_3way_v1",
    layout = {
        size = { width = 24, height = 24 },
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
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "          ####          ",
            "       #########        ",
            "      ###########       ",
            "    #############       ",
            "    ##############      ",
            "   ################     ",
            "   #################    ",
            "   ##################   ",
            "  ####################  ",
            "  ##################### ",
            "  ##################### ",
        },
        palettes = { "ravine" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_ravine_3way_v2",
    layout = {
        size = { width = 24, height = 24 },
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
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "            ######      ",
            "          ##########    ",
            "         ###########    ",
            "         ############   ",
            "        #############   ",
            "       ##############   ",
            "     #################  ",
            "  ####################  ",
            " #####################  ",
        },
        palettes = { "ravine" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_ground",
    layout = {
        size = { width = 1, height = 1 },
        terrain = { [" "] = "t_region_groundcover" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_under_soil",
    layout = {
        size = { width = 1, height = 1 },
        terrain = { [" "] = "t_soil" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_under_stone",
    layout = {
        size = { width = 1, height = 1 },
        terrain = { [" "] = "t_rock" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "ravine_bottom_forest",
    layout = {
        predecessor_mapgen = "forest",
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "ravine_bottom_forest",
    weight = 750,
    layout = {
        predecessor_mapgen = "forest_thick",
    },
}

-- z0
ccb.content.define_mapgen {
    kind = "overmap",
    id = "ravine_straight_ground",
    layout = {
        fallback_predecessor_mapgen = "forest",
        nested = { { x = 0, y = 0, id = { parameter = "variant", fallback = "24x24_ravine_straight_v1" } } },
        palettes = { "ravine_straight_parameters" },
    },
}

-- z-1
ccb.content.define_mapgen {
    kind = "overmap",
    id = "ravine_straight",
    layout = {
        predecessor_mapgen = "open_air",
        nested = { { x = 0, y = 0, id = { parameter = "variant", fallback = "24x24_ravine_straight_v1" } } },
        palettes = { "ravine_straight_parameters" },
    },
}

-- z-2
ccb.content.define_mapgen {
    kind = "overmap",
    id = "ravine_straight_bottom",
    layout = {
        predecessor_mapgen = "forest",
        nested = { { x = 0, y = 0, id = { parameter = "variant", fallback = "24x24_ravine_straight_v1" } } },
        palettes = { "ravine_straight_parameters" },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "ravine_corner_ground",
    layout = {
        fallback_predecessor_mapgen = "forest",
        nested = { { x = 0, y = 0, id = { parameter = "variant", fallback = "24x24_ravine_corner_v1" } } },
        palettes = { "ravine_corner_parameters" },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "ravine_corner",
    layout = {
        predecessor_mapgen = "open_air",
        nested = { { x = 0, y = 0, id = { parameter = "variant", fallback = "24x24_ravine_corner_v1" } } },
        palettes = { "ravine_corner_parameters" },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "ravine_corner_bottom",
    layout = {
        predecessor_mapgen = "forest",
        nested = { { x = 0, y = 0, id = { parameter = "variant", fallback = "24x24_ravine_corner_v1" } } },
        palettes = { "ravine_corner_parameters" },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "ravine_2way_ground",
    layout = {
        fallback_predecessor_mapgen = "forest",
        nested = { { x = 0, y = 0, id = { parameter = "variant", fallback = "24x24_ravine_2way_v1" } } },
        palettes = { "ravine_2way_parameters" },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "ravine_2way",
    layout = {
        predecessor_mapgen = "open_air",
        nested = { { x = 0, y = 0, id = { parameter = "variant", fallback = "24x24_ravine_2way_v1" } } },
        palettes = { "ravine_2way_parameters" },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "ravine_2way_bottom",
    layout = {
        predecessor_mapgen = "forest",
        nested = { { x = 0, y = 0, id = { parameter = "variant", fallback = "24x24_ravine_2way_v1" } } },
        palettes = { "ravine_2way_parameters" },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "ravine_3way_ground",
    layout = {
        fallback_predecessor_mapgen = "forest",
        nested = { { x = 0, y = 0, id = { parameter = "variant", fallback = "24x24_ravine_3way_v1" } } },
        palettes = { "ravine_3way_parameters" },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "ravine_3way",
    layout = {
        predecessor_mapgen = "open_air",
        nested = { { x = 0, y = 0, id = { parameter = "variant", fallback = "24x24_ravine_3way_v1" } } },
        palettes = { "ravine_3way_parameters" },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "ravine_3way_bottom",
    layout = {
        predecessor_mapgen = "forest",
        nested = { { x = 0, y = 0, id = { parameter = "variant", fallback = "24x24_ravine_3way_v1" } } },
        palettes = { "ravine_3way_parameters" },
    },
}
