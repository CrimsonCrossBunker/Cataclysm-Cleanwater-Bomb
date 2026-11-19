local ccb = require("ccb")

-- A nested map for lab commercial shops.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_5x5_bar_front_A",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "   AJ",
            "Aee J",
            " ee J",
            " ee J",
            "   AJ",
        },
        palettes = { "lab_common_palette", "lab_residential_palette" },
        rotation = { 0, 3 },
        item_groups = { J = { { group = "bar_food", chance = 30, repetitions = { 1, 2 } } } },
    },
}

-- A nested map for lab commercial shops.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_5x5_bar_front_B",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "Ø  AJ",
            "AA  Æ",
            "JJJɤJ",
            "    Y",
            "ww 35",
        },
        palettes = { "lab_common_palette", "lab_residential_palette" },
        rotation = { 0, 3 },
        item_groups = {
            J = {
                { group = "bar_food", chance = 30, repetitions = { 1, 2 } },
                { group = "bar_alcohol", chance = 30, repetitions = { 1, 2 } },
            },
            w = { { group = "bar_alcohol", chance = 30, repetitions = { 1, 2 } } },
        },
    },
}

-- A nested map for lab commercial shops.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_5x5_convenience_shop_front_A",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "Y   y",
            "m s q",
            "m s q",
            "m s q",
            "     ",
        },
        palettes = { "lab_common_palette" },
        rotation = { 0, 3 },
        item_groups = {
            s = { { group = "beauty", chance = 30, repetitions = { 1, 2 } } },
            m = { { group = "SUS_fridge_breakroom", chance = 30, repetitions = { 1, 2 } } },
            q = { { group = "vitamin_shop", chance = 30, repetitions = { 0, 4 } } },
        },
    },
}

-- A nested map for lab commercial shops.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_5x5_convenience_shop_front_A",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "ɤJ  s",
            "    s",
            "m Q q",
            "m Q q",
            "m Q q",
        },
        palettes = { "lab_common_palette" },
        rotation = { 0, 3 },
        item_groups = {
            s = { { group = "beauty", chance = 30, repetitions = { 1, 2 } } },
            m = { { group = "SUS_fridge_breakroom", chance = 30, repetitions = { 1, 2 } } },
            q = { { group = "dollar_food", chance = 30, repetitions = { 0, 4 } } },
            Q = { { group = "vitamin_shop", chance = 30, repetitions = { 0, 4 } } },
        },
    },
}

-- A nested map for lab commercial shops.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_5x5_convenience_shop_front_B",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "     ",
            "q s Q",
            "q s Q",
            "q s Q",
            "     ",
        },
        palettes = { "lab_common_palette" },
        rotation = { 0, 3 },
        item_groups = {
            s = { { group = "beauty", chance = 30, repetitions = { 1, 2 } } },
            q = { { group = "dollar_food", chance = 30, repetitions = { 1, 2 } } },
            Q = { { group = "vitamin_shop", chance = 30, repetitions = { 0, 4 } } },
        },
    },
}

-- A nested map for lab commercial shops.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_5x5_convenience_shop_front_B",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "q s Q",
            "q s Q",
            "q s Q",
            "Y   A",
            "2   1",
        },
        palettes = { "lab_common_palette" },
        terrain = { ["1"] = "t_slot_machine" },
        furniture = { ["2"] = "f_atm_off" },
        rotation = { 0, 3 },
        item_groups = {
            s = { { group = "beauty", chance = 30, repetitions = { 1, 2 } } },
            q = { { group = "dollar_food", chance = 30, repetitions = { 1, 2 } } },
            Q = { { group = "vitamin_shop", chance = 30, repetitions = { 0, 4 } } },
        },
    },
}

-- A nested map for lab commercial shops.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_5x5_convenience_shop_front_B",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "     ",
            " sss ",
            "     ",
            " sss ",
            "     ",
        },
        palettes = { "lab_common_palette" },
        rotation = { 0, 3 },
        item_groups = { s = { { group = "beauty", chance = 30, repetitions = { 1, 2 } } } },
    },
}

-- A nested map for lab commercial shops.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_5x5_pizza_shop_front_A",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            " M AJ",
            " M AJ",
            "JJ AJ",
            "m  AJ",
            "m   Y",
        },
        palettes = { "lab_common_palette" },
        rotation = { 0, 3 },
        item_groups = {
            M = { { group = "pizza_display", chance = 30, repetitions = { 1, 2 } } },
            J = { { group = "pizza_table", chance = 30, repetitions = { 1, 2 } } },
            Y = { { group = "SUS_trash_trashcan_public", chance = 30 } },
            m = { { group = "vending_drink", chance = 30 }, { group = "prepared_teas", chance = 30 } },
        },
    },
}

