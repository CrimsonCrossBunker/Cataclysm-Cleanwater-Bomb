local ccb = require("ccb")

-- reference: https://www.rei.com/product/202772/black-diamond-astro-300-headlamp
ccb.content.define_item {
    id = "wearable_light",
    category = "clothing",
    ascii_picture = "wearable_light",
    symbol = "[",
    color = "blue",
    name = ccb.content.plural_text("headlamp", "headlamps"),
    description = ccb.content.text("An LED headlamp with an adjustable strap so as to be comfortably worn on your head or attached to your helmet.  Use it to turn it on."),
    price = "20 USD",
    survival_price = "1 USD",
    materials = { "plastic", "aluminum" },
    flags = { "OVERSIZE", "BELTED", "PADDED", "ALLOWS_NATURAL_ATTACKS" },
    mass = "150 g",
    volume = "141 ml",
    length = "136 mm",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_MEDIUM" },
            default_magazine = "medium_battery_cell",
        },
    },
    melee_damage = { bash = 1 },
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 1, ammo_types = { "battery" } },
    armor = {
        thickness = 1,
        portions = { { coverage = 45, covers = { "head" }, subparts = { "head_crown", "head_forehead" } } },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You turn on the %s."),
            target = "wearable_light_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}

ccb.content.define_item {
    id = "wearable_camera",
    copy_from = "camera",
    category = "clothing",
    symbol = "[",
    color = "blue",
    name = ccb.content.plural_text("wearable camera", "wearable cameras"),
    description = ccb.content.text("A point-and-shoot digital camera with a digital viewfinder, a backup 'iron-sight', and flash.  You can look at your photos on the digital screen, or transfer them with a memory card.  This one can be worn over your neck."),
    flags = {
        "NO_UNLOAD",
        "NO_RELOAD",
        "OVERSIZE",
        "BELTED",
        "ALLOWS_NATURAL_ATTACKS",
        "WATER_BREAK",
        "ELECTRONIC",
    },
    mass = "520 g",
    volume = "500 ml",
    melee_damage = { bash = 1 },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        portions = {
            {
                encumbrance = 2,
                coverage = 15,
                covers = { "torso" },
                subparts = { "torso_hanging_front" },
            },
        },
    },
}

ccb.content.define_item {
    id = "wearable_camera_pro",
    copy_from = "camera_pro",
    category = "clothing",
    name = ccb.content.plural_text("wearable professional camera", "wearable professional cameras"),
    description = ccb.content.text("A 35 mm digital SLR (single-lens reflex) camera with optical and digital viewfinders, a zoom lens with auto-focus and stabilizer, and flash.  You can view your photos on it or transfer them with a memory card.  Before the Cataclysm, you could have taken professional-grade photos using this.  This one can be worn over your neck."),
    flags = {
        "NO_UNLOAD", "NO_RELOAD", "CAMERA_PRO", "ALWAYS_TWOHAND", "OVERSIZE", "BELTED",
        "ALLOWS_NATURAL_ATTACKS", "WATER_BREAK", "ELECTRONIC",
    },
    mass = "520 g",
    volume = "500 ml",
    melee_damage = { bash = 1 },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        portions = {
            {
                encumbrance = 2,
                coverage = 15,
                covers = { "torso" },
                subparts = { "torso_hanging_front" },
            },
        },
    },
}

ccb.content.define_item {
    id = "wearable_light_on",
    copy_from = "wearable_light",
    ascii_picture = "wearable_light",
    name = ccb.content.plural_text("headlamp (on)", "headlamps (on)"),
    description = ccb.content.text("An LED headlamp with an adjustable strap so as to be comfortably worn on your head or attached to your helmet.  It is turned on, and continually draining batteries.  Use it to turn it off."),
    flags = {
        "CHARGEDIM",
        "OVERSIZE",
        "BELTED",
        "PADDED",
        "ALLOWS_NATURAL_ATTACKS",
        "TRADER_AVOID",
        "SPAWN_ACTIVE",
    },
    light = 300,
    revert_to = "wearable_light",
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "1560 mW" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You turn off the %s."),
            target = "wearable_light",
        },
    },
}

ccb.content.define_item {
    id = "wearable_big_light_on",
    copy_from = "wearable_big_light",
    name = ccb.content.plural_text("heavy-duty headlamp (on)", "heavy-duty headlamps (on)"),
    description = ccb.content.text("A heavy-duty LED headlamp with a durable polymer housing.  It's impact-resistant, chemical-resistant, waterproof and certified for use in hazardous environments.  Designed for firefighters, rescue personnel and miners.  Use it to turn it off."),
    flags = {
        "CHARGEDIM",
        "OVERSIZE",
        "BELTED",
        "PADDED",
        "ALLOWS_NATURAL_ATTACKS",
        "TRADER_AVOID",
        "SPAWN_ACTIVE",
    },
    light = 650,
    revert_to = "wearable_big_light",
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "4 W" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You turn off the %s."),
            target = "wearable_big_light",
        },
    },
}

-- see heavy_flashlight. Based on https://www.nightstick.com/collections/fire/products/xpp-5462rx
ccb.content.define_item {
    id = "wearable_big_light",
    category = "clothing",
    symbol = "[",
    color = "blue",
    name = ccb.content.plural_text("heavy-duty headlamp", "heavy-duty headlamps"),
    description = ccb.content.text("A heavy-duty LED headlamp with a durable polymer housing.  It's impact-resistant, chemical-resistant, waterproof and certified for use in hazardous environments.  Designed for firefighters, rescue personnel and miners.  Use it to turn it on."),
    price = "65 USD",
    survival_price = "2 USD",
    materials = { "thermo_resin", "aluminum" },
    flags = { "OVERSIZE", "BELTED", "PADDED", "ALLOWS_NATURAL_ATTACKS" },
    mass = "300 g",
    volume = "750 ml",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_MEDIUM" },
            default_magazine = "medium_battery_cell",
        },
    },
    melee_damage = { bash = 1 },
    looks_like = "wearable_light",
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 1, ammo_types = { "battery" } },
    armor = {
        thickness = 1,
        portions = {
            {
                encumbrance = 2,
                coverage = 50,
                covers = { "head" },
                subparts = { "head_crown", "head_forehead" },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You turn on the %s."),
            target = "wearable_big_light_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}
