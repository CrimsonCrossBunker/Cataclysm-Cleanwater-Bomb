local ccb = require("ccb")

-- inherit name and description from item
ccb.content.define_item {
    id = "bikini_bottom",
    name = ccb.content.plural_text("bikini bottoms", "bikini bottoms"),
    description = ccb.content.text("Simple bikini bottoms."),
    variant_kind = "generic",
    variants = {
        { id = "generic_bikini_bottom", weight = 30 },
        {
            id = "black_bikini_bottom",
            name = ccb.content.plural_text("black bikini bottoms", "black bikini bottoms"),
            description = ccb.content.text("They're colored black."),
            color = "dark_gray",
            weight = 10,
            append = true,
        },
        {
            id = "white_bikini_bottom",
            name = ccb.content.plural_text("white bikini bottoms", "white bikini bottoms"),
            description = ccb.content.text("They're colored white."),
            color = "white",
            weight = 10,
            append = true,
        },
        {
            id = "red_bikini_bottom",
            name = ccb.content.plural_text("red bikini bottoms", "red bikini bottoms"),
            description = ccb.content.text("They're colored red."),
            color = "red",
            weight = 10,
            append = true,
        },
        {
            id = "blue_bikini_bottom",
            name = ccb.content.plural_text("blue bikini bottoms", "blue bikini bottoms"),
            description = ccb.content.text("They're colored blue."),
            color = "blue",
            weight = 10,
            append = true,
        },
        {
            id = "flag_bikini_bottom",
            name = ccb.content.plural_text("flag bikini bottoms", "flag bikini bottoms"),
            description = ccb.content.text("They're printed with an American flag pattern."),
            weight = 7,
            append = true,
        },
        {
            id = "pink_bikini_bottom",
            name = ccb.content.plural_text("pink bikini bottoms", "pink bikini bottoms"),
            description = ccb.content.text("They're colored neon pink.  Pretty flashy."),
            color = "pink",
            weight = 6,
            append = true,
        },
        {
            id = "tropical_bikini_bottom",
            name = ccb.content.plural_text("tropical bikini bottoms", "tropical bikini bottoms"),
            description = ccb.content.text("They're green and has a tropical design."),
            color = "light_green",
            weight = 5,
            append = true,
        },
        {
            id = "floral_bikini_bottom",
            name = ccb.content.plural_text("floral bikini bottoms", "floral bikini bottoms"),
            description = ccb.content.text("They're colored yellow and has a floral design."),
            color = "yellow",
            weight = 5,
            append = true,
        },
        {
            id = "camo_bikini_bottom",
            name = ccb.content.plural_text("camo bikini bottoms", "camo bikini bottoms"),
            description = ccb.content.text("They're has a camouflage pattern, perfect for a soldier on beach leave."),
            color = "green",
            weight = 4,
            append = true,
        },
        {
            id = "skull_bikini_bottom",
            name = ccb.content.plural_text("skull bikini bottoms", "skull bikini bottoms"),
            description = ccb.content.text("They're colored black and printed with a skull pattern.  Works wonders to communicate your happiness on the beach."),
            symbol = "S",
            color = "dark_gray",
            weight = 2,
            append = true,
        },
        {
            id = "maid_bikini_bottom",
            name = ccb.content.plural_text("maid bikini bottoms", "maid bikini bottoms"),
            description = ccb.content.text("They're colored black with white frilly decorations.  You are not sure that this is common attire for the beach."),
            color = "dark_gray",
            append = true,
        },
    },
    mass = "32 g",
    volume = "250 ml",
    price = "10 USD",
    survival_price = "50 cent",
    materials = { "lycra" },
    symbol = "[",
    looks_like = "panties",
    color = "light_red",
    flags = { "VARSIZE", "SKINTIGHT", "WATER_FRIENDLY" },
    armor = {
        thickness = 0.1,
        portions = {
            {
                coverage = 75,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "bikini_bottom_short",
    name = ccb.content.plural_text("short bikini bottoms", "short bikini bottoms"),
    description = ccb.content.text("A very short pair of bikini bottoms, commonly called a thong."),
    mass = "15 g",
    volume = "150 ml",
    price = "10 USD",
    survival_price = "10 cent",
    materials = { "lycra" },
    symbol = "[",
    looks_like = "bikini_bottom",
    color = "red",
    flags = { "VARSIZE", "SKINTIGHT", "WATER_FRIENDLY" },
    armor = {
        thickness = 0.01,
        portions = {
            {
                coverage = 25,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
            },
        },
    },
}

-- inherit name and description from item
ccb.content.define_item {
    id = "bikini_top",
    name = ccb.content.text("bikini top"),
    description = ccb.content.text("A simple bikini top."),
    variant_kind = "generic",
    variants = {
        { id = "generic_bikini_top", weight = 30 },
        {
            id = "black_bikini_top",
            name = ccb.content.text("black bikini top"),
            description = ccb.content.text("It's colored black."),
            color = "dark_gray",
            weight = 10,
            append = true,
        },
        {
            id = "white_bikini_top",
            name = ccb.content.text("white bikini top"),
            description = ccb.content.text("It's colored white."),
            color = "white",
            weight = 10,
            append = true,
        },
        {
            id = "red_bikini_top",
            name = ccb.content.text("red bikini top"),
            description = ccb.content.text("It's colored red."),
            color = "red",
            weight = 10,
            append = true,
        },
        {
            id = "blue_bikini_top",
            name = ccb.content.text("blue bikini top"),
            description = ccb.content.text("It's colored blue."),
            color = "blue",
            weight = 10,
            append = true,
        },
        {
            id = "flag_bikini_top",
            name = ccb.content.text("flag bikini top"),
            description = ccb.content.text("It's printed with an American flag pattern."),
            weight = 7,
            append = true,
        },
        {
            id = "pink_bikini_top",
            name = ccb.content.text("pink bikini top"),
            description = ccb.content.text("It's colored neon pink.  Pretty flashy."),
            color = "pink",
            weight = 6,
            append = true,
        },
        {
            id = "tropical_bikini_top",
            name = ccb.content.text("tropical bikini top"),
            description = ccb.content.text("It's green and has a tropical design."),
            color = "light_green",
            weight = 5,
            append = true,
        },
        {
            id = "floral_bikini_top",
            name = ccb.content.text("floral bikini top"),
            description = ccb.content.text("It's colored yellow and has a floral design."),
            color = "yellow",
            weight = 5,
            append = true,
        },
        {
            id = "camo_bikini_top",
            name = ccb.content.text("camo bikini top"),
            description = ccb.content.text("It has a camouflage pattern, perfect for a soldier on beach leave."),
            color = "green",
            weight = 4,
            append = true,
        },
        {
            id = "skull_bikini_top",
            name = ccb.content.text("skull bikini top"),
            description = ccb.content.text("It's colored black and printed with a skull pattern.  Works wonders to communicate your happiness on the beach."),
            symbol = "S",
            color = "dark_gray",
            weight = 2,
            append = true,
        },
        {
            id = "maid_bikini_top",
            name = ccb.content.text("maid bikini top"),
            description = ccb.content.text("It's colored black with white frilly decorations.  You are not sure that this is common attire for the beach."),
            color = "dark_gray",
            append = true,
        },
    },
    mass = "32 g",
    volume = "250 ml",
    price = "18 USD",
    survival_price = "50 cent",
    materials = { "lycra" },
    symbol = "[",
    looks_like = "bra",
    color = "light_red",
    flags = { "VARSIZE", "WATER_FRIENDLY", "SKINTIGHT" },
    armor = {
        thickness = 0.1,
        portions = { { coverage = 25, covers = { "torso" }, subparts = { "torso_upper" } } },
    },
}

ccb.content.define_item {
    id = "bikini_top_short",
    name = ccb.content.text("short bikini top"),
    description = ccb.content.text("A very short bikini top.  It doesn't cover much, but was in fashion before the world ended."),
    mass = "15 g",
    volume = "150 ml",
    price = "18 USD",
    survival_price = "10 cent",
    materials = { "lycra" },
    symbol = "[",
    looks_like = "bikini_top",
    color = "red",
    flags = { "VARSIZE", "WATER_FRIENDLY", "SKINTIGHT" },
    armor = {
        thickness = 0.01,
        portions = { { coverage = 15, covers = { "torso" }, subparts = { "torso_upper" } } },
    },
}

-- the flag_swimsuit was first, so that's why this ID is used for all swimsuits
ccb.content.define_item {
    id = "flag_swimsuit",
    name = ccb.content.text("swimsuit"),
    description = ccb.content.text("A simple swimsuit."),
    mass = "136 g",
    volume = "750 ml",
    price = "11 USD 50 cent",
    survival_price = "60 cent",
    materials = { { id = "nylon", portions = 8 }, { id = "lycra", portions = 2 } },
    symbol = "[",
    looks_like = "wetsuit_spring",
    color = "light_red",
    flags = { "VARSIZE", "WATER_FRIENDLY", "SKINTIGHT" },
    variant_kind = "generic",
    variants = {
        {
            id = "generic_swimsuit",
            name = ccb.content.text("swimsuit"),
            description = ccb.content.text("A simple swimsuit."),
            weight = 30,
        },
        {
            id = "black_swimsuit",
            name = ccb.content.text("black swimsuit"),
            description = ccb.content.text("It's colored black."),
            color = "dark_gray",
            weight = 10,
            append = true,
        },
        {
            id = "white_swimsuit",
            name = ccb.content.text("white swimsuit"),
            description = ccb.content.text("It's colored white."),
            color = "white",
            weight = 10,
            append = true,
        },
        {
            id = "red_swimsuit",
            name = ccb.content.text("red swimsuit"),
            description = ccb.content.text("It's colored red."),
            color = "red",
            weight = 10,
            append = true,
        },
        {
            id = "blue_swimsuit",
            name = ccb.content.text("blue swimsuit"),
            description = ccb.content.text("It's colored blue."),
            color = "blue",
            weight = 10,
            append = true,
        },
        {
            id = "flag_swimsuit",
            name = ccb.content.text("flag swimsuit"),
            description = ccb.content.text("It's printed with an American flag pattern."),
            weight = 7,
            append = true,
        },
        {
            id = "pink_swimsuit",
            name = ccb.content.text("pink swimsuit"),
            description = ccb.content.text("It's colored neon pink.  Pretty flashy."),
            color = "pink",
            weight = 6,
            append = true,
        },
        {
            id = "tropical_swimsuit",
            name = ccb.content.text("tropical swimsuit"),
            description = ccb.content.text("It's green and has a tropical design."),
            color = "light_green",
            weight = 5,
            append = true,
        },
        {
            id = "floral_swimsuit",
            name = ccb.content.text("floral swimsuit"),
            description = ccb.content.text("It's colored yellow and has a floral design."),
            color = "yellow",
            weight = 5,
            append = true,
        },
        {
            id = "striped_swimsuit",
            name = ccb.content.text("striped swimsuit"),
            description = ccb.content.text("It has horizontal black and white stripes."),
            color = "light_gray",
            weight = 5,
            append = true,
        },
        {
            id = "camo_swimsuit",
            name = ccb.content.text("camo swimsuit"),
            description = ccb.content.text("It has a camouflage pattern, perfect for a soldier on beach leave."),
            color = "green",
            weight = 4,
            append = true,
        },
        {
            id = "lifeguard_swimsuit",
            name = ccb.content.text("lifeguard swimsuit"),
            description = ccb.content.text("It's bright red and has a white cross with the word \"Lifeguard\" on the front."),
            symbol = "+",
            color = "red",
            weight = 4,
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
    id = "rashguard",
    name = ccb.content.text("rashguard shirt"),
    description = ccb.content.text("A long-sleeved rashguard shirt.  Commonly used to protect against rashes from abrasion or sun exposure."),
    mass = "250 g",
    volume = "2 L",
    price = "52 USD 50 cent",
    survival_price = "1 USD",
    materials = { { id = "nylon", portions = 8 }, { id = "lycra", portions = 2 } },
    symbol = "[",
    looks_like = "longshirt",
    color = "light_red",
    flags = { "VARSIZE", "WATER_FRIENDLY" },
    variant_kind = "generic",
    variants = {
        {
            id = "black_rashguard_shirt",
            name = ccb.content.text("black rashguard shirt"),
            description = ccb.content.text("It's colored black."),
            color = "dark_gray",
            weight = 20,
            append = true,
        },
        {
            id = "white_rashguard_shirt",
            name = ccb.content.text("white rashguard shirt"),
            description = ccb.content.text("It's colored white."),
            color = "white",
            weight = 20,
            append = true,
        },
        {
            id = "red_rashguard_shirt",
            name = ccb.content.text("red rashguard shirt"),
            description = ccb.content.text("It's colored red."),
            color = "red",
            weight = 20,
            append = true,
        },
        {
            id = "blue_rashguard_shirt",
            name = ccb.content.text("blue rashguard shirt"),
            description = ccb.content.text("It's colored blue."),
            color = "blue",
            weight = 20,
            append = true,
        },
        {
            id = "flag_rashguard_shirt",
            name = ccb.content.text("flag rashguard shirt"),
            description = ccb.content.text("It's printed with an American flag pattern.  You feel as if the flag itself protects your skin."),
            weight = 10,
            append = true,
        },
        {
            id = "pink_rashguard_shirt",
            name = ccb.content.text("pink rashguard shirt"),
            description = ccb.content.text("It's colored neon pink.  Pretty flashy."),
            color = "pink",
            weight = 5,
            append = true,
        },
        {
            id = "tropical_rashguard_shirt",
            name = ccb.content.text("tropical rashguard shirt"),
            description = ccb.content.text("It's green and has a tropical design."),
            color = "light_green",
            weight = 5,
            append = true,
        },
        {
            id = "floral_rashguard_shirt",
            name = ccb.content.text("floral rashguard shirt"),
            description = ccb.content.text("It's colored yellow and has a floral design."),
            color = "yellow",
            weight = 5,
            append = true,
        },
        {
            id = "jungle_rashguard_shirt",
            name = ccb.content.text("jungle rashguard shirt"),
            description = ccb.content.text("It has jungle decorations and motifs of animals fighting among themselves."),
            color = "light_green",
            weight = 5,
            append = true,
        },
        {
            id = "camo_rashguard_shirt",
            name = ccb.content.text("camo rashguard shirt"),
            description = ccb.content.text("It has a camouflage pattern and outlines your muscles."),
            color = "green",
            weight = 4,
            append = true,
        },
        {
            id = "lifeguard_rashguard_shirt",
            name = ccb.content.text("lifeguard rashguard shirt"),
            description = ccb.content.text("It's bright red and has a white cross with the word \"Lifeguard\" on the front."),
            symbol = "+",
            color = "red",
            weight = 4,
            append = true,
        },
        {
            id = "skull_rashguard_shirt",
            name = ccb.content.text("skull rashguard shirt"),
            description = ccb.content.text("It's colored black and has a big skull on the front and back.  It makes you look tough."),
            symbol = "S",
            color = "dark_gray",
            weight = 2,
            append = true,
        },
        {
            id = "gothic_rashguard_shirt",
            name = ccb.content.text("gothic rashguard shirt"),
            description = ccb.content.text("It has a jet-black color with dark red decorations.  Looks creepy."),
            append = true,
        },
    },
    armor = {
        portions = {
            { covers = { "torso" }, coverage = 100, encumbrance = 6 },
            { covers = { "arm_l", "arm_r" }, coverage = 100, encumbrance = 6 },
        },
        warmth = 10,
        thickness = 1,
        environmental_protection = 1,
    },
}

ccb.content.define_item {
    id = "speedo",
    name = ccb.content.text("speedo"),
    description = ccb.content.text("A pair of very short black swim briefs.  Commonly used by male competitive swimmers and bodybuilders."),
    mass = "45 g",
    volume = "250 ml",
    price = "60 USD",
    survival_price = "50 cent",
    materials = { { id = "nylon", portions = 8 }, { id = "lycra", portions = 2 } },
    symbol = "[",
    color = "dark_gray",
    looks_like = "briefs",
    flags = { "VARSIZE", "WATER_FRIENDLY", "SKINTIGHT" },
    armor = {
        portions = {
            {
                covers = { "leg_l", "leg_r" },
                coverage = 50,
                subparts = { "leg_hip_l", "leg_hip_r" },
            },
        },
        thickness = 0.1,
    },
}

ccb.content.define_item {
    id = "swim_briefs",
    name = ccb.content.plural_text("swim briefs", "swim briefs"),
    description = ccb.content.text("A pair of blue swim briefs.  Commonly used by male competitive swimmers."),
    mass = "75 g",
    volume = "250 ml",
    price = "60 USD",
    survival_price = "50 cent",
    materials = { { id = "nylon", portions = 8 }, { id = "lycra", portions = 2 } },
    looks_like = "briefs",
    symbol = "[",
    color = "blue",
    flags = { "VARSIZE", "WATER_FRIENDLY", "SKINTIGHT" },
    armor = {
        portions = {
            {
                covers = { "leg_l", "leg_r" },
                coverage = 100,
                subparts = { "leg_hip_l", "leg_hip_r" },
            },
        },
        warmth = 5,
        thickness = 0.2,
    },
}

ccb.content.define_item {
    id = "swim_cap",
    name = ccb.content.text("swim cap"),
    description = ccb.content.text("A tightly fitted, skin-tight head garment made of Lycra.  Commonly used by recreational and competitive swimmers."),
    mass = "50 g",
    volume = "250 ml",
    price = "25 USD",
    survival_price = "10 cent",
    materials = { "lycra" },
    symbol = "[",
    looks_like = "hood_rain",
    color = "blue",
    flags = { "VARSIZE", "WATER_FRIENDLY", "SKINTIGHT" },
    armor = {
        warmth = 5,
        thickness = 0.1,
        environmental_protection = 1,
        portions = {
            {
                encumbrance_modifiers = { "NONE" },
                coverage = 100,
                covers = { "head" },
                subparts = { "head_forehead", "head_crown", "head_ear_r", "head_ear_l" },
            },
        },
    },
}

ccb.content.define_item {
    id = "trunks",
    name = ccb.content.plural_text("swimming trunks", "swimming trunks"),
    description = ccb.content.text("A pair of swimming trunks, with netting."),
    mass = "210 g",
    volume = "750 ml",
    price = "18 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "shorts",
    color = "blue",
    flags = { "VARSIZE", "WATER_FRIENDLY" },
    armor = {
        thickness = 0.1,
        portions = {
            {
                coverage = 100,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
            },
            {
                coverage = 50,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "wetsuit_booties",
    name = ccb.content.plural_text("diving socks (pair)", "diving socks (pair)"),
    description = ccb.content.text("A pair of 3 mm split-toe neoprene diving socks with thin rubber soles."),
    mass = "130 g",
    volume = "1 L",
    price = "68 USD",
    survival_price = "2 USD 50 cent",
    symbol = "[",
    looks_like = "boots_rubber",
    color = "dark_gray",
    flags = { "VARSIZE", "WATER_FRIENDLY", "WATERPROOF" },
    armor = {
        warmth = 30,
        environmental_protection = 10,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_ankle_r", "foot_ankle_l", "foot_heel_r",
                    "foot_heel_l", "foot_arch_r", "foot_arch_l",
                },
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.2 },
                    { id = "neoprene", coverage = 100, thickness = 3.0 },
                },
                encumbrance = 10,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.2 },
                    { id = "neoprene", coverage = 100, thickness = 3.0 },
                    { id = "rubber", coverage = 100, thickness = 1.0 },
                },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_wetsuit_booties",
    copy_from = "wetsuit_booties",
    name = ccb.content.plural_text("diving socks (pair)", "diving socks (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.25, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_wetsuit_booties",
    copy_from = "wetsuit_booties",
    name = ccb.content.plural_text("diving socks (pair)", "diving socks (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.75 },
    },
}

-- These will have an ablative armor slot for fins, as diving boots are designed to be worn with those.
ccb.content.define_item {
    id = "wetsuit_booties_thick",
    copy_from = "wetsuit_booties",
    name = ccb.content.plural_text("thick diving boots (pair)", "thick diving boots (pair)"),
    description = ccb.content.text("A pair of 5 mm thick neoprene diving boots with thick soles."),
    mass = "160 g",
    pockets = {
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "1300 ml",
            mass_limit = "1000 g",
            moves = 150,
            description = ccb.content.text("mounting for a pair of fins."),
            allowed_flags = { "BOOT_FINS" },
        },
    },
    armor = {
        warmth = 50,
        environmental_protection = 12,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_ankle_r", "foot_ankle_l", "foot_heel_r",
                    "foot_heel_l", "foot_arch_r", "foot_arch_l",
                },
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.4 },
                    { id = "neoprene", coverage = 100, thickness = 5.0 },
                },
                encumbrance = 20,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.4 },
                    { id = "neoprene", coverage = 100, thickness = 5.0 },
                    { id = "rubber", coverage = 100, thickness = 4.0 },
                },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_wetsuit_booties_thick",
    copy_from = "wetsuit_booties_thick",
    name = ccb.content.plural_text("thick diving boots (pair)", "thick diving boots (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.25, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_wetsuit_booties_thick",
    copy_from = "wetsuit_booties_thick",
    name = ccb.content.plural_text("thick diving boots (pair)", "thick diving boots (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.75 },
    },
}

-- Most fins have some way of adjustment as of now, so OVERSIZE flag.
ccb.content.define_item {
    id = "swim_fins",
    name = ccb.content.plural_text("swim fins (pair)", "swim fins (pair)"),
    description = ccb.content.text("A pair of rubber flippers worn on the feet, which improve swimming speed while greatly impeding the wearer's ability to walk."),
    mass = "680 g",
    volume = "1250 ml",
    price = "20 USD",
    survival_price = "2 USD 50 cent",
    materials = { "rubber" },
    symbol = "[",
    looks_like = "clownshoes",
    color = "dark_gray",
    flags = { "VARSIZE", "WATER_FRIENDLY", "FIN", "BOOT_FINS", "OVERSIZE" },
    armor = {
        warmth = 5,
        thickness = 2.5,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_toes_r", "foot_toes_l" },
                materials = { { id = "rubber", coverage = 100, thickness = 2.5 } },
                encumbrance = 25,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_heel_r", "foot_heel_l" },
                materials = { { id = "rubber", coverage = 100, thickness = 2.5 } },
                coverage = 60,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_arch_r", "foot_arch_l" },
                materials = { { id = "rubber", coverage = 100, thickness = 2.5 } },
                coverage = 80,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = { { id = "rubber", coverage = 100, thickness = 2.5 } },
                coverage = 100,
            },
        },
    },
}

