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

ccb.content.define_item {
    id = "buttonshirt",
    name = ccb.content.text("button shirt"),
    description = ccb.content.text("A button-down shirt with long sleeves.  Looks professional!"),
    mass = "250 g",
    volume = "750 ml",
    price = "15 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "longshirt",
    color = "white",
    faults = { { group = "fabric_cotton" } },
    flags = { "VARSIZE" },
    variant_kind = "generic",
    variants = {
        {
            id = "white",
            name = ccb.content.text("white button shirt"),
            append = true,
            description = ccb.content.text("This one is white."),
        },
        {
            id = "striped",
            name = ccb.content.text("striped button shirt"),
            append = true,
            expand_snippets = true,
            description = ccb.content.text("This one has <color> stripes."),
        },
    },
    armor = {
        portions = {
            { covers = { "torso" }, coverage = 90, encumbrance = { 4, 5 } },
            { covers = { "arm_l", "arm_r" }, coverage = 90, encumbrance = { 4, 4 } },
        },
        warmth = 10,
        thickness = 0.1,
    },
}

ccb.content.define_item {
    id = "dress_shirt",
    copy_from = "buttonshirt",
    name = ccb.content.text("pocket shirt"),
    description = ccb.content.text("A button-down shirt with long sleeves and a pocket on the front.  Looks professional!"),
    variants = {
        {
            id = "black",
            name = ccb.content.text("black dress shirt"),
            color = "dark_gray",
            append = true,
            description = ccb.content.text("This one is black."),
        },
        {
            id = "white",
            name = ccb.content.text("white dress shirt"),
            color = "light_gray",
            append = true,
            description = ccb.content.text("This one is white."),
        },
        {
            id = "blue",
            name = ccb.content.text("blue dress shirt"),
            color = "blue",
            append = true,
            description = ccb.content.text("This one is blue."),
        },
        {
            id = "gray",
            name = ccb.content.text("gray dress shirt"),
            color = "light_gray",
            append = true,
            description = ccb.content.text("This one is gray."),
        },
    },
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "350 ml",
            mass_limit = "2 kg",
            max_item_length = "9 cm",
            moves = 80,
        },
    },
    armor = {},
}

ccb.content.define_item {
    id = "dress_wedding",
    name = ccb.content.plural_text("wedding dress", "wedding dresses"),
    description = ccb.content.text("A beautiful white wedding dress.  What good will it be now?"),
    mass = "9 kg",
    volume = "18 L",
    price = "590 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "dress",
    color = "white",
    faults = { { group = "fabric_cotton" } },
    flags = { "VARSIZE" },
    armor = {
        warmth = 16,
        thickness = 0.2,
        portions = {
            { coverage = 90, covers = { "torso" }, encumbrance = 12 },
            { covers = { "leg_l", "leg_r" }, coverage = 100, encumbrance = 20 },
        },
    },
}

ccb.content.define_item {
    id = "flotation_vest",
    name = ccb.content.text("flotation vest"),
    description = ccb.content.text("A brightly-colored vest designed to keep you upright and floating in water."),
    mass = "451 g",
    volume = "9 L",
    price = "110 USD",
    survival_price = "2 USD 50 cent",
    materials = { "plastic", "canvas" },
    symbol = "[",
    looks_like = "vest_leather",
    color = "yellow",
    flags = { "FLOTATION", "WATER_FRIENDLY", "BELTED" },
    armor = {
        warmth = 3,
        thickness = 4,
        portions = { { encumbrance = 40, coverage = 40, covers = { "torso" } } },
    },
}

ccb.content.define_item {
    id = "flotation_vest_ms",
    name = ccb.content.text("makeshift flotation vest"),
    description = ccb.content.text("A flotation vest made of inflated animal skins."),
    mass = "451 g",
    volume = "9 L",
    price = "110 USD",
    survival_price = "2 USD 50 cent",
    materials = { "leather" },
    symbol = "[",
    looks_like = "vest_leather",
    color = "brown",
    flags = { "FLOTATION", "WATER_FRIENDLY", "BELTED" },
    armor = {
        warmth = 5,
        thickness = 2,
        portions = { { encumbrance = 50, coverage = 40, covers = { "torso" } } },
    },
}

ccb.content.define_item {
    id = "gown",
    name = ccb.content.text("evening gown"),
    description = ccb.content.text("A luxurious evening gown.  It accentuates your curves, or lack thereof."),
    mass = "1800 g",
    volume = "5 L",
    price = "210 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "dress",
    color = "dark_gray",
    faults = { { group = "fabric_cotton" } },
    flags = { "VARSIZE" },
    armor = {
        warmth = 10,
        thickness = 0.3,
        portions = { { encumbrance = 14, coverage = 75, covers = { "torso", "leg_l", "leg_r" } } },
    },
}

ccb.content.define_item {
    id = "gown_sleeved",
    copy_from = "gown",
    name = ccb.content.plural_text("evening gown with sleeves", "evening gowns with sleeves"),
    description = ccb.content.text("A luxurious evening gown with full sleeves.  It accentuates your curves, or lack thereof."),
    variant_kind = "generic",
    variants = {
        {
            id = "black",
            name = ccb.content.text("black gown"),
            append = true,
            description = ccb.content.text("This one is black."),
            color = "black",
        },
        {
            id = "sinister",
            name = ccb.content.text("sinister gown"),
            description = ccb.content.text("A red and black gown with full sleeves.  It has a gothic style and looks pretty luxurious."),
            color = "red",
        },
    },
    armor = {
        portions = {
            { encumbrance = 14, coverage = 75, covers = { "torso", "leg_l", "leg_r" } },
            { encumbrance = 2, coverage = 90, covers = { "arm_l", "arm_r" } },
        },
    },
    inheritance = { scale = { warmth = 1.1, mass = 1.05, volume = 1.05 } },
}

