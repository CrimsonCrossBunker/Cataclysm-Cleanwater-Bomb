local ccb = require("ccb")

ccb.content.define_item {
    id = "powered_earmuffs",
    category = "armor",
    symbol = "[",
    color = "blue",
    name = ccb.content.plural_text("shooter's earmuffs", "shooter's earmuffs"),
    description = ccb.content.text("A pair of earmuffs favored by shooters.  Without batteries or when turned off, they function like normal earmuffs and block all sound.  They will only block sounds over a certain decibel amount when turned on, to protect your ears from injury while otherwise allowing you to hear normally.  The earmuffs are currently off."),
    flags = { "DEAF", "OVERSIZE", "BELTED", "ALLOWS_NATURAL_ATTACKS", "WATER_BREAK", "ELECTRONIC" },
    faults = { { group = "electronic_general" } },
    price = "125 USD",
    survival_price = "7 USD 50 cent",
    materials = { "plastic" },
    mass = "179 g",
    volume = "1 L",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_LIGHT", "BATTERY_ULTRA_LIGHT" },
            default_magazine = "light_battery_cell",
        },
    },
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 1, ammo_types = "battery" },
    armor = {
        warmth = 5,
        thickness = 2,
        portions = {
            {
                encumbrance = 5,
                coverage = 100,
                covers = { "head" },
                subparts = { "head_ear_r", "head_ear_l" },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You turn on the %s."),
            target = "powered_earmuffs_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}

-- 3M Peltors claim to go 100 hours on 2 AAs
ccb.content.define_item {
    id = "powered_earmuffs_on",
    category = "armor",
    symbol = "[",
    color = "blue",
    name = ccb.content.plural_text("shooter's earmuffs (on)", "shooter's earmuffs (on)"),
    description = ccb.content.text("A pair of earmuffs favored by shooters.  The earmuffs are turned on, and will block sounds over a certain decibel amount while otherwise allowing you to hear normally."),
    flags = {
        "OVERSIZE", "BELTED", "ALLOWS_NATURAL_ATTACKS", "PARTIAL_DEAF", "WATER_BREAK", "ELECTRONIC",
        "SPAWN_ACTIVE",
    },
    faults = { { group = "electronic_general" } },
    price = "125 USD",
    survival_price = "7 USD 50 cent",
    materials = { "plastic" },
    mass = "179 g",
    volume = "1 L",
    revert_to = "powered_earmuffs",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_LIGHT", "BATTERY_ULTRA_LIGHT" },
            default_magazine = "light_battery_cell",
        },
    },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "60 mW", charges_per_use = 1, ammo_types = "battery" },
    armor = {
        warmth = 5,
        thickness = 2,
        portions = {
            {
                encumbrance = 5,
                coverage = 100,
                covers = { "head" },
                subparts = { "head_ear_r", "head_ear_l" },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You turn off the %s."),
            target = "powered_earmuffs",
        },
    },
}

ccb.content.define_item {
    id = "powered_earplugs",
    category = "armor",
    symbol = "[",
    color = "blue",
    name = ccb.content.plural_text("shooter's ear plugs", "shooter's ear plugs"),
    description = ccb.content.text("A pair of in-ear drivers designed to dampen loud sounds.  Without batteries or when turned off, they function like normal earplugs and block most sound.  They will only block sounds over a certain decibel amount when turned on, to protect your ears from injury while otherwise allowing you to hear normally.  The earplugs are currently off."),
    flags = { "DEAF", "OVERSIZE", "USE_UPS", "NO_UNLOAD", "NO_RELOAD", "WATER_BREAK", "ELECTRONIC" },
    faults = { { group = "electronic_general" } },
    price = "125 USD",
    survival_price = "12 USD 50 cent",
    materials = { "plastic" },
    mass = "20 g",
    volume = "200 ml",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 10 } } },
    subtype_order = { "tool", "armor" },
    tool = { ammo_types = "battery" },
    armor = { thickness = 1 },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You turn on the %s."),
            target = "powered_earplugs_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}

-- same power draw as the earmuffs, much smaller internal battery
ccb.content.define_item {
    id = "powered_earplugs_on",
    copy_from = "powered_earplugs",
    symbol = "[",
    color = "blue",
    name = ccb.content.plural_text("shooter's ear plugs (on)", "shooter's ear plugs (on)"),
    description = ccb.content.text("A pair of in-ear drivers designed to dampen loud sounds.  The earplugs are turned on, and will block sounds over a certain decibel amount while otherwise allowing you to hear normally."),
    flags = { "OVERSIZE", "PARTIAL_DEAF", "USE_UPS", "NO_UNLOAD", "NO_RELOAD", "SPAWN_ACTIVE" },
    revert_to = "powered_earplugs",
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "60 mW" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You turn off the %s."),
            target = "powered_earplugs",
        },
    },
}