-- Pockets like here: https://mytriathlon.co.uk/zone3-versa-womens-wetsuit---ex-rental-cat-1/
ccb.content.define_item {
    id = "wetsuit",
    name = ccb.content.text("wetsuit"),
    description = ccb.content.text("A full-body 3 mm thick neoprene wetsuit with nylon lining."),
    mass = "825 g",
    volume = "5 L",
    price = "120 USD",
    survival_price = "5 USD",
    materials = { "neoprene", "nylon" },
    symbol = "[",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "500 ml",
            mass_limit = "1 kg",
            moves = 130,
            max_item_length = "11 cm",
            watertight = true,
            description = ccb.content.text("Back pocket."),
        },
        {
            kind = "CONTAINER",
            capacity = "500 ml",
            mass_limit = "1 kg",
            moves = 130,
            max_item_length = "11 cm",
            watertight = true,
            description = ccb.content.text("Back pocket."),
        },
    },
    flags = { "VARSIZE", "WATER_FRIENDLY", "WATERPROOF", "SKINTIGHT" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.2 },
                    { id = "neoprene", coverage = 100, thickness = 3.0 },
                },
                covers = { "torso", "leg_l", "leg_r", "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = { 10, 10 },
            },
        },
        warmth = 30,
        environmental_protection = 10,
    },
}

