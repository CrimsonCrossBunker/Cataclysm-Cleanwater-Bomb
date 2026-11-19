local ccb = require("ccb")

-- a nested map for magiclysm basements.  ID allows it to spawn wherever 6x6 gun basements spawn at the same weight.
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_6x6_guns_N",
    weight = 1000,
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "|||+||",
            "|RR ?|",
            "|E  &|",
            "|T h |",
            "|Y 0!|",
            "||||||",
        },
        palettes = { "standard_domestic_palette" },
        furniture = {
            ["0"] = "f_magic_bench",
            ["!"] = "f_alembic",
            ["&"] = "f_magic_circle",
            ["?"] = "f_rack_wood",
        },
        rotation = { 0, 3 },
        nested_glyphs = {
            ["0"] = {
                choices = {
                    { id = "druid_loot_spawn", weight = 40 },
                    { id = "stormshaper_loot_spawn", weight = 40 },
                    { id = "magus_loot_spawn", weight = 40 },
                    { id = "animist_loot_spawn", weight = 40 },
                    { id = "kelvinist_loot_spawn", weight = 40 },
                    { id = "technomancer_loot_spawn", weight = 40 },
                    { id = "earthshaper_loot_spawn", weight = 40 },
                    { id = "biomancer_loot_spawn", weight = 40 },
                },
            },
        },
        item_groups = {
            E = { group = "enchanted_small_items", chance = 5 },
            R = {
                { group = "magic_shop_books", chance = 40, repetitions = { 0, 2 } },
                { group = "spellbook_loot_2", chance = 2 },
                { group = "academy_lore", chance = 50 },
            },
            ["?"] = {
                { group = "alchemy_items", chance = 35, repetitions = { 1, 2 } },
                { group = "magic_shop_potions", chance = 30 },
                { group = "magic_tools_and_loot", chance = 20 },
                { group = "magic_shop_wands", chance = 5 },
            },
            ["0"] = {
                { group = "enchanted_small_items", chance = 5, repetitions = { 1, 2 } },
                { group = "enchanted_combat_items", chance = 1 },
                { group = "enchanted_misc", chance = 1 },
                { group = "classless_items", chance = 30 },
            },
        },
    },
}

-- a nested map for magiclysm basements.  ID allows it to spawn wherever 6x6 gun basements spawn at the same weight.
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_6x6_guns_S",
    weight = 1000,
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "||||||",
            "|yT0!|",
            "|H h |",
            "|H  &|",
            "|RR ?|",
            "|||+||",
        },
        palettes = { "standard_domestic_palette" },
        furniture = {
            ["0"] = "f_magic_bench",
            ["!"] = "f_alembic",
            ["&"] = "f_magic_circle",
            ["?"] = "f_rack_wood",
        },
        rotation = { 0, 3 },
        nested_glyphs = {
            ["0"] = {
                choices = {
                    { id = "druid_loot_spawn", weight = 40 },
                    { id = "stormshaper_loot_spawn", weight = 40 },
                    { id = "magus_loot_spawn", weight = 40 },
                    { id = "animist_loot_spawn", weight = 40 },
                    { id = "kelvinist_loot_spawn", weight = 40 },
                    { id = "technomancer_loot_spawn", weight = 40 },
                    { id = "earthshaper_loot_spawn", weight = 40 },
                    { id = "biomancer_loot_spawn", weight = 40 },
                },
            },
        },
        item_groups = {
            H = { group = "enchanted_small_items", chance = 5 },
            R = {
                { group = "magic_shop_books", chance = 40 },
                { group = "spellbook_loot_2", chance = 2 },
                { group = "academy_lore", chance = 50 },
            },
            ["?"] = {
                { group = "alchemy_items", chance = 35, repetitions = { 1, 2 } },
                { group = "magic_shop_potions", chance = 30 },
                { group = "magic_tools_and_loot", chance = 20 },
                { group = "magic_shop_wands", chance = 5 },
            },
            ["0"] = {
                { group = "enchanted_small_items", chance = 5, repetitions = { 1, 2 } },
                { group = "enchanted_combat_items", chance = 1 },
                { group = "enchanted_misc", chance = 1 },
                { group = "classless_items", chance = 30 },
            },
        },
    },
}

