local ccb = require("ccb")

-- NO_I18N
ccb.content.define_item {
    id = "cow_armor",
    abstract = true,
    name = ccb.content.text_without_extraction("cow armor"),
    symbol = "[",
    length = "60 cm",
    flags = { "IS_PET_ARMOR" },
    pet_armor = { min_pet_volume = "250 L", max_pet_volume = "1000 L", body_type = "dog" },
}

ccb.content.define_item {
    id = "kevlar_armor_cow",
    copy_from = "cow_armor",
    color = "yellow",
    name = ccb.content.plural_text("Kevlar-lined cow peto", "Kevlar-lined cow petos"),
    description = ccb.content.text("A heavy, mattress-like armor of cloth, leather and thick linings of Kevlar, originally used as protection in bullfighting.  You could put this on a friendly cow."),
    price = "600 USD",
    survival_price = "60 USD",
    materials = { "cotton", "leather", "kevlar_layered" },
    mass = "35 kg",
    volume = "180 L",
    pet_armor = { thickness = 12 },
}

ccb.content.define_item {
    id = "acidchitin_armor_cow",
    copy_from = "cow_armor",
    color = "green",
    name = ccb.content.plural_text("biosilicified chitin cow armor", "biosilicified chitin cow armors"),
    description = ccb.content.text("A makeshift assembly of criniere, peytral and croupiere made from biosilicified chitin fitted to a thin mesh.  You could put this on a friendly cow.  Acid-resistant but brittle."),
    price = "1 kUSD 450 USD",
    survival_price = "100 USD",
    materials = { "acidchitin" },
    mass = "40 kg",
    volume = "180 L",
    pet_armor = { thickness = 7, environmental_protection = 7 },
}

ccb.content.define_item {
    id = "chitin_armor_cow",
    copy_from = "cow_armor",
    color = "green",
    name = ccb.content.plural_text("chitin cow armor", "chitin cow armors"),
    description = ccb.content.text("A makeshift assembly of criniere, peytral and croupiere made from chitin fitted to a thin mesh.  You could put this on a friendly cow."),
    price = "1 kUSD 100 USD",
    survival_price = "70 USD",
    materials = { "chitin" },
    mass = "40 kg",
    volume = "180 L",
    pet_armor = { thickness = 7, environmental_protection = 4 },
}

ccb.content.define_item {
    id = "chainmail_armor_cow",
    copy_from = "cow_armor",
    color = "green",
    name = ccb.content.plural_text("chainmail cow armor", "chainmail cow armors"),
    description = ccb.content.text("A heavy covering of chainmail, suitably made for cows as protection.  You could put this on a friendly cow."),
    price = "500 USD",
    survival_price = "120 USD",
    materials = { "steel", "leather" },
    mass = "50 kg",
    volume = "180 L",
    pet_armor = { thickness = 7 },
}

ccb.content.define_item {
    id = "leather_armor_cow",
    copy_from = "cow_armor",
    color = "green",
    name = ccb.content.plural_text("boiled leather cow barding with caparison", "boiled leather cow bardings with caparison"),
    description = ccb.content.text("A full barding for cows consisting of boiled leather and cloth undercovering.  This caparison depicts a battle between a monstrous dragon and regal griffin.  You could put this on a friendly cow."),
    price = "350 USD",
    survival_price = "35 USD",
    materials = { "cotton", "leather" },
    mass = "18 kg",
    volume = "180 L",
    pet_armor = { thickness = 7 },
}

ccb.content.define_item {
    id = "leatherbone_armor_cow",
    copy_from = "cow_armor",
    color = "green",
    name = ccb.content.plural_text("boiled leather cow barding with bones", "boiled leather cow bardings with bones"),
    description = ccb.content.text("Decorative bones affixed to leather cow barding to invoke fear in bandits and raiders and traders all!  You could put this on a friendly cow."),
    price = "550 USD",
    survival_price = "35 USD",
    materials = { "leather" },
    mass = "20 kg",
    volume = "180 L",
    pet_armor = { thickness = 7 },
}

ccb.content.define_item {
    id = "rubber_armor_cow",
    copy_from = "cow_armor",
    color = "green",
    name = ccb.content.plural_text("cow rain sheet", "cow rain sheets"),
    description = ccb.content.text("A thin plastic covering designed to keep a cow dry in the rain.  You could put this on a friendly cow."),
    price = "180 USD",
    survival_price = "18 USD",
    materials = { "neoprene", "plastic" },
    mass = "17 kg",
    volume = "180 L",
    pet_armor = { thickness = 4 },
}

ccb.content.define_item {
    id = "iron_armor_cow",
    copy_from = "cow_armor",
    color = "brown",
    name = ccb.content.plural_text("iron cow armor", "iron cow armors"),
    description = ccb.content.text("A heavy covering of strategically-placed iron plates and leather, suitably made for cows as protection.  You could put this on a friendly cow."),
    price = "600 USD",
    survival_price = "120 USD",
    materials = { "iron", "leather" },
    mass = "35 kg",
    volume = "180 L",
    pet_armor = { thickness = 5 },
}

ccb.content.define_item {
    id = "steel_armor_cow",
    copy_from = "cow_armor",
    color = "light_gray",
    name = ccb.content.plural_text("steel cow armor", "steel cow armors"),
    description = ccb.content.text("A heavy covering of steel plate and leather, suitably made for cows as protection.  You could put this on a friendly cow."),
    price = "700 USD",
    survival_price = "180 USD",
    materials = { "steel", "leather" },
    mass = "60 kg",
    volume = "180 L",
    pet_armor = { thickness = 5 },
}

ccb.content.define_item {
    id = "bronze_armor_cow",
    copy_from = "cow_armor",
    color = "yellow",
    name = ccb.content.plural_text("bronze cow armor", "bronze cow armors"),
    description = ccb.content.text("A heavy covering of strategically-placed bronze plates and leather, suitably made for cows as protection.  You could put this on a friendly cow."),
    price = "600 USD",
    survival_price = "120 USD",
    materials = { "bronze", "leather" },
    mass = "35 kg",
    volume = "180 L",
    pet_armor = { thickness = 5 },
}
