local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "roof_6x6_greenhouse_roof",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "RRRRRR",
            "RRRRRR",
            "RRRRRR",
            "RRRRRR",
            "RRRRRR",
            "RRRRRR",
        },
        terrain = { R = "t_glass_roof" },
    },
}

-- zen garden.
ccb.content.define_mapgen {
    kind = "nested",
    id = "roof_6x6_garden_4",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "bb__bb",
            "b2222b",
            "_22G2_",
            "_2G22_",
            "b2222b",
            "bb__bb",
        },
        terrain = { _ = "t_railroad_rubble", b = "t_railroad_rubble", ["2"] = "t_sandbox", G = "t_sandbox" },
        furniture = { G = { { id = "f_boulder_medium" }, { id = "f_boulder_large" } }, b = "f_bench" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "residential_6kW_solar_v1",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "#####",
            "#####",
            "#####",
            "#####",
            "#####",
        },
        terrain = { ["#"] = "t_flat_roof" },
        furniture = { ["#"] = "f_solar_unit" },
        rotation = { 0, 3 },
        flags = { "ERASE_ITEMS_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "residential_6kW_solar_v2",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "###  ",
            "###  ",
            "?##  ",
            " ##  ",
            " ##  ",
        },
        terrain = { ["#"] = "t_flat_roof", ["?"] = "t_flat_roof" },
        furniture = {
            ["#"] = "f_solar_unit_v2",
            ["?"] = { { id = "f_solar_unit_v2", copies = 1 }, { id = "f_null", copies = 1 } },
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ITEMS_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "residential_6kW_solar",
    layout = {
        size = { width = 5, height = 5 },
        nested = {
            {
                choices = {
                    { id = "residential_6kW_solar_v1", weight = 80 },
                    { id = "residential_6kW_solar_v2", weight = 20 },
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "residential_7kW_solar_v1",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "######",
            "######",
            "######",
            "######",
            "######",
            "      ",
        },
        terrain = { ["#"] = "t_flat_roof" },
        furniture = { ["#"] = "f_solar_unit" },
        rotation = { 0, 3 },
        flags = { "ERASE_ITEMS_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "residential_7kW_solar_v2",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "###   ",
            "###   ",
            "###   ",
            "###   ",
            "###   ",
            "      ",
        },
        terrain = { ["#"] = "t_flat_roof" },
        furniture = { ["#"] = "f_solar_unit_v2" },
        rotation = { 0, 3 },
        flags = { "ERASE_ITEMS_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "residential_7kW_solar",
    layout = {
        size = { width = 6, height = 6 },
        nested = {
            {
                choices = {
                    { id = "residential_7kW_solar_v1", weight = 80 },
                    { id = "residential_7kW_solar_v2", weight = 20 },
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "residential_8kW_solar_v1",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "######",
            "######",
            "######",
            "######",
            "######",
            "######",
        },
        terrain = { ["#"] = "t_flat_roof" },
        furniture = { ["#"] = "f_solar_unit" },
        rotation = { 0, 3 },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "residential_8kW_solar_v2",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "###   ",
            "###   ",
            "###   ",
            "###   ",
            "###   ",
            "###   ",
        },
        terrain = { ["#"] = "t_flat_roof" },
        furniture = { ["#"] = "f_solar_unit_v2" },
        rotation = { 0, 3 },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "residential_8kW_solar",
    layout = {
        size = { width = 6, height = 6 },
        nested = {
            {
                choices = {
                    { id = "residential_8kW_solar_v1", weight = 80 },
                    { id = "residential_8kW_solar_v2", weight = 20 },
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "roof_4x4_holdout",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "xxxx",
            "xct ",
            "x   ",
            "    ",
        },
        furniture = { c = "f_camp_chair", x = "f_sandbag_wall", t = "f_table" },
        loot_placements = {
            { group = "SUS_trash_roof", x = { 0, 3 }, y = 3, chance = 30, repetitions = { 1, 2 } },
            { group = "alcohol_bottled_canned", x = { 1, 3 }, y = 3, chance = 80 },
            { group = "stash_food", x = 2, y = 1, chance = 50, repetitions = { 2, 3 } },
            {
                group = "roof_holdout",
                x = { 1, 3 },
                y = { 1, 3 },
                chance = 70,
                repetitions = { 2, 4 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "roof_4x4_party",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            " ct ",
            "    ",
            " b c",
            "c   ",
        },
        furniture = { c = "f_camp_chair", b = "f_brazier", t = "f_table" },
        item_group_placements = {
            {
                group = "SUS_trash_roof",
                x = { 0, 3 },
                y = { 0, 3 },
                chance = 35,
                repetitions = { 1, 2 },
            },
            { group = "alcohol_bottled_canned", x = { 1, 2 }, y = 2, chance = 50 },
            { group = "snacks", x = 2, y = 1, chance = 50, repetitions = { 2, 3 } },
            { group = "stash_drugs", x = 2, y = 1, chance = 10, repetitions = { 1, 2 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "roof_16x16_help",
    layout = {
        size = { width = 16, height = 16 },
        rotation = { 0, 0 },
        loot_placements = {
            { group = "roof_sign", x = 0, y = 0 },
            { group = "roof_sign", x = 0, y = 1 },
            { group = "roof_sign", x = 0, y = 2 },
            { group = "roof_sign", x = 0, y = 3 },
            { group = "roof_sign", x = 0, y = 4 },
            { group = "roof_sign", x = 1, y = 2 },
            { group = "roof_sign", x = 2, y = 2 },
            { group = "roof_sign", x = 3, y = 0 },
            { group = "roof_sign", x = 3, y = 1 },
            { group = "roof_sign", x = 3, y = 2 },
            { group = "roof_sign", x = 3, y = 3 },
            { group = "roof_sign", x = 3, y = 4 },
            { group = "roof_sign", x = 5, y = 0 },
            { group = "roof_sign", x = 5, y = 1 },
            { group = "roof_sign", x = 5, y = 2 },
            { group = "roof_sign", x = 5, y = 3 },
            { group = "roof_sign", x = 5, y = 4 },
            { group = "roof_sign", x = 6, y = 0 },
            { group = "roof_sign", x = 6, y = 2 },
            { group = "roof_sign", x = 6, y = 4 },
            { group = "roof_sign", x = 7, y = 0 },
            { group = "roof_sign", x = 7, y = 4 },
            { group = "roof_sign", x = 9, y = 0 },
            { group = "roof_sign", x = 9, y = 1 },
            { group = "roof_sign", x = 9, y = 2 },
            { group = "roof_sign", x = 9, y = 3 },
            { group = "roof_sign", x = 9, y = 4 },
            { group = "roof_sign", x = 10, y = 4 },
            { group = "roof_sign", x = 11, y = 4 },
            { group = "roof_sign", x = 13, y = 0 },
            { group = "roof_sign", x = 13, y = 1 },
            { group = "roof_sign", x = 13, y = 2 },
            { group = "roof_sign", x = 13, y = 3 },
            { group = "roof_sign", x = 13, y = 4 },
            { group = "roof_sign", x = 14, y = 0 },
            { group = "roof_sign", x = 14, y = 2 },
            { group = "roof_sign", x = 15, y = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "roof_5x5_coop",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "xxxxx",
            "x__tx",
            "+__tx",
            "xtttx",
            "xxxxx",
        },
        terrain = {
            _ = "t_dirtfloor_no_roof",
            ["+"] = "t_chickenwire_gate_c",
            x = "t_chickenwire_fence",
            t = "t_dirtfloor_no_roof",
        },
        furniture = { t = "f_table" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = {
            { id = "straw_pile", x = { 1, 3 }, y = 3, chance = 75, repetitions = { 1, 3 } },
            { id = "straw_pile", x = 3, y = { 1, 3 }, chance = 75, repetitions = { 1, 3 } },
        },
        monster_placements = {
            { id = "mon_pigeon", x = { 1, 3 }, y = { 1, 3 }, chance = 60, pack_size = { 2, 4 } },
            { id = "mon_chicken", x = { 1, 3 }, y = { 1, 3 }, chance = 20, pack_size = { 1, 2 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "roof_1x1_birdnest",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            " ",
        },
        loot_placements = {
            { id = "twig", x = 0, y = 0, chance = 100, repetitions = { 5, 10 } },
            { id = "feather", x = 0, y = 0, chance = 70, repetitions = { 1, 5 } },
            { group = "any_wild_egg", x = 0, y = 0, chance = 30, repetitions = { 1, 3 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_gutter_horizontal",
    layout = {
        size = { width = 24, height = 24 },
        tile_edits = {
            {
                shape = "line",
                operation = "terrain",
                id = "t_gutter",
                x = 0,
                y = 0,
                end_x = 23,
                end_y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_gutter_vertical",
    layout = {
        size = { width = 24, height = 24 },
        tile_edits = {
            {
                shape = "line",
                operation = "terrain",
                id = "t_gutter",
                x = 0,
                y = 0,
                end_x = 0,
                end_y = 23,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "roof_4x4_survivor",
    layout = {
        size = { width = 4, height = 4 },
        furniture_placements = { { id = "f_camp_chair", x = 0, y = 0 }, { id = "f_makeshift_bed", x = 2, y = 0 } },
        loot_placements = {
            { group = "cannedfood", x = 1, y = 0, repetitions = { 2, 3 } },
            { group = "camping", x = { 0, 3 }, y = { 0, 3 }, chance = 50, repetitions = { 2, 3 } },
            { id = "blanket", x = 2, y = 0, chance = 50, repetitions = { 1, 2 } },
            { id = "can_drink", x = 1, y = 1, chance = 30, repetitions = { 2, 3 } },
            { id = "can_food", x = 1, y = 1, chance = 40, repetitions = { 2, 3 } },
            { id = "can_food", x = 1, y = 1, chance = 40, repetitions = { 2, 3 } },
            { id = "sleeping_bag", x = 3, y = 1, chance = 40 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "roof_2x2_infrastructure",
    layout = {
        size = { width = 2, height = 2 },
        furniture_placements = { { id = "f_vent_pipe", x = 0, y = 0 }, { id = "f_roof_turbine_vent", x = 0, y = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "roof_2x2_infrastructure_1",
    layout = {
        size = { width = 2, height = 2 },
        furniture_placements = {
            { id = "f_small_satellite_dish", x = 1, y = 0 },
            { id = "f_cellphone_booster", x = 0, y = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "roof_2x2_infrastructure_2",
    layout = {
        size = { width = 2, height = 2 },
        flags = { "ALLOW_TERRAIN_UNDER_FURNITURE" },
        terrain_placements = { { id = "t_switchgear_s", x = 0, y = 0 }, { id = "t_sai_box", x = 0, y = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "roof_2x2_utilities_b",
    layout = {
        size = { width = 2, height = 2 },
        furniture_placements = {
            { id = "f_water_heater_family", x = 0, y = 0 },
            { id = "f_water_purifier", x = 0, y = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "roof_2x2_utilities_c",
    layout = {
        size = { width = 2, height = 2 },
        furniture_placements = { { id = "f_water_heater", x = 0, y = 0 }, { id = "f_solar_unit", x = 0, y = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "roof_2x2_utilities_d",
    layout = {
        size = { width = 2, height = 2 },
        furniture_placements = { { id = "f_water_heater", x = 0, y = 0 }, { id = "f_air_conditioner", x = 0, y = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "roof_3x3_wine",
    layout = {
        size = { width = 3, height = 3 },
        furniture_placements = {
            { id = "f_camp_chair", x = 0, y = 0 },
            { id = "f_camp_chair", x = 2, y = 0 },
            { id = "f_tourist_table", x = 1, y = 0 },
        },
        loot_placements = {
            { group = "wines_worthy", x = 1, y = 0 },
            { id = "glass", x = 1, y = 0, repetitions = 2 },
            { id = "survivor_scope", x = 0, y = 2, chance = 20 },
            { id = "diamond_ring", x = 0, y = 0, chance = 10 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "roof_2x2_utilities",
    layout = {
        size = { width = 2, height = 2 },
        furniture_placements = {
            { id = "f_water_heater", x = 0, y = 0 },
            { id = "f_air_conditioner", x = 1, y = 0 },
            { id = "f_solar_unit", x = 0, y = 1 },
            { id = "f_water_purifier", x = 1, y = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "roof_6x6_survivor",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "..AA..",
            "......",
            "..a...",
            ".o..o.",
            "......",
            "....A.",
        },
        furniture = { o = "f_camp_chair", a = "f_brazier", A = "f_tourist_table" },
        rotation = { 0, 3 },
        loot_placements = {
            { group = "cannedfood", x = { 2, 3 }, y = 0, repetitions = { 2, 3 } },
            { group = "camping", x = { 0, 5 }, y = { 0, 3 }, chance = 50, repetitions = { 2, 3 } },
            { group = "stash_wood", x = 1, y = 2, repetitions = { 2, 3 } },
            { group = "bed", x = 5, y = 5, chance = 50, repetitions = { 1, 2 } },
            { group = "bed", x = 3, y = 5, chance = 50, repetitions = { 1, 2 } },
            { id = "jug_plastic", x = 0, y = 0 },
            { id = "can_drink", x = { 0, 5 }, y = { 0, 5 }, chance = 30, repetitions = { 2, 3 } },
            { id = "can_food", x = { 0, 5 }, y = { 0, 5 }, chance = 40, repetitions = { 2, 3 } },
        },
        tile_edits = {
            { shape = "point", operation = "trap", id = "tr_funnel", x = 0, y = 0 },
            { shape = "point", operation = "trap", id = "tr_cot", x = 5, y = 5 },
            { shape = "point", operation = "trap", id = "tr_cot", x = 3, y = 5 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "residential_2x2_solar",
    layout = {
        size = { width = 2, height = 2 },
        furniture_placements = { { id = "f_solar_unit", x = { 0, 1 }, y = { 0, 1 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "residential_1x2_solar",
    layout = {
        size = { width = 2, height = 2 },
        furniture_placements = { { id = "f_solar_unit", x = 0, y = { 0, 1 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "residential_1x3_solar",
    layout = {
        size = { width = 3, height = 3 },
        furniture_placements = { { id = "f_solar_unit", x = 0, y = { 0, 2 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "residential_3x3_solar",
    layout = {
        size = { width = 3, height = 3 },
        furniture_placements = { { id = "f_solar_unit", x = { 0, 2 }, y = { 0, 2 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "industrial_1x5_solar",
    layout = {
        size = { width = 5, height = 5 },
        furniture_placements = { { id = "f_solar_unit", x = { 0, 4 }, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "industrial_1x1_solar",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_solar_unit", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "residential_2x2_solar_v2",
    layout = {
        size = { width = 2, height = 2 },
        furniture_placements = { { id = "f_solar_unit_v2", x = { 0, 1 }, y = { 0, 1 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "residential_1x2_solar_v2",
    layout = {
        size = { width = 2, height = 2 },
        furniture_placements = { { id = "f_solar_unit_v2", x = 0, y = { 0, 1 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "residential_1x3_solar_v2",
    layout = {
        size = { width = 3, height = 3 },
        furniture_placements = { { id = "f_solar_unit_v2", x = 0, y = { 0, 2 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "residential_3x3_solar_v2",
    layout = {
        size = { width = 3, height = 3 },
        furniture_placements = { { id = "f_solar_unit_v2", x = { 0, 2 }, y = { 0, 2 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "industrial_1x5_solar_v2",
    layout = {
        size = { width = 5, height = 5 },
        furniture_placements = { { id = "f_solar_unit_v2", x = { 0, 4 }, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "industrial_1x1_solar_v2",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_solar_unit_v2", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "roof_4x4_utility",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            " xxx",
            "  ax",
            " xxx",
            "  ox",
        },
        terrain = { x = "t_sewage_pipe" },
        furniture = {
            o = { { id = "f_water_heater" }, { id = "f_water_heater_family" } },
            a = "f_air_conditioner",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        liquid_glyphs = { o = { id = "water_clean", amount = { 0, 100 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "roof_4x4_utility_1",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "UUUU",
            "UAaU",
            "c oU",
            "UUUU",
        },
        terrain = { c = "t_chaingate_l", U = "t_chainfence" },
        furniture = {
            o = { { id = "f_water_heater" }, { id = "f_water_heater_family" } },
            a = "f_water_purifier",
            A = "f_standing_tank",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        liquid_glyphs = { o = { id = "water_clean", amount = { 0, 100 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "roof_6x6_utility",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            " xxxxx",
            " xA  x",
            " xx  x",
            "     x",
            "xooa x",
            "xxxxxx",
        },
        terrain = { x = "t_sewage_pipe" },
        furniture = {
            o = { { id = "f_water_heater" }, { id = "f_water_heater_family" } },
            a = "f_water_purifier",
            A = "f_standing_tank",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        liquid_glyphs = { o = { id = "water_clean", amount = { 0, 100 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "roof_2x2_golf",
    layout = {
        size = { width = 2, height = 2 },
        liquid_placements = { { id = "vodka", x = 0, y = 0, amount = { 2, 4 } } },
        loot_placements = {
            { id = "bottle_glass", x = 0, y = 0 },
            { id = "golf_club", x = 1, y = 1 },
            { id = "golf_bag", x = 0, y = 1, chance = 20 },
            { id = "golf_tee", x = 1, y = 0 },
            { id = "golf_ball", x = 1, y = 0 },
            { id = "scorecard", x = 0, y = 0 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "roof_6x6_greenhouse_1",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "%#++#%",
            "%1  1%",
            "#1  1#",
            "#1  1#",
            "%1  1%",
            "%#++#%",
        },
        terrain = {
            ["#"] = "t_reinforced_glass_shutter_open",
            ["+"] = "t_reinforced_door_glass_c",
            ["%"] = "t_reinforced_glass_shutter",
            ["$"] = "t_wall_glass",
        },
        furniture = { S = "f_statue" },
        rotation = { 0, 3 },
        nested = { { id = "roof_6x6_greenhouse_roof", x = 0, y = 0, z = 1 } },
        sealed_item_glyphs = { ["1"] = { item = { id = "seed_rose" }, furniture = "f_planter_mature" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "roof_6x6_greenhouse_2",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "%#++#%",
            "%1  1%",
            "#S  b#",
            "#S  b#",
            "%1  1%",
            "%#++#%",
        },
        terrain = {
            ["#"] = "t_reinforced_glass_shutter_open",
            ["+"] = "t_reinforced_door_glass_c",
            ["%"] = "t_reinforced_glass_shutter",
            ["$"] = "t_wall_glass",
        },
        furniture = { S = "f_statue", b = "f_bench" },
        rotation = { 0, 3 },
        nested = { { id = "roof_6x6_greenhouse_roof", x = 0, y = 0, z = 1 } },
        sealed_item_glyphs = { ["1"] = { item = { id = "seed_sugar_beet" }, furniture = "f_planter_mature" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "roof_6x6_greenhouse_3",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "%#++#%",
            "%1  1%",
            "#1a 1#",
            "#1  1#",
            "%1 a1%",
            "%#++#%",
        },
        terrain = {
            ["#"] = "t_reinforced_glass_shutter_open",
            ["+"] = "t_reinforced_door_glass_c",
            ["%"] = "t_reinforced_glass_shutter",
            ["$"] = "t_wall_glass",
        },
        furniture = { a = "f_stool" },
        rotation = { 0, 2 },
        nested = { { id = "roof_6x6_greenhouse_roof", x = 0, y = 0, z = 1 } },
        loot_placements = {
            { id = "stepladder", x = 3, y = 5, chance = 75, repetitions = { 1, 3 } },
            { id = "seed_weed", x = { 2, 3 }, y = { 2, 3 }, chance = 75, repetitions = { 1, 3 } },
        },
        sealed_item_glyphs = { ["1"] = { item = { id = "seed_weed" }, furniture = "f_planter_harvest" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "roof_6x6_garden_1",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "      ",
            "b111b ",
            "b1B1b ",
            "b111b ",
            "      ",
        },
        terrain = { B = "t_railroad_rubble" },
        furniture = { b = "f_bench", B = { { id = "f_birdbath" }, { id = "f_statue" } } },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        sealed_item_glyphs = { ["1"] = { item = { id = "seed_rose" }, furniture = "f_planter_seedling" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "roof_6x6_garden_2",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "1____1",
            "1_bb_1",
            "11__B1",
            "1B__11",
            "1_bb_1",
            "1____1",
        },
        terrain = { _ = "t_railroad_rubble", b = "t_railroad_rubble", B = "t_railroad_rubble" },
        furniture = { B = { { id = "f_birdbath" }, { id = "f_statue" } }, b = "f_bench" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        sealed_item_glyphs = { ["1"] = { item = { id = "seed_rose" }, furniture = "f_planter_seedling" } },
    },
}

-- herb garden
ccb.content.define_mapgen {
    kind = "nested",
    id = "roof_6x6_garden_3",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "44433 ",
            "BBBBB ",
            "22233 ",
            "BBBBB ",
            "11112 ",
        },
        terrain = { B = "t_railroad_rubble" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        sealed_item_glyphs = {
            ["1"] = { item = { id = "seed_chamomile" }, furniture = "f_planter_harvest" },
            ["2"] = { item = { id = "seed_thyme" }, furniture = "f_planter_harvest" },
            ["3"] = { item = { id = "seed_bee_balm" }, furniture = "f_planter_harvest" },
            ["4"] = { item = { id = "seed_mugwort" }, furniture = "f_planter_harvest" },
        },
    },
}
