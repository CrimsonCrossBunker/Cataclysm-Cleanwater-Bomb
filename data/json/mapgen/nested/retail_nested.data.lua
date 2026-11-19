local ccb = require("ccb")

-- designed for spaces 9x9.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_9x9_candy_shop_front",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "LHL   LHL",
            "         ",
            "w L L L w",
            "w L L L w",
            "w L L L w",
            "y        ",
            "MMM?MM  Y",
            "  A      ",
            "  VVV    ",
        },
        terrain = { [" "] = "t_floor" },
        furniture = {
            ["?"] = "f_counter",
            L = "f_table",
            H = "f_table",
            G = "f_table",
            M = "f_displaycase",
            w = "f_rack_wood",
            V = "f_glass_cabinet",
            Y = "f_trashcan",
            A = "f_stool",
            y = { { id = "f_indoor_plant" }, { id = "f_indoor_plant_y" } },
        },
        rotation = { 0, 3 },
        item_groups = {
            ["?"] = { { group = "cash_register_random", chance = 100 } },
            H = { { group = "toy_store", chance = 30, repetitions = { 1, 2 } } },
            Y = { { group = "SUS_trash_trashcan", chance = 30 } },
            L = { { group = "candy_chocolate", chance = 30, repetitions = { 0, 4 } } },
            w = { { group = "candy_chocolate", chance = 30, repetitions = { 0, 4 } } },
            M = {
                { group = "candy_chocolate", chance = 30, repetitions = { 0, 4 } },
                { group = "toy_store", chance = 30, repetitions = { 1, 2 } },
            },
            V = {
                { group = "candy_chocolate", chance = 30, repetitions = { 0, 4 } },
                { group = "toy_store", chance = 30, repetitions = { 1, 2 } },
            },
        },
    },
}

-- designed for 3x3 candy shop crates.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_3x3_backroom_crates_candy",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "z z",
            "  z",
            "z z",
        },
        terrain = { z = "t_floor" },
        furniture = { z = { { id = "f_cardboard_box", copies = 5 }, { id = "f_crate_c" } } },
        rotation = { 0, 3 },
        item_groups = {
            z = {
                { group = "candy_chocolate", chance = 30, repetitions = { 1, 6 } },
                { group = "toy_store", chance = 30, repetitions = { 1, 6 } },
            },
        },
    },
}

-- designed for 3x3 beauty shop crates.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_3x3_backroom_crates_beauty",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "z z",
            "  z",
            "z z",
        },
        terrain = { z = "t_floor" },
        furniture = { z = { { id = "f_cardboard_box", copies = 5 }, { id = "f_crate_c" } } },
        rotation = { 0, 3 },
        item_groups = { z = { { group = "beauty", chance = 30, repetitions = { 1, 6 } } } },
    },
}

-- designed for 3x3 vitamin shop crates.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_3x3_backroom_crates_vitamin",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "z z",
            "  z",
            "z z",
        },
        terrain = { z = "t_floor" },
        furniture = { z = { { id = "f_cardboard_box", copies = 5 }, { id = "f_crate_c" } } },
        rotation = { 0, 3 },
        item_groups = { z = { { group = "vitamin_shop", chance = 30, repetitions = { 1, 6 } } } },
    },
}

-- designed for 3x3 cellphone shop crates.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_3x3_backroom_crates_cellphone",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "z z",
            "  z",
            "z z",
        },
        terrain = { z = "t_floor" },
        furniture = { z = { { id = "f_cardboard_box", copies = 5 }, { id = "f_crate_c" } } },
        rotation = { 0, 3 },
        item_groups = {
            z = {
                { group = "cell_shop", chance = 30, repetitions = { 1, 6 } },
                { group = "elecsto_pcs", chance = 30, repetitions = { 1, 6 } },
                { group = "elecsto_persele", chance = 30, repetitions = { 1, 6 } },
            },
        },
    },
}

-- designed for 3x3 music shop crates.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_3x3_backroom_crates_music",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "z z",
            "  z",
            "z z",
        },
        terrain = { z = "t_floor" },
        furniture = { z = { { id = "f_cardboard_box", copies = 5 }, { id = "f_crate_c" } } },
        rotation = { 0, 3 },
        item_groups = {
            z = {
                { group = "musicstore_showpiece", chance = 30, repetitions = { 0, 2 } },
                { group = "mussto_windinst", chance = 30, repetitions = { 0, 2 } },
                { group = "mussto_stringinst", chance = 30, repetitions = { 0, 2 } },
            },
        },
    },
}

-- designed for 3x3 gift shop crates.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_3x3_backroom_crates_gift",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "z z",
            "  z",
            "z z",
        },
        terrain = { z = "t_floor" },
        furniture = { z = { { id = "f_cardboard_box", copies = 5 }, { id = "f_crate_c" } } },
        rotation = { 0, 3 },
        item_groups = { z = { { group = "gift_shop", chance = 30, repetitions = { 0, 2 } } } },
    },
}

