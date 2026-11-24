local ccb = require("ccb")

ccb.content.define_item {
    id = "arm_splint",
    name = ccb.content.text("arm splint"),
    description = ccb.content.text("A tool to help set arm bones and hold them in place."),
    mass = "300 g",
    volume = "1 L",
    price = "200 USD",
    survival_price = "50 cent",
    materials = { "wood", "cotton" },
    symbol = "[",
    looks_like = "armguard_hard",
    color = "white",
    flags = { "WATER_FRIENDLY", "OUTER", "SPLINT" },
    armor = {
        sided = true,
        warmth = 8,
        thickness = 1,
        portions = { { encumbrance = 70, coverage = 75, covers = { "arm_l", "arm_r" } } },
    },
}

ccb.content.define_item {
    id = "arm_xlsplint",
    name = ccb.content.text("arm splint"),
    description = ccb.content.text("A tool to help set arm bones and hold them in place.  It is specifically designed to fit Huge survivors."),
    copy_from = "arm_splint",
    looks_like = "arm_splint",
    mass = "600 g",
    volume = "2 L",
    price = "250 USD",
    survival_price = "50 cent",
    materials = { "wood", "cotton" },
    flags = { "OVERSIZE", "PREFIX_XL", "WATER_FRIENDLY", "OUTER", "SPLINT" },
    armor = {},
}

ccb.content.define_item {
    id = "arm_xs_splint",
    name = ccb.content.text("arm splint"),
    description = ccb.content.text("A tool to help set arm bones and hold them in place.  It is specifically designed to fit Tiny survivors."),
    copy_from = "arm_splint",
    looks_like = "arm_splint",
    mass = "150 g",
    volume = "500 ml",
    price = "150 USD",
    survival_price = "50 cent",
    flags = { "UNDERSIZE", "PREFIX_XS", "WATER_FRIENDLY", "OUTER", "SPLINT" },
    armor = {},
}

ccb.content.define_item {
    id = "tourniquet_upper",
    name = ccb.content.plural_text("tourniquet (arm)", "tourniquets (arm)"),
    description = ccb.content.text("A first aid device used to apply pressure to a limb or extremity in order to limit blood flow.  Should be employed only to manage heavy bleeding, because prolonged use will harm the limb.  It can be adjusted in size to fit different limbs."),
    mass = "200 g",
    volume = "300 ml",
    price = "200 USD",
    survival_price = "50 cent",
    materials = { "wood", "cotton" },
    symbol = "{",
    looks_like = "armguard_hard",
    color = "red",
    flags = { "WATER_FRIENDLY", "OUTER", "TOURNIQUET" },
    armor = {
        sided = true,
        warmth = 0,
        thickness = 1,
        portions = { { encumbrance = 70, coverage = 10, covers = { "arm_l", "arm_r" } } },
    },
    use_actions = {
        {
            kind = "transform",
            target = "tourniquet_upper_XL",
            message = ccb.content.text("You adjust the tourniquet."),
            menu_text = ccb.content.text("Adjust"),
        },
    },
}

ccb.content.define_item {
    id = "tourniquet_upper_XL",
    name = ccb.content.plural_text("tourniquet (arm)", "tourniquets (arm)"),
    description = ccb.content.text("A first aid device used to apply pressure to a limb or extremity in order to limit blood flow.  Should be employed only to manage heavy bleeding, because prolonged use will harm the limb.  It can be adjusted in size to fit different limbs."),
    copy_from = "tourniquet_upper",
    looks_like = "tourniquet_upper",
    flags = { "WATER_FRIENDLY", "OUTER", "TOURNIQUET", "OVERSIZE", "PREFIX_XL" },
    armor = { sided = true },
    use_actions = {
        {
            kind = "transform",
            target = "tourniquet_upper_XS",
            message = ccb.content.text("You adjust the tourniquet."),
            menu_text = ccb.content.text("Adjust"),
        },
    },
}

ccb.content.define_item {
    id = "tourniquet_upper_XS",
    name = ccb.content.plural_text("tourniquet (arm)", "tourniquets (arm)"),
    description = ccb.content.text("A first aid device used to apply pressure to a limb or extremity in order to limit blood flow.  Should be employed only to manage heavy bleeding, because prolonged use will harm the limb.  It can be adjusted in size to fit different limbs."),
    copy_from = "tourniquet_upper",
    looks_like = "tourniquet_upper",
    flags = { "WATER_FRIENDLY", "OUTER", "TOURNIQUET", "UNDERSIZE", "PREFIX_XS" },
    armor = { covers = { "arm_l", "arm_r" }, sided = true },
    use_actions = {
        {
            kind = "transform",
            target = "tourniquet_lower",
            message = ccb.content.text("You adjust the tourniquet."),
            menu_text = ccb.content.text("Adjust"),
        },
    },
}

ccb.content.define_item {
    id = "tourniquet_lower",
    name = ccb.content.plural_text("tourniquet (leg)", "tourniquets (leg)"),
    description = ccb.content.text("A first aid device used to apply pressure to a limb or extremity in order to limit blood flow.  Should be employed only to manage heavy bleeding, because prolonged use will harm the limb.  It can be adjusted in size to fit different limbs."),
    copy_from = "tourniquet_upper",
    looks_like = "tourniquet_upper",
    materials = { "wood", "cotton" },
    flags = { "WATER_FRIENDLY", "OUTER", "TOURNIQUET", "ALLOWS_TAIL" },
    armor = {
        sided = true,
        portions = { { encumbrance = 70, coverage = 10, covers = { "leg_l", "leg_r" } } },
    },
    use_actions = {
        {
            kind = "transform",
            target = "tourniquet_lower_XL",
            message = ccb.content.text("You adjust the tourniquet."),
            menu_text = ccb.content.text("Adjust"),
        },
    },
}

ccb.content.define_item {
    id = "tourniquet_lower_XL",
    name = ccb.content.plural_text("tourniquet (leg)", "tourniquets (leg)"),
    description = ccb.content.text("A first aid device used to apply pressure to a limb or extremity in order to limit blood flow.  Should be employed only to manage heavy bleeding, because prolonged use will harm the limb.  It can be adjusted in size to fit different limbs."),
    copy_from = "tourniquet_lower",
    looks_like = "tourniquet_lower",
    flags = { "WATER_FRIENDLY", "OUTER", "TOURNIQUET", "OVERSIZE", "PREFIX_XL", "ALLOWS_TAIL" },
    armor = { sided = true },
    use_actions = {
        {
            kind = "transform",
            target = "tourniquet_lower_XS",
            message = ccb.content.text("You adjust the tourniquet."),
            menu_text = ccb.content.text("Adjust"),
        },
    },
}

ccb.content.define_item {
    id = "tourniquet_lower_XS",
    name = ccb.content.plural_text("tourniquet (leg)", "tourniquets (leg)"),
    description = ccb.content.text("A first aid device used to apply pressure to a limb or extremity in order to limit blood flow.  Should be employed only to manage heavy bleeding, because prolonged use will harm the limb.  It can be adjusted in size to fit different limbs."),
    copy_from = "tourniquet_lower",
    looks_like = "tourniquet_lower",
    flags = { "WATER_FRIENDLY", "OUTER", "TOURNIQUET", "UNDERSIZE", "PREFIX_XS", "ALLOWS_TAIL" },
    armor = { sided = true },
    use_actions = {
        {
            kind = "transform",
            target = "tourniquet_upper",
            message = ccb.content.text("You adjust the tourniquet."),
            menu_text = ccb.content.text("Adjust"),
        },
    },
}

ccb.content.define_item {
    id = "makeshift_blindfold",
    name = ccb.content.plural_text("makeshift blindfold", "makeshift blindfolds"),
    description = ccb.content.text("A crude eye covering woven from blades of grass with string attached to fasten it.  Useful for sleeping in bright areas.  Use to raise it."),
    mass = "32 g",
    volume = "200 ml",
    price = "5 cent",
    survival_price = "1 cent",
    materials = { "dry_plant" },
    symbol = "[",
    looks_like = "blindfold",
    color = "yellow",
    flags = { "BLIND" },
    armor = {
        warmth = 0,
        thickness = 0.1,
        environmental_protection = 0,
        portions = { { encumbrance = 10, coverage = 95, covers = { "eyes" } } },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You uncover your eyes."),
            target = "makeshift_blindfold_up",
            menu_text = ccb.content.text("Raise"),
        },
    },
}

ccb.content.define_item {
    id = "makeshift_blindfold_up",
    name = ccb.content.plural_text("makeshift blindfold (raised)", "makeshift blindfolds (raised)"),
    description = ccb.content.text("A crude eye covering woven from blades of grass with string attached to fasten it.  It's currently raised, letting you see.  Use to lower it."),
    mass = "32 g",
    volume = "200 ml",
    price = "5 cent",
    survival_price = "1 cent",
    materials = { "dry_plant" },
    symbol = "[",
    looks_like = "blindfold",
    color = "yellow",
    armor = {
        warmth = 0,
        thickness = 0.1,
        environmental_protection = 0,
        portions = { { encumbrance = 10, coverage = 95, covers = { "head" } } },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You cover your eyes."),
            target = "makeshift_blindfold",
            menu_text = ccb.content.text("Lower"),
        },
    },
}

-- A folded bandana still takes up some space on the head.
ccb.content.define_item {
    id = "blindfold",
    name = ccb.content.plural_text("blindfold", "blindfolds"),
    description = ccb.content.text("A simple fabric covering tied over the eyes to block sight.  Useful for sleeping in bright areas.  Use to raise it."),
    mass = "50 g",
    volume = "100 ml",
    price = "6 USD",
    survival_price = "10 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "scarf",
    color = "dark_gray",
    flags = { "BLIND" },
    armor = {
        warmth = 5,
        thickness = 0.1,
        environmental_protection = 1,
        portions = { { encumbrance = 10, coverage = 95, covers = { "eyes" } } },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You uncover your eyes."),
            target = "blindfold_up",
            menu_text = ccb.content.text("Raise"),
        },
    },
}

ccb.content.define_item {
    id = "blindfold_up",
    name = ccb.content.plural_text("blindfold (raised)", "blindfolds (raised)"),
    description = ccb.content.text("A simple fabric covering tied over the eyes to block sight.  It's currently raised, letting you see.  Use to lower it."),
    mass = "50 g",
    volume = "100 ml",
    price = "6 USD",
    survival_price = "10 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "scarf",
    color = "dark_gray",
    armor = {
        warmth = 5,
        thickness = 0.1,
        environmental_protection = 1,
        portions = { { encumbrance = 10, coverage = 95, covers = { "head" } } },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You cover your eyes."),
            target = "blindfold",
            menu_text = ccb.content.text("Lower"),
        },
    },
}

-- A folded bandana still takes up some space on the head.
ccb.content.define_item {
    id = "blindfold_duct",
    name = ccb.content.plural_text("duct tape blindfold", "duct tape blindfolds"),
    description = ccb.content.text("A simple covering tied over the eyes to block sight, made out of duct tape.  Useful for sleeping in bright areas.  Use to raise it."),
    mass = "20 g",
    volume = "60 ml",
    price = "10 cent",
    survival_price = "5 cent",
    materials = { "plastic" },
    symbol = "[",
    looks_like = "blindfold",
    color = "dark_gray",
    flags = { "BLIND", "SKINTIGHT" },
    armor = {
        warmth = 0,
        thickness = 1,
        environmental_protection = 1,
        portions = { { encumbrance = 10, coverage = 95, covers = { "eyes" }, rigid_only = true } },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You uncover your eyes."),
            target = "blindfold_duct_up",
            menu_text = ccb.content.text("Raise"),
        },
    },
}

ccb.content.define_item {
    id = "blindfold_duct_up",
    name = ccb.content.plural_text("duct tape blindfold (raised)", "duct tape blindfolds (raised)"),
    description = ccb.content.text("A simple covering tied over the eyes to block sight, made out of duct tape.  It's currently raised, letting you see.  Use to lower it."),
    mass = "20 g",
    volume = "60 ml",
    price = "10 cent",
    survival_price = "5 cent",
    materials = { "plastic" },
    symbol = "[",
    looks_like = "blindfold",
    color = "dark_gray",
    flags = { "SKINTIGHT" },
    armor = {
        warmth = 0,
        thickness = 1,
        environmental_protection = 1,
        portions = { { encumbrance = 10, coverage = 95, covers = { "head" }, rigid_only = true } },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You cover your eyes."),
            target = "blindfold_duct",
            menu_text = ccb.content.text("Lower"),
        },
    },
}

ccb.content.define_item {
    id = "ear_plugs",
    name = ccb.content.plural_text("ear plugs (pair)", "ear plugs (pair)"),
    description = ccb.content.text("Industrial-grade ear plugs.  They fit inside the ears."),
    mass = "10 g",
    volume = "10 ml",
    price = "10 cent",
    survival_price = "50 cent",
    materials = { "plastic" },
    symbol = ";",
    color = "light_gray",
    flags = { "DEAF", "OVERSIZE", "POWERARMOR_COMPATIBLE" },
    armor = { thickness = 1 },
}

ccb.content.define_item {
    id = "leg_splint",
    name = ccb.content.text("leg splint"),
    description = ccb.content.text("A tool to help set leg bones and hold them in place."),
    mass = "500 g",
    volume = "1 L",
    price = "200 USD",
    survival_price = "50 cent",
    materials = { "wood", "cotton" },
    symbol = "[",
    looks_like = "legguard_hard",
    color = "white",
    flags = { "WATER_FRIENDLY", "OUTER", "SPLINT", "ALLOWS_TAIL" },
    armor = {
        sided = true,
        warmth = 5,
        thickness = 1,
        portions = { { encumbrance = 70, coverage = 75, covers = { "leg_l", "leg_r" } } },
    },
}

ccb.content.define_item {
    id = "leg_xlsplint",
    name = ccb.content.text("leg splint"),
    description = ccb.content.text("A tool to help set leg bones and hold them in place.  It is specifically designed to fit Huge people."),
    copy_from = "leg_splint",
    mass = "1000 g",
    volume = "2 L",
    price = "250 USD",
    survival_price = "50 cent",
    materials = { "wood", "cotton" },
    flags = { "OVERSIZE", "PREFIX_XL", "WATER_FRIENDLY", "OUTER", "SPLINT", "ALLOWS_TAIL" },
    armor = {},
}

ccb.content.define_item {
    id = "leg_xs_splint",
    name = ccb.content.text("leg splint"),
    description = ccb.content.text("A tool to help set leg bones and hold them in place.  It is specifically designed to fit Tiny people."),
    copy_from = "leg_splint",
    mass = "250 g",
    volume = "500 ml",
    price = "250 USD",
    survival_price = "50 cent",
    flags = { "UNDERSIZE", "PREFIX_XS", "WATER_FRIENDLY", "OUTER", "SPLINT", "ALLOWS_TAIL" },
    armor = {},
}

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

ccb.content.define_item {
    id = "smart_watch",
    name = ccb.content.plural_text("smart watch", "smart watches"),
    category = "clothing",
    ascii_picture = "smart_watch",
    volume = "125 ml",
    description = ccb.content.text("A touchscreen watch that comes with many uses, such as a calendar, alarm, and even a fitness app, for when you want to check your health on the go!"),
    mass = "61 g",
    color = "light_gray",
    price = "100 USD",
    survival_price = "1 USD 50 cent",
    materials = { { id = "plastic", portions = 75 }, { id = "aluminum", portions = 25 } },
    flags = {
        "WATCH", "ALARMCLOCK", "BELTED", "FRAGILE", "ALLOWS_NATURAL_ATTACKS", "OVERSIZE", "USE_UPS",
        "NO_UNLOAD", "NO_RELOAD", "WATER_BREAK", "CALORIE_BURN", "ELECTRONIC",
    },
    faults = { { group = "electronic_general" } },
    symbol = "[",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 20 } } },
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
    use_actions = {
        "CALORIES_INTAKE_TRACKER",
        "FITNESS_CHECK",
        "PORTABLE_GAME",
        {
            kind = "mp3",
            target = "smart_watch_music",
            message = ccb.content.text("You put in the earbuds and start listening to music."),
            activate = true,
        },
    },
}

ccb.content.define_item {
    id = "smart_watch_music",
    copy_from = "smart_watch",
    name = ccb.content.plural_text("smart watch - music", "smart watches - music"),
    description = ccb.content.text("This smart watch is playing music, steadily raising your morale.  You can't hear anything else while you're listening."),
    revert_to = "smart_watch",
    inheritance = { add = { flags = { "TRADER_AVOID" } } },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "200 mW" },
    armor = {},
    use_actions = {
        "CALORIES_INTAKE_TRACKER",
        "FITNESS_CHECK",
        "PORTABLE_GAME",
        {
            kind = "mp3",
            target = "smart_watch",
            message = ccb.content.text("You stop listening to music and take your earbuds out."),
            activate = false,
        },
    },
    tick_actions = { "MP3_ON" },
}

