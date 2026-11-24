local ccb = require("ccb")

-- hands are lighter armored
-- feet are heavier armored
-- limbs are lighter armored than torso but still strongly armored this is the non joints so extra hardsteel
ccb.content.define_item {
    id = "phase_immersion_suit",
    category = "clothing",
    symbol = "[",
    color = "light_gray",
    name = ccb.content.plural_text("phase immersion suit", "phase immersion suits"),
    looks_like = "rm13_armor",
    description = ccb.content.text("Covered in interlocking plates of reflective metal, this advanced suit resembles both plate armor and an astronaut's spacesuit.  Designed to protect its wearer during extradimensional excursions, it offers unparalleled environmental protection, both in this Earth and beyond.  Use it to turn it on."),
    price = "1 kUSD 500 USD",
    survival_price = "150 USD",
    materials = { "carbide", "qt_steel", "lvl4ballisticglass", "superalloy" },
    mass = "9550 g",
    volume = "4050 ml",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 5000 } } },
    flags = {
        "RAD_PROOF", "STURDY", "WATERPROOF", "RAINPROOF", "NO_REPAIR", "NANOFAB_REPAIR", "PADDED",
        "USE_UPS", "NO_UNLOAD", "COMBAT_TOGGLEABLE", "UNBREAKABLE_MELEE",
    },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { ammo_types = "battery" },
    armor = {
        warmth = 30,
        environmental_protection = 10,
        thickness = 3,
        portions = {
            {
                materials = {
                    { id = "carbide", coverage = 100, thickness = 1.0 },
                    { id = "qt_steel", coverage = 80, thickness = 1.0 },
                    { id = "superalloy", coverage = 40, thickness = 1.0 },
                    { id = "superalloy", coverage = 40, thickness = 1.0 },
                },
                encumbrance = 10,
                coverage = 100,
                covers = { "torso" },
                volume_encumbrance = 0,
            },
            {
                materials = {
                    { id = "carbide", coverage = 100, thickness = 1.0 },
                    { id = "qt_steel", coverage = 60, thickness = 1.0 },
                },
                encumbrance = 5,
                coverage = 100,
                covers = { "hand_l", "hand_r" },
                volume_encumbrance = 0,
            },
            {
                materials = {
                    { id = "carbide", coverage = 100, thickness = 1.0 },
                    { id = "qt_steel", coverage = 80, thickness = 3.0 },
                },
                encumbrance = 10,
                coverage = 100,
                covers = { "foot_l", "foot_r" },
                layers = { "NORMAL", "OUTER" },
                volume_encumbrance = 0,
            },
            {
                materials = {
                    { id = "carbide", coverage = 100, thickness = 1.0 },
                    { id = "qt_steel", coverage = 75, thickness = 0.5 },
                    { id = "superalloy", coverage = 40, thickness = 0.5 },
                    { id = "superalloy", coverage = 40, thickness = 0.5 },
                },
                encumbrance = 10,
                coverage = 100,
                covers = { "arm_l", "arm_r", "leg_l", "leg_r" },
                volume_encumbrance = 0,
            },
        },
    },
    artifact = { enchantments = { "ench_climate_control_all" } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("Initiating\nRunning suit integrity diagnostics…\nAll systems operational."),
            target = "phase_immersion_suit_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("Warning: Operating on minimal power.  Protection compromised."),
        },
    },
}

ccb.content.define_item {
    id = "phase_immersion_suit_on",
    copy_from = "phase_immersion_suit",
    name = ccb.content.plural_text("phase immersion suit (on)", "phase immersion suits (on)"),
    looks_like = "phase_immersion_suit",
    description = ccb.content.text("Covered in interlocking plates of reflective metal, this advanced suit resembles both plate armor and an astronaut's spacesuit.  It is turned on, and continually draining power.  Use it to turn it off."),
    revert_to = "phase_immersion_suit",
    flags = {
        "RAD_PROOF", "PORTAL_PROOF", "STURDY", "WATERPROOF", "RAINPROOF", "ELECTRIC_IMMUNE", "GAS_PROOF",
        "TRADER_AVOID", "NO_REPAIR", "NANOFAB_REPAIR", "PADDED", "USE_UPS", "NO_UNLOAD",
        "COMBAT_TOGGLEABLE", "UNBREAKABLE_MELEE", "SPAWN_ACTIVE", "SCBA",
    },
    subtype_order = { "tool", "armor" },
    tool = { turns_per_charge = 50 },
    armor = { environmental_protection = 80 },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("Suit shutting down."),
            target = "phase_immersion_suit",
        },
    },
}