ccb.content.define_item {
    id = "stethoscope",
    symbol = "y",
    color = "dark_gray",
    name = ccb.content.plural_text("stethoscope", "stethoscopes"),
    description = ccb.content.text("A medical listening tool.  Use it to listen to things.  Closely."),
    price = "40 USD",
    survival_price = "5 USD",
    materials = { "plastic", "aluminum" },
    mass = "150 g",
    volume = "250 ml",
    flags = { "BELTED", "SAFECRACK" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        portions = { { encumbrance = 1, coverage = 50, covers = { "torso" }, subparts = { "torso_neck" } } },
    },
}

ccb.content.define_item {
    id = "makeshift_stethoscope",
    symbol = "y",
    color = "dark_gray",
    name = ccb.content.plural_text("makeshift stethoscope", "makeshift stethoscopes"),
    description = ccb.content.text("A relatively cumbersome DIY child's medical listening toy.  Use it to listen to things.  Closely."),
    price = "5 USD",
    survival_price = "1 USD",
    materials = { "plastic" },
    mass = "400 g",
    volume = "500 ml",
    flags = { "BELTED", "SAFECRACK" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        portions = { { encumbrance = 3, coverage = 40, covers = { "torso" }, subparts = { "torso_neck" } } },
    },
}

ccb.content.define_item {
    id = "helmet_riot",
    category = "armor",
    name = ccb.content.plural_text("riot helmet", "riot helmets"),
    description = ccb.content.text("A riot helmet with a plastic face shield that covers your entire face.  Activate to raise the face shield."),
    mass = "1450 g",
    volume = "2250 ml",
    price = "220 USD",
    survival_price = "10 USD",
    accuracy = { grip = "bad", length = "short", surface = "any", balance = "uneven" },
    materials = { "plastic", "thermo_resin" },
    symbol = "[",
    color = "dark_gray",
    techniques = { "WBLOCK_1" },
    flags = { "WATERPROOF", "STURDY", "PADDED" },
    melee_damage = { bash = 8 },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        warmth = 15,
        portions = {
            {
                materials = {
                    { id = "plastic", coverage = 100, thickness = 2.0 },
                    { id = "thermo_resin", coverage = 100, thickness = 1.0 },
                },
                covers = { "head" },
                subparts = { "head_crown", "head_forehead", "head_nape", "head_ear_r", "head_ear_l" },
                coverage = 100,
                encumbrance_modifiers = { "NONE" },
            },
            {
                materials = {
                    { id = "plastic", coverage = 100, thickness = 2.0 },
                    { id = "thermo_resin", coverage = 100, thickness = 1.0 },
                },
                covers = { "eyes" },
                rigid_only = true,
                coverage = 100,
                encumbrance = 5,
                layers = { "OUTER" },
            },
            {
                materials = {
                    { id = "plastic", coverage = 100, thickness = 2.0 },
                    { id = "thermo_resin", coverage = 100, thickness = 1.0 },
                },
                covers = { "mouth" },
                rigid_only = true,
                coverage = 100,
                encumbrance = 2,
                layers = { "OUTER" },
            },
        },
        environmental_protection = 2,
    },
    use_actions = {
        {
            kind = "transform",
            target = "helmet_riot_raised",
            menu_text = ccb.content.text("Raise visor"),
            message = ccb.content.text("You raise your visor."),
        },
    },
}

ccb.content.define_item {
    id = "helmet_riot_raised",
    category = "armor",
    name = ccb.content.plural_text("riot helmet (raised visor)", "riot helmets (raised visor)"),
    description = ccb.content.text("A riot helmet with a plastic face shield, which is raised up.  Activate to lower the shield."),
    mass = "1450 g",
    volume = "2250 ml",
    price = "220 USD",
    survival_price = "10 USD",
    accuracy = { grip = "bad", length = "short", surface = "any", balance = "uneven" },
    materials = { "plastic", "thermo_resin" },
    symbol = "[",
    color = "dark_gray",
    techniques = { "WBLOCK_1" },
    flags = { "WATERPROOF", "STURDY", "PADDED" },
    melee_damage = { bash = 6 },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        warmth = 15,
        portions = {
            {
                materials = {
                    { id = "plastic", coverage = 100, thickness = 2.0 },
                    { id = "thermo_resin", coverage = 100, thickness = 1.0 },
                },
                covers = { "head" },
                subparts = { "head_crown", "head_forehead", "head_nape", "head_ear_r", "head_ear_l" },
                coverage = 100,
                encumbrance_modifiers = { "NONE" },
            },
        },
        environmental_protection = 2,
    },
    use_actions = {
        {
            kind = "transform",
            target = "helmet_riot",
            menu_text = ccb.content.text("Lower visor"),
            message = ccb.content.text("You put down your visor."),
        },
    },
}
