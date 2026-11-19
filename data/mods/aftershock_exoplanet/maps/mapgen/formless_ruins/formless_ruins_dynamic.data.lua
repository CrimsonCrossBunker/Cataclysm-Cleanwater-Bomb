local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "formless_ruins_ribs1",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "//    .../..",
            "/..   .../..",
            "/..     .//.",
            "/ /   ..   .",
            "  .   ....//",
            "  /   ...../",
            "///   /   /.",
            "/..   ...///",
            "///   .  ...",
            "/..    .  //",
            "/ //      ./",
            "/..      ../",
        },
        palettes = { "afs_formless_ruins" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "formless_ruins_ribs2",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "///// .////.",
            "/..  //..//.",
            "/..     .//.",
            "/ /   ..   .",
            "  .   ....  ",
            "  /   .   . ",
            "      /     ",
            "/..   ..    ",
            "      .  ...",
            "/..  / .   /",
            "  // /..  ./",
            "////  //////",
        },
        palettes = { "afs_formless_ruins" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "formless_ruins_room1",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "//    .../..",
            "/..  /ó/////",
            "/./X//1..../",
            "///    . . /",
            " /.    ...//",
            " //    ..../",
            " //   ...../",
            "///.../...//",
            "///   ./////",
            "///   .ó...ó",
            "/.//////////",
            "/ //      ./",
        },
        palettes = { "afs_formless_ruins" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested_glyphs = {
            ["1"] = {
                choices = {
                    { id = "null", weight = 200 },
                    { id = "formless_ruins_smallcryoroom", weight = 20 },
                    { id = "formless_ruins_smallasrg", weight = 20 },
                },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "formless_ruins_room2",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "//    .../..",
            "/..   .../..",
            "/./X//.//.//",
            "///   1. ../",
            " 3.   ...../",
            " //  ....../",
            "///.../...//",
            "/ 3   ...  /",
            "/ /   . ....",
            " .//3///////",
            "/ //.. ..../",
            "/./.  /// ./",
        },
        palettes = { "afs_formless_ruins" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested_glyphs = {
            ["1"] = {
                choices = {
                    { id = "null", weight = 200 },
                    { id = "formless_ruins_smallcryoroom", weight = 20 },
                    { id = "formless_ruins_smallasrg", weight = 20 },
                },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "formless_ruins_room3",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "/////#####..",
            "/.X  ///./..",
            "/./      ...",
            "///   ./ ...",
            "      1.////",
            "     ....../",
            "  /..//...  ",
            "  o  o...   ",
            "/ o  o. ....",
            " .// ///////",
            "   o..o ... ",
            "   /#3/     ",
        },
        palettes = { "afs_formless_ruins" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested_glyphs = {
            ["1"] = {
                choices = {
                    { id = "null", weight = 200 },
                    { id = "formless_ruins_smallcryoroom", weight = 20 },
                    { id = "formless_ruins_smallasrg", weight = 20 },
                },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "formless_ruins_room4",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "//.    ..#..",
            "/..  ///./..",
            "/.       ./.",
            " /    ./////",
            " o    .... /",
            " o   ....../",
            " ////./... /",
            " ..###3..   ",
            "  ....3 ....",
            "  /..///////",
            "  ...   ... ",
            "   ..       ",
        },
        palettes = { "afs_formless_ruins" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "formless_ruins_room5",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "////....///.",
            "/..  ///./..",
            "/..  ..  ./.",
            "/// / .////.",
            " /    ....//",
            " /   ....../",
            "///.../..../",
            "  o   o../. ",
            "/ #   # ./..",
            "#/// ////3  ",
            "## 3..  ... ",
            "#  /  .     ",
        },
        palettes = { "afs_formless_ruins" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "formless_ruins_room6",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "//33//..///.",
            "/... ///./#.",
            "ó......  .3.",
            "///.. ./////",
            "#..   ...../",
            "#... ......ó",
            "///../ .ooo/",
            "     / .. ./",
            "/    /  ././",
            "//// ///////",
            "##  ..  /.. ",
            "# /// . /   ",
        },
        palettes = { "afs_formless_ruins" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "formless_ruins_twoway1",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "/   //..///.",
            "/...   /  #.",
            "ó......  ...",
            "///|||./33//",
            "#.. #|#..../",
            "#...#|||...ó",
            "  /../..   /",
            "  .../...   ",
            "    .|....  ",
            "//   |||////",
            "##  ..  /.. ",
            "# /// . /   ",
        },
        palettes = { "afs_formless_ruins" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "formless_ruins_twoway2",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "/   /|../ //",
            "/... | /  #/",
            "/....|.  ../",
            "//   |./  //",
            "#.. #|#..../",
            "|...#|||...ó",
            "/ /../..   /",
            "/ .../...  /",
            "|   .|.... |",
            "//   |||/  /",
            "##  ..  /33/",
            "# /// . /   ",
        },
        palettes = { "afs_formless_ruins" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "formless_ruins_twoway3",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "/ ///#../ //",
            " ... # ///#/",
            " ....3...../",
            "//   #./. //",
            "#.. #|#.... ",
            "|////|||....",
            "/.###/./////",
            "...........3",
            "    ......./",
            "//   ||||../",
            "##  .||||33/",
            "#////||||.. ",
        },
        palettes = { "afs_formless_ruins" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "formless_ruins_pillar1",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "////... ///.",
            "/....     ..",
            "/..  ..  ./.",
            "//         .",
            " / ####.....",
            " /  #||# ../",
            "// ##||## ./",
            "     ###. . ",
            "/       .  .",
            "          / ",
            "## 3..  /   ",
            "#  /  . /   ",
        },
        palettes = { "afs_formless_ruins" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "formless_ruins_pillar2",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "////... ////",
            "/.... /// ./",
            "/..  ..  . /",
            "//         .",
            "       .....",
            "    #||./../",
            "   ##||./ ./",
            "     #  . . ",
            "/       .  .",
            "        ////",
            "##  ..  3...",
            "#  /  . /.  ",
        },
        palettes = { "afs_formless_ruins" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "formless_ruins_orderly1",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "/   ##     .",
            "/ .|#| |   .",
            "  .|#|.|.. .",
            "           .",
            "    ##   . /",
            "   | | | . /",
            "// |#| |   /",
            "          . ",
            "     ## .  .",
            "   | |#|    ",
            "#  |.| |   /",
            "/         //",
        },
        palettes = { "afs_formless_ruins" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "formless_ruins_orderly2",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "//////..   .",
            "/ .   |||| .",
            "/ .   |##| .",
            "     /|||| .",
            "    #/.... /",
            " ../.|.| . /",
            "//./.|.    /",
            " ../.|.   . ",
            "  ||||///  .",
            "  |##|#|    ",
            "# |||| |   /",
            "/      /////",
        },
        palettes = { "afs_formless_ruins" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "formless_ruins_orderly3",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "/   ##     .",
            "/ .|||||   .",
            "  .|#|.|.. .",
            "....       .",
            ".3  ##   . /",
            "./       . /",
            "//         /",
            "    .     . ",
            "   / .. .  .",
            "   | |.|    ",
            "#  |||||   /",
            "/  /   /////",
        },
        palettes = { "afs_formless_ruins" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "formless_ruins_orderly4",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "/   ##     .",
            "/ .|       .",
            "  .|    .. .",
            "         ///",
            "    ##   ./ ",
            "   |     ///",
            "// |       /",
            "          . ",
            "    //  .///",
            "   |.     / ",
            "#/ |.   ////",
            "/..       //",
        },
        palettes = { "afs_formless_ruins" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "formless_ruins_empty1",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "/         ..",
            "/.        /.",
            ".. /      /.",
            "/  //       ",
            "/    1      ",
            "/           ",
            "   /  .    /",
            "      /   . ",
            "           /",
            "            ",
            "            ",
            " //         ",
        },
        palettes = { "afs_formless_ruins" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested_glyphs = {
            ["1"] = {
                choices = { { id = "null", weight = 200 }, { id = "formless_ruins_escapepod", weight = 1 } },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "formless_ruins_empty2",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "/   #    //.",
            "/   .      .",
            "   /..  .. .",
            "   1/       ",
            "            ",
            "            ",
            "   ///     /",
            "   ..     . ",
            "   ../     /",
            ".    /     #",
            "..         #",
            "/./.        ",
        },
        palettes = { "afs_formless_ruins" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested_glyphs = {
            ["1"] = {
                choices = { { id = "null", weight = 200 }, { id = "formless_ruins_escapepod", weight = 1 } },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "formless_ruins_empty3",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "/   #    //.",
            "/        ...",
            "        .. .",
            "            ",
            "            ",
            "  1         ",
            "           /",
            "          ..",
            ".        ../",
            "..        .#",
            "#.         #",
            "/           ",
        },
        palettes = { "afs_formless_ruins" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested_glyphs = {
            ["1"] = {
                choices = { { id = "null", weight = 200 }, { id = "formless_ruins_escapepod", weight = 1 } },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "formless_ruins_empty4",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "/.. #      .",
            "/          .",
            "  .|    .. .",
            "         ///",
            "            ",
            ".        ///",
            "//         /",
            " .        . ",
            "...         ",
            "    . /...  ",
            "#     /.//..",
            "/         ..",
        },
        palettes = { "afs_formless_ruins" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "formless_ruins_cryoroom_roof",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "RRRRRRRRRRRR",
            "RRRR RRRRRRR",
            " RRRRRRRRRRR",
            "RRRRR RRRRRR",
            "RRR   RRRRRR",
            "RRRR RRRRRRR",
            "RRRRRRRRRRRR",
            "RR   R RRRRR",
            "RR   RRRRRRR",
            "RRRRRRRRRRRR",
            "RRR RR   RR ",
            "RRRRRRR RRRR",
        },
        terrain = { R = "t_metal_flat_roof" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "formless_ruins_telepad_roof",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "R     RRRRRR",
            "RR RRRRRRRRR",
            "RRRRRRRRRRRR",
            "RRRRRRRRRRRR",
            "RRR    RRRRR",
            "R RR  RRRRRR",
            "RR RRRRRRR R",
            "RR  RRRRRRRR",
            "RRR RRRRRR R",
            "RRRRRRRRRRRR",
            "RRRRRRRRRRRR",
            "RRRRR  RR   ",
        },
        terrain = { R = "t_metal_flat_roof" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "formless_ruins_escapepod_roof",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "R RRR ",
            "  RRR ",
            "  RRR ",
            "      ",
            "     R",
        },
        terrain = { R = "t_metal_flat_roof" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "formless_ruins_escapepod",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            " #### ",
            "/#-+-#",
            "##q!-#",
            "##---#",
            " #####",
            " ####/",
        },
        terrain = {
            ["-"] = "t_afs_space_ship_hull_wall",
            ["+"] = "t_afs_space_ship_hatch_c",
            q = "t_afs_escapepod_g",
            ["!"] = "t_metal_floor",
            ["#"] = "t_dirtmound",
        },
        furniture = { ["!"] = "f_afs_escape_pod_seat" },
        palettes = { "afs_formless_ruins" },
        item_groups = { ["!"] = { group = "afs_escape_pod_suppliesII", chance = 100 } },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested = { { id = "formless_ruins_escapepod_roof", x = 0, y = 0, z = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "formless_ruins_smallcryoroom_roof",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "   RRR",
            "RRRRRR",
            "RRRRRR",
            "  R RR",
            "  R RR",
            "  RRRR",
        },
        terrain = { R = "t_metal_flat_roof" },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "afs_formless_ruins_dynamic" },
    weight = 500,
    layout = {
        rows = {
            "1          .1           ",
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
            "1           1           ",
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
        },
        palettes = { "afs_formless_ruins" },
        predecessor_mapgen = "glacial_field",
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested = {
            { id = "formless_forest", x = 0, y = 0, neighbors = { north = "forest" } },
            { id = "formless_forest", x = 0, y = 0, neighbors = { east = "forest" } },
            { id = "formless_forest", x = 0, y = 0, neighbors = { south = "forest" } },
            { id = "formless_forest", x = 0, y = 0, neighbors = { west = "forest" } },
        },
        nested_glyphs = {
            ["1"] = {
                choices = {
                    { id = "formless_ruins_ribs1", weight = 20 },
                    { id = "formless_ruins_ribs2", weight = 20 },
                    { id = "formless_ruins_room1", weight = 20 },
                    { id = "formless_ruins_room2", weight = 20 },
                    { id = "formless_ruins_room3", weight = 20 },
                    { id = "formless_ruins_room4", weight = 20 },
                    { id = "formless_ruins_room5", weight = 20 },
                    { id = "formless_ruins_room6", weight = 20 },
                    { id = "formless_ruins_twoway1", weight = 20 },
                    { id = "formless_ruins_twoway2", weight = 20 },
                    { id = "formless_ruins_twoway3", weight = 20 },
                    { id = "formless_ruins_pillar1", weight = 20 },
                    { id = "formless_ruins_pillar2", weight = 20 },
                    { id = "formless_ruins_orderly1", weight = 10 },
                    { id = "formless_ruins_orderly2", weight = 10 },
                    { id = "formless_ruins_orderly3", weight = 10 },
                    { id = "formless_ruins_orderly4", weight = 10 },
                    { id = "formless_ruins_empty1", weight = 10 },
                    { id = "formless_ruins_empty2", weight = 10 },
                    { id = "formless_ruins_empty3", weight = 10 },
                    { id = "formless_ruins_empty4", weight = 10 },
                    { id = "formless_ruins_cryoroom", weight = 10 },
                    { id = "formless_ruins_armory", weight = 10 },
                    { id = "formless_ruins_sleeping_room", weight = 10 },
                    { id = "formless_ruins_telepad", weight = 5 },
                },
            },
        },
        loot_placements = {
            {
                group = "afs_formless_ruins_random_loot",
                x = { 0, 23 },
                y = { 0, 23 },
                chance = 50,
                repetitions = { 1, 4 },
            },
        },
        monster_group_placements = {
            {
                group = "AFS_GROUP_MOXIE_LOW_RISK",
                x = { 0, 23 },
                y = { 0, 23 },
                chance = 10,
                density = 0.1,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "afs_formless_ruins_dynamic" },
    weight = 100,
    layout = {
        rows = {
            "           .1           ",
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
            "            1           ",
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
        },
        palettes = { "afs_formless_ruins" },
        predecessor_mapgen = "glacial_field",
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested = {
            { id = "formless_forest", x = 0, y = 0, neighbors = { north = "forest" } },
            { id = "formless_forest", x = 0, y = 0, neighbors = { east = "forest" } },
            { id = "formless_forest", x = 0, y = 0, neighbors = { south = "forest" } },
            { id = "formless_forest", x = 0, y = 0, neighbors = { west = "forest" } },
        },
        nested_glyphs = {
            ["1"] = {
                choices = {
                    { id = "formless_ruins_ribs1", weight = 20 },
                    { id = "formless_ruins_ribs2", weight = 20 },
                    { id = "formless_ruins_room1", weight = 20 },
                    { id = "formless_ruins_room2", weight = 20 },
                    { id = "formless_ruins_room3", weight = 20 },
                    { id = "formless_ruins_room4", weight = 20 },
                    { id = "formless_ruins_room5", weight = 20 },
                    { id = "formless_ruins_room6", weight = 20 },
                    { id = "formless_ruins_twoway1", weight = 20 },
                    { id = "formless_ruins_twoway2", weight = 20 },
                    { id = "formless_ruins_twoway3", weight = 20 },
                    { id = "formless_ruins_pillar1", weight = 20 },
                    { id = "formless_ruins_pillar2", weight = 20 },
                    { id = "formless_ruins_orderly1", weight = 10 },
                    { id = "formless_ruins_orderly2", weight = 10 },
                    { id = "formless_ruins_orderly3", weight = 10 },
                    { id = "formless_ruins_orderly4", weight = 10 },
                    { id = "formless_ruins_empty1", weight = 10 },
                    { id = "formless_ruins_empty2", weight = 10 },
                    { id = "formless_ruins_empty3", weight = 10 },
                    { id = "formless_ruins_empty4", weight = 10 },
                    { id = "formless_ruins_cryoroom", weight = 10 },
                    { id = "formless_ruins_armory", weight = 10 },
                    { id = "formless_ruins_sleeping_room", weight = 10 },
                    { id = "formless_ruins_telepad", weight = 5 },
                },
            },
        },
        loot_placements = {
            {
                group = "afs_formless_ruins_random_loot",
                x = { 0, 23 },
                y = { 0, 23 },
                chance = 50,
                repetitions = { 1, 4 },
            },
        },
        monster_group_placements = {
            {
                group = "AFS_GROUP_MOXIE_LOW_RISK",
                x = { 0, 23 },
                y = { 0, 23 },
                chance = 10,
                density = 0.1,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "formless_ruins_cryoroom",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "///33/..///.",
            "/P.. ///////",
            "óP.....CCCC/",
            "///.. ...../",
            "/C.   .CC.#/",
            "/C.. ....../",
            "///../33ooo/",
            "/W   / ...W/",
            "/W   /P.C.W/",
            "///33///////",
            "##/ ..   .. ",
            "///////ó////",
        },
        terrain = { P = "t_metal_floor", C = "t_metal_floor", W = "t_metal_floor" },
        furniture = { P = "f_cooling_pylon", C = "f_cryo_pod", W = "f_workbench" },
        palettes = { "afs_formless_ruins" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested = { { id = "formless_ruins_cryoroom_roof", x = 0, y = 0, z = 1 } },
        item_groups = {
            W = {
                { group = "tools_science", chance = 80, repetitions = { 1, 3 } },
                { group = "afs_biomedical_scrapgroup", chance = 100, repetitions = { 1, 2 } },
                { group = "supplies_reagents_lab", chance = 80, repetitions = { 1, 3 } },
            },
        },
        monster_group_placements = {
            {
                group = "GROUP_CRYO_LAB",
                x = { 1, 5 },
                y = { 1, 2 },
                density = 0.1,
                repetitions = { 1, 3 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "formless_ruins_telepad",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "/     ..////",
            "/. ......../",
            "/.///3////C/",
            "///.........",
            "/C.    ooo#/",
            "/ ..  ....--",
            "/W .......1-",
            "/W  ......T-",
            "/W. ......1-",
            "//C.......--",
            "##/ooooo///.",
            "///..  //   ",
        },
        terrain = { C = "t_metal_floor", W = "t_metal_floor", T = "t_metal_floor" },
        furniture = { ["1"] = "f_machinery_heavy", C = "f_counter", W = "f_rack", T = "f_afs_telepad" },
        palettes = { "afs_formless_ruins" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested = { { id = "formless_ruins_telepad_roof", x = 0, y = 0, z = 1 } },
        item_groups = {
            W = {
                { group = "afs_experimental_combat_gear", chance = 10, repetitions = { 1, 2 } },
                { group = "afs_ruin_armory", chance = 50, repetitions = { 3, 6 } },
            },
            C = {
                { group = "afs_robotics_scrapgroup", chance = 20, repetitions = { 1, 2 } },
                {
                    group = "afs_machinery_maintenance_scrapgroup",
                    chance = 10,
                    repetitions = { 1, 2 },
                },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "formless_ruins_armory",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "/     ..////",
            "/. . ///////",
            "/....3.CCCC/",
            "// ///...../",
            "/C. / .CC.#/",
            "/ ../M...../",
            ".  .//33ooo/",
            ". ......  M/",
            "/.. /WWWWWW/",
            "//..///..../",
            "##/...  ... ",
            "///..  //   ",
        },
        terrain = { C = "t_metal_floor", W = "t_metal_floor" },
        furniture = { C = "f_counter", W = "f_rack" },
        palettes = { "afs_formless_ruins" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        item_groups = {
            W = {
                { group = "afs_ruin_armory", chance = 80, repetitions = { 3, 6 } },
                { group = "afs_any_energy_mag", chance = 50, repetitions = { 1, 2 } },
            },
            C = {
                { group = "afs_energy_weapon_armory", chance = 20, repetitions = { 1, 2 } },
                { group = "afs_any_energy_mag", chance = 10, repetitions = { 1, 2 } },
            },
        },
        monster_group_placements = { { group = "AFS_GROUP_ROBOT_LOW_RISK", x = { 0, 11 }, y = { 0, 11 }, density = 0.1 } },
        monster_glyphs = { M = { id = "mon_skitterbot", pack_size = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "formless_ruins_sleeping_room",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "/     ..  //",
            "/. . ///33//",
            "/....  ...P/",
            "// /  ....P/",
            "/C.  P....P/",
            "  ../P...///",
            "/. .//  .../",
            "/s  /P..  P/",
            "/s. /P    P/",
            "//33//   ///",
            "##/...   .. ",
            "///..  //   ",
        },
        terrain = { C = "t_metal_floor", s = "t_metal_floor" },
        furniture = { P = "f_sleep_pod", s = "f_sink" },
        palettes = { "afs_formless_ruins" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        item_groups = {
            P = { { group = "afs_formless_ruins_random_suit", chance = 80, repetitions = { 1, 2 } } },
        },
        monster_group_placements = { { group = "AFS_GROUP_MOXIE_LOW_RISK", x = { 0, 11 }, y = { 0, 11 }, density = 0.1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "formless_ruins_smallasrg",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "   ///",
            "/W.../",
            "/W.C./",
            "  .../",
            "  /66/",
            "  ////",
        },
        terrain = { ["6"] = "t_metal_floor", C = "t_metal_floor", W = "t_metal_floor" },
        furniture = { ["6"] = "f_console_broken", C = "f_compact_ASRG_containment", W = "f_workbench" },
        palettes = { "afs_formless_ruins" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        item_groups = {
            W = {
                { group = "tools_robotics", chance = 80, repetitions = { 1, 3 } },
                {
                    group = "afs_machinery_maintenance_scrapgroup",
                    chance = 100,
                    repetitions = { 1, 3 },
                },
                { group = "supplies_electronics", chance = 80, repetitions = { 1, 3 } },
            },
        },
        monster_group_placements = { { group = "AFS_GROUP_ROBOT_NEUTRAL_OLD", x = { 0, 5 }, y = { 0, 5 }, density = 0.05 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "formless_ruins_smallcryoroom",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "   ///",
            "/P.W./",
            "/#.../",
            "  3 C/",
            "  / C/",
            "  ////",
        },
        terrain = { P = "t_metal_floor", C = "t_metal_floor", W = "t_metal_floor" },
        furniture = { P = "f_cooling_pylon", C = "f_cryo_pod", W = "f_workbench" },
        palettes = { "afs_formless_ruins" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested = { { id = "formless_ruins_smallcryoroom_roof", x = 0, y = 0, z = 1 } },
        item_groups = {
            W = {
                { group = "tools_science", chance = 80, repetitions = { 1, 3 } },
                { group = "afs_biomedical_scrapgroup", chance = 100, repetitions = { 1, 2 } },
                { group = "supplies_reagents_lab", chance = 80, repetitions = { 1, 3 } },
            },
        },
        monster_group_placements = {
            {
                group = "GROUP_CRYO_LAB",
                x = { 1, 5 },
                y = { 1, 2 },
                density = 0.01,
                repetitions = { 1, 3 },
            },
        },
    },
}

-- forest map for when adjacent forests exists
ccb.content.define_mapgen {
    kind = "nested",
    id = "formless_forest",
    layout = {
        size = { width = 24, height = 24 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        tile_edits = {
            {
                shape = "point",
                operation = "terrain",
                id = "t_region_groundcover_forest",
                x = { 0, 23 },
                y = { 0, 23 },
                repetitions = { 50, 200 },
            },
            {
                shape = "point",
                operation = "terrain",
                id = "t_region_shrub",
                x = { 0, 23 },
                y = { 0, 23 },
                repetitions = { 50, 100 },
            },
            {
                shape = "point",
                operation = "terrain",
                id = "t_region_tree",
                x = { 0, 23 },
                y = { 0, 23 },
                repetitions = { 20, 50 },
            },
        },
    },
}
