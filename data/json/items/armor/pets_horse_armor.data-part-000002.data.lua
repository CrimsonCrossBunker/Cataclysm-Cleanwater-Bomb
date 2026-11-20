local ccb = require("ccb")

ccb.content.define_item {
    id = "leatherbone_armor_horse",
    copy_from = "horse_armor",
    color = "green",
    name = ccb.content.plural_text("boiled leather horse barding with bones", "boiled leather horse bardings with bones"),
    description = ccb.content.text("Decorative bones affixed to leather horse barding to invoke fear in bandits and raiders and traders all!  You could put this on a friendly horse."),
    price = "450 USD",
    survival_price = "30 USD",
    materials = { "leather" },
    mass = "17 kg",
    volume = "150 L",
    pet_armor = { thickness = 6 },
}

ccb.content.define_item {
    id = "rubber_armor_horse",
    copy_from = "horse_armor",
    color = "green",
    name = ccb.content.plural_text("horse rain sheet", "horse rain sheets"),
    description = ccb.content.text("A thin plastic covering designed to keep a horse dry in the rain.  You could put this on a friendly horse."),
    price = "150 USD",
    survival_price = "15 USD",
    materials = { "neoprene", "plastic" },
    mass = "14 kg",
    volume = "150 L",
    pet_armor = { thickness = 3 },
}

ccb.content.define_item {
    id = "iron_armor_horse",
    copy_from = "horse_armor",
    color = "brown",
    name = ccb.content.plural_text("iron horse armor", "iron horse armors"),
    description = ccb.content.text("A heavy covering of strategically-placed iron plates and leather, suitably made for horses as protection.  You could put this on a friendly horse."),
    price = "500 USD",
    survival_price = "100 USD",
    materials = { "iron", "leather" },
    mass = "30 kg",
    volume = "150 L",
    pet_armor = { thickness = 4 },
}

ccb.content.define_item {
    id = "steel_armor_horse",
    copy_from = "horse_armor",
    color = "light_gray",
    name = ccb.content.plural_text("steel horse armor", "steel horse armors"),
    description = ccb.content.text("A heavy covering of steel plate and leather, suitably made for horses as protection.  You could put this on a friendly horse."),
    price = "600 USD",
    survival_price = "150 USD",
    materials = { "steel", "leather" },
    mass = "50 kg",
    volume = "150 L",
    pet_armor = { thickness = 4 },
}

ccb.content.define_item {
    id = "bronze_armor_horse",
    copy_from = "horse_armor",
    color = "yellow",
    name = ccb.content.plural_text("bronze horse armor", "bronze horse armors"),
    description = ccb.content.text("A heavy covering of strategically-placed bronze plates and leather, suitably made for horses as protection.  You could put this on a friendly horse."),
    price = "500 USD",
    survival_price = "100 USD",
    materials = { "bronze", "leather" },
    mass = "30 kg",
    volume = "150 L",
    pet_armor = { thickness = 4 },
}