-- designed for 3x3 electronics shop crates.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_3x3_backroom_crates_electronics",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "z z",
            "  z",
            "z z",
        },
        terrain = { z = "t_floor" },
        furniture = { z = { { id = "f_cardboard_box", copies = 5 }, { id = "f_crate_c" } } },
        rotation = { 0, 3 },
        item_groups = {
            z = {
                { group = "elecsto_pcs", chance = 30, repetitions = { 0, 2 } },
                { group = "elecsto_cameras", chance = 30, repetitions = { 0, 2 } },
                { group = "elecsto_entapl", chance = 30, repetitions = { 0, 2 } },
                { group = "elecsto_homapl", chance = 30, repetitions = { 0, 2 } },
                { group = "elecsto_lights", chance = 30, repetitions = { 0, 2 } },
            },
        },
    },
}

-- designed for 3x3 pizza shop crates.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_3x3_backroom_crates_pizza",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "z z",
            "  z",
            "z z",
        },
        terrain = { z = "t_floor" },
        furniture = { z = { { id = "f_cardboard_box", copies = 5 }, { id = "f_crate_c" } } },
        rotation = { 0, 3 },
        item_groups = {
            z = {
                { group = "pizza_kitchen", chance = 30, repetitions = { 0, 2 } },
                { group = "pizza_table", chance = 30, repetitions = { 0, 2 } },
            },
        },
    },
}

-- designed for 8x8 clothing shop.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_8x8_clothing_shop_front",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "   BBB  ",
            " C GA  b",
            " C G?G  ",
            " d     R",
            "   LdL  ",
            " C     R",
            " C QQVV ",
            "## #####",
        },
        palettes = { "parametrized_walls_palette" },
        terrain = { [" "] = "t_floor", ["?"] = "t_floor" },
        furniture = {
            ["?"] = "f_counter",
            A = "f_stool",
            B = "f_counter",
            C = "f_table",
            G = "f_displaycase",
            b = "f_bigmirror",
            d = "f_mannequin",
            L = "f_table",
            Q = "f_rack_wood",
            R = "f_armchair",
            V = "f_rack_wood",
            y = { { id = "f_indoor_plant" }, { id = "f_indoor_plant_y" } },
        },
        rotation = { 0, 3 },
        item_groups = {
            ["?"] = { { group = "cash_register_random", chance = 100 } },
            d = {
                { group = "jackets", chance = 40 },
                { group = "pants", chance = 100 },
                { group = "shirts", chance = 100 },
                { group = "hatstore_accessories", chance = 100 },
                { group = "shoestore_shoes", chance = 100 },
            },
            C = { { group = "shirts", chance = 30, repetitions = { 1, 2 } } },
            L = { { group = "pants", chance = 30, repetitions = { 1, 2 } } },
            Q = { { group = "bags", chance = 30, repetitions = { 1, 2 } } },
            V = { { group = "shoestore_shoes", chance = 30, repetitions = { 1, 2 } } },
            G = {
                { group = "hatstore_accessories", chance = 30, repetitions = { 0, 4 } },
                { group = "jewelry_front", chance = 30, repetitions = { 0, 1 } },
            },
        },
    },
}

-- designed for 4x4 general clothing shop crates.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_4x4_backroom_clothing",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "z zz",
            " z z",
            "z z ",
            "z  z",
        },
        terrain = { z = "t_floor" },
        furniture = { z = { { id = "f_cardboard_box", copies = 5 }, { id = "f_crate_c" } } },
        rotation = { 0, 3 },
        item_groups = {
            z = {
                { group = "shirts", chance = 30, repetitions = { 1, 6 } },
                { group = "pants", chance = 30, repetitions = { 1, 6 } },
                { group = "jackets", chance = 30, repetitions = { 1, 6 } },
                { group = "hatstore_accessories", chance = 30, repetitions = { 1, 6 } },
                { group = "shoestore_shoes", chance = 30, repetitions = { 1, 6 } },
            },
        },
    },
}

-- designed for 4x4 general clothing backroom.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_4x4_backroom_clothing",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "CCCC",
            "    ",
            "    ",
            "CC C",
        },
        terrain = { [" "] = "t_floor" },
        furniture = { C = "f_rack" },
        rotation = { 0, 3 },
        item_groups = {
            C = {
                { group = "shirts", chance = 30, repetitions = { 1, 6 } },
                { group = "pants", chance = 30, repetitions = { 1, 6 } },
                { group = "jackets", chance = 30, repetitions = { 1, 6 } },
            },
        },
    },
}

-- designed for 8x8 formal clothing shop.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_8x8_formal_clothing_shop_front",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "   GGG  ",
            " e  A  b",
            " C B?B  ",
            " d     b",
            "   RCR  ",
            "       b",
            " b LLL  ",
            "## #####",
        },
        palettes = { "parametrized_walls_palette" },
        terrain = { [" "] = "t_floor", ["?"] = "t_floor" },
        furniture = {
            ["?"] = "f_counter",
            A = "f_stool",
            B = "f_counter",
            C = "f_table",
            G = "f_displaycase",
            b = "f_bigmirror",
            d = "f_mannequin",
            e = "f_mannequin",
            L = "f_wardrobe",
            R = "f_armchair",
        },
        rotation = { 0, 3 },
        item_groups = {
            ["?"] = { { group = "cash_register_random", chance = 100 } },
            d = {
                { group = "wedding_suits", chance = 100 },
                { group = "hatstore_accessories", chance = 100 },
                { group = "dress_shoes", chance = 100 },
            },
            e = {
                { group = "wedding_suits", chance = 100 },
                { group = "hatstore_accessories", chance = 100 },
                { group = "dress_shoes", chance = 100 },
            },
            C = { { group = "dress_shoes", chance = 30, repetitions = { 1, 2 } } },
            L = { { group = "wedding_suits", chance = 30, repetitions = { 1, 2 } } },
            V = { { group = "shoestore_shoes", chance = 30, repetitions = { 1, 2 } } },
            G = {
                { group = "neckties", chance = 30, repetitions = { 0, 4 } },
                { group = "accesories_personal_unisex", chance = 30, repetitions = { 0, 1 } },
            },
        },
    },
}

