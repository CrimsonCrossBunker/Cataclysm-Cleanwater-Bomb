local ccb = require("ccb")

ccb.content.define_item {
    id = "bear_armor",
    abstract = true,
    name = ccb.content.plural_text("bear armor", "bear armors"),
    symbol = "[",
    length = "60 cm",
    flags = { "IS_PET_ARMOR" },
    pet_armor = { min_pet_volume = "50 L", max_pet_volume = "1000 L", body_type = "bear" },
}

ccb.content.define_item {
    id = "kevlar_armor_bear",
    copy_from = "bear_armor",
    color = "yellow",
    name = ccb.content.plural_text("Kevlar-lined bear-sized peto", "Kevlar-lined bear-sized petos"),
    description = ccb.content.text("A heavy mattress-like armor of cloth, leather, and thick linings of Kevlar, originally used as horse protection for bullfighting, but adapted for the noblest of beasts.  You could put this on a friendly bear."),
    price = "500 USD",
    survival_price = "50 USD",
    materials = { "cotton", "leather", "kevlar" },
    mass = "30 kg",
    volume = "150 L",
    pet_armor = { thickness = 10 },
}

ccb.content.define_item {
    id = "acidchitin_armor_bear",
    copy_from = "bear_armor",
    color = "green",
    name = ccb.content.plural_text("biosilicified chitin bear armor", "biosilicified chitin bear armors"),
    description = ccb.content.text("A makeshift assembly of criniere, peytral, and croupiere made from biosilicified chitin fitted to a thin mesh.  You could put this on a friendly bear."),
    price = "1 kUSD 200 USD",
    survival_price = "80 USD",
    materials = { "acidchitin", "leather" },
    mass = "35 kg",
    volume = "150 L",
    pet_armor = { thickness = 6, environmental_protection = 7 },
}

ccb.content.define_item {
    id = "chitin_armor_bear",
    copy_from = "bear_armor",
    color = "green",
    name = ccb.content.plural_text("chitin bear armor", "chitin bear armors"),
    description = ccb.content.text("A makeshift assembly of criniere, peytral, and croupiere made from chitin fitted to a thin mesh.  You could put this on a friendly bear."),
    price = "1 kUSD",
    survival_price = "60 USD",
    materials = { "chitin", "leather" },
    mass = "35 kg",
    volume = "150 L",
    pet_armor = { thickness = 6, environmental_protection = 4 },
}

ccb.content.define_item {
    id = "chainmail_armor_bear",
    copy_from = "bear_armor",
    color = "green",
    name = ccb.content.plural_text("chainmail bear armor", "chainmail bear armors"),
    description = ccb.content.text("A heavy covering of chainmail, suitably made for bears as protection.  You could put this on a friendly bear."),
    price = "400 USD",
    survival_price = "100 USD",
    materials = { "steel", "leather" },
    mass = "40 kg",
    volume = "150 L",
    pet_armor = { thickness = 6 },
}