ccb.content.define_item {
    id = "xl_wetsuit",
    copy_from = "wetsuit",
    name = ccb.content.text("wetsuit"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.25, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_wetsuit",
    copy_from = "wetsuit",
    name = ccb.content.text("wetsuit"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.75 },
    },
}

-- Pockets like here: https://waterproof.eu/products/wetsuits/w7/
ccb.content.define_item {
    id = "wetsuit_thick",
    name = ccb.content.text("thick wetsuit"),
    description = ccb.content.text("A full-body 5 mm thick neoprene wetsuit with nylon lining."),
    mass = "2200 g",
    volume = "6 L",
    price = "100 USD",
    survival_price = "5 USD",
    materials = { "neoprene", "nylon" },
    symbol = "[",
    color = "dark_gray",
    looks_like = "wetsuit",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1000 ml",
            mass_limit = "1500 g",
            moves = 130,
            max_item_length = "20 cm",
            watertight = true,
            description = ccb.content.text("Hip pocket."),
        },
        {
            kind = "CONTAINER",
            capacity = "1000 ml",
            mass_limit = "1500 g",
            moves = 130,
            max_item_length = "20 cm",
            watertight = true,
            description = ccb.content.text("Hip pocket."),
        },
    },
    flags = { "VARSIZE", "WATER_FRIENDLY", "WATERPROOF", "SKINTIGHT", "NORMAL" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.4 },
                    { id = "neoprene", coverage = 100, thickness = 5.0 },
                },
                covers = { "torso", "leg_l", "leg_r", "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = { 20, 20 },
            },
        },
        warmth = 50,
        environmental_protection = 12,
    },
}