-- designed for 4x4 formal clothing shop crates.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_4x4_backroom_clothing_formal",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "z zz",
            " z z",
            "z z ",
            "z  z",
        },
        terrain = { z = "t_floor" },
        furniture = { z = { { id = "f_cardboard_box", copies = 5 }, { id = "f_crate_c" } } },
        rotation = { 0, 3 },
        item_groups = {
            z = {
                { group = "wedding_suits", chance = 30, repetitions = { 0, 6 } },
                { group = "hatstore_accessories", chance = 30, repetitions = { 0, 6 } },
                { group = "dress_shoes", chance = 30, repetitions = { 0, 6 } },
                { group = "neckties", chance = 30, repetitions = { 0, 6 } },
                { group = "accesories_personal_unisex", chance = 30, repetitions = { 0, 6 } },
            },
        },
    },
}

-- designed for 4x4 formal clothing backroom.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_4x4_backroom_clothing_formal",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "CCCC",
            "    ",
            "    ",
            "CC C",
        },
        terrain = { [" "] = "t_floor" },
        furniture = { C = "f_rack" },
        rotation = { 0, 3 },
        item_groups = {
            C = {
                { group = "wedding_suits", chance = 30, repetitions = { 0, 6 } },
                { group = "dress_shoes", chance = 30, repetitions = { 0, 6 } },
            },
        },
    },
}

-- designed for 4x4 formal clothing backroom.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_4x4_backroom_clothing_formal",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "CBBB",
            "e Ad",
            "    ",
            "bb C",
        },
        terrain = { [" "] = "t_floor", ["?"] = "t_floor" },
        furniture = {
            ["?"] = "f_console_broken",
            A = "f_stool",
            B = "f_workbench",
            C = "f_rack_wood",
            d = "f_mannequin",
            e = "f_mannequin",
            b = "f_bench",
        },
        rotation = { 0, 3 },
        item_groups = {
            C = { { group = "SUS_tailoring_materials", chance = 30, repetitions = { 1, 2 } } },
            d = { { group = "SUS_mannequin_formal_mens", chance = 30 } },
            e = { { group = "SUS_mannequin_dresses", chance = 30 } },
            B = {
                { group = "SUS_tailoring_tool_drawer", chance = 30, repetitions = { 0, 1 } },
                { group = "SUS_tailoring_fasteners", chance = 30, repetitions = { 2, 6 } },
            },
        },
    },
}

-- designed for 8x8 leather clothing shop.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_8x8_leather_clothing_shop_front",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            " d B?B  ",
            " Q  AB b",
            " Q      ",
            " Q C G b",
            " d C G  ",
            "       b",
            " b LLL  ",
            "## #####",
        },
        palettes = { "parametrized_walls_palette" },
        terrain = { [" "] = "t_floor", ["?"] = "t_floor" },
        furniture = {
            ["?"] = "f_counter",
            A = "f_stool",
            B = "f_counter",
            C = "f_table",
            G = "f_displaycase",
            b = "f_bigmirror",
            Q = "f_rack_wood",
            d = "f_mannequin",
            L = "f_wardrobe",
        },
        rotation = { 0, 3 },
        item_groups = {
            ["?"] = { { group = "cash_register_random", chance = 100 } },
            d = {
                { group = "leather_shop", chance = 100 },
                { group = "pants", chance = 50 },
                { group = "shirts", chance = 50 },
                { group = "leather_shop_accessories", chance = 100 },
            },
            C = { { group = "leather_shop", chance = 30, repetitions = { 1, 2 } } },
            L = { { group = "leather_shop", chance = 30, repetitions = { 1, 2 } } },
            Q = { { group = "leather_shop", chance = 30, repetitions = { 1, 2 } } },
            G = {
                { group = "leather_shop_accessories", chance = 30, repetitions = { 0, 4 } },
                { group = "accesories_personal_unisex", chance = 30, repetitions = { 0, 1 } },
            },
        },
    },
}

-- designed for 4x4 leather clothing shop crates.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_4x4_backroom_clothing_leather",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "z zz",
            " z z",
            "z z ",
            "z  z",
        },
        terrain = { z = "t_floor" },
        furniture = { z = { { id = "f_cardboard_box", copies = 5 }, { id = "f_crate_c" } } },
        rotation = { 0, 3 },
        item_groups = {
            z = {
                { group = "leather_shop", chance = 30, repetitions = { 1, 6 } },
                { group = "leather_shop_accessories", chance = 30, repetitions = { 1, 6 } },
                { group = "accesories_personal_unisex", chance = 30, repetitions = { 1, 6 } },
            },
        },
    },
}

