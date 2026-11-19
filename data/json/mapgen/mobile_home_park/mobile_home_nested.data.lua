local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "7x15_mobile_home_0",
    layout = {
        size = { width = 15, height = 15 },
        rows = {
            "      ||ooo||  ",
            "      |41O3F|  ",
            "      o1    o  ",
            "      o5  hho  ",
            "      |   ff|  ",
            "      *  Yhh|  ",
            "      |l ||||  ",
            "      oE +~9|  ",
            "      |  |tS|  ",
            "      ||+||||  ",
            "      |I T s|  ",
            "      |E  @@|  ",
            "      |   @@|  ",
            "      |Dd  s|  ",
            "      ||ooo||  ",
        },
        palettes = { "standard_domestic_palette", "standard_domestic_lino_bathroom" },
        terrain = { ["|"] = "t_wall_w" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested = {
            {
                choices = {
                    { id = "4x6_porch_0", weight = 1 },
                    { id = "4x6_porch_1", weight = 2 },
                    { id = "4x6_porch_2", weight = 1 },
                    { id = "4x6_porch_3", weight = 1 },
                },
                x = 0,
                y = 2,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "7x15_mobile_home_1",
    layout = {
        size = { width = 15, height = 15 },
        rows = {
            "      ||ooo||  ",
            "      |24O4F|  ",
            "      o3    o  ",
            "      o5   Ho  ",
            "      |Y hfH|  ",
            "      *  hfH|  ",
            "      |L ||||  ",
            "      o  +~9|  ",
            "      |y |tS|  ",
            "      ||+||||  ",
            "      |R s@@|  ",
            "      |d  @@|  ",
            "      |  h  |  ",
            "      |yrrrT|  ",
            "      ||ooo||  ",
        },
        palettes = { "standard_domestic_palette", "standard_domestic_lino_bathroom" },
        terrain = { ["|"] = "t_wall_w" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested = {
            {
                choices = {
                    { id = "4x6_porch_0", weight = 1 },
                    { id = "4x6_porch_1", weight = 2 },
                    { id = "4x6_porch_2", weight = 1 },
                    { id = "4x6_porch_3", weight = 1 },
                },
                x = 0,
                y = 2,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "7x15_mobile_home_4",
    layout = {
        size = { width = 15, height = 15 },
        rows = {
            "      ||ooo||  ",
            "      |HlETR|  ",
            "      oH   R|  ",
            "      |y Y R|  ",
            "      |  ||||  ",
            "      *  +~9|  ",
            "      |L |tS|  ",
            "      |1 ||||  ",
            "      oO   Ao  ",
            "      |F 352|  ",
            "      ||+||||  ",
            "      |y s@s|  ",
            "      |b  @ |  ",
            "      |d   E|  ",
            "      ||ooo||  ",
        },
        palettes = { "standard_domestic_palette", "standard_domestic_lino_bathroom" },
        terrain = { ["|"] = "t_wall_w" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested = {
            {
                choices = {
                    { id = "4x6_porch_0", weight = 1 },
                    { id = "4x6_porch_1", weight = 2 },
                    { id = "4x6_porch_2", weight = 1 },
                    { id = "4x6_porch_3", weight = 1 },
                },
                x = 0,
                y = 2,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "4x6_porch_0",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "      ",
            "      ",
            "  ....",
            "      ",
            "      ",
        },
        terrain = { ["."] = "t_region_soil" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "4x6_porch_1",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "      ",
            "    __",
            "  ..__",
            "    __",
            "      ",
        },
        terrain = { _ = "t_concrete", ["."] = "t_region_soil" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "4x6_porch_2",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "    ##",
            "    ||",
            "    |n",
            "  ..__",
            "    |h",
            "    ||",
        },
        terrain = {
            ["|"] = "t_railing",
            h = "t_floor_noroof",
            n = "t_floor_noroof",
            _ = "t_floor_noroof",
            ["."] = "t_region_soil",
            ["#"] = "t_region_shrub_decorative",
        },
        furniture = {
            h = { { id = "f_camp_chair" }, { id = "f_null" } },
            n = { { id = "f_tourist_table" }, { id = "f_null" } },
        },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "4x6_porch_3",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "  ....",
            "   #|_",
            "   #|_",
            "   #|_",
            "   #||",
            "   ###",
        },
        terrain = {
            ["|"] = "t_railing",
            _ = "t_floor_noroof",
            ["#"] = "t_region_shrub_decorative",
            ["."] = "t_region_soil",
        },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "trailer_fence_1",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "                        ",
            " |        @@@@@@@@@@@@| ",
            " |                    | ",
            " |                    | ",
            " |                    | ",
            " |                    | ",
            " |                    | ",
            " |                    | ",
            " |                    | ",
            " |                    | ",
            " |                    | ",
            " |                    | ",
            " |                    | ",
            " |                    | ",
            " |                    | ",
            " |                    | ",
            " |                    | ",
            " |                    | ",
            " |                    | ",
            " |                    | ",
            " |                    | ",
            " |                    | ",
            " |||||||||||||||||||||| ",
            "                        ",
        },
        terrain = { ["|"] = "t_splitrail_fence" },
        furniture = { ["@"] = "f_hedge_short" },
        rotation = { 0, 3 },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "trailer_fence_2",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "                        ",
            " |                      ",
            " |                      ",
            " |                      ",
            " |                      ",
            " |                      ",
            " |                      ",
            " |                      ",
            " |                      ",
            " |                      ",
            " |                      ",
            " |                      ",
            " |                      ",
            " |                      ",
            " |                      ",
            " |                      ",
            " |                      ",
            " |                      ",
            " |                      ",
            " |                      ",
            " |           |          ",
            " |           |          ",
            " |||||||||||||          ",
            "                        ",
        },
        terrain = { ["|"] = "t_privacy_fence" },
        furniture = { ["@"] = "f_hedge_short" },
        rotation = { 0, 3 },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "6x8_concrete",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            " ______ ",
            " ______ ",
            " ______ ",
            " ______ ",
            " ______ ",
            " ______ ",
            " ______ ",
            " ______ ",
        },
        terrain = { _ = "t_concrete" },
        rotation = { 0, 3 },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_tree",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "T",
        },
        terrain = { T = "t_region_tree" },
        flags = {
            "ALLOW_TERRAIN_UNDER_ITEMS",
            "ERASE_TRAP_BEFORE_PLACING_TERRAIN",
            "ERASE_FURNITURE_BEFORE_PLACING_TERRAIN",
        },
    },
}
