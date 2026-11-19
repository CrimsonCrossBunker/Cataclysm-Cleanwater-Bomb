local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "base_utensil",
    abstract = true,
    name = ccb.content.text_without_extraction("generic utensil"),
    description = ccb.content.text_without_extraction("generic item template"),
    symbol = ";",
    color = "light_gray",
    price = "2 USD",
    survival_price = "0 cent",
    mass = "158 g",
    volume = "75 ml",
    materials = { "steel" },
    accuracy = { grip = "solid", length = "hand", surface = "point", balance = "neutral" },
    melee_damage = { cut = 2 },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "base_ceramic_dish",
    abstract = true,
    name = ccb.content.text_without_extraction("generic ceramic dish", "generic ceramic dishes"),
    description = ccb.content.text_without_extraction("generic item template"),
    symbol = ")",
    color = "yellow",
    price = "12 USD",
    survival_price = "0 cent",
    materials = { "ceramic" },
    mass = "375 g",
    volume = "375 ml",
    accuracy = { grip = "bad", length = "hand", surface = "any", balance = "clumsy" },
    flags = { "FRAGILE_MELEE" },
    melee_damage = { bash = 3 },
}

ccb.content.define_item {
    id = "ceramic_plate",
    copy_from = "base_ceramic_dish",
    category = "other",
    volume = "125 ml",
    length = "26 cm",
    name = ccb.content.plural_text("ceramic plate", "ceramic plates"),
    symbol = ",",
    description = ccb.content.text("A ceramic dinner plate, unremarkable in every way."),
    qualities = { { id = "CONTAIN", level = 1 } },
}

ccb.content.define_item {
    id = "ladle",
    category = "other",
    ascii_picture = "ladle",
    name = ccb.content.plural_text("ladle", "ladles"),
    description = ccb.content.text("When you need to scoop some soup, this is the utensil for you."),
    looks_like = "spoon",
    copy_from = "base_utensil",
}
