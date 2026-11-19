local ccb = require("ccb")

ccb.content.define_item {
    id = "welding_mask",
    name = ccb.content.plural_text("welding mask", "welding masks"),
    description = ccb.content.text("A plastic mask with a very dark visor, meant to protect the entire face while welding.  It also serves as somewhat good armor, but makes it hard to see.  Activate it to push it up your head."),
    mass = "1 kg",
    volume = "4 L",
    length = "34 cm",
    price = "14 USD",
    survival_price = "5 USD",
    materials = { "plastic" },
    symbol = "[",
    color = "dark_gray",
    qualities = { { id = "GLARE", level = 1 } },
    flags = { "SUN_GLASSES", "FLASH_PROTECTION" },
    armor = {
        warmth = 10,
        thickness = 3,
        environmental_protection = 1,
        portions = {
            {
                encumbrance = 20,
                coverage = 100,
                covers = { "head" },
                subparts = { "head_forehead", "head_ear_r", "head_ear_l" },
            },
            { encumbrance = 0, coverage = 30, covers = { "head" }, subparts = { "head_crown" } },
            { encumbrance = 40, coverage = 90, covers = { "eyes", "mouth" }, rigid_only = true },
        },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You push your welding mask up your head."),
            target = "welding_mask_raised",
            menu_text = ccb.content.text("Raise"),
        },
    },
}

ccb.content.define_item {
    id = "welding_mask_crude",
    name = ccb.content.plural_text("crude welding mask", "crude welding masks"),
    description = ccb.content.text("A crude welding mask made from shaped steel.  It will keep your face safe while welding, but it's a bit less comfortable than the real deal.  Activate it to push it up your head."),
    mass = "4 kg",
    volume = "4 L",
    price = "10 USD",
    survival_price = "1 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "uneven" },
    materials = { "steel" },
    symbol = "[",
    color = "dark_gray",
    qualities = { { id = "GLARE", level = 1 } },
    flags = { "SUN_GLASSES", "FLASH_PROTECTION" },
    melee_damage = { bash = 5 },
    armor = {
        warmth = 12,
        thickness = 2,
        environmental_protection = 1,
        portions = {
            {
                encumbrance = 25,
                coverage = 100,
                covers = { "head" },
                subparts = { "head_forehead", "head_ear_r", "head_ear_l" },
            },
            { encumbrance = 0, coverage = 30, covers = { "head" }, subparts = { "head_crown" } },
            { encumbrance = 45, coverage = 90, covers = { "eyes", "mouth" }, rigid_only = true },
        },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You push your welding mask up your head."),
            target = "welding_mask_crude_raised",
            menu_text = ccb.content.text("Raise"),
        },
    },
}

ccb.content.define_item {
    id = "welding_mask_crude_raised",
    name = ccb.content.plural_text("crude welding mask (raised)", "crude welding masks (raised)"),
    description = ccb.content.text("A crude welding mask made from shaped steel.  It's less dark than a proper welding mask, and therefore less difficult to see in, but also less protective when welding.  Activate it to lower it over your face."),
    mass = "4 kg",
    volume = "4 L",
    price = "10 USD",
    survival_price = "1 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "uneven" },
    materials = { "steel" },
    symbol = "[",
    color = "dark_gray",
    melee_damage = { bash = 5 },
    armor = {
        warmth = 8,
        thickness = 2,
        portions = { { encumbrance = 25, coverage = 80, covers = { "head" }, subparts = { "head_crown" } } },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower your welding mask over your face."),
            target = "welding_mask_crude",
            menu_text = ccb.content.text("Lower"),
        },
    },
}

ccb.content.define_item {
    id = "welding_mask_raised",
    name = ccb.content.plural_text("welding mask (raised)", "welding masks (raised)"),
    description = ccb.content.text("A plastic mask with a very dark visor, meant to protect the entire face while welding.  It also serves as somewhat good armor, but makes it hard to see.  Activate it to lower it over your face."),
    mass = "1 kg",
    volume = "4 L",
    length = "34 cm",
    price = "14 USD",
    survival_price = "5 USD",
    materials = { "plastic" },
    symbol = "[",
    color = "dark_gray",
    armor = {
        warmth = 6,
        thickness = 3,
        portions = { { encumbrance = 20, coverage = 80, covers = { "head" }, subparts = { "head_crown" } } },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower your welding mask over your face."),
            target = "welding_mask",
            menu_text = ccb.content.text("Lower"),
        },
    },
}

ccb.content.define_item {
    id = "game_watch",
    name = ccb.content.plural_text("game watch", "game watches"),
    category = "clothing",
    volume = "250 ml",
    description = ccb.content.text("A waterproof digital watch with a built-in electronic game system, powered by standard batteries.  Activate to play."),
    mass = "112 g",
    color = "light_gray",
    price = "60 USD",
    survival_price = "1 USD",
    materials = { "plastic" },
    flags = {
        "WATCH",
        "ALARMCLOCK",
        "WATER_FRIENDLY",
        "BELTED",
        "FRAGILE",
        "ALLOWS_NATURAL_ATTACKS",
        "OVERSIZE",
    },
    symbol = "[",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_ULTRA_LIGHT" },
            default_magazine = "light_minus_battery_cell",
        },
    },
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 1, ammo_types = "battery" },
    armor = {
        sided = true,
        portions = {
            {
                coverage = 100,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r" },
            },
        },
    },
    use_actions = { "PORTABLE_GAME" },
}
