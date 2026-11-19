local ccb = require("ccb")

-- inherit name and description from item
ccb.content.define_item {
    id = "waist_apron_long",
    name = ccb.content.text("long waist apron"),
    description = ccb.content.text("A long waist apron made of cotton."),
    copy_from = "apron_cotton",
    volume = "1750 ml",
    mass = "226 g",
    price = "10 USD",
    materials = { "cotton" },
    color = "white",
    faults = { { group = "fabric_cotton" } },
    variant_kind = "generic",
    variants = {
        {
            id = "generic_apron_cotton",
            description = ccb.content.text("It's colored white, like the ones commonly used by chefs, professional or otherwise."),
            weight = 50,
            append = true,
        },
        {
            id = "black_apron_cotton",
            name = ccb.content.text("black long waist apron"),
            description = ccb.content.text("It's colored black, commonly used by chefs working in the night or who just want to look cool."),
            color = "dark_gray",
            weight = 25,
            append = true,
        },
        {
            id = "blue_apron_cotton",
            name = ccb.content.text("blue long waist apron"),
            description = ccb.content.text("It's a royal blue color, commonly used by supermarket workers around the world."),
            color = "blue",
            weight = 15,
            append = true,
        },
        {
            id = "red_apron_cotton",
            name = ccb.content.text("red long waist apron"),
            description = ccb.content.text("It's colored red."),
            color = "red",
            weight = 10,
            append = true,
        },
        {
            id = "pink_apron_cotton",
            name = ccb.content.text("pink long waist apron"),
            description = ccb.content.text("It's colored neon pink, commonly used by women or men who like pink."),
            color = "pink",
            weight = 3,
            append = true,
        },
        {
            id = "floral_apron_cotton",
            name = ccb.content.text("floral long waist apron"),
            description = ccb.content.text("It has a floral design and colored yellow, perfect for cooking outdoors."),
            color = "yellow",
            weight = 2,
            append = true,
        },
        {
            id = "camo_apron_cotton",
            name = ccb.content.text("camo long waist apron"),
            description = ccb.content.text("It has a camouflage pattern, perfect for chefs who want to hide in the wild."),
            color = "green",
            weight = 2,
            append = true,
        },
        {
            id = "skull_apron",
            name = ccb.content.text("skull long waist apron"),
            description = ccb.content.text("It's colored black with a skull and roses pattern.  Makes you feel more fashionable just by wearing it."),
            color = "dark_gray",
            append = true,
        },
        {
            id = "maid_apron",
            name = ccb.content.text("maid long waist apron"),
            description = ccb.content.text("It's colored white with black frilly decorations, commonly used with a maid dress or alone for nighttime activities."),
            append = true,
        },
        {
            id = "gothic_apron",
            name = ccb.content.text("gothic long waist apron"),
            description = ccb.content.text("It has a jet-black color with dark red decorations, perfect for cosplay or an adventurous gourmet."),
            color = "light_red",
            append = true,
        },
    },
    armor = {
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_waist" },
                coverage = 100,
                encumbrance = { 1, 1 },
            },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_draped_l", "leg_draped_r" },
                coverage = 70,
                encumbrance = 2,
                volume_encumbrance = 0.3,
            },
        },
    },
}

ccb.content.define_item {
    id = "waist_apron_long_xl",
    copy_from = "waist_apron_long",
    name = ccb.content.text("long waist apron"),
    variants = {
        {
            id = "maid_apron_xl",
            name = ccb.content.text("maid long waist apron"),
            description = ccb.content.text("It's colored white with black frilly decorations, commonly used with a maid dress or alone for nighttime activities."),
            append = true,
        },
    },
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "waist_apron_long_xs",
    copy_from = "waist_apron_long",
    name = ccb.content.text("long waist apron"),
    variants = {
        {
            id = "maid_apron_xs",
            name = ccb.content.text("maid long waist apron"),
            description = ccb.content.text("It's colored white with black frilly decorations, commonly used with a maid dress or alone for nighttime activities."),
            append = true,
        },
    },
    armor = {},
    inheritance = { add = { flags = { "UNDERSIZE", "PREFIX_XS" } }, scale = { mass = 0.5, volume = 0.5 } },
}

