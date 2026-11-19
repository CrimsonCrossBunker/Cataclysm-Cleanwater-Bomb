local ccb = require("ccb")

ccb.content.define_item {
    id = "boots_glimmer_fur",
    name = ccb.content.plural_text("pair of glimmer fur boots", "pairs of glimmer fur boots"),
    description = ccb.content.text("Boots lined with glimmer fur for warmth."),
    copy_from = "boots_fur",
    price = "190 USD",
    survival_price = "17 USD 50 cent",
    materials = { "leather", "fae_fur" },
    color = "brown_red",
    armor = {
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_ankle_r", "foot_ankle_l", "foot_heel_r",
                    "foot_heel_l", "foot_arch_r", "foot_arch_l",
                },
                materials = {
                    { id = "leather", coverage = 100, thickness = 1.5 },
                    { id = "fae_fur", coverage = 100, thickness = 1.5 },
                },
                encumbrance = 17,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "leather", coverage = 100, thickness = 0.1 },
                    { id = "rubber", coverage = 100, thickness = 4.0 },
                },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_boots_glimmer_fur",
    name = ccb.content.plural_text("pair of glimmer fur boots", "pairs of glimmer fur boots"),
    copy_from = "boots_glimmer_fur",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.15, volume = 1.15 } },
}

ccb.content.define_item {
    id = "xs_boots_glimmer_fur",
    copy_from = "boots_glimmer_fur",
    name = ccb.content.plural_text("pair of glimmer fur boots", "pairs of glimmer fur boots"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "pants_glimmer_fur",
    name = ccb.content.plural_text("pair of glimmer fur pants", "pairs of glimmer fur pants"),
    description = ccb.content.text("A hefty pair of fae fur-lined pants."),
    mass = "920 g",
    volume = "4 L",
    price = "200 USD",
    survival_price = "1 USD",
    materials = { "cotton", "fae_fur" },
    symbol = "[",
    looks_like = "pants",
    color = "brown",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "4 kg",
            max_item_length = "19 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "4 kg",
            max_item_length = "19 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1080 ml",
            mass_limit = "4 kg",
            max_item_length = "165 mm",
            moves = 100,
        },
        {
            kind = "CONTAINER",
            capacity = "1080 ml",
            mass_limit = "4 kg",
            max_item_length = "165 mm",
            moves = 100,
        },
    },
    flags = { "VARSIZE", "POCKETS" },
    armor = {
        warmth = 80,
        thickness = 1,
        environmental_protection = 3,
        portions = { { encumbrance = { 16, 20 }, coverage = 95, covers = { "leg_l", "leg_r" } } },
    },
}

ccb.content.define_item {
    id = "xl_pants_glimmer_fur",
    name = ccb.content.plural_text("pair of glimmer fur pants", "pairs of glimmer fur pants"),
    copy_from = "pants_glimmer_fur",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.15, volume = 1.15 } },
}

