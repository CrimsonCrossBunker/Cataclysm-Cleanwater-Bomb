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
