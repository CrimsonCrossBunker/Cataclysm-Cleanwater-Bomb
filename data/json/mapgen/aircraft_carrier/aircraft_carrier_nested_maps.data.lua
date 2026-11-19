local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "crates_supplies_mechanics",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "Ж",
        },
        palettes = { "aircraft_carrier_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "crates_armament_milspec",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "ж",
        },
        palettes = { "aircraft_carrier_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "crates_random_supply",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "Ω",
        },
        palettes = { "aircraft_carrier_palette" },
    },
}
