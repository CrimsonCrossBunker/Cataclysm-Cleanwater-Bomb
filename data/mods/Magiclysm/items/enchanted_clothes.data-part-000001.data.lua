local ccb = require("ccb")

ccb.content.define_item {
    id = "parabolan_blouse",
    name = ccb.content.text("parabolan wool blouse"),
    description = ccb.content.text("A loose silvery iridescent blouse in a style most often associated with pirates and renfaires.  It shimmers as you look at it.  Made of parabolan wool, it sometimes dimly shows reflections of things here and not."),
    looks_like = "dress_shirt",
    mass = "360 g",
    volume = "750 ml",
    price = "20 USD",
    survival_price = "5 USD",
    symbol = "[",
    color = "brown",
    materials = { "parabolan_wool" },
    flags = { "VARSIZE", "WATER_FRIENDLY" },
    armor = {
        portions = {
            { encumbrance = 1, coverage = 95, covers = { "torso" } },
            { encumbrance = 1, coverage = 85, covers = { "arm_r", "arm_l" } },
        },
        thickness = 0.5,
    },
}

ccb.content.define_item {
    id = "parabolan_breeches",
    name = ccb.content.plural_text("parabolan wool breeches", "parabolan wool breeches"),
    description = ccb.content.text("A well-made pair of old-fashioned pants, made of silvery iridescent material.  Comfortable, but lacks pockets.  It shimmers as you look at it.  Made of parabolan wool, it sometimes dimly shows reflections of things here and not."),
    mass = "312 g",
    volume = "1750 ml",
    price = "49 USD",
    survival_price = "5 USD",
    materials = { "parabolan_wool" },
    symbol = "[",
    looks_like = "pants",
    color = "brown",
    flags = { "VARSIZE", "WATER_FRIENDLY" },
    armor = {
        portions = { { encumbrance = 2, coverage = 95, covers = { "leg_l", "leg_r" } } },
        thickness = 0.5,
    },
}

