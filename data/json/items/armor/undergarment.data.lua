local ccb = require("ccb")

ccb.content.define_item {
    id = "garter_belt",
    name = ccb.content.text("garter belt"),
    description = ccb.content.text("A simple, decorated undergarment commonly used in combination with stockings.  They don't cover much, but they do help you feel sexy."),
    mass = "80 g",
    volume = "200 ml",
    looks_like = "panties",
    price = "5 USD",
    survival_price = "2 USD 50 cent",
    materials = { "cotton" },
    symbol = "[",
    color = "dark_gray",
    faults = { { group = "fabric_cotton" } },
    flags = { "SKINTIGHT", "VARSIZE" },
    variant_kind = "generic",
    variants = {
        {
            id = "generic_garter_belt",
            name = ccb.content.text("garter belt"),
            description = ccb.content.text("A simple, decorated undergarment commonly used in combination with stockings.  They don't cover much, but they do help you feel sexy."),
            color = "dark_gray",
            append = false,
        },
        {
            id = "black_garter_belt",
            name = ccb.content.text("black garter belt"),
            description = ccb.content.text("This one is colored black."),
            color = "dark_gray",
            append = true,
        },
        {
            id = "white_garter_belt",
            name = ccb.content.text("white garter belt"),
            description = ccb.content.text("This one is colored white."),
            color = "white",
            append = true,
        },
        {
            id = "red_garter_belt",
            name = ccb.content.text("red garter belt"),
            description = ccb.content.text("This one is colored red."),
            color = "red",
            append = true,
        },
        {
            id = "blue_garter_belt",
            name = ccb.content.text("blue garter belt"),
            description = ccb.content.text("This one is colored blue."),
            color = "blue",
            append = true,
        },
        {
            id = "green_garter_belt",
            name = ccb.content.text("green garter belt"),
            description = ccb.content.text("This one is colored green."),
            color = "green",
            append = true,
        },
        {
            id = "pink_garter_belt",
            name = ccb.content.text("pink garter belt"),
            description = ccb.content.text("This one is colored pink."),
            color = "pink",
            append = true,
        },
        {
            id = "purple_garter_belt",
            name = ccb.content.text("purple garter belt"),
            description = ccb.content.text("This one is colored purple."),
            color = "magenta",
            append = true,
        },
        {
            id = "teal_garter_belt",
            name = ccb.content.text("teal garter belt"),
            description = ccb.content.text("This one is colored teal."),
            color = "blue",
            append = true,
        },
        {
            id = "magenta_garter_belt",
            name = ccb.content.text("magenta garter belt"),
            description = ccb.content.text("This one is colored magenta."),
            color = "magenta",
            append = true,
        },
    },
    armor = {
        thickness = 0.1,
        portions = { { encumbrance = 1, coverage = 38, covers = { "torso" }, subparts = { "torso_lower" } } },
    },
}

