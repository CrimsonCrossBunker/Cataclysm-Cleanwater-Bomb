local ccb = require("ccb")

-- NO_I18N
ccb.content.define_item {
    id = "horse_armor",
    abstract = true,
    name = ccb.content.text_without_extraction("horse armor"),
    symbol = "[",
    length = "60 cm",
    flags = { "IS_PET_ARMOR" },
    subtype_order = { "pet_armor", "pet_equipment" },
    pet_armor = { min_pet_volume = "380 L", max_pet_volume = "1000 L", body_type = "horse" },
    pet_equipment = { slots = { "armor" }, passive_effects = { "monster_armor" } },
}

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

ccb.content.define_item {
    id = "leather_armor_horse",
    copy_from = "horse_armor",
    name = ccb.content.plural_text("boiled leather horse barding with caparison", "boiled leather horse bardings with caparison"),
    description = "A full barding for horses consisting of boiled leather and cloth undercovering.  This caparison depicts a battle between a monstrous dragon and regal griffin.  You could put this on a friendly horse.",
    color = "green",
    mass = "15 kg",
    volume = "150 L",
    price = "300 USD",
    survival_price = "30 USD",
    snippet_category = {
        {
            id = "battle",
            text = "A full barding for horses consisting of boiled leather and cloth undercovering.  This caparison depicts a battle between a monstrous dragon and regal griffin.  You could put this on a friendly horse.",
        },
        {
            id = "ancientdragon",
            text = "A full barding for horses consisting of boiled leather and cloth undercovering.  This caparison depicts a red dragon breathing fire on cities.  You could put this on a friendly horse.",
        },
        {
            id = "criticalbear",
            text = "A full barding for horses consisting of boiled leather and cloth undercovering.  This caparison depicts a bear standing on its hind legs, forelegs outstretched in a menacing manner.  You could put this on a friendly horse.",
        },
        {
            id = "orange",
            text = "A full barding for horses consisting of boiled leather and cloth undercovering.  This caparison depicts an assortment of fruits and vegetables with a very large orange featured in the foreground.  You could put this on a friendly horse.",
        },
        {
            id = "vulture",
            text = "A full barding for horses consisting of boiled leather and cloth undercovering.  This caparison depicts a massive vulture perched on a mountain.  You could put this on a friendly horse.",
        },
        {
            id = "direboar",
            text = "A full barding for horses consisting of boiled leather and cloth undercovering.  This caparison depicts the mythical Erymanthian boar in various artistic forms.  You could put this on a friendly horse.",
        },
        {
            id = "rycon",
            text = "A full barding for horses consisting of boiled leather and cloth undercovering.  This caparison seems to be sponsored by Rycon Construction, with a tag line of \"From down under to your home, we play all the roles from start to finish!\".  You could put this on a friendly horse.",
        },
        {
            id = "coregentech",
            text = "A full barding for horses consisting of boiled leather and cloth undercovering.  This caparison seems to be sponsored by Core Generator Tech, with a tag line of \"Providing power solutions from culinary to graphic design, we have the magic touch for your problems!\".  You could put this on a friendly horse.",
        },
    },
    materials = { "cotton", "leather" },
    pet_armor = { thickness = 6 },
}

-- each 15 L bag is ~ 60 x 25 x 10 cm
ccb.content.define_item {
    id = "saddlebag",
    name = ccb.content.plural_text("saddle bags (pair)", "saddle bags (pair)"),
    description = ccb.content.text("A pair of covered pouches laid across the back of a horse behind the saddle."),
    mass = "1 kg",
    volume = "7500 ml",
    price = "150 USD",
    survival_price = "25 USD",
    materials = { "leather" },
    symbol = "[",
    looks_like = "dump_pouch",
    color = "green",
    flags = { "BELTED", "WATER_FRIENDLY", "SADDLE_BAG" },
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "15 L",
            mass_limit = "20 kg",
            max_item_length = "60 cm",
            moves = 200,
        },
        {
            kind = "CONTAINER",
            capacity = "15 L",
            mass_limit = "20 kg",
            max_item_length = "60 cm",
            moves = 200,
        },
    },
    subtype_order = { "armor", "pet_equipment" },
    armor = {
        warmth = 10,
        thickness = 2,
        portions = { { encumbrance = 30, coverage = 50, covers = { "hand_l", "hand_r" } } },
    },
    pet_equipment = { slots = { "saddlebag" }, passive_effects = { "has_bag" } },
}
