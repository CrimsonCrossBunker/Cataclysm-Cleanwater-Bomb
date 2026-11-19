local ccb = require("ccb")

ccb.content.define_item {
    id = "fitness_band",
    name = ccb.content.plural_text("fitness band", "fitness bands"),
    category = "clothing",
    volume = "100 ml",
    description = ccb.content.text("A fitness band that can track your heartbeat, exercise level, and calories, and also has a clock.  Activate to see your metrics."),
    mass = "30 g",
    color = "light_gray",
    price = "50 USD",
    survival_price = "1 USD",
    materials = { "plastic" },
    flags = {
        "WATCH",
        "CALORIE_BURN",
        "WATER_FRIENDLY",
        "BELTED",
        "FRAGILE",
        "ALLOWS_NATURAL_ATTACKS",
        "OVERSIZE",
    },
    symbol = "[",
    subtype_order = { "tool", "armor" },
    tool = {},
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
    use_actions = { "FITNESS_CHECK" },
}

-- Based on mount for this: https://www.amazon.com/dp/B00DI5GMOM
ccb.content.define_item {
    id = "flashlight_mount_wrist",
    name = ccb.content.plural_text("diving flashlight wrist mount", "diving flashlight wrist mounts"),
    category = "clothing",
    volume = "150 ml",
    description = ccb.content.text("A proprietary wrist mount for a flashlight.  Not very useful on its own."),
    mass = "50 g",
    color = "light_gray",
    price = "25 USD",
    survival_price = "1 USD",
    materials = { "rubber", "plastic" },
    flags = { "WATER_FRIENDLY", "BELTED", "ALLOWS_NATURAL_ATTACKS", "OVERSIZE" },
    symbol = "[",
    pockets = {
        {
            kind = "CONTAINER",
            volume_encumbrance = 1.5,
            capacity = "300 ml",
            mass_limit = "300 g",
            moves = 150,
            description = ccb.content.text("Proprietary mount for a diving flashlight."),
            allowed_flags = { "WRIST_MOUNT_ATTACHMENT" },
        },
    },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        sided = true,
        portions = {
            {
                materials = {
                    { id = "rubber", coverage = 100, thickness = 2.0 },
                    { id = "plastic", coverage = 40, thickness = 4.0 },
                },
                coverage = 70,
                encumbrance = 1,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "holo_cloak",
    name = ccb.content.plural_text("hologram cloak", "hologram cloaks"),
    description = ccb.content.text("A cloak woven with metallic fibers and covered with hexagonal sheets of reflective carbide.  When activated, it will create a holographic decoy of its wearer."),
    mass = "1552 g",
    volume = "3500 ml",
    price = "55 kUSD",
    survival_price = "100 USD",
    materials = { "superalloy" },
    symbol = "[",
    color = "light_gray",
    pockets = { { kind = "MAGAZINE_WELL", rigid = true, allowed_items = { "medium_battery_cell" } } },
    flags = { "OVERSIZE", "HOOD", "WATERPROOF", "BELTED", "SOFT" },
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 25, ammo_types = "battery" },
    armor = {
        warmth = 10,
        thickness = 0.5,
        environmental_protection = 2,
        portions = {
            { encumbrance = 10, coverage = 70, covers = { "torso", "arm_l", "arm_r" } },
            {
                covers = { "head" },
                encumbrance = 10,
                coverage = 100,
                subparts = { "head_crown", "head_forehead", "head_nape" },
            },
            {
                covers = { "leg_l", "leg_r" },
                coverage = 70,
                encumbrance = 10,
                subparts = { "leg_draped_l", "leg_draped_r" },
                layers = { "BELTED" },
            },
        },
    },
    use_actions = { "DIRECTIONAL_HOLOGRAM" },
}

ccb.content.define_item {
    id = "fedora",
    category = "clothing",
    name = ccb.content.plural_text("fedora", "fedoras"),
    mass = "350 g",
    color = "brown",
    symbol = "[",
    description = ccb.content.text("A high-crowned, wide-brimmed, sable-colored fedora.  Its brim helps keep the sun out of your eyes.  The perfect hat for treasure hunting."),
    price = "75 USD",
    survival_price = "1 USD",
    materials = { "leather" },
    volume = "1750 ml",
    flags = { "VARSIZE", "SUN_GLASSES" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        warmth = 7,
        environmental_protection = 1,
        thickness = 0.5,
        portions = { { encumbrance = 10, coverage = 100, covers = { "head" }, subparts = { "head_crown" } } },
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Tip"),
            target = "fedora",
            message = ccb.content.text("You tip your fedora."),
        },
    },
}

