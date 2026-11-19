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