ccb.content.define_item {
    id = "xl_wetsuit_thick",
    copy_from = "wetsuit_thick",
    name = ccb.content.text("thick wetsuit"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.25, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_wetsuit_thick",
    copy_from = "wetsuit_thick",
    name = ccb.content.text("thick wetsuit"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.75 },
    },
}

ccb.content.define_item {
    id = "wetsuit_hood",
    name = ccb.content.text("wetsuit hood"),
    description = ccb.content.text("A 3 mm neoprene hood, commonly worn by divers."),
    mass = "160 g",
    volume = "1 L",
    price = "45 USD",
    survival_price = "2 USD 50 cent",
    materials = { "neoprene", "nylon" },
    symbol = "[",
    looks_like = "hood_rain",
    color = "dark_gray",
    flags = { "VARSIZE", "WATER_FRIENDLY", "WATERPROOF", "SKINTIGHT" },
    armor = {
        warmth = 30,
        environmental_protection = 10,
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.2 },
                    { id = "neoprene", coverage = 100, thickness = 3.0 },
                },
                encumbrance_modifiers = { "NONE" },
                coverage = 100,
                covers = { "head" },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_wetsuit_hood",
    copy_from = "wetsuit_hood",
    name = ccb.content.text("wetsuit hood"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.25, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_wetsuit_hood",
    copy_from = "wetsuit_hood",
    name = ccb.content.text("wetsuit hood"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.75 },
    },
}

