local ccb = require("ccb")

ccb.content.define_item {
    id = "ammo_satchel",
    name = ccb.content.plural_text("ammo satchel", "ammo satchels"),
    description = ccb.content.text("A fabric ammo bag worn at the waist.  It is capable of holding a single large magazine close at hand."),
    mass = "180 g",
    volume = "500 ml",
    price = "20 USD",
    survival_price = "6 USD",
    materials = { "canvas" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "dark_gray",
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

ccb.content.define_item {
    id = "chestpouch",
    name = ccb.content.plural_text("chest ammo pouch", "chest ammo pouches"),
    description = ccb.content.text("A fabric ammo pouch that can be strapped to your chest and hold a single magazine close at hand."),
    mass = "140 g",
    volume = "250 ml",
    price = "20 USD",
    survival_price = "2 USD",
    materials = { "canvas" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "dark_gray",
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
    flags = { "WATER_FRIENDLY", "BELTED", "PALS_SMALL" },
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

-- inherit name from item
ccb.content.define_item {
    id = "chestrig",
    name = ccb.content.plural_text("chest rig", "chest rigs"),
    description = ccb.content.text("Popularized during the Vietnam War, chest rigs like these are typically plain, barebones affairs consisting of three or more pouches in a row, with straps to secure them on your chest.  This one can hold four magazines in its pouches."),
    variant_kind = "generic",
    variants = {
        {
            id = "generic_chestrig",
            description = ccb.content.text("Popularized during the Vietnam War, chest rigs like these are typically plain, barebones affairs consisting of three or more pouches in a row, with straps to secure them on your chest.  This one can hold four magazines in its pouches."),
            weight = 30,
        },
        {
            id = "flag_chestrig",
            name = ccb.content.plural_text("patriot's chest rig", "patriot's chest rigs"),
            description = ccb.content.text("An American flag is proudly embroidered across the front of each pouch, with a tiny, eagle-winged .50-caliber bullet crowning each banner."),
            append = true,
        },
    },
    mass = "425 g",
    volume = "500 ml",
    price = "39 USD",
    survival_price = "30 USD",
    materials = { "canvas" },
    symbol = "[",
    looks_like = "tool_belt",
    color = "dark_gray",
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
        {
            kind = "CONTAINER",
            max_item_length = "240 mm",
            capacity = "750 ml",
            mass_limit = "2 kg",
            moves = 40,
            allowed_flags = { "MAG_COMPACT" },
            volume_encumbrance = 0.3,
        },
        {
            kind = "CONTAINER",
            max_item_length = "240 mm",
            capacity = "750 ml",
            mass_limit = "2 kg",
            moves = 40,
            allowed_flags = { "MAG_COMPACT" },
            volume_encumbrance = 0.3,
        },
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
    flags = { "WATER_FRIENDLY", "BELTED" },
    armor = {
        thickness = 2,
        portions = { { encumbrance = 1, coverage = 25, covers = { "torso" }, subparts = { "torso_upper" } } },
    },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Stash ammo"),
            message = ccb.content.text("You stash your %s."),
        },
    },
}
