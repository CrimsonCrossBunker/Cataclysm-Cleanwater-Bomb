local ccb = require("ccb")

ccb.content.define_item {
    id = "elephant_armor",
    abstract = true,
    name = ccb.content.plural_text("elephant armor", "elephant armors"),
    symbol = "[",
    length = "60 cm",
    flags = { "IS_PET_ARMOR" },
    pet_armor = { min_pet_volume = "380 L", max_pet_volume = "1000 L", body_type = "elephant" },
}

ccb.content.define_item {
    id = "kevlar_armor_elephant",
    copy_from = "elephant_armor",
    color = "yellow",
    name = ccb.content.plural_text("Kevlar-lined elephant-sized peto", "Kevlar-lined elephant-sized petos"),
    description = ccb.content.text("A heavy mattress-like armor of cloth, leather, and thick linings of Kevlar, originally used as horse protection for bullfighting.  You could put this on a friendly elephant."),
    price = "500 USD",
    survival_price = "50 USD",
    materials = { "cotton", "leather", "kevlar" },
    mass = "30 kg",
    volume = "150 L",
    pet_armor = { thickness = 10 },
}

ccb.content.define_item {
    id = "acidchitin_armor_elephant",
    copy_from = "elephant_armor",
    color = "green",
    name = ccb.content.plural_text("biosilicified chitin elephant armor", "biosilicified chitin elephant armors"),
    description = ccb.content.text("A makeshift assembly of criniere, peytral, and croupiere made from biosilicified chitin fitted to a thin mesh.  You could put this on a friendly elephant."),
    price = "1 kUSD 200 USD",
    survival_price = "80 USD",
    materials = { "acidchitin", "leather" },
    mass = "35 kg",
    volume = "150 L",
    pet_armor = { thickness = 6, environmental_protection = 7 },
}

ccb.content.define_item {
    id = "chitin_armor_elephant",
    copy_from = "elephant_armor",
    color = "green",
    name = ccb.content.plural_text("chitin elephant armor", "chitin elephant armors"),
    description = ccb.content.text("A makeshift assembly of criniere, peytral, and croupiere made from chitin fitted to a thin mesh.  You could put this on a friendly elephant."),
    price = "1 kUSD",
    survival_price = "60 USD",
    materials = { "chitin", "leather" },
    mass = "35 kg",
    volume = "150 L",
    pet_armor = { thickness = 6, environmental_protection = 4 },
}

ccb.content.define_item {
    id = "chainmail_armor_elephant",
    copy_from = "elephant_armor",
    color = "green",
    name = ccb.content.plural_text("chainmail elephant armor", "chainmail elephant armors"),
    description = ccb.content.text("A heavy covering of chainmail, suitably made for elephants as protection.  You could put this on a friendly elephant."),
    price = "400 USD",
    survival_price = "100 USD",
    materials = { "steel", "leather" },
    mass = "40 kg",
    volume = "150 L",
    pet_armor = { thickness = 6 },
}