ccb.content.define_item {
    id = "smart_watch_adv_music",
    copy_from = "smart_watch_adv",
    name = ccb.content.plural_text("advanced smart watch - music", "advanced smart watches - music"),
    description = ccb.content.text("This advanced smart watch is playing music, steadily raising your morale.  You can't hear anything else while you're listening."),
    revert_to = "smart_watch_adv",
    inheritance = { add = { flags = { "TRADER_AVOID" } } },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "200 mW" },
    armor = {},
    use_actions = {
        "E_FILE_DEVICE",
        "EBOOKSAVE",
        "CAMERA",
        "CALORIES_INTAKE_TRACKER",
        "FITNESS_CHECK",
        "PORTABLE_GAME",
        {
            kind = "mp3",
            target = "smart_watch_adv",
            message = ccb.content.text("You stop listening to music and take your earbuds out."),
            activate = false,
        },
        { kind = "link_up", cable_length = 3, charge_rate = "20 W" },
    },
    tick_actions = { "MP3_ON" },
}

ccb.content.define_item {
    id = "smart_watch_adv",
    copy_from = "smart_watch",
    name = ccb.content.plural_text("advanced smart watch", "advanced smart watches"),
    description = "A touchscreen watch that comes with many uses, such as a calendar, alarm, and even a fitness app, for when you want to check your health on the go!  This is a more expensive model, featuring a shock-resistant and waterproof case and a bunch of additional sensors.",
    price = "700 USD",
    survival_price = "10 USD",
    e_port = "phone",
    e_ports_banned = { "USB-A", "memory card", "camera" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            ammunition = { battery = 30 },
        },
        {
            kind = "E_FILE_STORAGE",
            capacity = "1 ml",
            mass_limit = "1 g",
            memory_capacity = "64 GB",
            weight_multiplier = 0,
            rigid = true,
        },
    },
    use_actions = {
        "E_FILE_DEVICE",
        "EBOOKSAVE",
        "CAMERA",
        "CALORIES_INTAKE_TRACKER",
        "FITNESS_CHECK",
        "WEATHER_TOOL",
        "PORTABLE_GAME",
        {
            kind = "mp3",
            target = "smart_watch_adv_music",
            activate = true,
            message = "You put in the earbuds and start listening to music.",
        },
        { kind = "link_up", charge_rate = "20 W", cable_length = 3 },
    },
    tool = { transfer_rate = "30 MB" },
    armor = {},
    subtype_order = { "tool", "armor" },
    inheritance = {
        add = {
            flags = { "WATER_FRIENDLY", "THERMOMETER", "HYGROMETER", "BAROMETER", "CAN_USE_IN_DARK" },
        },
        remove = {
            flags = { "WATER_BREAK", "FRAGILE" },
        },
    },
}

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

-- Based on https://www.amazon.com/dp/B0798Q79RV
ccb.content.define_item {
    id = "binoculars",
    category = "tools",
    symbol = ";",
    color = "dark_gray",
    name = ccb.content.plural_text("binoculars", "binoculars"),
    description = ccb.content.text("A pair of optics with a neck strap attached.  Useful for seeing long distances.  Wearing this item or carrying it in your inventory will double the distance around you that is mapped during your travels.  You could also use them to focus the sunlight."),
    price = "34 USD",
    survival_price = "5 USD",
    materials = { { id = "plastic", portions = 9 }, { id = "glass" } },
    flags = { "ZOOM", "OVERSIZE", "BELTED", "ALLOWS_NATURAL_ATTACKS", "FIRESTARTER" },
    mass = "550 g",
    volume = "540 ml",
    length = "15 cm",
    accuracy = { grip = "solid", length = "hand", surface = "any", balance = "uneven" },
    melee_damage = { bash = 3 },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        thickness = 2,
        portions = {
            {
                encumbrance = 2,
                coverage = 25,
                covers = { "torso" },
                subparts = { "torso_hanging_front" },
            },
        },
    },
    use_actions = { { kind = "firestarter", moves = 1000, slow_moves = 25000, need_sunlight = true } },
}

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

ccb.content.define_item {
    id = "ar_glasses_basic",
    category = "clothing",
    name = ccb.content.plural_text("basic AR glasses", "basic AR glasses"),
    description = ccb.content.text("A pair of compact augmented reality glasses with some basic functionality.  There is a camera on the rim, and it has an alarm clock feature."),
    mass = "65 g",
    volume = "720 ml",
    price = "500 USD",
    survival_price = "2 USD 50 cent",
    materials = { "plastic" },
    symbol = "[",
    looks_like = "glasses_safety",
    color = "light_gray",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_LIGHT", "BATTERY_ULTRA_LIGHT" },
            default_magazine = "light_battery_cell",
        },
        {
            kind = "E_FILE_STORAGE",
            rigid = true,
            capacity = "1 ml",
            mass_limit = "1 g",
            weight_multiplier = 0,
            memory_capacity = "64 GB",
        },
    },
    flags = { "WATCH", "ALARMCLOCK", "FRAGILE", "WATER_BREAK", "PADDED", "ELECTRONIC" },
    faults = { { group = "electronic_general" } },
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 1, transfer_rate = "30 MB", ammo_types = "battery" },
    armor = {
        portions = { { encumbrance = 5, coverage = 95, covers = { "eyes" } } },
        thickness = 1,
        environmental_protection = 1,
    },
    use_actions = { "CAMERA" },
}

ccb.content.define_item {
    id = "ar_glasses_advanced",
    category = "clothing",
    name = ccb.content.plural_text("advanced AR glasses", "advanced AR glasses"),
    description = ccb.content.text("An expensive model of augmented reality glasses, with adaptive light correction and some gadgets, designed to be compatible with corrective glasses.  An augmented reality overlay allows the user to zoom their view, and it displays handy information about local topology."),
    mass = "170 g",
    volume = "750 ml",
    price = "3 kUSD",
    survival_price = "4 USD",
    materials = { "plastic" },
    symbol = "[",
    looks_like = "glasses_safety",
    color = "light_gray",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_LIGHT", "BATTERY_ULTRA_LIGHT" },
            default_magazine = "light_battery_cell",
        },
        {
            kind = "E_FILE_STORAGE",
            rigid = true,
            capacity = "1 ml",
            mass_limit = "1 g",
            weight_multiplier = 0,
            memory_capacity = "1 TB",
        },
    },
    flags = {
        "ZOOM", "WATCH", "ALARMCLOCK", "OUTER", "FRAGILE", "SUN_GLASSES", "THERMOMETER", "WATER_BREAK",
        "PADDED", "ELECTRONIC", "CAN_USE_IN_DARK",
    },
    faults = { { group = "electronic_general" } },
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 1, transfer_rate = "30 MB", ammo_types = "battery" },
    armor = {
        portions = { { encumbrance = 5, coverage = 100, covers = { "eyes" } } },
        thickness = 1,
        environmental_protection = 1,
    },
    use_actions = { "CAMERA", "PORTABLE_GAME", "EBOOKSAVE", "E_FILE_DEVICE" },
}

-- Based on the EOD 10 and EOD 9 helmets.
ccb.content.define_item {
    id = "helmet_eod",
    category = "armor",
    name = ccb.content.plural_text("EOD helmet", "EOD helmets"),
    description = ccb.content.text("An armored, electronically-shielded helmet containing a camera, a two-way radio, and a headlamp, all of which can be voice-activated for redundancy.  It is designed to protect against overpressure, fragmentation, impact, and heat."),
    mass = "3600 g",
    volume = "4 L",
    price = "16 kUSD 139 USD",
    survival_price = "100 USD",
    materials = { "kevlar_rigid", "plastic", "plastic_pad" },
    symbol = "[",
    color = "light_green",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_MEDIUM" },
            default_magazine = "medium_battery_cell",
        },
    },
    flags = { "STURDY", "OUTER", "RAINPROOF", "PADDED", "WATCH", "ALARMCLOCK" },
    subtype_order = { "tool", "armor" },
    tool = { ammo_types = "battery" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "kevlar_rigid", coverage = 100, thickness = 4.0 },
                    { id = "plastic_pad", coverage = 100, thickness = 14.0 },
                },
                covers = { "head" },
                coverage = 100,
                layers = { "OUTER", "NORMAL" },
                encumbrance_modifiers = { "RESTRICTS_NECK", "WELL_SUPPORTED" },
            },
            {
                materials = { { id = "plastic", coverage = 100, thickness = 20.0 } },
                covers = { "mouth" },
                coverage = 100,
                encumbrance = 15,
                layers = { "OUTER" },
                rigid_only = true,
            },
            {
                materials = { { id = "plastic", coverage = 100, thickness = 20.0 } },
                covers = { "eyes" },
                coverage = 100,
                encumbrance = 5,
                layers = { "OUTER" },
                rigid_only = true,
            },
        },
        warmth = 65,
        environmental_protection = 3,
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Turn on headlamps"),
            message = ccb.content.text("\"Activating illumination.\""),
            target = "helmet_eod_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("\"Illumination disabled, low power.\""),
        },
    },
}

ccb.content.define_item {
    id = "helmet_eod_on",
    copy_from = "helmet_eod",
    name = ccb.content.plural_text("EOD helmet (on)", "EOD helmets (on)"),
    light = 350,
    revert_to = "helmet_eod",
    inheritance = { add = { flags = { "CHARGEDIM", "TRADER_AVOID", "TWO_WAY_RADIO", "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "10 W" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Turn off headlamps"),
            message = ccb.content.text("\"Disabling illumination.\""),
            target = "helmet_eod",
        },
    },
}

ccb.content.define_item {
    id = "dimensional_anchor",
    category = "clothing",
    symbol = "[",
    color = "light_gray",
    name = ccb.content.plural_text("5-point anchor", "5-point anchors"),
    looks_like = "chestguard_hard",
    description = ccb.content.text("A featureless, disc-shaped device mounted on a harness.  The words \"X.E.D.R.A\" and \"5-point anchor\" are inscribed on its front and back."),
    price = "1 kUSD 500 USD",
    survival_price = "80 USD",
    materials = { "ceramic", "kevlar" },
    mass = "1250 g",
    volume = "4500 ml",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_MEDIUM" },
            default_magazine = "medium_battery_cell",
        },
    },
    flags = { "OVERSIZE", "BELTED", "SOFT" },
    subtype_order = { "tool", "armor" },
    tool = { ammo_types = "battery" },
    armor = {
        warmth = 10,
        thickness = 2,
        portions = { { encumbrance = 2, coverage = 50, covers = { "torso" } } },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("An LED light in the 5-point anchor flickers on."),
            target = "dimensional_anchor_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("It seems like this device needs power."),
        },
    },
}

ccb.content.define_item {
    id = "dimensional_anchor_on",
    copy_from = "dimensional_anchor",
    name = ccb.content.plural_text("5-point anchor (on)", "5-point anchors (on)"),
    looks_like = "dimensional_anchor",
    description = ccb.content.text("The harness' shoulder-mounted LED glows with a soft green hue.  There's no further indication of anything happening."),
    revert_to = "dimensional_anchor",
    flags = { "DIMENSIONAL_ANCHOR", "OVERSIZE", "BELTED", "PORTAL_PROOF", "SOFT", "SPAWN_ACTIVE" },
    subtype_order = { "tool", "armor" },
    tool = { turns_per_charge = 100 },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("An LED light in the 5-point anchor flickers off."),
            target = "dimensional_anchor",
        },
    },
}

ccb.content.define_item {
    id = "broken_dimensional_anchor",
    copy_from = "dimensional_anchor",
    name = ccb.content.plural_text("malfunctioning 5-point anchor", "malfunctioning 5-point anchors"),
    description = ccb.content.text("A battered, disc-shaped device mounted on a harness.  The inscriptions \"X.E.D.R.A\" and \"5-point anchor\" are barely legible on its radiation-stained front and back."),
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("The 5-point anchor emits a low-pitched clicking alarm as its mounted LED light flashes yellow."),
            target = "broken_dimensional_anchor",
            need_charges = 1,
            need_charges_message = ccb.content.text("It seems like this device needs power."),
        },
    },
}

ccb.content.define_item {
    id = "ar_glasses_advanced_pat",
    name = ccb.content.plural_text("modified advanced AR glasses", "modified advanced AR glasses"),
    description = "An expensive model of augmented reality glasses, with adaptive light correction and some gadgets, designed to be compatible with corrective glasses.  An augmented reality overlay allows the user to zoom their view, and it displays handy information about local topology.  These have been modified by your friend Pat to function on long-distance radio waves (LoRa).  A battery pack, the internal parts of a tablet PC, and a two-way radio have been combined onto a hip-strapped unit.  Activate it to utilize software, start recording and transmitting with Pat's system, or hail Pat on the radio.",
    symbol = "[",
    color = "white",
    category = "clothing",
    looks_like = "glasses_safety",
    mass = "400 g",
    volume = "750 ml",
    price = "3 kUSD",
    survival_price = "4 USD",
    e_port = "phone",
    flags = {
        "ZOOM",
        "WATCH",
        "ALARMCLOCK",
        "OUTER",
        "FRAGILE",
        "SUN_GLASSES",
        "THERMOMETER",
        "WATER_BREAK",
        "PADDED",
        "ELECTRONIC",
        "CAN_USE_IN_DARK",
        "TWO_WAY_RADIO",
        "TRADER_AVOID",
    },
    materials = { "plastic" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            default_magazine = "light_battery_cell",
            rigid = true,
            allowed_flags = { "BATTERY_LIGHT", "BATTERY_ULTRA_LIGHT" },
        },
        {
            kind = "E_FILE_STORAGE",
            capacity = "1 ml",
            mass_limit = "1 g",
            memory_capacity = "1 TB",
            weight_multiplier = 0,
            rigid = true,
        },
    },
    faults = {
        { group = "electronic_general" },
    },
    use_actions = {
        "CAMERA",
        "PORTABLE_GAME",
        "EBOOKSAVE",
        "E_FILE_DEVICE",
        {
            kind = "transform",
            target = "ar_glasses_advanced_pat_on",
            ammo_scale = 0,
            message = "You turn the %s on and put in your earbud.",
            menu_text = "Connect to Pat's system and start transmitting data",
        },
    },
    tool = { charges_per_use = 1, ammo_types = "battery", transfer_rate = "30 MB" },
    armor = {
        thickness = 1,
        environmental_protection = 1,
        portions = {
            {
                covers = { "eyes" },
                coverage = 100,
                encumbrance = 5,
            },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_r", "leg_hip_l" },
                layers = { "BELTED" },
                coverage = 15,
                encumbrance = 5,
            },
        },
    },
    subtype_order = { "tool", "armor" },
}

ccb.content.define_item {
    id = "ar_glasses_advanced_pat_on",
    copy_from = "ar_glasses_advanced_pat",
    name = ccb.content.plural_text("modified advanced AR glasses (on)", "pairs of modified advanced AR glasses (on)"),
    category = "clothing",
    revert_to = "ar_glasses_advanced_pat",
    flags = {
        "ZOOM",
        "WATCH",
        "ALARMCLOCK",
        "OUTER",
        "FRAGILE",
        "SUN_GLASSES",
        "THERMOMETER",
        "WATER_BREAK",
        "PADDED",
        "ELECTRONIC",
        "CAN_USE_IN_DARK",
        "TWO_WAY_RADIO",
        "TRADER_AVOID",
        "SPAWN_ACTIVE",
    },
    use_actions = {
        "CAMERA",
        "PORTABLE_GAME",
        "EBOOKSAVE",
        "E_FILE_DEVICE",
        {
            kind = "transform",
            target = "ar_glasses_advanced_pat",
            ammo_scale = 0,
            message = "You turn the %s off and remove your earbud.",
            menu_text = "Disconnect from Pat's system and stop transmitting data",
        },
    },
    tool = { power_draw = "120 mW" },
    armor = {},
    subtype_order = { "tool", "armor" },
}

ccb.content.define_item {
    id = "rebreather",
    category = "clothing",
    symbol = "[",
    color = "dark_gray",
    name = ccb.content.plural_text("rebreather mask", "rebreather masks"),
    description = ccb.content.text("A mask worn over your mouth which, when loaded with the proper filters, recycles your exhaled breath for rebreathing while underwater.  Use it to turn it on."),
    flags = { "WATER_FRIENDLY", "PADDED" },
    price = "250 USD",
    survival_price = "5 USD",
    materials = { "plastic", "aluminum" },
    mass = "720 g",
    volume = "500 ml",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "REBREATHER_CART" },
            default_magazine = "rebreather_cartridge_o2",
        },
    },
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 1, ammo_types = { "rebreather_filter", "rebreather_o2_regenerator" } },
    armor = {
        warmth = 10,
        environmental_protection = 3,
        thickness = 1,
        portions = { { encumbrance = 30, coverage = 75, covers = { "mouth" } } },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You activate your %s."),
            target = "rebreather_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The filter is used up."),
        },
    },
}