ccb.content.define_item {
    id = "halter_top",
    name = ccb.content.text("halter top"),
    description = ccb.content.text("A short top made from cotton."),
    mass = "100 g",
    volume = "500 ml",
    price = "20 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "tank_top",
    color = "pink",
    faults = { { group = "fabric_cotton" } },
    flags = { "VARSIZE", "SKINTIGHT" },
    armor = { warmth = 2, thickness = 0.1, portions = { { coverage = 25, covers = { "torso" } } } },
}

ccb.content.define_item {
    id = "hoodie",
    name = ccb.content.text("hoodie"),
    description = ccb.content.text("A sweatshirt with a hood and a \"kangaroo pocket\" in the front for storage."),
    mass = "420 g",
    volume = "3 L",
    price = "38 USD",
    survival_price = "1 USD",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "sweater",
    color = "dark_gray",
    faults = { { group = "fabric_cotton" } },
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "3 L",
            mass_limit = "4 kg",
            max_item_length = "36 cm",
            moves = 80,
        },
    },
    flags = { "VARSIZE", "POCKETS", "HOOD", "OUTER" },
    variant_kind = "generic",
    variants = {
        {
            id = "hoodie_red",
            name = ccb.content.text("red hoodie"),
            description = ccb.content.text("This one is colored red."),
            color = "red",
            append = true,
            weight = 100,
        },
        {
            id = "hoodie_blue",
            name = ccb.content.text("blue hoodie"),
            color = "blue",
            description = ccb.content.text("This one is colored blue."),
            append = true,
            weight = 100,
        },
        {
            id = "hoodie_yellow",
            name = ccb.content.text("yellow hoodie"),
            color = "yellow",
            description = ccb.content.text("This one is colored yellow."),
            append = true,
            weight = 100,
        },
        {
            id = "hoodie_green",
            name = ccb.content.text("green hoodie"),
            color = "green",
            description = ccb.content.text("This one is colored green."),
            append = true,
            weight = 100,
        },
        {
            id = "hoodie_purple",
            name = ccb.content.text("purple hoodie"),
            color = "magenta",
            description = ccb.content.text("This one is colored purple."),
            append = true,
            weight = 100,
        },
        {
            id = "hoodie_pink",
            name = ccb.content.text("pink hoodie"),
            color = "magenta",
            description = ccb.content.text("This one is colored pink."),
            append = true,
            weight = 100,
        },
        {
            id = "hoodie_cyan",
            name = ccb.content.text("cyan hoodie"),
            color = "cyan",
            description = ccb.content.text("This one is colored cyan."),
            append = true,
            weight = 100,
        },
        {
            id = "hoodie_black",
            name = ccb.content.text("black hoodie"),
            color = "dark_gray",
            description = ccb.content.text("This one is colored black."),
            append = true,
            weight = 100,
        },
        {
            id = "hoodie_white",
            name = ccb.content.text("white hoodie"),
            color = "light_gray",
            description = ccb.content.text("This one is colored white."),
            append = true,
            weight = 100,
        },
        {
            id = "hoodie_brown",
            name = ccb.content.text("brown hoodie"),
            color = "brown",
            description = ccb.content.text("This one is colored brown."),
            append = true,
            weight = 100,
        },
        {
            id = "shark",
            name = ccb.content.text("shark hoodie"),
            append = true,
            description = ccb.content.text("This one is made to look like a cute shark."),
        },
        {
            id = "bear",
            name = ccb.content.text("bear hoodie"),
            append = true,
            description = ccb.content.text("This one is made to look like a cute bear."),
        },
        {
            id = "cat",
            name = ccb.content.text("cat hoodie"),
            append = true,
            description = ccb.content.text("This one is made to look like a cute cat."),
        },
        {
            id = "bunny",
            name = ccb.content.text("bunny hoodie"),
            append = true,
            description = ccb.content.text("This one is made to look like a cute bunny."),
        },
        {
            id = "wolf",
            name = ccb.content.text("wolf hoodie"),
            append = true,
            description = ccb.content.text("This one is made to look like a cute wolf."),
        },
        {
            id = "lizard",
            name = ccb.content.text("lizard hoodie"),
            append = true,
            description = ccb.content.text("This one is made to look like a cute lizard."),
        },
        {
            id = "dog",
            name = ccb.content.text("dog hoodie"),
            append = true,
            description = ccb.content.text("This one is made to look like a cute dog."),
        },
        {
            id = "panda",
            name = ccb.content.text("panda hoodie"),
            append = true,
            description = ccb.content.text("This one is made to look like a cute panda."),
        },
        {
            id = "frog",
            name = ccb.content.text("frog hoodie"),
            append = true,
            description = ccb.content.text("This one is made to look like a cute frog."),
        },
    },
    armor = {
        portions = {
            { covers = { "torso" }, coverage = 95, encumbrance = { 6, 12 } },
            { covers = { "arm_l", "arm_r" }, coverage = 95, encumbrance = { 6, 6 } },
        },
        warmth = 20,
        thickness = 1,
        valid_mods = { "steel_padded" },
    },
}

