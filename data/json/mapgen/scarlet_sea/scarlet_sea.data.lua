local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = "scarlet_sea_reverberation",
    layout = {
        rows = {
            "       1               .",
            " 1              1      .",
            "                       .",
            "     1                 .",
            "                       .",
            "              1        .",
            "                       .",
            "                       .",
            "1      1               .",
            "                       .",
            "                 1     .",
            "         1             .",
            "                       .",
            "                       .",
            " 1                     .",
            "              1        .",
            "                       .",
            "      1          1     .",
            "                       .",
            "                       .",
            "                       .",
            "                       .",
            "                       .",
            "........................",
        },
        terrain = { [" "] = "t_water_sh_scarlet", ["1"] = "t_water_sh_scarlet", ["."] = "t_water_sh_scarlet" },
        fill_terrain = "t_water_sh_scarlet",
        nested_glyphs = {
            ["1"] = {
                choices = {
                    { id = "null", weight = 95 },
                    { id = "scarlet_island_reverberation", weight = 5 },
                },
            },
            [" "] = { choices = { { id = "null", weight = 399 }, { id = "scarlet_light", weight = 1 } } },
        },
        field_glyphs = {
            [" "] = { { id = "fd_scarlet_atmosphere" } },
            ["1"] = { { id = "fd_scarlet_atmosphere" } },
            ["."] = { { id = "fd_scarlet_atmosphere" } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "scarlet_light",
    layout = {
        size = { width = 2, height = 2 },
        rows = {
            "1~",
            "L1",
        },
        terrain = {
            L = "t_scarlet_light",
            ["~"] = "t_water_sh_scarlet_wave",
            ["1"] = {
                { id = "t_water_sh_scarlet", copies = 90 },
                { id = "t_water_sh_scarlet_wave", copies = 10 },
            },
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        field_glyphs = {
            L = { { id = "fd_scarlet_atmosphere" } },
            ["~"] = { { id = "fd_scarlet_atmosphere" } },
            ["1"] = { { id = "fd_scarlet_atmosphere" } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "scarlet_island_reverberation",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "  .~~  ",
            " ....~ ",
            "...#..~",
            "..###.~",
            "...#...",
            " ..... ",
            "  ...  ",
        },
        terrain = {
            ["#"] = "t_sand_scarlet",
            ["."] = { { id = "t_sand_scarlet", copies = 60 }, { id = "t_water_sh_scarlet", copies = 40 } },
            ["~"] = {
                { id = "t_sand_scarlet", copies = 60 },
                { id = "t_water_sh_scarlet_wave", copies = 40 },
            },
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        field_glyphs = {
            [" "] = { { id = "fd_scarlet_atmosphere" } },
            ["."] = { { id = "fd_scarlet_atmosphere" } },
            ["#"] = { { id = "fd_scarlet_atmosphere" } },
            ["~"] = { { id = "fd_scarlet_atmosphere" } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "scarlet_scrap_metal_spire",
    layout = {
        rows = {
            "                       .",
            "                       .",
            "                       .",
            "     2                 .",
            "                       .",
            "                       .",
            "                       .",
            "                       .",
            "                       .",
            "                       .",
            "                       .",
            "                       .",
            "                       .",
            "                       .",
            " 1                     .",
            "              1        .",
            "                       .",
            "      1          1     .",
            "                       .",
            "                       .",
            "                       .",
            "                       .",
            "                       .",
            "........................",
        },
        terrain = { [" "] = "t_water_sh_scarlet", ["1"] = "t_water_sh_scarlet", ["."] = "t_water_sh_scarlet" },
        fill_terrain = "t_water_sh_scarlet",
        nested_glyphs = {
            ["1"] = {
                choices = {
                    { id = "null", weight = 95 },
                    { id = "scarlet_island_reverberation", weight = 5 },
                },
            },
            [" "] = { choices = { { id = "null", weight = 399 }, { id = "scarlet_light", weight = 1 } } },
            ["2"] = { id = "scarlet_scrap_metal_spire_0" },
        },
        field_glyphs = {
            [" "] = { { id = "fd_scarlet_atmosphere" } },
            ["1"] = { { id = "fd_scarlet_atmosphere" } },
            ["."] = { { id = "fd_scarlet_atmosphere" } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "scarlet_light",
    layout = {
        size = { width = 2, height = 2 },
        rows = {
            "1~",
            "L1",
        },
        terrain = {
            L = "t_scarlet_light",
            ["~"] = "t_water_sh_scarlet_wave",
            ["1"] = {
                { id = "t_water_sh_scarlet", copies = 90 },
                { id = "t_water_sh_scarlet_wave", copies = 10 },
            },
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        field_glyphs = {
            L = { { id = "fd_scarlet_atmosphere" } },
            ["~"] = { { id = "fd_scarlet_atmosphere" } },
            ["1"] = { { id = "fd_scarlet_atmosphere" } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "scarlet_scrap_metal_spire_0",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "    ~~~~    ",
            "   !!!!!~   ",
            " ,##...#!~  ",
            " ,##.####!~ ",
            "##.#......~ ",
            "#..##.....!~",
            "#...,..###! ",
            "####......#~",
            " ....#######",
            ",##..#..## ,",
            " ,!!...!!,  ",
            "  ,!!O!!,   ",
        },
        terrain = {
            ["!"] = "t_nl_scrap_wall_scarlet",
            ["#"] = {
                { id = "t_water_sh_scarlet", copies = 10 },
                { id = "t_nl_scrap_wall_scarlet", copies = 90 },
            },
            ["."] = "t_nl_scrap_floor",
            [","] = "t_scrap_scaffolding_scarlet",
            L = "t_nl_scrap_floor",
            [" "] = "t_water_sh_scarlet",
            ["~"] = "t_water_sh_scarlet_wave",
            ["<"] = "t_ladder_up",
            O = "t_nl_archway",
        },
        furniture = { L = "f_nl_exodii_lamp" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            { id = "scarlet_scrap_metal_spire_1", x = 0, y = 1, z = 1 },
            { id = "scarlet_scrap_metal_spire_2", x = 1, y = 2, z = 2 },
            { id = "scarlet_scrap_metal_spire_3-8", x = 2, y = 3, z = 3 },
            { id = "scarlet_scrap_metal_spire_3-8", x = 2, y = 3, z = 4 },
            { id = "scarlet_scrap_metal_spire_3-8", x = 2, y = 3, z = 5 },
            { id = "scarlet_scrap_metal_spire_3-8", x = 2, y = 3, z = 6 },
            { id = "scarlet_scrap_metal_spire_3-8", x = 2, y = 3, z = 7 },
            { id = "scarlet_scrap_metal_spire_3-8", x = 2, y = 3, z = 8 },
            { id = "scarlet_scrap_metal_spire_9", x = 3, y = 4, z = 9 },
        },
        field_glyphs = {
            ["!"] = { { id = "fd_scarlet_atmosphere" } },
            ["#"] = { { id = "fd_scarlet_atmosphere" } },
            ["."] = { { id = "fd_scarlet_atmosphere" } },
            [","] = { { id = "fd_scarlet_atmosphere" } },
            [" "] = { { id = "fd_scarlet_atmosphere" } },
            ["~"] = { { id = "fd_scarlet_atmosphere" } },
            O = { { id = "fd_scarlet_atmosphere" } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "scarlet_scrap_metal_spire_1",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "    ,,,    ",
            "   ,###,   ",
            "  ,##.##,  ",
            " ,##...##, ",
            ",##.....##,",
            ",#.......#,",
            ",##.....##,",
            " ,##...##, ",
            "  ,##.##,  ",
            "   ,###,   ",
            "    ,,,    ",
        },
        terrain = {
            ["#"] = {
                { id = "t_nl_scrap_floor", copies = 10 },
                { id = "t_nl_scrap_wall_scarlet", copies = 90 },
            },
            ["."] = { { id = "t_open_air", copies = 50 }, { id = "t_nl_scrap_wall_scarlet", copies = 50 } },
            [","] = { { id = "t_scrap_scaffolding_scarlet" } },
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        field_glyphs = {
            ["#"] = { { id = "fd_scarlet_atmosphere" } },
            ["."] = { { id = "fd_scarlet_atmosphere" } },
            [","] = { { id = "fd_scarlet_atmosphere" } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "scarlet_scrap_metal_spire_2",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "   ,,,   ",
            "  ,###,  ",
            " ,##.##, ",
            ",##...##,",
            ",#.....#,",
            ",##...##,",
            " ,##.##, ",
            "  ,###,  ",
            "   ,,,   ",
        },
        terrain = {
            ["#"] = {
                { id = "t_nl_scrap_floor", copies = 10 },
                { id = "t_nl_scrap_wall_scarlet", copies = 90 },
            },
            ["."] = { { id = "t_open_air", copies = 50 }, { id = "t_nl_scrap_wall_scarlet", copies = 50 } },
            [","] = { { id = "t_scrap_scaffolding_scarlet" } },
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        field_glyphs = {
            ["#"] = { { id = "fd_scarlet_atmosphere" } },
            ["."] = { { id = "fd_scarlet_atmosphere" } },
            [","] = { { id = "fd_scarlet_atmosphere" } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "scarlet_scrap_metal_spire_3-8",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "  ,,,  ",
            " ,###, ",
            ",##.##,",
            ",#...#,",
            ",##.##,",
            " ,###, ",
            "  ,,,  ",
        },
        terrain = {
            ["#"] = {
                { id = "t_nl_scrap_floor", copies = 10 },
                { id = "t_nl_scrap_wall_scarlet", copies = 90 },
            },
            ["."] = "t_open_air",
            [","] = "t_scrap_scaffolding_scarlet",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        field_glyphs = {
            ["#"] = { { id = "fd_scarlet_atmosphere" } },
            ["."] = { { id = "fd_scarlet_atmosphere" } },
            [","] = { { id = "fd_scarlet_atmosphere" } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "scarlet_scrap_metal_spire_9",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            " .A. ",
            ".....",
            ".....",
            ".....",
            " .L. ",
        },
        terrain = { ["."] = "t_nl_scrap_floor", L = "t_nl_scrap_floor", A = "t_nl_obelisk_scarlet" },
        furniture = { L = "f_nl_exodii_lamp" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        field_glyphs = {
            ["."] = { { id = "fd_scarlet_atmosphere" } },
            A = { { id = "fd_scarlet_atmosphere" } },
            L = { { id = "fd_scarlet_atmosphere" } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "scarlet_sea_xedra_hew",
    layout = {
        rows = {
            "                       ,",
            "                       ,",
            "    .....~~            ,",
            "   ..#a##..~           ,",
            "    ..####..~          ,",
            "   ...###T#..~         ,",
            "    ...#####..~        ,",
            "     ...a#@f#..~       ,",
            "      ...#####..~      ,",
            "       ...####a..~     ,",
            "        ........       ,",
            "         1             ,",
            "                       ,",
            "                       ,",
            " 1                     ,",
            "              1        ,",
            "                       ,",
            "      1          1     ,",
            "                       ,",
            "                       ,",
            "                       ,",
            "                       ,",
            "                       ,",
            ",,,,,,,,,,,,,,,,,,,,,,,,",
        },
        furniture = {
            T = "f_xedra_mobile_weather_station",
            a = "f_xedra_antenna",
            f = "f_foot_locker_aluminum",
        },
        terrain = {
            ["#"] = "t_sand_scarlet",
            ["@"] = "t_sand_scarlet",
            [","] = "t_water_sh_scarlet",
            T = "t_sand_scarlet",
            a = "t_sand_scarlet",
            f = "t_sand_scarlet",
            ["."] = { { id = "t_sand_scarlet", copies = 60 }, { id = "t_water_sh_scarlet", copies = 40 } },
            ["~"] = {
                { id = "t_sand_scarlet", copies = 60 },
                { id = "t_water_sh_scarlet_wave", copies = 40 },
            },
        },
        fill_terrain = "t_water_sh_scarlet",
        nested_glyphs = {
            ["1"] = {
                choices = {
                    { id = "null", weight = 95 },
                    { id = "scarlet_island_reverberation", weight = 5 },
                },
            },
            [" "] = { choices = { { id = "null", weight = 399 }, { id = "scarlet_light", weight = 1 } } },
        },
        monster_placements = { { id = "mon_zombie_xedra_scarlet_sea", x = 10, y = 7, chance = 100 } },
        loot_placements = {
            { id = "folded_inflatable_boat", x = 11, y = 7, chance = 100 },
            { id = "hand_pump", x = 11, y = 7, chance = 100 },
            { group = "wrapped_gasmask_filter", x = 11, y = 7, chance = 100, repetitions = 20 },
        },
        field_glyphs = {
            [" "] = { { id = "fd_scarlet_atmosphere" } },
            [","] = { { id = "fd_scarlet_atmosphere" } },
            ["#"] = { { id = "fd_scarlet_atmosphere" } },
            T = { { id = "fd_scarlet_atmosphere" } },
            a = { { id = "fd_scarlet_atmosphere" } },
            ["."] = { { id = "fd_scarlet_atmosphere" } },
            ["~"] = { { id = "fd_scarlet_atmosphere" } },
            f = { { id = "fd_scarlet_atmosphere" } },
        },
    },
}
