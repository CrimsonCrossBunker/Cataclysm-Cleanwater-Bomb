local ccb = require("ccb")

ccb.content.define_item {
    id = "cocaine_topical",
    name = ccb.content.plural_text("cocaine topical cream", "cocaine topical cream"),
    description = ccb.content.text("A medical cream that provides both vascular restriction and anesthetic properties."),
    display_type = "BY_VOLUME",
    mass = "5 g",
    volume = "250 ml",
    price = "5 USD 50 cent",
    survival_price = "30 USD",
    stack_size = 60,
    symbol = "u",
    color = "light_gray",
    phase = "liquid",
    default_container = "bottle_plastic_small",
    flags = { "NO_INGEST", "WATER_DISSOLVE" },
    comestible = { kind = "MED", servings = 6, addiction_potential = 5, addiction = "cocaine" },
    use_actions = {
        {
            kind = "heal",
            bleed = 20,
            moves = 3000,
            effects = { { id = "pkill1_generic", duration = 720 } },
        },
    },
}
