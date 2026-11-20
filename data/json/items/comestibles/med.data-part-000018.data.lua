local ccb = require("ccb")

ccb.content.define_item {
    id = "cattail_jelly",
    name = ccb.content.plural_text("cattail jelly", "cattail jelly"),
    description = ccb.content.text("Clear jelly harvested from cattails.  Can be used to protect a wound from contamination, and works as a painkiller."),
    display_type = "BY_VOLUME",
    default_container = "bottle_plastic_small",
    mass = "18 g",
    volume = "125 ml",
    price = "50 cent",
    survival_price = "50 cent",
    materials = { "water", "veggy" },
    phase = "liquid",
    symbol = "~",
    color = "light_blue",
    flags = { "NO_INGEST", "WATER_DISSOLVE" },
    comestible = { kind = "MED", servings = 7 },
    use_actions = {
        {
            kind = "heal",
            disinfectant_power = 1,
            bite = 0.75,
            moves = 3000,
            effects = { { id = "pkill1_generic", duration = 720 } },
        },
    },
}
