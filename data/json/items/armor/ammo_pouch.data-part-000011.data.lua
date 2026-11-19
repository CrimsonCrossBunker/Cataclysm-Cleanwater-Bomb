local ccb = require("ccb")

ccb.content.define_item {
    id = "ammo_satchel_leather",
    name = ccb.content.plural_text("leather ammo satchel", "leather ammo satchels"),
    description = ccb.content.text("A sturdy leather ammo bag worn at the waist.  It is capable of holding a single large magazine close at hand."),
    mass = "590 g",
    volume = "500 ml",
    price = "20 USD",
    survival_price = "6 USD",
    materials = { "leather" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "brown",
    pockets = {
        {
            kind = "CONTAINER",
            max_item_length = "300 mm",
            capacity = "1500 ml",
            mass_limit = "2 kg",
            moves = 40,
            allowed_flags = { "MAG_COMPACT", "MAG_BULKY" },
            volume_encumbrance = 0.3,
        },
    },
    flags = { "WATER_FRIENDLY", "OVERSIZE", "BELTED", "PALS_LARGE" },
    armor = {
        thickness = 2,
        portions = { { encumbrance = 1, coverage = 20, covers = { "torso" }, subparts = { "torso_waist" } } },
    },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Stash ammo"),
            message = ccb.content.text("You stash your %s."),
        },
    },
}

ccb.content.define_item {
    id = "chestpouch_leather",
    name = ccb.content.plural_text("leather chest ammo pouch", "leather chest ammo pouches"),
    description = ccb.content.text("A leather ammo pouch that can be strapped to your chest and hold a single magazine close at hand."),
    mass = "1140 g",
    volume = "250 ml",
    price = "12 USD 50 cent",
    survival_price = "2 USD",
    materials = { "leather" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "brown",
    pockets = {
        {
            kind = "CONTAINER",
            max_item_length = "240 mm",
            capacity = "750 ml",
            mass_limit = "2 kg",
            moves = 40,
            allowed_flags = { "MAG_COMPACT" },
            volume_encumbrance = 0.3,
        },
    },
    flags = { "WATER_FRIENDLY", "OVERSIZE", "BELTED", "PALS_SMALL" },
    armor = {
        thickness = 2,
        portions = { { coverage = 25, covers = { "torso" }, subparts = { "torso_upper" } } },
    },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Stash ammo"),
            message = ccb.content.text("You stash your %s."),
        },
    },
}