ccb.content.define_item {
    id = "hoodie_cropped",
    copy_from = "hoodie",
    pockets = {},
    name = ccb.content.text("cropped hoodie"),
    description = ccb.content.text("A sweatshirt with a hood, cropped to expose the stomach."),
    variant_kind = "generic",
    variants = {
        {
            id = "hoodie_red",
            name = ccb.content.text("red cropped hoodie"),
            description = ccb.content.text("This one is colored red."),
            color = "red",
            append = true,
            weight = 100,
        },
        {
            id = "hoodie_blue",
            name = ccb.content.text("blue cropped hoodie"),
            color = "blue",
            description = ccb.content.text("This one is colored blue."),
            append = true,
            weight = 100,
        },
        {
            id = "hoodie_yellow",
            name = ccb.content.text("yellow cropped hoodie"),
            color = "yellow",
            description = ccb.content.text("This one is colored yellow."),
            append = true,
            weight = 100,
        },
        {
            id = "hoodie_green",
            name = ccb.content.text("green cropped hoodie"),
            color = "green",
            description = ccb.content.text("This one is colored green."),
            append = true,
            weight = 100,
        },
        {
            id = "hoodie_purple",
            name = ccb.content.text("purple cropped hoodie"),
            color = "magenta",
            description = ccb.content.text("This one is colored purple."),
            append = true,
            weight = 100,
        },
        {
            id = "hoodie_pink",
            name = ccb.content.text("pink cropped hoodie"),
            color = "magenta",
            description = ccb.content.text("This one is colored pink."),
            append = true,
            weight = 100,
        },
        {
            id = "hoodie_cyan",
            name = ccb.content.text("cyan cropped hoodie"),
            color = "cyan",
            description = ccb.content.text("This one is colored cyan."),
            append = true,
            weight = 100,
        },
        {
            id = "hoodie_black",
            name = ccb.content.text("black cropped hoodie"),
            color = "dark_gray",
            description = ccb.content.text("This one is colored black."),
            append = true,
            weight = 100,
        },
        {
            id = "hoodie_white",
            name = ccb.content.text("white cropped hoodie"),
            color = "light_gray",
            description = ccb.content.text("This one is colored white."),
            append = true,
            weight = 100,
        },
        {
            id = "hoodie_brown",
            name = ccb.content.text("brown cropped hoodie"),
            color = "brown",
            description = ccb.content.text("This one is colored brown."),
            append = true,
            weight = 100,
        },
        {
            id = "shark",
            name = ccb.content.text("shark cropped hoodie"),
            append = true,
            description = ccb.content.text("This one is made to look like a cute shark."),
        },
        {
            id = "bear",
            name = ccb.content.text("bear cropped hoodie"),
            append = true,
            description = ccb.content.text("This one is made to look like a cute bear."),
        },
        {
            id = "cat",
            name = ccb.content.text("cat cropped hoodie"),
            append = true,
            description = ccb.content.text("This one is made to look like a cute cat."),
        },
        {
            id = "bunny",
            name = ccb.content.text("bunny cropped hoodie"),
            append = true,
            description = ccb.content.text("This one is made to look like a cute bunny."),
        },
        {
            id = "wolf",
            name = ccb.content.text("wolf cropped hoodie"),
            append = true,
            description = ccb.content.text("This one is made to look like a cute wolf."),
        },
        {
            id = "lizard",
            name = ccb.content.text("lizard cropped hoodie"),
            append = true,
            description = ccb.content.text("This one is made to look like a cute lizard."),
        },
        {
            id = "dog",
            name = ccb.content.text("dog cropped hoodie"),
            append = true,
            description = ccb.content.text("This one is made to look like a cute dog."),
        },
        {
            id = "panda",
            name = ccb.content.text("panda cropped hoodie"),
            append = true,
            description = ccb.content.text("This one is made to look like a cute panda."),
        },
        {
            id = "frog",
            name = ccb.content.text("frog cropped hoodie"),
            append = true,
            description = ccb.content.text("This one is made to look like a cute frog."),
        },
    },
    armor = {
        portions = {
            { covers = { "torso" }, subparts = { "torso_upper" }, coverage = 95, encumbrance = 4 },
            { covers = { "arm_l", "arm_r" }, coverage = 95, encumbrance = 6 },
        },
    },
    inheritance = { remove = { flags = { "POCKETS" } }, scale = { mass = 0.75, volume = 0.75, warmth = 0.75 } },
}

-- inherit name and description from item
ccb.content.define_item {
    id = "jersey",
    name = ccb.content.text("sports jersey"),
    description = ccb.content.text("A lightweight, breathable shirt made from synthetic fabric, designed for athletic performance and team identification."),
    mass = "150 g",
    volume = "500 ml",
    price = "89 USD",
    survival_price = "50 cent",
    materials = { "nylon", "lycra" },
    symbol = "[",
    looks_like = "tshirt",
    flags = { "VARSIZE" },
    variant_kind = "generic",
    variants = {
        { id = "generic" },
        {
            id = "sportsteam",
            name = ccb.content.text("sports team jersey"),
            append = true,
            expand_snippets = true,
            description = ccb.content.text("This one is printed with the name and logo of the <sports_team>"),
        },
    },
    armor = {
        warmth = 5,
        thickness = 0.3,
        portions = { { breathability = "SECOND_SKIN", coverage = 90, covers = { "torso", "arm_l", "arm_r" } } },
    },
}

ccb.content.define_item {
    id = "leotard",
    name = ccb.content.text("leotard"),
    description = ccb.content.text("A skin-tight spandex garment, covering the body from the groin to the shoulders.  With its deep scoop-cut back and high waist cuts, this garment is perfect for showcasing your physique on the stage."),
    mass = "150 g",
    volume = "500 ml",
    price = "10 USD",
    survival_price = "50 cent",
    materials = { "lycra" },
    symbol = "[",
    color = "dark_gray",
    flags = { "VARSIZE", "SKINTIGHT", "WATER_FRIENDLY" },
    armor = { warmth = 5, thickness = 0.01, portions = { { coverage = 80, covers = { "torso" } } } },
}

ccb.content.define_item {
    id = "longshirt",
    name = ccb.content.text("long-sleeved shirt"),
    description = ccb.content.text("A long-sleeved cotton shirt."),
    mass = "146 g",
    volume = "750 ml",
    price = "20 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "dress_shirt",
    color = "blue",
    faults = { { group = "fabric_cotton" } },
    flags = { "VARSIZE", "SKINTIGHT" },
    armor = {
        warmth = 5,
        thickness = 0.1,
        portions = { { coverage = 90, covers = { "torso", "arm_l", "arm_r" } } },
    },
}