-- inherit name from item
ccb.content.define_item {
    id = "waist_apron_short",
    name = ccb.content.text("short waist apron"),
    description = ccb.content.text("A short waist apron made of cotton."),
    copy_from = "apron_cotton",
    volume = "350 ml",
    mass = "136 g",
    price = "25 USD",
    materials = { "cotton" },
    color = "white",
    faults = { { group = "fabric_cotton" } },
    variant_kind = "generic",
    variants = {
        {
            id = "generic_apron_cotton",
            description = ccb.content.text("It's colored white, like the ones commonly used by chefs, professional or otherwise."),
            weight = 50,
            append = true,
        },
        {
            id = "black_apron_cotton",
            name = ccb.content.text("black short waist apron"),
            description = ccb.content.text("It's colored black, commonly used by chefs working in the night or who just want to look cool."),
            color = "dark_gray",
            weight = 25,
            append = true,
        },
        {
            id = "blue_apron_cotton",
            name = ccb.content.text("blue short waist apron"),
            description = ccb.content.text("It's a royal blue color, commonly used by supermarket workers around the world."),
            color = "blue",
            weight = 15,
            append = true,
        },
        {
            id = "red_apron_cotton",
            name = ccb.content.text("red short waist apron"),
            description = ccb.content.text("It's colored red."),
            color = "red",
            weight = 10,
            append = true,
        },
        {
            id = "pink_apron_cotton",
            name = ccb.content.text("pink short waist apron"),
            description = ccb.content.text("It's colored neon pink, commonly used by women or men who like pink."),
            color = "pink",
            weight = 3,
            append = true,
        },
        {
            id = "floral_apron_cotton",
            name = ccb.content.text("floral short waist apron"),
            description = ccb.content.text("It has a floral design and colored yellow, perfect for cooking outdoors."),
            color = "yellow",
            weight = 2,
            append = true,
        },
        {
            id = "camo_apron_cotton",
            name = ccb.content.text("camo short waist apron"),
            description = ccb.content.text("It has a camouflage pattern, perfect for chefs who want to hide in the wild."),
            color = "green",
            weight = 2,
            append = true,
        },
        {
            id = "skull_apron",
            name = ccb.content.text("skull short waist apron"),
            description = ccb.content.text("It's colored black with a skull and roses pattern.  Makes you feel more fashionable just by wearing it."),
            color = "dark_gray",
            append = true,
        },
        {
            id = "maid_apron",
            name = ccb.content.text("maid short waist apron"),
            description = ccb.content.text("It's colored white with black frilly decorations, commonly used with a maid dress or alone for nighttime activities."),
            append = true,
        },
        {
            id = "gothic_apron",
            name = ccb.content.text("gothic short waist apron"),
            description = ccb.content.text("It has a jet-black color with dark red decorations, perfect for cosplay or an adventurous gourmet."),
            color = "light_red",
            append = true,
        },
    },
    armor = {
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_waist" },
                coverage = 80,
                encumbrance = { 0, 0 },
            },
            {
                covers = { "leg_l", "leg_r" },
                coverage = 22,
                subparts = { "leg_draped_l", "leg_draped_r" },
                encumbrance = 0,
                volume_encumbrance = 0.3,
            },
        },
    },
}

ccb.content.define_item {
    id = "waist_apron_short_xl",
    copy_from = "waist_apron_short",
    name = ccb.content.text("short waist apron"),
    variants = {
        {
            id = "maid_apron_xl",
            name = ccb.content.text("maid short waist apron"),
            description = ccb.content.text("It's colored white with black frilly decorations, commonly used with a maid dress or alone for nighttime activities."),
            append = true,
        },
    },
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "waist_apron_short_xs",
    copy_from = "waist_apron_short",
    name = ccb.content.text("short waist apron"),
    variants = {
        {
            id = "maid_apron_xs",
            name = ccb.content.text("maid short waist apron"),
            description = ccb.content.text("It's colored white with black frilly decorations, commonly used with a maid dress or alone for nighttime activities."),
            append = true,
        },
    },
    armor = {},
    inheritance = { add = { flags = { "UNDERSIZE", "PREFIX_XS" } }, scale = { mass = 0.5, volume = 0.5 } },
}