-- designed for 4x4 leather clothing backroom.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_4x4_backroom_clothing_leather",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "CCCC",
            "    ",
            "    ",
            "CC C",
        },
        terrain = { [" "] = "t_floor" },
        furniture = { C = "f_rack" },
        rotation = { 0, 3 },
        item_groups = {
            C = {
                { group = "leather_shop", chance = 30, repetitions = { 0, 6 } },
                { group = "leather_shop_accessories", chance = 30, repetitions = { 0, 6 } },
            },
        },
    },
}

-- designed for 4x4 leather clothing backroom.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_4x4_backroom_clothing_leather",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "CBBB",
            "  Ad",
            "A   ",
            "BB C",
        },
        terrain = { [" "] = "t_floor", ["?"] = "t_floor" },
        furniture = {
            ["?"] = "f_console_broken",
            A = "f_stool",
            B = "f_workbench",
            C = "f_rack_wood",
            d = "f_mannequin",
            e = "f_mannequin",
            b = "f_bench",
        },
        rotation = { 0, 3 },
        item_groups = {
            C = {
                { group = "SUS_tailoring_materials", chance = 10, repetitions = { 1, 2 } },
                { group = "leather_shop_repair", chance = 30, repetitions = { 2, 6 } },
            },
            d = {
                { group = "leather_shop", chance = 100 },
                { group = "pants", chance = 50 },
                { group = "shirts", chance = 50 },
                { group = "leather_shop_accessories", chance = 100 },
            },
            B = {
                { group = "SUS_tailoring_tool_drawer", chance = 30, repetitions = { 0, 1 } },
                { group = "SUS_tailoring_fasteners", chance = 30, repetitions = { 2, 6 } },
            },
        },
    },
}

-- designed for 8x8 fur clothing shop.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_8x8_fur_clothing_shop_front",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            " d B?B  ",
            " L  AB b",
            " L      ",
            " L C G b",
            " d C G  ",
            "       b",
            " b QQQ  ",
            "## #####",
        },
        palettes = { "parametrized_walls_palette" },
        terrain = { [" "] = "t_floor", ["?"] = "t_floor" },
        furniture = {
            ["?"] = "f_counter",
            A = "f_stool",
            B = "f_counter",
            C = "f_table",
            G = "f_displaycase",
            b = "f_bigmirror",
            Q = "f_rack_wood",
            d = "f_mannequin",
            L = "f_wardrobe",
        },
        rotation = { 0, 3 },
        item_groups = {
            ["?"] = { { group = "cash_register_random", chance = 100 } },
            d = {
                { group = "fancyfurs", chance = 100 },
                { group = "pants", chance = 50 },
                { group = "shirts", chance = 50 },
                { group = "dress_shoes", chance = 100 },
            },
            C = { { group = "fancyfurs", chance = 30, repetitions = { 1, 2 } } },
            L = { { group = "fancyfurs", chance = 30, repetitions = { 1, 2 } } },
            Q = { { group = "fancyfurs", chance = 30, repetitions = { 1, 2 } } },
            G = {
                { group = "neckties", chance = 30, repetitions = { 0, 4 } },
                { group = "jewelry_front", chance = 30, repetitions = { 0, 1 } },
            },
        },
    },
}

-- designed for 4x4 fur clothing shop crates.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_4x4_backroom_clothing_fur",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "z  z",
            " z  ",
            "z z ",
            "z  z",
        },
        terrain = { z = "t_floor" },
        furniture = { z = { { id = "f_cardboard_box", copies = 5 }, { id = "f_crate_c" } } },
        rotation = { 0, 3 },
        item_groups = {
            z = {
                { group = "fancyfurs", chance = 30, repetitions = { 1, 6 } },
                { group = "neckties", chance = 30, repetitions = { 1, 6 } },
                { group = "accesories_personal_unisex", chance = 30, repetitions = { 1, 6 } },
            },
        },
    },
}

-- designed for 4x4 fur clothing backroom.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_4x4_backroom_clothing_fur",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "CCCC",
            "    ",
            "    ",
            "CC C",
        },
        terrain = { [" "] = "t_floor" },
        furniture = { C = "f_rack" },
        rotation = { 0, 3 },
        item_groups = { C = { { group = "fancyfurs", chance = 30, repetitions = { 0, 6 } } } },
    },
}

-- designed for 4x4 fur clothing backroom.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_4x4_backroom_clothing_fur",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "CBBB",
            "  Ad",
            "A   ",
            "BB C",
        },
        terrain = { [" "] = "t_floor", ["?"] = "t_floor" },
        furniture = {
            ["?"] = "f_console_broken",
            A = "f_stool",
            B = "f_workbench",
            C = "f_rack_wood",
            d = "f_mannequin",
            e = "f_mannequin",
            b = "f_bench",
        },
        rotation = { 0, 3 },
        item_groups = {
            C = {
                { group = "SUS_tailoring_materials", chance = 10, repetitions = { 1, 2 } },
                { group = "SUS_fur_tailoring_materials", chance = 30, repetitions = { 2, 6 } },
            },
            d = { { group = "SUS_mannequin_fur", chance = 100 } },
            B = {
                { group = "SUS_tailoring_tool_drawer", chance = 30, repetitions = { 0, 1 } },
                { group = "SUS_tailoring_fasteners", chance = 30, repetitions = { 2, 6 } },
            },
        },
    },
}