ccb.content.define_item {
    id = "maid_dress",
    name = ccb.content.plural_text("French maid clothes", "French maid clothes"),
    description = ccb.content.text("The French maid dress, blue with a frilly white apron."),
    mass = "125 g",
    volume = "250 ml",
    price = "50 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "dress",
    color = "blue",
    faults = { { group = "fabric_cotton" } },
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "500 ml",
            mass_limit = "3 kg",
            max_item_length = "10 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "200 ml",
            mass_limit = "1 kg",
            max_item_length = "15 cm",
            moves = 120,
            description = ccb.content.text("Hidden pocket."),
        },
    },
    flags = { "VARSIZE", "COSPLAY_COSTUME" },
    armor = {
        portions = {
            { covers = { "torso" }, coverage = 100, encumbrance = { 5, 7 } },
            { covers = { "leg_l", "leg_r" }, coverage = 95, encumbrance = { 5, 5 } },
            { covers = { "arm_l", "arm_r" }, coverage = 95, encumbrance = { 5, 5 } },
        },
        warmth = 10,
        thickness = 0.1,
    },
}

ccb.content.define_item {
    id = "maid_dress_xl",
    copy_from = "maid_dress",
    name = ccb.content.plural_text("French maid clothes", "French maid clothes"),
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "maid_dress_xs",
    copy_from = "maid_dress",
    name = ccb.content.plural_text("French maid clothes", "French maid clothes"),
    armor = {},
    inheritance = { add = { flags = { "UNDERSIZE", "PREFIX_XS" } }, scale = { mass = 0.5, volume = 0.5 } },
}

ccb.content.define_item {
    id = "maid_dress_short",
    name = ccb.content.plural_text("short French maid clothes", "short French maid clothes"),
    description = ccb.content.text("The French maid dress, black with a frilly white apron.  This version is much lighter and shorter than normal."),
    mass = "125 g",
    volume = "250 ml",
    price = "50 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "maid_dress",
    color = "dark_gray",
    faults = { { group = "fabric_cotton" } },
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "200 ml",
            mass_limit = "1 kg",
            max_item_length = "15 cm",
            moves = 120,
            description = ccb.content.text("Hidden pocket."),
        },
    },
    flags = { "VARSIZE", "COSPLAY_COSTUME" },
    armor = {
        portions = {
            { covers = { "torso" }, subparts = { "torso_lower" }, coverage = 100, encumbrance = 4 },
            { covers = { "torso" }, subparts = { "torso_upper" }, coverage = 20 },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
                coverage = 100,
                encumbrance = 2,
            },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
                coverage = 50,
            },
            {
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_shoulder_r" },
                coverage = 15,
                encumbrance = 2,
            },
        },
        warmth = 2,
        thickness = 0.1,
    },
}

ccb.content.define_item {
    id = "maid_dress_short_xl",
    copy_from = "maid_dress_short",
    name = ccb.content.plural_text("short French maid clothes", "short French maid clothes"),
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "maid_dress_short_xs",
    copy_from = "maid_dress_short",
    name = ccb.content.plural_text("short French maid clothes", "short French maid clothes"),
    armor = {},
    inheritance = { add = { flags = { "UNDERSIZE", "PREFIX_XS" } }, scale = { mass = 0.5, volume = 0.5 } },
}

ccb.content.define_item {
    id = "mummy_dress",
    name = ccb.content.plural_text("mummy dress", "mummy dresses"),
    description = ccb.content.text("A short off-white dress printed to look like the tattered wrappings of an ancient mummy.  Very easy to move in, but it doesn't offer any type of protection."),
    mass = "10 g",
    volume = "2000 ml",
    price = "50 USD",
    survival_price = "10 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "dress",
    color = "white",
    faults = { { group = "fabric_cotton" } },
    flags = { "VARSIZE", "SKINTIGHT", "FRAGILE", "COSPLAY_COSTUME" },
    armor = {
        portions = {
            { covers = { "torso" }, coverage = 90 },
            { covers = { "arm_l", "arm_r" }, coverage = 85 },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
                coverage = 100,
            },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
                coverage = 40,
            },
        },
        thickness = 0.1,
    },
}

ccb.content.define_item {
    id = "ninja_dress",
    name = ccb.content.plural_text("ninja dress", "ninja dresses"),
    description = ccb.content.text("A short black and red sleeved dress with oriental dragon motifs printed on it.  Perfect for the kunoichi that wants a little more style."),
    mass = "440 g",
    volume = "2250 ml",
    price = "160 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "sundress",
    color = "dark_gray",
    faults = { { group = "fabric_cotton" } },
    flags = { "VARSIZE", "COSPLAY_COSTUME" },
    armor = {
        warmth = 5,
        thickness = 0.2,
        portions = {
            { covers = { "torso", "arm_l", "arm_r" }, coverage = 85, encumbrance = 4 },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
                coverage = 100,
                encumbrance = 2,
            },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
                coverage = 40,
            },
        },
    },
}

ccb.content.define_item {
    id = "ninja_dress_sleeveless",
    name = ccb.content.plural_text("ninja sleeveless dress", "ninja sleeveless dresses"),
    description = ccb.content.text("A short black and red dress with oriental dragon motifs printed on it.  Perfect for the kunoichi that wants a little more style."),
    mass = "408 g",
    volume = "2000 ml",
    price = "160 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "sundress",
    color = "dark_gray",
    faults = { { group = "fabric_cotton" } },
    flags = { "VARSIZE", "COSPLAY_COSTUME" },
    armor = {
        warmth = 5,
        thickness = 0.2,
        portions = {
            { covers = { "torso" }, coverage = 85, encumbrance = 4 },
            {
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_shoulder_r" },
                coverage = 80,
            },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
                coverage = 100,
                encumbrance = 2,
            },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
                coverage = 40,
            },
        },
    },
}