ccb.content.define_item {
    id = "leg_warmers",
    name = ccb.content.plural_text("leg warmers (pair)", "leg warmers (pair)"),
    description = ccb.content.text("Snug, soft cloth sleeves to keep your legs warm."),
    mass = "70 g",
    volume = "500 ml",
    price = "10 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "leggings",
    color = "light_gray",
    faults = { { group = "fabric_cotton" } },
    flags = { "SKINTIGHT" },
    armor = {
        warmth = 20,
        thickness = 0.1,
        portions = {
            {
                encumbrance = 1,
                coverage = 100,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_lower_l", "leg_lower_r", "leg_knee_l", "leg_knee_r" },
            },
            {
                coverage = 90,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "leg_warmers_f",
    name = ccb.content.plural_text("fur leggings", "fur leggings"),
    description = ccb.content.text("Snug fur sleeves to keep your legs warm.  Simple yet effective since prehistoric times."),
    mass = "700 g",
    volume = "1500 ml",
    price = "15 USD",
    survival_price = "2 USD 50 cent",
    materials = { "fur" },
    symbol = "[",
    looks_like = "leg_warmers",
    color = "brown",
    flags = { "VARSIZE" },
    armor = {
        warmth = 40,
        thickness = 0.2,
        portions = {
            {
                encumbrance = 3,
                coverage = 100,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_lower_l", "leg_lower_r", "leg_knee_l", "leg_knee_r" },
            },
            {
                coverage = 90,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "leg_warmers_xlf",
    name = ccb.content.plural_text("fetlock furs (pair)", "fetlock furs (pair)"),
    description = ccb.content.text("Snug fur sleeves to keep your fetlocks warm."),
    mass = "500 g",
    volume = "750 ml",
    price = "250 USD",
    survival_price = "2 USD 50 cent",
    materials = { "fur" },
    symbol = "[",
    looks_like = "leg_warmers_xl",
    color = "light_gray",
    flags = { "VARSIZE", "OVERSIZE" },
    armor = {
        warmth = 40,
        thickness = 2,
        portions = { { encumbrance = 7, coverage = 60, covers = { "foot_l", "foot_r" } } },
    },
}

ccb.content.define_item {
    id = "leg_warmers_xsf",
    copy_from = "leg_warmers_f",
    name = ccb.content.plural_text("fur leggings", "fur leggings"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "leg_warmers_xl",
    name = ccb.content.plural_text("leg warmers (pair)", "leg warmers (pair)"),
    description = ccb.content.text("Large, soft, snug cloth sleeves to keep your exotic anatomy warm."),
    mass = "90 g",
    volume = "750 ml",
    price = "200 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "leg_warmers",
    color = "light_gray",
    faults = { { group = "fabric_cotton" } },
    flags = { "VARSIZE", "SKINTIGHT", "OVERSIZE", "PREFIX_XL" },
    armor = {
        warmth = 20,
        thickness = 2,
        portions = {
            {
                encumbrance = 7,
                coverage = 100,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_lower_l", "leg_lower_r", "leg_knee_l", "leg_knee_r" },
            },
            {
                coverage = 90,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "leg_warmers_xs",
    copy_from = "leg_warmers",
    name = ccb.content.plural_text("leg warmers (pair)", "leg warmers (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "long_underpants",
    name = ccb.content.text("long underwear bottom"),
    description = ccb.content.text("A pair of long underwear that help to maintain body temperature."),
    mass = "100 g",
    volume = "500 ml",
    price = "15 USD",
    survival_price = "1 USD",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "leggings",
    color = "light_gray",
    faults = { { group = "fabric_cotton" } },
    flags = { "VARSIZE", "SKINTIGHT" },
    armor = {
        warmth = 10,
        thickness = 0.2,
        portions = { { encumbrance = 3, coverage = 100, covers = { "leg_l", "leg_r" } } },
    },
}

ccb.content.define_item {
    id = "long_undertop",
    name = ccb.content.text("long underwear top"),
    description = ccb.content.text("A long underwear top that helps to maintain body temperature."),
    mass = "102 g",
    volume = "500 ml",
    price = "15 USD",
    survival_price = "1 USD",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "longshirt",
    color = "light_gray",
    faults = { { group = "fabric_cotton" } },
    flags = { "VARSIZE", "SKINTIGHT" },
    armor = {
        warmth = 10,
        thickness = 0.2,
        portions = {
            { encumbrance = 3, coverage = 100, covers = { "arm_l", "arm_r" } },
            {
                covers = { "torso" },
                subparts = { "torso_upper", "torso_lower" },
                coverage = 100,
                encumbrance = 3,
            },
        },
    },
}

ccb.content.define_item {
    id = "long_undertop_sleeveless",
    name = ccb.content.text("sleeveless underwear top"),
    description = ccb.content.text("A sleeveless underwear top that helps to maintain body temperature."),
    mass = "80 g",
    volume = "400 ml",
    price = "12 USD",
    survival_price = "1 USD",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "long_undertop",
    color = "light_gray",
    faults = { { group = "fabric_cotton" } },
    flags = { "VARSIZE", "SKINTIGHT" },
    armor = {
        warmth = 10,
        thickness = 0.2,
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_upper", "torso_lower" },
                coverage = 100,
                encumbrance = 3,
            },
        },
    },
}

ccb.content.define_item {
    id = "panties",
    name = ccb.content.plural_text("panties", "panties"),
    description = ccb.content.text("Underwear designed to be worn by women.  Preserves your modesty in desperate times."),
    mass = "32 g",
    volume = "250 ml",
    price = "10 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "briefs",
    color = "white",
    faults = { { group = "fabric_cotton" } },
    flags = { "VARSIZE", "SKINTIGHT" },
    armor = {
        warmth = 5,
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
    id = "thermal_shirt",
    name = ccb.content.text("thermal shirt"),
    description = ccb.content.text("A lightweight, form-fitting long-sleeved spandex undershirt that helps maintains body temperature."),
    mass = "112 g",
    volume = "250 ml",
    price = "32 USD",
    survival_price = "2 USD 50 cent",
    materials = { "lycra" },
    symbol = "[",
    color = "dark_gray",
    flags = { "VARSIZE", "SKINTIGHT", "WATER_FRIENDLY" },
    armor = {
        warmth = 20,
        thickness = 0.1,
        portions = {
            { coverage = 100, covers = { "arm_l", "arm_r" } },
            { covers = { "torso" }, subparts = { "torso_upper", "torso_lower" }, coverage = 100 },
        },
    },
}

ccb.content.define_item {
    id = "sports_bra",
    name = ccb.content.text("sports bra"),
    description = ccb.content.text("A sturdy nylon bra to provide additional support during physical movement.  Typically worn when exercising, it clings to the skin and is easy to wear."),
    mass = "92 g",
    volume = "500 ml",
    price = "42 USD",
    survival_price = "50 cent",
    materials = { "lycra" },
    symbol = "[",
    looks_like = "bra",
    color = "white",
    flags = { "VARSIZE", "WATER_FRIENDLY", "SKINTIGHT" },
    armor = {
        warmth = 5,
        thickness = 0.1,
        portions = { { coverage = 50, covers = { "torso" }, subparts = { "torso_upper" } } },
    },
}

ccb.content.define_item {
    id = "xlsports_bra",
    name = ccb.content.text("sports bra"),
    mass = "160 g",
    volume = "750 ml",
    copy_from = "sports_bra",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } } },
}

ccb.content.define_item {
    id = "xssports_bra",
    copy_from = "sports_bra",
    name = ccb.content.text("sports bra"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- Based on https://www.amazon.com/dp/B07SDD5CZH
ccb.content.define_item {
    id = "tank_top",
    name = ccb.content.text("tank top"),
    description = ccb.content.text("A sleeveless cotton shirt.  Very easy to move in."),
    mass = "55 g",
    volume = "115 ml",
    price = "9 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "tshirt",
    color = "light_gray",
    faults = { { group = "fabric_cotton" } },
    flags = { "VARSIZE", "WATER_FRIENDLY", "SKINTIGHT" },
    variant_kind = "generic",
    variants = {
        {
            id = "tank_top_generic",
            name = ccb.content.text("tank top"),
            description = ccb.content.text("A sleeveless cotton shirt.  Very easy to move in."),
            weight = 45,
        },
        {
            id = "tank_top_camo",
            name = ccb.content.text("camo tank top"),
            description = ccb.content.text("A sleeveless cotton shirt with a camouflage pattern.  Very easy to move in."),
            weight = 3,
        },
        {
            id = "tank_top_cheerleader",
            name = ccb.content.text("cheerleader tank top"),
            description = ccb.content.text("A red cheerleader tank top.  It has the word \"Cheers\" printed at the top."),
            weight = 2,
        },
    },
    armor = {
        thickness = 0.1,
        portions = {
            { covers = { "torso" }, subparts = { "torso_lower" }, coverage = 100 },
            { covers = { "torso" }, subparts = { "torso_upper" }, coverage = 90 },
        },
    },
}

ccb.content.define_item {
    id = "tights",
    name = ccb.content.plural_text("tights", "tights"),
    description = ccb.content.text("A snug cloth garment which clings tightly to the legs and feet to protect them from the cold."),
    mass = "114 g",
    volume = "250 ml",
    price = "20 USD",
    survival_price = "1 USD",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "leggings",
    color = "dark_gray",
    faults = { { group = "fabric_cotton" } },
    flags = { "VARSIZE", "SKINTIGHT" },
    variants = {
        {
            id = "tights_basic",
            name = ccb.content.plural_text("tights", "tights"),
            description = ccb.content.text("A snug cloth garment which clings tightly to the legs and feet to protect them from the cold."),
            expand_snippets = true,
            weight = 50,
        },
        {
            id = "tights_polka_dot",
            name = ccb.content.plural_text("polka dot tights", "polka dot tights"),
            description = ccb.content.text("These are adorned with dozens of <color> polka dots."),
            expand_snippets = true,
            append = true,
            weight = 50,
        },
        {
            id = "tights_print",
            name = ccb.content.plural_text("animal print tights", "animal print tights"),
            description = ccb.content.text("A pair of snug cotton tights, featuring a classic <animal_print> pattern."),
            expand_snippets = true,
            weight = 150,
        },
        {
            id = "tights_solid",
            name = ccb.content.plural_text("solid color tights", "solid color tights"),
            description = ccb.content.text("A pair of cotton tights, these are a solid <color> color."),
            expand_snippets = true,
            weight = 300,
        },
    },
    armor = {
        warmth = 10,
        thickness = 0.1,
        portions = { { coverage = 100, covers = { "foot_l", "foot_r", "leg_r", "leg_l" } } },
    },
}

ccb.content.define_item {
    id = "under_armor",
    name = ccb.content.text("compression top"),
    description = ccb.content.text("Nylon sportswear that clings to your chest and wicks away sweat."),
    mass = "92 g",
    volume = "250 ml",
    price = "20 USD",
    survival_price = "1 USD",
    materials = { "lycra" },
    symbol = "[",
    looks_like = "longshirt",
    color = "dark_gray",
    flags = { "VARSIZE", "SKINTIGHT", "WATER_FRIENDLY" },
    armor = { warmth = 4, thickness = 0.05, portions = { { coverage = 100, covers = { "torso" } } } },
}

ccb.content.define_item {
    id = "under_armor_shorts",
    name = ccb.content.plural_text("compression shorts", "compression shorts"),
    description = ccb.content.text("Nylon sportswear that clings to your upper legs, aiding muscle tone and wicking away sweat."),
    mass = "82 g",
    volume = "250 ml",
    price = "20 USD",
    survival_price = "1 USD",
    materials = { "lycra" },
    symbol = "[",
    looks_like = "shorts",
    color = "dark_gray",
    flags = { "VARSIZE", "SKINTIGHT", "WATER_FRIENDLY" },
    armor = {
        warmth = 4,
        thickness = 0.1,
        portions = {
            {
                coverage = 100,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
            },
            {
                coverage = 65,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "undershirt",
    name = ccb.content.text("undershirt"),
    description = ccb.content.text("A simple white undershirt.  Worn beneath your regular clothes, it provides a little extra warmth."),
    mass = "100 g",
    volume = "250 ml",
    price = "10 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "tshirt",
    color = "white",
    faults = { { group = "fabric_cotton" } },
    flags = { "VARSIZE", "SKINTIGHT" },
    armor = {
        warmth = 5,
        thickness = 0.1,
        portions = {
            { covers = { "torso" }, subparts = { "torso_lower" }, coverage = 100 },
            { covers = { "torso" }, subparts = { "torso_upper" }, coverage = 90 },
        },
    },
}

ccb.content.define_item {
    id = "unitard",
    name = ccb.content.text("unitard"),
    description = ccb.content.text("A skin-tight spandex garment resembling a crew-necked leotard combined with leggings.  Commonly used by gymnasts, dancers and equestrian vaulters, the unitard provides overall coverage with great flexibility."),
    mass = "110 g",
    volume = "250 ml",
    price = "31 USD",
    survival_price = "50 cent",
    materials = { "lycra" },
    symbol = "[",
    color = "dark_gray",
    flags = { "VARSIZE", "SKINTIGHT", "WATER_FRIENDLY" },
    armor = {
        warmth = 20,
        thickness = 0.02,
        portions = {
            { coverage = 100, covers = { "leg_l", "leg_r" } },
            { covers = { "torso" }, subparts = { "torso_lower" }, coverage = 100 },
            { covers = { "torso" }, subparts = { "torso_upper" }, coverage = 90 },
        },
    },
}