ccb.content.define_item {
    id = "xs_pants_glimmer_fur",
    copy_from = "pants_glimmer_fur",
    name = ccb.content.plural_text("pair of glimmer fur pants", "pairs of glimmer fur pants"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "cloak_glimmer_fur",
    name = ccb.content.text("glimmer fur cloak"),
    description = ccb.content.text("A heavy glimmer fur cloak meant to be thrown over your body.  The shimmering nature of the fur made these garments coveted before the Cataclysm."),
    copy_from = "cloak_fur",
    price = "345 USD",
    survival_price = "27 USD 50 cent",
    materials = { "fae_fur" },
    color = "brown_red",
    flags = { "OVERSIZE", "HOOD", "BELTED", "RAINPROOF" },
    armor = {
        portions = {
            {
                encumbrance = 6,
                coverage = 65,
                covers = { "torso", "arm_l", "arm_r", "leg_l", "leg_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "coat_glimmer_fur",
    name = ccb.content.text("glimmer fur coat"),
    description = ccb.content.text("A glimmer fur coat with a couple small pockets.  Extremely warm and very rare before the Cataclysm."),
    copy_from = "coat_fur",
    price = "650 USD",
    survival_price = "9 USD",
    materials = { "fae_fur", "cotton" },
    color = "brown_red",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "500 ml",
            mass_limit = "2 kg",
            max_item_length = "16 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "500 ml",
            mass_limit = "2 kg",
            max_item_length = "16 cm",
            moves = 80,
        },
    },
    flags = { "VARSIZE", "POCKETS", "OUTER" },
    armor = {
        portions = {
            { covers = { "torso" }, coverage = 95, encumbrance = { 26, 30 } },
            { covers = { "arm_l", "arm_r" }, coverage = 95, encumbrance = { 26, 26 } },
        },
        warmth = 80,
        thickness = 2,
        valid_mods = { "steel_padded" },
        environmental_protection = 2,
    },
}

ccb.content.define_item {
    id = "xl_coat_glimmer_fur",
    name = ccb.content.text("glimmer fur coat"),
    copy_from = "coat_glimmer_fur",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_coat_glimmer_fur",
    copy_from = "coat_glimmer_fur",
    name = ccb.content.text("glimmer fur coat"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "trenchcoat_glimmer_fur",
    name = ccb.content.text("glimmer fur trenchcoat"),
    description = ccb.content.text("A thick glimmer fur trenchcoat, lined with pockets.  Great for storage."),
    mass = "1750 g",
    volume = "7250 ml",
    price = "979 USD",
    survival_price = "7 USD 50 cent",
    materials = { "fae_fur" },
    symbol = "[",
    looks_like = "trenchcoat_leather",
    color = "brown",
    pockets = {
        { kind = "CONTAINER", capacity = "1500 ml", mass_limit = "4 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "1500 ml", mass_limit = "4 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "1 L", mass_limit = "2 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "1 L", mass_limit = "2 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "500 ml", mass_limit = "1 kg", moves = 120 },
        { kind = "CONTAINER", capacity = "500 ml", mass_limit = "1 kg", moves = 120 },
    },
    flags = { "VARSIZE", "POCKETS", "OUTER" },
    armor = {
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_lower" },
                coverage = 100,
                encumbrance = { 9, 19 },
            },
            {
                covers = { "torso" },
                subparts = { "torso_upper" },
                coverage = 95,
                encumbrance = { 0, 0 },
            },
            { covers = { "arm_l", "arm_r" }, coverage = 100, encumbrance = { 9, 9 } },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
                coverage = 90,
                encumbrance = { 4, 5 },
            },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
                coverage = 80,
                encumbrance = { 0, 0 },
            },
        },
        warmth = 50,
        thickness = 3,
        environmental_protection = 1,
    },
}

-- The general guideline for sleeveless trenchcoats is the components, volume, weight, time to craft, and value are 15% lower (rounded down) than the original.  Making it from an original takes 50% the time.
ccb.content.define_item {
    id = "sleeveless_trenchcoat_glimmer_fur",
    name = ccb.content.text("sleeveless glimmer fur trenchcoat"),
    description = ccb.content.text("A thick glimmer fur trenchcoat without sleeves, leaving your arms unencumbered.  Has plenty of storage space due to its many pockets."),
    mass = "1487 g",
    volume = "6750 ml",
    price = "832 USD 15 cent",
    survival_price = "5 USD",
    materials = { "fae_fur" },
    symbol = "[",
    looks_like = "sleeveless_duster_fur",
    color = "brown",
    pockets = {
        { kind = "CONTAINER", capacity = "1500 ml", mass_limit = "4 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "1500 ml", mass_limit = "4 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "1 L", mass_limit = "2 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "1 L", mass_limit = "2 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "500 ml", mass_limit = "1 kg", moves = 120 },
        { kind = "CONTAINER", capacity = "500 ml", mass_limit = "1 kg", moves = 120 },
    },
    flags = { "VARSIZE", "POCKETS", "OUTER" },
    armor = {
        warmth = 50,
        thickness = 3,
        environmental_protection = 1,
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_lower" },
                coverage = 100,
                encumbrance = { 9, 19 },
            },
            {
                covers = { "torso" },
                subparts = { "torso_upper" },
                coverage = 95,
                encumbrance = { 0, 0 },
            },
            {
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_shoulder_r" },
                coverage = 40,
                encumbrance = { 0, 0 },
            },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
                coverage = 90,
                encumbrance = { 4, 5 },
            },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
                coverage = 80,
                encumbrance = { 0, 0 },
            },
        },
    },
}