ccb.content.define_item {
    id = "rebreather_on",
    copy_from = "rebreather",
    materials = { "plastic", "aluminum" },
    name = ccb.content.plural_text("rebreather mask (on)", "rebreather masks (on)"),
    description = ccb.content.text("A mask worn over your mouth which, when loaded with the proper filters, recycles your exhaled breath for rebreathing while underwater.  It is turned on, and continually consuming its filter.  Use it to turn it off."),
    flags = { "WATER_FRIENDLY", "REBREATHER", "TRADER_AVOID", "SPAWN_ACTIVE" },
    revert_to = "rebreather",
    subtype_order = { "tool", "armor" },
    tool = { turns_per_charge = 60 },
    armor = {
        environmental_protection = 15,
        portions = { { encumbrance = 20, coverage = 75, covers = { "mouth" } } },
    },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("Your %s deactivates."),
            target = "rebreather",
        },
    },
}

ccb.content.define_item {
    id = "rebreather_xl",
    category = "clothing",
    symbol = "[",
    color = "dark_gray",
    name = ccb.content.plural_text("rebreather mask", "rebreather masks"),
    description = ccb.content.text("A mask worn over your mouth which, when loaded with the proper filters, recycles your exhaled breath for rebreathing while underwater.  This model has been expanded substantially and can accommodate exotic anatomy.  Use it to turn it on."),
    flags = { "WATER_FRIENDLY", "OVERSIZE", "PREFIX_XL" },
    price = "250 USD",
    survival_price = "5 USD",
    materials = { "plastic", "aluminum" },
    mass = "960 g",
    volume = "1250 ml",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "REBREATHER_CART" },
            default_magazine = "rebreather_cartridge_o2",
        },
    },
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 1, ammo_types = { "rebreather_filter", "rebreather_o2_regenerator" } },
    armor = {
        warmth = 10,
        environmental_protection = 3,
        thickness = 1,
        portions = { { encumbrance = 30, coverage = 75, covers = { "mouth" } } },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You activate your %s."),
            target = "rebreather_xl_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The filter is used up."),
        },
    },
}

ccb.content.define_item {
    id = "rebreather_xl_on",
    copy_from = "rebreather_xl",
    name = ccb.content.plural_text("rebreather mask (on)", "rebreather masks (on)"),
    materials = { "plastic", "aluminum" },
    description = ccb.content.text("A mask worn over your mouth which, when loaded with the proper filters, recycles your exhaled breath for rebreathing while underwater.  This model has been expanded substantially and can accommodate exotic anatomy.  It is turned on, and continually consuming its filter.  Use it to turn it off."),
    flags = { "WATER_FRIENDLY", "REBREATHER", "OVERSIZE", "PREFIX_XL", "TRADER_AVOID", "SPAWN_ACTIVE" },
    revert_to = "rebreather_xl",
    subtype_order = { "tool", "armor" },
    tool = { turns_per_charge = 60 },
    armor = {
        environmental_protection = 15,
        portions = { { encumbrance = 20, coverage = 75, covers = { "mouth" } } },
    },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("Your %s deactivates."),
            target = "rebreather_xl",
        },
    },
}

ccb.content.define_item {
    id = "rebreather_xs",
    category = "clothing",
    symbol = "[",
    color = "dark_gray",
    name = ccb.content.plural_text("rebreather mask", "rebreather masks"),
    description = ccb.content.text("A mask worn over your mouth which, when loaded with the proper filters, recycles your exhaled breath for rebreathing while underwater.  This model has been shrunk dramatically to fit a smaller face.  Use it to turn it on."),
    flags = { "WATER_FRIENDLY", "UNDERSIZE", "PREFIX_XS" },
    price = "250 USD",
    survival_price = "5 USD",
    materials = { "plastic", "aluminum" },
    mass = "360 g",
    volume = "250 ml",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "REBREATHER_CART" },
            default_magazine = "rebreather_cartridge_o2",
        },
    },
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 1, ammo_types = { "rebreather_filter", "rebreather_o2_regenerator" } },
    armor = {
        covers = { "mouth" },
        warmth = 10,
        environmental_protection = 3,
        thickness = 1,
        portions = { { encumbrance = 30, coverage = 75, covers = { "mouth" } } },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You activate your %s."),
            target = "rebreather_xs_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The filter is used up."),
        },
    },
}

ccb.content.define_item {
    id = "rebreather_xs_on",
    copy_from = "rebreather_xs",
    name = ccb.content.plural_text("rebreather mask (on)", "rebreather masks (on)"),
    description = ccb.content.text("A mask worn over your mouth which, when loaded with the proper filters, recycles your exhaled breath for rebreathing while underwater.  This model has been shrunk dramatically to fit a smaller face.  It is turned on, and continually consuming its filter.  Use it to turn it off."),
    flags = { "WATER_FRIENDLY", "REBREATHER", "UNDERSIZE", "PREFIX_XS", "TRADER_AVOID", "SPAWN_ACTIVE" },
    revert_to = "rebreather_xs",
    subtype_order = { "tool", "armor" },
    tool = { turns_per_charge = 60 },
    armor = {
        covers = { "mouth" },
        environmental_protection = 15,
        portions = { { encumbrance = 20, coverage = 75, covers = { "mouth" } } },
    },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("Your %s deactivates."),
            target = "rebreather_xs",
        },
    },
}

ccb.content.define_item {
    id = "scuba_regulator",
    category = "clothing",
    symbol = "[",
    color = "dark_gray",
    name = ccb.content.plural_text("SCUBA regulator", "SCUBA regulators"),
    description = ccb.content.text("A set of hoses and regulators used by SCUBA divers to breathe underwater.  Wear it, open an air tank, and activate it to prepare it for use."),
    flags = { "WATER_FRIENDLY", "PADDED", "NORMAL", "SKINTIGHT", "SCBA" },
    price = "250 USD",
    survival_price = "5 USD",
    materials = { "plastic", "aluminum", "rubber" },
    mass = "1000 g",
    volume = "1500 ml",
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        environmental_protection = 3,
        thickness = 1,
        portions = { { encumbrance = 30, coverage = 75, covers = { "mouth" } } },
    },
    use_actions = { "SCBA_MASK_ACTIVATE" },
}

ccb.content.define_item {
    id = "scuba_regulator_scba_on",
    category = "clothing",
    symbol = "[",
    color = "dark_gray",
    name = ccb.content.plural_text("SCUBA regulator (on)", "SCUBA regulators (on)"),
    description = ccb.content.text("A set of hoses and regulators used by SCUBA divers to breathe underwater.  It is currently being fed air.  Activate it to turn it off."),
    flags = { "WATER_FRIENDLY", "PADDED", "NORMAL", "SKINTIGHT", "SCBA_ON", "SPAWN_ACTIVE" },
    revert_to = "scuba_regulator",
    price = "250 USD",
    survival_price = "5 USD",
    materials = { "plastic", "aluminum", "rubber" },
    mass = "1000 g",
    volume = "1500 ml",
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        environmental_protection = 16,
        thickness = 1,
        portions = { { encumbrance = 30, coverage = 75, covers = { "mouth" } } },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You turn off the regulator."),
            menu_text = ccb.content.text("Turn off the regulator"),
            target = "scuba_regulator",
        },
    },
    tick_actions = { "SCBA_MASK" },
}

ccb.content.define_item {
    id = "mask_filter",
    name = ccb.content.plural_text("filter mask", "filter masks"),
    category = "clothing",
    description = ccb.content.text("A mask that straps over your mouth and nose and filters air.  Protects from smoke, dust, and other contaminants quite well.  It must be prepared before use."),
    flags = { "SLEEP_IGNORE" },
    mass = "260 g",
    volume = "500 ml",
    price = "35 USD",
    survival_price = "2 USD 50 cent",
    materials = { "plastic" },
    symbol = "[",
    looks_like = "mask_dust",
    color = "light_gray",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "GASFILTER_SM" },
            default_magazine = "gasfilter_sm",
        },
    },
    subtype_order = { "tool", "armor" },
    tool = { ammo_types = "gasfilter_s" },
    armor = {
        warmth = 10,
        thickness = 2,
        environmental_protection = 3,
        filtered_protection = 7,
        portions = { { encumbrance = 15, rigid_only = true, coverage = 100, covers = { "mouth" } } },
    },
    use_actions = { "GASMASK_ACTIVATE" },
    tick_actions = { "GASMASK" },
}

-- Based on https://www.avon-protection.com/products/c50/
-- While it's based on the C50, this could equally be the FM53, CM8, or an assortment of other gas masks that fall into the same category.
-- The cotton represents the head harness that keeps the mask attached to one's melon. Hood-style masks, like the GP5, should get their own item.
-- While some older gas masks had lenses made from glass, most modern ones are fabricated with plastic eyepieces or visors. We can hand-wave away the outliers.
-- The exhale valve, speech diaphragm, and, if a mask has them, the communications unit and drinking tube, are located over the mouth and nose sections. They're represented by the plastic content.
-- Most modern gas masks possess plastic filter mounts on either one or both of the cheek sections, which this plastic represents. Again, we can tactically handwave away the outliers.
ccb.content.define_item {
    id = "mask_gas",
    category = "clothing",
    name = ccb.content.plural_text("gas mask", "gas masks"),
    description = ccb.content.text("A full-face, industrial-grade respirator made from a solid black silicon and butyl rubber blend, providing decent user comfort in addition to a clear field of view and a secure fit thanks to the mask's single-element visor and 6-point head harness.  Provided that a filter canister's been screwed into the right-side filter port and the respirator's been prepared, it'll do an admirable job at preventing smoke, gas, and contaminants derived from chemical and lab work from taking up residence in your organs."),
    mass = "490 g",
    volume = "1536 ml",
    length = "27 cm",
    price = "499 USD 50 cent",
    survival_price = "7 USD 50 cent",
    materials = { { id = "butyl_rubber", portions = 3 }, { id = "plastic", portions = 2 } },
    symbol = "[",
    color = "dark_gray",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_flags = { "GASFILTER_MED" },
            default_magazine = "gasfilter_med",
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "50 ml",
            mass_limit = "60 g",
            max_item_length = "17 cm",
            moves = 250,
            description = ccb.content.text("A number of external brackets arranged around the eyepiece to retain an outer attachment."),
            allowed_flags = { "PANORAMIC_OUTSERT" },
            inherits_flags = true,
        },
        {
            kind = "CONTAINER",
            rigid = true,
            ablative = true,
            volume_encumbrance = 0,
            capacity = "50 ml",
            mass_limit = "50 g",
            max_item_length = "10 cm",
            moves = 380,
            description = ccb.content.text("A space behind the visor designed to accommodate the installation of inserts."),
            allowed_flags = { "PANORAMIC_INSERT" },
            inherits_flags = true,
        },
    },
    flags = { "SKINTIGHT", "NORMAL", "SLEEP_IGNORE", "VARSIZE", "PADDED" },
    subtype_order = { "tool", "armor" },
    tool = { ammo_types = "gasfilter_m" },
    armor = {
        portions = {
            {
                materials = { { id = "cotton", coverage = 100, thickness = 0.2 } },
                covers = { "head" },
                subparts = { "head_crown", "head_nape" },
                coverage = 25,
                encumbrance = 0,
                layers = { "SKINTIGHT" },
                volume_encumbrance = 0,
            },
            {
                materials = { { id = "butyl_rubber", coverage = 100, thickness = 2 } },
                covers = { "head" },
                subparts = { "head_forehead" },
                coverage = 100,
                encumbrance = 20,
                volume_encumbrance = 0,
                layers = { "SKINTIGHT" },
            },
            {
                materials = { { id = "hard_plastic_transp", coverage = 100, thickness = 2 } },
                covers = { "eyes" },
                coverage = 100,
                encumbrance = 10,
                layers = { "SKINTIGHT", "NORMAL" },
                rigid_only = true,
                volume_encumbrance = 0,
            },
            {
                materials = {
                    { id = "butyl_rubber", coverage = 100, thickness = 2 },
                    { id = "plastic", coverage = 30, thickness = 1 },
                },
                covers = { "mouth", "muzzle", "beak", "insect_proboscis" },
                subparts = {
                    "mouth_lips", "mouth_nose", "mouth_chin", "muzzle_lips", "muzzle_nose",
                    "muzzle_chin", "beak_tip", "beak_bottom", "beak_top", "insect_proboscis_base",
                    "insect_proboscis_labium", "insect_proboscis_bottom",
                },
                coverage = 100,
                encumbrance = { 20, 40 },
                layers = { "SKINTIGHT", "NORMAL" },
            },
            {
                materials = {
                    { id = "butyl_rubber", coverage = 100, thickness = 2 },
                    { id = "plastic", coverage = 25, thickness = 1 },
                },
                covers = { "mouth", "muzzle", "beak", "insect_proboscis" },
                subparts = { "mouth_cheeks", "muzzle_cheeks", "beak_nares", "insect_proboscis_cheeks" },
                coverage = 100,
                encumbrance = 20,
                layers = { "SKINTIGHT", "NORMAL", "OUTER" },
                volume_encumbrance = 0,
            },
        },
        warmth = 40,
        thickness = 2,
        environmental_protection = 4,
        filtered_protection = 16,
    },
    use_actions = { "GASMASK_ACTIVATE" },
    tick_actions = { "GASMASK" },
}

ccb.content.define_item {
    id = "mask_gas_xl",
    name = ccb.content.plural_text("gas mask", "gas masks"),
    copy_from = "mask_gas",
    looks_like = "mask_gas",
    flags = { "VARSIZE", "OVERSIZE", "PREFIX_XL", "SLEEP_IGNORE" },
    inheritance = { scale = { mass = 1.25, volume = 1.25, price = 0.5 } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}

ccb.content.define_item {
    id = "mask_gas_xs",
    name = ccb.content.plural_text("gas mask", "gas masks"),
    copy_from = "mask_gas",
    looks_like = "mask_gas",
    flags = { "VARSIZE", "UNDERSIZE", "PREFIX_XS", "SLEEP_IGNORE" },
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}

ccb.content.define_item {
    id = "mask_gas_half",
    name = ccb.content.plural_text("half-face gas mask", "half-face gas masks"),
    category = "clothing",
    description = ccb.content.text("A lightweight, form-fitting mask that straps over your mouth and nose, providing full protection from the inhalation of smoke, tear gas, and chemical contaminants - though safety goggles are advised!  It must be prepared before use."),
    flags = { "SLEEP_IGNORE" },
    mass = "400 g",
    volume = "500 ml",
    price = "52 USD",
    survival_price = "7 USD 50 cent",
    materials = { "plastic" },
    symbol = "[",
    looks_like = "mask_dust",
    color = "light_gray",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_flags = { "GASFILTER_MED" },
            default_magazine = "gasfilter_med",
        },
    },
    subtype_order = { "tool", "armor" },
    tool = { ammo_types = "gasfilter_m" },
    armor = {
        warmth = 12,
        thickness = 2,
        environmental_protection = 3,
        filtered_protection = 16,
        portions = { { encumbrance = 35, rigid_only = true, coverage = 100, covers = { "mouth" } } },
    },
    use_actions = { "GASMASK_ACTIVATE" },
    tick_actions = { "GASMASK" },
}

ccb.content.define_item {
    id = "mask_fsurvivor",
    category = "armor",
    name = ccb.content.plural_text("handmade firemask", "handmade firemasks"),
    description = ccb.content.text("A custom-made leather gas mask faced with Nomex.  It must be prepared before use."),
    mass = "686 g",
    volume = "1250 ml",
    price = "260 USD",
    survival_price = "18 USD",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "GASFILTER_MED" },
            default_magazine = "gasfilter_med",
        },
    },
    materials = { "nomex", "leather_treated", "hard_plastic_transp" },
    symbol = "[",
    color = "brown",
    flags = { "VARSIZE", "STURDY", "SUN_GLASSES", "SLEEP_IGNORE", "UNRESTRICTED", "PADDED" },
    subtype_order = { "tool", "armor" },
    tool = { ammo_types = "gasfilter_m" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "leather_treated", coverage = 100, thickness = 4 },
                    { id = "nomex", coverage = 100, thickness = 2 },
                },
                covers = { "mouth", "muzzle", "beak", "insect_proboscis" },
                coverage = 100,
                encumbrance = 37,
            },
            {
                materials = { { id = "hard_plastic_transp", coverage = 100, thickness = 5 } },
                covers = { "eyes", "eyes_compound" },
                coverage = 100,
                encumbrance = 25,
            },
        },
        warmth = 25,
        environmental_protection = 4,
        filtered_protection = 16,
    },
    use_actions = { "GASMASK_ACTIVATE" },
    tick_actions = { "GASMASK" },
}

