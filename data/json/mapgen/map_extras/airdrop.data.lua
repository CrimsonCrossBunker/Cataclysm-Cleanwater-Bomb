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

ccb.content.define_mapgen {
    kind = "nested",
    id = "supply_humanitarian",
    layout = {
        size = { width = 2, height = 2 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_placements = {
            { id = "parachute_mil", x = { 0, 1 }, y = 1 },
            { id = "parachute_mil", x = 1, y = { 0, 1 } },
        },
        item_group_placements = { { group = "airdrop_humanitarian_full", x = 0, y = 0, chance = 100 } },
        furniture_placements = { { id = "f_pallet_belted", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "supply_water_bottles_full",
    layout = {
        size = { width = 2, height = 2 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_placements = {
            { id = "parachute_mil", x = { 0, 1 }, y = 1 },
            { id = "parachute_mil", x = 1, y = { 0, 1 } },
        },
        item_group_placements = {
            { group = "twoliter_water_batch", x = 0, y = 0, chance = 100, repetitions = 15 },
            { group = "twoliter_water_batch", x = 0, y = 0, chance = 50, repetitions = 15 },
            { group = "twoliter_water_batch", x = 0, y = 0, chance = 25, repetitions = 15 },
        },
        furniture_placements = { { id = "f_pallet_belted", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "supply_generatos",
    layout = {
        size = { width = 2, height = 2 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_placements = {
            { id = "parachute_mil", x = { 0, 1 }, y = 1 },
            { id = "parachute_mil", x = 1, y = { 0, 1 } },
        },
        item_group_placements = { { group = "airdrop_generator", x = 0, y = 0, chance = 100 } },
        furniture_placements = { { id = "f_pallet_belted", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "supply_humanitarian_used",
    layout = {
        size = { width = 1, height = 1 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_group_placements = { { group = "airdrop_humanitarian_looted", x = 0, y = 0, chance = 100 } },
        furniture_placements = { { id = "f_pallet_belted_open", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "supply_water_bottles_open",
    layout = {
        size = { width = 1, height = 1 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_group_placements = { { group = "twoliter_water_batch", x = 0, y = 0, repetitions = { 0, 11 }, chance = 100 } },
        furniture_placements = { { id = "f_pallet_belted_open", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "supply_generator_active",
    layout = {
        size = { width = 1, height = 1 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_placements = { { id = "laptop", x = 0, y = 0, repetitions = { 0, 4 } } },
        item_group_placements = { { group = "civilian_phones", x = 0, y = 0, repetitions = { 2, 7 } } },
        furniture_placements = { { id = "f_active_backup_generator", x = 0, y = 0 } },
    },
}
