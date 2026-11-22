local ccb = require("ccb")

ccb.content.define_item {
    id = "pants_army",
    name = ccb.content.plural_text("army pants", "army pants"),
    description = "A tough pair of pants lined with pockets.  Favored by the military.",
    symbol = "[",
    color = "green",
    looks_like = "pants_cargo",
    mass = "720 g",
    volume = "2500 ml",
    price = "35 USD",
    survival_price = "2 USD 50 cent",
    snippet_category = {
        {
            id = "apants_UCP",
            text = "A tough pair of pants.  Favored by the military.  This pair sports the US Army's gray, green and tan Universal Camouflage Pattern.  The pattern is notable for its lack of black.",
        },
        {
            id = "apants_desert",
            text = "A tough pair of military pants patterned in desert camouflage.  They are lined with deep pockets.",
        },
        {
            id = "apants_MARPAT",
            text = "A tough pair of military pants with a black, green and tan pixel camouflage pattern.  Commonly seen worn by US Marines.",
        },
        {
            id = "apants_BDU",
            text = "A tough pair of military pants with the black, brown, green and tan Battle Dress camouflage pattern.  They look old.",
        },
        {
            id = "apants_OCP",
            text = "A tough and breathable pair of military pants in Operational Camouflage Pattern.",
        },
        {
            id = "mil_pants_navy",
            text = "A tough pair of military pants with a predominantly dark blue camouflage.  Favored by the US Navy.",
        },
    },
    flags = { "VARSIZE", "POCKETS", "SOFT" },
    materials = { "nylon" },
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "4 kg",
            max_item_length = "19 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "4 kg",
            max_item_length = "19 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "4 kg",
            max_item_length = "19 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "4 kg",
            max_item_length = "19 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1080 ml",
            mass_limit = "4 kg",
            max_item_length = "165 mm",
            moves = 100,
        },
        {
            kind = "CONTAINER",
            capacity = "1080 ml",
            mass_limit = "4 kg",
            max_item_length = "165 mm",
            moves = 100,
        },
    },
    armor = {
        thickness = 0.25,
        warmth = 20,
        portions = {
            {
                covers = { "leg_l", "leg_r" },
                coverage = 100,
                volume_encumbrance = 0.6,
                encumbrance = 3,
            },
        },
    },
}
