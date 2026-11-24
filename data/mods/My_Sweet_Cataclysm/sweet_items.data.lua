local ccb = require("ccb")

-- This item should not get any use whatsoever, it is merely conservation.
ccb.content.define_item {
    id = "ruined_candy",
    symbol = "¨",
    name = ccb.content.plural_text("pieces of candy wrapper", "pieces of candy wrapper"),
    volume = "100 ml",
    mass = "100 g",
    color = "white",
    looks_like = "wrapper",
    description = ccb.content.text("Bits and pieces of plastic entangled in sticky candy goop.  They spot some bright colors and might have been part of a candy wrapper at some point.  Maybe you could suck the sugar from them, if you're really desperate."),
    materials = { "junk" },
    comestible = { kind = "FOOD", calories = 10, vitamins = { { id = "junk_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "feces_candy",
    symbol = "^",
    name = ccb.content.plural_text("sticky sludge", "sticky sludge"),
    volume = "100 ml",
    mass = "100 g",
    color = "white",
    looks_like = "ruined_candy",
    description = ccb.content.text("A pile of weird sticky sludge.  It looks absolutely disgusting but smells kind of sweet."),
    materials = { "junk" },
    comestible = { kind = "FOOD", calories = 10, fun = -12, vitamins = { { id = "junk_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "rock_candy_chunk",
    category = "spare_parts",
    name = ccb.content.plural_text("rock candy chunk", "rock candy chunks"),
    description = ccb.content.text("This is a chunk of hard rock candy.  It can be broken down into sugar."),
    mass = "50 g",
    volume = "250 ml",
    price = "0 cent",
    survival_price = "10 cent",
    materials = { "rock_candy" },
    symbol = ",",
    color = "light_gray",
    flags = { "NO_SALVAGE" },
    tool = {},
}

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
