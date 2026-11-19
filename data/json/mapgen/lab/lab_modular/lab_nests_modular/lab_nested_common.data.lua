local ccb = require("ccb")

-- A nested map for general lab security areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_generic_6x6_open",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "h h h ",
            "s s s ",
            "      ",
            "  II  ",
            "  h   ",
        },
        palettes = { "lab_common_palette", "lab_security_palette" },
        rotation = { 0, 3 },
    },
}

-- A nested map for general lab security areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_generic_6x6_open",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "P sh P",
            "Phs  P",
            "P sh P",
            "h    T",
            "Y     ",
        },
        palettes = { "lab_common_palette", "lab_security_palette" },
        rotation = { 0, 3 },
    },
}

-- A nested map for general office areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_generic_7x7_open",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "yh    Y",
            "       ",
            "h h h h",
            "s s s s",
            "       ",
            " rrr   ",
            "  h  RR",
        },
        palettes = { "lab_common_palette" },
        rotation = { 0, 3 },
    },
}

-- A nested map for general office areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_generic_7x7_open",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "yh    Y",
            "    E E",
            " r     ",
            "hr  rrr",
            "    r  ",
            "h   rh ",
            "Y     P",
        },
        palettes = { "lab_common_palette" },
        rotation = { 0, 3 },
    },
}

-- A nested map for general office areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_generic_7x7_open",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "Y     y",
            "H     H",
            "H     H",
            "s HHH s",
            "H     H",
            "H     H",
            "y     Y",
        },
        palettes = { "lab_common_palette" },
        rotation = { 0, 3 },
    },
}

-- A nested map for general office areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_generic_7x7_open",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "       ",
            "  h   y",
            "  ff  R",
            " hffh R",
            "  ffh h",
            " hffh  ",
            "Y h    ",
        },
        palettes = { "lab_common_palette" },
        rotation = { 0, 3 },
    },
}

-- A nested map for general office areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_generic_7x7_N",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "H     H",
            "H     H",
            "y     T",
            "])]|])]",
            "E T|E y",
            "  r|rr ",
            "Yhr|h Y",
        },
        palettes = { "lab_common_palette" },
        rotation = { 0, 3 },
    },
}

-- A nested map for general office areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_generic_7x7_S",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "Yhr|h Y",
            "  r|rr ",
            "E T|E y",
            "])]|])]",
            "y     T",
            "H     H",
            "H     H",
        },
        palettes = { "lab_common_palette" },
        rotation = { 0, 3 },
    },
}

-- A nested map for general office areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_generic_7x7_N",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "H     E",
            "H rr  E",
            "y  h  Y",
            "])]||+|",
            "E  |P P",
            " rr|P P",
            " hT|P P",
        },
        palettes = { "lab_common_palette" },
        rotation = { 0, 3 },
    },
}

-- A nested map for general office areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_generic_7x7_S",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "Yhr|P P",
            "  r|P P",
            "h T|P P",
            "])]||+|",
            "   h   ",
            "E rr  H",
            "E     H",
        },
        palettes = { "lab_common_palette" },
        rotation = { 0, 3 },
    },
}

-- A nested map for general office areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_generic_7x7_open",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "       ",
            "  h   y",
            "  ff  x",
            " hffh x",
            "  ffh h",
            " hffh  ",
            "Y h    ",
        },
        palettes = { "lab_common_palette" },
        rotation = { 0, 3 },
    },
}

-- A nested map for general lab variety.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_generic_3x3_EW_open",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "UUU",
            "   ",
            "UUU",
        },
        palettes = { "lab_common_palette" },
        item_groups = { U = { { group = "cleaning", chance = 70, repetitions = { 1, 3 } } } },
    },
}

-- A nested map for general lab variety.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_generic_3x3_EW_open",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "VVV",
            "   ",
            "VVV",
        },
        palettes = { "lab_common_palette" },
        item_groups = { V = { { group = "vitamin_shop", chance = 70, repetitions = { 1, 3 } } } },
    },
}

-- A nested map for general lab variety.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_generic_3x3_EW_open",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "PPP",
            "   ",
            "PPP",
        },
        palettes = { "lab_common_palette" },
        item_groups = { P = { { group = "SUS_office_filing_cabinet", chance = 70, repetitions = { 1, 3 } } } },
    },
}

-- A nested map for general lab area.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_common_5x5_open",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            " h  y",
            "rr  P",
            "    P",
            "  rr ",
            "Y  h ",
        },
        palettes = { "lab_common_palette", "lab_maintenance_palette" },
        item_groups = {
            r = { { group = "SUS_office_desk", chance = 70 } },
            P = { { group = "SUS_office_filing_cabinet", chance = 70, repetitions = { 1, 3 } } },
        },
    },
}

-- A nested map for recreational areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_recreational_3x3_open",
    weight = 500,
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "jjj",
            "fff",
            "jjj",
        },
        palettes = { "lab_common_palette" },
        rotation = { 0, 3 },
        item_groups = {
            f = {
                { group = "restaurant_mexican_table", chance = 10 },
                { group = "pizza_table", chance = 10 },
                { group = "bar_food", chance = 10 },
                { group = "coffee_counter", chance = 10 },
            },
        },
    },
}

-- A nested map for recreational areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_recreational_3x3_open",
    weight = 300,
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "G G",
            "K K",
            "G G",
        },
        palettes = { "lab_residential_palette" },
        rotation = { 0, 3 },
        loot_placements = {
            { group = "games", x = 0, y = 1, chance = 25 },
            { group = "games", x = 2, y = 1, chance = 25 },
        },
    },
}

-- A nested map for recreational areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_recreational_3x3_open",
    weight = 300,
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "jjj",
            "եեե",
            "jjj",
        },
        palettes = { "lab_common_palette", "lab_residential_palette" },
        rotation = { 0, 3 },
    },
}

-- A nested map for recreational areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_recreational_3x3_open",
    weight = 300,
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "jjj",
            "jեj",
            "jjj",
        },
        palettes = { "lab_common_palette", "lab_residential_palette" },
        rotation = { 0, 3 },
    },
}

-- A nested map for recreational areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_recreational_3x3_open",
    weight = 100,
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "jjj",
            "jcj",
            "jjj",
        },
        palettes = { "lab_common_palette", "lab_residential_palette" },
        rotation = { 0, 3 },
    },
}

-- A nested map for recreational areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_recreational_3x3_open",
    weight = 50,
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "   ",
            "   ",
            "jjj",
        },
        palettes = { "lab_common_palette" },
        rotation = { 0, 3 },
        vehicle_placements = { { id = "ice_cream_cart", x = 1, y = 0, status = 0, rotation = 90 } },
    },
}

-- A nested map for recreational areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_recreational_3x3_open",
    weight = 50,
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "   ",
            "   ",
            "GKG",
        },
        palettes = { "lab_residential_palette" },
        rotation = { 0, 3 },
        vehicle_placements = { { id = "food_cart", x = 1, y = 0, status = 0, rotation = 180 } },
    },
}