-- inherit name from item
ccb.content.define_item {
    id = "apron_cotton",
    name = ccb.content.text("cotton apron"),
    description = ccb.content.text("An apron made of cotton."),
    copy_from = "apron_leather",
    volume = "1750 ml",
    mass = "357 g",
    price = "10 USD",
    materials = { "cotton" },
    color = "white",
    faults = { { group = "fabric_cotton" } },
    variant_kind = "generic",
    variants = {
        {
            id = "generic_apron_cotton",
            description = ccb.content.text("It's colored white, like the ones commonly used by chefs, professional or otherwise."),
            weight = 50,
            append = true,
        },
        {
            id = "black_apron_cotton",
            name = ccb.content.text("black cotton apron"),
            description = ccb.content.text("It's colored black, commonly used by chefs working in the night or who just want to look cool."),
            color = "dark_gray",
            weight = 25,
            append = true,
        },
        {
            id = "blue_apron_cotton",
            name = ccb.content.text("blue cotton apron"),
            description = ccb.content.text("It's a royal blue color, commonly used by supermarket workers around the world."),
            color = "blue",
            weight = 15,
            append = true,
        },
        {
            id = "red_apron_cotton",
            name = ccb.content.text("red cotton apron"),
            description = ccb.content.text("It's colored red."),
            color = "red",
            weight = 10,
            append = true,
        },
        {
            id = "pink_apron_cotton",
            name = ccb.content.text("pink cotton apron"),
            description = ccb.content.text("It's colored neon pink, commonly used by women or men who like pink."),
            color = "pink",
            weight = 3,
            append = true,
        },
        {
            id = "floral_apron_cotton",
            name = ccb.content.text("floral cotton apron"),
            description = ccb.content.text("It has a floral design and colored yellow, perfect for cooking outdoors."),
            color = "yellow",
            weight = 2,
            append = true,
        },
        {
            id = "camo_apron_cotton",
            name = ccb.content.text("camo cotton apron"),
            description = ccb.content.text("It has a camouflage pattern, perfect for chefs who want to hide in the wild."),
            color = "green",
            weight = 2,
            append = true,
        },
        {
            id = "skull_apron",
            name = ccb.content.text("skull apron"),
            description = ccb.content.text("It's colored black with a skull and roses pattern.  Makes you feel more fashionable just by wearing it."),
            color = "dark_gray",
            append = true,
        },
        {
            id = "maid_apron",
            name = ccb.content.text("maid apron"),
            description = ccb.content.text("It's colored white with black frilly decorations, commonly used with a maid dress or alone for nighttime activities."),
            append = true,
        },
        {
            id = "gothic_apron",
            name = ccb.content.text("gothic apron"),
            description = ccb.content.text("It has a jet-black color with dark red decorations, perfect for cosplay or an adventurous gourmet."),
            color = "light_red",
            append = true,
        },
    },
    armor = { thickness = 1.5 },
    inheritance = { remove = { flags = { "WATER_FRIENDLY" } } },
}

ccb.content.define_item {
    id = "apron_cotton_xl",
    copy_from = "apron_cotton",
    name = ccb.content.text("cotton apron"),
    variants = {
        {
            id = "maid_apron_xl",
            name = ccb.content.text("maid apron"),
            description = ccb.content.text("It's colored white with black frilly decorations, commonly used with a maid dress or alone for nighttime activities."),
            append = true,
        },
    },
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "apron_cotton_xs",
    copy_from = "apron_cotton",
    name = ccb.content.text("cotton apron"),
    variants = {
        {
            id = "maid_apron_xs",
            name = ccb.content.text("maid apron"),
            description = ccb.content.text("It's colored white with black frilly decorations, commonly used with a maid dress or alone for nighttime activities."),
            append = true,
        },
    },
    armor = {},
    inheritance = { add = { flags = { "UNDERSIZE", "PREFIX_XS" } }, scale = { mass = 0.5, volume = 0.5 } },
}

