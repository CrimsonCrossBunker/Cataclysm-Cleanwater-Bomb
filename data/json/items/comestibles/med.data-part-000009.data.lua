local ccb = require("ccb")

ccb.content.define_item {
    id = "wintergreen_oil",
    name = ccb.content.plural_text("wintergreen oil", "wintergreen oil"),
    description = ccb.content.text("An ointment infused with wintergreen oil.  Has mild antiseptic properties, and can ease the pain caused by wounds."),
    display_type = "BY_VOLUME",
    mass = "40 g",
    volume = "250 ml",
    price = "0 cent",
    survival_price = "50 cent",
    materials = { "oil" },
    symbol = "~",
    color = "yellow",
    phase = "liquid",
    flags = { "NO_INGEST", "WATER_DISSOLVE", "ALLOWS_REMOTE_USE" },
    comestible = { kind = "MED", servings = 1, fun = -5, shelf_life = "60 days" },
    use_actions = {
        {
            kind = "heal",
            disinfectant_power = 1,
            bleed = 0,
            bite = 0.85,
            moves = 2500,
            effects = { { id = "pkill_wintergreen_oil", duration = "1 h" } },
        },
    },
}
