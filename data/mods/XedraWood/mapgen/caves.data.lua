local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "cave_underground_innawood" },
    weight = 500,
    layout = {
        fill_terrain = "t_dirt_underground",
        rows = {
            "........................",
            ".......         m ......",
            ".....m    mmmm     .....",
            ".....    mmmmmm    .....",
            "....m   m------m    ....",
            "...    m-%%%%%%-m   m...",
            "...   m-%%~~~~%%-m   ...",
            "...m m-%%~~~~~~%%-m m...",
            "...  m-%%~~~~~~%%-m  ...",
            "...   m-%%~~~~%%-m  m...",
            "...m   m-%%%%%%-m    ...",
            "....    m------m    ....",
            ".....    mmmmmm    m....",
            "......            m.....",
            ".......m        mm......",
            ".......           ......",
            "........        m.......",
            ".........       ........",
            "...........   ..........",
            "...........   ..........",
            "...........   ..........",
            "...........   ..........",
            "............<...........",
            "........................",
        },
        terrain = {
            ["."] = "t_soil",
            [" "] = "t_dirt_underground",
            ["<"] = "t_slope_up",
            ["~"] = "t_water_hot",
            m = "t_dirt_underground",
            ["%"] = {
                { id = "t_water_hot", copies = 3 },
                { id = "t_dirt_underground" },
            },
            ["-"] = {
                { id = "t_water_hot", copies = 1 },
                { id = "t_dirt_underground" },
            },
        },
        furniture = {
            m = {
                { id = "f_corpsefire_mushroom", copies = 1 },
                { id = "f_null", copies = 8 },
            },
        },
        monster_group_glyphs = {
            [" "] = { group = "GROUP_CAVE", chance = 2 },
        },
    },
}
