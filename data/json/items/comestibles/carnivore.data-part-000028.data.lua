local ccb = require("ccb")

-- It's so alien few micro organisms are able to degrade it.
ccb.content.define_item {
    id = "meat_mi-go",
    category = "other",
    name = ccb.content.plural_text("chunk of mi-go meat", "of mi-go meat chunks"),
    mass = "238 g",
    color = "pink",
    symbol = "%",
    description = ccb.content.text("A piece of mi-go meat that's obviously alien, given its pink color, odd odor, and strange texture.  It would not be advisable to try to eat it."),
    display_type = "BY_WEIGHT",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "mi-go_flesh" },
    volume = "250 ml",
    flags = { "TRADER_AVOID", "NUTRIENT_OVERRIDE" },
    stackable = true,
    comestible = { shelf_life = "90 days", kind = "FOOD", calories = 0, fun = -10 },
    use_actions = { "POISON" },
}
