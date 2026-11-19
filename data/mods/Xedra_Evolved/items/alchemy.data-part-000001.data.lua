local ccb = require("ccb")

ccb.content.define_item {
    id = "sixdust",
    name = ccb.content.plural_text("sixdust", "sixdust"),
    description = ccb.content.text("Sixdust, for when you must scorch the earth.  A sprayable anti-fungal/anti-insecticidal ammo for the chemical thrower.  Best used with some kind of mask or mouth protection."),
    mass = "3 g",
    volume = "250 ml",
    price = "6 USD",
    survival_price = "5 USD",
    materials = { "water" },
    symbol = "=",
    color = "yellow_red",
    default_container = "bottle_plastic",
    sealed_container = false,
    phase = "liquid",
    ammunition = {
        type = "chemical_spray",
        range = 4,
        count = 100,
        effects = {
            "GAS_FUNGICIDAL",
            "STREAM_GAS_FUNGICIDAL",
            "GAS_INSECTICIDAL",
            "STREAM_GAS_INSECTICIDAL",
            "JET",
        },
    },
}
