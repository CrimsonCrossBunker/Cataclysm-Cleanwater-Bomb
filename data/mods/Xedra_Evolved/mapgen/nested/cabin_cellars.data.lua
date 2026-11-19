local ccb = require("ccb")

-- A cellar with a setup for hedge magick
ccb.content.define_mapgen {
    kind = "nested",
    id = "cabin_6x6_cellar_nested",
    weight = 250,
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "BB  tt",
            "     t",
            "  OO  ",
            "  OO  ",
            "      ",
            "      ",
        },
        palettes = { "cabin_cellar" },
        furniture = { O = "f_xe_magic_circle", B = "f_bookcase" },
        rotation = { 0, 0 },
        item_groups = {
            B = {
                { group = "esoteric_books", chance = 80, repetitions = { 1, 2 } },
                { group = "hedge_magic_books", chance = 50, repetitions = { 1, 2 } },
            },
            t = { { group = "hedge_magick_materials", chance = 80, repetitions = { 2, 4 } } },
        },
        field_placements = { { id = "fd_dust", x = { 0, 5 }, y = { 0, 5 }, repetitions = { 10, 20 } } },
    },
}

-- A cellar for nether cultists
ccb.content.define_mapgen {
    kind = "nested",
    id = "cabin_6x6_cellar_nested",
    weight = 50,
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "BB  tt",
            "   D t",
            "  OO  ",
            "  OO  ",
            "      ",
            "      ",
        },
        palettes = { "cabin_cellar" },
        furniture = { O = "f_xe_magic_circle", B = "f_bookcase" },
        rotation = { 0, 0 },
        item_groups = {
            B = { { group = "esoteric_books", chance = 80, repetitions = { 1, 2 } } },
            t = { { group = "nether_cabin_ritual_ingredients", chance = 80, repetitions = { 2, 4 } } },
            D = { group = "xe_nether_cult_artifact", chance = 100 },
        },
        field_placements = { { id = "fd_dust", x = { 0, 5 }, y = { 0, 5 }, repetitions = { 10, 20 } } },
        monster_placements = {
            {
                group = "GROUP_NETHER_CULT",
                x = { 0, 5 },
                y = { 0, 5 },
                chance = 66,
                repetitions = { 1, 2 },
            },
        },
    },
}

-- A cellar overlay for a feral vampire.
ccb.content.define_mapgen {
    kind = "nested",
    id = "cabin_6x6_cellar_nested_zombies",
    weight = 200,
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
        loot_placements = {
            { id = "sleeping_bag", x = 1, y = 3, chance = 100, repetitions = { 1, 2 } },
            {
                group = "stash_food",
                x = { 2, 3 },
                y = { 2, 4 },
                chance = 30,
                repetitions = { 2, 3 },
            },
            {
                group = "roof_holdout",
                x = { 2, 3 },
                y = { 2, 4 },
                chance = 70,
                repetitions = { 2, 4 },
            },
        },
        field_placements = { { id = "fd_blood", x = { 0, 5 }, y = { 0, 5 }, repetitions = { 1, 4 } } },
        monster_placements = { { id = "mon_vampire_feral", x = { 0, 5 }, y = { 0, 5 }, chance = 100 } },
    },
}

-- A cellar overlay for XE goblin spiders.  Won't you come out to play?
ccb.content.define_mapgen {
    kind = "nested",
    id = "cabin_6x6_cellar_nested_spiders",
    weight = 250,
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
                group = "GROUP_GOBLIN_SPIDER",
                x = { 0, 5 },
                y = { 0, 5 },
                chance = 100,
                repetitions = { 3, 4 },
            },
        },
    },
}
