local ccb = require("ccb")

ccb.content.define_item {
    id = "shorts_denim",
    name = ccb.content.plural_text("jorts", "jorts"),
    description = "A pair of denim shorts.",
    symbol = "[",
    color = "light_blue",
    looks_like = "shorts",
    mass = "260 g",
    volume = "1250 ml",
    price = "20 USD",
    survival_price = "50 cent",
    snippet_category = {
        { id = "denim_shorts1", text = "A pair of stone wash denim shorts." },
        {
            id = "denim_shorts2",
            text = "An old pair of denim jeans that have been cut down into shorts.",
        },
        { id = "denim_shorts3", text = "A pair of brand-name black denim shorts." },
    },
    flags = { "VARSIZE" },
    materials = { "denim" },
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
    faults = {
        { group = "fabric_denim" },
    },
    armor = {
        thickness = 0.65,
        warmth = 5,
        portions = {
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
                coverage = 100,
                volume_encumbrance = 0.5,
                encumbrance = 1,
            },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
                coverage = 90,
                volume_encumbrance = 0.0,
            },
        },
    },
}
