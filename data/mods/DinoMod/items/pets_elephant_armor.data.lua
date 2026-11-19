local ccb = require("ccb")

ccb.content.define_item {
    id = "leatherbone_armor_elephant",
    copy_from = "elephant_armor",
    color = "green",
    name = ccb.content.plural_text("boiled leather elephant barding with bones", "boiled leather elephant bardings with bones"),
    description = ccb.content.text("Leather elephant barding with decorative bones affixed, meant to invoke fear in bandits and raiders and traders all!  You could put this on a friendly elephant."),
    price = "450 USD",
    survival_price = "30 USD",
    materials = { "bone", "leather" },
    mass = "17 kg",
    volume = "150 L",
    pet_armor = { thickness = 6 },
}

ccb.content.define_item {
    id = "rubber_armor_elephant",
    copy_from = "elephant_armor",
    color = "green",
    name = ccb.content.plural_text("elephant rain sheet", "elephant rain sheets"),
    description = ccb.content.text("A thin plastic covering, adapted to protect an elephant from acid zombie splashes and similar caustic substances.  You could put this on a friendly elephant."),
    price = "150 USD",
    survival_price = "15 USD",
    materials = { "neoprene", "plastic" },
    mass = "14 kg",
    volume = "150 L",
    pet_armor = { thickness = 3 },
}

ccb.content.define_item {
    id = "sweater_armor_elephant",
    copy_from = "elephant_armor",
    color = "red",
    name = ccb.content.plural_text("elephant-sized holiday sweater", "elephant-sized holiday sweaters"),
    description = ccb.content.text("A very large warm wool sweater with a festive holiday pattern.  You could put this on a friendly elephant."),
    price = "100 USD",
    survival_price = "10 USD",
    materials = { "wool" },
    mass = "3 kg",
    volume = "20 L",
    looks_like = "longshirt",
    pet_armor = { thickness = 1 },
}

ccb.content.define_item {
    id = "iron_armor_elephant",
    copy_from = "elephant_armor",
    color = "brown",
    name = ccb.content.plural_text("iron elephant armor", "iron elephant armors"),
    description = ccb.content.text("A heavy covering of strategically placed iron plates and leather, suitably made for elephants as protection.  You could put this on a friendly elephant."),
    price = "500 USD",
    survival_price = "100 USD",
    materials = { "iron", "leather" },
    mass = "30 kg",
    volume = "150 L",
    pet_armor = { thickness = 4 },
}

ccb.content.define_item {
    id = "steel_armor_elephant",
    copy_from = "elephant_armor",
    color = "light_gray",
    name = ccb.content.plural_text("steel elephant armor", "steel elephant armors"),
    description = ccb.content.text("A heavy covering of steel plate and leather, suitably made for elephants as protection.  You could put this on a friendly elephant."),
    price = "600 USD",
    survival_price = "150 USD",
    materials = { "steel", "leather" },
    mass = "50 kg",
    volume = "150 L",
    pet_armor = { thickness = 4 },
}

ccb.content.define_item {
    id = "bronze_armor_elephant",
    copy_from = "elephant_armor",
    color = "yellow",
    name = ccb.content.plural_text("bronze elephant armor", "bronze elephant armors"),
    description = ccb.content.text("A heavy covering of strategically placed bronze plates and leather, suitably made for elephants as protection.  You could put this on a friendly elephant."),
    price = "500 USD",
    survival_price = "100 USD",
    materials = { "bronze", "leather" },
    mass = "30 kg",
    volume = "150 L",
    pet_armor = { thickness = 4 },
}
