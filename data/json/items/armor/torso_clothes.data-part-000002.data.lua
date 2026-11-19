local ccb = require("ccb")

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
