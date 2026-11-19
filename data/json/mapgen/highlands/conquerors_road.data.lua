local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "conquerors_road_open",
    layout = { nested = { { id = "conquerors_road_open", x = 0, y = 0 } } },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "conquerors_road_close",
    layout = { nested = { { id = "conquerors_road_close", x = 0, y = 0 } } },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "conquerors_road",
    layout = {
        rows = {
            "       ----------       ", "       -wwwwwwww-       ", " ----|||wwwwwwww|||---- ",
            " -GG||S----------S||GG- ", " -GG|XXXXX====XXXXX|GG- ", " -|||XXXXXñTTñXXXXX|||- ",
            "  |www-iiiiTTiiii-www|  ", "  -www-/iiiiiiii/-www-  ", "  -----//iiiiii//-----  ",
            "       ///iiii///       ", "    S  ////iii///  S    ", "    |t /////iii// t|    ",
            "    S  //////ii//  S    ", "   |||F//////ii//F|||   ", "   -w-F//////ii//F-w-   ",
            "   -S-F/////ii///F-S-   ", "   -w-F/////ii///F-w-   ", "   -w-F/////ii///F-w-   ",
            "   |||F/////ii///F|||   ", "   -|- ////ii//// -|-   ", "   -S- ////ii//// -S-   ",
            "   -w- ////ii//// -w-   ", "   --- ////ii//// ---   ", "       ////ii////       ",
        },
        erase_before_terrain = true,
        palettes = { "highland_structure" },
        terrain = {
            i = { { id = "t_stone_road", copies = 10 }, { id = "t_highland_groundcover", copies = 1 } },
            ["/"] = { { id = "t_stone_road", copies = 4 }, { id = "t_highland_groundcover", copies = 1 } },
            X = "t_highland_bronze_pillar",
            t = "t_stone_road",
            T = "t_highland_bronze_floor",
            ["="] = "t_highland_bronze_floor_inactive",
            G = "t_highland_flower_bed",
            ["ñ"] = "t_stone_masonry_floor",
            S = "t_highlands_conqueror_statue",
        },
        furniture = { ["ñ"] = "f_highlands_gatekeeper_statue" },
        item_spawns = {
            i = { id = "highland_censer", chance = 20 },
            ["/"] = { id = "highland_censer", chance = 2 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "conquerors_road_above",
    layout = {
        rows = {
            "       ..........       ", "       ..........       ", "     ..............     ",
            "    ................    ", "    .XX          XX.    ", "  ...XX          XX...  ",
            "  ....................  ", "   ..................   ", "   ....          ....   ",
            "   ...            ...   ", "   ...            ...   ", "   ...            ...   ",
            "   ....          ....   ", "   ..................   ", "   ..................   ",
            "   ..................   ", "   ..................   ", "   ....          ....   ",
            "   ...            ...   ", "    .              .    ", "                        ",
            "                        ", "                        ", "                        ",
        },
        erase_before_terrain = true,
        terrain = {
            [" "] = "t_open_air",
            ["."] = "t_stone_masonry_floor_balcony",
            X = "t_highland_bronze_pillar",
        },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "conquerors_road_above_1",
    layout = {
        rows = {
            "                        ", "                        ", "                        ",
            "                        ", "     XX          XX     ", "     XX          XX     ",
            "                        ", "                        ", "                        ",
            "                        ", "                        ", "                        ",
            "                        ", "                        ", "                        ",
            "                        ", "                        ", "                        ",
            "                        ", "                        ", "                        ",
            "                        ", "                        ", "                        ",
        },
        erase_before_terrain = true,
        terrain = { [" "] = "t_open_air", X = "t_highland_bronze_pillar" },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "conquerors_road_top",
    layout = {
        rows = {
            "                        ", "                        ", "                        ",
            "                        ", "     ..          ..     ", "     ..          ..     ",
            "                        ", "                        ", "                        ",
            "                        ", "                        ", "                        ",
            "                        ", "                        ", "                        ",
            "                        ", "                        ", "                        ",
            "                        ", "                        ", "                        ",
            "                        ", "                        ", "                        ",
        },
        erase_before_terrain = true,
        terrain = { [" "] = "t_open_air", ["."] = "t_stone_masonry_floor_balcony" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "conquerors_road_open",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            " ###################### ", " ###################### ", " ###################### ",
            " ###################### ", "  ###XXXXXTTTTXXXXX###  ", "                        ",
            "                        ", "                        ", "                        ",
            "                        ", "                        ", "                        ",
            "                        ", "                        ", "                        ",
            "                        ", "                        ", "                        ",
            "                        ", "                        ", "                        ",
            "                        ", "                        ", "                        ",
        },
        erase_before_terrain = true,
        terrain = { ["#"] = "t_nether_glass_wall", X = "t_highland_bronze_pillar", T = "t_distortion_floor" },
        traps = { T = "tr_imperial_road_go" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "conquerors_road_close",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            ",,,,,,,----------,,,,,,,", ",,,,,,,-wwwwwwww-,,,,,,,", ",----|||wwwwwwww|||----,",
            ",-GG|| ---------- ||GG-,", ",-GG|XXXXX====XXXXX|GG-,", ",-|||XXXXXS  SXXXXX|||-,",
            "                        ", "                        ", "                        ",
            "                        ", "                        ", "                        ",
            "                        ", "                        ", "                        ",
            "                        ", "                        ", "                        ",
            "                        ", "                        ", "                        ",
            "                        ", "                        ", "                        ",
        },
        erase_before_terrain = true,
        terrain = {
            [","] = "t_highland_groundcover",
            X = "t_highland_bronze_pillar",
            T = "t_highland_bronze_floor",
            ["="] = "t_highland_bronze_floor_inactive",
            G = "t_highland_flower_bed",
            S = "t_stone_masonry_floor",
            w = "t_water_sh",
            ["|"] = "t_rock_wall",
            ["-"] = "t_stone_fence",
        },
        furniture = { S = "f_highlands_gatekeeper_statue" },
    },
}
