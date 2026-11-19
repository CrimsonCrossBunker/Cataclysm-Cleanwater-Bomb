local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_ammo_satchel",
    name = ccb.content.plural_text("U7s ammo satchel", "U7s ammo satchels"),
    description = ccb.content.text("A large magnetic magazine carrier.  It is capable of holding two large magazines close at hand."),
    mass = "180 g",
    volume = "500 ml",
    price = "80 USD",
    survival_price = "80 USD",
    materials = { "canvas" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            max_item_length = "500 mm",
            capacity = "2500 ml",
            mass_limit = "4 kg",
            moves = 40,
            holster = true,
            allowed_flags = { "MAG_COMPACT", "MAG_BULKY" },
            volume_encumbrance = 0.3,
        },
        {
            kind = "CONTAINER",
            max_item_length = "500 mm",
            capacity = "2500 ml",
            mass_limit = "4 kg",
            moves = 40,
            holster = true,
            allowed_flags = { "MAG_COMPACT", "MAG_BULKY" },
            volume_encumbrance = 0.3,
        },
    },
    flags = { "WATER_FRIENDLY", "BELTED", "PALS_LARGE" },
    armor = {
        thickness = 2,
        portions = { { encumbrance = 1, coverage = 100, covers = { "torso" }, subparts = { "torso_waist" } } },
    },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Stash ammo"),
            message = ccb.content.text("You stash your %s."),
        },
    },
}
