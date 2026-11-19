local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
-- Based on my own cash card that I measured with a ruler. Yes I'm professional like that. 8.4cm x 5.3cm x 0.1cm. Really it's slightly less than 5ml but we don't do volume lower than 1ml.
ccb.content.define_item {
    id = "card_plastic_abstract",
    abstract = true,
    symbol = ",",
    color = "cyan",
    name = ccb.content.text_without_extraction("abstract plastic card"),
    description = ccb.content.text_without_extraction("A generic plastic card item template with numbers based off a credit card."),
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "plastic" },
    mass = "5 g",
    volume = "5 ml",
    length = "84 mm",
    flags = { "CREDIT_CARD_SHAPED" },
    accuracy = { grip = "bad", length = "hand", surface = "any", balance = "neutral" },
    tool = {},
}

ccb.content.define_item {
    id = "cash_card",
    category = "currency",
    copy_from = "card_plastic_abstract",
    symbol = "$",
    color = "yellow",
    name = ccb.content.plural_text("cash card", "cash cards"),
    ascii_picture = "cashcard",
    description = ccb.content.text("A yellow plastic card used to electronically store money.  It holds up to 2 million dollars."),
    price = "10 USD",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { money = 200000000 } } },
    inheritance = { add = { flags = { "NO_UNLOAD", "NO_RELOAD", "TRADER_AVOID" } } },
    tool = { ammo_types = { "money" } },
}

ccb.content.define_item {
    id = "wallet_travel",
    category = "clothing",
    symbol = ";",
    color = "dark_gray",
    name = ccb.content.plural_text("travel wallet", "travel wallets"),
    description = ccb.content.text("A flat case with a neck strap, used to carry items such as currency, identification documents, laminated cards, and other small items."),
    price = "150 USD",
    survival_price = "2 USD 50 cent",
    materials = { "plastic", "leather" },
    flags = {
        "OVERSIZE",
        "BELTED",
        "ALLOWS_NATURAL_ATTACKS",
        "TARDIS",
        "COLLAPSE_CONTENTS",
        "POWERARMOR_COMPATIBLE",
    },
    mass = "708 g",
    volume = "500 ml",
    pockets = {
        {
            kind = "CONTAINER",
            rigid = true,
            mass_limit = "600 g",
            capacity = "500 ml",
            moves = 400,
            allowed_flags = { "BANK_NOTE_SHAPED", "CREDIT_CARD_SHAPED" },
        },
    },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        thickness = 2,
        portions = { { encumbrance = 2, coverage = 100, covers = { "torso" }, subparts = { "torso_neck" } } },
    },
}

ccb.content.define_item {
    id = "lanyard",
    category = "clothing",
    symbol = "[",
    color = "white",
    name = ccb.content.plural_text("lanyard", "lanyards"),
    description = ccb.content.text("A flat, clear plastic sleeve for identification documents, laminated cards, and other small items.  It has a neck strap attached."),
    price = "10 cent",
    survival_price = "1 cent",
    materials = { "plastic" },
    flags = { "OVERSIZE", "BELTED", "ALLOWS_NATURAL_ATTACKS", "POWERARMOR_COMPATIBLE", "PADDED" },
    mass = "250 g",
    volume = "250 ml",
    length = "5 cm",
    pockets = {
        {
            kind = "CONTAINER",
            rigid = false,
            mass_limit = "60 g",
            capacity = "150 ml",
            max_item_length = "85 mm",
            moves = 100,
            allowed_flags = { "BANK_NOTE_SHAPED", "CREDIT_CARD_SHAPED" },
        },
    },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        thickness = 1,
        portions = { { encumbrance = 0, covers = { "torso" }, subparts = { "torso_neck" } } },
    },
}