ccb.content.define_item {
    id = "polo_shirt",
    name = ccb.content.text("polo shirt"),
    description = ccb.content.text("A short-sleeved cotton shirt, slightly thicker than a t-shirt."),
    mass = "136 g",
    volume = "750 ml",
    price = "15 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "tshirt",
    color = "light_red",
    faults = { { group = "fabric_cotton" } },
    flags = { "VARSIZE" },
    armor = {
        warmth = 10,
        thickness = 0.2,
        portions = {
            { encumbrance = 7, coverage = 90, covers = { "torso" } },
            {
                coverage = 100,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_shoulder_r" },
            },
            {
                coverage = 50,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_upper_l", "arm_upper_r" },
            },
        },
    },
}

-- inherit name and description from item
-- inherit name from item
ccb.content.define_item {
    id = "postman_shirt",
    name = ccb.content.text("mail carrier shirt"),
    description = ccb.content.text("A light blue button down shirt with a couple of pockets in front and the US postal service logo embroidered on it."),
    mass = "110 g",
    volume = "500 ml",
    price = "15 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "polo_shirt",
    color = "light_blue",
    faults = { { group = "fabric_cotton" } },
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "800 ml",
            mass_limit = "3 kg",
            max_item_length = "15 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "800 ml",
            mass_limit = "3 kg",
            max_item_length = "15 cm",
            moves = 80,
        },
    },
    flags = { "VARSIZE" },
    variant_kind = "generic",
    variants = {
        { id = "generic" },
        {
            id = "sheriff",
            description = ccb.content.text("A tan button-down shirt with long sleeves."),
        },
        {
            id = "swat",
            name = ccb.content.text("SWAT shirt"),
            description = ccb.content.text("A charcoal button-down shirt with long sleeves.  Has a patch with the word \"SWAT\" affixed on one shoulder."),
        },
    },
    armor = {
        warmth = 5,
        thickness = 0.1,
        portions = {
            { coverage = 90, covers = { "torso" } },
            {
                encumbrance = { 0, 0 },
                coverage = 100,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_shoulder_r" },
            },
            {
                encumbrance = { 0, 0 },
                coverage = 50,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_upper_l", "arm_upper_r" },
            },
        },
    },
}

-- The dot after Mrs is not a period
ccb.content.define_item {
    id = "santa_dress",
    name = ccb.content.plural_text("Santa dress", "Santa dresses"),
    description = ccb.content.text("A sleeved red dress with white faux fur trim.  For when you want to be Mrs. Claus on Christmas, or perhaps Santa going clubbing."),
    mass = "800 g",
    volume = "3500 ml",
    price = "180 USD",
    survival_price = "60 cent",
    materials = { "cotton", "faux_fur" },
    symbol = "[",
    looks_like = "dress",
    color = "red",
    faults = { { group = "fabric_cotton" } },
    flags = { "VARSIZE", "COSPLAY_COSTUME" },
    armor = {
        warmth = 20,
        thickness = 0.4,
        portions = {
            { covers = { "torso" }, coverage = 95, encumbrance = 10 },
            { covers = { "arm_l", "arm_r" }, coverage = 95, encumbrance = 8 },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
                coverage = 100,
                encumbrance = 5,
            },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
                coverage = 50,
            },
        },
    },
}

ccb.content.define_item {
    id = "santa_dress_long",
    name = ccb.content.plural_text("luxury Santa dress", "luxury Santa dresses"),
    description = ccb.content.text("A long red dress with full sleeves and white faux fur trim.  A dress for a queen of the north pole."),
    mass = "1200 g",
    volume = "3850 ml",
    price = "250 USD",
    survival_price = "90 cent",
    materials = { "cotton", "faux_fur" },
    symbol = "[",
    looks_like = "santa_dress",
    color = "red",
    faults = { { group = "fabric_cotton" } },
    flags = { "VARSIZE", "COSPLAY_COSTUME" },
    armor = {
        warmth = 25,
        thickness = 0.8,
        portions = {
            { covers = { "torso" }, coverage = 85, encumbrance = 8 },
            { covers = { "arm_l", "arm_r" }, coverage = 85, encumbrance = 6 },
            { covers = { "leg_l", "leg_r" }, coverage = 100, encumbrance = 8 },
        },
    },
}

-- The dot after Mrs is not a period
ccb.content.define_item {
    id = "santa_dress_short",
    name = ccb.content.plural_text("short Santa dress", "short Santa dresses"),
    description = ccb.content.text("A short red dress with white faux fur trim.  Looks like something Mrs. Claus might wear on Christmas night."),
    mass = "600 g",
    volume = "2000 ml",
    price = "160 USD",
    survival_price = "50 cent",
    materials = { "cotton", "faux_fur" },
    symbol = "[",
    looks_like = "sundress",
    color = "red",
    faults = { { group = "fabric_cotton" } },
    flags = { "VARSIZE", "COSPLAY_COSTUME" },
    armor = {
        warmth = 15,
        thickness = 0.2,
        portions = {
            { covers = { "torso" }, coverage = 75, encumbrance = 4 },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
                coverage = 100,
                encumbrance = 4,
            },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
                coverage = 40,
            },
        },
    },
}

ccb.content.define_item {
    id = "shirt_straw",
    name = ccb.content.text("grass shirt"),
    description = ccb.content.text("A crude and bulky short-sleeved shirt woven from grass.  Definitely not the most comfortable thing to wear."),
    mass = "500 g",
    volume = "2500 ml",
    price = "1 USD",
    survival_price = "5 cent",
    materials = { "dry_plant" },
    symbol = "[",
    looks_like = "camisole",
    color = "yellow",
    flags = { "VARSIZE" },
    armor = {
        portions = {
            { covers = { "torso" }, coverage = 90, encumbrance = 8 },
            {
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_shoulder_r", "arm_upper_l", "arm_upper_r" },
                coverage = 40,
                encumbrance = 1,
            },
        },
        warmth = 5,
        thickness = 0.5,
    },
}

