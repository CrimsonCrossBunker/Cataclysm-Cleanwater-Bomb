local ccb = require("ccb")

ccb.content.define_item {
    id = "thyme_oil",
    name = ccb.content.plural_text("thyme oil", "thyme oil"),
    description = ccb.content.text("Some essential oil made from thyme, which can act as a mildly irritating antiseptic."),
    display_type = "BY_VOLUME",
    mass = "40 g",
    volume = "250 ml",
    price = "0 cent",
    survival_price = "50 cent",
    materials = { "oil" },
    symbol = "~",
    color = "yellow",
    phase = "liquid",
    flags = { "NO_INGEST" },
    comestible = { kind = "MED", servings = 1, shelf_life = "28 days" },
    use_actions = { { kind = "heal", disinfectant_power = 3, bite = 0.95, moves = 3000 } },
}