ccb.content.define_item {
    id = "mask_fsurvivorxl",
    copy_from = "mask_fsurvivor",
    looks_like = "mask_fsurvivor",
    name = ccb.content.plural_text("handmade firemask", "handmade firemasks"),
    flags = {
        "VARSIZE",
        "STURDY",
        "OVERSIZE",
        "PREFIX_XL",
        "SUN_GLASSES",
        "SLEEP_IGNORE",
        "PADDED",
        "UNRESTRICTED",
    },
    inheritance = { scale = { mass = 1.25, volume = 1.25, price = 0.5 } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}

ccb.content.define_item {
    id = "mask_fsurvivorxs",
    copy_from = "mask_fsurvivor",
    looks_like = "mask_fsurvivor",
    name = ccb.content.plural_text("handmade firemask", "handmade firemasks"),
    flags = {
        "VARSIZE",
        "STURDY",
        "SUN_GLASSES",
        "SLEEP_IGNORE",
        "UNDERSIZE",
        "PREFIX_XS",
        "PADDED",
        "UNRESTRICTED",
    },
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}

ccb.content.define_item {
    id = "mask_bunker",
    category = "armor",
    symbol = "[",
    color = "light_gray",
    name = ccb.content.plural_text("firefighter respirator mask", "firefighter respirator masks"),
    description = ccb.content.text("A full-face mask commonly used by firefighters.  When connected to an air source, the breathing apparatus provides excellent protection from smoke, flame, and other dangers.  Wear it, activate an air source, and activate it to engage airflow."),
    flags = { "WATERPROOF", "STURDY", "PADDED", "SCBA" },
    price = "1 kUSD",
    survival_price = "7 USD 50 cent",
    materials = { "plastic", "nomex" },
    mass = "1260 g",
    volume = "1500 ml",
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        warmth = 25,
        environmental_protection = 4,
        portions = {
            {
                materials = {
                    { id = "nomex", coverage = 100, thickness = 3 },
                    { id = "plastic", coverage = 100, thickness = 3 },
                },
                covers = { "mouth" },
                coverage = 100,
                encumbrance = 25,
            },
            {
                materials = { { id = "plastic", coverage = 100, thickness = 3 } },
                covers = { "eyes" },
                coverage = 100,
                encumbrance = 12,
            },
        },
    },
    use_actions = { "SCBA_MASK_ACTIVATE" },
}

ccb.content.define_item {
    id = "mask_bunker_scba_on",
    category = "armor",
    symbol = "[",
    color = "light_gray",
    name = ccb.content.plural_text("firefighter respirator mask (on)", "firefighter respirator masks (on)"),
    description = ccb.content.text("A full-face mask commonly used by firefighters.  When connected to an air source, the breathing apparatus provides excellent protection from smoke, flame, and other dangers.  It is currently part of an active SCBA system.  Activate it to turn it off."),
    copy_from = "mask_bunker",
    flags = { "WATERPROOF", "STURDY", "SUN_GLASSES", "SLEEP_IGNORE", "PADDED", "SCBA_ON" },
    revert_to = "mask_bunker",
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = { environmental_protection = 16 },
    tick_actions = { "SCBA_MASK" },
}

ccb.content.define_item {
    id = "mask_hsurvivor",
    category = "armor",
    name = ccb.content.plural_text("handmade plated gas mask", "handmade plated gas masks"),
    description = ccb.content.text("A gas mask handcrafted from treated leather with a steel faceplate overtop.  It must be prepared before use."),
    mass = "686 g",
    volume = "1350 ml",
    price = "260 USD",
    survival_price = "18 USD",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_flags = { "GASFILTER_MED" },
            default_magazine = "gasfilter_med",
        },
    },
    materials = { "leather_treated", "hard_plastic_transp", "lc_steel" },
    symbol = "[",
    color = "brown",
    flags = { "VARSIZE", "STURDY", "SUN_GLASSES", "SLEEP_IGNORE", "PADDED", "UNRESTRICTED" },
    subtype_order = { "tool", "armor" },
    tool = { ammo_types = "gasfilter_m" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "leather_treated", coverage = 100, thickness = 4 },
                    { id = "lc_steel", coverage = 90, thickness = 1 },
                },
                covers = { "mouth", "muzzle", "beak", "insect_proboscis" },
                coverage = 100,
                encumbrance = 38,
            },
            {
                materials = {
                    { id = "hard_plastic_transp", coverage = 100, thickness = 5 },
                    { id = "lc_steel", coverage = 15, thickness = 1 },
                },
                covers = { "eyes", "eyes_compound" },
                layers = { "SKINTIGHT", "NORMAL" },
                rigid_only = true,
                coverage = 100,
                encumbrance = 28,
            },
        },
        warmth = 28,
        environmental_protection = 4,
        filtered_protection = 16,
    },
    use_actions = { "GASMASK_ACTIVATE" },
    tick_actions = { "GASMASK" },
}

ccb.content.define_item {
    id = "mask_hsurvivorxl",
    copy_from = "mask_hsurvivor",
    looks_like = "mask_hsurvivor",
    name = ccb.content.plural_text("handmade plated gas mask", "handmade plated gas masks"),
    flags = {
        "VARSIZE",
        "STURDY",
        "OVERSIZE",
        "PREFIX_XL",
        "SUN_GLASSES",
        "SLEEP_IGNORE",
        "PADDED",
        "UNRESTRICTED",
    },
    inheritance = { scale = { mass = 1.25, volume = 1.25, price = 0.5 } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}

ccb.content.define_item {
    id = "mask_hsurvivorxs",
    copy_from = "mask_hsurvivor",
    looks_like = "mask_hsurvivor",
    name = ccb.content.plural_text("handmade plated gas mask", "handmade plated gas masks"),
    flags = {
        "VARSIZE",
        "STURDY",
        "SUN_GLASSES",
        "SLEEP_IGNORE",
        "UNDERSIZE",
        "PREFIX_XS",
        "PADDED",
        "UNRESTRICTED",
    },
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}

ccb.content.define_item {
    id = "mask_lsurvivor",
    category = "armor",
    name = ccb.content.plural_text("handmade half gas mask", "handmade half gas masks"),
    description = ccb.content.text("A half-face gas mask handcrafted from treated leather.  It provides no protection for the eyes, and must be activated before use."),
    mass = "341 g",
    volume = "625 ml",
    price = "200 USD",
    survival_price = "14 USD 50 cent",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "GASFILTER_MED" },
            default_magazine = "gasfilter_med",
        },
    },
    materials = { "leather_treated" },
    symbol = "[",
    color = "brown",
    flags = { "VARSIZE", "STURDY", "SLEEP_IGNORE", "UNRESTRICTED" },
    subtype_order = { "tool", "armor" },
    tool = { ammo_types = "gasfilter_m" },
    armor = {
        portions = {
            {
                materials = { { id = "leather_treated", coverage = 100, thickness = 4 } },
                covers = { "mouth", "muzzle", "beak", "insect_proboscis" },
                coverage = 100,
                encumbrance = 35,
            },
        },
        warmth = 15,
        environmental_protection = 4,
        filtered_protection = 15,
    },
    use_actions = { "GASMASK_ACTIVATE" },
    tick_actions = { "GASMASK" },
}

ccb.content.define_item {
    id = "mask_lsurvivorxl",
    copy_from = "mask_lsurvivor",
    looks_like = "mask_lsurvivor",
    name = ccb.content.plural_text("handmade half gas mask", "handmade half gas masks"),
    flags = { "VARSIZE", "STURDY", "OVERSIZE", "PREFIX_XL", "SLEEP_IGNORE", "UNRESTRICTED" },
    inheritance = { scale = { mass = 1.25, volume = 1.25, price = 0.5 } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}

ccb.content.define_item {
    id = "mask_lsurvivorxs",
    copy_from = "mask_lsurvivor",
    looks_like = "mask_lsurvivor",
    name = ccb.content.plural_text("handmade half gas mask", "handmade half gas masks"),
    flags = { "VARSIZE", "STURDY", "SLEEP_IGNORE", "UNDERSIZE", "PREFIX_XS", "UNRESTRICTED" },
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}

ccb.content.define_item {
    id = "mask_survivor",
    category = "armor",
    name = ccb.content.plural_text("handmade gas mask", "handmade gas masks"),
    description = ccb.content.text("A gas mask handcrafted from treated leather.  It must be prepared before use."),
    mass = "682 g",
    volume = "1250 ml",
    price = "240 USD",
    survival_price = "17 USD 50 cent",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "GASFILTER_MED" },
            default_magazine = "gasfilter_med",
        },
    },
    materials = { "leather_treated", "hard_plastic_transp" },
    symbol = "[",
    color = "brown",
    flags = { "VARSIZE", "STURDY", "SUN_GLASSES", "SLEEP_IGNORE", "PADDED", "UNRESTRICTED" },
    subtype_order = { "tool", "armor" },
    tool = { ammo_types = "gasfilter_m" },
    armor = {
        portions = {
            {
                materials = { { id = "leather_treated", coverage = 100, thickness = 4 } },
                covers = { "mouth", "beak", "muzzle", "insect_proboscis" },
                coverage = 100,
                encumbrance = 35,
            },
            {
                materials = { { id = "hard_plastic_transp", coverage = 100, thickness = 5 } },
                covers = { "eyes", "eyes_compound" },
                layers = { "SKINTIGHT", "NORMAL" },
                rigid_only = true,
                coverage = 100,
                encumbrance = 25,
            },
        },
        warmth = 20,
        environmental_protection = 4,
        filtered_protection = 15,
    },
    use_actions = { "GASMASK_ACTIVATE" },
    tick_actions = { "GASMASK" },
}

ccb.content.define_item {
    id = "mask_survivorxl",
    copy_from = "mask_survivor",
    looks_like = "mask_survivor",
    name = ccb.content.plural_text("handmade gas mask", "handmade gas masks"),
    flags = {
        "VARSIZE",
        "STURDY",
        "OVERSIZE",
        "PREFIX_XL",
        "SUN_GLASSES",
        "SLEEP_IGNORE",
        "PADDED",
        "UNRESTRICTED",
    },
    inheritance = { scale = { mass = 1.25, volume = 1.25, price = 0.5 } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}

ccb.content.define_item {
    id = "mask_survivorxs",
    copy_from = "mask_survivor",
    looks_like = "mask_survivor",
    name = ccb.content.plural_text("handmade gas mask", "handmade gas masks"),
    flags = {
        "VARSIZE",
        "STURDY",
        "SUN_GLASSES",
        "SLEEP_IGNORE",
        "UNDERSIZE",
        "PREFIX_XS",
        "PADDED",
        "UNRESTRICTED",
    },
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}

ccb.content.define_item {
    id = "string_dimension_phase_immersion_suit",
    name = ccb.content.plural_text("KÁ expedition harness", "KÁ expedition harnesses"),
    description = "A protective body-suit built from layered textiles and segmented plates, all coated in a layer of gold.  The collar bares a prominent set of clasps and tube fittings.  An integrated harness is equipped with spring-loaded clips and a small electronic control apparatus stamped with \"KÁ\".",
    symbol = "[",
    color = "yellow",
    category = "clothing",
    mass = "8400 g",
    volume = "4100 ml",
    price = "2 kUSD 500 USD",
    survival_price = "100 USD",
    flags = {
        "RAD_PROOF",
        "ELECTRIC_IMMUNE",
        "STURDY",
        "WATERPROOF",
        "GAS_PROOF",
        "RAINPROOF",
        "PADDED",
        "COMBAT_TOGGLEABLE",
        "UNBREAKABLE_MELEE",
    },
    materials = { "carbide", "qt_steel", "superalloy", "gold" },
    pockets = {
        {
            capacity = "2000 ml",
            mass_limit = "2500 g",
            max_item_length = "70 cm",
            moves = 60,
            volume_encumbrance = 0.5,
            holster = true,
            transparent = true,
            allowed_flags = { "BELT_CLIP" },
            description = "Clipped to the harness.",
        },
        {
            capacity = "2000 ml",
            mass_limit = "2500 g",
            max_item_length = "70 cm",
            moves = 60,
            volume_encumbrance = 0.5,
            holster = true,
            transparent = true,
            allowed_flags = { "BELT_CLIP" },
            description = "Clipped to the harness.",
        },
        {
            capacity = "2000 ml",
            mass_limit = "2500 g",
            max_item_length = "70 cm",
            moves = 60,
            volume_encumbrance = 0.5,
            holster = true,
            transparent = true,
            allowed_flags = { "BELT_CLIP" },
            description = "Clipped to the harness.",
        },
        {
            capacity = "2000 ml",
            mass_limit = "2500 g",
            max_item_length = "70 cm",
            moves = 60,
            volume_encumbrance = 0.5,
            holster = true,
            transparent = true,
            allowed_flags = { "BELT_CLIP" },
            description = "Clipped to the harness.",
        },
    },
    armor = {
        warmth = 30,
        environmental_protection = 16,
        portions = {
            {
                covers = { "torso" },
                coverage = 100,
                volume_encumbrance = 0,
                encumbrance = 10,
                materials = {
                    { id = "carbide", thickness = 2.0, coverage = 100 },
                    { id = "qt_steel", thickness = 1.0, coverage = 80 },
                    { id = "superalloy", thickness = 1.0, coverage = 40 },
                    { id = "superalloy", thickness = 1.0, coverage = 40 },
                    { id = "gold", thickness = 0.1, coverage = 100 },
                },
            },
            {
                covers = { "hand_l", "hand_r" },
                coverage = 100,
                volume_encumbrance = 0,
                encumbrance = 5,
                materials = {
                    { id = "carbide", thickness = 1.0, coverage = 100 },
                    { id = "qt_steel", thickness = 1.0, coverage = 60 },
                    { id = "gold", thickness = 0.1, coverage = 100 },
                },
            },
            {
                covers = { "foot_l", "foot_r" },
                layers = { "NORMAL", "OUTER" },
                coverage = 100,
                volume_encumbrance = 0,
                encumbrance = 10,
                materials = {
                    { id = "carbide", thickness = 1.0, coverage = 100 },
                    { id = "qt_steel", thickness = 3.0, coverage = 80 },
                    { id = "gold", thickness = 0.1, coverage = 100 },
                },
            },
            {
                covers = { "arm_l", "arm_r", "leg_l", "leg_r" },
                coverage = 100,
                volume_encumbrance = 0,
                encumbrance = 10,
                materials = {
                    { id = "carbide", thickness = 1.0, coverage = 100 },
                    { id = "qt_steel", thickness = 0.5, coverage = 75 },
                    { id = "superalloy", thickness = 0.5, coverage = 40 },
                    { id = "superalloy", thickness = 0.5, coverage = 40 },
                    { id = "gold", thickness = 0.1, coverage = 100 },
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "goggles_nv",
    category = "clothing",
    symbol = "[",
    color = "dark_gray",
    name = ccb.content.plural_text("light amp goggles", "light amp goggles"),
    description = ccb.content.text("A pair of battery-powered goggles that use a infrared LED in conjunction with a IR camera, allowing you to see in the dark.  Use it to turn them on."),
    flags = { "FRAGILE", "OUTER", "ELECTRONIC", "MUNDANE" },
    faults = { { group = "electronic_general" } },
    price = "300 USD",
    survival_price = "30 USD",
    materials = { "plastic", "steel" },
    mass = "600 g",
    volume = "1 L",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_LIGHT", "BATTERY_ULTRA_LIGHT" },
            default_magazine = "light_battery_cell",
        },
    },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1, ammo_types = "battery" },
    armor = {
        warmth = 10,
        environmental_protection = 3,
        thickness = 2,
        portions = { { encumbrance = 40, coverage = 100, covers = { "eyes" }, rigid_only = true } },
    },
    artifact = { enchantments = { "nvg_bad" } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You activate your %s."),
            target = "goggles_nv_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}

-- Based on 3M M-307
ccb.content.define_item {
    id = "basic_papr_helmet",
    category = "armor",
    name = ccb.content.plural_text("PAPR helmet", "PAPR helmets"),
    looks_like = "flight_helmet",
    description = ccb.content.text("A helmet fit with a transparent full-face mask.  On the back of the helmet is a long tube which attaches to a powered air purifying respirator system.  Once activated it will comfortably protect against chemical, biological, radiological, and nuclear threats.  Like a standard gas mask it must be prepared before use; unlike a standard gas mask, it is relatively cool and comfortable, but will only function when paired with an active PAPR blower unit."),
    mass = "857 g",
    volume = "2250 ml",
    price = "700 USD",
    survival_price = "10 USD",
    materials = { { id = "plastic", portions = 4 }, { id = "hard_plastic_transp", portions = 1 } },
    symbol = "[",
    color = "dark_gray",
    flags = { "WATERPROOF", "PADDED", "OVERSIZE", "SLEEP_IGNORE", "PAPR_MASK" },
    pockets = {
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "500 ml",
            mass_limit = "400 g",
            moves = 250,
            description = ccb.content.text("Pocket for an ear attachment."),
            allowed_flags = { "HELMET_EAR_ATTACHMENT" },
            inherits_flags = true,
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "500 ml",
            mass_limit = "250 g",
            moves = 250,
            description = ccb.content.text("Pocket for a nape protector."),
            allowed_flags = { "HELMET_NAPE_PROTECTOR" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            capacity = "400 ml",
            mass_limit = "400 g",
            moves = 250,
            description = ccb.content.text("Pocket for a counterweight pouch."),
            allowed_flags = { "HELMET_BACK_POUCH" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            capacity = "300 ml",
            mass_limit = "500 g",
            max_item_length = "14 cm",
            moves = 100,
            description = ccb.content.text("Pocket for a flashlight attachment."),
            allowed_flags = { "HELMET_HEAD_ATTACHMENT" },
            transparent = true,
        },
    },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        warmth = 20,
        portions = {
            {
                materials = { { id = "plastic", coverage = 100, thickness = 4 } },
                covers = { "head" },
                subparts = { "head_crown", "head_forehead" },
                coverage = 100,
                encumbrance = 10,
                layers = { "OUTER" },
            },
            {
                materials = { { id = "hard_plastic_transp", coverage = 100, thickness = 1.0 } },
                covers = { "eyes" },
                rigid_only = true,
                coverage = 100,
                encumbrance = 5,
                layers = { "OUTER" },
            },
            {
                materials = { { id = "hard_plastic_transp", coverage = 100, thickness = 1.0 } },
                covers = { "mouth" },
                rigid_only = true,
                coverage = 100,
                encumbrance = 5,
                layers = { "OUTER" },
            },
        },
        environmental_protection = 4,
        filtered_protection = 16,
    },
    use_actions = { "PAPR_MASK_ACTIVATE" },
    tick_actions = { "PAPR_MASK" },
}

ccb.content.define_item {
    id = "military_papr_mask_asr_scba_on",
    category = "clothing",
    name = ccb.content.plural_text("military respirator mask (SCBA) (on)", "military respirator masks (SCBA) (on)"),
    looks_like = "mask_gas",
    description = ccb.content.text("A black, full-face military respirator made from a silicon and butyl rubber blend, providing decent user comfort in addition to a clear field of view and a secure fit thanks to the mask's single-element visor and 6-point head harness.  This mask is configured for two modes: negative-pressure, using standard CBRN gas mask filter canisters; and positive-pressure, with built-in hardware to accommodate either a powered air-purifying respirator (PAPR) or a self-contained breathing apparatus (SCBA).  Once activated it will comfortably protect against chemical, biological, radiological, and nuclear threats.  It is currently in positive-pressure SCBA mode, so will only function with an external air source.  It is currently being fed air.  Activate it to turn it off."),
    copy_from = "military_papr_mask",
    flags = { "VARSIZE", "PADDED", "SCBA_ON", "SPAWN_ACTIVE" },
    revert_to = "military_papr_mask_asr",
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = { environmental_protection = 16 },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You turn off the regulator."),
            menu_text = ccb.content.text("Turn off the regulator"),
            target = "military_papr_mask_asr",
        },
    },
    tick_actions = { "SCBA_MASK" },
}

ccb.content.define_item {
    id = "military_papr_mask",
    name = ccb.content.plural_text("military respirator mask (PAPR)", "military respirator masks (PAPR)"),
    description = "A black, full-face military respirator made from a silicon and butyl rubber blend, providing decent user comfort in addition to a clear field of view and a secure fit thanks to the mask's single-element visor and 6-point head harness.  This mask is configured for two modes: negative-pressure, using standard CBRN gas mask filter canisters; and positive-pressure, with built-in hardware to accommodate either a powered air-purifying respirator (PAPR) or a self-contained breathing apparatus (SCBA).  Once activated it will comfortably protect against chemical, biological, radiological, and nuclear threats.  It is currently in positive-pressure PAPR mode, so will only function with a powered PAPR blower.",
    symbol = "[",
    color = "dark_gray",
    category = "clothing",
    looks_like = "mask_gas",
    mass = "490 g",
    volume = "1536 ml",
    length = "27 cm",
    price = "499 USD 50 cent",
    survival_price = "7 USD 50 cent",
    flags = { "SLEEP_IGNORE", "VARSIZE", "PADDED", "PAPR_MASK" },
    materials = {
        { id = "butyl_rubber", portions = 3 },
        { id = "plastic", portions = 2 },
    },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            default_magazine = "gasfilter_med",
            allowed_flags = { "GASFILTER_MED" },
        },
        {
            kind = "CONTAINER",
            capacity = "50 ml",
            mass_limit = "60 g",
            max_item_length = "17 cm",
            moves = 250,
            volume_encumbrance = 0,
            ablative = true,
            inherits_flags = true,
            allowed_flags = { "PANORAMIC_OUTSERT" },
            description = "A number of external brackets arranged around the eyepiece to retain an outer attachment.",
        },
        {
            kind = "CONTAINER",
            capacity = "50 ml",
            mass_limit = "50 g",
            max_item_length = "10 cm",
            moves = 380,
            volume_encumbrance = 0,
            ablative = true,
            rigid = true,
            inherits_flags = true,
            allowed_flags = { "PANORAMIC_INSERT" },
            description = "A space behind the visor designed to accommodate the installation of inserts.",
        },
    },
    use_actions = {
        "PAPR_MASK_ACTIVATE",
        {
            kind = "transform",
            target = "military_papr_mask_gasmask",
            message = "You switch airflow to the CBRN filter compartment.",
            menu_text = "Switch to filter mode",
        },
    },
    tick_actions = { "PAPR_MASK" },
    tool = {},
    armor = {
        thickness = 2,
        warmth = 40,
        environmental_protection = 4,
        portions = {
            {
                covers = { "head" },
                subparts = { "head_crown", "head_nape" },
                layers = { "SKINTIGHT" },
                coverage = 25,
                volume_encumbrance = 0,
                encumbrance = 0,
                materials = {
                    { id = "cotton", thickness = 0.2, coverage = 100 },
                },
            },
            {
                covers = { "head" },
                subparts = { "head_forehead" },
                layers = { "SKINTIGHT" },
                coverage = 100,
                volume_encumbrance = 0,
                encumbrance = 20,
                materials = {
                    { id = "butyl_rubber", thickness = 2, coverage = 100 },
                },
            },
            {
                covers = { "eyes" },
                layers = { "SKINTIGHT", "NORMAL" },
                coverage = 100,
                rigid_only = true,
                volume_encumbrance = 0,
                encumbrance = 10,
                materials = {
                    { id = "hard_plastic_transp", thickness = 2, coverage = 100 },
                },
            },
            {
                covers = { "mouth" },
                subparts = { "mouth_lips", "mouth_nose", "mouth_chin" },
                layers = { "SKINTIGHT", "NORMAL" },
                coverage = 100,
                encumbrance = 10,
                materials = {
                    { id = "butyl_rubber", thickness = 2, coverage = 100 },
                    { id = "plastic", thickness = 1, coverage = 30 },
                },
            },
            {
                covers = { "mouth" },
                subparts = { "mouth_cheeks" },
                layers = { "SKINTIGHT", "NORMAL" },
                coverage = 100,
                volume_encumbrance = 0,
                encumbrance = 10,
                materials = {
                    { id = "butyl_rubber", thickness = 2, coverage = 100 },
                    { id = "plastic", thickness = 1, coverage = 25 },
                },
            },
        },
        filtered_protection = 16,
    },
    subtype_order = { "tool", "armor" },
}

