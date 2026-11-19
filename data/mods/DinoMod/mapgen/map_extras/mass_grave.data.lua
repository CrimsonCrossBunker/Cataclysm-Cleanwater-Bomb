local ccb = require("ccb")

-- This is the 'base' mass grave, and doesn't actually contain anything. Variants are generated via the place_nested field.
ccb.content.define_mapgen {
    kind = "update",
    id = "mx_mass_grave_dino",
    layout = {
        nested = {
            {
                choices = {
                    { id = "mass_grave_abandoned_dino", weight = 30 },
                    { id = "mass_grave_partial_dino", weight = 20 },
                    { id = "mass_grave_finished_dino", weight = 10 },
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mass_grave_partial_dino",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "                        ",
            "   ##  ##  aa  #a  aa   ",
            "   ##  ##  aa  aa  aa   ",
            "   ##  ##  aa  aa  aa   ",
            "   ##  ##  aa  aa  ##   ",
            "   ##  ##  #a  aa  ##   ",
            "   ##  ##  ##  aa  ##   ",
            "   ##  ##  ##  aa  ##   ",
            "   ##  ##  ##  aa  ##   ",
            "   ##  ##  ##  aa  ##   ",
            "   ##  ##  ##  aa  ##   ",
            "   ##  ##  ##  aa  ## X ",
            "   ##  ##  ##  aa  ##   ",
            "   ##  ##  ##  aa  ##   ",
            "   ##  ##  ##  aa  ##   ",
            "   ##  ##  ##  a#  ##   ",
            "   ##  ##  ##  a#  ##   ",
            "   ##  ##  ##  ##  ##   ",
            "   ##  ##  ##  ##  ##   ",
            "   ##  ##  ##  ##  ##   ",
            "   ##  ##  ##  ##  ##   ",
            "   ##  ##  ##  ##  ##   ",
            "   ##  ##  ##  ##  ##   ",
            "                        ",
        },
        terrain = { a = { { id = "t_pit_corpsed" } }, ["#"] = { { id = "t_dirt" } } },
        furniture = { X = { { id = "f_null", copies = 3 }, { id = "f_battlefield_cross", copies = 1 } } },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = {
            {
                group = "mass_grave_casings",
                repetitions = { 10, 15 },
                x = { 2, 22 },
                y = { 18, 23 },
            },
            { group = "SUS_trash_floor", repetitions = { 5, 6 }, x = { 1, 23 }, y = { 18, 23 } },
        },
        monster_group_placements = {
            { group = "GROUP_DINOSAUR_ZOMBIE", density = 0.5, x = { 1, 22 }, y = { 1, 22 } },
            {
                group = "GROUP_DINOSAUR_ZOMBIE_SCORCHED",
                chance = 35,
                density = 0.5,
                x = { 1, 22 },
                y = { 1, 22 },
            },
        },
        monster_glyphs = { a = { id = "mon_zappalachiosaurus_scorched", chance = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mass_grave_finished_dino",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "                        ",
            "   ##  ##  ##  ##  ##   ",
            "   ##  ##  ##  ##  ##   ",
            "   ##  ##  ##  ##  ##   ",
            "   ##  ##  ##  ##  ##   ",
            "   ##  ##  ##  ##  ##  X",
            "   ##  ##  ##  ##  ##   ",
            "   ##  ##  ##  ##  ## X ",
            "   ##  ##  ##  ##  ##   ",
            "   ##  ##  ##  ##  ##   ",
            "   ##  ##  ##  ##  ##  X",
            "   ##  ##  ##  ##  ##   ",
            "   ##  ##  ##  ##  ##   ",
            "   ##  ##  ##  ##  ##   ",
            "   ##  ##  ##  ##  ## X ",
            "   ##  ##  ##  ##  ##   ",
            "   ##  ##  ##  ##  ##   ",
            "   ##  ##  ##  ##  ##   ",
            "   ##  ##  ##  ##  ##   ",
            "   ##  ##  ##  ##  ##   ",
            "   ##  ##  ##  ##  ##  X",
            "   ##  ##  ##  ##  ##   ",
            "   ##  ##  ##  ##  ##   ",
            "                        ",
        },
        terrain = { ["#"] = { { id = "t_dirt", copies = 24 }, { id = "t_pit_shallow", copies = 1 } } },
        furniture = { X = { { id = "f_null", copies = 19 }, { id = "f_battlefield_cross", copies = 1 } } },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = {
            { group = "mass_grave_casings", repetitions = { 20, 30 }, x = { 1, 23 }, y = { 1, 17 } },
            {
                group = "mass_grave_casings",
                repetitions = { 10, 15 },
                x = { 1, 23 },
                y = { 18, 23 },
            },
            { group = "SUS_trash_floor", repetitions = { 1, 3 }, x = { 1, 23 }, y = { 18, 23 } },
        },
        monster_group_placements = {
            {
                group = "GROUP_DINOSAUR_ZOMBIE_SCORCHED",
                density = 0.1,
                x = { 1, 22 },
                y = { 1, 22 },
            },
        },
        monster_glyphs = { ["#"] = { id = "mon_zaspletosaurus_scorched", chance = 1 } },
    },
}
