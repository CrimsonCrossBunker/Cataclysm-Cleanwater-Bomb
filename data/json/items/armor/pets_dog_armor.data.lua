local ccb = require("ccb")

ccb.content.define_item {
    id = "kevlar_harness",
    symbol = "[",
    looks_like = "tacvest",
    color = "blue",
    name = ccb.content.plural_text("Kevlar dog harness", "Kevlar dog harnesses"),
    description = ccb.content.text("A blue bulletproof harness, designed to be worn by canines in the service of local law enforcement, that protects from the shoulders to the abdomen.  You could put this on a friendly dog."),
    price = "300 USD",
    survival_price = "10 USD",
    materials = { "kevlar_layered" },
    mass = "2150 g",
    volume = "4500 ml",
    flags = { "IS_PET_ARMOR" },
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "5 L",
            mass_limit = "10 kg",
            max_item_length = "60 cm",
            moves = 200,
        },
        {
            kind = "CONTAINER",
            capacity = "5 L",
            mass_limit = "10 kg",
            max_item_length = "60 cm",
            moves = 200,
        },
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "2 kg",
            max_item_length = "20 cm",
            moves = 200,
        },
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "2 kg",
            max_item_length = "20 cm",
            moves = 200,
        },
    },
    pet_armor = { thickness = 2.0, max_pet_volume = "60 L", min_pet_volume = "25000 ml", body_type = "dog" },
}

ccb.content.define_item {
    id = "acidchitin_harness_dog",
    copy_from = "kevlar_harness",
    color = "green",
    name = ccb.content.plural_text("biosilicified chitin dog mesh harness", "biosilicified chitin dog mesh harnesses"),
    description = ccb.content.text("A makeshift canine harness of biosilicified chitin fitted to a thin mesh, protecting from the neck to the flank.  You could put this on a friendly dog.  Acid-resistant but brittle."),
    price = "500 USD",
    survival_price = "25 USD",
    materials = { "acidchitin" },
    mass = "5362 g",
    pet_armor = { environmental_protection = 7 },
}

ccb.content.define_item {
    id = "chitin_harness_dog",
    copy_from = "acidchitin_harness_dog",
    name = ccb.content.plural_text("chitin dog mesh harness", "chitin dog mesh harnesses"),
    description = ccb.content.text("A makeshift canine harness of chitin fitted to a thin mesh, protecting from the neck to the flank.  You could put this on a friendly dog."),
    price = "350 USD",
    survival_price = "20 USD",
    materials = { "chitin" },
    pet_armor = { environmental_protection = 4 },
}

-- Description is reference to Churl scenario text - 'protect your dog from foul undead'.
ccb.content.define_item {
    id = "chainmail_harness_dog",
    copy_from = "kevlar_harness",
    color = "light_red",
    name = ccb.content.plural_text("chainmail dog coat", "chainmail dog coats"),
    description = ccb.content.text("Protecteth yon hund fram ful daemons!  You could put this on a friendly dog."),
    price = "250 USD",
    survival_price = "35 USD",
    materials = { "iron", "budget_steel" },
    mass = "6434 g",
    pet_armor = { thickness = 0.5 },
}

ccb.content.define_item {
    id = "leather_harness_dog",
    copy_from = "kevlar_harness",
    color = "brown",
    name = ccb.content.plural_text("leather dog harness", "leather dog harnesses"),
    description = ccb.content.text("A neck to hip harness made from leather that can be attached to a canine for protection.  You could put this on a friendly dog."),
    price = "175 USD",
    survival_price = "17 USD 50 cent",
    materials = { "leather" },
    mass = "2145 g",
    inheritance = { add = { flags = { "NO_SALVAGE" } } },
    pet_armor = {},
}

ccb.content.define_item {
    id = "leatherbone_harness_dog",
    copy_from = "leather_harness_dog",
    name = ccb.content.plural_text("leather dog harness with bones", "leather dog harnesses with bones"),
    description = ccb.content.text("Decorative bones affixed to a leather dog harness for that true post-apocalyptic style, including a skull bone headpiece!  You could put this on a friendly dog."),
    price = "190 USD",
    survival_price = "19 USD",
    materials = { "leather" },
    mass = "2645 g",
    pet_armor = {},
}

ccb.content.define_item {
    id = "rubber_harness_dog",
    copy_from = "kevlar_harness",
    color = "dark_gray",
    name = ccb.content.plural_text("rubber dog rainsuit", "rubber dog rainsuits"),
    description = ccb.content.text("A thin plastic covering designed to keep a dog dry in the rain.  You could put this on a friendly dog."),
    price = "100 USD",
    survival_price = "10 USD",
    materials = { "neoprene", "plastic", "rubber" },
    mass = "1960 g",
    inheritance = { add = { flags = { "NO_SALVAGE" } } },
    pet_armor = { thickness = 0.1, environmental_protection = 10, min_pet_volume = "15000 ml" },
}