ccb.content.define_item {
    id = "military_papr_mask_asr",
    copy_from = "military_papr_mask",
    name = ccb.content.plural_text("military respirator mask (SCBA)", "military respirator masks (SCBA)"),
    description = "A black, full-face military respirator made from a silicon and butyl rubber blend, providing decent user comfort in addition to a clear field of view and a secure fit thanks to the mask's single-element visor and 6-point head harness.  This mask is configured for two modes: negative-pressure, using standard CBRN gas mask filter canisters; and positive-pressure, with built-in hardware to accommodate either a powered air-purifying respirator (PAPR) or a self-contained breathing apparatus (SCBA).  Once activated it will comfortably protect against chemical, biological, radiological, and nuclear threats.  It is currently in positive-pressure SCBA mode, so will only function with an external air source.",
    category = "clothing",
    looks_like = "mask_gas",
    flags = { "SLEEP_IGNORE", "VARSIZE", "PADDED", "SCBA" },
    use_actions = {
        "SCBA_MASK_ACTIVATE",
        {
            kind = "transform",
            target = "military_papr_mask_gasmask",
            message = "You switch airflow to the CBRN filter compartment.",
            menu_text = "Switch to filter mode",
        },
    },
    tool = {},
    armor = {},
    subtype_order = { "tool", "armor" },
}

-- modified version for xedra field notebook mission.  Really just extra warm and cumbersome PAPR mask, plus a tinfoil hat to protect from THEM.
ccb.content.define_item {
    id = "basic_papr_helmet_xedra_mark",
    category = "armor",
    name = ccb.content.plural_text("shielded PAPR-EEG helmet", "shielded PAPR-EEG helmets"),
    looks_like = "flight_helmet",
    description = ccb.content.text("A white plastic helmet fit with a transparent full-face mask.  It has been modified for some unknown purpose.  On the back of the helmet is a long tube which attaches to a powered air purifying respirator system.  Once activated it will comfortably protect against chemical, biological, radiological, and nuclear threats.  Like a standard gas mask it must be prepared before use; unlike a standard gas mask it will only function when paired with an active PAPR blower unit.  A cotton cap covered in electrodes and wires, like those used to make electroencephalogram recordings, has been integrated as an underlayer, with a thick connection cable exiting a grommeted and sealed hole in the back.  A layer of shiny metallized polyethylene terephthalate has been glued to the interior of the helmet itself.  A tinfoil hat for a prepper with class."),
    mass = "950 g",
    volume = "2250 ml",
    price = "700 USD",
    survival_price = "10 USD",
    materials = {
        { id = "cotton", portions = 1 },
        { id = "plastic", portions = 4 },
        { id = "hard_plastic_transp", portions = 1 },
        { id = "aluminum", portions = 0.01 },
    },
    symbol = "[",
    color = "white",
    flags = { "WATERPROOF", "PADDED", "OVERSIZE", "SLEEP_IGNORE", "PAPR_MASK", "PSYSHIELD_PARTIAL" },
    pockets = {
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "500 ml",
            mass_limit = "400 g",
            moves = 250,
            description = ccb.content.text("Pocket for an ear attachment."),
            allowed_flags = { "HELMET_EAR_ATTACHMENT" },
            inherits_flags = true,
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "500 ml",
            mass_limit = "250 g",
            moves = 250,
            description = ccb.content.text("Pocket for a nape protector."),
            allowed_flags = { "HELMET_NAPE_PROTECTOR" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            capacity = "400 ml",
            mass_limit = "400 g",
            moves = 250,
            description = ccb.content.text("Pocket for a counterweight pouch."),
            allowed_flags = { "HELMET_BACK_POUCH" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            capacity = "300 ml",
            mass_limit = "500 g",
            max_item_length = "14 cm",
            moves = 100,
            description = ccb.content.text("Pocket for a flashlight attachment."),
            allowed_flags = { "HELMET_HEAD_ATTACHMENT" },
            transparent = true,
        },
    },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        warmth = 30,
        portions = {
            {
                materials = {
                    { id = "plastic", coverage = 100, thickness = 4 },
                    { id = "aluminum", coverage = 100, thickness = 0.01 },
                    { id = "cotton", coverage = 100, thickness = 1 },
                },
                covers = { "head" },
                subparts = { "head_crown", "head_forehead" },
                coverage = 100,
                encumbrance = 20,
                layers = { "OUTER" },
            },
            {
                materials = { { id = "cotton", coverage = 100, thickness = 1 } },
                covers = { "head" },
                subparts = { "head_ear_r", "head_ear_l" },
                coverage = 100,
                encumbrance = 0,
                layers = { "SKINTIGHT" },
            },
            {
                materials = { { id = "hard_plastic_transp", coverage = 100, thickness = 1.0 } },
                covers = { "eyes" },
                rigid_only = true,
                coverage = 100,
                encumbrance = 5,
                layers = { "OUTER" },
            },
            {
                materials = { { id = "hard_plastic_transp", coverage = 100, thickness = 1.0 } },
                covers = { "mouth" },
                rigid_only = true,
                coverage = 100,
                encumbrance = 5,
                layers = { "OUTER" },
            },
        },
        environmental_protection = 4,
        filtered_protection = 16,
    },
    use_actions = { "PAPR_MASK_ACTIVATE" },
    tick_actions = { "PAPR_MASK" },
}

ccb.content.define_item {
    id = "military_papr_mask_gasmask",
    copy_from = "military_papr_mask",
    name = ccb.content.plural_text("military respirator mask (filter)", "military respirator masks (filter)"),
    description = "A black, full-face military respirator made from a silicon and butyl rubber blend, providing decent user comfort in addition to a clear field of view and a secure fit thanks to the mask's single-element visor and 6-point head harness.  This mask is configured for two modes: negative-pressure, using standard CBRN gas mask filter canisters; and positive-pressure, with built-in hardware to accommodate either a powered air-purifying respirator (PAPR) or a self-contained breathing apparatus (SCBA).  Once activated it will comfortably protect against chemical, biological, radiological, and nuclear threats.  It is currently in negative-pressure mode, so will only function with an installed and prepared CBRN gas mask canister.",
    category = "clothing",
    looks_like = "mask_gas",
    flags = { "SLEEP_IGNORE", "VARSIZE", "PADDED" },
    use_actions = {
        "GASMASK_ACTIVATE",
        {
            kind = "transform",
            target = "military_papr_mask_asr",
            message = "You switch airflow to the SCBA regulator.",
            menu_text = "Switch to SCBA mode",
        },
    },
    tick_actions = { "GASMASK" },
    tool = { ammo_types = "gasfilter_m" },
    armor = {
        portions = {
            {
                covers = { "head" },
                subparts = { "head_crown", "head_nape" },
                layers = { "SKINTIGHT" },
                coverage = 25,
                volume_encumbrance = 0,
                encumbrance = 0,
                materials = {
                    { id = "cotton", thickness = 0.2, coverage = 100 },
                },
            },
            {
                covers = { "head" },
                subparts = { "head_forehead" },
                layers = { "SKINTIGHT" },
                coverage = 100,
                volume_encumbrance = 0,
                encumbrance = 20,
                materials = {
                    { id = "butyl_rubber", thickness = 2, coverage = 100 },
                },
            },
            {
                covers = { "eyes" },
                layers = { "SKINTIGHT", "NORMAL" },
                coverage = 100,
                rigid_only = true,
                volume_encumbrance = 0,
                encumbrance = 10,
                materials = {
                    { id = "hard_plastic_transp", thickness = 2, coverage = 100 },
                },
            },
            {
                covers = { "mouth" },
                subparts = { "mouth_lips", "mouth_nose", "mouth_chin" },
                layers = { "SKINTIGHT", "NORMAL" },
                coverage = 100,
                encumbrance = { 20, 40 },
                materials = {
                    { id = "butyl_rubber", thickness = 2, coverage = 100 },
                    { id = "plastic", thickness = 1, coverage = 30 },
                },
            },
            {
                covers = { "mouth" },
                subparts = { "mouth_cheeks" },
                layers = { "SKINTIGHT", "NORMAL" },
                coverage = 100,
                volume_encumbrance = 0,
                encumbrance = 10,
                materials = {
                    { id = "butyl_rubber", thickness = 2, coverage = 100 },
                    { id = "plastic", thickness = 1, coverage = 25 },
                },
            },
        },
    },
    subtype_order = { "tool", "armor" },
}

-- Based on Optrel Swiss Air
ccb.content.define_item {
    id = "papr_half_mask",
    name = ccb.content.plural_text("half-face PAPR mask", "half-face PAPR masks"),
    category = "clothing",
    description = ccb.content.text("A lightweight, form-fitting mask that straps over your mouth and nose.  The mask has pre-installed tubing which attaches to a powered air purifying respirator system.  Once activated it will comfortably protect against chemical, biological, radiological, and nuclear threats.  Like a standard gas mask it must be prepared before use; unlike a standard gas mask, it will only function when paired with an active PAPR blower unit.  Safety goggles are advised!"),
    flags = { "SLEEP_IGNORE", "PAPR_MASK" },
    mass = "400 g",
    volume = "500 ml",
    price = "300 USD",
    survival_price = "15 USD 50 cent",
    materials = { "plastic" },
    symbol = "[",
    looks_like = "mask_dust",
    color = "light_gray",
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        warmth = 12,
        thickness = 2,
        environmental_protection = 3,
        filtered_protection = 16,
        portions = { { encumbrance = 10, rigid_only = true, coverage = 100, covers = { "mouth" } } },
    },
    use_actions = { "PAPR_MASK_ACTIVATE" },
    tick_actions = { "PAPR_MASK" },
}

