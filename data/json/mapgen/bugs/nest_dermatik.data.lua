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
