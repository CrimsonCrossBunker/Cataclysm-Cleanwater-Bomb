local ccb = require("ccb")

ccb.content.define_item {
    id = "water",
    copy_from = "water",
    name = ccb.content.plural_text("water", "water"),
    comestible = { kind = "DRINK", calories = 0 },
    inheritance = {
        add = {
            flags = { "NUTRIENT_OVERRIDE" },
            contamination = {
                { disease = "xe_hydrating_gout_incubation", probability = 0.1 },
            },
        },
    },
}

ccb.content.define_item {
    id = "water_murky",
    copy_from = "water_murky",
    name = ccb.content.plural_text("murky water", "murky water"),
    comestible = { kind = "DRINK", calories = 0 },
    inheritance = {
        add = {
            flags = { "NUTRIENT_OVERRIDE" },
            contamination = {
                { disease = "xe_hydrating_gout_incubation", probability = 10 },
            },
        },
    },
}
