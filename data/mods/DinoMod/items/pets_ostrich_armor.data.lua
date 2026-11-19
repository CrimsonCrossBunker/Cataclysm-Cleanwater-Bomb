local ccb = require("ccb")

ccb.content.define_item {
    id = "leatherbone_armor_ostrich",
    copy_from = "ostrich_armor",
    color = "green",
    name = ccb.content.plural_text("boiled leather ostrich barding with bones", "boiled leather ostrich bardings with bones"),
    description = ccb.content.text("Leather ostrich barding with decorative bones affixed, meant to invoke fear in bandits and raiders and traders all!  You could put this on a friendly ostrich."),
    price = "450 USD",
    survival_price = "30 USD",
    materials = { "bone", "leather" },
    mass = "17 kg",
    volume = "150 L",
    pet_armor = { thickness = 6 },
}

ccb.content.define_item {
    id = "rubber_armor_ostrich",
    copy_from = "ostrich_armor",
    color = "green",
    name = ccb.content.plural_text("ostrich rain sheet", "ostrich rain sheets"),
    description = ccb.content.text("A thin plastic covering, adapted to protect an ostrich from acid zombie splashes and similar caustic substances.  You could put this on a friendly ostrich."),
    price = "150 USD",
    survival_price = "15 USD",
    materials = { "neoprene", "plastic" },
    mass = "14 kg",
    volume = "150 L",
    pet_armor = { thickness = 3 },
}

ccb.content.define_item {
    id = "sweater_armor_ostrich",
    copy_from = "ostrich_armor",
    color = "red",
    name = ccb.content.plural_text("ostrich-sized holiday sweater", "ostrich-sized holiday sweaters"),
    description = ccb.content.text("A very large warm wool sweater with a festive holiday pattern.  You could put this on a friendly ostrich."),
    price = "100 USD",
    survival_price = "10 USD",
    materials = { "wool" },
    mass = "3 kg",
    volume = "20 L",
    looks_like = "longshirt",
    pet_armor = { thickness = 1 },
}

ccb.content.define_item {
    id = "iron_armor_ostrich",
    copy_from = "ostrich_armor",
    color = "brown",
    name = ccb.content.plural_text("iron ostrich armor", "iron ostrich armors"),
    description = ccb.content.text("A heavy covering of strategically placed iron plates and leather, suitably made for ostriches as protection.  You could put this on a friendly ostrich."),
    price = "500 USD",
    survival_price = "100 USD",
    materials = { "iron", "leather" },
    mass = "30 kg",
    volume = "150 L",
    pet_armor = { thickness = 4 },
}

ccb.content.define_item {
    id = "steel_armor_ostrich",
    copy_from = "ostrich_armor",
    color = "light_gray",
    name = ccb.content.plural_text("steel ostrich armor", "steel ostrich armors"),
    description = ccb.content.text("A heavy covering of steel plate and leather, suitably made for ostriches as protection.  You could put this on a friendly ostrich."),
    price = "600 USD",
    survival_price = "150 USD",
    materials = { "steel", "leather" },
    mass = "50 kg",
    volume = "150 L",
    pet_armor = { thickness = 4 },
}

ccb.content.define_item {
    id = "bronze_armor_ostrich",
    copy_from = "ostrich_armor",
    color = "yellow",
    name = ccb.content.plural_text("bronze ostrich armor", "bronze ostrich armors"),
    description = ccb.content.text("A heavy covering of strategically placed bronze plates and leather, suitably made for ostriches as protection.  You could put this on a friendly ostrich."),
    price = "500 USD",
    survival_price = "100 USD",
    materials = { "bronze", "leather" },
    mass = "30 kg",
    volume = "150 L",
    pet_armor = { thickness = 4 },
}