-- 2
ccb.content.define_item {
    id = "gambeson_parabolan",
    name = ccb.content.text("parabolan wool gambeson"),
    description = ccb.content.text("A padded greatcoat assembled by quilting rarely available iridescent wool that was intended as standalone armor, this is half the thickness of a historical gambeson due to the quality of its material.  Famed for its resistance to arrows in olden times, one might wonder how effective it might be against modern projectiles."),
    mass = "1664 g",
    volume = "3750 ml",
    price = "4 kUSD",
    survival_price = "3 kUSD",
    accuracy = -5,
    materials = { "parabolan_wool" },
    symbol = "[",
    looks_like = "jacket_light",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY", "NORMAL", "OUTER", "BLOCK_WHILE_WORN" },
    armor = {
        warmth = 6,
        portions = {
            {
                materials = {
                    { id = "parabolan_wool_quilted", coverage = 100, thickness = 1 },
                    { id = "parabolan_wool", coverage = 95, thickness = 2.75 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 9,
            },
            {
                materials = {
                    { id = "parabolan_wool_quilted", coverage = 100, thickness = 1 },
                    { id = "parabolan_wool", coverage = 95, thickness = 2 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 13,
            },
            {
                materials = { { id = "parabolan_wool_quilted", coverage = 100, thickness = 1.0 } },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_draped_l", "leg_draped_r" },
                coverage = 72,
                encumbrance = 3,
                layers = { "BELTED" },
            },
        },
    },
}

-- surface area of XL body assumed to be 50% greater and materials used are also 50% greater.
ccb.content.define_item {
    id = "xl_gambeson_parabolan",
    name = ccb.content.text("parabolan wool gambeson"),
    copy_from = "gambeson_parabolan",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.5, volume = 1.5, price = 1.25 },
    },
}

-- surface area of XS body assumed to be 75% size and materials used are also 75% as much.
ccb.content.define_item {
    id = "xs_gambeson_parabolan",
    name = ccb.content.text("parabolan wool gambeson"),
    copy_from = "gambeson_parabolan",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- 3
-- 2
ccb.content.define_item {
    id = "gambeson_parabolan_thinsleeved",
    name = ccb.content.text("thin-sleeved parabolan wool gambeson"),
    description = ccb.content.text("A thick iridescent wool greatcoat famed for its resistance to arrows in olden times.  Compared to conventional wool, this is much lighter and less warm.  The sleeves are a lot thinner for flexibility and it drapes below your legs, providing additional protection there."),
    mass = "3147 g",
    volume = "3750 ml",
    survival_price = "1 kUSD 500 USD",
    accuracy = -5,
    materials = { "parabolan_wool" },
    symbol = "[",
    looks_like = "gambeson_parabolan",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY", "NORMAL", "OUTER" },
    armor = {
        warmth = 6,
        thickness = 3.75,
        environmental_protection = 1,
        portions = {
            {
                materials = {
                    { id = "parabolan_wool_quilted", coverage = 100, thickness = 1.0 },
                    { id = "parabolan_wool", coverage = 95, thickness = 2.75 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 9,
            },
            {
                materials = {
                    { id = "parabolan_wool_quilted", coverage = 100, thickness = 0.5 },
                    { id = "parabolan_wool", coverage = 95, thickness = 1.0 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 12,
                layers = { "NORMAL" },
            },
            {
                materials = { { id = "parabolan_wool_quilted", coverage = 100, thickness = 1.0 } },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_draped_l", "leg_draped_r" },
                coverage = 72,
                encumbrance = 3,
                layers = { "BELTED" },
            },
        },
    },
}

-- surface area of XL body assumed to be 50% greater and materials used are also 50% greater.
ccb.content.define_item {
    id = "xl_gambeson_parabolan_thinsleeved",
    name = ccb.content.text("thin-sleeved parabolan wool gambeson"),
    copy_from = "gambeson_parabolan_thinsleeved",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.5, volume = 1.5, price = 1.25 },
    },
}

-- surface area of XS body assumed to be 75% size and materials used are also 75% as much.
ccb.content.define_item {
    id = "xs_gambeson_parabolan_thinsleeved",
    name = ccb.content.text("thin-sleeved parabolan wool gambeson"),
    copy_from = "gambeson_parabolan_thinsleeved",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- 2
ccb.content.define_item {
    id = "gambeson_parabolan_vest",
    name = ccb.content.text("sleeveless parabolan wool gambeson"),
    description = ccb.content.text("A thick iridescent wool surcoat famed for its resistance to arrows in the olden times.  Compared to conventional wool, this is much lighter and less warm.  It drapes below your legs, providing additional protection there, and it lacks sleeves entirely."),
    mass = "2340 g",
    volume = "3000 ml",
    survival_price = "1 kUSD",
    accuracy = -5,
    materials = { "parabolan_wool" },
    symbol = "[",
    looks_like = "sleeveless_tunic",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY", "NORMAL", "OUTER" },
    armor = {
        warmth = 6,
        thickness = 3.75,
        environmental_protection = 1,
        portions = {
            {
                materials = {
                    { id = "parabolan_wool_quilted", coverage = 100, thickness = 1.0 },
                    { id = "parabolan_wool", coverage = 95, thickness = 2.75 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 9,
            },
            {
                materials = { { id = "parabolan_wool_quilted", coverage = 100, thickness = 1.0 } },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_draped_l", "leg_draped_r" },
                coverage = 72,
                encumbrance = 3,
                layers = { "BELTED" },
            },
        },
    },
}

-- surface area of XL body assumed to be 50% greater and materials used are also 50% greater.
ccb.content.define_item {
    id = "xl_gambeson_parabolan_vest",
    name = ccb.content.text("sleeveless parabolan wool gambeson"),
    copy_from = "gambeson_parabolan_vest",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.5, volume = 1.5, price = 1.25 },
    },
}

-- surface area of XS body assumed to be 75% size and materials used are also 75% as much.
ccb.content.define_item {
    id = "xs_gambeson_parabolan_vest",
    name = ccb.content.text("sleeveless parabolan wool gambeson"),
    copy_from = "gambeson_parabolan_vest",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "gambeson_pants_parabolan",
    name = ccb.content.plural_text("parabolan wool heavy arming pants", "pairs of parabolan wool heavy arming pants"),
    description = ccb.content.text("Tough, fairly thick iridescent wool pants worn on their own alongside a gambeson.  These are made of layered wool quilting offering very solid protection, specifically for the purposes of stopping arrows."),
    mass = "1404 g",
    volume = "1875 ml",
    survival_price = "1 kUSD",
    accuracy = -5,
    materials = { "parabolan_wool" },
    symbol = "[",
    looks_like = "fencing_pants",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY", "NORMAL", "OUTER" },
    armor = {
        warmth = 6,
        thickness = 3.0,
        environmental_protection = 1,
        portions = {
            {
                materials = {
                    { id = "parabolan_wool_quilted", coverage = 100, thickness = 1.0 },
                    { id = "parabolan_wool", coverage = 95, thickness = 2.0 },
                },
                covers = { "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = 13,
            },
        },
    },
}

-- surface area of XL body assumed to be 50% greater and materials used are also 50% greater.
ccb.content.define_item {
    id = "xl_gambeson_pants_parabolan",
    name = ccb.content.plural_text("parabolan wool heavy arming pants", "pairs of parabolan wool heavy arming pants"),
    copy_from = "gambeson_pants_parabolan",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.5, volume = 1.5, price = 1.25 },
    },
}

-- surface area of XS body assumed to be 75% size and materials used are also 75% as much.
ccb.content.define_item {
    id = "xs_gambeson_pants_parabolan",
    name = ccb.content.plural_text("parabolan wool heavy arming pants", "pairs of parabolan wool heavy arming pants"),
    copy_from = "gambeson_pants_parabolan",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- technically, only covering 60% ish - inner hand is thinner - but fist will be clenched so inner hand should not really be hit
ccb.content.define_item {
    id = "gambeson_gloves_parabolan",
    name = ccb.content.plural_text("parabolan wool arming mittens", "pairs of parabolan wool arming mittens"),
    description = ccb.content.text("Thick iridescent wool gauntlets worn in lieu of metal or leather armor.  These are much less encumbering and warm than conventional wool, but they offer excellent protection against arrows."),
    mass = "174 g",
    volume = "250 ml",
    survival_price = "400 USD",
    accuracy = -1,
    materials = { "parabolan_wool" },
    symbol = "[",
    looks_like = "mittens",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY", "NORMAL", "OUTER" },
    armor = {
        warmth = 5,
        thickness = 3.0,
        environmental_protection = 1,
        portions = {
            {
                materials = {
                    { id = "parabolan_wool_quilted", coverage = 100, thickness = 1.0 },
                    { id = "parabolan_wool", coverage = 90, thickness = 2.0 },
                },
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
                coverage = 100,
                encumbrance = 15,
            },
            {
                materials = {
                    { id = "parabolan_wool_quilted", coverage = 100, thickness = 1.0 },
                    { id = "parabolan_wool", coverage = 95, thickness = 2.0 },
                },
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_back_l", "hand_back_r", "hand_wrist_l", "hand_wrist_r" },
                coverage = 100,
            },
            {
                materials = { { id = "parabolan_wool_quilted", coverage = 100, thickness = 1.0 } },
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_palm_l", "hand_palm_r" },
                coverage = 100,
            },
        },
    },
}

-- surface area of XL body assumed to be 50% greater and materials used are also 50% greater.
ccb.content.define_item {
    id = "xl_gambeson_gloves_parabolan",
    name = ccb.content.plural_text("parabolan wool arming mittens", "pairs of parabolan wool arming mittens"),
    copy_from = "gambeson_gloves_parabolan",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.5, volume = 1.5, price = 1.25 },
    },
}

-- surface area of XS body assumed to be 75% size and materials used are also 75% as much.
ccb.content.define_item {
    id = "xs_gambeson_gloves_parabolan",
    name = ccb.content.plural_text("parabolan wool arming mittens", "pairs of parabolan wool arming mittens"),
    copy_from = "gambeson_gloves_parabolan",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}
