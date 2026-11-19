local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "market_6x6_roof",
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
        terrain = { R = "t_canvas_roof" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "market_4x4_roof",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "RRRR",
            "RRRR",
            "RRRR",
            "RRRR",
        },
        terrain = { R = "t_canvas_roof" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "market_5x5_roof",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "RRRRR",
            "RRRRR",
            "RRRRR",
            "RRRRR",
            "RRRRR",
        },
        terrain = { R = "t_canvas_roof" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "market_7x7_roof",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "RRRRRRR",
            "RRRRRRR",
            "RRRRRRR",
            "RRRRRRR",
            "RRRRRRR",
            "RRRRRRR",
            "RRRRRRR",
        },
        terrain = { R = "t_canvas_roof" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "market_meat",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "cccccc",
            "cf  ht",
            "C    d",
            "cf   d",
            "cf H d",
            "cccccc",
        },
        furniture = { H = "f_hanging_meathook" },
        palettes = { "open_air_stall_palette" },
        nested = { { id = "market_6x6_roof", x = 0, y = 0, z = 1 } },
        item_groups = {
            t = { group = "cash_register_random", chance = 100 },
            d = { group = "butcher_meat", chance = 25, repetitions = { 1, 2 } },
            f = { group = "butcher_raw_meat", chance = 25, repetitions = { 1, 2 } },
            H = { group = "butcher_raw_meat", chance = 25, repetitions = { 1, 2 } },
        },
        tile_edits = {
            {
                shape = "rectangle",
                operation = "terrain",
                id = "t_sidewalk_roof_canvas",
                x = 0,
                y = 0,
                end_x = 5,
                end_y = 5,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "market_grocery",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "cccccc",
            "cT  ht",
            "C    d",
            "cT   d",
            "cT   d",
            "cccccc",
        },
        palettes = { "open_air_stall_palette" },
        nested = { { id = "market_6x6_roof", x = 0, y = 0, z = 1 } },
        item_groups = {
            t = { group = "cash_register_random", chance = 100 },
            T = { group = "fresh_produce", chance = 30, repetitions = { 1, 2 } },
            d = { group = "produce", chance = 30, repetitions = { 1, 3 } },
        },
        tile_edits = {
            {
                shape = "rectangle",
                operation = "terrain",
                id = "t_sidewalk_roof_canvas",
                x = 0,
                y = 0,
                end_x = 5,
                end_y = 5,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "market_confectionery",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "cccccc",
            "cr  ht",
            "cr   d",
            "C    d",
            "cr   d",
            "cccccc",
        },
        palettes = { "open_air_stall_palette" },
        nested = { { id = "market_6x6_roof", x = 0, y = 0, z = 1 } },
        item_groups = {
            t = { group = "cash_register_random", chance = 100 },
            r = { group = "candy_chocolate", chance = 65, repetitions = { 1, 2 } },
            d = { group = "candy_shop", chance = 40, repetitions = { 1, 3 } },
        },
        tile_edits = {
            {
                shape = "rectangle",
                operation = "terrain",
                id = "t_sidewalk_roof_canvas",
                x = 0,
                y = 0,
                end_x = 5,
                end_y = 5,
            },
        },
    },
}

