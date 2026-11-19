local ccb = require("ccb")

--  stats taken from: https://www.patriotoutfitters.com/condor-vertical-molle-holster?PMSRCH=MOLLE%20GEAR
ccb.content.define_item {
    id = "tactical_holster",
    name = ccb.content.plural_text("tactical holster", "tactical holsters"),
    description = ccb.content.text("A sturdy holster designed to be worn vertically, to keep a small profile on a tactical vest.  This makes it a little more awkward to draw from than a normal holster."),
    mass = "220 g",
    volume = "500 ml",
    price = "90 USD",
    survival_price = "2 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "sheath",
    color = "light_gray",
    pockets = {
        {
            magazine_well = "350 ml",
            kind = "CONTAINER",
            holster = true,
            min_item_volume = "300 ml",
            capacity = "1000 ml",
            mass_limit = "2 kg",
            max_item_length = "30 cm",
            moves = 70,
        },
    },
    flags = { "BELTED", "OVERSIZE", "PALS_SMALL" },
    armor = {
        sided = true,
        thickness = 1,
        portions = {
            {
                encumbrance = { 3, 4 },
                coverage = 5,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_r", "leg_hip_l" },
            },
        },
    },
    use_actions = { { kind = "holster" } },
}
