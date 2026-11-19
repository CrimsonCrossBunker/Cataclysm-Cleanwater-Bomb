local ccb = require("ccb")

ccb.content.define_item {
    id = "rune_wildwood",
    name = ccb.content.plural_text("wildwood rune", "wildwood runes"),
    description = ccb.content.text("A small druid rune wrapped in a leaf.  It appears to be made of some kind of resin, and is very sticky."),
    price = "0 USD",
    mass = "40 g",
    volume = "50 ml",
    symbol = ",",
    color = "green",
    subtype_order = { "tool", "comestible" },
    tool = {},
    comestible = { quench = 1, calories = 350, kind = "INVALID", pet_food = { "rune_wildwood" } },
    use_actions = { "PETFOOD" },
}