ccb.content.define_item {
    id = "wetsuit_hood_thick",
    copy_from = "wetsuit_hood",
    name = ccb.content.text("thick wetsuit hood"),
    description = ccb.content.text("A 5 mm thick neoprene hood, commonly worn by divers in cold weather."),
    mass = "180 g",
    armor = {
        warmth = 50,
        environmental_protection = 12,
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.4 },
                    { id = "neoprene", coverage = 100, thickness = 5.0 },
                },
                encumbrance_modifiers = { "RESTRICTS_NECK", "WELL_SUPPORTED" },
                coverage = 100,
                covers = { "head" },
            },
        },
    },
    inheritance = { add = { flags = { "NORMAL" } } },
}

ccb.content.define_item {
    id = "xl_wetsuit_hood_thick",
    copy_from = "wetsuit_hood_thick",
    name = ccb.content.text("thick wetsuit hood"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.25, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_wetsuit_hood_thick",
    copy_from = "wetsuit_hood_thick",
    name = ccb.content.text("thick wetsuit hood"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.75 },
    },
}

ccb.content.define_item {
    id = "wetsuit_jacket",
    name = ccb.content.text("wetsuit jacket"),
    description = ccb.content.text("A long-sleeved neoprene jacket.  Keeps you warm and protected from the elements."),
    mass = "520 g",
    volume = "2500 ml",
    price = "75 USD",
    survival_price = "3 USD 50 cent",
    materials = { "neoprene", "nylon" },
    symbol = "[",
    looks_like = "jacket_light",
    color = "dark_gray",
    flags = { "VARSIZE", "WATERPROOF", "WATER_FRIENDLY" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.2 },
                    { id = "neoprene", coverage = 100, thickness = 2.0 },
                },
                encumbrance = 8,
                coverage = 100,
                covers = { "torso" },
            },
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.2 },
                    { id = "neoprene", coverage = 100, thickness = 2.0 },
                },
                encumbrance = 8,
                coverage = 100,
                covers = { "arm_l", "arm_r" },
            },
        },
        warmth = 20,
        environmental_protection = 8,
    },
}