-- Based on 3M Adflo
ccb.content.define_item {
    id = "welding_papr_helmet",
    category = "armor",
    name = ccb.content.plural_text("PAPR welding helmet", "PAPR welding helmets"),
    looks_like = "welding_mask",
    description = ccb.content.text("A helmet fit with a welding mask over a transparent full-face mask.  On the back of the helmet is a long tube which attaches to a powered air purifying respirator system.  Once activated it will comfortably protect against chemical, biological, radiological, and nuclear threats.  Like a standard gas mask it must be prepared before use; unlike a standard gas mask, it is relatively cool and comfortable, but will only function when paired with an active PAPR blower unit.  The welding shield is separate from the PAPR mask itself, so can be raised safely without compromising its ability to filter air.  Activate it to prepare it, or to push the welding mask up onto your head."),
    mass = "857 g",
    volume = "2250 ml",
    price = "700 USD",
    survival_price = "10 USD",
    materials = { { id = "plastic", portions = 4 }, { id = "hard_plastic_transp", portions = 1 } },
    symbol = "[",
    color = "dark_gray",
    qualities = { { id = "GLARE", level = 1 } },
    flags = {
        "WATERPROOF",
        "PADDED",
        "OVERSIZE",
        "SLEEP_IGNORE",
        "PAPR_MASK",
        "SUN_GLASSES",
        "FLASH_PROTECTION",
    },
    pockets = {
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "500 ml",
            mass_limit = "400 g",
            moves = 250,
            description = ccb.content.text("Pocket for an ear attachment."),
            allowed_flags = { "HELMET_EAR_ATTACHMENT" },
            inherits_flags = true,
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "500 ml",
            mass_limit = "250 g",
            moves = 250,
            description = ccb.content.text("Pocket for a nape protector."),
            allowed_flags = { "HELMET_NAPE_PROTECTOR" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            capacity = "400 ml",
            mass_limit = "400 g",
            moves = 250,
            description = ccb.content.text("Pocket for a counterweight pouch."),
            allowed_flags = { "HELMET_BACK_POUCH" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            capacity = "300 ml",
            mass_limit = "500 g",
            max_item_length = "14 cm",
            moves = 100,
            description = ccb.content.text("Pocket for a flashlight attachment."),
            allowed_flags = { "HELMET_HEAD_ATTACHMENT" },
            transparent = true,
        },
    },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        warmth = 20,
        portions = {
            {
                materials = { { id = "plastic", coverage = 100, thickness = 4 } },
                covers = { "head" },
                subparts = { "head_crown", "head_forehead" },
                coverage = 100,
                encumbrance = 10,
                layers = { "OUTER" },
            },
            {
                materials = { { id = "hard_plastic_transp", coverage = 100, thickness = 4.0 } },
                covers = { "eyes" },
                rigid_only = true,
                coverage = 100,
                encumbrance = 40,
                layers = { "OUTER" },
            },
            {
                materials = { { id = "plastic", coverage = 100, thickness = 3.0 } },
                covers = { "mouth" },
                rigid_only = true,
                coverage = 100,
                encumbrance = 5,
                layers = { "OUTER" },
            },
        },
        environmental_protection = 4,
        filtered_protection = 16,
    },
    use_actions = {
        "PAPR_MASK_ACTIVATE",
        {
            kind = "transform",
            message = ccb.content.text("You raise the welding shield."),
            target = "welding_papr_helmet_raised",
            menu_text = ccb.content.text("Raise welding shield"),
        },
    },
    tick_actions = { "PAPR_MASK" },
}

-- Based on 3M Adflo
ccb.content.define_item {
    id = "welding_papr_helmet_raised",
    category = "armor",
    copy_from = "welding_papr_helmet",
    name = ccb.content.plural_text("PAPR welding helmet (raised)", "PAPR welding helmets (raised)"),
    looks_like = "welding_mask_raised",
    description = ccb.content.text("A helmet fit with a welding mask over a transparent full-face mask.  On the back of the helmet is a long tube which attaches to a powered air purifying respirator system.  Once activated it will comfortably protect against chemical, biological, radiological, and nuclear threats.  Like a standard gas mask it must be prepared before use; unlike a standard gas mask, it is relatively cool and comfortable, but will only function when paired with an active PAPR blower unit.  The welding shield is separate from the PAPR mask itself, so can be raised safely without compromising its ability to filter air.  The welding mask it raised.  Activate it to prepare it, or to push the welding mask back down over your face."),
    flags = { "WATERPROOF", "PADDED", "OVERSIZE", "SLEEP_IGNORE", "PAPR_MASK" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        portions = {
            {
                materials = { { id = "plastic", coverage = 100, thickness = 7 } },
                covers = { "head" },
                subparts = { "head_crown", "head_forehead" },
                coverage = 100,
                encumbrance = 20,
                layers = { "OUTER" },
            },
            {
                materials = { { id = "hard_plastic_transp", coverage = 100, thickness = 2.0 } },
                covers = { "eyes" },
                rigid_only = true,
                coverage = 100,
                encumbrance = 5,
                layers = { "OUTER" },
            },
            {
                materials = { { id = "plastic", coverage = 100, thickness = 1.0 } },
                covers = { "mouth" },
                rigid_only = true,
                coverage = 100,
                encumbrance = 5,
                layers = { "OUTER" },
            },
        },
    },
    use_actions = {
        "PAPR_MASK_ACTIVATE",
        {
            kind = "transform",
            message = ccb.content.text("You lower the welding shield."),
            target = "welding_papr_helmet",
            menu_text = ccb.content.text("Lower welding shield"),
        },
    },
    tick_actions = { "PAPR_MASK" },
}

-- 2019 commercial models can operate at under 0.375W with the IR illuminator on
ccb.content.define_item {
    id = "goggles_nv_on",
    copy_from = "goggles_nv",
    name = ccb.content.plural_text("light amp goggles (on)", "light amp goggles (on)"),
    description = ccb.content.text("A pair of battery-powered goggles that use a infrared LED in conjunction with a IR camera, allowing you to see in the dark.  It is turned on, and continually draining batteries.  Use it to turn them off."),
    materials = { "plastic", "steel" },
    revert_to = "goggles_nv",
    inheritance = { add = { flags = { "TRADER_AVOID", "NVG_GREEN", "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "375 mW" },
    armor = {
        warmth = 15,
        portions = { { encumbrance = 20, coverage = 100, covers = { "eyes" }, rigid_only = true } },
    },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("Your %s deactivates."),
            target = "goggles_nv",
        },
    },
}

ccb.content.define_item {
    id = "basic_papr_belt_off",
    name = ccb.content.plural_text("PAPR blower (off)", "PAPR blowers (off)"),
    description = "A blower unit for a powered air purifying respirator system.  It has been attached to a basic rubber and plastic belt.  When active and loaded with a charged battery and a filter canister, it can be paired with a prepared PAPR mask to provide excellent protection against chemical, biological, radiological, and nuclear threats.",
    symbol = "[",
    color = "black",
    looks_like = "leather_belt",
    mass = "918 g",
    volume = "1000 ml",
    price = "300 USD",
    survival_price = "5 USD",
    flags = { "BELTED", "OVERSIZE", "ELECTRONIC", "WATER_BREAK_ACTIVE" },
    materials = {
        { id = "plastic", portions = 2 },
        { id = "rubber", portions = 1 },
    },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            id = "papr_blower_filter",
            default_magazine = "gasfilter_med",
            rigid = true,
            allowed_flags = { "GASFILTER_MED" },
        },
        {
            kind = "MAGAZINE_WELL",
            id = "papr_blower_battery",
            default_magazine = "medium_battery_cell",
            rigid = true,
            allowed_flags = { "BATTERY_MEDIUM" },
        },
    },
    use_actions = {
        {
            kind = "transform",
            target = "basic_papr_belt_on",
            need_charges = 1,
            message = "You activate your %s and the fan starts to audibly whoosh.",
            need_charges_message = "The batteries are dead.",
        },
    },
    tool = {
        ammo_types = { "battery", "gasfilter_m" },
        consumption_per_use = {
            { pocket = "papr_blower_battery", count = 1 },
        },
    },
    armor = {
        thickness = 1,
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_waist" },
                coverage = 50,
                volume_encumbrance = 0.35,
                encumbrance = 4,
            },
        },
    },
    subtype_order = { "tool", "armor" },
}

ccb.content.define_item {
    id = "basic_papr_belt_on",
    copy_from = "basic_papr_belt_off",
    name = ccb.content.plural_text("PAPR blower (on)", "PAPR blowers (on)"),
    description = "An active blower unit for a powered air purifying respirator system.  It has been attached to a basic rubber and plastic belt.  If paired with a prepared PAPR mask, this will provide excellent protection against chemical, biological, radiological, and nuclear threats.  The fan is audibly blowing.",
    symbol = "[",
    color = "black",
    looks_like = "leather_belt",
    mass = "918 g",
    volume = "1000 ml",
    revert_to = "basic_papr_belt_off",
    flags = {
        "BELTED",
        "OVERSIZE",
        "ELECTRONIC",
        "TRADER_AVOID",
        "WATER_BREAK",
        "SPAWN_ACTIVE",
        "PAPR_BLOWER",
    },
    materials = {
        { id = "plastic", portions = 2 },
        { id = "rubber", portions = 1 },
    },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            id = "papr_blower_filter",
            default_magazine = "gasfilter_med",
            rigid = true,
            allowed_flags = { "GASFILTER_MED" },
        },
        {
            kind = "MAGAZINE_WELL",
            id = "papr_blower_battery",
            default_magazine = "medium_battery_cell",
            rigid = true,
            allowed_flags = { "BATTERY_MEDIUM" },
        },
    },
    use_actions = {
        {
            kind = "transform",
            target = "basic_papr_belt_off",
            ammo_scale = 0,
            message = "You turn off the %s.",
            menu_text = "Turn off",
        },
    },
    tick_actions = {
        "PAPR_BLOWER",
        {
            kind = "sound",
            sound_id = "humming",
            sound_variant = "machinery",
            sound_type = "movement",
            volume = 12,
            message = "whooooo…",
        },
    },
    tool = {
        turns_per_charge = 240,
        ammo_types = { "battery", "gasfilter_m" },
        consumption_per_use = {
            { pocket = "papr_blower_battery", count = 1 },
        },
    },
    armor = {
        thickness = 1,
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_waist" },
                coverage = 50,
                volume_encumbrance = 0.35,
                encumbrance = 4,
            },
        },
    },
    subtype_order = { "tool", "armor" },
}

ccb.content.define_item {
    id = "military_papr_blower_off",
    name = ccb.content.plural_text("military PAPR blower (off)", "military PAPR blowers (off)"),
    description = "A sturdy blower unit for a powered air purifying respirator system.  Its large triangular body is designed to be worn on the back.  When active and loaded with a charged battery and a filter canister, it can be paired with a prepared PAPR mask to provide excellent protection against chemical, biological, radiological, and nuclear threats.",
    symbol = "[",
    color = "black",
    looks_like = "backpack",
    mass = "653 g",
    volume = "3589 ml",
    price = "1400 USD",
    survival_price = "15 USD",
    flags = { "BELTED", "OVERSIZE", "ELECTRONIC" },
    materials = {
        { id = "plastic", portions = 2 },
        { id = "rubber", portions = 1 },
    },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            id = "papr_blower_filter",
            default_magazine = "gasfilter_med",
            rigid = true,
            allowed_flags = { "GASFILTER_MED" },
        },
        {
            kind = "MAGAZINE_WELL",
            id = "papr_blower_battery",
            default_magazine = "heavy_plus_battery_cell",
            rigid = true,
            allowed_flags = { "BATTERY_HEAVY" },
        },
    },
    use_actions = {
        {
            kind = "transform",
            target = "military_papr_blower_on",
            need_charges = 1,
            message = "You activate your %s and the fan starts to audibly whoosh.",
            need_charges_message = "The batteries are dead.",
        },
    },
    tool = {
        ammo_types = { "battery", "gasfilter_m" },
        consumption_per_use = {
            { pocket = "papr_blower_battery", count = 1 },
        },
    },
    armor = {
        thickness = 2,
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
                coverage = 40,
                volume_encumbrance = 0.35,
                encumbrance = 4,
            },
        },
    },
    subtype_order = { "tool", "armor" },
}

ccb.content.define_item {
    id = "military_papr_blower_on",
    copy_from = "military_papr_blower_off",
    name = ccb.content.plural_text("military PAPR blower (on)", "military PAPR blowers (on)"),
    description = "An active, sturdy blower unit for a powered air purifying respirator system.  Its large triangular body is designed to be worn on the back.  When paired with a prepared PAPR mask, this will provide excellent protection against chemical, biological, radiological, and nuclear threats.  The fan is audibly blowing.",
    symbol = "[",
    color = "black",
    looks_like = "backpack",
    mass = "653 g",
    volume = "3589 ml",
    revert_to = "military_papr_blower_off",
    flags = { "BELTED", "OVERSIZE", "ELECTRONIC", "TRADER_AVOID", "SPAWN_ACTIVE", "PAPR_BLOWER" },
    materials = {
        { id = "plastic", portions = 2 },
        { id = "rubber", portions = 1 },
    },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            id = "papr_blower_filter",
            default_magazine = "gasfilter_med",
            rigid = true,
            allowed_flags = { "GASFILTER_MED" },
        },
        {
            kind = "MAGAZINE_WELL",
            id = "papr_blower_battery",
            default_magazine = "heavy_plus_battery_cell",
            rigid = true,
            allowed_flags = { "BATTERY_HEAVY" },
        },
    },
    use_actions = {
        {
            kind = "transform",
            target = "military_papr_blower_off",
            ammo_scale = 0,
            message = "You turn off the %s.",
            menu_text = "Turn off",
        },
    },
    tick_actions = {
        "PAPR_BLOWER",
        {
            kind = "sound",
            sound_id = "humming",
            sound_variant = "machinery",
            sound_type = "movement",
            volume = 12,
            message = "whooooo…",
        },
    },
    tool = {
        turns_per_charge = 240,
        ammo_types = { "battery", "gasfilter_m" },
        consumption_per_use = {
            { pocket = "papr_blower_battery", count = 1 },
        },
    },
    armor = {
        thickness = 2,
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
                coverage = 40,
                volume_encumbrance = 0.35,
                encumbrance = 4,
            },
        },
    },
    subtype_order = { "tool", "armor" },
}

ccb.content.define_item {
    id = "molle_papr_blower_off",
    name = ccb.content.plural_text("modular PAPR blower (off)", "modular PAPR blowers (off)"),
    description = "A blower unit for a powered air purifying respirator system, built from a flexible silicon and butyl rubber blend.  Its components are arranged linearly in a narrow strip close to the body and is outfitted with straps to wear it about the waist.  If paired with the appropriate straps, it can also attached to any compatible MOLLE system.  When active and loaded with a charged battery and a filter canister, it can be paired with a prepared PAPR mask to provide excellent protection against chemical, biological, radiological, and nuclear threats.",
    symbol = "[",
    color = "dark_gray",
    looks_like = "backpack",
    mass = "920 g",
    volume = "3000 ml",
    price = "1600 USD",
    survival_price = "20 USD",
    flags = { "WATER_FRIENDLY", "BELTED", "OVERSIZE", "ELECTRONIC" },
    materials = {
        { id = "plastic", portions = 2 },
        { id = "butyl_rubber", portions = 1 },
    },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            id = "papr_blower_filter",
            default_magazine = "gasfilter_med",
            rigid = true,
            allowed_flags = { "GASFILTER_MED" },
        },
        {
            kind = "MAGAZINE_WELL",
            id = "papr_blower_battery",
            default_magazine = "heavy_plus_battery_cell",
            rigid = true,
            allowed_flags = { "BATTERY_HEAVY" },
        },
    },
    use_actions = {
        {
            kind = "transform",
            target = "molle_papr_blower_on",
            need_charges = 1,
            message = "You activate your %s and the fan starts to audibly whoosh.",
            need_charges_message = "The batteries are dead.",
        },
    },
    tool = {
        ammo_types = { "battery", "gasfilter_m" },
        consumption_per_use = {
            { pocket = "papr_blower_battery", count = 1 },
        },
    },
    armor = {
        thickness = 2,
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_waist" },
                coverage = 30,
                volume_encumbrance = 0.35,
                encumbrance = 2,
            },
        },
    },
    subtype_order = { "tool", "armor" },
}

ccb.content.define_item {
    id = "molle_papr_blower_on",
    copy_from = "molle_papr_blower_off",
    name = ccb.content.plural_text("modular PAPR blower (on)", "modular PAPR blowers (on)"),
    description = "An active blower unit for a powered air purifying respirator system, built from a flexible silicon and butyl rubber blend.  Its components are arranged linearly in a narrow strip close to the body and is outfitted with straps to wear it about the waist.  If paired with the appropriate straps, it can also attached to any compatible MOLLE system.  When paired with a prepared PAPR mask, this will provide excellent protection against chemical, biological, radiological, and nuclear threats.  The fan is quietly blowing.",
    symbol = "[",
    color = "dark_gray",
    looks_like = "backpack",
    mass = "920 g",
    volume = "3000 ml",
    revert_to = "molle_papr_blower_off",
    flags = {
        "WATER_FRIENDLY",
        "BELTED",
        "OVERSIZE",
        "ELECTRONIC",
        "TRADER_AVOID",
        "SPAWN_ACTIVE",
        "PAPR_BLOWER",
    },
    materials = {
        { id = "plastic", portions = 2 },
        { id = "butyl_rubber", portions = 1 },
    },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            id = "papr_blower_filter",
            default_magazine = "gasfilter_med",
            rigid = true,
            allowed_flags = { "GASFILTER_MED" },
        },
        {
            kind = "MAGAZINE_WELL",
            id = "papr_blower_battery",
            default_magazine = "heavy_plus_battery_cell",
            rigid = true,
            allowed_flags = { "BATTERY_HEAVY" },
        },
    },
    use_actions = {
        {
            kind = "transform",
            target = "molle_papr_blower_off",
            ammo_scale = 0,
            message = "You turn off the %s.",
            menu_text = "Turn off",
        },
    },
    tick_actions = {
        "PAPR_BLOWER",
        {
            kind = "sound",
            sound_id = "humming",
            sound_variant = "machinery",
            sound_type = "movement",
            volume = 12,
            message = "whooooo…",
        },
    },
    tool = {
        turns_per_charge = 240,
        ammo_types = { "battery", "gasfilter_m" },
        consumption_per_use = {
            { pocket = "papr_blower_battery", count = 1 },
        },
    },
    armor = {
        thickness = 2,
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_waist" },
                coverage = 30,
                volume_encumbrance = 0.35,
                encumbrance = 2,
            },
        },
    },
    subtype_order = { "tool", "armor" },
}