ccb.content.define_item {
    id = "phase_immersion_helmet",
    category = "clothing",
    symbol = "[",
    color = "light_gray",
    name = ccb.content.plural_text("phase immersion helmet", "phase immersion helmets"),
    description = ccb.content.text("This advanced headpiece resembles an astronaut's helmet.  Designed to protect its wearer during extradimensional excursions, it offers unparalleled environmental protection, both in this Earth and beyond.  It has tubes to connect to a powered air-purifying respirator (PAPR), and a regulator to connect to an external air source (such as a SCUBA tank)."),
    price = "1 kUSD 500 USD",
    survival_price = "150 USD",
    materials = { "aluminum", "qt_steel", "lvl4ballisticglass" },
    mass = "950 g",
    volume = "450 ml",
    pockets = {
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            capacity = "1600 ml",
            mass_limit = "800 g",
            max_item_length = "14 cm",
            moves = 200,
            description = ccb.content.text("Attachment points for a floating Communications Carrier Assembly (CCA)."),
            inherits_flags = true,
            allowed_items = { "phase_immersion_cca", "phase_immersion_cca_on" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            capacity = "300 ml",
            mass_limit = "500 g",
            max_item_length = "14 cm",
            moves = 100,
            description = ccb.content.text("External clips for a flashlight."),
            allowed_flags = { "HELMET_HEAD_ATTACHMENT" },
            transparent = true,
        },
    },
    flags = {
        "RAD_PROOF", "STURDY", "WATERPROOF", "RAINPROOF", "SWIM_GOGGLES", "SUN_GLASSES", "PADDED",
        "UNBREAKABLE_MELEE", "PSYSHIELD_PARTIAL", "SCBA",
    },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {
        warmth = 30,
        environmental_protection = 10,
        filtered_protection = 80,
        thickness = 3,
        portions = {
            {
                materials = { { id = "lvl4ballisticglass", coverage = 100, thickness = 1.0 } },
                encumbrance = 5,
                coverage = 100,
                covers = { "mouth", "eyes" },
                layers = { "OUTER" },
                volume_encumbrance = 0,
            },
            {
                materials = {
                    { id = "aluminum", coverage = 60, thickness = 1.0 },
                    { id = "qt_steel", coverage = 30, thickness = 1.0 },
                    { id = "lvl4ballisticglass", coverage = 100, thickness = 1.0 },
                },
                encumbrance = 10,
                coverage = 100,
                covers = { "head" },
                layers = { "OUTER" },
                volume_encumbrance = 0,
            },
        },
    },
    artifact = {},
    use_actions = {
        "PAPR_MASK_ACTIVATE",
        "SCBA_MASK_ACTIVATE",
        {
            kind = "transform",
            message = ccb.content.text("You raise your face shield."),
            menu_text = ccb.content.text("Raise face shield"),
            target = "phase_immersion_helmet_raised",
        },
    },
    tick_actions = { "PAPR_MASK" },
}

ccb.content.define_item {
    id = "phase_immersion_helmet_raised",
    category = "clothing",
    symbol = "[",
    color = "light_gray",
    name = ccb.content.plural_text("phase immersion helmet (raised)", "phase immersion helmets (raised)"),
    description = ccb.content.text("This advanced headpiece resembles an astronaut's helmet.  Designed to protect its wearer during extradimensional excursions, it offers unparalleled environmental protection, both in this Earth and beyond.  The face shield is raised.  Activate it to lower the face shield."),
    price = "1 kUSD 500 USD",
    survival_price = "150 USD",
    materials = { "aluminum", "qt_steel", "lvl4ballisticglass" },
    mass = "950 g",
    volume = "450 ml",
    pockets = {
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            capacity = "1600 ml",
            mass_limit = "800 g",
            max_item_length = "14 cm",
            ablative = true,
            moves = 200,
            description = ccb.content.text("Attachment points for a floating Communications Carrier Assembly (CCA)."),
            inherits_flags = true,
            allowed_items = { "phase_immersion_cca", "phase_immersion_cca_on" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            capacity = "300 ml",
            mass_limit = "500 g",
            max_item_length = "14 cm",
            moves = 100,
            description = ccb.content.text("External clips for a flashlight."),
            allowed_flags = { "HELMET_HEAD_ATTACHMENT" },
            transparent = true,
        },
    },
    flags = { "RAD_PROOF", "STURDY", "WATERPROOF", "RAINPROOF", "PADDED", "PSYSHIELD_PARTIAL" },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {
        warmth = 15,
        thickness = 3,
        environmental_protection = 4,
        portions = {
            {
                materials = {
                    { id = "aluminum", coverage = 60, thickness = 1.0 },
                    { id = "qt_steel", coverage = 30, thickness = 1.0 },
                    { id = "lvl4ballisticglass", coverage = 100, thickness = 2.0 },
                },
                encumbrance = 10,
                coverage = 100,
                covers = { "head" },
                layers = { "OUTER" },
                volume_encumbrance = 0,
            },
        },
    },
    artifact = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower your face shield."),
            menu_text = ccb.content.text("Lower face shield"),
            target = "phase_immersion_helmet",
        },
    },
}