ccb.content.define_item {
    id = "apron_leather",
    name = ccb.content.text("leather apron"),
    description = ccb.content.text("An apron made of leather."),
    mass = "1925 g",
    volume = "2250 ml",
    price = "15 USD",
    survival_price = "50 cent",
    materials = { "leather" },
    symbol = "[",
    looks_like = "vest_leather",
    color = "brown",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1 L",
            mass_limit = "3 kg",
            max_item_length = "21 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1 L",
            mass_limit = "3 kg",
            max_item_length = "21 cm",
            moves = 80,
        },
    },
    flags = { "POCKETS", "BELTED", "WATER_FRIENDLY" },
    armor = {
        portions = {
            { covers = { "torso" }, coverage = 70, encumbrance = 2, volume_encumbrance = 0.3 },
            {
                covers = { "leg_l", "leg_r" },
                coverage = 42,
                encumbrance = { 1, 1 },
                subparts = { "leg_draped_l", "leg_draped_r" },
            },
        },
        warmth = 2,
        thickness = 2,
        environmental_protection = 1,
    },
}

ccb.content.define_item {
    id = "apron_plastic",
    category = "armor",
    name = ccb.content.text("plastic apron"),
    description = ccb.content.text("An apron made of plastic, provides good protection against accidental chemical splashes."),
    copy_from = "apron_leather",
    mass = "391 g",
    materials = { "plastic" },
    color = "light_cyan",
    armor = {},
}

ccb.content.define_item {
    id = "apron_cut_resistant",
    category = "armor",
    name = ccb.content.text("cut-resistant apron"),
    description = ccb.content.text("An apron made of Kevlar fabric."),
    copy_from = "apron_leather",
    mass = "576 g",
    price = "38 USD",
    materials = { "kevlar" },
    color = "dark_gray",
    armor = { thickness = 2.5 },
}

ccb.content.define_item {
    id = "bee_dress",
    name = ccb.content.plural_text("bee dress", "bee dresses"),
    description = ccb.content.text("A short black and yellow dress, reminiscent of a bee.  It includes bee wings, a hood, and a pair of antennae."),
    mass = "739 g",
    volume = "4000 ml",
    price = "75 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "dress",
    color = "yellow",
    faults = { { group = "fabric_cotton" } },
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1 L",
            mass_limit = "2 kg",
            max_item_length = "12 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1 L",
            mass_limit = "2 kg",
            max_item_length = "12 cm",
            moves = 80,
        },
    },
    flags = { "VARSIZE", "POCKETS", "HOOD", "COSPLAY_COSTUME" },
    armor = {
        portions = {
            { covers = { "torso" }, coverage = 85, encumbrance = { 8, 9 } },
            { covers = { "arm_l", "arm_r" }, coverage = 95, encumbrance = { 4, 4 } },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
                coverage = 100,
                encumbrance = { 4, 5 },
            },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
                coverage = 50,
            },
        },
        warmth = 10,
        thickness = 0.2,
    },
}

-- inherit name and description from item
ccb.content.define_item {
    id = "blazer",
    name = ccb.content.text("blazer"),
    description = ccb.content.text("A professional-looking wool blazer."),
    mass = "680 g",
    volume = "3500 ml",
    price = "120 USD",
    survival_price = "50 cent",
    materials = { "wool" },
    symbol = "[",
    looks_like = "jacket_light",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "750 ml",
            mass_limit = "3 kg",
            max_item_length = "11 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "750 ml",
            mass_limit = "3 kg",
            max_item_length = "11 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "350 ml",
            mass_limit = "2 kg",
            max_item_length = "9 cm",
            moves = 100,
        },
    },
    flags = { "VARSIZE", "OUTER" },
    variant_kind = "generic",
    variants = {
        { id = "generic" },
        {
            id = "bostonchan",
            name = ccb.content.text("Boston-Chan blazer"),
            append = true,
            description = ccb.content.text("This one is bright blue and styled to cosplay Boston-Chan."),
            color = "blue",
            weight = 0,
        },
    },
    armor = {
        portions = {
            { covers = { "torso" }, coverage = 85, encumbrance = { 16, 20 } },
            { covers = { "arm_l", "arm_r" }, coverage = 85, encumbrance = { 16, 16 } },
        },
        warmth = 25,
        thickness = 1.5,
        valid_mods = { "steel_padded" },
    },
}