ccb.content.define_item {
    id = "goggles_ir",
    category = "clothing",
    symbol = "[",
    color = "dark_gray",
    name = ccb.content.plural_text("infrared goggles", "infrared goggles"),
    description = ccb.content.text("A pair of battery-powered goggles that grant infrared vision, allowing you to see warm-blooded creatures in the dark.  Use it to turn them on."),
    flags = { "FRAGILE", "OUTER", "ELECTRONIC", "MUNDANE" },
    faults = { { group = "electronic_general" } },
    price = "920 USD",
    survival_price = "25 USD",
    materials = { "plastic", "steel" },
    mass = "1240 g",
    volume = "1 L",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_LIGHT", "BATTERY_ULTRA_LIGHT" },
            default_magazine = "light_battery_cell",
        },
    },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1, ammo_types = "battery" },
    armor = {
        warmth = 10,
        environmental_protection = 3,
        thickness = 2,
        portions = { { encumbrance = 40, coverage = 100, covers = { "eyes" }, rigid_only = true } },
    },
    artifact = { enchantments = { "THERMAL_VISION_GOOD" } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You activate your %s."),
            target = "goggles_ir_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}

ccb.content.define_item {
    id = "goggles_ir_on",
    copy_from = "goggles_ir",
    name = ccb.content.plural_text("infrared goggles (on)", "infrared goggles (on)"),
    description = ccb.content.text("A pair of battery-powered goggles that grant infrared vision, allowing you to see warm-blooded creatures in the dark.  Use it to turn them off."),
    materials = { "plastic", "steel" },
    faults = { { group = "electronic_general" } },
    revert_to = "goggles_ir",
    inheritance = { add = { flags = { "TRADER_AVOID", "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "1 W" },
    armor = {
        warmth = 15,
        portions = { { encumbrance = 20, coverage = 100, covers = { "eyes" }, rigid_only = true } },
    },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("Your %s deactivates."),
            target = "goggles_ir",
        },
    },
}

ccb.content.define_item {
    id = "wearable_rx12",
    category = "clothing",
    symbol = "[",
    color = "blue",
    name = ccb.content.plural_text("wearable RX12 jet injector", "wearable RX12 jet injectors"),
    description = ccb.content.text("A modified RX12 jet injector which can be worn on the body.  A label on the side warns against using more than two doses per hour."),
    price = "400 USD",
    survival_price = "10 USD",
    materials = { "ceramic", "superalloy" },
    flags = { "OVERSIZE" },
    mass = "364 g",
    volume = "750 ml",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ampoule = 2 } } },
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 1 },
    armor = { thickness = 3 },
    use_actions = { "JET_INJECTOR" },
}

ccb.content.define_item {
    id = "rx11_stimpack",
    category = "clothing",
    symbol = "[",
    color = "dark_gray",
    name = ccb.content.plural_text("RX11 stimulant delivery system", "RX11 stimulant delivery system"),
    description = ccb.content.text("A Rivtech RX11 stimulant delivery system, a jet autoinjector system worn on the user's body.  A simple press of its activator injects powerful chemical stimulants into the bloodstream without using a needle."),
    price = "400 USD",
    survival_price = "10 USD",
    materials = { "superalloy", "kevlar_rigid" },
    flags = { "OVERSIZE" },
    mass = "212 g",
    volume = "750 ml",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { stimpack_ammo = 5 } } },
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 1, ammo_types = "stimpack_ammo" },
    armor = { thickness = 3 },
    use_actions = { "STIMPACK" },
}

ccb.content.define_item {
    id = "mask_h20survivor",
    category = "armor",
    symbol = "[",
    color = "dark_gray",
    name = ccb.content.plural_text("handmade divemask", "handmade divemasks"),
    description = ccb.content.text("A custom-built, armored rebreather mask that covers the face and eyes.  Provides excellent protection from harm as well providing breathing gas while underwater.  Use it to turn it on."),
    flags = { "VARSIZE", "STURDY", "WATER_FRIENDLY", "SWIM_GOGGLES" },
    price = "400 USD",
    survival_price = "20 USD",
    materials = { "kevlar_layered", "plastic" },
    mass = "982 g",
    volume = "1500 ml",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "REBREATHER_CART" },
            default_magazine = "rebreather_cartridge_o2",
        },
    },
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 1, ammo_types = { "rebreather_filter", "rebreather_o2_regenerator" } },
    armor = {
        warmth = 15,
        environmental_protection = 4,
        portions = {
            {
                materials = {
                    { id = "plastic", coverage = 100, thickness = 3.0 },
                    { id = "neoprene", coverage = 25, thickness = 1.0 },
                },
                covers = { "eyes" },
                rigid_only = true,
                coverage = 100,
                encumbrance = 5,
            },
            {
                materials = {
                    {
                        id = "kevlar_layered",
                        coverage = 100,
                        thickness = 1.1,
                        ignore_sheet_thickness = true,
                    },
                    { id = "plastic", coverage = 100, thickness = 1.0 },
                    { id = "aluminum", coverage = 75, thickness = 0.5 },
                    { id = "neoprene", coverage = 50, thickness = 1.0 },
                },
                covers = { "mouth" },
                rigid_only = true,
                coverage = 100,
                encumbrance = 30,
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You activate your %s."),
            target = "mask_h20survivor_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The filter is used up."),
        },
    },
}

ccb.content.define_item {
    id = "mask_h20survivor_on",
    copy_from = "mask_h20survivor",
    name = ccb.content.plural_text("handmade divemask (on)", "handmade divemasks (on)"),
    description = ccb.content.text("A custom-built, armored rebreather mask that covers the face and eyes.  Provides excellent protection from harm as well providing breathing gas while underwater.  It is turned on, and continually consuming its filter.  Use it to turn it off."),
    flags = { "VARSIZE", "STURDY", "WATER_FRIENDLY", "REBREATHER", "SWIM_GOGGLES", "SPAWN_ACTIVE" },
    revert_to = "mask_h20survivor",
    subtype_order = { "tool", "armor" },
    tool = { turns_per_charge = 60 },
    armor = { environmental_protection = 16 },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("Your %s deactivates."),
            target = "mask_h20survivor",
        },
    },
}

ccb.content.define_item {
    id = "mask_h20survivorxl",
    copy_from = "mask_h20survivor",
    looks_like = "mask_h20survivor",
    name = ccb.content.plural_text("handmade divemask", "handmade divemasks"),
    description = ccb.content.text("A custom-built, armored rebreather mask that covers the face and eyes.  Provides excellent protection from harm as well providing breathing gas while underwater.  Use it to turn it on."),
    flags = { "VARSIZE", "STURDY", "WATER_FRIENDLY", "SWIM_GOGGLES", "OVERSIZE", "PREFIX_XL" },
    inheritance = { scale = { mass = 1.25, volume = 1.25, price = 1.5 } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You activate your %s."),
            target = "mask_h20survivorxl_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The filter is used up."),
        },
    },
}

ccb.content.define_item {
    id = "mask_h20survivorxs",
    copy_from = "mask_h20survivor",
    looks_like = "mask_h20survivor",
    name = ccb.content.plural_text("handmade divemask", "handmade divemasks"),
    description = ccb.content.text("A custom-built, armored rebreather mask that covers the face and eyes.  Provides excellent protection from harm as well providing breathing gas while underwater.  Use it to turn it on."),
    flags = { "VARSIZE", "STURDY", "WATER_FRIENDLY", "SWIM_GOGGLES", "UNDERSIZE", "PREFIX_XS" },
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You activate your %s."),
            target = "mask_h20survivorxs_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The filter is used up."),
        },
    },
}

ccb.content.define_item {
    id = "mask_h20survivorxl_on",
    copy_from = "mask_h20survivorxl",
    name = ccb.content.plural_text("handmade divemask (on)", "handmade divemasks (on)"),
    description = ccb.content.text("A custom-built, armored rebreather mask that covers the face and eyes regardless of your state of mutation.  Provides excellent protection from harm as well providing breathing gas while underwater.  It is turned on, and continually consuming its filter.  Use it to turn it off."),
    flags = {
        "VARSIZE", "STURDY", "WATER_FRIENDLY", "REBREATHER", "SWIM_GOGGLES", "OVERSIZE", "PREFIX_XL",
        "TRADER_AVOID", "SPAWN_ACTIVE",
    },
    revert_to = "mask_h20survivorxl",
    subtype_order = { "tool", "armor" },
    tool = { turns_per_charge = 60 },
    armor = { environmental_protection = 16 },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("Your %s deactivates."),
            target = "mask_h20survivorxl",
        },
    },
}

ccb.content.define_item {
    id = "mask_h20survivorxs_on",
    copy_from = "mask_h20survivor",
    looks_like = "mask_h20survivor",
    name = ccb.content.plural_text("handmade divemask (on)", "handmade divemasks (on)"),
    description = ccb.content.text("A custom-built, armored rebreather mask that covers the face and eyes.  Provides excellent protection from harm as well providing breathing gas while underwater.  Use it to turn it on."),
    flags = {
        "VARSIZE", "STURDY", "WATER_FRIENDLY", "REBREATHER", "SWIM_GOGGLES", "UNDERSIZE", "PREFIX_XS",
        "TRADER_AVOID", "SPAWN_ACTIVE",
    },
    revert_to = "mask_h20survivorxs",
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
    subtype_order = { "tool", "armor" },
    tool = { turns_per_charge = 60 },
    armor = { environmental_protection = 16 },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("Your %s deactivates."),
            target = "mask_h20survivorxs",
        },
    },
}

ccb.content.define_item {
    id = "rad_monitor",
    category = "clothing",
    symbol = "[",
    color = "dark_gray",
    name = ccb.content.plural_text("radiation biomonitor", "radiation biomonitors"),
    description = ccb.content.text("A small, battery-powered biometric safety device worn on the wrist.  Activate to check your current level of radiation exposure."),
    price = "600 USD",
    survival_price = "10 USD",
    materials = { "plastic", "aluminum" },
    mass = "150 g",
    volume = "150 ml",
    flags = { "BELTED", "FRAGILE", "ALLOWS_NATURAL_ATTACKS", "WATER_FRIENDLY", "OVERSIZE" },
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
        thickness = 0.1,
        portions = {
            {
                coverage = 50,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r" },
            },
        },
    },
    use_actions = { "RADGLOVE" },
}

ccb.content.define_item {
    id = "hairpin",
    category = "clothing",
    symbol = "[",
    color = "brown",
    name = ccb.content.plural_text("hairpin", "hairpins"),
    description = ccb.content.text("A plain hairpin to keep your hair in place."),
    price = "4 cent",
    survival_price = "10 cent",
    materials = { "steel" },
    mass = "200 mg",
    volume = "1 ml",
    length = "45 mm",
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}

ccb.content.define_item {
    id = "fc_hairpin",
    copy_from = "hairpin",
    color = "pink",
    name = ccb.content.plural_text("fancy hairpin", "fancy hairpins"),
    description = ccb.content.text("A pink hairpin with cute flower textures."),
    price = "10 USD",
    survival_price = "5 cent",
    materials = { "plastic" },
    mass = "100 mg",
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}

ccb.content.define_item {
    id = "towel",
    symbol = ",",
    color = "cyan",
    name = ccb.content.plural_text("towel", "towels"),
    description = ccb.content.text("A large, fluffy towel.  It could be used to dry yourself.  Any person that can travel the length and breadth of the apocalypse, rough it, slum it, struggle against terrible odds, win through, and still know where their towel is, is clearly a force to be reckoned with."),
    price = "45 USD",
    survival_price = "10 cent",
    materials = { "cotton" },
    mass = "250 g",
    volume = "500 ml",
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        warmth = 8,
        thickness = 0.3,
        portions = { { coverage = 50, covers = { "torso", "leg_l", "leg_r" } } },
    },
    use_actions = { "TOWEL" },
}

ccb.content.define_item {
    id = "towel_wet",
    symbol = ",",
    color = "blue",
    name = ccb.content.plural_text("towel", "towels"),
    description = ccb.content.text("A large, sopping wet towel.  If you wait a little bit, it should dry out.  Don't panic."),
    price = "20 USD",
    survival_price = "0 cent",
    materials = { "cotton", "water" },
    mass = "375 g",
    volume = "500 ml",
    revert_to = "towel",
    flags = { "WET", "SLEEP_IGNORE" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = { thickness = 0.3, portions = { { coverage = 50, covers = { "torso", "leg_l", "leg_r" } } } },
    use_actions = { "TOWEL" },
}

ccb.content.define_item {
    id = "straw_fedora",
    category = "clothing",
    name = ccb.content.plural_text("straw fedora", "straw fedoras"),
    mass = "300 g",
    color = "light_gray",
    symbol = "[",
    description = ccb.content.text("A straw fedora hat, comfortable and stylish.  Its brim helps keep the sun out of your eyes."),
    price = "50 USD",
    survival_price = "50 cent",
    materials = { "paper" },
    volume = "1250 ml",
    flags = { "VARSIZE", "SUN_GLASSES" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        warmth = 5,
        environmental_protection = 1,
        thickness = 1,
        portions = { { encumbrance = 10, coverage = 100, covers = { "head" }, subparts = { "head_crown" } } },
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Tip"),
            target = "straw_fedora",
            message = ccb.content.text("You tip your fedora."),
        },
    },
}

ccb.content.define_item {
    id = "thermal_outfit",
    category = "clothing",
    symbol = "[",
    color = "light_gray",
    name = ccb.content.plural_text("thermal electric outfit", "thermal electric outfits"),
    description = ccb.content.text("A suit of thin thermal underwear that covers you from head to toe and is equipped with internal battery-powered heating elements.  Use it to turn it on."),
    flags = { "VARSIZE", "SKINTIGHT", "WATER_BREAK" },
    price = "300 USD",
    survival_price = "7 USD 50 cent",
    materials = { "cotton" },
    mass = "2250 g",
    volume = "4500 ml",
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
        portions = {
            {
                coverage = 100,
                covers = {
                    "head",
                    "mouth",
                    "torso",
                    "arm_l",
                    "arm_r",
                    "leg_l",
                    "leg_r",
                    "hand_l",
                    "hand_r",
                    "foot_l",
                    "foot_r",
                },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You turn the heating elements on."),
            target = "thermal_outfit_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}

ccb.content.define_item {
    id = "thermal_outfit_on",
    copy_from = "thermal_outfit",
    name = ccb.content.plural_text("thermal electric outfit (on)", "thermal electric outfits (on)"),
    description = ccb.content.text("A suit of thin thermal underwear that covers you from head to toe and is equipped with internal battery-powered heating elements.  It is currently on, and continually draining batteries.  Use it to turn it off."),
    flags = { "VARSIZE", "SKINTIGHT", "TRADER_AVOID", "SPAWN_ACTIVE" },
    revert_to = "thermal_outfit",
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "8 W" },
    armor = { warmth = 60 },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You turn the heating elements off."),
            target = "thermal_outfit",
        },
    },
}

ccb.content.define_item {
    id = "turtleneck",
    name = ccb.content.plural_text("turtleneck", "turtlenecks"),
    description = ccb.content.text("A tasteful wool turtleneck, modeled after cashmere.  Unencumbering and warm, but lacking storage."),
    category = "clothing",
    mass = "478 g",
    volume = "2500 ml",
    price = "50 USD",
    survival_price = "60 cent",
    materials = { "wool" },
    symbol = "[",
    looks_like = "sweater",
    color = "white",
    flags = { "VARSIZE", "ALLOWS_NATURAL_ATTACKS" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        warmth = 30,
        thickness = 0.5,
        environmental_protection = 2,
        portions = {
            { encumbrance = 3, coverage = 100, covers = { "torso", "arm_l", "arm_r", "mouth" } },
            { encumbrance = 1, coverage = 100, covers = { "head" }, subparts = { "head_throat" } },
        },
    },
    use_actions = {
        {
            kind = "transform",
            target = "turtleneck_rolled",
            menu_text = ccb.content.text("Roll neck"),
            message = ccb.content.text("You adjust the neck and collar of the turtleneck."),
        },
    },
}