-- designed for 3x3 candy shop crates.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_3x3_backroom_crates_candy",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "z z",
            "  z",
            "z z",
        },
        terrain = { z = "t_floor" },
        furniture = { z = { { id = "f_cardboard_box", copies = 5 }, { id = "f_crate_c" } } },
        rotation = { 0, 3 },
        item_groups = {
            z = {
                { group = "candy_chocolate", chance = 30, repetitions = { 1, 6 } },
                { group = "toy_store", chance = 30, repetitions = { 1, 6 } },
            },
        },
    },
}

-- designed for restaurant spaces 14x14.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_14x14_restaurant",
    layout = {
        size = { width = 14, height = 14 },
        rows = {
            "              ",
            "              ",
            "HLH HLH  GG   ",
            "HLH HLH  LL   ",
            "         GG   ",
            "HLH HLH   y   ",
            "HLH HLH  GG   ",
            "         LL   ",
            "|||||||| GG   ",
            "JJiRiJJ| ||   ",
            "F     n| |t   ",
            "F RRR l| *    ",
            "(      * |    ",
            "YPPQQSY| |j   ",
        },
        palettes = { "parametrized_walls_palette" },
        terrain = { ["*"] = "t_door_c" },
        furniture = {
            ["?"] = "f_console_broken",
            L = "f_table",
            H = "f_chair",
            G = "f_sofa",
            t = "f_toilet",
            j = "f_sink",
            P = "f_rack",
            S = "f_rack",
            Q = "f_rack",
            Y = "f_trashcan",
            A = "f_stool",
            i = "f_oven",
            F = "f_heavy_duty_fridge",
            ["("] = "f_heavy_duty_freezer",
            n = "f_sink",
            l = "f_dishwasher",
            J = "f_counter",
            R = "f_counter",
            y = { { id = "f_indoor_plant" }, { id = "f_indoor_plant_y" } },
        },
        rotation = { 0, 3 },
        item_groups = {
            Y = { { group = "SUS_trash_trashcan", chance = 30 } },
            l = { { group = "restaur_sink", chance = 30, repetitions = { 1, 2 } } },
            n = { { group = "restaur_sink", chance = 30, repetitions = { 1, 2 } } },
            j = { { group = "restaur_bath", chance = 30, repetitions = { 1, 2 } } },
            i = { { group = "SUS_oven", chance = 30, repetitions = { 1, 2 } } },
            L = { { group = "restaur_table", chance = 30, repetitions = { 0, 4 } } },
            J = {
                { group = "SUS_knife_drawer", chance = 30, repetitions = { 0, 4 } },
                { group = "restaur_kitchen", chance = 30, repetitions = { 1, 2 } },
            },
            R = {
                { group = "restaur_kitchen", chance = 30, repetitions = { 0, 4 } },
                { group = "diner_food", chance = 30, repetitions = { 1, 2 } },
            },
            P = {
                { group = "restaur_kitchen", chance = 30, repetitions = { 0, 4 } },
                { group = "restaur_rack", chance = 30, repetitions = { 1, 2 } },
            },
            Q = {
                { group = "restaur_kitchen", chance = 30, repetitions = { 0, 4 } },
                { group = "restaur_kitchen", chance = 30, repetitions = { 1, 2 } },
            },
            S = {
                { group = "groce_bread", chance = 30, repetitions = { 0, 4 } },
                { group = "restaur_kitchen", chance = 30, repetitions = { 1, 2 } },
            },
        },
    },
}