ccb.content.define_item {
    id = "cheerleader_dress",
    name = ccb.content.plural_text("cheerleader dress", "cheerleader dresses"),
    description = ccb.content.text("A light and breezy cheerleader dress.  It's blue and white with the word \"Cheers\" printed at the top."),
    mass = "200 g",
    volume = "500 ml",
    price = "12 USD 50 cent",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "sundress",
    color = "blue",
    faults = { { group = "fabric_cotton" } },
    flags = { "VARSIZE", "WATER_FRIENDLY" },
    armor = {
        thickness = 0.1,
        portions = {
            { coverage = 85, covers = { "torso" } },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
                coverage = 100,
            },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
                coverage = 25,
            },
        },
    },
}

ccb.content.define_item {
    id = "cheerleader_top_short",
    name = ccb.content.text("short cheerleader tank top"),
    description = ccb.content.text("A short red cheerleader tank top.  It has the word \"Cheers\" printed at the top."),
    mass = "100 g",
    volume = "250 ml",
    price = "8 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "tank_top",
    color = "red",
    faults = { { group = "fabric_cotton" } },
    flags = { "VARSIZE", "WATER_FRIENDLY" },
    armor = {
        portions = { { covers = { "torso" }, subparts = { "torso_upper" }, coverage = 90, encumbrance = 2 } },
        thickness = 0.2,
    },
}

ccb.content.define_item {
    id = "combat_shirt",
    name = ccb.content.text("combat shirt"),
    description = ccb.content.text("An oddly balanced long-sleeved shirt with a thin, breathable torso and thicker arms more appropriate for a jacket.  The arms are covered in a camouflage pattern and have two shoulder pockets.  It has a pocket for your pen!"),
    mass = "450 g",
    volume = "3 L",
    price = "64 USD",
    survival_price = "7 USD 50 cent",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "jacket_army",
    color = "green",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "500 ml",
            mass_limit = "1 kg",
            max_item_length = "13 cm",
            moves = 120,
        },
        {
            kind = "CONTAINER",
            capacity = "500 ml",
            mass_limit = "1 kg",
            max_item_length = "13 cm",
            moves = 120,
        },
        {
            kind = "CONTAINER",
            capacity = "10 ml",
            mass_limit = "50 g",
            max_item_length = "13 cm",
            moves = 120,
        },
    },
    flags = { "VARSIZE", "POCKETS" },
    armor = {
        portions = {
            { covers = { "torso" }, coverage = 95, encumbrance = 3 },
            { covers = { "arm_l", "arm_r" }, coverage = 95, encumbrance = { 7, 9 } },
        },
        warmth = 5,
        thickness = 0.3,
    },
}

