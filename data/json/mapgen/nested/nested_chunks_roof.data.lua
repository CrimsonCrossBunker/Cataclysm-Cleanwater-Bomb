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