ccb.content.define_item {
    id = "sundress",
    name = ccb.content.plural_text("sundress", "sundresses"),
    description = ccb.content.text("A light and breezy cotton dress."),
    mass = "300 g",
    volume = "1 L",
    price = "40 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "dress",
    color = "yellow",
    faults = { { group = "fabric_cotton" } },
    flags = { "VARSIZE" },
    armor = {
        thickness = 0.1,
        portions = {
            { coverage = 65, covers = { "torso" } },
            {
                covers = { "leg_l", "leg_r" },
                subparts = {
                    "leg_knee_l",
                    "leg_knee_r",
                    "leg_upper_l",
                    "leg_upper_r",
                    "leg_hip_l",
                    "leg_hip_r",
                },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "sweater",
    name = ccb.content.text("sweater"),
    description = ccb.content.text("A warm wool sweater."),
    mass = "550 g",
    volume = "2 L",
    price = "45 USD",
    survival_price = "1 USD",
    materials = { "wool" },
    symbol = "[",
    looks_like = "longshirt",
    color = "blue",
    flags = { "VARSIZE" },
    armor = {
        warmth = 35,
        thickness = 1,
        valid_mods = { "steel_padded" },
        portions = { { encumbrance = 6, coverage = 95, covers = { "torso", "arm_l", "arm_r" } } },
    },
}

ccb.content.define_item {
    id = "sweatshirt",
    name = ccb.content.text("sweatshirt"),
    description = ccb.content.text("A thick cotton shirt."),
    mass = "244 g",
    volume = "3500 ml",
    price = "18 USD",
    survival_price = "1 USD",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "longshirt",
    color = "light_red",
    faults = { { group = "fabric_cotton" } },
    flags = { "VARSIZE" },
    armor = {
        warmth = 30,
        thickness = 1,
        valid_mods = { "steel_padded" },
        portions = { { encumbrance = 6, coverage = 95, covers = { "torso", "arm_l", "arm_r" } } },
    },
}

ccb.content.define_item {
    id = "technician_shirt_gray",
    name = "work t-shirt",
    description = "A gray work t-shirt with a small front pocket.",
    symbol = "[",
    color = "light_gray",
    looks_like = "polo_shirt",
    mass = "200 g",
    volume = "250 ml",
    price = "10 USD",
    survival_price = "50 cent",
    snippet_category = {
        {
            id = "technician_shirt_blue",
            text = "A blue work t-shirt with a small front pocket.",
        },
        {
            id = "technician_shirt_gray",
            text = "A gray work t-shirt with a small front pocket.",
        },
        {
            id = "technician_shirt_lightblue",
            text = "A light-blue work t-shirt with a small front pocket.",
        },
    },
    flags = { "VARSIZE" },
    materials = { "canvas" },
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "650 ml",
            mass_limit = "1 kg",
            max_item_length = "15 cm",
            moves = 80,
        },
    },
    armor = {
        thickness = 0.2,
        warmth = 8,
        portions = {
            {
                covers = { "torso" },
                coverage = 90,
                encumbrance = { 4, 5 },
            },
            {
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_shoulder_r" },
                coverage = 100,
                encumbrance = { 0, 0 },
            },
            {
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_upper_l", "arm_upper_r" },
                coverage = 50,
                encumbrance = { 0, 0 },
            },
        },
    },
}

-- inherit name and description from item
ccb.content.define_item {
    id = "tshirt",
    name = ccb.content.text("t-shirt"),
    description = ccb.content.text("A short-sleeved cotton shirt."),
    mass = "110 g",
    volume = "500 ml",
    price = "8 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "camisole",
    color = "white",
    faults = { { group = "fabric_cotton" } },
    variant_kind = "generic",
    variants = {
        { id = "generic_tshirt", weight = 40 },
        {
            id = "baseball_fan_tshirt",
            name = ccb.content.text("baseball t-shirt"),
            description = ccb.content.text("A short-sleeved cotton shirt with the logo of a local baseball team printed on its front and back."),
        },
        {
            id = "football_fan_tshirt",
            name = ccb.content.text("football t-shirt"),
            description = ccb.content.text("A short-sleeved cotton shirt with the logo of a local football team printed on its front and back."),
        },
        {
            id = "picture",
            name = ccb.content.text("picture t-shirt"),
            append = true,
            expand_snippets = true,
            description = ccb.content.text("This one has a picture on it, <clothing_picture>"),
        },
        {
            id = "text",
            name = ccb.content.text("text print t-shirt"),
            append = true,
            expand_snippets = true,
            description = ccb.content.text("This one has some text on it, it says \"<clothing_text>\"."),
        },
        {
            id = "flag_shirt",
            name = ccb.content.text("flag t-shirt"),
            description = ccb.content.text("A t-shirt embroidered with an American flag pattern."),
            symbol = "[",
            color = "light_red",
        },
        {
            id = "linux",
            name = ccb.content.text("linux t-shirt"),
            append = true,
            expand_snippets = true,
            description = ccb.content.text("This one has a joke in the form of <linux_joke>."),
        },
        {
            id = "band",
            name = ccb.content.text("band t-shirt"),
            append = true,
            expand_snippets = true,
            description = ccb.content.text("This one is merch for a music band and has <music_band_graphic>"),
        },
        {
            id = "red_tshirt",
            name = ccb.content.text("red t-shirt"),
            description = ccb.content.text("This one is colored red."),
            color = "red",
            append = true,
            weight = 24,
        },
        {
            id = "blue_tshirt",
            name = ccb.content.text("blue t-shirt"),
            color = "blue",
            description = ccb.content.text("This one is colored blue."),
            append = true,
            weight = 24,
        },
        {
            id = "yellow_tshirt",
            name = ccb.content.text("yellow t-shirt"),
            color = "yellow",
            description = ccb.content.text("This one is colored yellow."),
            append = true,
            weight = 24,
        },
        {
            id = "green_tshirt",
            name = ccb.content.text("green t-shirt"),
            color = "green",
            description = ccb.content.text("This one is colored green."),
            append = true,
            weight = 24,
        },
        {
            id = "purple_tshirt",
            name = ccb.content.text("purple t-shirt"),
            color = "magenta",
            description = ccb.content.text("This one is colored purple."),
            append = true,
            weight = 24,
        },
        {
            id = "pink_tshirt",
            name = ccb.content.text("pink t-shirt"),
            color = "magenta",
            description = ccb.content.text("This one is colored pink."),
            append = true,
            weight = 24,
        },
        {
            id = "cyan_tshirt",
            name = ccb.content.text("cyan t-shirt"),
            color = "cyan",
            description = ccb.content.text("This one is colored cyan."),
            append = true,
            weight = 24,
        },
        {
            id = "black_tshirt",
            name = ccb.content.text("black t-shirt"),
            color = "dark_gray",
            description = ccb.content.text("This one is colored black."),
            append = true,
            weight = 24,
        },
        {
            id = "brown_tshirt",
            name = ccb.content.text("brown t-shirt"),
            color = "brown",
            description = ccb.content.text("This one is colored brown."),
            append = true,
            weight = 24,
        },
        {
            id = "3dog_tshirt",
            name = ccb.content.text("3 Wolf Moon t-shirt"),
            color = "magenta",
            description = ccb.content.text("This magnificent piece of clothing contains not one, not two, but THREE WOLVES.  THREE WOLVES HOWLING AT THE MOON!  It is the most badass item of clothing ever produced."),
            weight = 1,
        },
        {
            id = "striped_blue_yellow",
            name = ccb.content.text("blue-yellow striped t-shirt"),
            color = "blue",
            description = ccb.content.text("This one has blue-yellow pattern."),
            append = true,
        },
        {
            id = "striped_red_yellow",
            name = ccb.content.text("red-yellow striped t-shirt"),
            color = "red",
            description = ccb.content.text("This one has red-yellow pattern."),
            append = true,
        },
        {
            id = "striped_yellow_green",
            name = ccb.content.text("yellow-green striped t-shirt"),
            color = "yellow",
            description = ccb.content.text("This one has yellow-green pattern."),
            append = true,
        },
        {
            id = "striped_blue_white",
            name = ccb.content.text("blue-white striped t-shirt"),
            color = "blue",
            description = ccb.content.text("This one has blue-white pattern."),
            append = true,
        },
    },
    flags = { "VARSIZE" },
    armor = {
        warmth = 5,
        thickness = 0.1,
        portions = {
            { coverage = 90, covers = { "torso" } },
            {
                coverage = 100,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_shoulder_r" },
            },
            {
                coverage = 50,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_upper_l", "arm_upper_r" },
            },
        },
    },
}

-- inherit name and description from item
ccb.content.define_item {
    id = "tshirt_cropped",
    copy_from = "tshirt",
    name = ccb.content.text("crop top"),
    description = ccb.content.text("A short-sleeved cotton shirt, cropped to expose the stomach."),
    variant_kind = "generic",
    variants = {
        { id = "generic_tshirt", weight = 1 },
        {
            id = "red_tshirt",
            name = ccb.content.text("red crop top"),
            description = ccb.content.text("This one is colored red."),
            color = "red",
            append = true,
            weight = 1,
        },
        {
            id = "blue_tshirt",
            name = ccb.content.text("blue crop top"),
            color = "blue",
            description = ccb.content.text("This one is colored blue."),
            append = true,
            weight = 1,
        },
        {
            id = "yellow_tshirt",
            name = ccb.content.text("yellow crop top"),
            color = "yellow",
            description = ccb.content.text("This one is colored yellow."),
            append = true,
            weight = 1,
        },
        {
            id = "green_tshirt",
            name = ccb.content.text("green crop top"),
            color = "green",
            description = ccb.content.text("This one is colored green."),
            append = true,
            weight = 1,
        },
        {
            id = "purple_tshirt",
            name = ccb.content.text("purple crop top"),
            color = "magenta",
            description = ccb.content.text("This one is colored purple."),
            append = true,
            weight = 1,
        },
        {
            id = "pink_tshirt",
            name = ccb.content.text("pink crop top"),
            color = "magenta",
            description = ccb.content.text("This one is colored pink."),
            append = true,
            weight = 1,
        },
        {
            id = "cyan_tshirt",
            name = ccb.content.text("cyan crop top"),
            color = "cyan",
            description = ccb.content.text("This one is colored cyan."),
            append = true,
            weight = 1,
        },
        {
            id = "black_tshirt",
            name = ccb.content.text("black crop top"),
            color = "dark_gray",
            description = ccb.content.text("This one is colored black."),
            append = true,
            weight = 1,
        },
        {
            id = "brown_tshirt",
            name = ccb.content.text("brown crop top"),
            color = "brown",
            description = ccb.content.text("This one is colored brown."),
            append = true,
            weight = 1,
        },
    },
    armor = {
        portions = {
            { coverage = 90, covers = { "torso" }, subparts = { "torso_upper" } },
            {
                coverage = 100,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_shoulder_r" },
            },
            {
                coverage = 50,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_upper_l", "arm_upper_r" },
            },
        },
    },
    inheritance = { scale = { mass = 0.5, volume = 0.5, warmth = 0.5 } },
}

ccb.content.define_item {
    id = "tallit_katan",
    name = ccb.content.plural_text("tallit katan", "tallit katan"),
    description = ccb.content.text("A shirt with four tassels worn by observant Jews in deference to Deuteronomy 22:12, which commands the wearing of fringes on the corner of one's garments."),
    mass = "158 g",
    volume = "500 ml",
    price = "60 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "tshirt",
    color = "white",
    faults = { { group = "fabric_cotton" } },
    flags = { "VARSIZE", "SKINTIGHT" },
    armor = {
        warmth = 10,
        thickness = 0.1,
        portions = {
            { coverage = 90, covers = { "torso" } },
            {
                coverage = 100,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_shoulder_r" },
            },
            {
                coverage = 50,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_upper_l", "arm_upper_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "uttarasanga",
    name = ccb.content.text("uttarasanga"),
    description = ccb.content.text("A traditional Buddhist shirt, covering most of the upper body, but not the arms."),
    mass = "250 g",
    volume = "750 ml",
    price = "65 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "longshirt",
    color = "brown",
    faults = { { group = "fabric_cotton" } },
    pockets = { { kind = "CONTAINER", capacity = "250 ml", mass_limit = "1 kg", moves = 400 } },
    flags = { "VARSIZE" },
    armor = {
        warmth = 5,
        thickness = 0.4,
        portions = { { encumbrance = { 4, 5 }, coverage = 50, covers = { "torso" } } },
    },
}

ccb.content.define_item {
    id = "vest_leather",
    name = ccb.content.text("leather vest"),
    description = ccb.content.text("A vest made from thick leather."),
    mass = "997 g",
    volume = "2500 ml",
    price = "55 USD",
    survival_price = "2 USD 50 cent",
    materials = { "leather" },
    symbol = "[",
    looks_like = "vest",
    color = "brown",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "650 ml",
            mass_limit = "3 kg",
            max_item_length = "15 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "800 ml",
            mass_limit = "3 kg",
            max_item_length = "15 cm",
            moves = 120,
        },
        {
            kind = "CONTAINER",
            capacity = "800 ml",
            mass_limit = "3 kg",
            max_item_length = "15 cm",
            moves = 120,
        },
    },
    flags = { "VARSIZE", "POCKETS", "OUTER" },
    armor = {
        warmth = 15,
        thickness = 1.5,
        environmental_protection = 1,
        valid_mods = { "steel_padded" },
        portions = { { encumbrance = { 4, 8 }, coverage = 90, covers = { "torso" } } },
    },
}

ccb.content.define_item {
    id = "wool_hoodie",
    name = ccb.content.text("wool hoodie"),
    description = ccb.content.text("A hooded wool shirt with a kangaroo pocket in the front."),
    mass = "580 g",
    volume = "3250 ml",
    price = "35 USD",
    survival_price = "1 USD",
    materials = { "wool" },
    symbol = "[",
    looks_like = "hoodie",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "3 L",
            mass_limit = "4 kg",
            max_item_length = "36 cm",
            moves = 80,
        },
    },
    flags = { "VARSIZE", "POCKETS", "HOOD", "OUTER" },
    armor = {
        portions = {
            { covers = { "torso" }, coverage = 95, encumbrance = { 6, 12 } },
            { covers = { "arm_l", "arm_r" }, coverage = 95, encumbrance = { 6, 6 } },
        },
        warmth = 35,
        thickness = 1,
        valid_mods = { "steel_padded" },
    },
}

