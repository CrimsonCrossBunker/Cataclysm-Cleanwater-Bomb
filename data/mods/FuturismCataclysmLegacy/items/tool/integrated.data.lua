local ccb = require("ccb")

ccb.content.define_item {
    id = "fcl_bio_deck_jack",
    category = "tools",
    name = ccb.content.plural_text("Infolink jack", "Infolink jacks"),
    description = ccb.content.text("The interface jack of an implanted Infolink, coiled within your forearm and accessible through a small port in your wrist.  It can be used to interface and hack into electronic devices."),
    mass = "20 g",
    volume = "2 ml",
    price = "1 USD",
    symbol = ",",
    color = "green",
    flags = {
        "INTEGRATED", "UNBREAKABLE", "PERSONAL", "WATER_FRIENDLY", "SOFT", "NO_REPAIR",
        "ALLOWS_NATURAL_ATTACKS", "TRADER_AVOID", "USES_BIONIC_POWER",
    },
    qualities = { { id = "HACK", level = 4 } },
    tool = { charges_per_use = 1, ammo_types = { "battery" } },
}
