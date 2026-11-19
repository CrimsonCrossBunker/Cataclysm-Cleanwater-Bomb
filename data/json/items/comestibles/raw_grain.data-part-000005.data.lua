local ccb = require("ccb")

-- These things are rock-hard and not digestible by humans, but birds and cattle can eat them just fine.
ccb.content.define_item {
    id = "wheat",
    name = ccb.content.plural_text("wheat", "handfuls of wheat"),
    mass = "203 g",
    color = "brown",
    symbol = ",",
    description = ccb.content.text("A heap of dried wheatberries, ready for planting.  They're hard as gravel, but could be boiled for food or ground into flour."),
    display_type = "BY_WEIGHT",
    price = "1 USD 20 cent",
    survival_price = "1 USD",
    materials = { "wheat" },
    volume = "250 ml",
    flags = {
        "EDIBLE_FROZEN", "RAW", "INEDIBLE", "CATTLE", "PLANTABLE_SEED", "CUT_HARVEST", "BIRD", "RAT",
        "MOUSE", "NUTRIENT_OVERRIDE",
    },
    stackable = true,
    subtype_order = { "seed", "milling", "comestible" },
    seed = {
        plant_name = ccb.content.text("wheat"),
        fruit = "wheat_stalks",
        drop_seeds = false,
        growth_stages = {
            { stage = "GROWTH_SEED", duration = "30 days" },
            { stage = "GROWTH_SEEDLING", duration = "30 days" },
            { stage = "GROWTH_MATURE", duration = "30 days" },
            { stage = "GROWTH_HARVEST", duration = "30 days" },
            { stage = "GROWTH_OVERGROWN", duration = "1 hour" },
        },
        climate = {
            base_c = 4.4,
            optimum_c = 23,
            min_c = -6,
            max_c = 36,
            degree_days = 1060,
            water_mm = 480,
            growing_days = 109,
            water_peak = 0.7,
        },
    },
    milling = { result = "flour", recipe = "flour_mill_1_15" },
    comestible = {
        kind = "FOOD",
        quench = -10,
        calories = 667,
        vitamins = {
            { id = "calcium", amount = 4 },
            { id = "iron", amount = 40 },
            { id = "wheat_allergen", amount = 1 },
        },
        pet_food = { "CATTLEFOOD", "BIRDFOOD" },
    },
}

-- This avoids copy-from on the base wheat item because that item is coded as a seed despite 'proper' wheat seeds existing. To keep things simple I've not mixed the roles like that.
-- Continuing the trend of hardier winter wheat having ~10% less calories.
ccb.content.define_item {
    id = "winter_wheat",
    name = ccb.content.plural_text("winter wheat", "handfuls of winter wheat"),
    mass = "203 g",
    color = "brown",
    symbol = ",",
    description = ccb.content.text("A heap of dried wheatberries.  They're hard as gravel, but could be boiled for food or ground into flour."),
    display_type = "BY_WEIGHT",
    price = "1 USD 20 cent",
    survival_price = "1 USD",
    materials = { "wheat" },
    volume = "250 ml",
    flags = {
        "EDIBLE_FROZEN", "RAW", "INEDIBLE", "CATTLE", "PLANTABLE_SEED", "CUT_HARVEST", "BIRD", "RAT",
        "MOUSE", "NUTRIENT_OVERRIDE",
    },
    stackable = true,
    subtype_order = { "milling", "comestible" },
    milling = { result = "flour", recipe = "flour_mill_1_15" },
    comestible = {
        kind = "FOOD",
        quench = -10,
        calories = 610,
        vitamins = {
            { id = "calcium", amount = 4 },
            { id = "iron", amount = 40 },
            { id = "wheat_allergen", amount = 1 },
        },
        pet_food = { "CATTLEFOOD", "BIRDFOOD" },
    },
}
