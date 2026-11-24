local ccb = require("ccb")

ccb.content.define_item {
    id = "clearcrete_chunk",
    copy_from = "rock",
    name = ccb.content.text("clearcrete chunk"),
    category = "other",
    description = ccb.content.text("A broken chunk of clearcrete.  Basically a clear rock."),
    materials = { "clearcrete" },
    ammunition = {},
}

ccb.content.define_item {
    id = "afs_doping_agent",
    category = "spare_parts",
    name = ccb.content.text("electrical doping agent"),
    description = ccb.content.text("One part of ubiquitous superconductor insulation-protection sheathing, this viscuous goop is otherwise unremarkable.  A label with defunct digital link and printed text claims conductivity losses are reduced by an order of magnitude over competitors, and that the protection resists everything from lunar vacuum to stray laser fire.  The much smaller disclaimer clarifies that the claims only apply to industrial lasers, and that the manufacturer is not responsible for accidents resulting from misapplication outside of the approved specfications sheet  That spec sheet must be on the digital link, but even without it this is a valuable ingredient for reproducing pre-Discontinuity technology."),
    mass = "90 g",
    volume = "80 ml",
    price = "75 USD",
    survival_price = "75 USD",
    stack_size = 4,
    materials = { "water" },
    default_container = "can_food",
    phase = "liquid",
    looks_like = "silver_small",
    symbol = "o",
    color = "light_gray",
    ammunition = { count = 4, type = "components" },
}

-- Density 4.506g/cm³ ~ 1.127kg/250ml @ stack 1000 = 1g/unit
ccb.content.define_item {
    id = "afs_titanium_small",
    category = "spare_parts",
    name = ccb.content.plural_text("titanium", "titanium"),
    description = ccb.content.text("A strong, durable metal.  Highly valued for its weight to strength ratio and an excellent upgrade to aluminum for those properties - albeit a lot more expensive due to rarity.  More commonly used in jewelry and medical implants."),
    mass = "1 g",
    volume = "50 ml",
    price = "100 USD",
    survival_price = "7 USD 50 cent",
    stack_size = 200,
    materials = { "titanium" },
    looks_like = "silver_small",
    symbol = "/",
    color = "light_gray",
    ammunition = { count = 100, type = "components" },
}

ccb.content.define_item {
    id = "afs_titanium_watch",
    name = ccb.content.plural_text("titanium watch", "titanium watches"),
    description = ccb.content.text("A thick, masculine watch made out of titanium.  It is durable, light-weight and water-resistant, an excellent watch to have in a hostile environment."),
    mass = "50 g",
    volume = "250 ml",
    price = "200 USD",
    survival_price = "30 USD",
    accuracy = -1,
    materials = { "titanium" },
    symbol = "[",
    color = "light_gray",
    flags = { "WATCH", "STURDY", "BELTED", "ALLOWS_NATURAL_ATTACKS", "WATER_FRIENDLY", "OVERSIZE" },
    armor = { sided = true, portions = { { coverage = 5, covers = { "hand_l", "hand_r" } } } },
}

ccb.content.define_item {
    id = "afs_titanium_ring",
    name = ccb.content.text("titanium ring"),
    description = ccb.content.text("A thick, masculine ring made out of titanium.  Made in a variety of styles and finishes, they're valued for their durability."),
    mass = "13 g",
    volume = "5 ml",
    price = "7 USD",
    survival_price = "5 USD",
    materials = { "titanium" },
    symbol = "[",
    color = "light_gray",
    flags = { "STURDY" },
    armor = {},
}

ccb.content.define_item {
    id = "afs_glass_AR_device",
    name = ccb.content.text("glass headset"),
    description = ccb.content.text("This transparent lune of computation glass was once an incredibly versatile hypercloud access point.  It continues to display \"No Connection\" in ancient English script.  Although completely useless these sometimes gain popularity as a fashion accessory."),
    mass = "170 g",
    volume = "750 ml",
    price = "7 USD",
    survival_price = "5 USD",
    materials = { "glass" },
    symbol = "[",
    color = "light_gray",
    flags = { "STURDY", "OUTER" },
    armor = { portions = { { encumbrance = 5, coverage = 100, covers = { "eyes" } } }, thickness = 1 },
}