ccb.content.define_item {
    id = "turtleneck_rolled",
    name = ccb.content.plural_text("turtleneck (rolled)", "turtlenecks (rolled)"),
    description = ccb.content.text("This wool turtleneck's neck is rolled out of the way of the mouth."),
    category = "clothing",
    mass = "478 g",
    volume = "2500 ml",
    price = "50 USD",
    survival_price = "60 cent",
    materials = { "wool" },
    symbol = "[",
    looks_like = "sweater",
    color = "white",
    flags = { "VARSIZE", "ALLOWS_NATURAL_ATTACKS" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        warmth = 30,
        thickness = 0.5,
        environmental_protection = 2,
        portions = {
            { encumbrance = 3, coverage = 100, covers = { "torso", "arm_l", "arm_r" } },
            { encumbrance = 1, coverage = 100, covers = { "head" }, subparts = { "head_throat" } },
        },
    },
    use_actions = {
        {
            kind = "transform",
            target = "turtleneck",
            menu_text = ccb.content.text("Unroll neck"),
            message = ccb.content.text("You adjust the neck and collar of the turtleneck."),
        },
    },
}

ccb.content.define_item {
    id = "turtleneck_shirt",
    name = ccb.content.plural_text("turtleneck shirt", "turtleneck shirts"),
    description = ccb.content.text("A tasteful cotton turtleneck shirt, thick for a shirt, thin for a sweater, and completely lacking storage."),
    category = "clothing",
    mass = "300 g",
    volume = "2000 ml",
    price = "20 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "sweater",
    color = "white",
    flags = { "VARSIZE", "ALLOWS_NATURAL_ATTACKS" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        warmth = 20,
        thickness = 0.5,
        environmental_protection = 1,
        portions = {
            { encumbrance = 2, coverage = 100, covers = { "torso", "arm_l", "arm_r", "mouth" } },
            { encumbrance = 0, coverage = 100, covers = { "head" }, subparts = { "head_throat" } },
        },
    },
    use_actions = {
        {
            kind = "transform",
            target = "turtleneck_shirt_rolled",
            menu_text = ccb.content.text("Roll neck"),
            message = ccb.content.text("You adjust the neck and collar of the turtleneck shirt."),
        },
    },
}

ccb.content.define_item {
    id = "turtleneck_shirt_rolled",
    name = ccb.content.plural_text("turtleneck shirt (rolled)", "turtleneck shirts (rolled)"),
    description = ccb.content.text("This turtleneck shirt's neck is rolled out of the way of the mouth."),
    category = "clothing",
    mass = "300 g",
    volume = "2000 ml",
    price = "20 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "sweater",
    color = "white",
    flags = { "VARSIZE", "ALLOWS_NATURAL_ATTACKS" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        warmth = 20,
        thickness = 0.5,
        environmental_protection = 1,
        portions = {
            { encumbrance = 2, coverage = 100, covers = { "torso", "arm_l", "arm_r" } },
            { encumbrance = 0, coverage = 100, covers = { "head" }, subparts = { "head_throat" } },
        },
    },
    use_actions = {
        {
            kind = "transform",
            target = "turtleneck_shirt",
            menu_text = ccb.content.text("Unroll neck"),
            message = ccb.content.text("You adjust the neck and collar of the turtleneck shirt."),
        },
    },
}

-- not forehead or nape
ccb.content.define_item {
    id = "mask_ski",
    name = ccb.content.plural_text("ski mask", "ski masks"),
    category = "clothing",
    mass = "86 g",
    color = "dark_gray",
    symbol = "[",
    description = ccb.content.text("A warm wool mask that protects the head and face from the cold.  It covers most of your head and mouth, and can be adjusted to hang around your throat instead."),
    price = "18 USD",
    survival_price = "2 USD 50 cent",
    materials = { "wool" },
    volume = "250 ml",
    flags = { "VARSIZE", "SKINTIGHT" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        warmth = 25,
        thickness = 1,
        environmental_protection = 2,
        portions = {
            {
                encumbrance = 6,
                coverage = 100,
                covers = { "head" },
                subparts = { "head_crown", "head_ear_r", "head_ear_l", "head_throat" },
            },
            {
                encumbrance = 10,
                coverage = 100,
                covers = { "mouth" },
                subparts = { "mouth_lips", "mouth_cheeks", "mouth_chin" },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Wear as collar"),
            message = ccb.content.text("You adjust your ski mask for less warmth."),
            target = "mask_ski_loose",
        },
    },
}

ccb.content.define_item {
    id = "mask_ski_loose",
    name = ccb.content.plural_text("ski mask (collar)", "ski masks (collar)"),
    category = "clothing",
    mass = "86 g",
    color = "dark_gray",
    revert_to = "mask_ski",
    symbol = "[",
    description = ccb.content.text("A warm wool mask that protects the head and face from the cold.  It is wrapped around your throat, and can be adjusted to cover your mouth and more of your head."),
    price = "18 USD",
    survival_price = "2 USD 50 cent",
    materials = { "wool" },
    volume = "250 ml",
    flags = { "VARSIZE", "SKINTIGHT", "COLLAR" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        warmth = 25,
        thickness = 1,
        environmental_protection = 1,
        portions = {
            {
                encumbrance = 4,
                coverage = 20,
                covers = { "head" },
                subparts = { "head_nape", "head_throat" },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Wear around head"),
            message = ccb.content.text("You adjust your ski mask for more warmth."),
            target = "mask_ski",
        },
    },
}

-- Use of %s not currently supported.
ccb.content.define_item {
    id = "whistle",
    name = ccb.content.plural_text("whistle", "whistles"),
    volume = "10 ml",
    description = ccb.content.text("A simple metal whistle, with a cord to wear it around your neck."),
    mass = "25 g",
    color = "light_gray",
    price = "2 USD",
    survival_price = "50 cent",
    materials = { "steel", "cotton" },
    flags = { "WATER_FRIENDLY", "BELTED" },
    symbol = "[",
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = { portions = { { coverage = 1, covers = { "torso" }, subparts = { "torso_neck" } } } },
    use_actions = {
        {
            kind = "manualnoise",
            message = ccb.content.text("You blow the whistle."),
            sound_message = ccb.content.text("FWEEEET!"),
            sound_id = "misc",
            sound_variant = "whistle",
            volume = 100,
            moves = 100,
        },
    },
}

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

ccb.content.define_item {
    id = "electric_blanket",
    name = ccb.content.plural_text("electric blanket", "electric blankets"),
    description = ccb.content.text("A heated blanket made of polyester.  The most comfortable thing on Earth.  Its power drain is usually negligible, but without being able to plug it into a wall, it chews through batteries insanely quickly."),
    mass = "1123 g",
    volume = "2500 ml",
    price = "55 USD",
    survival_price = "2 USD 50 cent",
    materials = { "nylon" },
    symbol = "[",
    color = "brown",
    flags = { "OVERSIZE", "OUTER", "ALLOWS_NATURAL_ATTACKS", "WATER_BREAK" },
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
        warmth = 50,
        thickness = 1,
        environmental_protection = 2,
        portions = {
            {
                encumbrance = 35,
                coverage = 100,
                covers = {
                    "torso",
                    "arm_l",
                    "arm_r",
                    "hand_l",
                    "hand_r",
                    "leg_l",
                    "leg_r",
                    "foot_l",
                    "foot_r",
                },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You turn the heating elements on."),
            target = "electric_blanket_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
        { kind = "link_up", cable_length = 3, charge_rate = "110 W" },
    },
}

ccb.content.define_item {
    id = "electric_blanket_on",
    name = ccb.content.plural_text("electric blanket (on)", "electric blankets (on)"),
    description = ccb.content.text("A heated blanket made of polyester.  It's turned on, making it nice and toasty while it lasts."),
    copy_from = "electric_blanket",
    revert_to = "electric_blanket",
    inheritance = { add = { flags = { "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "100 W" },
    armor = { warmth = 90 },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You turn the heating elements off."),
            target = "electric_blanket",
        },
        { kind = "link_up", cable_length = 3, charge_rate = "110 W" },
    },
}

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

-- This is based on the Sarcos Guardian, a production model with independent battery power, all weather operation, and capable of lifting up to 200 lbs. It uses three 12 lb batteries that provide 8 hours of operation. The battery life in-game is significantly less in order to utilize medium storage batteries, otherwise this would require the unit to be active to reload itself. This can also be changed out to use other battery types.
ccb.content.define_item {
    id = "utility_exoskeleton_off",
    category = "armor",
    name = ccb.content.plural_text("battery powered utility exoskeleton", "battery powered utility exoskeletons"),
    description = ccb.content.text("A skeletal frame of sturdy metal with attached motors to allow the user to lift and move heavier loads with less strain on the body."),
    mass = "90 kg",
    volume = "130 L",
    price = "115 kUSD",
    survival_price = "400 USD",
    accuracy = { grip = "bad", length = "long", surface = "any", balance = "clumsy" },
    materials = { "steel", "plastic" },
    symbol = "[",
    looks_like = "depowered_armor",
    color = "dark_gray",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_items = { "medium_storage_battery" },
            default_magazine = "medium_storage_battery",
        },
    },
    flags = { "STURDY", "OVERSIZE", "BELTED", "WATER_FRIENDLY", "ELECTRONIC" },
    faults = { { group = "electronic_general" } },
    melee_damage = { bash = 10 },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1, ammo_types = "battery" },
    armor = {
        warmth = 0,
        thickness = 8,
        environmental_protection = 0,
        portions = {
            {
                encumbrance = 20,
                coverage = 20,
                covers = {
                    "torso",
                    "arm_l",
                    "arm_r",
                    "hand_l",
                    "hand_r",
                    "leg_l",
                    "leg_r",
                    "foot_l",
                    "foot_r",
                },
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_dda_utility_exoskeleton_off_0" } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("The %s engages."),
            target = "utility_exoskeleton_on",
        },
    },
}

-- Battery should last two hours (02:00:07). Weight capacity bonus should include weight of item AND battery, plus 90kg.
ccb.content.define_item {
    id = "utility_exoskeleton_on",
    copy_from = "utility_exoskeleton_off",
    looks_like = "power_armor_light",
    name = ccb.content.plural_text("battery powered utility exoskeleton (on)", "battery powered utility exoskeletons (on)"),
    description = ccb.content.text("A skeletal frame of sturdy metal with attached motors to allow the user to lift and move heavier loads with less strain on the body.  It is turned on and continually drawing power.  Use it to turn it off."),
    flags = { "STURDY", "OVERSIZE", "BELTED", "WATER_FRIENDLY", "TRADER_AVOID", "SPAWN_ACTIVE" },
    qualities = { { id = "LIFT", level = 1 } },
    revert_to = "utility_exoskeleton_off",
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "972216 mW", ammo_types = "battery" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("The %s disengages."),
            target = "utility_exoskeleton_off",
        },
    },
}

ccb.content.define_item {
    id = "ice_utility_exoskeleton_off",
    category = "armor",
    name = ccb.content.plural_text("ICE utility exoskeleton", "ICE utility exoskeletons"),
    description = ccb.content.text("A skeletal frame of sturdy metal with attached motors to allow the user to lift and move heavier loads with less strain on the body.  This model uses a compact internal combustion engine for power."),
    mass = "110 kg",
    volume = "130 L",
    price = "115 kUSD",
    survival_price = "400 USD",
    accuracy = { grip = "bad", length = "long", surface = "any", balance = "clumsy" },
    materials = { "steel", "plastic" },
    symbol = "[",
    looks_like = "depowered_armor",
    color = "dark_gray",
    pockets = { { kind = "MAGAZINE", rigid = true, watertight = true, ammunition = { gasoline = 10000 } } },
    flags = { "STURDY", "OVERSIZE", "BELTED", "WATER_FRIENDLY", "ELECTRONIC" },
    faults = { { group = "electronic_general" } },
    melee_damage = { bash = 10 },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1, ammo_types = "gasoline" },
    armor = {
        warmth = 0,
        thickness = 8,
        environmental_protection = 0,
        portions = {
            {
                encumbrance = 20,
                coverage = 20,
                covers = {
                    "torso",
                    "arm_l",
                    "arm_r",
                    "hand_l",
                    "hand_r",
                    "leg_l",
                    "leg_r",
                    "foot_l",
                    "foot_r",
                },
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_dda_ice_utility_exoskeleton_off_0" } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("The %s engages."),
            target = "ice_utility_exoskeleton_on",
        },
    },
}

-- Full tank lasts a bit under three hours (166.66 minutes). Has less carry bonus than the battery one since the weight of the fuel will drop over time.
ccb.content.define_item {
    id = "ice_utility_exoskeleton_on",
    copy_from = "ice_utility_exoskeleton_off",
    looks_like = "power_armor_light",
    name = ccb.content.plural_text("ICE utility exoskeleton (on)", "ICE utility exoskeletons (on)"),
    description = ccb.content.text("A skeletal frame of sturdy metal with attached motors to allow the user to lift and move heavier loads with less strain on the body.  This model uses a compact internal combustion engine for power.  It is turned on and continually draining gasoline.  Use it to turn it off."),
    flags = { "STURDY", "OVERSIZE", "BELTED", "WATER_FRIENDLY", "TRADER_AVOID", "SPAWN_ACTIVE" },
    revert_to = "ice_utility_exoskeleton_off",
    qualities = { { id = "LIFT", level = 1 } },
    subtype_order = { "tool", "armor" },
    tool = { turns_per_charge = 1 },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("The %s disengages."),
            target = "ice_utility_exoskeleton_off",
        },
    },
}

-- Based on Anduril IVAS system.  Renamed 'Integrated' to 'Military' so as to not confuse it with other internal, integrated items in game. Dispersion bonus is high to make up for combating effects of eye encumbrance - final bonus is modest.
ccb.content.define_item {
    id = "military_vis_aug_system",
    category = "armor",
    name = ccb.content.plural_text("military visual augmentation system", "military visual augmentation system"),
    description = ccb.content.text("An experimental and cumbersome augmented reality headset developed for the military.  It consists of a broad eyepiece, a rugged multi-camera array, and a puck computer, all designed to be strapped over a helmet.  The lenses are equipped with adaptive light correction, light amplification and thermal imaging, and an augmented reality overlay equipped with various gadgets, including a rangefinder and adaptive targeting system, making target acquisition quicker.  Activate it to turn on all systems."),
    mass = "1500 g",
    volume = "1400 ml",
    price = "40000 USD",
    survival_price = "10 USD",
    materials = { "plastic", "qt_steel", "glass" },
    symbol = "[",
    color = "dark_gray",
    pockets = {
        { kind = "MAGAZINE", rigid = true, ammunition = { battery = 500 } },
        {
            kind = "E_FILE_STORAGE",
            rigid = true,
            capacity = "1 ml",
            mass_limit = "1 g",
            weight_multiplier = 0,
            memory_capacity = "1 TB",
        },
    },
    flags = { "ELECTRONIC", "CAN_USE_IN_DARK", "BELTED", "PADDED", "MUNDANE", "USE_UPS", "NO_UNLOAD" },
    faults = { { group = "electronic_general" } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1, transfer_rate = "30 MB", ammo_types = "battery" },
    armor = {
        thickness = 2,
        portions = {
            { covers = { "eyes" }, coverage = 100, encumbrance = 30, rigid_only = true },
            { covers = { "head" }, encumbrance = 20, coverage = 80, subparts = { "head_forehead" } },
            { covers = { "head" }, encumbrance = 5, coverage = 40, subparts = { "head_crown" } },
        },
    },
    artifact = {},
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Switch on the AR system"),
            message = ccb.content.text("You activate your AR system.\nAnduril IVASos v1.2: ONLINE.\nVisual systems:      ONLINE.\nRadio systems:       ONLINE.\nTargeting HUD:       ONLINE.\nGPS:                  ERROR."),
            target = "military_vis_aug_system_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
        "CAMERA",
        "EBOOKSAVE",
        "E_FILE_DEVICE",
    },
}

ccb.content.define_item {
    id = "military_vis_aug_system_on",
    copy_from = "military_vis_aug_system",
    name = ccb.content.plural_text("military visual augmentation system (on)", "military visual augmentation system (on)"),
    description = ccb.content.text("An experimental and cumbersome augmented reality headset developed for the military.  It consists of a broad eyepiece, a rugged multi-camera array, and a puck computer, all designed to be strapped over a helmet.  The lenses are equipped with adaptive light correction, light amplification and thermal imaging, and an augmented reality overlay equipped with various gadgets, including a rangefinder and adaptive targeting system, making target acquisition quicker.  It has a few small connectors for external devices.  The AR system is currently turned on, and is continually draining batteries.  Use it to turn it off."),
    revert_to = "military_vis_aug_system",
    inheritance = {
        add = {
            flags = {
                "SPAWN_ACTIVE", "ZOOM", "THERMOMETER", "HYGROMETER", "BAROMETER", "TWO_WAY_RADIO",
                "WATCH", "ALARMCLOCK", "SUN_GLASSES",
            },
        },
    },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { power_draw = "320 mW" },
    armor = {
        portions = {
            { covers = { "eyes" }, coverage = 100, encumbrance = 5, rigid_only = true },
            { covers = { "head" }, encumbrance = 20, coverage = 80, subparts = { "head_forehead" } },
            { covers = { "head" }, encumbrance = 5, coverage = 40, subparts = { "head_crown" } },
        },
    },
    artifact = { enchantments = { "nvg_great", "THERMAL_VISION_GOOD", "AR_targeting_system" } },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("Your AR system turns off."),
            target = "military_vis_aug_system",
        },
        "CAMERA",
        "EBOOKSAVE",
        "E_FILE_DEVICE",
    },
}
