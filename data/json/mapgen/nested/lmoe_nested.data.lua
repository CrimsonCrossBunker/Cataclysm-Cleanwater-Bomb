local ccb = require("ccb")

-- This is done in a nested map to make the flooring under the furniture look right, nothing much else.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lmoe3_storage_11x11",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "lllll|#####",
            "u___U|#####",
            "u_u_U|#####",
            "u_u_U|#####",
            "u_u_U|#####",
            "u_u_U|#####",
            "__v_U|#####",
            "u_v_U|#####",
            "u_v_U|#####",
            "u___U|#####",
            "AV_VU|#####",
        },
        palettes = { "bunker", "empty_bunker_items" },
    },
}

-- This is done in a nested map to make the flooring under the furniture look right, nothing much else.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lmoe3_tankroom_11x11",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "_{|l__aa|{_",
            "_{|l__aa||+",
            "_{|l____ll_",
            "_{|l_______",
            "__+________",
            "|||||||||||",
            "           ",
            "           ",
            "           ",
            "           ",
            "           ",
        },
        palettes = { "bunker", "empty_bunker_items" },
    },
}

-- This is done in a nested map to make the flooring under the furniture look right, nothing much else.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lmoe3_crafting_11x11",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "l__RRRR=_G",
            "l______*_a",
            "l_____c=_a",
            "__h___c=_l",
            "TTTcccc=_A",
            "||||||||||",
            "          ",
            "          ",
            "          ",
            "          ",
        },
        palettes = { "bunker", "empty_bunker_items" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "lmoe_exit_n",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "))_)))",
            ")#+##)",
            ")#..#)",
            ")#>>#)",
            ")####)",
            "))))))",
        },
        palettes = { "bunker_ext" },
        nested = { { id = "lmoe_exit_roof_n", x = 0, y = 0, z = 1 } },
    },
}

-- 6% chance of solar, 20% chance it's v2
ccb.content.define_mapgen {
    kind = "nested",
    id = "lmoe_exit_roof_n",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "((v(((",
            "(    (",
            "(    (",
            "(    (",
            "(    (",
            "((((((",
        },
        palettes = { "bunker_ext" },
        nested = {
            {
                choices = {
                    { id = "residential_1x2_solar", weight = 12 },
                    { id = "residential_2x2_solar", weight = 4 },
                    { id = "residential_1x3_solar", weight = 8 },
                    { id = "residential_1x2_solar_v2", weight = 3 },
                    { id = "residential_2x2_solar_v2", weight = 1 },
                    { id = "residential_1x3_solar_v2", weight = 2 },
                    { id = "null", weight = 470 },
                },
                x = 2,
                y = 2,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "lmoe_exit_s",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "))))))",
            ")####)",
            ")#>>#)",
            ")#..#)",
            ")#+##)",
            "))_)))",
        },
        palettes = { "bunker_ext" },
        nested = { { id = "lmoe_exit_roof_s", x = 0, y = 0, z = 1 } },
    },
}

-- 6% chance of solar, 20% chance it's v2
ccb.content.define_mapgen {
    kind = "nested",
    id = "lmoe_exit_roof_s",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "((((((",
            "(    (",
            "(    (",
            "(    (",
            "(    (",
            "((v(((",
        },
        palettes = { "bunker_ext" },
        nested = {
            {
                choices = {
                    { id = "residential_1x2_solar", weight = 12 },
                    { id = "residential_2x2_solar", weight = 4 },
                    { id = "residential_1x3_solar", weight = 8 },
                    { id = "residential_1x2_solar_v2", weight = 3 },
                    { id = "residential_2x2_solar_v2", weight = 1 },
                    { id = "residential_1x3_solar_v2", weight = 2 },
                    { id = "null", weight = 470 },
                },
                x = 2,
                y = 2,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "lmoe_exit_e",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "))))))",
            ")####)",
            ")#> +_",
            ")#> #)",
            ")####)",
            "))))))",
        },
        palettes = { "bunker_ext" },
        nested = { { id = "lmoe_exit_roof_e", x = 0, y = 0, z = 1 } },
    },
}

-- 6% chance of solar, 20% chance it's v2
ccb.content.define_mapgen {
    kind = "nested",
    id = "lmoe_exit_roof_e",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "((((((",
            "(    (",
            "(    v",
            "(    (",
            "(    (",
            "((((((",
        },
        palettes = { "bunker_ext" },
        nested = {
            {
                choices = {
                    { id = "residential_1x2_solar", weight = 12 },
                    { id = "residential_2x2_solar", weight = 4 },
                    { id = "residential_1x3_solar", weight = 8 },
                    { id = "residential_1x2_solar_v2", weight = 3 },
                    { id = "residential_2x2_solar_v2", weight = 1 },
                    { id = "residential_1x3_solar_v2", weight = 2 },
                    { id = "null", weight = 470 },
                },
                x = 2,
                y = 2,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "lmoe_exit_prepperquest_n",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "))_)))",
            ")#X##)",
            ")#..#)",
            ")#>>#)",
            ")####)",
            "))))))",
        },
        palettes = { "bunker_ext" },
        terrain = { X = "t_door_metal_locked" },
        nested = { { id = "lmoe_exit_roof_n", x = 0, y = 0, z = 1 } },
    },
}
