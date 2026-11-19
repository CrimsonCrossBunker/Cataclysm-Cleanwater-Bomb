local ccb = require("ccb")

-- Right now, it's just used in a quest, and should not spawn naturally.
ccb.content.define_item {
    id = "fert_supplement",
    name = ccb.content.plural_text("fertility supplement", "fertility supplement"),
    flags = { "EDIBLE_FROZEN", "WATER_DISSOLVE", "NO_INGEST", "MISSION_ITEM" },
    mass = "1 g",
    color = "pink",
    default_container = "bottle_plastic_pill_supplement",
    symbol = "%",
    description = ccb.content.text("A pill for those looking to have children.  It is of no use to you."),
    price = "1 cent",
    volume = "10 ml",
    display_type = "BY_WEIGHT",
    stackable = true,
    comestible = { kind = "FOOD", calories = 10 },
}

-- Due to change of volume to 1ml from 125, price per unit is now less  then 1 cent, i found the price of a 3.5L of bleach to be roughly $7.50
ccb.content.define_item {
    id = "bleach",
    name = ccb.content.plural_text("bleach", "bleach"),
    mass = "1 g",
    color = "white",
    flags = { "CORROSIVE", "NUTRIENT_OVERRIDE" },
    default_container = "jug_plastic",
    sealed_container = false,
    symbol = "~",
    description = ccb.content.text("Sodium hypochlorite, a common household cleaning agent."),
    price = "0 cent",
    survival_price = "0 cent",
    volume = "1 ml",
    phase = "liquid",
    category = "chems",
    conditional_names = { { kind = "FLAG", key = "DIRTY", name = ccb.content.text("bleach spill") } },
    display_type = "BY_VOLUME",
    comestible = { kind = "INVALID", servings = 1, freezing_point = -8 },
}