ccb.content.define_item {
    id = "bunny_suit_playboy",
    name = ccb.content.text("bunny suit"),
    description = ccb.content.text("A bunny suit, still shiny despite the time it's likely spent in storage, or worse, on a corpse.  It was a recognizable piece of clothing often found in clubs or in playboy magazines."),
    mass = "136 g",
    volume = "750 ml",
    price = "50 USD",
    survival_price = "60 cent",
    materials = { "leather" },
    symbol = "[",
    looks_like = "wetsuit_spring",
    color = "dark_gray",
    flags = { "VARSIZE", "SKINTIGHT" },
    variants = {
        {
            id = "tailless",
            name = ccb.content.text("bunny suit"),
            description = ccb.content.text("A bunny suit, still shiny despite the time it's likely spent in storage, or worse, on a corpse.  It was a recognizable piece of clothing often found in clubs or in playboy magazines."),
        },
        {
            id = "tail",
            name = ccb.content.text("bunny suit"),
            description = ccb.content.text("This one comes with a white, fluffy tail"),
            append = true,
        },
    },
    armor = {
        portions = {
            { covers = { "torso" }, coverage = 60 },
            {
                coverage = 75,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
            },
        },
        thickness = 0.1,
    },
}

ccb.content.define_item {
    id = "cheongsam",
    name = ccb.content.text("cheongsam"),
    description = ccb.content.text("Also called qipao, it's a long, figure-fitting traditional chinese dress that covers the shoulders and features a standing collar, an asymmetric, left-over-right opening and two side slits."),
    mass = "500 g",
    volume = "3 L",
    price = "100 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "Y",
    looks_like = "dress",
    color = "light_red",
    faults = { { group = "fabric_cotton" } },
    flags = { "VARSIZE", "SKINTIGHT" },
    armor = {
        portions = {
            { covers = { "torso" }, coverage = 100 },
            { covers = { "leg_l", "leg_r" }, coverage = 80 },
            {
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_shoulder_r" },
                coverage = 100,
            },
        },
        thickness = 0.2,
    },
}

