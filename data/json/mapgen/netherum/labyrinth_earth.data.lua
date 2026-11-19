local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = "earth_scrap_metal_spire",
    layout = {
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "     *                  ",
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
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        predecessor_mapgen = "field",
        nested_glyphs = { ["*"] = { id = "earth_scrap_metal_spire_0" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "earth_scrap_metal_spire_0",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "            ",
            "   !!!!!    ",
            " ,##...#!   ",
            " ,##.####!  ",
            "##.#......  ",
            "#..##.....! ",
            "#...,..###! ",
            "####......# ",
            " ....#######",
            ",##..#..## ,",
            " ,!!...!!,  ",
            "  ,!!O!!,   ",
        },
        terrain = {
            ["!"] = "t_nl_scrap_wall_scarlet",
            ["#"] = { { id = "t_dirt", copies = 10 }, { id = "t_nl_scrap_wall_scarlet", copies = 90 } },
            ["."] = "t_nl_scrap_floor",
            [","] = "t_scrap_scaffolding_scarlet",
            L = "t_nl_scrap_floor",
            ["<"] = "t_ladder_up",
            O = "t_nl_archway",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            { id = "earth_scrap_metal_spire_1", x = 0, y = 1, z = 1 },
            { id = "earth_scrap_metal_spire_2", x = 1, y = 2, z = 2 },
            { id = "earth_scrap_metal_spire_3-8", x = 2, y = 3, z = 3 },
            { id = "earth_scrap_metal_spire_3-8", x = 2, y = 3, z = 4 },
            { id = "earth_scrap_metal_spire_3-8", x = 2, y = 3, z = 5 },
            { id = "earth_scrap_metal_spire_3-8", x = 2, y = 3, z = 6 },
            { id = "earth_scrap_metal_spire_3-8", x = 2, y = 3, z = 7 },
            { id = "earth_scrap_metal_spire_3-8", x = 2, y = 3, z = 8 },
            { id = "earth_scrap_metal_spire_9", x = 3, y = 4, z = 9 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "earth_scrap_metal_spire_1",
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
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "earth_scrap_metal_spire_2",
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
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "earth_scrap_metal_spire_3-8",
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
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "earth_scrap_metal_spire_9",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            " ... ",
            ".....",
            "..A..",
            ".....",
            " ... ",
        },
        terrain = { ["."] = "t_nl_scrap_floor", L = "t_nl_scrap_floor", A = "t_nl_obelisk_earth" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}
