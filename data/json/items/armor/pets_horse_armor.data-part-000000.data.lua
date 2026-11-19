local ccb = require("ccb")

ccb.content.define_item {
    id = "kevlar_armor_horse",
    copy_from = "horse_armor",
    color = "yellow",
    name = ccb.content.plural_text("Kevlar-lined horse peto", "Kevlar-lined horse petos"),
    description = ccb.content.text("A heavy, mattress-like armor of cloth, leather and thick linings of Kevlar, originally used as protection in bullfighting.  You could put this on a friendly horse."),
    price = "500 USD",
    survival_price = "50 USD",
    materials = { "cotton", "leather", "kevlar_layered" },
    mass = "30 kg",
    volume = "150 L",
    pet_armor = { thickness = 10 },
}

ccb.content.define_item {
    id = "acidchitin_armor_horse",
    copy_from = "horse_armor",
    color = "green",
    name = ccb.content.plural_text("biosilicified chitin horse armor", "biosilicified chitin horse armors"),
    description = ccb.content.text("A makeshift assembly of criniere, peytral and croupiere made from biosilicified chitin fitted to a thin mesh.  You could put this on a friendly horse.  Acid-resistant but brittle."),
    price = "1 kUSD 200 USD",
    survival_price = "80 USD",
    materials = { "acidchitin" },
    mass = "35 kg",
    volume = "150 L",
    pet_armor = { thickness = 6, environmental_protection = 7 },
}

ccb.content.define_item {
    id = "chitin_armor_horse",
    copy_from = "horse_armor",
    color = "green",
    name = ccb.content.plural_text("chitin horse armor", "chitin horse armors"),
    description = ccb.content.text("A makeshift assembly of criniere, peytral and croupiere made from chitin fitted to a thin mesh.  You could put this on a friendly horse."),
    price = "1 kUSD",
    survival_price = "60 USD",
    materials = { "chitin" },
    mass = "35 kg",
    volume = "150 L",
    pet_armor = { thickness = 6, environmental_protection = 4 },
}

ccb.content.define_item {
    id = "chainmail_armor_horse",
    copy_from = "horse_armor",
    color = "green",
    name = ccb.content.plural_text("chainmail horse armor", "chainmail horse armors"),
    description = ccb.content.text("A heavy covering of chainmail, suitably made for horses as protection.  You could put this on a friendly horse."),
    price = "400 USD",
    survival_price = "100 USD",
    materials = { "steel", "leather" },
    mass = "40 kg",
    volume = "150 L",
    pet_armor = { thickness = 6 },
}