ccb.content.define_item {
    id = "duster_glimmer_fur",
    name = ccb.content.text("glimmer fur duster"),
    description = ccb.content.text("A thick glimmer fur full-length duster.  Has many pockets for storage.  Shimmers in direct sunlight and would have been fancy clothing prior to the Cataclysm."),
    copy_from = "duster_fur",
    price = "1 kUSD 979 USD",
    survival_price = "25 USD",
    materials = { "fae_fur" },
    color = "brown_red",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1500 ml",
            mass_limit = "4 kg",
            max_item_length = "24 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1500 ml",
            mass_limit = "4 kg",
            max_item_length = "24 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1 L",
            mass_limit = "2 kg",
            max_item_length = "21 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1 L",
            mass_limit = "2 kg",
            max_item_length = "21 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "800 ml",
            mass_limit = "1 kg",
            max_item_length = "13 cm",
            moves = 120,
        },
        {
            kind = "CONTAINER",
            capacity = "800 ml",
            mass_limit = "1 kg",
            max_item_length = "13 cm",
            moves = 120,
        },
    },
    flags = { "VARSIZE", "POCKETS", "OUTER", "WATERPROOF", "RAINPROOF" },
    armor = {
        portions = {
            { covers = { "torso" }, coverage = 90, encumbrance = { 9, 16 } },
            {
                covers = { "leg_l", "leg_r" },
                coverage = 90,
                encumbrance = { 5, 6 },
                subparts = { "leg_hip_l", "leg_hip_r", "leg_upper_l", "leg_upper_r" },
            },
            { covers = { "arm_l", "arm_r" }, coverage = 90, encumbrance = { 9, 9 } },
        },
        warmth = 50,
        thickness = 3,
        valid_mods = { "steel_padded" },
        environmental_protection = 1,
    },
}

-- The general guideline for sleeveless dusters is the components, volume, weight, time to craft, and value are 15% lower (rounded down) than the original.  Making it from an original takes 50% the time.
ccb.content.define_item {
    id = "sleeveless_duster_glimmer_fur",
    name = ccb.content.text("sleeveless glimmer fur duster"),
    description = ccb.content.text("A thick glimmer fur full-length duster without sleeves, leaving your arms unencumbered.  Has plenty of storage space due to its many pockets."),
    mass = "2007 g",
    volume = "8250 ml",
    price = "832 USD 15 cent",
    survival_price = "5 USD",
    materials = { "fae_fur" },
    symbol = "[",
    looks_like = "duster_fur",
    color = "brown",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1500 ml",
            mass_limit = "4 kg",
            max_item_length = "24 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1500 ml",
            mass_limit = "4 kg",
            max_item_length = "24 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1 L",
            mass_limit = "2 kg",
            max_item_length = "21 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1 L",
            mass_limit = "2 kg",
            max_item_length = "21 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "800 ml",
            mass_limit = "1 kg",
            max_item_length = "13 cm",
            moves = 120,
        },
        {
            kind = "CONTAINER",
            capacity = "800 ml",
            mass_limit = "1 kg",
            max_item_length = "13 cm",
            moves = 120,
        },
    },
    flags = { "VARSIZE", "POCKETS", "OUTER", "WATERPROOF", "RAINPROOF" },
    armor = {
        portions = {
            { covers = { "torso" }, coverage = 100, encumbrance = { 9, 17 } },
            {
                covers = { "leg_l", "leg_r" },
                coverage = 85,
                encumbrance = { 4, 5 },
                subparts = { "leg_draped_l", "leg_draped_r" },
                layers = { "BELTED" },
            },
            {
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_shoulder_r" },
                coverage = 40,
                encumbrance = { 0, 0 },
            },
        },
        warmth = 50,
        thickness = 3,
        environmental_protection = 1,
    },
}

