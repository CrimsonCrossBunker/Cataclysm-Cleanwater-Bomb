local ccb = require("ccb")

ccb.content.define_item {
    id = "demonchitin_harness_dog",
    copy_from = "kevlar_harness",
    color = "red",
    name = ccb.content.plural_text("demon chitin dog mesh harness", "demon chitin dog mesh harnesses"),
    description = ccb.content.text("A makeshift harness of demon chitin fitted to a thin mesh protecting the neck to flank of canines.  You could put this on a friendly dog."),
    price = "500 USD",
    survival_price = "50 USD",
    materials = { "demon_chitin" },
    mass = "1601 g",
    pet_armor = { environmental_protection = 8 },
}

ccb.content.define_item {
    id = "demonchitin_armor_horse",
    copy_from = "horse_armor",
    color = "green",
    name = ccb.content.plural_text("demon chitin horse armor", "demon chitin horse armors"),
    description = ccb.content.text("A makeshift assembly of criniere, peytral and croupiere made from demon chitin fitted to a thin mesh.  You could put this on a friendly horse."),
    price = "1 kUSD 200 USD",
    survival_price = "120 USD",
    materials = { "demon_chitin", "steel" },
    mass = "31500 g",
    volume = "150 L",
    pet_armor = { thickness = 6, environmental_protection = 8 },
}
