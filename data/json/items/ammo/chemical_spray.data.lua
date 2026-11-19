local ccb = require("ccb")

ccb.content.define_item {
    id = "gas_chloramine",
    name = ccb.content.plural_text("sprayable toxic gas", "sprayable toxic gas"),
    description = ccb.content.text("A hazardous mixture made from household cleaning chemicals, improvised for use in a chemical thrower.  Best used with some kind of mask or mouth protection."),
    mass = "3 g",
    volume = "250 ml",
    price = "35 USD",
    survival_price = "5 USD",
    materials = { "water" },
    symbol = "=",
    color = "green",
    default_container = "bottle_plastic",
    sealed_container = false,
    phase = "liquid",
    ammunition = {
        type = "chemical_spray",
        range = 4,
        count = 100,
        effects = { "TOXICGAS", "JET", "SPECIAL_COOKOFF" },
    },
}

ccb.content.define_item {
    id = "gas_fungicidal",
    name = ccb.content.plural_text("sprayable fungicide", "sprayable fungicide"),
    description = ccb.content.text("Fungicide enhanced with sulfur to create sprayable anti-fungal ammo for the chemical thrower.  Best used with some kind of mask or mouth protection."),
    mass = "3 g",
    volume = "250 ml",
    price = "6 USD",
    survival_price = "5 USD",
    materials = { "water" },
    symbol = "=",
    color = "yellow",
    default_container = "bottle_plastic",
    sealed_container = false,
    phase = "liquid",
    ammunition = {
        type = "chemical_spray",
        range = 4,
        count = 100,
        effects = { "GAS_FUNGICIDAL", "STREAM_GAS_FUNGICIDAL", "JET" },
    },
}

ccb.content.define_item {
    id = "gas_insecticidal",
    name = ccb.content.plural_text("sprayable insecticide", "sprayable insecticide"),
    description = ccb.content.text("Strong sprayable insecticide ammo for the chemical thrower.  Best used with some kind of mask or mouth protection."),
    mass = "3 g",
    volume = "250 ml",
    price = "5 USD",
    survival_price = "5 USD",
    materials = { "water" },
    symbol = "=",
    color = "yellow",
    default_container = "bottle_plastic",
    sealed_container = false,
    phase = "liquid",
    ammunition = {
        type = "chemical_spray",
        range = 4,
        count = 100,
        effects = { "GAS_INSECTICIDAL", "STREAM_GAS_INSECTICIDAL", "JET" },
    },
}
