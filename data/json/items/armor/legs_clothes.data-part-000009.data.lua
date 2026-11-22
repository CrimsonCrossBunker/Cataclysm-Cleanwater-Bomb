local ccb = require("ccb")

ccb.content.define_item {
    id = "technician_pants_gray",
    name = ccb.content.plural_text("work pants", "work pants"),
    description = "A pair of gray canvas work pants.",
    symbol = "[",
    color = "light_gray",
    looks_like = "pants",
    mass = "1040 g",
    volume = "2 L",
    price = "50 USD",
    survival_price = "1 USD",
    snippet_category = {
        { id = "technician_pants_blue", text = "A pair of blue canvas work pants." },
        { id = "technician_pants_gray", text = "A pair of gray canvas work pants." },
        { id = "technician_pants_lightblue", text = "A pair of light-blue canvas work pants." },
    },
    flags = { "VARSIZE", "POCKETS", "STURDY", "WATERPROOF" },
    materials = { "canvas" },
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1500 ml",
            mass_limit = "5 kg",
            max_item_length = "19 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1500 ml",
            mass_limit = "5 kg",
            max_item_length = "19 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1080 ml",
            mass_limit = "5 kg",
            max_item_length = "165 mm",
            moves = 100,
        },
        {
            kind = "CONTAINER",
            capacity = "1080 ml",
            mass_limit = "5 kg",
            max_item_length = "165 mm",
            moves = 100,
        },
        {
            kind = "CONTAINER",
            capacity = "200 ml",
            mass_limit = "3 kg",
            max_item_length = "12 cm",
            moves = 120,
        },
        {
            kind = "CONTAINER",
            capacity = "200 ml",
            mass_limit = "3 kg",
            max_item_length = "12 cm",
            moves = 120,
        },
    },
    armor = {
        thickness = 0.5,
        warmth = 15,
        portions = {
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_upper_l", "leg_lower_l", "leg_hip_r", "leg_upper_r", "leg_lower_r" },
                coverage = 100,
                encumbrance = { 4, 9 },
                materials = {
                    { id = "canvas", thickness = 0.5, coverage = 100 },
                },
            },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_knee_l", "leg_knee_r" },
                coverage = 100,
                encumbrance = { 0, 0 },
                materials = {
                    { id = "canvas", thickness = 1, coverage = 100 },
                },
            },
        },
    },
}