-- designed for bar spaces 11x11.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_11x11_bar",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "y  A   xx  ",
            "F RRA  xx  ",
            "n  RA  xx  ",
            "J  RA      ",
            "J ARA   LG ",
            "F  RA  LLG ",
            "F     yGGG ",
            "|| ||||||| ",
            "t| |FFFllK ",
            " * *     K ",
            "j|K|YnJK   ",
        },
        palettes = { "parametrized_walls_palette" },
        terrain = { ["*"] = "t_door_c" },
        furniture = {
            L = "f_table",
            x = "f_pool_table",
            G = "f_sofa",
            t = "f_toilet",
            j = "f_sink",
            Y = "f_trashcan",
            A = "f_stool",
            F = "f_glass_fridge",
            n = "f_sink",
            l = "f_dishwasher",
            J = "f_counter",
            R = "f_counter",
            y = { { id = "f_indoor_plant" }, { id = "f_indoor_plant_y" } },
        },
        rotation = { 0, 3 },
        item_groups = {
            K = { group = "keg_beer", chance = 50 },
            Y = { { group = "SUS_trash_trashcan", chance = 30 } },
            x = { { group = "pool_table", chance = 30, repetitions = { 1, 2 } } },
            l = { { group = "restaur_sink", chance = 30, repetitions = { 1, 2 } } },
            n = { { group = "restaur_sink", chance = 30, repetitions = { 1, 2 } } },
            j = { { group = "restaur_bath", chance = 30, repetitions = { 1, 2 } } },
            L = { { group = "bar_table", chance = 30, repetitions = { 0, 4 } } },
            J = {
                { group = "liqstore_brew", chance = 30, repetitions = { 0, 4 } },
                { group = "bar_alcohol", chance = 30, repetitions = { 1, 2 } },
            },
            R = { { group = "bar_table", chance = 30, repetitions = { 0, 4 } } },
            F = {
                { group = "bar_alcohol", chance = 30, repetitions = { 0, 4 } },
                { group = "bar_fridge", chance = 30, repetitions = { 1, 2 } },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "pizza_loot",
    layout = {
        size = { width = 18, height = 18 },
        rows = {
            "D,BrrW|66Q,U|t|Y|t",
            "FB,,h,|Q,,,,|,+,+,",
            "E,A,,,,,,DFE|S|,|S",
            "|,,||+|||||||||,||",
            "k,O|7,JA,llmmY,,HH",
            "k,O|7,ƃ,,,,,,,,,ff",
            "2,K|J,JA,hh,hh,,HH",
            "3,K0J,JA,ff,ff,,,,",
            "1,K0J,JA,hh,hh,,HH",
            "4,K|J,JA,,,,,,,,ff",
            "J,,+,,v,,hh,hh,,HH",
            "5,J|J,v,,ff,ff,,,,",
            "JnJ|J,9,,hh,hh,,,,",
            "####uuu,,,,,,,,,,,",
            "   #HHH,,,,,,,,,,,",
            "   #Hff,,HffH,HffH",
            "   #Hff,,HffH,HffH",
            "   #HHH,,HHHHyHHHH",
        },
        palettes = { "commercial_restaurant_palette" },
        item_groups = {
            f = {
                { group = "dishes_dining", chance = 30 },
                { group = "pizza_table", chance = 10, repetitions = { 1, 2 } },
            },
            l = { group = "pizza_soda", chance = 80, repetitions = { 1, 3 } },
            m = { group = "pizza_beer", chance = 80, repetitions = { 1, 3 } },
            W = { group = "pizza_locker", chance = 80, repetitions = { 1, 3 } },
            q = { { group = "pizza_kitchen", chance = 30, repetitions = { 1, 2 } } },
            u = { group = "pizza_display", chance = 30, repetitions = { 1, 3 } },
            v = { { group = "baked_goods", chance = 60, repetitions = { 1, 3 } } },
            Q = { { group = "pizza_kitchen", chance = 20, repetitions = { 1, 3 } } },
            D = { group = "pizza_display", chance = 70, repetitions = { 1, 3 } },
            E = { group = "produce", chance = 70, repetitions = { 1, 3 } },
            F = { group = "pizza_fridge", chance = 70, repetitions = { 1, 3 } },
            J = { group = "pizza_table", chance = 5, repetitions = { 1, 3 } },
            K = { group = "pizza_kitchen", chance = 15, repetitions = { 1, 3 } },
            S = {
                { group = "pizza_bathroom", chance = 30 },
                { group = "SUS_bathroom_medicine", chance = 10 },
            },
            Y = { group = "SUS_trash_trashcan", chance = 30 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "diner_loot",
    layout = {
        size = { width = 18, height = 18 },
        rows = {
            "6 q|DFKOKKJlmYQQ5J",
            "6  +             n",
            "6 W|EKKOKSK   JJJJ",
            "|||||||||||  |||||",
            "KKKKKKKK77Y,,JY,hh",
            "K,,,,,,,,,,,,ƃ,,ff",
            "K,,|JJJJJJJJJJ,,hh",
            "l,B|AA,AAA,AAA,,,,",
            "m,B|hh,hh,hh,,,hfh",
            "|+||ff,ff,ff,,,hfh",
            "6 r|hh,hh,hh,,,,,,",
            "6Ar|hh,hh,hh,,,u,,",
            "6QQ|ff,ff,ff,,A9,,",
            "####hh,hh,hh,,,u,,",
            "   #,,,,,,,,,,,,,i",
            "   #|+|+||Æ,,,,,,i",
            "   # Y| Y|,A,,,,,i",
            "   #tS|tS|Æ,,iii,y",
        },
        palettes = { "commercial_restaurant_palette" },
        terrain = { ["."] = "t_thconc_floor" },
        item_groups = {
            f = { { group = "dishes_dining", chance = 30 }, { group = "diner_food", chance = 20 } },
            l = { group = "coffee_freezer", chance = 80, repetitions = { 1, 3 } },
            m = { group = "pizza_beer", chance = 80, repetitions = { 1, 3 } },
            W = { group = "coffee_locker", chance = 80, repetitions = { 1, 3 } },
            q = { { group = "diner_back", chance = 30, repetitions = { 1, 2 } } },
            u = { group = "baked_goods", chance = 30, repetitions = { 1, 3 } },
            Q = { { group = "diner_back", chance = 20, repetitions = { 1, 3 } } },
            D = { group = "butcher_meat", chance = 70, repetitions = { 1, 3 } },
            E = { group = "produce", chance = 70, repetitions = { 1, 3 } },
            F = { group = "restaur_fridge", chance = 70, repetitions = { 1, 3 } },
            J = { group = "diner_food", chance = 5, repetitions = { 1, 3 } },
            K = { group = "diner_back", chance = 5, repetitions = { 1, 3 } },
            S = {
                { group = "pizza_bathroom", chance = 30 },
                { group = "SUS_bathroom_medicine", chance = 10 },
            },
            Y = { group = "SUS_trash_floor", chance = 30, repetitions = { 1, 4 } },
        },
    },
}

-- designed for the back of the woodwork craftshop
ccb.content.define_mapgen {
    kind = "nested",
    id = "3x3_woodcrafts_crates",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "  z",
            " zz",
            "zzz",
        },
        furniture = {
            z = {
                { id = "f_crate_c", copies = 2 },
                { id = "f_crate_o", copies = 1 },
                { id = "f_null", copies = 3 },
            },
        },
        rotation = { 0, 3 },
        item_groups = { z = { group = "wood_workshop", chance = 20, repetitions = { 3, 5 } } },
    },
}

-- designed for the large workbench tables in the woodwork craftshop
ccb.content.define_mapgen {
    kind = "nested",
    id = "4x4_woodcrafts_table_vertical",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "ttt ",
            "ttt ",
            "ttt ",
            "ttt ",
        },
        furniture = { t = "f_table" },
        rotation = { 0, 3 },
        item_spawns = { t = { id = "sandpaper", chance = 17 } },
        item_placements = {
            { id = "clamp", x = 0, y = { 0, 3 }, chance = 80 },
            { id = "clamp", x = 2, y = { 0, 3 }, chance = 80 },
        },
    },
}

