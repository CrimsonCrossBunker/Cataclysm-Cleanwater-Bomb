local ccb = require("ccb")

-- the calories of 4 units (140 g) of oatmeal
ccb.content.define_item {
    id = "oats",
    name = ccb.content.plural_text("oats", "handfuls of oats"),
    display_type = "BY_WEIGHT",
    mass = "203 g",
    color = "brown",
    symbol = ",",
    description = ccb.content.text("A pile of raw oats."),
    price = "1 USD 20 cent",
    survival_price = "1 USD",
    materials = { "wheat" },
    volume = "250 ml",
    flags = {
        "EDIBLE_FROZEN", "RAW", "INEDIBLE", "CATTLE", "NUTRIENT_OVERRIDE", "PLANTABLE_SEED",
        "CUT_HARVEST", "BIRD", "RAT", "MOUSE",
    },
    subtype_order = { "seed", "milling", "comestible" },
    seed = {
        plant_name = ccb.content.text("oats"),
        fruit = "oat_stalks",
        drop_seeds = false,
        growth_stages = {
            { stage = "GROWTH_SEED", duration = "17 days" },
            { stage = "GROWTH_SEEDLING", duration = "16 days" },
            { stage = "GROWTH_MATURE", duration = "16 days" },
            { stage = "GROWTH_HARVEST", duration = "16 days" },
            { stage = "GROWTH_OVERGROWN", duration = "1 hour" },
        },
        climate = {
            base_c = 4.4,
            optimum_c = 21,
            min_c = -4,
            max_c = 32,
            degree_days = 840,
            water_mm = 480,
            growing_days = 91,
            water_peak = 0.62,
        },
    },
    milling = { result = "flour_wheat_free", recipe = "flour_wheat_free_mill_4_15" },
    comestible = {
        kind = "FOOD",
        quench = -5,
        calories = 524,
        vitamins = {
            { id = "calcium", amount = 3 },
            { id = "iron", amount = 20 },
            { id = "wheat_allergen", amount = 1 },
        },
        pet_food = { "CATTLEFOOD", "BIRDFOOD" },
    },
}
