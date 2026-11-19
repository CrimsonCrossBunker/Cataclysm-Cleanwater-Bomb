local ccb = require("ccb")

-- This is the 'base' airdrop, and doesn't actually contain anything. Variants are generated via the place_nested field.
ccb.content.define_mapgen {
    kind = "update",
    id = "mx_airdrop",
    layout = {
        nested = {
            {
                choices = {
                    { id = "mx_airdrop_humanitarian_full", weight = 5 },
                    { id = "mx_airdrop_humanitarian_looted", weight = 93 },
                    { id = "mx_airdrop_mil", weight = 2 },
                },
                x = 0,
                y = 0,
            },
        },
    },
}

-- untouched version of drop, rare
ccb.content.define_mapgen {
    kind = "nested",
    id = "mx_airdrop_humanitarian_full",
    layout = {
        size = { width = 24, height = 24 },
        nested = {
            {
                choices = { { id = "supply_humanitarian", weight = 100 } },
                x = { 0, 22 },
                y = { 0, 22 },
            },
            {
                choices = { { id = "supply_humanitarian", weight = 50 } },
                x = { 0, 22 },
                y = { 0, 22 },
            },
            {
                choices = { { id = "supply_humanitarian", weight = 20 } },
                x = { 0, 22 },
                y = { 0, 22 },
            },
            {
                choices = { { id = "supply_water_bottles_full", weight = 100 } },
                x = { 0, 22 },
                y = { 0, 22 },
            },
            {
                choices = { { id = "supply_water_bottles_full", weight = 50 } },
                x = { 0, 22 },
                y = { 0, 22 },
            },
            {
                choices = { { id = "supply_water_bottles_full", weight = 20 } },
                x = { 0, 22 },
                y = { 0, 22 },
            },
            { choices = { { id = "supply_generatos", weight = 30 } }, x = { 0, 22 }, y = { 0, 22 } },
        },
    },
}

-- versions with a few tents here and there, and some occupants
ccb.content.define_mapgen {
    kind = "nested",
    id = "mx_airdrop_humanitarian_looted",
    layout = {
        size = { width = 24, height = 24 },
        nested = {
            {
                choices = { { id = "supply_humanitarian_used", weight = 100 } },
                x = { 0, 23 },
                y = { 0, 23 },
            },
            {
                choices = { { id = "supply_humanitarian_used", weight = 10 } },
                x = { 0, 23 },
                y = { 0, 23 },
            },
            {
                choices = { { id = "supply_water_bottles_open", weight = 100 } },
                x = { 0, 23 },
                y = { 0, 23 },
            },
            {
                choices = { { id = "supply_water_bottles_open", weight = 50 } },
                x = { 0, 23 },
                y = { 0, 23 },
            },
            {
                choices = { { id = "supply_water_bottles_open", weight = 20 } },
                x = { 0, 23 },
                y = { 0, 23 },
            },
            { choices = { { id = "supply_trash", weight = 50 } }, x = { 0, 23 }, y = { 0, 23 } },
            {
                choices = { { id = "supply_generator_active", weight = 30 } },
                x = { 0, 23 },
                y = { 0, 23 },
            },
        },
        item_placements = {
            {
                id = "shrink_wrap",
                x = { 0, 23 },
                y = { 0, 23 },
                chance = 50,
                repetitions = { 0, 12 },
            },
            {
                id = "bottle_twoliter",
                x = { 0, 23 },
                y = { 0, 23 },
                chance = 50,
                repetitions = { 1, 12 },
            },
            {
                id = "bottle_plastic_small",
                x = { 0, 23 },
                y = { 0, 23 },
                chance = 50,
                repetitions = { 0, 6 },
            },
            { id = "cardboard", x = { 0, 23 }, y = { 0, 23 }, chance = 50, repetitions = { 3, 12 } },
        },
        monster_placements = {
            {
                group = "GROUP_HOUSE",
                x = { 0, 23 },
                y = { 0, 23 },
                chance = 100,
                repetitions = { 4, 6 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "supply_trash",
    layout = {
        size = { width = 1, height = 1 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_group_placements = { { group = "airdrop_trash", x = 0, y = 0, chance = 100 } },
    },
}