ccb.content.define_item {
    id = "denim_shirt",
    name = "denim shirt",
    description = "A long sleeved button-down shirt made from denim.",
    symbol = "[",
    color = "light_blue",
    looks_like = "dress_shirt",
    mass = "680 g",
    volume = "1 L",
    price = "50 USD",
    survival_price = "50 cent",
    snippet_category = {
        {
            id = "denim_shirt1",
            text = "A long sleeved button-down blue shirt made from denim.",
        },
        {
            id = "denim_shirt2",
            text = "A long sleeved button-down shirt made from denim, dyed black.",
        },
        {
            id = "denim_shirt3",
            text = "A long sleeved button-down cowboy wash shirt made from denim.",
        },
    },
    flags = { "VARSIZE" },
    materials = { "denim" },
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "400 ml",
            mass_limit = "4 kg",
            max_item_length = "10 cm",
            moves = 75,
        },
    },
    faults = {
        { group = "fabric_denim" },
    },
    armor = {
        thickness = 0.8,
        warmth = 10,
        portions = {
            {
                covers = { "torso" },
                coverage = 95,
                encumbrance = { 4, 5 },
            },
            {
                covers = { "arm_l", "arm_r" },
                coverage = 95,
                encumbrance = { 4, 4 },
            },
        },
    },
}
