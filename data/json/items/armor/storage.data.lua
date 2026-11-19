local ccb = require("ccb")

ccb.content.define_item {
    id = "bigtrapper_pack",
    name = ccb.content.text("big trapper pack"),
    description = ccb.content.text("A wooden frame with waterproofed cloth stretched around it, and a drawstring at the top to hold things in.  It has straps to wear it on your back."),
    mass = "10 kg",
    volume = "45 L",
    price = "8 USD",
    survival_price = "7 USD 50 cent",
    materials = { "wood", "canvas" },
    symbol = "[",
    looks_like = "golf_bag",
    color = "green",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "40 L",
            mass_limit = "100 kg",
            moves = 300,
            rigid = true,
            max_item_length = "150 cm",
        },
    },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY" },
    armor = {
        warmth = 5,
        thickness = 1,
        portions = {
            {
                encumbrance = { 30, 35 },
                coverage = 70,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
}

ccb.content.define_item {
    id = "trapper_pack",
    name = ccb.content.text("trapper pack"),
    description = ccb.content.text("An L-shaped wooden frame with a waterproofed cloth sack attached to it.  There's a drawstring to hold things in and straps to carry it on your back."),
    mass = "5 kg",
    volume = "10 L",
    price = "8 USD",
    survival_price = "7 USD 50 cent",
    materials = { "wood", "canvas" },
    symbol = "[",
    looks_like = "backpack",
    color = "green",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "25 L",
            mass_limit = "50 kg",
            moves = 300,
            max_item_length = "60 cm",
        },
    },
    flags = { "BELTED", "WATER_FRIENDLY" },
    armor = {
        warmth = 5,
        thickness = 1,
        portions = {
            {
                encumbrance = { 10, 25 },
                coverage = 60,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
}

ccb.content.define_item {
    id = "frame_pack",
    name = ccb.content.text("pack frame"),
    description = ccb.content.text("An L-shaped wooden frame with straps to secure a large item to it."),
    mass = "5 kg",
    volume = "10 L",
    price = "8 USD",
    survival_price = "7 USD 50 cent",
    materials = { "wood" },
    symbol = "[",
    looks_like = "backpack",
    color = "brown",
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "100 L",
            mass_limit = "75 kg",
            moves = 300,
            min_item_volume = "1 L",
        },
    },
    flags = { "BELTED", "WATER_FRIENDLY" },
    armor = {
        warmth = 5,
        thickness = 1,
        portions = {
            {
                encumbrance = { 10, 50 },
                coverage = 60,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
}

ccb.content.define_item {
    id = "bigframe_pack",
    name = ccb.content.text("big pack frame"),
    description = ccb.content.text("A sturdy L-shaped wooden frame with leather straps to secure an oversized item to it.  It has straps to wear it on your back."),
    mass = "10 kg",
    volume = "45 L",
    price = "8 USD",
    survival_price = "7 USD 50 cent",
    materials = { "wood" },
    symbol = "[",
    looks_like = "golf_bag",
    color = "brown",
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "1000 L",
            mass_limit = "150 kg",
            moves = 300,
            min_item_volume = "1 L",
            max_item_length = "260 cm",
        },
    },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY" },
    armor = {
        warmth = 5,
        thickness = 1,
        portions = {
            {
                encumbrance = { 30, 250 },
                coverage = 70,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
}

-- based off of USMC seabag
-- Small pocket for ID, etc
-- tucked against back
ccb.content.define_item {
    id = "seabag",
    name = ccb.content.text("military seabag"),
    description = ccb.content.text("A massive, watertight, olive drab duffel bag used to move soft goods like uniforms when being redeployed.  While it has straps to be worn like a backpack, it is extremely cumbersome to do so."),
    mass = "1000 g",
    volume = "5 L",
    price = "65 USD",
    survival_price = "10 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "duffelbag",
    color = "green",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "80 L",
            mass_limit = "90 kg",
            max_item_length = "92 cm",
            watertight = true,
            rigid = false,
            magazine_well = "4 L",
            moves = 450,
        },
        {
            kind = "CONTAINER",
            capacity = "400 ml",
            mass_limit = "250 g",
            max_item_length = "8 cm",
            watertight = true,
            moves = 150,
        },
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "5 L",
            mass_limit = "4 kg",
            max_item_length = "150 cm",
            min_item_length = "60 cm",
            moves = 200,
            rigid = false,
            extra_encumbrance = 10,
            description = ccb.content.text("Tucked between your back and the seabag."),
            ripoff = 3,
            transparent = true,
        },
    },
    flags = { "FLOTATION", "BELTED", "WATER_FRIENDLY", "OVERSIZE" },
    armor = {
        warmth = 10,
        thickness = 1,
        portions = {
            {
                encumbrance = 10,
                volume_encumbrance = 0.3,
                coverage = 100,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
}
