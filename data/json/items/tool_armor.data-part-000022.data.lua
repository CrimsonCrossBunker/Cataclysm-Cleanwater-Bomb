local ccb = require("ccb")

ccb.content.define_item {
    id = "foodperson_mask",
    name = ccb.content.plural_text("Foodperson mask", "Foodperson masks"),
    description = ccb.content.text("Foodperson, the mascot your stomach deserves!"),
    mass = "1500 g",
    volume = "16 L",
    price = "15 USD",
    survival_price = "10 cent",
    materials = { "cotton", "plastic" },
    symbol = "Q",
    color = "pink",
    flags = { "OUTER", "SUN_GLASSES", "COSPLAY_PROPS" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_MEDIUM" },
            default_magazine = "medium_battery_cell",
        },
    },
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 1, ammo_types = "battery" },
    armor = {
        warmth = 40,
        thickness = 1,
        environmental_protection = 3,
        portions = { { encumbrance = 30, coverage = 100, covers = { "head", "eyes", "mouth" } } },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("Your HUD lights-up: \"Greetings Foodperson, your shift begins now.  Good luck!\""),
            target = "foodperson_mask_on",
            need_worn = true,
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}

ccb.content.define_item {
    id = "foodperson_mask_on",
    name = ccb.content.plural_text("Foodperson mask (on)", "Foodperson masks (on)"),
    copy_from = "foodperson_mask",
    revert_to = "foodperson_mask",
    light = 10,
    flags = { "OUTER", "SUN_GLASSES", "NO_TAKEOFF", "WATCH", "NO_UNLOAD", "SPAWN_ACTIVE" },
    subtype_order = { "tool", "armor" },
    tool = { turns_per_charge = 60 },
    armor = {},
    use_actions = { "FOODPERSON" },
    tick_actions = { "FOODPERSON_VOICE" },
}

ccb.content.define_item {
    id = "attached_ear_plugs_on",
    name = ccb.content.plural_text("attached ear plugs (in) (pair)", "attached ear plugs (in) (pair)"),
    description = ccb.content.text("A pair of industrial-grade ear plugs attached together by some string.  They are inside your ears, activate them to take them out."),
    copy_from = "ear_plugs",
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You take the ear plugs out."),
            target = "attached_ear_plugs_off",
            menu_text = ccb.content.text("Unplug"),
            need_worn = true,
        },
    },
}

ccb.content.define_item {
    id = "attached_ear_plugs_off",
    name = ccb.content.plural_text("attached ear plugs (out) (pair)", "attached ear plugs (out) (pair)"),
    description = ccb.content.text("A pair of industrial-grade ear plugs, they are attached together by some string.  They hang around your neck, use them to plug them in."),
    copy_from = "attached_ear_plugs_on",
    inheritance = { remove = { flags = { "DEAF" } } },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You plug up your ears."),
            target = "attached_ear_plugs_on",
            menu_text = ccb.content.text("Plug in"),
            need_worn = true,
        },
    },
}

ccb.content.define_item {
    id = "makeshift_ear_plugs_on",
    name = ccb.content.plural_text("makeshift ear plugs (in) (pair)", "makeshift ear plugs (in) (pair)"),
    description = ccb.content.text("A pair of makeshift ear plugs made from lumps of wax on the ends of a piece of string.  They are inside your ears, activate them to take them out."),
    copy_from = "ear_plugs",
    materials = { "beeswax", "cotton" },
    inheritance = { scale = { volume = 2 } },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You take the ear plugs out."),
            target = "makeshift_ear_plugs_off",
            menu_text = ccb.content.text("Unplug"),
            need_worn = true,
        },
    },
}

ccb.content.define_item {
    id = "makeshift_ear_plugs_off",
    name = ccb.content.plural_text("makeshift ear plugs (out) (pair)", "makeshift ear plugs (out) (pair)"),
    description = ccb.content.text("A pair of makeshift ear plugs made from lumps of wax on the ends of a piece of string.  They hang around your neck, use them to plug them in."),
    copy_from = "ear_plugs",
    materials = { "beeswax", "cotton" },
    inheritance = { remove = { flags = { "DEAF" } }, scale = { volume = 2 } },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You plug up your ears."),
            target = "makeshift_ear_plugs_on",
            menu_text = ccb.content.text("Plug in"),
            need_worn = true,
        },
    },
}

ccb.content.define_item {
    id = "flight_helmet",
    category = "armor",
    name = ccb.content.plural_text("military flight helmet", "military flight helmets"),
    description = ccb.content.text("A military flight helmet.  Equipped with a visor, microphone, and noise dampening system.  The helmet is also fitted with plastic rail for a night-vision attachment."),
    mass = "1324 g",
    volume = "2 L",
    price = "500 USD",
    survival_price = "10 USD",
    accuracy = { grip = "bad", length = "short", surface = "any", balance = "uneven" },
    materials = { "kevlar_rigid", "plastic" },
    symbol = "[",
    looks_like = "helmet_motor",
    color = "dark_gray",
    techniques = { "WBLOCK_1" },
    flags = { "VARSIZE", "STURDY", "DEAF", "SUN_GLASSES", "PADDED", "MODULE_HOLDER" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_LIGHT", "BATTERY_ULTRA_LIGHT" },
            default_magazine = "light_battery_cell",
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "2 L",
            mass_limit = "2 kg",
            moves = 250,
            description = ccb.content.text("Pocket for a front night vision attachment."),
            allowed_flags = { "HELMET_FRONT_ATTACHMENT" },
            inherits_flags = false,
        },
    },
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 1, ammo_types = "battery" },
    armor = {
        portions = {
            { covers = { "head" }, coverage = 100, encumbrance = 30 },
            {
                covers = { "eyes" },
                rigid_only = true,
                coverage = 100,
                encumbrance = 5,
                layers = { "OUTER" },
            },
        },
        warmth = 15,
        thickness = 5,
        environmental_protection = 2,
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You turn on the %s."),
            target = "flight_helmet_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}

ccb.content.define_item {
    id = "flight_helmet_on",
    copy_from = "flight_helmet",
    name = ccb.content.plural_text("military flight helmet (on)", "military flight helmets (on)"),
    symbol = "[",
    looks_like = "helmet_motor",
    color = "dark_gray",
    revert_to = "flight_helmet",
    inheritance = {
        add = { flags = { "PARTIAL_DEAF", "TWO_WAY_RADIO", "SPAWN_ACTIVE" } },
        remove = { flags = { "DEAF" } },
    },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "60 mW", ammo_types = "battery" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You turn off the %s."),
            target = "flight_helmet",
        },
    },
}

ccb.content.define_item {
    id = "combo_cover",
    category = "clothing",
    name = ccb.content.plural_text("combo cover", "combo covers"),
    mass = "500 g",
    color = "white",
    symbol = "[",
    description = ccb.content.text("A military officer's combo cover, or peaked cap.  It conveys an air of authority, while keeping the sun out of your eyes."),
    price = "100 USD",
    survival_price = "10 USD",
    materials = { "cotton" },
    volume = "1750 ml",
    flags = { "VARSIZE", "SUN_GLASSES" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        warmth = 7,
        environmental_protection = 1,
        portions = { { covers = { "head" }, coverage = 80, encumbrance = 10 } },
        thickness = 0.5,
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Salute"),
            target = "combo_cover",
            message = ccb.content.text("You bring your hand to your cover and issue a salute."),
        },
    },
}
