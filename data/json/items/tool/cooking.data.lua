local ccb = require("ccb")

-- roughy a 6-quart pot, these usually hold about 15-16 psi safely
ccb.content.define_item {
    id = "pressure_cooker",
    category = "tools",
    name = ccb.content.plural_text("pressure cooker", "pressure cookers"),
    mass = "6 kg",
    volume = "7500 ml",
    description = ccb.content.text("A sealable pot, designed to cook food at higher pressures and temperatures.  Useful for all kinds of cooking, and it can also be used for pressure-sensitive chemical reactions."),
    price = "65 USD",
    survival_price = "50 cent",
    accuracy = { grip = "bad", length = "short", surface = "any", balance = "clumsy" },
    materials = { "steel" },
    symbol = ")",
    color = "light_gray",
    looks_like = "pot_canning",
    pockets = { { capacity = "6 L", mass_limit = "100 kg", watertight = true, rigid = true } },
    qualities = {
        { id = "COOK", level = 3 },
        { id = "BOIL", level = 2 },
        { id = "CONTAIN", level = 1 },
        { id = "CHEM", level = 1 },
    },
    flags = { "ALLOWS_REMOTE_USE" },
    melee_damage = { bash = 6 },
    use_actions = { "HEAT_ALL_ITEMS" },
}

ccb.content.define_item {
    id = "multi_cooker_filled",
    copy_from = "multi_cooker",
    name = ccb.content.plural_text("multi-cooker - cooking", "multi-cookers - cooking"),
    description = "A professional-grade multi-cooker, with a battery slot for camping trips or tailgating.  There is a dish cooking inside it.",
    tool = {},
    inheritance = {
        remove = {
            qualities = { "CONTAIN" },
        },
    },
}