ccb.content.define_item {
    id = "xl_duster_glimmer_fur",
    name = ccb.content.text("glimmer fur duster"),
    copy_from = "duster_glimmer_fur",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_duster_glimmer_fur",
    copy_from = "duster_glimmer_fur",
    name = ccb.content.text("glimmer fur duster"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- 20
ccb.content.define_item {
    id = "gambeson_gossamer",
    copy_from = "gambeson",
    looks_like = "gambeson",
    name = ccb.content.text("gossamer gambeson"),
    description = ccb.content.text("A padded greatcoat assembled by quilting gossamer and stuffing the layers with more scraps of gossamer.  It shimmers in a soft rainbow of colors."),
    color = "white",
    materials = { "fae_cotton" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "fae_cotton_quilted", coverage = 100, thickness = 2.5 },
                    { id = "fae_cotton", coverage = 95, thickness = 2.5 },
                    { id = "fae_cotton", coverage = 95, thickness = 2.5 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 13,
            },
            {
                materials = {
                    { id = "fae_cotton_quilted", coverage = 100, thickness = 2 },
                    { id = "fae_cotton", coverage = 95, thickness = 2 },
                    { id = "fae_cotton", coverage = 95, thickness = 2 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 17,
            },
            {
                materials = { { id = "fae_cotton_quilted", coverage = 100, thickness = 2 } },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_draped_l", "leg_draped_r" },
                coverage = 72,
                encumbrance = 5,
                layers = { "BELTED" },
            },
        },
    },
    inheritance = { scale = { mass = 0.6666, price = 2 } },
}

ccb.content.define_item {
    id = "gambeson_pants_gossamer",
    copy_from = "gambeson_pants",
    name = ccb.content.plural_text("gossamer arming pants", "gossamer arming pants"),
    description = ccb.content.text("Thick pants made of gossamer, meant to be worn alongside a gambeson under or without armor.  Stylish and as comfortable as armor can be."),
    color = "white",
    materials = { "fae_cotton" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "fae_cotton_quilted", coverage = 100, thickness = 1 },
                    { id = "fae_cotton", coverage = 95, thickness = 2 },
                },
                covers = { "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = 10,
            },
        },
    },
    inheritance = { scale = { mass = 0.6666, price = 2 } },
}

ccb.content.define_item {
    id = "gambeson_hood_gossamer",
    copy_from = "gambeson_hood",
    looks_like = "gambeson_hood",
    name = ccb.content.text("gossamer gambeson coif"),
    description = ccb.content.text("A gossamer coif with neck and forehead protection.  Resting on your shoulders, it serves as padding for a helmet.  The sort of thing a fae knight guarding a crossroads would wear when challenging travelers to duels."),
    color = "white",
    materials = { "fae_cotton" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "fae_cotton_quilted", coverage = 100, thickness = 0.5 },
                    { id = "fae_cotton", coverage = 95, thickness = 1.5 },
                },
                covers = { "head" },
                subparts = {
                    "head_throat",
                    "head_ear_l",
                    "head_ear_r",
                    "head_forehead",
                    "head_crown",
                    "head_nape",
                },
                coverage = 100,
                encumbrance_modifiers = { "WELL_SUPPORTED" },
            },
        },
    },
    inheritance = { scale = { mass = 0.6666, price = 2 } },
}