-- designed for the large workbench tables in the woodwork craftshop
ccb.content.define_mapgen {
    kind = "nested",
    id = "4x4_woodcrafts_table_horizontal",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "tttt",
            "tttt",
            "tttt",
            "    ",
        },
        furniture = { t = "f_table" },
        rotation = { 0, 3 },
        item_spawns = { t = { id = "sandpaper", chance = 17 } },
        item_placements = {
            { id = "clamp", x = { 0, 3 }, y = 0, chance = 80 },
            { id = "clamp", x = { 0, 3 }, y = 2, chance = 80 },
        },
    },
}

-- designed for the window display of the woodwork craftshop
ccb.content.define_mapgen {
    kind = "nested",
    id = "4x4_woodcrafts_display_nocanoe",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "ππππ",
            "    ",
            "    ",
            "    ",
        },
        furniture = { ["π"] = "f_displaycase" },
        rotation = { 0, 3 },
        item_groups = { ["π"] = { group = "woodcrafts", chance = 100, repetitions = { 1, 3 } } },
    },
}

-- designed for the window display of the woodwork craftshop
ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_woodcrafts_display_canoe",
    layout = {
        size = { width = 1, height = 1 },
        rotation = { 0, 3 },
        vehicle_placements = { { id = "canoe", x = 2, y = 0, rotation = 180, fuel = 0, status = 0 } },
    },
}

-- designed for 5x5 shop backroom.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_5x5_backroom_shop",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "d   G",
            "L   G",
            "BA   ",
            "B  zz",
            "Cyz  ",
        },
        terrain = { [" "] = "t_floor", ["?"] = "t_floor" },
        furniture = {
            ["?"] = "f_console_broken",
            A = "f_chair",
            B = "f_desk",
            C = "f_rack",
            G = "f_locker",
            b = "f_bench",
            d = "f_filing_cabinet",
            L = "f_shredder",
            y = { { id = "f_indoor_plant" }, { id = "f_indoor_plant_y" } },
            z = { { id = "f_cardboard_box", copies = 5 }, { id = "f_crate_c" } },
        },
        rotation = { 0, 3 },
        item_groups = {
            d = { { group = "SUS_office_filing_cabinet", chance = 25 } },
            C = { { group = "cleaning", chance = 30, repetitions = { 1, 2 } } },
            B = { { group = "SUS_office_desk", chance = 30, repetitions = { 1, 2 } } },
            G = {
                { group = "jackets", chance = 30, repetitions = { 0, 1 } },
                { group = "bags", chance = 30, repetitions = { 0, 1 } },
            },
        },
    },
}

-- designed for 5x5 shop backroom.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_5x5_backroom_shop",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "y  GG",
            "b   G",
            "b z  ",
            "   zz",
            "CDF  ",
        },
        terrain = { [" "] = "t_floor", ["?"] = "t_floor" },
        furniture = {
            ["?"] = "f_console_broken",
            A = "f_chair",
            B = "f_desk",
            C = "f_rack",
            G = "f_locker",
            b = "f_bench",
            d = "f_filing_cabinet",
            L = "f_shredder",
            y = { { id = "f_indoor_plant" }, { id = "f_indoor_plant_y" } },
            z = { { id = "f_cardboard_box", copies = 5 }, { id = "f_crate_c" } },
        },
        rotation = { 0, 3 },
        vending_glyphs = {
            D = { group = "vending_drink", lootable = true },
            F = { group = "vending_food", lootable = true },
        },
        item_groups = {
            C = { { group = "cleaning", chance = 30, repetitions = { 1, 2 } } },
            G = {
                { group = "jackets", chance = 30, repetitions = { 0, 1 } },
                { group = "bags", chance = 30, repetitions = { 0, 1 } },
            },
        },
    },
}