ccb.content.define_item {
    id = "thermal_socks",
    category = "clothing",
    symbol = "[",
    color = "light_gray",
    name = ccb.content.plural_text("thermal electric socks (pair)", "thermal electric socks (pair)"),
    description = ccb.content.text("A pair of socks with internal battery-powered heating elements.  Use it to turn it on."),
    flags = { "VARSIZE", "SKINTIGHT" },
    price = "50 USD",
    survival_price = "1 USD",
    materials = { "cotton" },
    mass = "182 g",
    volume = "750 ml",
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
        warmth = 10,
        thickness = 0.3,
        portions = { { coverage = 100, covers = { "foot_l", "foot_r" } } },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You turn the heating elements on."),
            target = "thermal_socks_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}

ccb.content.define_item {
    id = "thermal_socks_on",
    copy_from = "thermal_socks",
    name = ccb.content.plural_text("thermal electric socks (on) (pair)", "thermal electric socks (on) (pair)"),
    description = ccb.content.text("A pair of socks with internal battery-powered heating elements.  They are currently on, and continually draining batteries.  Use it to turn them off."),
    flags = { "VARSIZE", "SKINTIGHT", "TRADER_AVOID", "SPAWN_ACTIVE" },
    revert_to = "thermal_socks",
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "400 mW" },
    armor = { warmth = 60 },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You turn the heating elements off."),
            target = "thermal_socks",
        },
    },
}

ccb.content.define_item {
    id = "thermal_suit",
    category = "clothing",
    symbol = "[",
    color = "light_gray",
    name = ccb.content.plural_text("thermal electric suit", "thermal electric suits"),
    description = ccb.content.text("A full-body suit of thin thermal underwear equipped with internal battery-powered heating elements.  Use it to turn it on."),
    flags = { "VARSIZE", "SKINTIGHT" },
    price = "150 USD",
    survival_price = "5 USD",
    materials = { "cotton" },
    mass = "3972 g",
    volume = "2 L",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_MEDIUM", "BATTERY_HEAVY" },
            default_magazine = "heavy_battery_cell",
        },
    },
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 1, ammo_types = "battery" },
    armor = {
        warmth = 10,
        thickness = 0.1,
        portions = { { coverage = 100, covers = { "torso", "arm_l", "arm_r", "leg_l", "leg_r" } } },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You turn the heating elements on."),
            target = "thermal_suit_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}

ccb.content.define_item {
    id = "thermal_suit_on",
    copy_from = "thermal_suit",
    name = ccb.content.plural_text("thermal electric suit (on)", "thermal electric suits (on)"),
    description = ccb.content.text("A full-body suit of thin thermal underwear equipped with internal battery-powered heating elements.  It is currently on, and continually draining batteries.  Use it to turn it off."),
    flags = { "VARSIZE", "SKINTIGHT", "TRADER_AVOID", "SPAWN_ACTIVE" },
    revert_to = "thermal_suit",
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "6800 mW" },
    armor = { warmth = 60 },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You turn the heating elements off."),
            target = "thermal_suit",
        },
    },
}

ccb.content.define_item {
    id = "thermal_gloves",
    category = "clothing",
    symbol = "[",
    color = "light_gray",
    name = ccb.content.plural_text("thermal electric gloves (pair)", "thermal electric gloves (pair)"),
    description = ccb.content.text("A pair of gloves with internal battery-powered heating elements.  Use it to turn it on."),
    flags = { "VARSIZE", "SKINTIGHT" },
    price = "50 USD",
    survival_price = "1 USD",
    materials = { "cotton" },
    mass = "210 g",
    volume = "750 ml",
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
        warmth = 10,
        thickness = 0.3,
        portions = { { coverage = 100, covers = { "hand_l", "hand_r" } } },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You turn the heating elements on."),
            target = "thermal_gloves_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}

ccb.content.define_item {
    id = "thermal_gloves_on",
    copy_from = "thermal_gloves",
    name = ccb.content.plural_text("thermal electric gloves (on) (pair)", "thermal electric gloves (on) (pair)"),
    description = ccb.content.text("A pair of gloves with internal battery-powered heating elements.  They are currently on, and continually draining batteries.  Use it to turn them off."),
    flags = { "VARSIZE", "SKINTIGHT", "TRADER_AVOID", "SPAWN_ACTIVE" },
    revert_to = "thermal_gloves",
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "400 mW" },
    armor = { warmth = 60 },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You turn the heating elements off."),
            target = "thermal_gloves",
        },
    },
}

ccb.content.define_item {
    id = "thermal_mask",
    category = "clothing",
    symbol = "[",
    color = "light_gray",
    name = ccb.content.plural_text("thermal electric balaclava", "thermal electric balaclavas"),
    description = ccb.content.text("A snug cloth mask with internal battery-powered heating elements.  Use it to turn it on."),
    flags = { "VARSIZE", "SKINTIGHT" },
    price = "50 USD",
    survival_price = "2 USD 50 cent",
    materials = { "cotton" },
    mass = "196 g",
    volume = "1 L",
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
        warmth = 10,
        thickness = 0.3,
        portions = { { coverage = 100, covers = { "head", "mouth" } } },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You turn the heating elements on."),
            target = "thermal_mask_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}

ccb.content.define_item {
    id = "thermal_mask_on",
    copy_from = "thermal_mask",
    name = ccb.content.plural_text("thermal electric balaclava (on)", "thermal electric balaclavas (on)"),
    description = ccb.content.text("A snug cloth mask with internal battery-powered heating elements.  It is are currently on, and continually draining batteries.  Use it to turn it off."),
    flags = { "VARSIZE", "SKINTIGHT", "TRADER_AVOID", "SPAWN_ACTIVE" },
    revert_to = "thermal_mask",
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "400 mW" },
    armor = { warmth = 60 },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You turn the heating elements off."),
            target = "thermal_mask",
        },
    },
}
