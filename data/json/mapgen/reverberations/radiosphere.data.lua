local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = "radiosphere_radio_tower_top",
    layout = {
        rows = {
            "          g,gg,g        ",
            "          g,gg,g        ",
            "         ,,,,,,,,       ",
            "]gggggggg,gg,,gg,ggggggg",
            ",,,,,,,,,,g,,,,g,,,,,,,,",
            "ggggggggg,,,UU,,,ggggggg",
            "ggggggggg,,,UU,,,ggggggg",
            ",,,,,,,,,,g,,,,g,,,,,,,,",
            "]gggggggg,gg,,gg,ggggggg",
            "         ,,,,,,,,       ",
            "          g,gg,g        ",
            "          g,gg,g        ",
            "          g,gg,g        ",
            "          g,gg,g        ",
            "          g,gg,g        ",
            "          g,gg,g        ",
            "          g,gg,g        ",
            "          g,gg,g        ",
            "          ],gg,]        ",
            "          g,gg,g        ",
            "          g,gg,g        ",
            "          g,gg,g        ",
            "          g,gg,g        ",
            "          g,gg,g        ",
        },
        nested = {
            {
                x = 9,
                y = 2,
                choices = {
                    { id = "null", weight = 180 },
                    { id = "radio_tower_starving_beetles", weight = 40 },
                    { id = "radio_tower_flailer", weight = 15 },
                    { id = "mx_radiosphere_radio_tower", weight = 5 },
                },
            },
            {
                x = 10,
                y = 5,
                choices = { { id = "null", weight = 90 }, { id = "radio_tower_2x2_holdout", weight = 10 } },
            },
        },
        item_spawns = { [","] = { id = "dead_solar_beetle_radiosphere", chance = 1 } },
        fill_terrain = "t_open_air",
        palettes = { "roof_palette" },
        terrain = {
            U = {
                { id = "t_radio_tower", copies = 90 },
                { id = "t_radiosphere_radio_tower_liminal_light", copies = 4 },
            },
            ["]"] = {
                { id = "t_grate", copies = 50 },
                { id = "t_open_air", copies = 25 },
                { id = "t_radiosphere_radio_tower_liminal_light", copies = 25 },
            },
            a = "t_railing",
            [","] = "t_metal_floor_no_roof",
            g = { { id = "t_grate", copies = 80 }, { id = "t_open_air", copies = 20 } },
        },
        furniture = {
            U = {
                { id = "f_null", copies = 40 },
                { id = "f_cellphone_booster", copies = 20 },
                { id = "f_small_satellite_dish", copies = 20 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "radio_tower_flailer",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            " x xx x ",
            "xxxxxxxx",
            " xBBBBx ",
            "xxB  Bxx",
            "xxB  Bxx",
            " xBBBBx ",
            "xxxxxxxx",
            " x xx x ",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        monster_glyphs = {
            x = { { id = "mon_flailer_radiosphere", chance = 2 } },
            B = { { id = "mon_flailer_radiosphere", chance = 10 } },
        },
        item_spawns = { B = { { id = "blanket", chance = 50 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "radio_tower_starving_beetles",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            " x xx x ",
            "xxxxxxxx",
            " xxxxxx ",
            "xxx  xxx",
            "xxx  xxx",
            " xxxxxx ",
            "xxxxxxxx",
            " x xx x ",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        monster_glyphs = { x = { { id = "mon_beetle_solar_starving_reverberation", chance = 1 } } },
        item_spawns = { x = { { id = "dead_solar_beetle_radiosphere", chance = 5, repetitions = { 1, 3 } } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mx_radiosphere_radio_tower",
    weight = 100,
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            " cllllc ",
            "ctcllctc",
            "lcllLlcl",
            "lllcclll",
            "lllCTlll",
            "lcllLlcl",
            "ctcllctc",
            " cllllc ",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        field_glyphs = {
            l = { id = "fd_air_conditioner_radiosphere", intensity = 1 },
            c = { id = "fd_air_conditioner_radiosphere", intensity = 1 },
            C = { id = "fd_air_conditioner_radiosphere", intensity = 1 },
            t = { id = "fd_air_conditioner_radiosphere", intensity = 1 },
            T = { id = "fd_air_conditioner_radiosphere", intensity = 1 },
        },
        monster_glyphs = { l = { { id = "mon_beetle_solar_reverberation", chance = 1 } } },
        item_groups = {
            C = { group = "cash_register_random", chance = 100 },
            T = { group = "coffee_counter", chance = 20 },
            t = { group = "coffee_table", chance = 25 },
        },
        terrain = {
            [" "] = "t_open_air",
            l = "t_linoleum_white",
            c = "t_linoleum_white",
            C = "t_linoleum_white",
            t = "t_linoleum_white",
            T = "t_linoleum_white",
            L = "t_radiosphere_radio_tower_liminal_light",
        },
        furniture = {
            c = { { id = "f_null", copies = 40 }, { id = "f_chair", copies = 60 } },
            t = "f_table",
            T = "f_counter",
            C = "f_counter",
        },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "radiosphere_deletion_plane",
    layout = {
        rows = {
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
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        fill_terrain = "t_radiosphere_glowing_floor",
        terrain = { [" "] = "t_radiosphere_glowing_floor" },
    },
}

ccb.content.define_overmap_terrain {
    id = { "radiosphere_radio_tower_top" },
    vision_levels = "isolated_tower",
    name = ccb.content.text("radio tower"),
    symbol = ".",
    color = "light_gray",
    see_cost = "all_clear",
}

ccb.content.define_overmap_terrain {
    id = { "radiosphere_deletion_plane" },
    name = ccb.content.text("vanishing plane"),
    symbol = "~",
    color = "cyan",
    see_cost = "all_clear",
}
