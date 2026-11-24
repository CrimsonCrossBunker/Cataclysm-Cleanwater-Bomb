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

ccb.content.define_item {
    id = "leatherbone_armor_bear",
    copy_from = "bear_armor",
    color = "green",
    name = ccb.content.plural_text("boiled leather bear barding with bones", "boiled leather bear bardings with bones"),
    description = ccb.content.text("Leather bear barding with decorative bones affixed, meant to invoke fear in bandits and raiders and traders all!  You could put this on a friendly bear."),
    price = "450 USD",
    survival_price = "30 USD",
    materials = { "bone", "leather" },
    mass = "17 kg",
    volume = "150 L",
    pet_armor = { thickness = 6 },
}

ccb.content.define_item {
    id = "rubber_armor_bear",
    copy_from = "bear_armor",
    color = "green",
    name = ccb.content.plural_text("bear rain sheet", "bear rain sheets"),
    description = ccb.content.text("A thin plastic covering, adapted to protect a bear from acid zombie splashes and similar caustic substances.  You could put this on a friendly bear."),
    price = "150 USD",
    survival_price = "15 USD",
    materials = { "neoprene", "plastic" },
    mass = "14 kg",
    volume = "150 L",
    pet_armor = { thickness = 3 },
}

ccb.content.define_item {
    id = "sweater_armor_bear",
    copy_from = "bear_armor",
    color = "red",
    name = ccb.content.plural_text("bear-sized holiday sweater", "bear-sized holiday sweaters"),
    description = ccb.content.text("A very large warm wool sweater with a festive holiday pattern.  You could put this on a friendly bear."),
    price = "100 USD",
    survival_price = "10 USD",
    materials = { "wool" },
    mass = "3 kg",
    volume = "20 L",
    looks_like = "longshirt",
    pet_armor = { thickness = 1 },
}

ccb.content.define_item {
    id = "iron_armor_bear",
    copy_from = "bear_armor",
    color = "brown",
    name = ccb.content.plural_text("iron bear armor", "iron bear armors"),
    description = ccb.content.text("A heavy covering of strategically placed iron plates and leather, suitably made for bears as protection.  You could put this on a friendly bear."),
    price = "500 USD",
    survival_price = "100 USD",
    materials = { "iron", "leather" },
    mass = "30 kg",
    volume = "150 L",
    pet_armor = { thickness = 4 },
}

ccb.content.define_item {
    id = "steel_armor_bear",
    copy_from = "bear_armor",
    color = "light_gray",
    name = ccb.content.plural_text("steel bear armor", "steel bear armors"),
    description = ccb.content.text("A heavy covering of steel plate and leather, suitably made for bears as protection.  You could put this on a friendly bear."),
    price = "600 USD",
    survival_price = "150 USD",
    materials = { "steel", "leather" },
    mass = "50 kg",
    volume = "150 L",
    pet_armor = { thickness = 4 },
}

ccb.content.define_item {
    id = "bronze_armor_bear",
    copy_from = "bear_armor",
    color = "yellow",
    name = ccb.content.plural_text("bronze bear armor", "bronze bear armors"),
    description = ccb.content.text("A heavy covering of strategically placed bronze plates and leather, suitably made for bears as protection.  You could put this on a friendly bear."),
    price = "500 USD",
    survival_price = "100 USD",
    materials = { "bronze", "leather" },
    mass = "30 kg",
    volume = "150 L",
    pet_armor = { thickness = 4 },
}

ccb.content.define_item {
    id = "leather_armor_bear",
    copy_from = "bear_armor",
    name = ccb.content.plural_text("boiled leather bear barding with caparison", "boiled leather bear bardings with caparison"),
    description = "A full barding for bears, consisting of boiled leather with cloth underneath.  This caparison depicts four men in heavy metal armor riddled with bullet marks.  You could put this on a friendly bear.",
    color = "green",
    mass = "15 kg",
    volume = "150 L",
    price = "300 USD",
    survival_price = "30 USD",
    snippet_category = {
        {
            id = "honeyeater",
            text = "A full barding for bears, consisting of boiled leather with cloth underneath.  This caparison depicts a large brown bear being swarmed by bees as it devours a honeycomb.  You could put this on a friendly bear.",
        },
        {
            id = "mormont",
            text = "A full barding for bears, consisting of boiled leather with cloth underneath.  This caparison depicts a warrior-woman holding a baby in one arm and a battleaxe in the other.  You could put this on a friendly bear.",
        },
        {
            id = "maidenfair",
            text = "A full barding for bears, consisting of boiled leather with cloth underneath.  This caparison depicts a bear dancing with a golden-haired maiden.  You could put this on a friendly bear.",
        },
        {
            id = "wight",
            text = "A full barding for bears, consisting of boiled leather with cloth underneath.  This caparison depicts a zombified bear with cold blue eyes fighting alongside an undead army.  You could put this on a friendly bear.",
        },
        {
            id = "beorn",
            text = "A full barding for bears, consisting of boiled leather with cloth underneath.  This caparison depicts a tall man transforming into a giant bear and leaping into battle.  You could put this on a friendly bear.",
        },
        {
            id = "stegosaurus",
            text = "A full barding for bears, consisting of boiled leather with cloth underneath.  This caparison depicts a fierce stegosaurus bursting out the side of a 1970s-era van.  You could put this on a friendly bear.",
        },
    },
    materials = { "cotton", "leather" },
    pet_armor = { thickness = 6 },
}
