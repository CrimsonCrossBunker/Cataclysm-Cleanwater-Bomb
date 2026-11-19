local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "nest_dermatik_paper_roof",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "#",
        },
        terrain = { ["#"] = "t_roof_paper" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "nest_dermatik_paper_wall",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "#",
        },
        terrain = { ["#"] = "t_paper" },
        nested = { { id = "nest_dermatik_paper_roof", x = 0, y = 0, z = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "nest_dermatik_dirt_roof",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "#",
        },
        terrain = { ["#"] = "t_dirt" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "nest_dermatik_dirt_wall",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "#",
        },
        terrain = { ["#"] = "t_wall_dirt" },
        nested = { { id = "nest_dermatik_dirt_roof", x = 0, y = 0, z = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "nest_dermatik_roof",
    layout = {
        rows = {
            "                        ",
            "              -         ",
            "      -    ----         ",
            "     ---...-..---       ",
            "    --.--..-...--- -    ",
            "    -... .- ...------   ",
            "   -- .  .   ..-..---   ",
            "  --- ....- .   ..--    ",
            "  -   ..   ..... .---   ",
            "  - ..   .. .... --.-   ",
            "  -- .      ....  ..--  ",
            "   --... . .....  ...-- ",
            "  -- .  . ....... ..--- ",
            "  --      ...... . .--  ",
            "  -... ........   ...-  ",
            " - ...  .........  .--  ",
            "  --. .........  .---   ",
            " --   .......   . ..--  ",
            "--.... .. . . ... ...-  ",
            " - .          ......--  ",
            " ------...  .......--   ",
            "   ---- ...  -.-----    ",
            "      ---------- -      ",
            "       --- --           ",
        },
        terrain = { ["-"] = { { id = "t_dirt" } }, ["."] = { { id = "t_roof_paper" } } },
        fill_terrain = "t_open_air",
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "nest_dermatik",
    layout = {
        rows = {
            "                        ",
            "       t  t   -     t   ",
            "  t   -    ----         ",
            "     ---...-..---       ",
            "    --.--..-...--- -    ",
            "    -..0#.-#0..------   ",
            "   --#.##.###..-..---   ",
            " t---#....-#.###..-- t  ",
            "  -###..###.....#0---   ",
            "  -#..###..#....#--.-   ",
            "  --#.######....##0.--  ",
            "   --...#.#.....##...-- ",
            "  --#.##.#.......#..--- ",
            " t--######......#.#0--  ",
            "  -...#........###...-  ",
            " -#.0.##.........##.--  ",
            "  --.#.........##.---   ",
            " --###.......###.#.0--  ",
            "--.0..#..#.#.#..0#...-  ",
            " -#.##########......--  ",
            " ------...##..0....--   ",
            "   ----#..0##-.-----    ",
            "  t   ---------- -   t  ",
            "       --- --           ",
        },
        terrain = {
            t = { { id = "t_region_tree" }, { id = "t_region_groundcover" } },
            [","] = { { id = "t_region_tree" } },
            ["-"] = { { id = "t_wall_dirt" } },
            ["."] = { { id = "t_mud_underground" }, { id = "t_floor_paper", copies = 2 } },
            ["0"] = { { id = "t_pit_shallow" } },
        },
        fill_terrain = "t_region_groundcover",
        nested_glyphs = {
            ["#"] = {
                choices = {
                    { id = "nest_dermatik_paper_wall", weight = 3 },
                    { id = "nest_dermatik_dirt_wall", weight = 1 },
                },
            },
        },
        monster_glyphs = { ["0"] = { group = "GROUP_DERMATIK_INCUB", chance = 70 } },
        field_placements = {
            { id = "fd_blood", x = { 3, 19 }, y = { 4, 20 }, repetitions = { 30, 50 } },
            { id = "fd_blood_insect", x = { 3, 19 }, y = { 4, 20 }, repetitions = { 20, 30 } },
        },
        monster_placements = {
            { id = "mon_dermatik_larva", x = { 3, 22 }, y = { 8, 22 }, repetitions = { 2, 4 } },
            { id = "mon_dermatik_midwife", x = { 10, 12 }, y = { 14, 17 }, repetitions = { 0, 2 } },
            { id = "mon_dermatik", x = { 0, 23 }, y = { 0, 23 }, repetitions = { 1, 4 } },
        },
    },
}