ccb.content.define_item {
    id = "dress",
    name = ccb.content.plural_text("dress", "dresses"),
    description = ccb.content.text("A cotton dress."),
    mass = "500 g",
    volume = "2600 ml",
    price = "180 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "robe",
    color = "pink",
    faults = { { group = "fabric_cotton" } },
    flags = { "VARSIZE", "ALLOWS_GASTROPOD_FOOT", "ALLOWS_LEG_TENTACLES" },
    variants = {
        {
            id = "white",
            name = ccb.content.plural_text("white dress", "white dresses"),
            append = true,
            description = ccb.content.text("This one is white."),
            color = "white",
        },
        {
            id = "black",
            name = ccb.content.plural_text("black dress", "black dresses"),
            append = true,
            description = ccb.content.text("This one is black."),
            color = "black",
        },
    },
    armor = {
        warmth = 5,
        thickness = 0.2,
        portions = {
            { encumbrance = 7, coverage = 85, covers = { "torso" } },
            { encumbrance = 4, coverage = 55, covers = { "leg_l", "leg_r" } },
            {
                covers = { "gastropod_foot" },
                coverage = 100,
                encumbrance = 7,
                subparts = { "leg_hip_gastropod_l", "leg_hip_gastropod_r", "leg_upper_gastropod" },
            },
            {
                covers = { "gastropod_foot" },
                encumbrance = 4,
                coverage = 40,
                subparts = { "leg_lower_gastropod" },
            },
            {
                covers = {
                    "tentacle_lower_front_l", "tentacle_lower_middle_l", "tentacle_lower_rear_l",
                    "tentacle_lower_front_r", "tentacle_lower_middle_r", "tentacle_lower_rear_r",
                },
                coverage = 100,
                encumbrance = 7,
                subparts = {
                    "tentacle_lower_front_base_l", "tentacle_lower_middle_base_l",
                    "tentacle_lower_rear_base_l", "tentacle_lower_front_base_r",
                    "tentacle_lower_middle_base_r", "tentacle_lower_rear_base_r",
                },
            },
            {
                covers = {
                    "tentacle_lower_front_l", "tentacle_lower_middle_l", "tentacle_lower_rear_l",
                    "tentacle_lower_front_r", "tentacle_lower_middle_r", "tentacle_lower_rear_r",
                },
                coverage = 40,
                encumbrance = 4,
                subparts = {
                    "tentacle_lower_front_middle_l", "tentacle_lower_middle_middle_l",
                    "tentacle_lower_rear_middle_l", "tentacle_lower_front_middle_r",
                    "tentacle_lower_middle_middle_r", "tentacle_lower_rear_middle_r",
                },
            },
            {
                covers = { "tail_long", "tail_fluffy", "tail_bovine", "tail_rat" },
                coverage = 35,
                encumbrance = 4,
            },
            { covers = { "tail_thick", "tail_club" }, coverage = 20, encumbrance = 4 },
        },
    },
}

ccb.content.define_item {
    id = "long_dress",
    copy_from = "dress",
    name = ccb.content.plural_text("long dress", "long dresses"),
    description = ccb.content.text("A long cotton dress."),
    variant_kind = "generic",
    variants = {
        {
            id = "white",
            name = ccb.content.plural_text("long white dress", "long white dresses"),
            append = true,
            description = ccb.content.text("This one is white."),
            color = "white",
        },
        {
            id = "black",
            name = ccb.content.plural_text("long black dress", "long black dresses"),
            append = true,
            description = ccb.content.text("This one is black."),
            color = "dark_gray",
        },
    },
    armor = {
        portions = {
            { encumbrance = 7, coverage = 85, covers = { "torso", "leg_l", "leg_r" } },
            {
                covers = { "gastropod_foot" },
                coverage = 100,
                encumbrance = 7,
                subparts = { "leg_hip_gastropod_l", "leg_hip_gastropod_r", "leg_upper_gastropod" },
            },
            {
                covers = { "gastropod_foot" },
                coverage = 40,
                encumbrance = 4,
                subparts = { "leg_lower_gastropod" },
            },
            {
                covers = { "tail_long", "tail_fluffy", "tail_bovine", "tail_rat" },
                coverage = 75,
                encumbrance = 6,
            },
            { covers = { "tail_thick", "tail_club" }, coverage = 65, encumbrance = 8 },
        },
    },
    inheritance = { scale = { mass = 1.25, volume = 1.25, warmth = 2 } },
}

ccb.content.define_item {
    id = "short_dress",
    copy_from = "dress",
    name = ccb.content.plural_text("short dress", "short dresses"),
    description = ccb.content.text("A short cotton dress."),
    variant_kind = "generic",
    variants = {
        {
            id = "white",
            name = ccb.content.plural_text("short white dress", "short white dresses"),
            append = true,
            description = ccb.content.text("This one is white."),
            color = "white",
            weight = 50,
        },
        {
            id = "black",
            name = ccb.content.plural_text("short black dress", "short black dresses"),
            append = true,
            description = ccb.content.text("This one is black."),
            color = "black",
            weight = 50,
        },
        {
            id = "sinister",
            name = ccb.content.plural_text("short sinister dress", "short sinister dresses"),
            description = ccb.content.text("A short red dress made in gothic lolita fashion."),
            color = "red",
        },
    },
    armor = {
        portions = {
            { encumbrance = 7, coverage = 85, covers = { "torso" } },
            { encumbrance = 1, coverage = 25, covers = { "leg_l", "leg_r" } },
        },
    },
    inheritance = { scale = { mass = 0.75, volume = 0.75, warmth = 0.5 } },
}

