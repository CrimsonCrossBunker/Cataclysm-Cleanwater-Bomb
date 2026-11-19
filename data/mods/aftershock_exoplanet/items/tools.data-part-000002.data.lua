local ccb = require("ccb")

ccb.content.define_item {
    id = "syringe",
    name = ccb.content.plural_text("jet injector", "jet injectors"),
    description = ccb.content.text("A compact jet injector from a first aid kit.  A light based assistive injection system allows use without any medical training."),
    mass = "4240 mg",
    volume = "10ml",
    length = "10 cm",
    accuracy = { grip = "none", length = "hand", surface = "point", balance = "neutral" },
    price = "2 USD",
    survival_price = "2 USD",
    materials = { "plastic" },
    symbol = ",",
    color = "white",
    flags = { "FRAGILE_MELEE" },
    melee_damage = { stab = 1 },
    tool = {},
}

ccb.content.define_item {
    id = "afs_internal_battery_compartment",
    name = ccb.content.plural_text("high-voltage battery compartment", "high-voltage battery compartments"),
    description = ccb.content.text("A battery slot installed in your upper torso, designed to power bionic implants.  Compatible with the power cartridges used by laser weaponry."),
    volume = "750 ml",
    mass = "1 g",
    price = "0 cent",
    materials = { "plastic" },
    symbol = "(",
    color = "magenta",
    flags = {
        "INTEGRATED", "UNBREAKABLE", "PERSONAL", "NO_REPAIR", "ALLOWS_NATURAL_ATTACKS",
        "BIONIC_FUEL_SOURCE", "SOFT", "TRADER_AVOID",
    },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            capacity = "20 L",
            mass_limit = "20 kg",
            allowed_items = { "afs_cartridge", "afs_bootleg_cartridge", "afs_archeotech_cartridge" },
        },
    },
    subtype_order = { "tool", "armor" },
    tool = { ammo_types = { "battery" } },
    armor = {},
}
