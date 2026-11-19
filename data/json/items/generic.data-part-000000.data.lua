local ccb = require("ccb")

ccb.content.define_item {
    id = "chitin_piece",
    category = "spare_parts",
    symbol = ",",
    color = "light_gray",
    name = ccb.content.plural_text("chunk of chitin", "chunks of chitin"),
    snippet_category = "chitin_desc",
    description = ccb.content.text("A piece of an insect's exoskeleton.  It is light and very durable."),
    price = "0 cent",
    survival_price = "25 cent",
    materials = { "chitin" },
    flags = { "NO_SALVAGE" },
    mass = "89 g",
    volume = "250 ml",
    milling = { result = "meal_chitin_piece", recipe = "meal_chitin_piece_mill_1_4" },
}

ccb.content.define_item {
    id = "endochitin",
    category = "spare_parts",
    symbol = ",",
    color = "light_gray",
    name = ccb.content.plural_text("strand of endochitin", "strands of endochitin"),
    snippet_category = "endochitin_desc",
    description = ccb.content.text("A piece of an insect's endoskeleton."),
    price = "0 cent",
    materials = { "chitin" },
    flags = { "NO_SALVAGE" },
    mass = "89 g",
    volume = "300 ml",
    milling = { result = "meal_chitin_piece", recipe = "meal_chitin_piece_mill_1_4" },
}