-- designed for 4x4 shop backroom.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_4x4_backroom_shop",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "FD d",
            "G   ",
            "G   ",
            "ybb ",
        },
        terrain = { [" "] = "t_floor", ["?"] = "t_floor" },
        furniture = {
            ["?"] = "f_console_broken",
            G = "f_locker",
            b = "f_bench",
            d = "f_filing_cabinet",
            y = { { id = "f_indoor_plant" }, { id = "f_indoor_plant_y" } },
        },
        rotation = { 0, 3 },
        vending_glyphs = {
            D = { group = "vending_drink", lootable = true },
            F = { group = "vending_food", lootable = true },
        },
        item_groups = {
            G = {
                { group = "jackets", chance = 30, repetitions = { 0, 1 } },
                { group = "bags", chance = 30, repetitions = { 0, 1 } },
            },
        },
    },
}

-- designed for 4x4 shop backroom.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_4x4_backroom_shop",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "FD d",
            "G   ",
            "G   ",
            "y C ",
        },
        terrain = { [" "] = "t_floor" },
        furniture = {
            C = "f_rack",
            G = "f_sofa",
            d = "f_filing_cabinet",
            y = { { id = "f_indoor_plant" }, { id = "f_indoor_plant_y" } },
            ["?"] = "f_console_broken",
        },
        rotation = { 0, 3 },
        vending_glyphs = {
            D = { group = "vending_drink", lootable = true },
            F = { group = "vending_food", lootable = true },
        },
        item_groups = {
            C = { { group = "cleaning", chance = 30, repetitions = { 1, 2 } } },
            G = {
                { group = "jackets", chance = 30, repetitions = { 0, 1 } },
                { group = "bags", chance = 30, repetitions = { 0, 1 } },
            },
        },
    },
}

-- designed for 4x4 shop backroom.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_4x4_backroom_shop",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "d  L",
            "B   ",
            "BA  ",
            "y GC",
        },
        terrain = { [" "] = "t_floor" },
        furniture = {
            ["?"] = "f_console_broken",
            A = "f_chair",
            B = "f_desk",
            C = "f_rack",
            G = "f_locker",
            d = "f_filing_cabinet",
            L = "f_shredder",
            y = { { id = "f_indoor_plant" }, { id = "f_indoor_plant_y" } },
        },
        rotation = { 0, 3 },
        item_groups = {
            C = { { group = "cleaning", chance = 30, repetitions = { 1, 2 } } },
            B = { { group = "SUS_office_desk", chance = 30, repetitions = { 1, 2 } } },
            G = {
                { group = "jackets", chance = 30, repetitions = { 0, 1 } },
                { group = "bags", chance = 30, repetitions = { 0, 1 } },
            },
        },
    },
}

-- designed for 5x5 shop backroom.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_5x5_backroom_shop",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "d  FD",
            "G b  ",
            "G b z",
            "G b  ",
            "yz CC",
        },
        terrain = { [" "] = "t_floor" },
        furniture = {
            A = "f_chair",
            B = "f_desk",
            C = "f_rack",
            G = "f_locker",
            b = "f_bench",
            d = "f_filing_cabinet",
            L = "f_shredder",
            y = { { id = "f_indoor_plant" }, { id = "f_indoor_plant_y" } },
            z = { { id = "f_cardboard_box", copies = 5 }, { id = "f_crate_c" } },
            ["?"] = "f_console_broken",
        },
        rotation = { 0, 3 },
        vending_glyphs = {
            D = { group = "vending_drink", lootable = true },
            F = { group = "vending_food", lootable = true },
        },
        item_groups = {
            C = { { group = "cleaning", chance = 30, repetitions = { 1, 2 } } },
            G = {
                { group = "jackets", chance = 30, repetitions = { 0, 1 } },
                { group = "bags", chance = 30, repetitions = { 0, 1 } },
            },
        },
    },
}

-- designed for 5x5 shop backroom.
ccb.content.define_mapgen {
    kind = "nested",
    id = "city_block_5x5_backroom_shop",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "d  FD",
            "G    ",
            "G   z",
            "C    ",
            "yAAA ",
        },
        terrain = { [" "] = "t_floor" },
        furniture = {
            A = "f_sofa",
            C = "f_rack",
            G = "f_locker",
            d = "f_filing_cabinet",
            y = { { id = "f_indoor_plant" }, { id = "f_indoor_plant_y" } },
            z = { { id = "f_cardboard_box", copies = 5 }, { id = "f_crate_c" } },
        },
        rotation = { 0, 3 },
        vending_glyphs = {
            D = { group = "vending_drink", lootable = true },
            F = { group = "vending_food", lootable = true },
        },
        item_groups = {
            C = { { group = "cleaning", chance = 30, repetitions = { 1, 2 } } },
            G = {
                { group = "jackets", chance = 30, repetitions = { 0, 1 } },
                { group = "bags", chance = 30, repetitions = { 0, 1 } },
            },
        },
    },
}