-- a nested map for magiclysm basements.  ID allows it to spawn wherever 6x6 gun basements spawn at the same weight.
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_6x6_guns_E",
    weight = 1000,
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "||||||",
            "|RR&?|",
            "|E   +",
            "|T h |",
            "|Yy0!|",
            "||||||",
        },
        palettes = { "standard_domestic_palette" },
        furniture = {
            ["0"] = "f_magic_bench",
            ["!"] = "f_alembic",
            ["&"] = "f_magic_circle",
            ["?"] = "f_rack_wood",
        },
        rotation = { 0, 3 },
        nested_glyphs = {
            ["0"] = {
                choices = {
                    { id = "druid_loot_spawn", weight = 40 },
                    { id = "stormshaper_loot_spawn", weight = 40 },
                    { id = "magus_loot_spawn", weight = 40 },
                    { id = "animist_loot_spawn", weight = 40 },
                    { id = "kelvinist_loot_spawn", weight = 40 },
                    { id = "technomancer_loot_spawn", weight = 40 },
                    { id = "earthshaper_loot_spawn", weight = 40 },
                    { id = "biomancer_loot_spawn", weight = 40 },
                },
            },
        },
        item_groups = {
            E = { group = "enchanted_small_items", chance = 5 },
            R = {
                { group = "magic_shop_books", chance = 40 },
                { group = "spellbook_loot_2", chance = 2 },
                { group = "academy_lore", chance = 50 },
            },
            ["?"] = {
                { group = "alchemy_items", chance = 35, repetitions = { 1, 2 } },
                { group = "magic_shop_potions", chance = 30 },
                { group = "magic_tools_and_loot", chance = 20 },
                { group = "magic_shop_wands", chance = 5 },
            },
            ["0"] = {
                { group = "enchanted_small_items", chance = 5, repetitions = { 1, 2 } },
                { group = "enchanted_combat_items", chance = 1 },
                { group = "enchanted_misc", chance = 1 },
                { group = "classless_items", chance = 30 },
            },
        },
    },
}

-- a nested map for magiclysm basements.  ID allows it to spawn wherever 6x6 gun basements spawn at the same weight.
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_6x6_guns_W",
    weight = 1000,
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "||||||",
            "|RRT?|",
            "+   &|",
            "|  h0|",
            "|HH !|",
            "||||||",
        },
        palettes = { "standard_domestic_palette" },
        furniture = {
            ["0"] = "f_magic_bench",
            ["!"] = "f_alembic",
            ["&"] = "f_magic_circle",
            ["?"] = "f_rack_wood",
        },
        rotation = { 0, 3 },
        nested_glyphs = {
            ["0"] = {
                choices = {
                    { id = "druid_loot_spawn", weight = 40 },
                    { id = "stormshaper_loot_spawn", weight = 40 },
                    { id = "magus_loot_spawn", weight = 40 },
                    { id = "animist_loot_spawn", weight = 40 },
                    { id = "kelvinist_loot_spawn", weight = 40 },
                    { id = "technomancer_loot_spawn", weight = 40 },
                    { id = "earthshaper_loot_spawn", weight = 40 },
                    { id = "biomancer_loot_spawn", weight = 40 },
                },
            },
        },
        item_groups = {
            H = { group = "enchanted_small_items", chance = 5 },
            R = {
                { group = "magic_shop_books", chance = 40 },
                { group = "spellbook_loot_2", chance = 2 },
                { group = "academy_lore", chance = 50 },
            },
            ["?"] = {
                { group = "alchemy_items", chance = 35, repetitions = { 1, 2 } },
                { group = "magic_shop_potions", chance = 30 },
                { group = "magic_tools_and_loot", chance = 20 },
                { group = "magic_shop_wands", chance = 5 },
            },
            ["0"] = {
                { group = "enchanted_small_items", chance = 5, repetitions = { 1, 2 } },
                { group = "enchanted_combat_items", chance = 1 },
                { group = "enchanted_misc", chance = 1 },
                { group = "classless_items", chance = 30 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "druid_loot_spawn",
    layout = {
        size = { width = 1, height = 1 },
        loot_placements = { { group = "druid_items", x = 0, y = 0, chance = 70 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "biomancer_loot_spawn",
    layout = {
        size = { width = 1, height = 1 },
        loot_placements = { { group = "biomancer_items", x = 0, y = 0, chance = 70 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "earthshaper_loot_spawn",
    layout = {
        size = { width = 1, height = 1 },
        loot_placements = { { group = "earthshaper_items", x = 0, y = 0, chance = 70 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "technomancer_loot_spawn",
    layout = {
        size = { width = 1, height = 1 },
        loot_placements = { { group = "technomancer_items", x = 0, y = 0, chance = 70 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "kelvinist_loot_spawn",
    layout = {
        size = { width = 1, height = 1 },
        loot_placements = { { group = "kelvinist_items", x = 0, y = 0, chance = 70 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "animist_loot_spawn",
    layout = {
        size = { width = 1, height = 1 },
        loot_placements = { { group = "animist_items", x = 0, y = 0, chance = 70 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "magus_loot_spawn",
    layout = {
        size = { width = 1, height = 1 },
        loot_placements = { { group = "magus_items", x = 0, y = 0, chance = 70 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "stormshaper_loot_spawn",
    layout = {
        size = { width = 1, height = 1 },
        loot_placements = { { group = "stormshaper_items", x = 0, y = 0, chance = 70 } },
    },
}
