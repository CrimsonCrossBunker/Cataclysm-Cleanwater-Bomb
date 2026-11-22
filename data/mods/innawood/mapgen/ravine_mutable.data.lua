local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "ravine_corner_parameters",
    layout = {
        parameters = {
            variant = {
                value_type = "nested_mapgen",
                default = { weighted = { "24x24_ravine_corner_v1", "24x24_ravine_corner_v2" } },
                scope = "map_stack",
            },
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "ravine_2way_parameters",
    layout = {
        parameters = {
            variant = {
                value_type = "nested_mapgen",
                default = { weighted = { "24x24_ravine_2way_v1", "24x24_ravine_2way_v2" } },
                scope = "map_stack",
            },
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "ravine_3way_parameters",
    layout = {
        parameters = {
            variant = {
                value_type = "nested_mapgen",
                default = { weighted = { "24x24_ravine_3way_v1", "24x24_ravine_3way_v2" } },
                scope = "map_stack",
            },
        },
    },
}

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

ccb.content.define_mutable_overmap_special {
    id = "Ravine Mutable",
    root = "ravine_root",
    locations = { "field", "forest_with_swamp", "subterranean_empty" },
    flags = { "WILDERNESS" },
    occurrences = { 0, 2 },
    priority = 3,
    check_for_locations_area = {
        {
            from = { -4, -4, 0 },
            to = { 4, 4, 0 },
            locations = { "field", "forest_with_swamp" },
        },
        {
            from = { -16, -16, -1 },
            to = { 16, 16, -2 },
            locations = { "subterranean_empty" },
        },
    },
    joins = { "ravine_to_ravine", "ravine_to_edge", "ravine_to_bottom" },
    overmaps = {
        ravine_root = {
            overmap = "open_air",
            north = { id = "ravine_to_ravine" },
            south = { id = "ravine_to_ravine" },
            east = { id = "ravine_to_ravine" },
            west = { id = "ravine_to_ravine" },
            below = {
                id = "ravine_to_bottom",
                alternatives = { "ravine_to_edge" },
            },
        },
        ravine_core_ground = {
            overmap = "open_air",
            north = {
                id = "ravine_to_ravine",
                alternatives = { "ravine_to_edge" },
            },
            south = {
                id = "ravine_to_ravine",
                alternatives = { "ravine_to_edge" },
            },
            east = {
                id = "ravine_to_ravine",
                alternatives = { "ravine_to_edge" },
            },
            west = {
                id = "ravine_to_ravine",
                alternatives = { "ravine_to_edge" },
            },
        },
        ravine_filler_ground = {
            overmap = "open_air",
            north = {
                id = "ravine_to_ravine",
                type = "available",
                alternatives = { "ravine_to_edge" },
            },
            south = {
                id = "ravine_to_ravine",
                type = "available",
                alternatives = { "ravine_to_edge" },
            },
            east = {
                id = "ravine_to_ravine",
                type = "available",
                alternatives = { "ravine_to_edge" },
            },
            west = {
                id = "ravine_to_ravine",
                type = "available",
                alternatives = { "ravine_to_edge" },
            },
        },
        ravine_straight_ground = {
            overmap = "ravine_straight_ground_north",
            north = { id = "ravine_to_ravine" },
        },
        ravine_corner_ground = {
            overmap = "ravine_corner_ground_north",
            north = {
                id = "ravine_to_ravine",
                alternatives = { "ravine_to_edge" },
            },
            east = {
                id = "ravine_to_ravine",
                alternatives = { "ravine_to_edge" },
            },
        },
        ravine_2way_ground = {
            overmap = "ravine_2way_ground_east",
            north = {
                id = "ravine_to_ravine",
                type = "available",
                alternatives = { "ravine_to_edge" },
            },
            south = {
                id = "ravine_to_ravine",
                type = "available",
                alternatives = { "ravine_to_edge" },
            },
        },
        ravine_3way_ground = {
            overmap = "ravine_3way_ground_north",
            north = {
                id = "ravine_to_ravine",
                type = "available",
                alternatives = { "ravine_to_edge" },
            },
            east = {
                id = "ravine_to_ravine",
                type = "available",
                alternatives = { "ravine_to_edge" },
            },
            west = {
                id = "ravine_to_ravine",
                type = "available",
                alternatives = { "ravine_to_edge" },
            },
        },
        ravine_core = { overmap = "open_air" },
        ravine_filler = { overmap = "open_air" },
        ravine_root_filler = {
            overmap = "open_air",
            above = {
                id = "ravine_to_bottom",
                alternatives = { "ravine_to_edge" },
            },
        },
        ravine_bottom = { overmap = "ravine_bottom_forest" },
        ravine_straight = { overmap = "ravine_straight_north" },
        ravine_corner = { overmap = "ravine_corner_north" },
        ravine_2way = { overmap = "ravine_2way_east" },
        ravine_3way = { overmap = "ravine_3way_north" },
        ravine_straight_bottom = { overmap = "ravine_straight_bottom_north" },
        ravine_corner_bottom = { overmap = "ravine_corner_bottom_north" },
        ravine_2way_bottom = { overmap = "ravine_2way_bottom_east" },
        ravine_3way_bottom = { overmap = "ravine_3way_bottom_north" },
    },
    phases = {
        {
            {
                name = "15-tile straight branch",
                chunk = {
                    {
                        overmap = "ravine_core_ground",
                        pos = { 0, 0, 0 },
                    },
                    {
                        overmap = "ravine_core",
                        pos = { 0, 0, -1 },
                    },
                    {
                        overmap = "ravine_bottom",
                        pos = { 0, 0, -2 },
                    },
                    {
                        overmap = "ravine_core_ground",
                        pos = { 1, 0, 0 },
                    },
                    {
                        overmap = "ravine_core",
                        pos = { 1, 0, -1 },
                    },
                    {
                        overmap = "ravine_bottom",
                        pos = { 1, 0, -2 },
                    },
                    {
                        overmap = "ravine_core_ground",
                        pos = { 2, 0, 0 },
                    },
                    {
                        overmap = "ravine_core",
                        pos = { 2, 0, -1 },
                    },
                    {
                        overmap = "ravine_bottom",
                        pos = { 2, 0, -2 },
                    },
                    {
                        overmap = "ravine_core_ground",
                        pos = { 3, 0, 0 },
                    },
                    {
                        overmap = "ravine_core",
                        pos = { 3, 0, -1 },
                    },
                    {
                        overmap = "ravine_bottom",
                        pos = { 3, 0, -2 },
                    },
                    {
                        overmap = "ravine_core_ground",
                        pos = { 4, 0, 0 },
                    },
                    {
                        overmap = "ravine_core",
                        pos = { 4, 0, -1 },
                    },
                    {
                        overmap = "ravine_bottom",
                        pos = { 4, 0, -2 },
                    },
                    {
                        overmap = "ravine_core_ground",
                        pos = { 5, 0, 0 },
                    },
                    {
                        overmap = "ravine_core",
                        pos = { 5, 0, -1 },
                    },
                    {
                        overmap = "ravine_bottom",
                        pos = { 5, 0, -2 },
                    },
                    {
                        overmap = "ravine_core_ground",
                        pos = { 6, 0, 0 },
                    },
                    {
                        overmap = "ravine_core",
                        pos = { 6, 0, -1 },
                    },
                    {
                        overmap = "ravine_bottom",
                        pos = { 6, 0, -2 },
                    },
                    {
                        overmap = "ravine_core_ground",
                        pos = { 7, 0, 0 },
                    },
                    {
                        overmap = "ravine_core",
                        pos = { 7, 0, -1 },
                    },
                    {
                        overmap = "ravine_bottom",
                        pos = { 7, 0, -2 },
                    },
                    {
                        overmap = "ravine_core_ground",
                        pos = { 8, 0, 0 },
                    },
                    {
                        overmap = "ravine_core",
                        pos = { 8, 0, -1 },
                    },
                    {
                        overmap = "ravine_bottom",
                        pos = { 8, 0, -2 },
                    },
                    {
                        overmap = "ravine_core_ground",
                        pos = { 9, 0, 0 },
                    },
                    {
                        overmap = "ravine_core",
                        pos = { 9, 0, -1 },
                    },
                    {
                        overmap = "ravine_bottom",
                        pos = { 9, 0, -2 },
                    },
                    {
                        overmap = "ravine_core_ground",
                        pos = { 10, 0, 0 },
                    },
                    {
                        overmap = "ravine_core",
                        pos = { 10, 0, -1 },
                    },
                    {
                        overmap = "ravine_bottom",
                        pos = { 10, 0, -2 },
                    },
                    {
                        overmap = "ravine_core_ground",
                        pos = { 11, 0, 0 },
                    },
                    {
                        overmap = "ravine_core",
                        pos = { 11, 0, -1 },
                    },
                    {
                        overmap = "ravine_bottom",
                        pos = { 11, 0, -2 },
                    },
                    {
                        overmap = "ravine_core_ground",
                        pos = { 12, 1, 0 },
                    },
                    {
                        overmap = "ravine_core",
                        pos = { 12, 1, -1 },
                    },
                    {
                        overmap = "ravine_bottom",
                        pos = { 12, 1, -2 },
                    },
                    {
                        overmap = "ravine_core_ground",
                        pos = { 13, 1, 0 },
                    },
                    {
                        overmap = "ravine_core",
                        pos = { 13, 1, -1 },
                    },
                    {
                        overmap = "ravine_bottom",
                        pos = { 13, 1, -2 },
                    },
                    {
                        overmap = "ravine_core_ground",
                        pos = { 14, 1, 0 },
                    },
                    {
                        overmap = "ravine_core",
                        pos = { 14, 1, -1 },
                    },
                    {
                        overmap = "ravine_bottom",
                        pos = { 14, 1, -2 },
                    },
                },
                max = 1,
            },
            {
                name = "12-tile diagonal branch",
                chunk = {
                    {
                        overmap = "ravine_core_ground",
                        pos = { 0, 0, 0 },
                    },
                    {
                        overmap = "ravine_core",
                        pos = { 0, 0, -1 },
                    },
                    {
                        overmap = "ravine_bottom",
                        pos = { 0, 0, -2 },
                    },
                    {
                        overmap = "ravine_core_ground",
                        pos = { 1, 1, 0 },
                    },
                    {
                        overmap = "ravine_core",
                        pos = { 1, 1, -1 },
                    },
                    {
                        overmap = "ravine_bottom",
                        pos = { 1, 1, -2 },
                    },
                    {
                        overmap = "ravine_core_ground",
                        pos = { 2, 2, 0 },
                    },
                    {
                        overmap = "ravine_core",
                        pos = { 2, 2, -1 },
                    },
                    {
                        overmap = "ravine_bottom",
                        pos = { 2, 2, -2 },
                    },
                    {
                        overmap = "ravine_core_ground",
                        pos = { 3, 3, 0 },
                    },
                    {
                        overmap = "ravine_core",
                        pos = { 3, 3, -1 },
                    },
                    {
                        overmap = "ravine_bottom",
                        pos = { 3, 3, -2 },
                    },
                    {
                        overmap = "ravine_core_ground",
                        pos = { 4, 4, 0 },
                    },
                    {
                        overmap = "ravine_core",
                        pos = { 4, 4, -1 },
                    },
                    {
                        overmap = "ravine_bottom",
                        pos = { 4, 4, -2 },
                    },
                    {
                        overmap = "ravine_core_ground",
                        pos = { 5, 5, 0 },
                    },
                    {
                        overmap = "ravine_core",
                        pos = { 5, 5, -1 },
                    },
                    {
                        overmap = "ravine_bottom",
                        pos = { 5, 5, -2 },
                    },
                    {
                        overmap = "ravine_core_ground",
                        pos = { 6, 6, 0 },
                    },
                    {
                        overmap = "ravine_core",
                        pos = { 6, 6, -1 },
                    },
                    {
                        overmap = "ravine_bottom",
                        pos = { 6, 6, -2 },
                    },
                    {
                        overmap = "ravine_core_ground",
                        pos = { 7, 7, 0 },
                    },
                    {
                        overmap = "ravine_core",
                        pos = { 7, 7, -1 },
                    },
                    {
                        overmap = "ravine_bottom",
                        pos = { 7, 7, -2 },
                    },
                    {
                        overmap = "ravine_core_ground",
                        pos = { 8, 8, 0 },
                    },
                    {
                        overmap = "ravine_core",
                        pos = { 8, 8, -1 },
                    },
                    {
                        overmap = "ravine_bottom",
                        pos = { 8, 8, -2 },
                    },
                    {
                        overmap = "ravine_core_ground",
                        pos = { 9, 9, 0 },
                    },
                    {
                        overmap = "ravine_core",
                        pos = { 9, 9, -1 },
                    },
                    {
                        overmap = "ravine_bottom",
                        pos = { 9, 9, -2 },
                    },
                    {
                        overmap = "ravine_core_ground",
                        pos = { 10, 10, 0 },
                    },
                    {
                        overmap = "ravine_core",
                        pos = { 10, 10, -1 },
                    },
                    {
                        overmap = "ravine_bottom",
                        pos = { 10, 10, -2 },
                    },
                    {
                        overmap = "ravine_core_ground",
                        pos = { 11, 11, 0 },
                    },
                    {
                        overmap = "ravine_core",
                        pos = { 11, 11, -1 },
                    },
                    {
                        overmap = "ravine_bottom",
                        pos = { 11, 11, -2 },
                    },
                },
                max = 1,
            },
        },
        {
            {
                name = "ravine core",
                chunk = {
                    {
                        overmap = "ravine_core_ground",
                        pos = { 0, 0, 0 },
                    },
                    {
                        overmap = "ravine_core",
                        pos = { 0, 0, -1 },
                    },
                    {
                        overmap = "ravine_bottom",
                        pos = { 0, 0, -2 },
                    },
                },
                max = { poisson = 30 },
            },
        },
        {
            {
                name = "ravine edge",
                weight = 1,
                chunk = {
                    {
                        overmap = "ravine_straight_ground",
                        pos = { 0, 0, 0 },
                    },
                    {
                        overmap = "ravine_straight",
                        pos = { 0, 0, -1 },
                    },
                    {
                        overmap = "ravine_straight_bottom",
                        pos = { 0, 0, -2 },
                    },
                },
            },
        },
        {
            {
                name = "ravine corner",
                weight = 1,
                chunk = {
                    {
                        overmap = "ravine_corner_ground",
                        pos = { 0, 0, 0 },
                    },
                    {
                        overmap = "ravine_corner",
                        pos = { 0, 0, -1 },
                    },
                    {
                        overmap = "ravine_corner_bottom",
                        pos = { 0, 0, -2 },
                    },
                },
            },
        },
        {
            {
                name = "ravine 2way",
                weight = 1,
                chunk = {
                    {
                        overmap = "ravine_2way_ground",
                        pos = { 0, 0, 0 },
                    },
                    {
                        overmap = "ravine_2way",
                        pos = { 0, 0, -1 },
                    },
                    {
                        overmap = "ravine_2way_bottom",
                        pos = { 0, 0, -2 },
                    },
                },
            },
        },
        {
            {
                name = "ravine 3way",
                weight = 1,
                chunk = {
                    {
                        overmap = "ravine_3way_ground",
                        pos = { 0, 0, 0 },
                    },
                    {
                        overmap = "ravine_3way",
                        pos = { 0, 0, -1 },
                    },
                    {
                        overmap = "ravine_3way_bottom",
                        pos = { 0, 0, -2 },
                    },
                },
            },
        },
        {
            {
                name = "ravine filler",
                weight = 1,
                chunk = {
                    {
                        overmap = "ravine_filler_ground",
                        pos = { 0, 0, 0 },
                    },
                    {
                        overmap = "ravine_filler",
                        pos = { 0, 0, -1 },
                    },
                    {
                        overmap = "ravine_bottom",
                        pos = { 0, 0, -2 },
                    },
                },
            },
        },
        {
            {
                name = "ravine filler root",
                weight = 1,
                chunk = {
                    {
                        overmap = "ravine_root_filler",
                        pos = { 0, 0, -1 },
                    },
                    {
                        overmap = "ravine_bottom",
                        pos = { 0, 0, -2 },
                    },
                },
            },
        },
    },
}
