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

ccb.content.define_item {
    id = "leather_armor_elephant",
    copy_from = "elephant_armor",
    name = ccb.content.plural_text("boiled leather elephant barding with caparison", "boiled leather elephant bardings with caparison"),
    description = "A full barding for elephants, consisting of boiled leather with cloth underneath.  This caparison depicts a battle between a monstrous demon and a regal warrior astride an elephant and wielding an elaborate vajra.  You could put this on a friendly elephant.",
    color = "green",
    mass = "15 kg",
    volume = "150 L",
    price = "300 USD",
    survival_price = "30 USD",
    snippet_category = {
        {
            id = "vritra",
            text = "A full barding for elephants, consisting of boiled leather with cloth underneath.  This caparison depicts a battle between a monstrous demon and a regal warrior astride an elephant and wielding an elaborate vajra.  You could put this on a friendly elephant.",
        },
        {
            id = "khajurahoshiva",
            text = "A full barding for elephants, consisting of boiled leather with cloth underneath.  This caparison depicts a being, a goddess?  with many arms bearing different items with one large uncovered breast on the left side.  You could put this on a friendly elephant.",
        },
        {
            id = "elephantry",
            text = "A full barding for elephants, consisting of boiled leather with cloth underneath.  This caparison depicts several charging elephants trampling enemy soldiers.  You could put this on a friendly elephant.",
        },
        {
            id = "diamond",
            text = "A full barding for elephants, consisting of boiled leather with cloth underneath.  This caparison depicts an assortment of diamonds and gems.  You could put this on a friendly elephant.",
        },
        {
            id = "ashoka",
            text = "A full barding for elephants, consisting of boiled leather with cloth underneath.  This caparison depicts a man in rich garments and a full uncovered belly, riding in an elaborate chariot.  You could put this on a friendly elephant.",
        },
        {
            id = "singh",
            text = "A full barding for elephants, consisting of boiled leather with cloth underneath.  This caparison depicts several identical smiling men in turbans of various bright colors performing a dance.  You could put this on a friendly elephant.",
        },
        {
            id = "triceratops",
            text = "A full barding for elephants, consisting of boiled leather with cloth underneath.  This caparison depicts a fierce, three-horned dinosaur bursting out the side of a 1970s-era van.  You could put this on a friendly elephant.",
        },
    },
    materials = { "cotton", "leather" },
    pet_armor = { thickness = 6 },
}
