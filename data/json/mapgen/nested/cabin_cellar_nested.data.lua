local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "cabin_cellar_stairs",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "          ",
            "          ",
            "          ",
            "          ",
            "          ",
            "          ",
            "          ",
            "          ",
            "       >  ",
            "          ",
        },
        palettes = { "cabin_cellar" },
        rotation = { 0, 0 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { id = "cabin_cellar", x = 0, y = 0, z = -1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "cabin_cellar",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "#--------#",
            "#-......-#",
            "#-......-#",
            "#-......-#",
            "#-......-#",
            "#-......-#",
            "#-......-#",
            "#------.-#",
            "######-<-#",
            "######---#",
        },
        palettes = { "cabin_cellar" },
        rotation = { 0, 0 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            { id = "cabin_6x6_cellar_nested", x = 2, y = 1 },
            {
                choices = {
                    { id = "null", weight = 90 },
                    { id = "cabin_6x6_cellar_nested_zombies", weight = 15 },
                    { id = "cabin_6x6_cellar_nested_spiders", weight = 5 },
                    { id = "cabin_6x6_cellar_nested_mycus", weight = 1 },
                },
                x = 2,
                y = 1,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "cabin_cellar_2x2_moonshine_still",
    layout = {
        size = { width = 2, height = 2 },
        rows = {
            "SV",
            "  ",
        },
        furniture = { S = "f_still", V = "f_fvat_empty" },
        rotation = { 0, 0 },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "cabin_cellar_1x1_junk_box",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            " ",
        },
        rotation = { 0, 0 },
        item_group_placements = { { group = "cabin_nested_cellar_boxed_junk", x = 0, y = 0 } },
    },
}

-- A cellar overlay for zombies.  It is the zombie apocalypse, after all.
ccb.content.define_mapgen {
    kind = "nested",
    id = "cabin_6x6_cellar_nested_zombies",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "      ",
            "      ",
            "      ",
            "      ",
            "      ",
        },
        palettes = { "cabin_cellar" },
        rotation = { 0, 0 },
        monster_placements = {
            {
                group = "GROUP_VANILLA_DORMANT",
                x = { 0, 5 },
                y = { 0, 5 },
                chance = 100,
                repetitions = { 1, 6 },
            },
        },
    },
}

-- A cellar filled with various bits of hobby equipment for hiking, hunting, or camping
ccb.content.define_mapgen {
    kind = "nested",
    id = "cabin_6x6_cellar_nested",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "NNNNNN",
            "Nnnnn ",
            "Nn    ",
            "Nn nn ",
            "Nn nn ",
            "N     ",
        },
        palettes = { "cabin_cellar" },
        rotation = { 0, 0 },
        nested_glyphs = {
            N = {
                choices = { { id = "cabin_cellar_1x1_junk_box", weight = 20 }, { id = "null", weight = 5 } },
            },
            n = {
                choices = { { id = "cabin_cellar_1x1_junk_box", weight = 1 }, { id = "null", weight = 1 } },
            },
        },
        field_placements = { { id = "fd_dust", x = { 0, 5 }, y = { 0, 5 }, repetitions = { 10, 20 } } },
    },
}

-- A cellar filled with preserved food
ccb.content.define_mapgen {
    kind = "nested",
    id = "cabin_6x6_cellar_nested",
    weight = 900,
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            " R  R ",
            " R  R ",
            " R  R ",
            " R  R ",
            "      ",
        },
        palettes = { "cabin_cellar" },
        rotation = { 0, 0 },
        item_groups = { R = { group = "preserved_food", chance = 80, repetitions = { 1, 4 } } },
        field_placements = { { id = "fd_dust", x = { 0, 5 }, y = { 0, 5 }, repetitions = { 10, 20 } } },
    },
}

-- A cellar that's totally empty
ccb.content.define_mapgen {
    kind = "nested",
    id = "cabin_6x6_cellar_nested",
    weight = 600,
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "      ",
            "      ",
            "      ",
            "      ",
            "      ",
        },
        palettes = { "cabin_cellar" },
        rotation = { 0, 0 },
        field_placements = { { id = "fd_dust", x = { 0, 5 }, y = { 0, 5 }, repetitions = { 10, 20 } } },
    },
}

