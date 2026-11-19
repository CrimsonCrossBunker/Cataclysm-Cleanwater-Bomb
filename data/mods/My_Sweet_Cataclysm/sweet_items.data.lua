local ccb = require("ccb")

ccb.content.define_item {
    id = "sugar",
    name = ccb.content.plural_text("sugar", "sugar"),
    copy_from = "sugar",
    color = "white",
    symbol = "%",
    description = ccb.content.text("Sweet, sweet sugar.  Bad for your teeth and surprisingly not very tasty on its own."),
    materials = { "junk" },
    comestible = { vitamins = { { id = "junk_allergen", amount = 1 } } },
}

-- values based off of sucrose's density and our 'bone' item
ccb.content.define_item {
    id = "bone_sugar",
    name = ccb.content.plural_text("sugar bone", "sugar bone"),
    description = ccb.content.text("A large bone, made entirely of super-compressed sugar.  Way too hard to be eaten directly, but it can be broken down into sugar."),
    mass = "508 g",
    volume = "320 ml",
    symbol = "I",
    price = "0 cent",
    survival_price = "20 cent",
    color = "white",
    materials = { "rock_candy" },
    flags = { "INEDIBLE" },
    comestible = { kind = "FOOD" },
}