ccb.content.define_item {
    id = "phase_immersion_helmet_scba_on",
    category = "clothing",
    symbol = "[",
    color = "light_gray",
    name = ccb.content.plural_text("phase immersion helmet (SCBA)", "phase immersion helmets (SCBA)"),
    description = ccb.content.text("This advanced headpiece resembles an astronaut's helmet.  Designed to protect its wearer during extradimensional excursions, it offers unparalleled environmental protection, both in this Earth and beyond.  Its SCBA system is currently engaged.  Activate it to turn it off."),
    copy_from = "phase_immersion_helmet",
    revert_to = "phase_immersion_helmet",
    flags = {
        "RAD_PROOF", "STURDY", "WATERPROOF", "RAINPROOF", "SWIM_GOGGLES", "SUN_GLASSES", "PADDED",
        "UNBREAKABLE_MELEE", "PSYSHIELD_PARTIAL", "SPAWN_ACTIVE", "SCBA_ON",
    },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = { environmental_protection = 80 },
    artifact = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You turn off the SCBA system."),
            menu_text = ccb.content.text("Turn off the SCBA system"),
            target = "phase_immersion_helmet",
        },
    },
    tick_actions = { "SCBA_MASK" },
}

-- floating, attached to helmet
-- floating, attached to helmet
ccb.content.define_item {
    id = "phase_immersion_cca",
    name = ccb.content.plural_text("phase immersion CCA", "phase immersion CCAs"),
    description = ccb.content.text("A DARPA Communications Carrier Assembly - a bundle of electronics, including a battery, microphone, headphones with active noise suppression, and slimmed down ground panoramic night vision goggles.  The assembly cannot be worn on its own - it must be attached to an appropriate helmet.  Activate it to turn it on."),
    mass = "800 g",
    volume = "1600 ml",
    price = "80 kUSD",
    survival_price = "150 USD",
    materials = { "plastic", "glass", "steel" },
    symbol = "[",
    color = "dark_gray",
    flags = { "CANT_WEAR", "ELECTRONIC", "WATERPROOF", "USE_UPS", "NO_UNLOAD" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 2000 } } },
    faults = { { group = "electronic_general" } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        portions = {
            { covers = { "eyes" }, coverage = 10, encumbrance = 0, rigid_only = true },
            { covers = { "head" }, encumbrance = 0, coverage = 80 },
        },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("Initiating\nRunning CCA integrity diagnostics…\nAll systems operational."),
            target = "phase_immersion_cca_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("Warning: Low power."),
        },
    },
}

-- floating, attached to helmet
-- floating, attached to helmet
ccb.content.define_item {
    id = "phase_immersion_cca_on",
    copy_from = "phase_immersion_cca",
    name = ccb.content.plural_text("phase immersion CCA (on)", "phase immersion CCAs (on)"),
    description = ccb.content.text("A DARPA communications carrier assembly - a bundle of electronics, including a battery, microphone, headphones with active noise suppression, and slimmed down ground panoramic night vision goggles.  The assembly cannot be worn on its own.  It must be attached to an appropriate helmet.  Activate it to turn it off."),
    revert_to = "phase_immersion_cca",
    inheritance = {
        add = {
            flags = {
                "GNV_EFFECT", "SPAWN_ACTIVE", "HYGROMETER", "THERMOMETER", "WATCH", "ALARMCLOCK",
                "PARTIAL_DEAF", "TWO_WAY_RADIO",
            },
        },
    },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "360 mW" },
    armor = {
        portions = {
            { covers = { "eyes" }, coverage = 10, encumbrance = 15, rigid_only = true },
            { covers = { "head" }, encumbrance = 0, coverage = 80 },
        },
    },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You deactivate your %s."),
            target = "phase_immersion_cca",
        },
    },
}
