local ccb = require("ccb")

-- Calories shouldn't matter since it won't spawn - should only be craftable.
ccb.content.define_item {
    id = "amphora_plum_juice",
    copy_from = "oj",
    looks_like = "oj",
    name = ccb.content.plural_text("fresh amphora plum juice", "fresh amphora plum juice"),
    description = ccb.content.text("Freshly-squeezed from real amphora plums!  Tasty, nutritious and highly alcoholic."),
    display_type = "BY_VOLUME",
    comestible = {
        shelf_life = "3 days",
        kind = "DRINK",
        fun = 6,
        vitamins = {
            { id = "vitC", amount = "252 mg" },
            { id = "iron", amount = "40 μg" },
            { id = "calcium", amount = "3 mg" },
            { id = "fruit_allergen", amount = 1 },
            { id = "ethanol", amount = 28 },
        },
    },
}

-- Calories shouldn't matter since it won't spawn - should only be craftable.
ccb.content.define_item {
    id = "oxblood_paste",
    copy_from = "ketchup",
    looks_like = "ketchup",
    name = ccb.content.plural_text("oxblood paste", "oxblood paste"),
    description = ccb.content.text("Boiled and the fibers removed, Oxblood paste becomes more palatable."),
    display_type = "BY_VOLUME",
    comestible = {
        shelf_life = "2 days",
        kind = "DRINK",
        fun = 3,
        vitamins = {
            { id = "vitC", amount = "252 mg" },
            { id = "iron", amount = "40 μg" },
            { id = "calcium", amount = "3 mg" },
            { id = "fruit_allergen", amount = 1 },
            { id = "ethanol", amount = 28 },
        },
    },
}