-- A nested map for lab food shops.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_5x5_pizza_shop_front_B",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "y  hh",
            "   ff",
            "HH hh",
            "ff  h",
            "HH hf",
        },
        palettes = { "lab_common_palette" },
        rotation = { 0, 3 },
        item_groups = {
            q = { { group = "pizza_display", chance = 30, repetitions = { 1, 2 } } },
            f = { { group = "pizza_table", chance = 30, repetitions = { 1, 2 } } },
        },
    },
}

-- A nested map for lab commercial shops.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_5x5_restaurant_mexican_front_A",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            " J  m",
            "ɤJ  m",
            "    Y",
            "HH HH",
            "ff ff",
        },
        palettes = { "lab_common_palette" },
        rotation = { 0, 3 },
        item_groups = {
            f = { { group = "restaurant_mexican_table", chance = 30 } },
            Y = { { group = "SUS_trash_trashcan_public", chance = 30 } },
            m = { { group = "vending_drink", chance = 30 }, { group = "pizza_beer", chance = 30 } },
        },
    },
}

-- A nested map for lab food shops.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_5x5_restaurant_mexican_front_B",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "HH HH",
            "y    ",
            "HH HH",
            "ff ff",
            "HH HH",
        },
        palettes = { "lab_common_palette" },
        rotation = { 0, 3 },
        item_groups = { f = { { group = "restaurant_mexican_table", chance = 30 } } },
    },
}

-- A nested map for lab commercial shops.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_5x5_coffee_shop_front_A",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            " M AJ",
            " M AJ",
            "ɤJ AJ",
            "   AJ",
            "m   m",
        },
        palettes = { "lab_common_palette" },
        rotation = { 0, 3 },
        item_groups = {
            M = { { group = "baked_goods", chance = 30, repetitions = { 1, 2 } } },
            J = { { group = "coffee_counter", chance = 30, repetitions = { 1, 2 } } },
            Y = { { group = "SUS_trash_trashcan_public", chance = 30 } },
            m = {
                { group = "coffee_freezer", chance = 30, repetitions = { 1, 6 } },
                { group = "prepared_teas", chance = 30, repetitions = { 0, 6 } },
            },
        },
    },
}

-- A nested map for lab food shops.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_5x5_coffee_shop_front_B",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "w   w",
            "  h Y",
            "h f h",
            "f h f",
            "h   h",
        },
        palettes = { "lab_common_palette" },
        rotation = { 0, 3 },
        item_groups = {
            w = { { group = "coffee_display_2", chance = 30, repetitions = { 1, 2 } } },
            Y = { { group = "SUS_trash_trashcan_public", chance = 30 } },
            f = { { group = "coffee_condiments", chance = 30, repetitions = { 1, 2 } } },
        },
    },
}

-- A nested map for lab food shops.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_5x5_coffee_shop_front_B",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "H   H",
            "H   H",
            "JJJɤJ",
            " A  S",
            "Qq Ym",
        },
        palettes = { "lab_common_palette" },
        rotation = { 0, 3 },
        item_groups = {
            m = {
                { group = "coffee_freezer", chance = 30, repetitions = { 1, 6 } },
                { group = "prepared_teas", chance = 30, repetitions = { 0, 6 } },
            },
            Q = {
                { group = "coffee_condiments", chance = 30, repetitions = { 1, 6 } },
                { group = "coffee_prep", chance = 30, repetitions = { 0, 6 } },
            },
            q = {
                { group = "coffee_display_2", chance = 30, repetitions = { 1, 6 } },
                { group = "prepared_teas", chance = 30, repetitions = { 0, 6 } },
            },
            Y = { { group = "SUS_trash_trashcan_public", chance = 30 } },
            H = { { group = "coffee_newsstand", chance = 30 } },
            J = {
                { group = "coffee_prep", chance = 30, repetitions = { 1, 3 } },
                { group = "coffee_dishes", chance = 30 },
            },
        },
    },
}

