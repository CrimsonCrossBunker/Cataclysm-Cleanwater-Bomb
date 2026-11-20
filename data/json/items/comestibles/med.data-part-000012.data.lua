local ccb = require("ccb")

ccb.content.define_item {
    id = "quikclot",
    name = ccb.content.plural_text("hemostatic powder", "hemostatic powder"),
    description = ccb.content.text("A powdered antihemorrhagic compound that reacts with blood to immediately form a gel-like substance that stops bleeding."),
    display_type = "BY_WEIGHT",
    mass = "5 g",
    volume = "5 ml",
    price = "9 cent",
    survival_price = "50 cent",
    materials = { "powder" },
    symbol = "!",
    color = "light_gray",
    default_container = "bag_plastic_small",
    flags = { "NO_INGEST", "IRREPLACEABLE_CONSUMABLE", "WATER_DISSOLVE", "NO_TEMP" },
    stackable = true,
    comestible = { kind = "MED" },
    use_actions = { { kind = "heal", bleed = 20, moves = 2000 } },
}
