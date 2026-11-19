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
