local ccb = require("ccb")

-- extra rare version, also has few mil troops.  Should be a separate map extra, but i still don't know what one should contain,
ccb.content.define_mapgen {
    kind = "nested",
    id = "mx_airdrop_mil",
    layout = {
        size = { width = 24, height = 24 },
        nested = {
            {
                choices = { { id = "supply_generatos_mil", weight = 50 } },
                x = { 0, 22 },
                y = { 0, 22 },
            },
            {
                choices = { { id = "supply_water_drums_55", weight = 100 } },
                x = { 0, 22 },
                y = { 0, 22 },
            },
            {
                choices = { { id = "supply_water_drums_55", weight = 50 } },
                x = { 0, 22 },
                y = { 0, 22 },
            },
            {
                choices = { { id = "supply_water_drums_55", weight = 20 } },
                x = { 0, 22 },
                y = { 0, 22 },
            },
            { choices = { { id = "supply_fuel_gas", weight = 35 } }, x = { 0, 22 }, y = { 0, 22 } },
            {
                choices = { { id = "supply_fuel_diesel", weight = 35 } },
                x = { 0, 22 },
                y = { 0, 22 },
            },
            { choices = { { id = "supply_fuel_jp8", weight = 35 } }, x = { 0, 22 }, y = { 0, 22 } },
            {
                choices = { { id = "supply_military_kit", weight = 50 } },
                x = { 0, 22 },
                y = { 0, 22 },
            },
            {
                choices = { { id = "supply_military_kit", weight = 50 } },
                x = { 0, 22 },
                y = { 0, 22 },
            },
        },
        monster_placements = { { group = "GROUP_MIL_EXTRA", x = { 0, 23 }, y = { 0, 23 }, repetitions = { 10, 16 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "supply_generatos_mil",
    layout = {
        size = { width = 2, height = 2 },
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
    id = "supply_water_drums_55",
    layout = {
        size = { width = 2, height = 2 },
        item_placements = {
            { id = "parachute_mil", x = { 0, 1 }, y = 1 },
            { id = "parachute_mil", x = 1, y = { 0, 1 } },
        },
        item_group_placements = { { group = "airdrop_water_drum", x = 0, y = 0, chance = 100, repetitions = 4 } },
        furniture_placements = { { id = "f_pallet_belted", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "supply_military_kit",
    layout = {
        size = { width = 2, height = 2 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_placements = {
            { id = "parachute_mil", x = { 0, 1 }, y = 1 },
            { id = "parachute_mil", x = 1, y = { 0, 1 } },
        },
        item_group_placements = { { group = "airdrop_military_kit", x = 0, y = 0, chance = 100 } },
        furniture_placements = { { id = "f_pallet_belted", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "supply_fuel_gas",
    layout = {
        size = { width = 2, height = 2 },
        furniture_placements = {
            { id = "f_432gal_drum_rubber", x = 0, y = 0 },
            { id = "f_432gal_drum_rubber", x = 1, y = 1 },
        },
        item_placements = {
            { id = "parachute_mil", x = { 0, 1 }, y = 1 },
            { id = "parachute_mil", x = 1, y = { 0, 1 } },
        },
        liquid_placements = {
            { id = "gasoline", x = 0, y = 0, amount = { 9000, 10000 } },
            { id = "gasoline", x = 1, y = 1, amount = { 9000, 10000 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "supply_fuel_diesel",
    layout = {
        size = { width = 2, height = 2 },
        furniture_placements = {
            { id = "f_432gal_drum_rubber", x = 0, y = 0 },
            { id = "f_432gal_drum_rubber", x = 1, y = 1 },
        },
        liquid_placements = {
            { id = "diesel", x = 0, y = 0, amount = { 9000, 10000 } },
            { id = "diesel", x = 1, y = 1, amount = { 9000, 10000 } },
        },
        item_placements = {
            { id = "parachute_mil", x = { 0, 1 }, y = 1 },
            { id = "parachute_mil", x = 1, y = { 0, 1 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "supply_fuel_jp8",
    layout = {
        size = { width = 2, height = 2 },
        furniture_placements = {
            { id = "f_432gal_drum_rubber", x = 0, y = 0 },
            { id = "f_432gal_drum_rubber", x = 1, y = 1 },
        },
        item_placements = {
            { id = "parachute_mil", x = { 0, 1 }, y = 1 },
            { id = "parachute_mil", x = 1, y = { 0, 1 } },
        },
        liquid_placements = {
            { id = "jp8", x = 0, y = 0, amount = { 9000, 10000 } },
            { id = "jp8", x = 1, y = 1, amount = { 9000, 10000 } },
        },
    },
}
