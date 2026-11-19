local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "canyon_edge_parameters",
    layout = {
        parameters = {
            variant = {
                value_type = "nested_mapgen",
                default = { weighted = { "24x24_canyon_edge_v1", "24x24_canyon_edge_v2" } },
                scope = "map_stack",
            },
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "canyon",
    layout = {
        nested_glyphs = {
            ["#"] = { levels = { 0 }, otherwise = { "1x1_sandstone" } },
            [" "] = { levels = { 0 }, id = "1x1_open_air" },
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "canyon_corner_parameters",
    layout = {
        parameters = {
            variant = {
                value_type = "nested_mapgen",
                default = { weighted = { "24x24_canyon_corner_v1", "24x24_canyon_corner_v2" } },
                scope = "map_stack",
            },
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "canyon_2way_parameters",
    layout = {
        parameters = {
            variant = {
                value_type = "nested_mapgen",
                default = { weighted = { "24x24_canyon_2way_v1", "24x24_canyon_2way_v2" } },
                scope = "map_stack",
            },
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "canyon_3way_parameters",
    layout = {
        parameters = {
            variant = {
                value_type = "nested_mapgen",
                default = { weighted = { "24x24_canyon_3way_v1", "24x24_canyon_3way_v2" } },
                scope = "map_stack",
            },
        },
    },
}

-- Number indicates number of tiles from center
ccb.content.define_mapgen_palette {
    id = "trail_width_palette",
    layout = {
        nested_glyphs = {
            ["0"] = { id = "1x1_trail" },
            ["1"] = { choices = { { id = "1x1_trail", weight = 1 }, { id = "null", weight = 1 } } },
            ["2"] = { choices = { { id = "1x1_trail", weight = 0 }, { id = "null", weight = 1 } } },
            ["3"] = { choices = { { id = "1x1_trail", weight = 0 }, { id = "null", weight = 1 } } },
            ["4"] = { choices = { { id = "1x1_trail", weight = 0 }, { id = "null", weight = 1 } } },
        },
    },
}

ccb.content.define_mapgen_palette { id = "trail_path_palette", layout = { terrain = { ["."] = "t_railroad_rubble" } } }

ccb.content.define_mapgen {
    kind = "overmap",
    id = "mesa",
    layout = {
        fill_terrain = "t_sandstone",
    },
}

-- Z = 0
-- These would probably be better done as conditional nests of mesa though z-level testing would need adding
ccb.content.define_mapgen {
    kind = "overmap",
    id = { { "mesa_edge_v1", "mesa_edge_v2" } },
    layout = {
        rows = {
            "###########################     ################",
            "   #################                ##########  ",
            "      ##########                      ####      ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
        },
        terrain = { ["#"] = "t_sandstone" },
        fallback_predecessor_mapgen = "field",
    },
}

-- Z = 2
ccb.content.define_mapgen {
    kind = "overmap",
    id = { { "mesa_edge_top_v1", "mesa_edge_top_v2" } },
    layout = {
        rows = {
            "###########################     ################",
            "   #################                ##########  ",
            "      ##########                      ####      ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
        },
        terrain = { ["#"] = "t_null", [" "] = "t_open_air" },
        predecessor_mapgen = "field",
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- Z = 0
ccb.content.define_mapgen {
    kind = "overmap",
    id = { { "mesa_corner_v1", "mesa_corner_v2" } },
    layout = {
        rows = {
            "################################################",
            "   #############################################",
            "     ################### #######################",
            "        ################  ######################",
            "          ##############   #####################",
            "            ############    ####################",
            "             ###########    ####################",
            "              ##########     ###################",
            "              ##########       #################",
            "               #########        ################",
            "                ########          ##############",
            "                 #######           #############",
            "                   #####            ############",
            "                    ####            ############",
            "                    ####             ###########",
            "                     ###              ##########",
            "                     ###              ##########",
            "                     ###               #########",
            "                      ##                ########",
            "                      ##                  ######",
            "                      ##                   #####",
            "                       #                     ###",
            "                       #                      ##",
            "                       #                      ##",
        },
        terrain = { ["#"] = "t_sandstone" },
        fallback_predecessor_mapgen = "field",
    },
}

-- Z = 2
ccb.content.define_mapgen {
    kind = "overmap",
    id = { { "mesa_corner_top_v1", "mesa_corner_top_v2" } },
    layout = {
        rows = {
            "################################################",
            "   #############################################",
            "     ################### #######################",
            "        ################  ######################",
            "          ##############   #####################",
            "            ############    ####################",
            "             ###########    ####################",
            "              ##########     ###################",
            "              ##########       #################",
            "               #########        ################",
            "                ########          ##############",
            "                 #######           #############",
            "                   #####            ############",
            "                    ####            ############",
            "                    ####             ###########",
            "                     ###              ##########",
            "                     ###              ##########",
            "                     ###               #########",
            "                      ##                ########",
            "                      ##                  ######",
            "                      ##                   #####",
            "                       #                     ###",
            "                       #                      ##",
            "                       #                      ##",
        },
        terrain = { ["#"] = "t_null", [" "] = "t_open_air" },
        predecessor_mapgen = "field",
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- Z = 0
ccb.content.define_mapgen {
    kind = "overmap",
    id = { { "mesa_2way_v1", "mesa_2way_v2" } },
    layout = {
        rows = {
            "#                      ##                      #",
            "#                      ##                      #",
            "##                    ###                     ##",
            "##                    ####                    ##",
            "##                    ####                   ###",
            "###                  #####                   ###",
            "###                  #####                   ###",
            "####                 #####                  ####",
            "####                 #####                  ####",
            "####                 ######                 ####",
            "####                 ######                 ####",
            "####                #######                 ####",
            "###                 ########                ####",
            "###                 ########                 ###",
            "###                 ########                 ###",
            "##                  ########                 ###",
            "##                  ########                 ###",
            "##                   ######                  ###",
            "##                   ######                  ###",
            "##                   #####                    ##",
            "##                    ####                    ##",
            "#                     ####                    ##",
            "#                      ##                      #",
            "#                      ##                      #",
        },
        terrain = { ["#"] = "t_sandstone" },
        fallback_predecessor_mapgen = "field",
    },
}

-- Z = 2
-- Why does this use predecessor when it replaces the whole map?
ccb.content.define_mapgen {
    kind = "overmap",
    id = { { "mesa_2way_top_v1", "mesa_2way_top_v2" } },
    layout = {
        rows = {
            "#                      ##                      #",
            "#                      ##                      #",
            "##                    ###                     ##",
            "##                    ####                    ##",
            "##                    ####                   ###",
            "###                  #####                   ###",
            "###                  #####                   ###",
            "####                 #####                  ####",
            "####                 #####                  ####",
            "####                 ######                 ####",
            "####                 ######                 ####",
            "####                #######                 ####",
            "###                 ########                ####",
            "###                 ########                 ###",
            "###                 ########                 ###",
            "##                  ########                 ###",
            "##                  ########                 ###",
            "##                   ######                  ###",
            "##                   ######                  ###",
            "##                   #####                    ##",
            "##                    ####                    ##",
            "#                     ####                    ##",
            "#                      ##                      #",
            "#                      ##                      #",
        },
        terrain = { ["#"] = "t_null", [" "] = "t_open_air" },
        predecessor_mapgen = "field",
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- Z = 0
ccb.content.define_mapgen {
    kind = "overmap",
    id = { { "mesa_3way_v1", "mesa_3way_v2" } },
    layout = {
        rows = {
            "################################################",
            "################################################",
            "################################################",
            "################################################",
            "################################################",
            "################################################",
            "################################################",
            "################################################",
            "################################################",
            "################################################",
            "################################################",
            "################################################",
            "################################################",
            "##########    ##################################",
            "#######         ################################",
            "######           ###################      ######",
            "####             #################          ####",
            "####              ###############           ####",
            "###                ##############            ###",
            "###                 ############             ###",
            "###                  ##########              ###",
            "##                    #######                 ##",
            "##                     ###                    ##",
            "##                     ##                     ##",
        },
        terrain = { ["#"] = "t_sandstone" },
        fallback_predecessor_mapgen = "field",
    },
}

-- Z = 2
ccb.content.define_mapgen {
    kind = "overmap",
    id = { { "mesa_3way_top_v1", "mesa_3way_top_v2" } },
    layout = {
        rows = {
            "################################################",
            "################################################",
            "################################################",
            "################################################",
            "################################################",
            "################################################",
            "################################################",
            "################################################",
            "################################################",
            "################################################",
            "################################################",
            "################################################",
            "################################################",
            "##########    ##################################",
            "#######         ################################",
            "######           ###################      ######",
            "####             #################          ####",
            "####              ###############           ####",
            "###                ##############            ###",
            "###                 ############             ###",
            "###                  ##########              ###",
            "##                    #######                 ##",
            "##                     ###                    ##",
            "##                     ##                     ##",
        },
        terrain = { ["#"] = "t_null", [" "] = "t_open_air" },
        predecessor_mapgen = "field",
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_canyon_edge_v1",
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
        palettes = { "canyon" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_canyon_edge_v2",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "   #####                ",
            "############          ##",
            "##############    ######",
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
        palettes = { "canyon" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_canyon_corner_v1",
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
        palettes = { "canyon" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_canyon_corner_v2",
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
        palettes = { "canyon" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_canyon_2way_v1",
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
        palettes = { "canyon" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_canyon_2way_v2",
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
        palettes = { "canyon" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_canyon_3way_v1",
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
        palettes = { "canyon" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_canyon_3way_v2",
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
        palettes = { "canyon" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_sandstone",
    layout = {
        size = { width = 1, height = 1 },
        terrain = { [" "] = "t_sandstone" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- z0
ccb.content.define_mapgen {
    kind = "overmap",
    id = "canyon_edge_ground",
    layout = {
        fallback_predecessor_mapgen = "field",
        nested = { { x = 0, y = 0, id = { parameter = "variant", fallback = "24x24_canyon_edge_v1" } } },
        palettes = { "canyon_edge_parameters" },
    },
}

-- z-1
ccb.content.define_mapgen {
    kind = "overmap",
    id = "canyon_edge",
    layout = {
        predecessor_mapgen = "open_air",
        nested = { { x = 0, y = 0, id = { parameter = "variant", fallback = "24x24_canyon_edge_v1" } } },
        palettes = { "canyon_edge_parameters" },
    },
}

-- z-2
ccb.content.define_mapgen {
    kind = "overmap",
    id = "canyon_edge_bottom",
    layout = {
        predecessor_mapgen = "field",
        nested = { { x = 0, y = 0, id = { parameter = "variant", fallback = "24x24_canyon_edge_v1" } } },
        palettes = { "canyon_edge_parameters" },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "canyon_corner_ground",
    layout = {
        fallback_predecessor_mapgen = "field",
        nested = { { x = 0, y = 0, id = { parameter = "variant", fallback = "24x24_canyon_corner_v1" } } },
        palettes = { "canyon_corner_parameters" },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "canyon_corner",
    layout = {
        predecessor_mapgen = "open_air",
        nested = { { x = 0, y = 0, id = { parameter = "variant", fallback = "24x24_canyon_corner_v1" } } },
        palettes = { "canyon_corner_parameters" },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "canyon_corner_bottom",
    layout = {
        predecessor_mapgen = "field",
        nested = { { x = 0, y = 0, id = { parameter = "variant", fallback = "24x24_canyon_corner_v1" } } },
        palettes = { "canyon_corner_parameters" },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "canyon_2way_ground",
    layout = {
        fallback_predecessor_mapgen = "field",
        nested = { { x = 0, y = 0, id = { parameter = "variant", fallback = "24x24_canyon_2way_v1" } } },
        palettes = { "canyon_2way_parameters" },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "canyon_2way",
    layout = {
        predecessor_mapgen = "open_air",
        nested = { { x = 0, y = 0, id = { parameter = "variant", fallback = "24x24_canyon_2way_v1" } } },
        palettes = { "canyon_2way_parameters" },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "canyon_2way_bottom",
    layout = {
        predecessor_mapgen = "field",
        nested = { { x = 0, y = 0, id = { parameter = "variant", fallback = "24x24_canyon_2way_v1" } } },
        palettes = { "canyon_2way_parameters" },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "canyon_3way_ground",
    layout = {
        fallback_predecessor_mapgen = "field",
        nested = { { x = 0, y = 0, id = { parameter = "variant", fallback = "24x24_canyon_3way_v1" } } },
        palettes = { "canyon_3way_parameters" },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "canyon_3way",
    layout = {
        predecessor_mapgen = "open_air",
        nested = { { x = 0, y = 0, id = { parameter = "variant", fallback = "24x24_canyon_3way_v1" } } },
        palettes = { "canyon_3way_parameters" },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "canyon_3way_bottom",
    layout = {
        predecessor_mapgen = "field",
        nested = { { x = 0, y = 0, id = { parameter = "variant", fallback = "24x24_canyon_3way_v1" } } },
        palettes = { "canyon_3way_parameters" },
    },
}
