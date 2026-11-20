local ccb = require("ccb")

ccb.content.define_item {
    id = "bfipowder",
    name = ccb.content.plural_text("antiseptic powder", "antiseptic powder"),
    description = ccb.content.text("A powdered form of chemical antiseptic, this bismuth formic iodide cleans wounds quickly and painlessly."),
    display_type = "BY_WEIGHT",
    mass = "6 g",
    volume = "6 ml",
    price = "22 cent",
    survival_price = "50 cent",
    materials = { "powder" },
    symbol = "!",
    color = "white",
    default_container = "bottle_plastic_small",
    flags = { "NO_INGEST", "IRREPLACEABLE_CONSUMABLE", "WATER_DISSOLVE", "NO_TEMP" },
    stackable = true,
    comestible = { kind = "MED" },
    use_actions = { { kind = "heal", disinfectant_power = 4, bite = 0.95, moves = 2000 } },
}
