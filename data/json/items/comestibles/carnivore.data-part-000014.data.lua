local ccb = require("ccb")

ccb.content.define_item {
    id = "tainted_marrow",
    category = "other",
    name = ccb.content.plural_text("portion of tainted bone marrow", "of tainted bone marrow portions"),
    mass = "60 g",
    volume = "65 ml",
    color = "red",
    symbol = "%",
    description = ccb.content.text("A wet, green chunk of spongy goop extracted from a rotten bone.  You could eat it, but it will poison you."),
    display_type = "BY_WEIGHT",
    price = "0 cent",
    survival_price = "10 cent",
    materials = { "flesh" },
    flags = { "TRADER_AVOID", "RAW" },
    stackable = true,
    comestible = {
        shelf_life = "4 hours",
        kind = "FOOD",
        calories = 235,
        fun = -10,
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
    use_actions = { "POISON" },
}