ccb.content.define_item {
    id = "dress_sleeved",
    copy_from = "dress",
    description = ccb.content.text("A cotton dress with sleeves."),
    name = ccb.content.plural_text("dress with sleeves", "dresses with sleeves"),
    variant_kind = "generic",
    variants = {
        {
            id = "white",
            name = ccb.content.plural_text("white dress with sleeves", "white dresses with sleeves"),
            append = true,
            description = ccb.content.text("This one is white."),
            color = "white",
            weight = 200,
        },
        {
            id = "black",
            name = ccb.content.plural_text("black dress with sleeves", "black dresses with sleeves"),
            append = true,
            description = ccb.content.text("This one is black."),
            color = "black",
            weight = 200,
        },
        {
            id = "witch_black",
            name = ccb.content.plural_text("black witch dress", "black witch dresses"),
            description = ccb.content.text("A dress with full sleeves and pointed cuts at the edges.  Perfect for Halloween.  It's colored black."),
        },
        {
            id = "witch_green",
            name = ccb.content.plural_text("green witch dress", "green witch dresses"),
            description = ccb.content.text("A dress with full sleeves and pointed cuts at the edges.  Perfect for Halloween.  It's colored dark green."),
        },
        {
            id = "witch_red",
            name = ccb.content.plural_text("red witch dress", "red witch dresses"),
            description = ccb.content.text("A dress with full sleeves and pointed cuts at the edges.  Perfect for Halloween.  It's colored dark red."),
        },
        {
            id = "witch_purple",
            name = ccb.content.plural_text("purple witch dress", "purple witch dresses"),
            description = ccb.content.text("A dress with full sleeves and pointed cuts at the edges.  Perfect for Halloween.  It's colored dark purple."),
        },
    },
    armor = {
        portions = {
            { encumbrance = 7, coverage = 85, covers = { "torso" } },
            { encumbrance = 1, coverage = 85, covers = { "arm_l", "arm_r" } },
            { encumbrance = 4, coverage = 55, covers = { "leg_l", "leg_r" } },
            {
                covers = { "gastropod_foot" },
                coverage = 100,
                encumbrance = 7,
                subparts = { "leg_hip_gastropod_l", "leg_hip_gastropod_r", "leg_upper_gastropod" },
            },
            {
                covers = { "gastropod_foot" },
                coverage = 40,
                encumbrance = 4,
                subparts = { "leg_lower_gastropod" },
            },
            {
                covers = { "tail_long", "tail_fluffy", "tail_bovine", "tail_rat" },
                coverage = 35,
                encumbrance = 4,
            },
            { covers = { "tail_thick", "tail_club" }, coverage = 20, encumbrance = 4 },
        },
    },
    inheritance = { scale = { warmth = 1.25 } },
}

