local ccb = require("ccb")

-- 0.8  g/cm3
ccb.content.define_item {
    id = "fertilizer_commercial",
    name = ccb.content.plural_text("commercial fertilizer", "commercial fertilizer"),
    mass = "27 g",
    color = "yellow",
    flags = { "FERTILIZER" },
    fertilizer_quality = 1.0,
    default_container = "bag_canvas",
    symbol = "~",
    description = ccb.content.text("Nutrient-rich granules for plants."),
    price = "16 cent",
    survival_price = "16 cent",
    materials = { "powder" },
    volume = "33 ml",
    category = "chems",
    display_type = "BY_WEIGHT",
    stackable = true,
    comestible = { kind = "FOOD", quench = -10, healthy = -1, calories = 43, fun = -15 },
    use_actions = { "PLANTBLECH" },
}

-- Typically sold in larger quantities, but that's handled in the charge count.
-- Previously 10 doses to a gram, so about 400 to the pound.
ccb.content.define_item {
    id = "fungicide",
    category = "chems",
    name = ccb.content.plural_text("fungicide powder", "fungicide powder"),
    mass = "1 g",
    color = "pink",
    flags = { "EDIBLE_FROZEN" },
    default_container = "bag_plastic_small",
    symbol = "!",
    description = ccb.content.text("Agricultural-grade chemical anti-fungal powder designed to destroy infections in plants."),
    price = "5 cent",
    survival_price = "5 cent",
    materials = { "powder" },
    volume = "1 ml",
    display_type = "BY_WEIGHT",
    stackable = true,
    comestible = { stimulation = -7, kind = "MED", healthy = -7, fun = -15 },
    use_actions = { "FUNGICIDE" },
}
