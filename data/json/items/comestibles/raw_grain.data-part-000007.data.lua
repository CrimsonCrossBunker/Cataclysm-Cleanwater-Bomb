local ccb = require("ccb")

ccb.content.define_item {
    id = "barley",
    name = ccb.content.plural_text("barley", "handfuls of barley"),
    mass = "211 g",
    color = "brown",
    symbol = ",",
    description = ccb.content.text("A pile of dried barleycorn, a staple of brewing everywhere.  It can be planted, boiled, or ground into flour."),
    price = "5 cent",
    survival_price = "62 cent",
    materials = { "veggy" },
    volume = "250 ml",
    flags = {
        "EDIBLE_FROZEN", "RAW", "INEDIBLE", "CATTLE", "PLANTABLE_SEED", "CUT_HARVEST", "BIRD", "RAT",
        "MOUSE", "NUTRIENT_OVERRIDE",
    },
    subtype_order = { "seed", "milling", "comestible" },
    seed = {
        plant_name = ccb.content.text("barley"),
        fruit = "barley_stalks",
        drop_seeds = false,
        growth_stages = {
            { stage = "GROWTH_SEED", duration = "18 days" },
            { stage = "GROWTH_SEEDLING", duration = "18 days" },
            { stage = "GROWTH_MATURE", duration = "17 days" },
            { stage = "GROWTH_HARVEST", duration = "17 days" },
            { stage = "GROWTH_OVERGROWN", duration = "1 hour" },
        },
        climate = {
            base_c = 4,
            optimum_c = 21,
            min_c = -5,
            max_c = 32,
            degree_days = 870,
            water_mm = 460,
            growing_days = 90,
            water_peak = 0.65,
        },
    },
    milling = { result = "flour", recipe = "flour_mill_1_15" },
    comestible = {
        kind = "FOOD",
        quench = -10,
        calories = 743,
        vitamins = {
            { id = "calcium", amount = 6 },
            { id = "iron", amount = 29 },
            { id = "veggy_allergen", amount = 1 },
        },
        pet_food = { "CATTLEFOOD", "BIRDFOOD" },
    },
}
