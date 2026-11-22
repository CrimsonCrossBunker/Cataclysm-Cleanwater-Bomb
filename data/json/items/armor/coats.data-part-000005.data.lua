local ccb = require("ccb")

ccb.content.define_item {
    id = "coat_light_winter",
    name = "shell jacket",
    description = "A lightweight waterproof shell jacket designed to block wind and rain.  It has deep pockets and provides a moderate amount of warmth.",
    symbol = "[",
    color = "light_blue",
    looks_like = "coat_winter",
    mass = "880 g",
    volume = "2150 ml",
    price = "140 USD",
    survival_price = "5 USD ",
    flags = { "VARSIZE", "POCKETS", "COLLAR", "OUTER" },
    materials = { "nylon", "cotton" },
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "3 kg",
            max_item_length = "21 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "3 kg",
            max_item_length = "21 cm",
            moves = 80,
        },
        { kind = "CONTAINER", capacity = "800 ml", mass_limit = "1600 g", moves = 90 },
    },
    armor = {
        thickness = 1,
        warmth = 40,
        environmental_protection = 3,
        portions = {
            {
                covers = { "torso" },
                coverage = 100,
                encumbrance = { 12, 14 },
                materials = {
                    { id = "nylon", thickness = 0.25, coverage = 100 },
                    { id = "cotton", thickness = 0.25, coverage = 100 },
                },
            },
            {
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = { 12, 12 },
                materials = {
                    { id = "nylon", thickness = 0.25, coverage = 100 },
                    { id = "cotton", thickness = 0.25, coverage = 100 },
                },
            },
        },
    },
}
