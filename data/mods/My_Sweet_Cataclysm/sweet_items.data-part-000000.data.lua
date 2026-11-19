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
