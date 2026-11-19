local ccb = require("ccb")

ccb.content.define_item {
    id = "alien_organs",
    symbol = "¨",
    name = ccb.content.plural_text("unidentifiable alien organs", "unidentifiable alien organs"),
    volume = "166 ml",
    mass = "250 g",
    color = "dark_gray",
    looks_like = "feces_manure",
    description = ccb.content.text("An unidentifiable pile of organs; you have no idea how you'd prepare them."),
    snippet_category = "alien_organ",
    materials = { "flesh" },
    comestible = {
        kind = "FOOD",
        shelf_life = "8 hours",
        healthy = -25,
        fun = -25,
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
    use_actions = { "POISON" },
}
