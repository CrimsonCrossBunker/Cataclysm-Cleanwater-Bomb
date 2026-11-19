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
