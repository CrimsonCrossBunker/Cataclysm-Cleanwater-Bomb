local ccb = require("ccb")

-- Based on these: https://fourthelement.com/product/technical-shorts/
-- A recipe to make these into leg pouches?
-- Two large pockets separated into four, two small zipper pockets on flaps, four bungee loops.
ccb.content.define_item {
    id = "wetsuit_shorts_technical",
    name = ccb.content.plural_text("wetsuit technical shorts", "wetsuit technical shorts"),
    description = ccb.content.text("A pair of stretchy neoprene shorts with large pockets.  Can be worn alone or adjusted to be worn over a wetsuit."),
    mass = "500 g",
    volume = "1500 ml",
    price = "65 USD",
    survival_price = "1 USD 50 cent",
    materials = { "neoprene", "nylon", "nylon_2" },
    symbol = "[",
    color = "dark_gray",
    looks_like = "wetsuit_shorts",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1650 ml",
            mass_limit = "1500 g",
            max_item_length = "32 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1650 ml",
            mass_limit = "1500 g",
            max_item_length = "32 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1650 ml",
            mass_limit = "1500 g",
            max_item_length = "32 cm",
            moves = 100,
        },
        {
            kind = "CONTAINER",
            capacity = "1650 ml",
            mass_limit = "1500 g",
            max_item_length = "32 cm",
            moves = 100,
        },
        {
            kind = "CONTAINER",
            capacity = "500 ml",
            mass_limit = "500 g",
            max_item_length = "19 cm",
            moves = 130,
        },
        {
            kind = "CONTAINER",
            capacity = "500 ml",
            mass_limit = "500 g",
            max_item_length = "19 cm",
            moves = 130,
        },
        {
            holster = true,
            min_item_volume = "50 ml",
            capacity = "1 L",
            mass_limit = "1000 g",
            max_item_length = "70 cm",
            extra_encumbrance = 2,
            moves = 50,
            allowed_flags = { "BELT_CLIP", "SHEATH_KNIFE" },
        },
        {
            holster = true,
            min_item_volume = "50 ml",
            capacity = "1 L",
            mass_limit = "1000 g",
            max_item_length = "70 cm",
            extra_encumbrance = 2,
            moves = 50,
            allowed_flags = { "BELT_CLIP", "SHEATH_KNIFE" },
        },
        {
            holster = true,
            min_item_volume = "50 ml",
            capacity = "1 L",
            mass_limit = "1000 g",
            max_item_length = "70 cm",
            extra_encumbrance = 2,
            moves = 50,
            allowed_flags = { "BELT_CLIP", "SHEATH_KNIFE" },
        },
        {
            holster = true,
            min_item_volume = "50 ml",
            capacity = "1 L",
            mass_limit = "1000 g",
            max_item_length = "70 cm",
            extra_encumbrance = 2,
            moves = 50,
            allowed_flags = { "BELT_CLIP", "SHEATH_KNIFE" },
        },
    },
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
                encumbrance = 4,
                volume_encumbrance = 0.25,
                subparts = { "leg_hip_l", "leg_hip_r" },
            },
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.2 },
                    { id = "neoprene", coverage = 100, thickness = 2.0 },
                    { id = "nylon_2", coverage = 20, thickness = 1.5 },
                },
                covers = { "leg_l", "leg_r" },
                coverage = 50,
                subparts = { "leg_upper_l", "leg_upper_r" },
            },
        },
        warmth = 11,
        environmental_protection = 8,
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You loosen your shorts."),
            target = "wetsuit_shorts_technical_loose",
            menu_text = ccb.content.text("Loosen"),
        },
    },
}

ccb.content.define_item {
    id = "xl_wetsuit_shorts_technical",
    copy_from = "wetsuit_shorts_technical",
    name = ccb.content.plural_text("wetsuit technical shorts", "wetsuit technical shorts"),
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.25, price = 1.25 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You loosen your shorts."),
            target = "xl_wetsuit_shorts_technical_loose",
            menu_text = ccb.content.text("Loosen"),
        },
    },
}

ccb.content.define_item {
    id = "xs_wetsuit_shorts_technical",
    copy_from = "wetsuit_shorts_technical",
    name = ccb.content.plural_text("wetsuit technical shorts", "wetsuit technical shorts"),
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.75 },
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You loosen your shorts."),
            target = "xs_wetsuit_shorts_technical_loose",
            menu_text = ccb.content.text("Loosen"),
        },
    },
}

ccb.content.define_item {
    id = "wetsuit_shorts_technical_loose",
    name = ccb.content.plural_text("wetsuit technical shorts (loose)", "wetsuit technical shorts (loose)"),
    description = ccb.content.text("A pair of stretchy neoprene shorts with large pockets.  Can be worn over a wetsuit or adjusted to be worn alone."),
    copy_from = "wetsuit_shorts_technical",
    inheritance = { remove = { flags = { "SKINTIGHT" } } },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You tighten your shorts."),
            target = "wetsuit_shorts_technical",
            menu_text = ccb.content.text("Tighten"),
        },
    },
}

ccb.content.define_item {
    id = "xl_wetsuit_shorts_technical_loose",
    copy_from = "xl_wetsuit_shorts_technical",
    name = ccb.content.plural_text("wetsuit technical shorts (loose)", "wetsuit technical shorts (loose)"),
    inheritance = { remove = { flags = { "SKINTIGHT" } } },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You tighten your shorts."),
            target = "xl_wetsuit_shorts_technical",
            menu_text = ccb.content.text("Tighten"),
        },
    },
}

ccb.content.define_item {
    id = "xs_wetsuit_shorts_technical_loose",
    copy_from = "xs_wetsuit_shorts_technical",
    name = ccb.content.plural_text("wetsuit technical shorts (loose)", "wetsuit technical shorts (loose)"),
    inheritance = { remove = { flags = { "SKINTIGHT" } } },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You tighten your shorts."),
            target = "xs_wetsuit_shorts_technical",
            menu_text = ccb.content.text("Tighten"),
        },
    },
}