-- Give small chance to spawn mutated/normal bees?
ccb.content.define_mapgen {
    kind = "nested",
    id = "market_bees",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "cccc",
            "crht",
            "C  T",
            "cccc",
        },
        palettes = { "open_air_stall_palette" },
        nested = { { id = "market_4x4_roof", x = 0, y = 0, z = 1 } },
        item_groups = {
            t = { group = "cash_register_random", chance = 100 },
            r = { group = "honey_market_stall", chance = 75, repetitions = { 1, 3 } },
            T = { group = "honey_market_stall", chance = 75, repetitions = { 1, 2 } },
        },
        tile_edits = {
            {
                shape = "rectangle",
                operation = "terrain",
                id = "t_sidewalk_roof_canvas",
                x = 0,
                y = 0,
                end_x = 3,
                end_y = 3,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "market_clothes",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "cccccc",
            "MRKJZc",
            "     c",
            "    hC",
            "MRTIUc",
            "cccccc",
        },
        furniture = {
            I = "f_clothing_rail",
            J = "f_clothing_rail",
            K = "f_clothing_rail",
            M = "f_mannequin",
            R = "f_clothing_rail",
            T = "f_clothing_rail",
            U = "f_clothing_rail",
            Z = "f_clothing_rail",
        },
        palettes = { "open_air_stall_palette" },
        nested = { { id = "market_6x6_roof", x = 0, y = 0, z = 1 } },
        item_groups = {
            t = { group = "cash_register_random", chance = 100 },
            R = { group = "SUS_mannequin_outdoor", chance = 40, repetitions = { 1, 2 } },
            M = { group = "SUS_mannequin_general", chance = 40 },
            K = { group = "coats_unisex", chance = 40, repetitions = { 1, 2 } },
            J = { { group = "shoes_unisex", chance = 60 }, { group = "shoes_womens", chance = 20 } },
            Z = { { group = "shirts_unisex", chance = 60 }, { group = "shirts_womens", chance = 25 } },
            U = { group = "underwear_mens", chance = 65 },
            I = { group = "underwear_womens", chance = 65 },
            T = { { group = "gloves_unisex", chance = 65 }, { group = "scarfs_unisex", chance = 40 } },
        },
        tile_edits = {
            {
                shape = "rectangle",
                operation = "terrain",
                id = "t_sidewalk_roof_canvas",
                x = 0,
                y = 0,
                end_x = 5,
                end_y = 5,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "market_botanical",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "ccccc",
            "ppppc",
            "   hC",
            "ppppc",
            "ccccc",
        },
        furniture = {
            p = {
                { id = "f_indoor_plant" },
                { id = "f_indoor_plant_y" },
                { id = "f_null", copies = 3 },
            },
        },
        palettes = { "open_air_stall_palette" },
        nested = { { id = "market_5x5_roof", x = 0, y = 0, z = 1 } },
        item_groups = { t = { group = "cash_register_random", chance = 100 } },
        tile_edits = {
            {
                shape = "rectangle",
                operation = "terrain",
                id = "t_sidewalk_roof_canvas",
                x = 0,
                y = 0,
                end_x = 4,
                end_y = 4,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "market_misc",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "ccccccc",
            "hrrrrrc",
            "      c",
            "trrrrrc",
            "      c",
            " rrrrrc",
            "ccccccc",
        },
        palettes = { "open_air_stall_palette" },
        nested = { { id = "market_7x7_roof", x = 0, y = 0, z = 1 } },
        item_groups = { t = { group = "cash_register_random", chance = 100 } },
        item_group_placements = {
            {
                chance = 50,
                repetitions = { 2, 6 },
                group = "recycle_electronic",
                x = { 1, 5 },
                y = { 1, 1 },
            },
            {
                chance = 50,
                repetitions = { 3, 6 },
                group = "SUS_office_mess",
                x = { 1, 5 },
                y = { 3, 3 },
            },
            {
                chance = 35,
                repetitions = { 1, 3 },
                group = "tools_home",
                x = { 1, 5 },
                y = { 5, 5 },
            },
        },
        tile_edits = {
            {
                shape = "rectangle",
                operation = "terrain",
                id = "t_sidewalk_roof_canvas",
                x = 0,
                y = 0,
                end_x = 6,
                end_y = 6,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "market_books",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "cccccc",
            "TTTTTc",
            "     c",
            "    hc",
            "TTTTTc",
            "cccccc",
        },
        palettes = { "open_air_stall_palette" },
        nested = { { id = "market_6x6_roof", x = 0, y = 0, z = 1 } },
        item_groups = {
            t = { group = "cash_register_random", chance = 100 },
            T = { { group = "homebooks", chance = 40, repetitions = { 1, 2 } } },
        },
        tile_edits = {
            {
                shape = "rectangle",
                operation = "terrain",
                id = "t_sidewalk_roof_canvas",
                x = 0,
                y = 0,
                end_x = 5,
                end_y = 5,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "market_fish",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "cccccc",
            "cr  ht",
            "C    d",
            "cr   d",
            "cr   d",
            "cccccc",
        },
        palettes = { "open_air_stall_palette" },
        nested = { { id = "market_6x6_roof", x = 0, y = 0, z = 1 } },
        liquid_glyphs = { d = { id = "water", amount = { 12, 60 } } },
        item_groups = {
            t = { group = "cash_register_random", chance = 100 },
            d = { group = "fresh_fish", chance = 50, repetitions = { 1, 2 } },
            r = { group = "fish_market_stall", chance = 30, repetitions = { 1, 3 } },
        },
        tile_edits = {
            {
                shape = "rectangle",
                operation = "terrain",
                id = "t_sidewalk_roof_canvas",
                x = 0,
                y = 0,
                end_x = 5,
                end_y = 5,
            },
        },
    },
}
