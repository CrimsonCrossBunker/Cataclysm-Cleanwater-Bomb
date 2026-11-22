local ccb = require("ccb")

ccb.content.define_item {
    id = "rope_loop",
    name = ccb.content.plural_text("loop of rope", "loops of rope"),
    description = "A length of rope tied with a sliding knot into a loop.  You can slip all sorts of large objects in and carry them as a bundle; if you want to tie a single item more securely you'd have to disassemble this loop.  It takes a while to untie it and get things out, and attackers might pull the whole thing undone if you're not careful.",
    symbol = ",",
    color = "light_gray",
    looks_like = "rope_6",
    mass = "180 g",
    volume = "360 ml",
    price = "3 USD 60 cent",
    survival_price = "10 cent",
    flags = { "NO_SALVAGE", "TIE_UP", "BELTED", "WATER_FRIENDLY", "OVERSIZE" },
    materials = { "cotton" },
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "50 L",
            mass_limit = "80 kg",
            max_item_length = "260 cm",
            min_item_length = "60 cm",
            moves = 1000,
            ripoff = 5,
            extra_encumbrance = 20,
            transparent = true,
            activity_noise = { volume = 9, chance = 15 },
        },
    },
    armor = {
        thickness = 2,
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
                coverage = 10,
                encumbrance = { 3, 80 },
            },
        },
    },
}
