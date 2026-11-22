local ccb = require("ccb")

ccb.content.define_item {
    id = "technician_shirt_gray",
    name = "work t-shirt",
    description = "A gray work t-shirt with a small front pocket.",
    symbol = "[",
    color = "light_gray",
    looks_like = "polo_shirt",
    mass = "200 g",
    volume = "250 ml",
    price = "10 USD",
    survival_price = "50 cent",
    snippet_category = {
        {
            id = "technician_shirt_blue",
            text = "A blue work t-shirt with a small front pocket.",
        },
        {
            id = "technician_shirt_gray",
            text = "A gray work t-shirt with a small front pocket.",
        },
        {
            id = "technician_shirt_lightblue",
            text = "A light-blue work t-shirt with a small front pocket.",
        },
    },
    flags = { "VARSIZE" },
    materials = { "canvas" },
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "650 ml",
            mass_limit = "1 kg",
            max_item_length = "15 cm",
            moves = 80,
        },
    },
    armor = {
        thickness = 0.2,
        warmth = 8,
        portions = {
            {
                covers = { "torso" },
                coverage = 90,
                encumbrance = { 4, 5 },
            },
            {
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_shoulder_r" },
                coverage = 100,
                encumbrance = { 0, 0 },
            },
            {
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_upper_l", "arm_upper_r" },
                coverage = 50,
                encumbrance = { 0, 0 },
            },
        },
    },
}