ccb.content.define_item {
    id = "long_dress_sleeved",
    copy_from = "dress_sleeved",
    description = ccb.content.text("A long cotton dress with sleeves."),
    name = ccb.content.plural_text("long dress with sleeves", "long dresses with sleeves"),
    variant_kind = "generic",
    variants = {
        {
            id = "white",
            name = ccb.content.plural_text("long white dress with sleeves", "long white dresses with sleeves"),
            append = true,
            description = ccb.content.text("This one is white."),
            color = "white",
            weight = 225,
        },
        {
            id = "black",
            name = ccb.content.plural_text("long black dress with sleeves", "long black dresses with sleeves"),
            append = true,
            description = ccb.content.text("This one is black."),
            color = "black",
            weight = 225,
        },
        {
            id = "witch_black",
            name = ccb.content.plural_text("long black witch dress", "long black witch dresses"),
            append = true,
            description = ccb.content.text("A long dress with sleeves, typical of a witch.  It's colored black."),
        },
        {
            id = "witch_green",
            name = ccb.content.plural_text("long green witch dress", "long green witch dresses"),
            append = true,
            description = ccb.content.text("A long dress with sleeves, typical of a witch.  It's colored dark green."),
        },
        {
            id = "witch_red",
            name = ccb.content.plural_text("long red witch dress", "long red witch dresses"),
            append = true,
            description = ccb.content.text("A long dress with sleeves, typical of a witch.  It's colored dark red."),
        },
        {
            id = "witch_purple",
            name = ccb.content.plural_text("long purple witch dress", "long purple witch dresses"),
            append = true,
            description = ccb.content.text("A long dress with sleeves, typical of a witch.  It's colored dark purple."),
        },
        {
            id = "sinister",
            name = ccb.content.plural_text("sinister dress", "sinister dresses"),
            description = ccb.content.text("A long black and red dress with full sleeves, a collar, and embroidery reminiscent of a vampire duchess."),
        },
    },
    armor = {
        portions = {
            { encumbrance = 7, coverage = 85, covers = { "torso" } },
            { encumbrance = 1, coverage = 85, covers = { "arm_l", "arm_r" } },
            { encumbrance = 7, coverage = 85, covers = { "leg_l", "leg_r" } },
            {
                covers = { "gastropod_foot" },
                coverage = 100,
                encumbrance = 7,
                subparts = { "leg_hip_gastropod_l", "leg_hip_gastropod_r", "leg_upper_gastropod" },
            },
            {
                covers = { "gastropod_foot" },
                coverage = 40,
                encumbrance = 4,
                subparts = { "leg_lower_gastropod" },
            },
            {
                covers = { "tail_long", "tail_fluffy", "tail_bovine", "tail_rat" },
                coverage = 75,
                encumbrance = 6,
            },
            { covers = { "tail_thick", "tail_club" }, coverage = 65, encumbrance = 8 },
        },
    },
    inheritance = { scale = { mass = 1.25, volume = 1.25, warmth = 2 } },
}

ccb.content.define_item {
    id = "short_dress_sleeved",
    copy_from = "dress_sleeved",
    description = ccb.content.text("A short cotton dress with sleeves."),
    name = ccb.content.plural_text("short dress with sleeves", "short dresses with sleeves"),
    variant_kind = "generic",
    variants = {
        {
            id = "white",
            name = ccb.content.plural_text("short white dress with sleeves", "short white dresses with sleeves"),
            append = true,
            description = ccb.content.text("This one is white."),
            color = "white",
            weight = 200,
        },
        {
            id = "black",
            name = ccb.content.plural_text("short black dress with sleeves", "short black dresses with sleeves"),
            append = true,
            description = ccb.content.text("This one is black."),
            color = "black",
            weight = 200,
        },
        {
            id = "witch_black",
            name = ccb.content.plural_text("short black witch dress", "short black witch dresses"),
            description = ccb.content.text("A short dress typically used by witches.  It's colored black."),
        },
        {
            id = "witch_green",
            name = ccb.content.plural_text("short green witch dress", "short green witch dresses"),
            description = ccb.content.text("A short dress typically used by witches.  It's colored dark green."),
        },
        {
            id = "witch_red",
            name = ccb.content.plural_text("short red witch dress", "short red witch dresses"),
            description = ccb.content.text("A short dress typically used by witches.  It's colored dark red."),
        },
        {
            id = "witch_purple",
            name = ccb.content.plural_text("short purple witch dress", "short purple witch dresses"),
            description = ccb.content.text("A short dress typically used by witches.  It's colored dark purple."),
        },
    },
    armor = {
        portions = {
            { encumbrance = 7, coverage = 85, covers = { "torso" } },
            { encumbrance = 1, coverage = 85, covers = { "arm_l", "arm_r" } },
            { encumbrance = 1, coverage = 25, covers = { "leg_l", "leg_r" } },
        },
    },
    inheritance = { scale = { mass = 0.75, volume = 0.75, warmth = 0.5 } },
}