ccb.content.define_item {
    id = "xl_wetsuit_jacket",
    copy_from = "wetsuit_jacket",
    name = ccb.content.text("wetsuit jacket"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.25, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_wetsuit_jacket",
    copy_from = "wetsuit_jacket",
    name = ccb.content.text("wetsuit jacket"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.75 },
    },
}

ccb.content.define_item {
    id = "wetsuit_top",
    name = ccb.content.text("wetsuit shirt"),
    description = ccb.content.text("A short-sleeved neoprene shirt.  Good for use on the beach."),
    mass = "272 g",
    volume = "1500 ml",
    price = "65 USD",
    survival_price = "2 USD 50 cent",
    materials = { "neoprene", "nylon" },
    symbol = "[",
    looks_like = "tshirt",
    color = "dark_gray",
    flags = { "VARSIZE", "WATER_FRIENDLY", "WATERPROOF", "SKINTIGHT" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.1 },
                    { id = "neoprene", coverage = 100, thickness = 1.0 },
                },
                encumbrance = 5,
                coverage = 95,
                covers = { "torso" },
            },
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.1 },
                    { id = "neoprene", coverage = 100, thickness = 1.0 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                subparts = { "arm_shoulder_l", "arm_shoulder_r" },
                encumbrance = 2,
            },
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.1 },
                    { id = "neoprene", coverage = 100, thickness = 1.0 },
                },
                coverage = 95,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_upper_l", "arm_upper_r" },
            },
        },
        warmth = 15,
        environmental_protection = 6,
    },
}

