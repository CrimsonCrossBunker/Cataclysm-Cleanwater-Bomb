local ccb = require("ccb")

-- The flag below implies that part of root got burned and has to be removed
ccb.content.define_item {
    id = "roasted_cattail_rhizome",
    name = ccb.content.plural_text("roasted cattail rhizome", "roasted cattail rhizomes"),
    copy_from = "cattail_rhizome",
    mass = "160 g",
    volume = "220 ml",
    color = "dark_gray",
    description = ccb.content.text("A roasted root from a cattail plant.  Its fibrous outer core is charred black, so you can remove it and chew on the dry inside."),
    inheritance = { add = { flags = { "NUTRIENT_OVERRIDE" } }, remove = { flags = { "RAW" } } },
    subtype_order = { "milling", "comestible" },
    milling = { result = "flour_wheat_free", recipe = "flour_wheat_free_mill_2_15" },
    comestible = { calories = 280, shelf_life = "5 days", fun = -1 },
}

ccb.content.define_item {
    id = "starch",
    name = ccb.content.plural_text("starch", "starch"),
    mass = "180 g",
    color = "light_gray",
    symbol = "%",
    description = ccb.content.text("Sticky, gooey carbohydrate paste extracted from plants.  Spoils rather quickly if not prepared for storage."),
    display_type = "BY_WEIGHT",
    price = "0 cent",
    survival_price = "10 cent",
    materials = { "veggy" },
    volume = "250 ml",
    flags = { "EDIBLE_FROZEN" },
    stackable = true,
    subtype_order = { "milling", "comestible" },
    milling = { result = "flour", recipe = "flour_mill_1_15" },
    comestible = {
        shelf_life = "3 day 12 hours",
        kind = "FOOD",
        calories = 620,
        fun = -14,
        vitamins = { { id = "veggy_allergen", amount = 1 } },
    },
}
