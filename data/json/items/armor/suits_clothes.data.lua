local ccb = require("ccb")

ccb.content.define_item {
    id = "denim_overalls",
    name = ccb.content.plural_text("denim overalls", "denim overalls"),
    description = "The basic denim overalls that is the symbol of the Proletariat (and some hipsters).  It covers the legs and a large portion of the torso, secured around the shoulders with straps.  It has many pockets and is relatively protective.",
    symbol = "[",
    color = "light_blue",
    mass = "1200 g",
    volume = "3300 ml",
    price = "65 USD 50 cent",
    survival_price = "8 USD",
    flags = { "VARSIZE", "POCKETS", "STURDY" },
    materials = { "denim" },
    pockets = {
        { kind = "CONTAINER", capacity = "2 L", mass_limit = "4 kg", moves = 120 },
        { kind = "CONTAINER", capacity = "2 L", mass_limit = "4 kg", moves = 120 },
        { kind = "CONTAINER", capacity = "800 ml", mass_limit = "1600 g", moves = 70 },
        { kind = "CONTAINER", capacity = "800 ml", mass_limit = "1600 g", moves = 70 },
        { kind = "CONTAINER", capacity = "800 ml", mass_limit = "1600 g", moves = 70 },
        { kind = "CONTAINER", capacity = "800 ml", mass_limit = "1600 g", moves = 70 },
    },
    armor = {
        thickness = 1.1,
        warmth = 18,
        portions = {
            {
                covers = { "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = 12,
            },
            {
                covers = { "torso" },
                coverage = 80,
                encumbrance = { 14, 20 },
            },
        },
    },
}