ccb.content.define_item {
    id = "xl_wetsuit_top",
    copy_from = "wetsuit_top",
    name = ccb.content.text("wetsuit shirt"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.25, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_wetsuit_top",
    copy_from = "wetsuit_top",
    name = ccb.content.text("wetsuit shirt"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.75 },
    },
}

ccb.content.define_item {
    id = "wetsuit_top_sleeved_thin",
    name = ccb.content.text("thin wetsuit long-sleeved shirt"),
    copy_from = "wetsuit_top_sleeved",
    description = ccb.content.text("A thin long-sleeved neoprene shirt.  Good for surfing and other water sports."),
    mass = "350 g",
    volume = "2 L",
    flags = { "VARSIZE", "WATER_FRIENDLY", "WATERPROOF", "SKINTIGHT" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.1 },
                    { id = "neoprene", coverage = 100, thickness = 1.0 },
                },
                encumbrance = 5,
                coverage = 100,
                covers = { "torso" },
            },
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.1 },
                    { id = "neoprene", coverage = 100, thickness = 1.0 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 5,
            },
        },
        warmth = 15,
        environmental_protection = 6,
    },
}

ccb.content.define_item {
    id = "xl_wetsuit_top_sleeved_thin",
    copy_from = "wetsuit_top_sleeved_thin",
    name = ccb.content.text("thin wetsuit long-sleeved shirt"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.25, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_wetsuit_top_sleeved_thin",
    copy_from = "wetsuit_top_sleeved_thin",
    name = ccb.content.text("thin wetsuit long-sleeved shirt"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.75 },
    },
}

