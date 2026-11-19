local ccb = require("ccb")

ccb.content.define_item {
    id = "nether_huntsman_organ",
    name = ccb.content.text("reverberating organ"),
    mass = "800 g",
    color = "black_red",
    symbol = ",",
    description = ccb.content.text("A tubular leathery organ of an alien creature, comprised of tough muscle tissue.  Dozens of deep ridges make up the slimy surface, like a disgusting rendition of an accordion."),
    price = "0 cent",
    materials = { "flesh" },
    volume = "1 L",
    flags = { "STRICT_HUMANITARIANISM" },
    stackable = true,
    comestible = {
        kind = "FOOD",
        healthy = -1,
        calories = 186,
        fun = -30,
        shelf_life = "1 day",
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "nether_grub",
    name = ccb.content.text("alien grub"),
    mass = "54 g",
    color = "black_red",
    symbol = "g",
    description = ccb.content.text("A segmented chitinous shell with curious markings is sheltering a weird alien larva, squirming and wiggling around.  Theorizing what it could eventually turn into, you're unsure if it is safe to keep around."),
    price = "0 cent",
    materials = { "flesh" },
    volume = "50 ml",
    stackable = true,
    comestible = {
        kind = "FOOD",
        healthy = -1,
        calories = 213,
        fun = -20,
        shelf_life = "30 days",
        vitamins = {
            { id = "vitC", amount = 8 },
            { id = "calcium", amount = 72 },
            { id = "iron", amount = 231 },
            { id = "mutant_toxin", amount = 110 },
            { id = "meat_allergen", amount = 1 },
        },
    },
}