-- A nested map for lab commercial shops.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_6x6_pizza_kitchen",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "Y    J",
            "2 J  n",
            "O J  J",
            "O J  5",
            "3    m",
            "wwww m",
        },
        palettes = { "lab_common_palette", "lab_residential_palette" },
        rotation = { 0, 3 },
        item_groups = {
            J = { { group = "pizza_kitchen", chance = 30, repetitions = { 1, 2 } } },
            ["2"] = { group = "pizza_display", chance = 30, repetitions = { 1, 3 } },
            ["3"] = { group = "pizza_display", chance = 70, repetitions = { 1, 3 } },
            m = { group = "pizza_fridge", chance = 70, repetitions = { 1, 3 } },
            w = {
                { group = "produce", chance = 30, repetitions = { 1, 3 } },
                { group = "pizza_kitchen", chance = 60, repetitions = { 1, 3 } },
            },
            Y = { group = "SUS_trash_trashcan_public", chance = 30 },
        },
    },
}

-- A nested map for lab commercial shops.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_6x6_bar_kitchen",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "Q    J",
            "m    O",
            "|+|U J",
            "P ||+|",
            "Ih|   ",
            "I |   ",
        },
        palettes = { "lab_common_palette", "lab_residential_palette" },
        rotation = { 0, 3 },
        item_group_placements = { { group = "keg_beer", x = { 3, 5 }, y = { 4, 5 }, chance = 60, repetitions = { 1, 2 } } },
        item_groups = {
            J = { { group = "bar_food", chance = 30, repetitions = { 1, 2 } } },
            Q = { group = "bar_alcohol", chance = 30, repetitions = { 1, 3 } },
            q = { group = "cleaning", chance = 70, repetitions = { 1, 3 } },
            m = { group = "bar_fridge", chance = 70, repetitions = { 1, 3 } },
        },
    },
}

-- A nested map for lab commercial shops.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_6x6_restaurant_mexican_kitchen",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "Y    J",
            "2 J  n",
            "O J  J",
            "O J  5",
            "3    m",
            "wwww m",
        },
        palettes = { "lab_common_palette", "lab_residential_palette" },
        rotation = { 0, 3 },
        item_groups = {
            J = {
                { group = "SUS_utensils", chance = 5 },
                { group = "SUS_appliances_cupboard", chance = 5 },
                { group = "SUS_oven", chance = 5 },
            },
            ["2"] = { group = "restaurant_mexican_table", chance = 30 },
            ["3"] = { group = "restaurant_mexican_table", chance = 60 },
            m = { group = "restaurant_mexican_fridge", chance = 70 },
            w = { { group = "restaurant_mexican_pantry", chance = 40 } },
            Y = { group = "SUS_trash_trashcan_public", chance = 30 },
        },
    },
}

-- A nested map for lab commercial shops.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_6x6_shop_backroom",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "T     ",
            "I    H",
            "Ih   H",
            "Y    L",
            "   h y",
            "PP IIT",
        },
        palettes = { "lab_common_palette" },
        rotation = { 0, 3 },
        item_groups = {
            I = { { group = "SUS_office_desk", chance = 30, repetitions = { 1, 2 } } },
            P = { { group = "SUS_office_desk", chance = 30, repetitions = { 1, 2 } } },
            L = {
                { group = "jackets", chance = 30, repetitions = { 0, 1 } },
                { group = "bags", chance = 30, repetitions = { 0, 1 } },
            },
        },
    },
}

-- A nested map for lab commercial shops.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_6x6_shop_backroom",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "y    T",
            "L   hI",
            "L    I",
            "|+|| P",
            "U U| P",
            "U U| P",
        },
        palettes = { "lab_common_palette" },
        rotation = { 0, 3 },
        item_groups = {
            I = { { group = "SUS_office_desk", chance = 30, repetitions = { 1, 2 } } },
            P = { { group = "SUS_office_filing_cabinet", chance = 30, repetitions = { 1, 2 } } },
            U = { { group = "cleaning", chance = 30, repetitions = { 0, 4 } } },
            L = {
                { group = "jackets", chance = 30, repetitions = { 0, 1 } },
                { group = "bags", chance = 30, repetitions = { 0, 1 } },
            },
        },
    },
}

-- A nested map for lab commercial shops.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_6x6_shop_backroom",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "U    P",
            "U   II",
            "U   h ",
            "|+||||",
            "L     ",
            "L HHs ",
        },
        palettes = { "lab_common_palette" },
        rotation = { 0, 3 },
        item_groups = {
            I = { { group = "SUS_office_desk", chance = 30, repetitions = { 1, 2 } } },
            P = { { group = "SUS_office_filing_cabinet", chance = 30, repetitions = { 1, 2 } } },
            U = { { group = "cleaning", chance = 30, repetitions = { 0, 4 } } },
            L = {
                { group = "jackets", chance = 30, repetitions = { 0, 1 } },
                { group = "bags", chance = 30, repetitions = { 0, 1 } },
            },
        },
    },
}