-- A cellar with booze.  Drink up!
ccb.content.define_mapgen {
    kind = "nested",
    id = "cabin_6x6_cellar_nested",
    weight = 500,
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "R     ",
            "R   c ",
            "R ctt ",
            "R ctt ",
            "   c  ",
            "      ",
        },
        palettes = { "cabin_cellar" },
        rotation = { 0, 0 },
        nested = {
            {
                choices = {
                    { id = "null", weight = 2 },
                    { id = "cabin_cellar_2x2_moonshine_still", weight = 1 },
                },
                x = 1,
                y = 0,
            },
        },
        item_groups = { R = { group = "liquor_and_spirits", chance = 80, repetitions = { 1, 4 } } },
        item_placements = {
            { id = "bottle_glass", x = 3, y = 2, chance = 80 },
            { id = "bottle_glass", x = 3, y = 3, chance = 80 },
            { id = "bottle_glass", x = 4, y = 2, chance = 80 },
            { id = "bottle_glass", x = 4, y = 3, chance = 80 },
            { id = "deck_of_cards", x = 4, y = 3, chance = 50 },
        },
        field_placements = { { id = "fd_dust", x = { 0, 5 }, y = { 0, 5 }, repetitions = { 10, 20 } } },
    },
}

-- A cellar with stored furniture
ccb.content.define_mapgen {
    kind = "nested",
    id = "cabin_6x6_cellar_nested",
    weight = 450,
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "ttttcc",
            "ttcccc",
            "      ",
            "      ",
            "      ",
            "      ",
        },
        palettes = { "cabin_cellar" },
        rotation = { 0, 0 },
        item_placements = {
            { id = "tourist_table", x = 0, y = 2, chance = 50 },
            { id = "tourist_table", x = 1, y = 2, chance = 50 },
            { id = "box_large_wood", x = 0, y = 3, chance = 50 },
            { id = "box_large_wood", x = 0, y = 4, chance = 50 },
            { id = "box_large_wood", x = 0, y = 5, chance = 50 },
            { id = "box_large_wood", x = 1, y = 3, chance = 50 },
            { id = "box_large_wood", x = 1, y = 4, chance = 50 },
            { id = "box_large_wood", x = 1, y = 5, chance = 50 },
        },
        field_placements = { { id = "fd_dust", x = { 0, 5 }, y = { 0, 5 }, repetitions = { 10, 20 } } },
    },
}

-- A cellar that's totally empty and also has no dust.  Mysterious!
ccb.content.define_mapgen {
    kind = "nested",
    id = "cabin_6x6_cellar_nested",
    weight = 50,
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "      ",
            "      ",
            "      ",
            "      ",
            "      ",
        },
        palettes = { "cabin_cellar" },
        rotation = { 0, 0 },
    },
}

-- A cellar with bones on a table and candles on the floor around it.  What happened here?
ccb.content.define_mapgen {
    kind = "nested",
    id = "cabin_6x6_cellar_nested",
    weight = 25,
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "      ",
            "  tt  ",
            "  tt  ",
            "      ",
            "      ",
        },
        palettes = { "cabin_cellar" },
        rotation = { 0, 0 },
        item_placements = {
            { id = "bone", x = 2, y = 2, repetitions = { 1, 2 } },
            { id = "bone", x = 3, y = 2, repetitions = { 1, 2 } },
            { id = "bone", x = 2, y = 3, repetitions = { 1, 2 } },
            { id = "bone", x = 3, y = 3, repetitions = { 1, 2 } },
            { id = "candle", x = 1, y = 1, chance = 95 },
            { id = "candle", x = 4, y = 1, chance = 95 },
            { id = "candle", x = 1, y = 4, chance = 95 },
            { id = "candle", x = 4, y = 4, chance = 95 },
        },
        field_placements = { { id = "fd_dust", x = { 0, 5 }, y = { 0, 5 }, repetitions = { 10, 20 } } },
    },
}

-- A cellar overlay for spiders.  Spiders!!
ccb.content.define_mapgen {
    kind = "nested",
    id = "cabin_6x6_cellar_nested_spiders",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "      ",
            "      ",
            "      ",
            "      ",
            "      ",
        },
        palettes = { "cabin_cellar" },
        rotation = { 0, 0 },
        field_placements = { { id = "fd_web", x = { 0, 5 }, y = { 0, 5 }, repetitions = { 10, 20 } } },
        monster_placements = {
            {
                group = "GROUP_SPIDER_BASEMENT",
                x = { 0, 5 },
                y = { 0, 5 },
                chance = 100,
                repetitions = { 3, 4 },
            },
        },
    },
}