ccb.content.define_item {
    id = "wetsuit_top_sleeved",
    name = ccb.content.text("wetsuit long-sleeved shirt"),
    description = ccb.content.text("A long-sleeved neoprene shirt.  Good for surfing and other water sports."),
    mass = "500 g",
    volume = "4 L",
    price = "65 USD",
    survival_price = "2 USD 50 cent",
    materials = { "neoprene", "nylon" },
    symbol = "[",
    looks_like = "longshirt",
    color = "dark_gray",
    flags = { "VARSIZE", "WATER_FRIENDLY", "WATERPROOF", "SKINTIGHT" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.2 },
                    { id = "neoprene", coverage = 100, thickness = 2.0 },
                },
                encumbrance = 7,
                coverage = 100,
                covers = { "torso" },
            },
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.2 },
                    { id = "neoprene", coverage = 100, thickness = 2.0 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 7,
            },
        },
        warmth = 20,
        environmental_protection = 8,
    },
}

ccb.content.define_item {
    id = "xl_wetsuit_top_sleeved",
    copy_from = "wetsuit_top_sleeved",
    name = ccb.content.text("wetsuit long-sleeved shirt"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.25, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_wetsuit_top_sleeved",
    copy_from = "wetsuit_top_sleeved",
    name = ccb.content.text("wetsuit long-sleeved shirt"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.75 },
    },
}

ccb.content.define_item {
    id = "wetsuit_pants_thin",
    name = ccb.content.plural_text("thin wetsuit pants", "thin wetsuit pants"),
    copy_from = "wetsuit_pants",
    description = ccb.content.text("A pair of light and stretchy thin neoprene pants.  Good for surfing and other water sports."),
    mass = "325 g",
    volume = "2 L",
    flags = { "VARSIZE", "WATER_FRIENDLY", "WATERPROOF", "SKINTIGHT" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.1 },
                    { id = "neoprene", coverage = 100, thickness = 1.0 },
                },
                covers = { "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = 5,
            },
        },
        warmth = 15,
        environmental_protection = 6,
    },
}

ccb.content.define_item {
    id = "xl_wetsuit_pants_thin",
    copy_from = "wetsuit_pants_thin",
    name = ccb.content.plural_text("thin wetsuit pants", "thin wetsuit pants"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.25, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_wetsuit_pants_thin",
    copy_from = "wetsuit_pants_thin",
    name = ccb.content.plural_text("thin wetsuit pants", "thin wetsuit pants"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.75 },
    },
}

ccb.content.define_item {
    id = "wetsuit_pants",
    name = ccb.content.plural_text("wetsuit pants", "wetsuit pants"),
    description = ccb.content.text("A pair of light and stretchy neoprene pants.  Good for surfing and other water sports."),
    mass = "450 g",
    volume = "4 L",
    price = "65 USD",
    survival_price = "2 USD 50 cent",
    materials = { "neoprene", "nylon" },
    symbol = "[",
    color = "dark_gray",
    looks_like = "pants",
    flags = { "VARSIZE", "WATER_FRIENDLY", "WATERPROOF", "SKINTIGHT" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.2 },
                    { id = "neoprene", coverage = 100, thickness = 2.0 },
                },
                covers = { "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = 7,
            },
        },
        warmth = 20,
        environmental_protection = 8,
    },
}

ccb.content.define_item {
    id = "xl_wetsuit_pants",
    copy_from = "wetsuit_pants",
    name = ccb.content.plural_text("wetsuit pants", "wetsuit pants"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.25, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_wetsuit_pants",
    copy_from = "wetsuit_pants",
    name = ccb.content.plural_text("wetsuit pants", "wetsuit pants"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.75 },
    },
}

ccb.content.define_item {
    id = "wetsuit_shorts",
    name = ccb.content.plural_text("wetsuit shorts", "wetsuit shorts"),
    description = ccb.content.text("A pair of light and stretchy neoprene shorts.  Good for use on the beach."),
    mass = "220 g",
    volume = "1 L",
    price = "65 USD",
    survival_price = "1 USD 50 cent",
    materials = { "neoprene", "nylon" },
    symbol = "[",
    color = "dark_gray",
    looks_like = "shorts",
    flags = { "VARSIZE", "WATER_FRIENDLY", "WATERPROOF", "SKINTIGHT" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.1 },
                    { id = "neoprene", coverage = 100, thickness = 1.0 },
                },
                covers = { "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = 2,
                subparts = { "leg_hip_l", "leg_hip_r" },
            },
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.1 },
                    { id = "neoprene", coverage = 100, thickness = 1.0 },
                },
                covers = { "leg_l", "leg_r" },
                coverage = 50,
                subparts = { "leg_upper_l", "leg_upper_r" },
            },
        },
        warmth = 8,
        environmental_protection = 6,
    },
}

ccb.content.define_item {
    id = "xl_wetsuit_shorts",
    copy_from = "wetsuit_shorts",
    name = ccb.content.plural_text("wetsuit shorts", "wetsuit shorts"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.25, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_wetsuit_shorts",
    copy_from = "wetsuit_shorts",
    name = ccb.content.plural_text("wetsuit shorts", "wetsuit shorts"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.75 },
    },
}
