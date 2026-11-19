local ccb = require("ccb")

ccb.content.define_item {
    id = "insect_dust",
    name = ccb.content.plural_text("chitin dust", "chitin dust"),
    category = "spare_parts",
    mass = "40 g",
    color = "white",
    symbol = "%",
    description = ccb.content.text("The dust left over by winged insects such as butterflies or moths.  It's mostly chitin but may also contain dirt and other gross materials."),
    price = "1 cent",
    survival_price = "1 cent",
    materials = { "chitin" },
    flags = { "NO_SALVAGE", "INEDIBLE" },
    volume = "62 ml",
    comestible = { kind = "FOOD" },
}

ccb.content.define_item {
    id = "shed_snakeskin_little",
    name = ccb.content.text("shed snakeskin"),
    copy_from = "shed_snakeskin",
    description = ccb.content.text("A small length of shed snakeskin.  It's thin and translucent but still bears the distinct pattern of scales."),
    mass = "30 g",
    volume = "100 ml",
    comestible = {},
}

ccb.content.define_item {
    id = "shed_snakeskin",
    name = ccb.content.text("shed snakeskin"),
    description = ccb.content.text("The molted dermis of an adult snake.  This one is in one piece.  You can even see the individual eyes."),
    category = "spare_parts",
    materials = { "flesh" },
    symbol = "~",
    color = "white",
    mass = "100 g",
    volume = "400 ml",
    price = "0 cent",
    survival_price = "0 cent",
    flags = { "TRADER_AVOID", "INEDIBLE" },
    comestible = { kind = "FOOD", shelf_life = "60 days", vitamins = { { id = "meat_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "shed_snakeskin_big",
    name = ccb.content.text("big shed snakeskin"),
    copy_from = "shed_snakeskin",
    description = ccb.content.text("A very large shed snakeskin.  This didn't come from anything native, or natural, to New England."),
    mass = "500 g",
    volume = "2 L",
    comestible = {},
}

ccb.content.define_item {
    id = "shed_snakeskin_giant",
    name = ccb.content.text("gigantic shed snakeskin"),
    copy_from = "shed_snakeskin",
    description = ccb.content.text("A complete shed snakeskin of tremendous size.  Whatever left it must be getting even bigger.  You should not be, or return to, wherever you found this."),
    mass = "1 kg",
    volume = "4 L",
    comestible = {},
}

ccb.content.define_item {
    id = "shed_snakeskin_scales",
    name = ccb.content.plural_text("gigantic snake scales", "gigantic snake scales"),
    description = ccb.content.text("A handful of greatly oversized scales from a snake.  This is a troubling find for a few reasons.  There's the size, obviously, but also the unusual hardness in spite of the obvious decay, and the fact that snakes don't shed individual scales like this."),
    category = "spare_parts",
    materials = { "chitin" },
    symbol = "U",
    color = "brown",
    mass = "3 kg",
    volume = "4 L",
    price = "0 cent",
    survival_price = "0 cent",
    flags = { "TRADER_AVOID", "INEDIBLE" },
    comestible = { kind = "FOOD", shelf_life = "60 days" },
}