ccb.content.define_item {
    id = "mt_chainmail_arms",
    copy_from = "hc_chainmail_arms",
    materials = { "moon_tears_fine_chain" },
    name = ccb.content.plural_text("moon tears chainmail sleeves (pair)", "moon tears chainmail sleeves (pairs)"),
    description = ccb.content.text("Moon tears chainmail arms, found in places where changeling bannermen are numerous.  Each sleeve has straps to connect them with each other.  The lack of fingers makes them less cumbersome and allows them to be used with gloves."),
    armor = {
        portions = {
            {
                materials = { { id = "moon_tears_fine_chain", coverage = 100, thickness = 1.2 } },
                covers = { "arm_l", "arm_r" },
                coverage = 95,
                encumbrance = 12,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_mt_chainmail_arms",
    copy_from = "mt_chainmail_arms",
    name = ccb.content.plural_text("moon tears chainmail sleeves (pair)", "moon tears chainmail sleeves (pairs)"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_mt_chainmail_arms",
    copy_from = "mt_chainmail_arms",
    name = ccb.content.plural_text("moon tears chainmail sleeves (pair)", "moon tears chainmail sleeves (pairs)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "mt_chainmail_feet",
    copy_from = "hc_chainmail_feet",
    materials = { "moon_tears_fine_chain" },
    name = ccb.content.plural_text("moon tears chainmail chausses (pair)", "moon tears chainmail chausses (pairs)"),
    description = ccb.content.text("Moon tears chainmail chausses that cover the feet, like booties made of chainmail.  Found in places where changeling bannermen are numerous."),
    armor = {
        portions = {
            {
                materials = { { id = "moon_tears_fine_chain", coverage = 100, thickness = 1.2 } },
                covers = { "foot_l", "foot_r" },
                coverage = 100,
                encumbrance = 12,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_mt_chainmail_feet",
    copy_from = "mt_chainmail_feet",
    name = ccb.content.plural_text("moon tears chainmail chausses (pair)", "moon tears chainmail chausses (pairs)"),
    description = ccb.content.text("Moon tears chainmail chausses that cover the feet, like booties made of chainmail.  Found in places where redcap aspirants are numerous."),
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 2, volume = 2 } },
}

ccb.content.define_item {
    id = "xs_mt_chainmail_feet",
    copy_from = "mt_chainmail_feet",
    name = ccb.content.plural_text("moon tears chainmail chausses (pair)", "moon tears chainmail chausses (pairs)"),
    description = ccb.content.text("Moon tears chainmail chausses that cover the feet, like booties made of chainmail.  Found in places where pooka aspirants are numerous."),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "mt_chainmail_hands",
    copy_from = "hc_chainmail_hands",
    materials = { "moon_tears_fine_chain" },
    name = ccb.content.plural_text("moon tears chainmail gloves (pair)", "moon tears chainmail gloves (pairs)"),
    description = ccb.content.text("Moon tears chainmail gloves that fully enclose the hand."),
    armor = {
        portions = {
            {
                materials = { { id = "moon_tears_fine_chain", coverage = 100, thickness = 1.2 } },
                covers = { "hand_l", "hand_r" },
                coverage = 100,
                encumbrance = 12,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_mt_chainmail_hands",
    copy_from = "mt_chainmail_hands",
    name = ccb.content.plural_text("moon tears chainmail gloves (pair)", "moon tears chainmail gloves (pairs)"),
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "xs_mt_chainmail_hands",
    copy_from = "mt_chainmail_hands",
    name = ccb.content.plural_text("moon tears chainmail gloves (pair)", "moon tears chainmail gloves (pairs)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "mt_chainmail_hood",
    copy_from = "lc_chainmail_hood",
    materials = { "moon_tears_fine_chain" },
    name = ccb.content.text("moon tears chainmail coif"),
    description = ccb.content.text("A fine moon tears chainmail hood.  Can be worn comfortably under helmets."),
    armor = {
        portions = {
            {
                materials = { { id = "moon_tears_fine_chain", coverage = 100, thickness = 1.2 } },
                covers = { "head" },
                coverage = 95,
                encumbrance = 6,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_mt_chainmail_hood",
    copy_from = "mt_chainmail_hood",
    name = ccb.content.text("moon tears chainmail coif"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_mt_chainmail_hood",
    copy_from = "mt_chainmail_hood",
    name = ccb.content.text("moon tears chainmail coif"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "mt_chainmail_legs",
    copy_from = "lc_chainmail_legs",
    materials = { "moon_tears_fine_chain" },
    name = ccb.content.plural_text("moon tears chainmail leggings", "pairs of moon tears chainmail leggings"),
    description = ccb.content.text("Moon tears chainmail leggings.  Their straps keep everything in place, and the lack of toes and heels allows them to work perfectly well with footwear."),
    armor = {
        portions = {
            {
                materials = { { id = "moon_tears_fine_chain", coverage = 100, thickness = 1.2 } },
                covers = { "leg_l", "leg_r" },
                coverage = 95,
                encumbrance = 20,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_mt_chainmail_legs",
    copy_from = "mt_chainmail_legs",
    name = ccb.content.plural_text("moon tears chainmail leggings", "pairs of moon tears chainmail leggings"),
    description = ccb.content.text("Moon tears chainmail leggings for the largest of redcaps.  Their straps keep everything in place, and the lack of toes and heels allows them to work perfectly well with footwear."),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_mt_chainmail_legs",
    copy_from = "mt_chainmail_legs",
    name = ccb.content.plural_text("moon tears chainmail leggings", "pairs of moon tears chainmail leggings"),
    description = ccb.content.text("Moon tears chainmail leggings for the smallest of pooka.  Their straps keep everything in place, and the lack of toes and heels allows them to work perfectly well with footwear."),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "mt_chainmail_hauberk",
    copy_from = "lc_chainmail_hauberk",
    materials = { "moon_tears_fine_chain" },
    name = ccb.content.text("moon tears chainmail hauberk"),
    description = ccb.content.text("A fully customized high steel chainmail outfit, leaving the head uncovered.  Combine with a gambeson or other padded layer for optimal protection."),
    armor = {
        portions = {
            {
                materials = { { id = "moon_tears_fine_chain", coverage = 100, thickness = 1.2 } },
                covers = { "torso", "leg_l", "leg_r", "arm_l", "arm_r" },
                coverage = 95,
                encumbrance = 20,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_mt_chainmail_hauberk",
    name = ccb.content.text("moon tears chainmail hauberk"),
    copy_from = "mt_chainmail_hauberk",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "mt_chainmail_hauberk_xs",
    copy_from = "mt_chainmail_hauberk",
    name = ccb.content.text("moon tears chainmail hauberk"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "mt_chainmail_suit",
    copy_from = "lc_chainmail_suit",
    materials = { "moon_tears_fine_chain" },
    name = ccb.content.text("moon tears chainmail armor"),
    description = ccb.content.text("A fully customized moon tears chainmail suit.  Combine with a gambeson or other padded layer for optimal protection."),
    armor = {
        portions = {
            {
                materials = { { id = "moon_tears_fine_chain", coverage = 100, thickness = 1.2 } },
                covers = { "head", "torso", "leg_l", "leg_r", "arm_l", "arm_r" },
                coverage = 95,
                encumbrance = 20,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_mt_chainmail_suit",
    name = ccb.content.text("moon tears chainmail armor"),
    copy_from = "mt_chainmail_suit",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "mt_chainmail_suit_xs",
    copy_from = "mt_chainmail_suit",
    materials = { "moon_tears_fine_chain" },
    name = ccb.content.text("moon tears chainmail armor"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "mt_chainmail_vest",
    copy_from = "hc_chainmail_vest",
    materials = { "moon_tears_fine_chain" },
    name = ccb.content.text("moon tears chainmail vest"),
    description = ccb.content.text("A customized moon tears chainmail vest.  It's a sleeveless piece of chainmail with small straps designed to better distribute the weight."),
    armor = {
        portions = {
            {
                materials = { { id = "moon_tears_fine_chain", coverage = 100, thickness = 1.2 } },
                covers = { "torso" },
                coverage = 95,
                encumbrance = 20,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_mt_chainmail_vest",
    name = ccb.content.text("moon tears chainmail vest"),
    copy_from = "mt_chainmail_vest",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_mt_chainmail_vest",
    copy_from = "hc_chainmail_vest",
    name = ccb.content.text("moon tears chainmail vest"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "xl_armor_troll_moons_tears",
    copy_from = "xl_armor_ch_heavyplate",
    name = ccb.content.text("troll armor"),
    description = ccb.content.text("An enormous suit of plate armor once worn by a troll, made of moon's tears almost 15 mm thick.  This would make you a walking tank, if you can move in it."),
    armor = {
        portions = {
            {
                materials = {
                    { id = "moon_tears", coverage = 95, thickness = 14 },
                    { id = "moon_tears_fine_chain", coverage = 100, thickness = 4 },
                    { id = "leather", coverage = 1, thickness = 1 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 50,
            },
            {
                materials = {
                    { id = "moon_tears", coverage = 95, thickness = 6 },
                    { id = "moon_tears_fine_chain", coverage = 100, thickness = 4 },
                    { id = "leather", coverage = 1, thickness = 1 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 40,
            },
            {
                materials = {
                    { id = "moon_tears", coverage = 95, thickness = 6 },
                    { id = "moon_tears_fine_chain", coverage = 100, thickness = 4 },
                    { id = "leather", coverage = 1, thickness = 1 },
                },
                covers = { "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = 40,
            },
        },
    },
    inheritance = { scale = { mass = 3, volume = 2, price = 0.5 } },
}

ccb.content.define_item {
    id = "xl_gauntlets_troll_moons_tears",
    copy_from = "qt_demi_gaunt",
    category = "armor",
    name = ccb.content.plural_text("troll gauntlets (pair)", "troll gauntlets (pair)"),
    description = ccb.content.text("A pair of gigantic gauntlets with mail links of moon's tears protecting the fingers and palm, and plating over the back of the hand and wrist.  You could probably fit an entire child in one of these."),
    mass = "3500 g",
    volume = "2025 ml",
    price = "400 USD",
    survival_price = "15 USD",
    symbol = "[",
    looks_like = "fire_gauntlets",
    materials = { "moon_tears", "moon_tears_fine_chain" },
    color = "light_gray",
    flags = { "STURDY", "OUTER", "OVERSIZE", "PREFIX_XL" },
    melee_damage = { bash = 7 },
    armor = {
        warmth = 15,
        environmental_protection = 1,
        portions = {
            {
                encumbrance = 25,
                coverage = 100,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_back_l", "hand_back_r", "hand_wrist_l", "hand_wrist_r" },
                materials = {
                    { id = "moon_tears", coverage = 100, thickness = 4 },
                    { id = "moon_tears_fine_chain", coverage = 100, thickness = 3 },
                    { id = "leather", coverage = 100, thickness = 1 },
                },
            },
            {
                coverage = 100,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_palm_l", "hand_palm_r" },
                materials = {
                    { id = "moon_tears_fine_chain", coverage = 100, thickness = 3 },
                    { id = "leather", coverage = 100, thickness = 1 },
                },
            },
            {
                coverage = 100,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
                materials = {
                    { id = "moon_tears_fine_chain", coverage = 100, thickness = 3 },
                    { id = "leather", coverage = 100, thickness = 1 },
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_helm_troll_moons_tears",
    category = "armor",
    name = ccb.content.text("troll helm"),
    description = ccb.content.text("Similar to a type of helmet that was developed in the late 15th century, but on a much larger scale.  It includes a bevor to protect the neck, if your neck is as thick as a tree trunk."),
    mass = "7000 g",
    volume = "12 L",
    price = "740 USD",
    survival_price = "74 USD",
    materials = { "moon_tears" },
    symbol = "o",
    looks_like = "helmet_sallet",
    color = "light_gray",
    techniques = { "WBLOCK_1" },
    flags = { "STURDY", "CONDUCTIVE", "PREFIX_XL", "OVERSIZE" },
    max_worn = 1,
    melee_damage = { bash = 8 },
    armor = {
        portions = {
            {
                materials = {
                    { id = "moon_tears", coverage = 100, thickness = 1.75 },
                    { id = "leather", coverage = 1, thickness = 1 },
                },
                covers = { "head" },
                coverage = 100,
                encumbrance_modifiers = { "RESTRICTS_NECK", "WELL_SUPPORTED" },
            },
            {
                materials = {
                    { id = "moon_tears", coverage = 100, thickness = 1.75 },
                    { id = "leather", coverage = 1, thickness = 1 },
                },
                covers = { "mouth" },
                coverage = 100,
                encumbrance = 10,
                layers = { "OUTER" },
                rigid_only = true,
            },
            {
                materials = { { id = "moon_tears", coverage = 100, thickness = 1.75 } },
                covers = { "eyes" },
                coverage = 95,
                encumbrance = 10,
                layers = { "OUTER" },
                rigid_only = true,
            },
        },
        warmth = 5,
        environmental_protection = 1,
    },
}

ccb.content.define_item {
    id = "xl_boots_troll_moons_tears",
    category = "armor",
    name = ccb.content.plural_text("troll greaves (pair)", "troll greaves (pair)"),
    description = ccb.content.text("A pair of greaves made of shimmering fabric sandwiched between alternating strips of moon's tears, sized for a giant."),
    mass = "675 g",
    volume = "1581 ml",
    price = "500 USD",
    survival_price = "5 USD",
    materials = { "moon_tears", "fae_cotton" },
    symbol = "[",
    looks_like = "legguard_metal",
    color = "light_gray",
    flags = { "OUTER", "STURDY", "ABLATIVE_CHAINMAIL_LEGS", "OVERSIZE", "PREFIX_XL" },
    copy_from = "qt_greaves_brigandine",
    armor = {
        environmental_protection = 1,
        portions = {
            {
                materials = {
                    { id = "fae_cotton", coverage = 100, thickness = 2.5 },
                    { id = "moon_tears", coverage = 90, thickness = 3 },
                },
                covers = { "leg_l", "leg_r" },
                encumbrance = 15,
                coverage = 100,
                melee_coverage = 100,
                ranged_coverage = 100,
                vitals_coverage = 90,
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_ankle_r", "foot_ankle_l", "foot_heel_r",
                    "foot_heel_l", "foot_arch_r", "foot_arch_l",
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "dreamforged_ballistic_plate",
    name = ccb.content.text("dreamforged ballistic plate"),
    copy_from = "steel_ballistic_plate",
    description = ccb.content.text("Manually forged ballistic plate, made to fit the common ballistic plate.  Probably not as good as steel one, but lightweight, and additionally hardened with magic."),
    materials = { "forged_dreamstuff" },
    mass = "1499 g",
    volume = "749 ml",
    length = "30 cm",
    armor = {
        portions = {
            {
                materials = { { id = "forged_dreamstuff", coverage = 100, thickness = 1 } },
                encumbrance = 1,
                coverage = 45,
                covers = { "torso" },
                subparts = { "torso_upper" },
            },
        },
    },
}

ccb.content.define_item {
    id = "dreamforged_ballistic_plate_small",
    name = ccb.content.text("small dreamforged ballistic plate"),
    copy_from = "steel_ballistic_plate",
    description = ccb.content.text("Manually forged ballistic plate, made to fit the common ballistic plate.  Probably not as good as steel one, but lightweight, and additionally hardened with magic.  Smaller in size, and can fit a side pocket of plate carrier."),
    materials = { "forged_dreamstuff" },
    mass = "618 g",
    volume = "309 ml",
    length = "20 cm",
    armor = {
        portions = {
            {
                materials = { { id = "forged_dreamstuff", coverage = 100, thickness = 1 } },
                encumbrance = 1,
                coverage = 35,
                covers = { "torso" },
                subparts = { "torso_lower" },
            },
        },
    },
    inheritance = { add = { flags = { "ABLATIVE_MEDIUM" } }, remove = { flags = { "ABLATIVE_LARGE" } } },
}

ccb.content.define_item {
    id = "dreamforged_fullhelmet",
    copy_from = "tac_fullhelmet",
    category = "armor",
    name = ccb.content.text("dreamforged full helmet"),
    description = ccb.content.text("Manually forged helmet, that resemble the shape of modern army helmets.  This one protect both face and eyes, using a special forged mask, but has no visor, and not so comfortable.  The dreamdross grant it some small magical properties, but you can't control their effects."),
    mass = "750 g",
    price = "250 USD",
    survival_price = "0 cent",
    materials = { "forged_dreamstuff" },
    looks_like = "tac_fullhelmet",
    color = "dark_gray",
    techniques = { "WBLOCK_1" },
    flags = { "WATERPROOF", "STURDY", "PADDED", "MORPHIC" },
    armor = {
        portions = {
            {
                covers = { "head" },
                coverage = 100,
                encumbrance_modifiers = { "WELL_SUPPORTED", "RESTRICTS_NECK" },
            },
            { covers = { "eyes" }, rigid_only = true, coverage = 7, encumbrance = 10 },
            { covers = { "mouth" }, rigid_only = true, coverage = 10, encumbrance = 15 },
        },
        warmth = 10,
        thickness = 1.4,
        environmental_protection = 2,
    },
}

ccb.content.define_item {
    id = "dreamforged_helmet",
    copy_from = "helmet_army",
    category = "armor",
    name = ccb.content.text("dreamforged helmet"),
    description = ccb.content.text("Manually forged helmet in the that resemble the shape of modern army helmets."),
    mass = "467 g",
    materials = { "forged_dreamstuff" },
    symbol = "[",
    looks_like = "helmet_army",
    color = "dark_gray",
    techniques = { "WBLOCK_1" },
    flags = { "MORPHIC", "WATERPROOF", "STURDY", "PADDED" },
    armor = {
        warmth = 10,
        thickness = 1.4,
        portions = { { encumbrance_modifiers = { "NONE" }, coverage = 85, covers = { "head" } } },
    },
}
