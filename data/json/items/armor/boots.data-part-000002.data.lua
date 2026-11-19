local ccb = require("ccb")

ccb.content.define_item {
    id = "boots_winter",
    name = ccb.content.plural_text("winter boots (pair)", "winter boots (pair)"),
    description = ccb.content.text("Wool-lined boots designed for warmth."),
    mass = "1640 g",
    volume = "3500 ml",
    price = "70 USD",
    survival_price = "7 USD 50 cent",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "wool", "plastic" },
    symbol = "[",
    looks_like = "boots_larmor",
    color = "light_gray",
    flags = { "VARSIZE", "WATERPROOF" },
    melee_damage = { bash = 1 },
    armor = {
        warmth = 80,
        environmental_protection = 1,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_r", "foot_ankle_l", "foot_arch_r", "foot_arch_l" },
                materials = {
                    { id = "plastic", coverage = 100, thickness = 2.5 },
                    { id = "wool", coverage = 100, thickness = 2.5 },
                },
                encumbrance = 25,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_toes_r", "foot_toes_l", "foot_heel_r", "foot_heel_l" },
                materials = {
                    { id = "rubber", coverage = 100, thickness = 2.5 },
                    { id = "wool", coverage = 100, thickness = 2.5 },
                },
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 0.1 },
                    { id = "rubber", coverage = 100, thickness = 6.0 },
                },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_boots_winter",
    name = ccb.content.plural_text("winter boots (pair)", "winter boots (pair)"),
    copy_from = "boots_winter",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.3, volume = 1.3 } },
}

ccb.content.define_item {
    id = "xs_boots_winter",
    copy_from = "boots_winter",
    name = ccb.content.plural_text("winter boots (pair)", "winter boots (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "cleats",
    name = ccb.content.plural_text("cleats (pair)", "cleats (pair)"),
    description = ccb.content.text("Sport shoes with hard undersides and studs on the bottom designed to dig into grass."),
    mass = "860 g",
    volume = "1500 ml",
    price = "70 USD",
    survival_price = "7 USD 50 cent",
    materials = { "cotton", "leather" },
    symbol = "[",
    looks_like = "sneakers",
    color = "light_gray",
    flags = { "VARSIZE" },
    melee_damage = { bash = 2 },
    armor = {
        warmth = 20,
        thickness = 2,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r",
                    "foot_toes_l",
                    "foot_heel_r",
                    "foot_heel_l",
                    "foot_arch_r",
                    "foot_arch_l",
                },
                materials = {
                    { id = "leather", coverage = 100, thickness = 1.0 },
                    { id = "cotton", coverage = 100, thickness = 1.0 },
                },
                encumbrance = 15,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_l", "foot_ankle_r" },
                materials = {
                    { id = "leather", coverage = 100, thickness = 1.0 },
                    { id = "cotton", coverage = 100, thickness = 1.0 },
                },
                coverage = 40,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 0.1 },
                    { id = "rubber", coverage = 100, thickness = 2.0 },
                    { id = "rubber", coverage = 20, thickness = 4.0 },
                },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "golf_shoes",
    name = ccb.content.plural_text("golf shoes (pair)", "golf shoes (pair)"),
    description = ccb.content.text("Snug sport shoes with hard ridges on the bottom."),
    mass = "820 g",
    volume = "1500 ml",
    price = "65 USD",
    survival_price = "2 USD 50 cent",
    materials = { "cotton", "leather" },
    symbol = "[",
    looks_like = "dress_shoes",
    color = "light_gray",
    flags = { "VARSIZE" },
    melee_damage = { bash = 2 },
    armor = {
        warmth = 15,
        thickness = 2,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r",
                    "foot_toes_l",
                    "foot_heel_r",
                    "foot_heel_l",
                    "foot_arch_r",
                    "foot_arch_l",
                },
                materials = {
                    { id = "leather", coverage = 100, thickness = 1.0 },
                    { id = "cotton", coverage = 100, thickness = 1.0 },
                },
                encumbrance = 12,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_r", "foot_ankle_l" },
                materials = {
                    { id = "leather", coverage = 100, thickness = 1.0 },
                    { id = "cotton", coverage = 100, thickness = 1.0 },
                },
                coverage = 60,
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
    id = "clogs",
    name = ccb.content.plural_text("wooden clogs (pair)", "wooden clogs (pair)"),
    description = ccb.content.text("Known as klompen in the Netherlands and sabots in France, these wooden shoes have endured through the ages due to their simple design and durability."),
    mass = "916 g",
    volume = "1250 ml",
    price = "40 USD",
    survival_price = "1 USD 50 cent",
    materials = { "wood" },
    symbol = "[",
    looks_like = "leathersandals",
    color = "yellow",
    flags = { "VARSIZE", "WATERPROOF" },
    melee_damage = { bash = 5 },
    armor = {
        warmth = 5,
        thickness = 4,
        environmental_protection = 1,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_toes_r", "foot_toes_l" },
                materials = { { id = "wood", coverage = 100, thickness = 2.0 } },
                encumbrance = 20,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_arch_l", "foot_arch_r", "foot_heel_l", "foot_heel_r" },
                materials = { { id = "wood", coverage = 100, thickness = 2.0 } },
                encumbrance = 20,
                coverage = 80,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = { { id = "wood", coverage = 100, thickness = 2.0 } },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "clownshoes",
    name = ccb.content.plural_text("clown shoes (pair)", "clown shoes (pair)"),
    description = ccb.content.text("Gigantic shoes fit for a clown.  Incredibly difficult to walk in."),
    mass = "1140 g",
    volume = "3500 ml",
    price = "5 USD",
    survival_price = "50 cent",
    materials = { "leather" },
    symbol = "[",
    looks_like = "sneakers",
    color = "light_red",
    armor = {
        warmth = 20,
        thickness = 2.5,
        environmental_protection = 2,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_heel_r",
                    "foot_heel_l",
                    "foot_arch_r",
                    "foot_arch_l",
                    "foot_toes_l",
                    "foot_toes_r",
                },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 1.25 },
                    { id = "leather", coverage = 100, thickness = 1.25 },
                },
                encumbrance = 8,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_r", "foot_ankle_l" },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 1.25 },
                    { id = "leather", coverage = 100, thickness = 1.25 },
                },
                coverage = 60,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 0.1 },
                    { id = "rubber", coverage = 100, thickness = 4.0 },
                },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "dance_shoes",
    name = ccb.content.plural_text("dance shoes (pair)", "dance shoes (pair)"),
    description = ccb.content.text("Expensive black dance shoes with large heels."),
    mass = "870 g",
    volume = "1500 ml",
    price = "120 USD",
    survival_price = "1 USD 50 cent",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "leather" },
    symbol = "[",
    looks_like = "dress_shoes",
    color = "dark_gray",
    flags = { "VARSIZE" },
    melee_damage = { bash = 1 },
    armor = {
        warmth = 10,
        thickness = 1.5,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_heel_r",
                    "foot_heel_l",
                    "foot_arch_r",
                    "foot_arch_l",
                    "foot_toes_r",
                    "foot_toes_l",
                },
                materials = { { id = "cotton", coverage = 100, thickness = 1 } },
                encumbrance = 5,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_r", "foot_ankle_l" },
                materials = { { id = "cotton", coverage = 100, thickness = 1.0 } },
                coverage = 20,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 0.1 },
                    { id = "rubber", coverage = 20, thickness = 8.0 },
                    { id = "rubber", coverage = 100, thickness = 4.0 },
                },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "dress_shoes",
    name = ccb.content.plural_text("dress shoes (pair)", "dress shoes (pair)"),
    description = ccb.content.text("Fancy patent leather shoes.  Not designed for running."),
    mass = "870 g",
    volume = "1500 ml",
    price = "120 USD",
    survival_price = "2 USD 50 cent",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "leather" },
    symbol = "[",
    looks_like = "sneakers",
    color = "dark_gray",
    flags = { "VARSIZE" },
    melee_damage = { bash = 1 },
    armor = {
        warmth = 10,
        thickness = 2.0,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_heel_r",
                    "foot_heel_l",
                    "foot_arch_r",
                    "foot_arch_l",
                    "foot_toes_r",
                    "foot_toes_l",
                },
                materials = { { id = "leather", coverage = 100, thickness = 2 } },
                encumbrance = 15,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_r", "foot_ankle_l" },
                materials = { { id = "leather", coverage = 100, thickness = 2.0 } },
                coverage = 40,
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
    id = "flip_flops",
    name = ccb.content.plural_text("flip-flops (pair)", "flip-flops (pair)"),
    description = ccb.content.text("Simple sandals.  Somewhat difficult to run in."),
    mass = "62 g",
    volume = "250 ml",
    price = "5 USD",
    survival_price = "50 cent",
    symbol = "[",
    looks_like = "sneakers",
    color = "blue",
    flags = { "VARSIZE", "WATER_FRIENDLY", "ALLOWS_NATURAL_ATTACKS", "ALLOWS_TALONS" },
    armor = {
        thickness = 1,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_arch_r", "foot_arch_l" },
                materials = { { id = "plastic", coverage = 100, thickness = 1 } },
                encumbrance = 15,
                coverage = 40,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = { { id = "plastic", coverage = 100, thickness = 4.0 } },
                coverage = 80,
            },
        },
    },
}

ccb.content.define_item {
    id = "flip_flops_exp",
    name = ccb.content.plural_text("expensive flip-flops (pair)", "expensive flip-flops (pair)"),
    description = ccb.content.text("These are upmarket \"luxury\" flip-flops.  Very difficult to run in."),
    mass = "170 g",
    volume = "250 ml",
    price = "105 USD",
    survival_price = "50 cent",
    materials = { "rubber", "leather" },
    symbol = "[",
    looks_like = "flip_flops",
    color = "brown",
    flags = { "VARSIZE", "WATER_FRIENDLY", "ALLOWS_NATURAL_ATTACKS" },
    melee_damage = { bash = 1 },
    armor = {
        thickness = 1,
        environmental_protection = 1,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_arch_r", "foot_arch_l" },
                materials = { { id = "leather", coverage = 100, thickness = 1 } },
                encumbrance = 22,
                coverage = 40,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = { { id = "rubber", coverage = 100, thickness = 4.0 } },
                coverage = 80,
            },
        },
    },
}

ccb.content.define_item {
    id = "footrags",
    name = ccb.content.plural_text("foot rags (pair)", "foot rags (pair)"),
    description = ccb.content.text("Rags tied around your feet.  Not much of an improvement over being barefoot, but still better than nothing."),
    mass = "56 g",
    volume = "250 ml",
    price = "5 USD",
    survival_price = "10 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "socks",
    color = "white",
    flags = { "SKINTIGHT", "OVERSIZE", "ALLOWS_NATURAL_ATTACKS" },
    armor = {
        warmth = 5,
        thickness = 1.5,
        portions = {
            {
                encumbrance = 2,
                coverage = 65,
                covers = {
                    "foot_l", "foot_r", "hoof_r", "hoof_l", "avian_talon_l", "avian_talon_r",
                    "animal_paw_l", "animal_paw_r", "animal_paw_rabbit_l", "animal_paw_rabbit_r",
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "footrags_fur",
    name = ccb.content.plural_text("fur foot wraps (pair)", "fur foot wraps (pair)"),
    description = ccb.content.text("Fur pelts tied around your feet.  Not much of an improvement over being barefoot, but still better than nothing."),
    mass = "135 g",
    volume = "500 ml",
    price = "7 USD",
    survival_price = "50 cent",
    materials = { "fur" },
    symbol = "[",
    looks_like = "socks_wool",
    color = "brown",
    flags = { "OVERSIZE", "ALLOWS_NATURAL_ATTACKS" },
    armor = {
        warmth = 20,
        thickness = 1.5,
        portions = {
            {
                encumbrance = 5,
                coverage = 65,
                covers = {
                    "foot_l", "foot_r", "hoof_r", "hoof_l", "avian_talon_l", "avian_talon_r",
                    "animal_paw_l", "animal_paw_r", "animal_paw_rabbit_l", "animal_paw_rabbit_r",
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "footrags_faux_fur",
    name = ccb.content.plural_text("faux fur foot wraps (pair)", "faux fur foot wraps (pair)"),
    description = ccb.content.text("Faux fur patches tied around your feet.  Not much of an improvement over being barefoot, but still better than nothing."),
    mass = "135 g",
    volume = "500 ml",
    price = "7 USD",
    survival_price = "50 cent",
    materials = { "faux_fur" },
    symbol = "[",
    looks_like = "socks_wool",
    color = "brown",
    flags = { "OVERSIZE", "ALLOWS_NATURAL_ATTACKS" },
    armor = {
        warmth = 18,
        thickness = 1.5,
        portions = {
            {
                encumbrance = 5,
                coverage = 65,
                covers = {
                    "foot_l", "foot_r", "hoof_r", "hoof_l", "avian_talon_l", "avian_talon_r",
                    "animal_paw_l", "animal_paw_r", "animal_paw_rabbit_l", "animal_paw_rabbit_r",
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "footrags_leather",
    name = ccb.content.plural_text("leather foot wraps (pair)", "leather foot wraps (pair)"),
    description = ccb.content.text("Leather patches tied around your feet.  Not much of an improvement over being barefoot, but still better than nothing."),
    mass = "120 g",
    volume = "500 ml",
    price = "5 USD 25 cent",
    survival_price = "50 cent",
    materials = { "leather" },
    symbol = "[",
    looks_like = "socks",
    color = "brown",
    flags = { "OVERSIZE", "ALLOWS_NATURAL_ATTACKS" },
    armor = {
        warmth = 10,
        thickness = 1.5,
        portions = {
            {
                encumbrance = 5,
                coverage = 65,
                covers = {
                    "foot_l", "foot_r", "hoof_r", "hoof_l", "avian_talon_l", "avian_talon_r",
                    "animal_paw_l", "animal_paw_r", "animal_paw_rabbit_l", "animal_paw_rabbit_r",
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "footrags_wool",
    name = ccb.content.plural_text("wool foot wraps (pair)", "wool foot wraps (pair)"),
    description = ccb.content.text("Felt patches tied around your feet.  Not much of an improvement over being barefoot, but still better than nothing."),
    mass = "56 g",
    volume = "250 ml",
    price = "5 USD",
    survival_price = "50 cent",
    materials = { "wool" },
    symbol = "[",
    looks_like = "socks_wool",
    color = "blue",
    flags = { "SKINTIGHT", "OVERSIZE", "ALLOWS_NATURAL_ATTACKS" },
    armor = {
        warmth = 15,
        thickness = 1.5,
        portions = {
            {
                encumbrance = 5,
                coverage = 65,
                covers = {
                    "foot_l", "foot_r", "hoof_r", "hoof_l", "avian_talon_l", "avian_talon_r",
                    "animal_paw_l", "animal_paw_r", "animal_paw_rabbit_l", "animal_paw_rabbit_r",
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "geta",
    name = ccb.content.plural_text("geta (pair)", "geta (pair)"),
    description = ccb.content.text("A simple pair of geta.  Traditional wooden Japanese sandals with a fabric thong similar to flip flops."),
    mass = "460 g",
    volume = "1 L",
    price = "65 USD",
    survival_price = "50 cent",
    symbol = "[",
    looks_like = "clogs",
    color = "yellow",
    flags = { "VARSIZE", "WATERPROOF" },
    melee_damage = { bash = 5 },
    armor = {
        warmth = 5,
        environmental_protection = 1,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_arch_r", "foot_arch_l" },
                materials = { { id = "cotton", coverage = 100, thickness = 2 } },
                encumbrance = 10,
                coverage = 40,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "wood", coverage = 100, thickness = 2.0 },
                    { id = "wood", coverage = 40, thickness = 4.0 },
                },
                coverage = 80,
            },
        },
    },
}

ccb.content.define_item {
    id = "heels",
    name = ccb.content.plural_text("heels (pair)", "heels (pair)"),
    description = ccb.content.text("A pair of high heels.  Difficult to even walk in."),
    mass = "640 g",
    volume = "750 ml",
    price = "40 USD",
    survival_price = "50 cent",
    materials = { "leather" },
    symbol = "[",
    looks_like = "dress_shoes",
    color = "dark_gray",
    flags = { "VARSIZE" },
    melee_damage = { bash = 6 },
    variant_kind = "generic",
    variants = {
        {
            id = "heels_stiletto",
            name = ccb.content.plural_text("stiletto heels (pair)", "stiletto heels (pair)"),
            description = ccb.content.text("A traditional pair of tall, high-heeled shoes with a tapered, slender heel, which makes strutting fashionable, walking a challenge, and running an impossibility.  These days, they'd probably be more useful to stab a zombie's eyes out than as footwear."),
            weight = 10,
        },
        {
            id = "heels_block",
            name = ccb.content.plural_text("block heels (pair)", "block heels (pair)"),
            description = ccb.content.text("These are a pair of chunky, broad-based shoes with a sturdy block-like heel, and while they don't do you any favors in the mobility department, they're at least more comfortable to trudge about in than their peers and won't likely cause irreversible damage to your feet."),
            weight = 10,
        },
        {
            id = "heels_wedge",
            name = ccb.content.plural_text("wedges (pair)", "wedges (pair)"),
            description = ccb.content.text("A pair of tall, high-heeled, open-toed shoes with thick wedges running the length of the shoe, serving as its heels."),
            weight = 10,
        },
        {
            id = "heels_platform",
            name = ccb.content.plural_text("platform heels (pair)", "platform heels (pair)"),
            description = ccb.content.text("A pair of heavy, thick-soled high-heeled shoes with a ridiculously tall heel supported by an ankle strap and chunky soles.  A great choice for when you've given up on basic biomechanical function and decided that you're more than willing to risk long-term damage to your feet for the sake of a ridiculous fashion statement in the ruins of America."),
            weight = 10,
        },
        {
            id = "heels_flag",
            name = ccb.content.plural_text("liberty's heels (pair)", "liberty's heels (pair)"),
            description = ccb.content.text("The shoes of patriotic ladies around the nation, these open-toed heels glitter with small golden stars embroidered along their sides, with a pair of decorative flaps styled with the image of a miniature American flag unfurling from each ankle, like wings.  The footwear's heels consist of an adorably tiny reproduction of the Statue of Liberty situated beneath each sole, with their arms razed and supporting the shoe's heels.  Each of the statues' dresses is inscribed with the legend, \"America Gives You Wings!\""),
        },
    },
    armor = {
        thickness = 1.5,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_heel_r", "foot_heel_l", "foot_toes_r", "foot_toes_l" },
                materials = { { id = "leather", coverage = 100, thickness = 1 } },
                encumbrance = 50,
                coverage = 80,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "leather", coverage = 100, thickness = 1.0 },
                    { id = "rubber", coverage = 100, thickness = 4.0 },
                    { id = "rubber", coverage = 5, thickness = 80.0 },
                },
                coverage = 100,
            },
        },
    },
}

-- inherit name and description from item
ccb.content.define_item {
    id = "knee_high_boots",
    name = ccb.content.plural_text("knee-high boots (pair)", "knee-high boots (pair)"),
    description = ccb.content.text("Very long leather boots that cover the lower legs, they are cumbersome to wear."),
    mass = "1520 g",
    volume = "3750 ml",
    length = "33 cm",
    price = "80 USD",
    survival_price = "12 USD 50 cent",
    accuracy = { grip = "none", length = "short", surface = "any", balance = "clumsy" },
    materials = { "leather" },
    symbol = "[",
    looks_like = "boots_larmor",
    color = "black",
    flags = { "VARSIZE", "WATERPROOF" },
    melee_damage = { bash = 1 },
    variant_kind = "generic",
    variants = {
        { id = "generic_knee_high_boots", weight = 10 },
        {
            id = "jackboots",
            name = ccb.content.plural_text("jackboots (pair)", "jackboots (pair)"),
            description = ccb.content.text("A pair of sturdy, over-the-knee, laceless boots fitted with a rubberized sole: these imposing combat boots provide good traction despite their encumbering nature.  Most commonly associated with totalitarian regimes due to their use by Nazi soldiers, this style of boot is warm, protective, and produces a deeply satisfying sound while marching."),
            weight = 10,
        },
        {
            id = "chelsea_boots",
            name = ccb.content.plural_text("Chelsea boots (pair)", "Chelsea boots (pair)"),
            description = ccb.content.text("A pair of knee-length, laceless boots formed from calfskin with an elastic side panel that's designed to stretch away to facilitate simple donning and doffing, these stylish stompers are a time-old gift from Victorian-age England.  Intended for you to fashionably saunter down roadways rather than sprint for your life, this style of boot became a style staple within London during the 1960s, where they were synonymous with the mod crowd."),
            weight = 10,
        },
    },
    armor = {
        warmth = 20,
        thickness = 2,
        environmental_protection = 2,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "leather", coverage = 100, thickness = 0.1 },
                    { id = "rubber", coverage = 100, thickness = 4.0 },
                },
                coverage = 100,
                encumbrance = 20,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_heel_r", "foot_heel_l", "foot_arch_r", "foot_arch_l", "foot_toes_r",
                    "foot_toes_l", "foot_ankle_l", "foot_ankle_r",
                },
                materials = { { id = "leather", coverage = 100, thickness = 2.0 } },
                coverage = 100,
            },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_lower_l", "leg_lower_r" },
                coverage = 100,
                encumbrance = 15,
            },
        },
    },
}

ccb.content.define_item {
    id = "motor_police_boots",
    category = "armor",
    name = ccb.content.plural_text("motorcycle police boots (pair)", "motorcycle police boots (pair)"),
    description = ccb.content.text("Custom-made knee-high leather boots issued to motor officers.  Warm, durable and quite tough."),
    mass = "1520 g",
    volume = "3750 ml",
    price = "80 USD",
    survival_price = "12 USD 50 cent",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    symbol = "[",
    looks_like = "knee_high_boots",
    color = "dark_gray",
    flags = { "VARSIZE", "WATERPROOF", "OUTER", "STURDY" },
    melee_damage = { bash = 1 },
    armor = {
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "leather", coverage = 100, thickness = 0.1 },
                    { id = "rubber", coverage = 100, thickness = 4.0 },
                },
                coverage = 100,
                encumbrance = 15,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_heel_r", "foot_heel_l", "foot_arch_r", "foot_arch_l", "foot_toes_r",
                    "foot_toes_l", "foot_ankle_l", "foot_ankle_r",
                },
                materials = { { id = "leather", coverage = 100, thickness = 2.0 } },
                coverage = 100,
            },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_lower_l", "leg_lower_r" },
                coverage = 100,
                encumbrance = 10,
            },
        },
        warmth = 20,
        thickness = 2,
        environmental_protection = 2,
    },
}

-- weight is based on an average of between 1 and 2 lbs for various hiking sandals IRL.
ccb.content.define_item {
    id = "leathersandals",
    name = ccb.content.plural_text("leather sandals (pair)", "leather sandals (pair)"),
    description = ccb.content.text("Sturdy leather hiking sandals with a heel strap.  Offers little in the way of protection, but keeps you cool during warmer months."),
    mass = "675 g",
    volume = "250 ml",
    price = "40 USD",
    survival_price = "2 USD 50 cent",
    symbol = "[",
    looks_like = "flip_flops",
    color = "brown",
    flags = { "VARSIZE", "WATER_FRIENDLY", "ALLOWS_NATURAL_ATTACKS", "ALLOWS_TALONS" },
    armor = {
        thickness = 1.5,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_heel_r", "foot_heel_l" },
                materials = { { id = "leather", coverage = 100, thickness = 1.5 } },
                encumbrance = 8,
                coverage = 40,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_ankle_r",
                    "foot_ankle_l",
                    "foot_arch_r",
                    "foot_arch_l",
                    "foot_toes_r",
                    "foot_toes_l",
                },
                materials = { { id = "leather", coverage = 100, thickness = 1.5 } },
                coverage = 20,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "leather", coverage = 100, thickness = 0.1 },
                    { id = "rubber", coverage = 100, thickness = 4.0 },
                },
                coverage = 95,
            },
        },
    },
}

ccb.content.define_item {
    id = "lowtops",
    name = ccb.content.plural_text("lowtop tennis shoes (pair)", "lowtop tennis shoes (pair)"),
    description = ccb.content.text("Lightweight shoes made of cloth and rubber."),
    mass = "114 g",
    volume = "750 ml",
    price = "15 USD",
    survival_price = "2 USD 50 cent",
    symbol = "[",
    looks_like = "sneakers",
    color = "dark_gray",
    flags = { "VARSIZE", "WATER_FRIENDLY" },
    armor = {
        warmth = 5,
        thickness = 1.5,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_heel_r",
                    "foot_heel_l",
                    "foot_arch_r",
                    "foot_arch_l",
                    "foot_toes_r",
                    "foot_toes_l",
                },
                materials = { { id = "cotton", coverage = 100, thickness = 1.5 } },
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_r", "foot_ankle_l" },
                materials = { { id = "cotton", coverage = 100, thickness = 1.5 } },
                coverage = 10,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 0.1 },
                    { id = "rubber", coverage = 100, thickness = 4.0 },
                },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "mocassins",
    name = ccb.content.plural_text("moccasins (pair)", "moccasins (pair)"),
    description = ccb.content.text("A type of traditional Native American footwear sewn out of prepared leather or pelts."),
    mass = "230 g",
    volume = "500 ml",
    price = "50 USD",
    survival_price = "2 USD 50 cent",
    materials = { "fur", "leather" },
    symbol = "[",
    looks_like = "leathersandals",
    color = "brown",
    flags = { "VARSIZE", "WATERPROOF" },
    armor = {
        warmth = 20,
        thickness = 1.0,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_toes_r", "foot_toes_l" },
                materials = { { id = "leather", coverage = 100, thickness = 1.0 } },
                encumbrance = 2,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_heel_r", "foot_heel_l", "foot_arch_r", "foot_arch_l" },
                materials = { { id = "leather", coverage = 100, thickness = 1.0 } },
                coverage = 80,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = { { id = "leather", coverage = 100, thickness = 4.0 } },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "motorbike_boots",
    category = "armor",
    name = ccb.content.plural_text("motorcycle boots (pair)", "motorcycle boots (pair)"),
    description = ccb.content.text("A pair of durable boots used by dirt bikers and motorcyclists."),
    mass = "1800 g",
    volume = "2 L",
    price = "80 USD",
    survival_price = "7 USD 50 cent",
    materials = { "kevlar", "cotton" },
    symbol = "[",
    looks_like = "boots_steel",
    color = "dark_gray",
    flags = { "VARSIZE", "WATERPROOF" },
    melee_damage = { bash = 5 },
    armor = {
        warmth = 35,
        thickness = 2.5,
        environmental_protection = 3,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 0.1 },
                    { id = "rubber", coverage = 100, thickness = 6.0 },
                },
                coverage = 100,
                encumbrance = 30,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_heel_r", "foot_heel_l", "foot_arch_r", "foot_arch_l", "foot_toes_r",
                    "foot_toes_l", "foot_ankle_l", "foot_ankle_r",
                },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 1.25 },
                    { id = "kevlar", coverage = 100, thickness = 1.25 },
                },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "roller_blades",
    name = ccb.content.plural_text("rollerblades (pair)", "rollerblades (pair)"),
    description = ccb.content.text("A pair of inline skates.  Very fast on flat floors, but they make it hard to move on rough terrain, take hits, or dodge effectively."),
    mass = "1640 g",
    volume = "3750 ml",
    price = "85 USD",
    survival_price = "25 USD",
    materials = { "plastic", "cotton" },
    symbol = "[",
    looks_like = "rollerskates",
    color = "light_gray",
    flags = { "VARSIZE", "WATERPROOF", "ROLLER_INLINE", "REQUIRES_BALANCE" },
    armor = {
        warmth = 20,
        thickness = 3,
        environmental_protection = 2,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_heel_r", "foot_heel_l", "foot_arch_r", "foot_arch_l", "foot_toes_r",
                    "foot_toes_l", "foot_ankle_r", "foot_ankle_l",
                },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 1.5 },
                    { id = "plastic", coverage = 95, thickness = 1.5 },
                },
                encumbrance = 25,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 0.1 },
                    { id = "plastic", coverage = 100, thickness = 2.0 },
                },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "rollerskates",
    name = ccb.content.plural_text("rollerskates (pair)", "rollerskates (pair)"),
    description = ccb.content.text("An old-fashioned pair of leather rollerskates with steel frames.  While quite fast on flat floors, they make it difficult to take hits or to move on rough terrain."),
    mass = "2720 g",
    volume = "3 L",
    price = "85 USD",
    survival_price = "15 USD",
    materials = { "leather", "steel" },
    symbol = "[",
    looks_like = "roller_blades",
    color = "brown",
    flags = { "VARSIZE", "WATERPROOF", "ROLLER_QUAD", "REQUIRES_BALANCE" },
    melee_damage = { bash = 6 },
    armor = {
        warmth = 30,
        thickness = 3,
        environmental_protection = 2,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_heel_r", "foot_heel_l", "foot_arch_r", "foot_arch_l", "foot_toes_r",
                    "foot_toes_l", "foot_ankle_r", "foot_ankle_l",
                },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 1.5 },
                    { id = "leather", coverage = 100, thickness = 1.5 },
                },
                encumbrance = 25,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 0.1 },
                    { id = "wood", coverage = 90, thickness = 4.0 },
                    { id = "steel", coverage = 20, thickness = 2.0 },
                },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "shoes_birchbark",
    name = ccb.content.plural_text("birchbark shoes (pair)", "birchbark shoes (pair)"),
    description = ccb.content.text("Simple shoes woven from strips of birch bark.  Not very comfortable, but better than going barefoot."),
    mass = "345 g",
    volume = "500 ml",
    price = "35 USD",
    survival_price = "50 cent",
    materials = { "wood" },
    symbol = "[",
    looks_like = "clogs",
    color = "light_gray",
    flags = { "VARSIZE" },
    armor = {
        warmth = 10,
        thickness = 1.0,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_toes_r", "foot_toes_l" },
                materials = { { id = "wood", coverage = 100, thickness = 1.0 } },
                encumbrance = 15,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_heel_r", "foot_heel_l", "foot_arch_r", "foot_arch_l" },
                materials = { { id = "wood", coverage = 100, thickness = 1.0 } },
                coverage = 80,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = { { id = "wood", coverage = 100, thickness = 1.0 } },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "shoes_bowling",
    name = ccb.content.plural_text("bowling shoes (pair)", "bowling shoes (pair)"),
    description = ccb.content.text("A pair of flat-soled shoes designed to give you a grip on slippery surfaces."),
    mass = "840 g",
    volume = "1500 ml",
    price = "40 USD",
    survival_price = "2 USD 50 cent",
    materials = { "cotton", "leather" },
    symbol = "[",
    looks_like = "dress_shoes",
    color = "light_blue",
    flags = { "VARSIZE" },
    armor = {
        warmth = 20,
        thickness = 2,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_heel_r",
                    "foot_heel_l",
                    "foot_arch_r",
                    "foot_arch_l",
                    "foot_toes_r",
                    "foot_toes_l",
                },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 1 },
                    { id = "leather", coverage = 100, thickness = 1 },
                },
                encumbrance = 10,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_r", "foot_ankle_l" },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 1.0 },
                    { id = "leather", coverage = 100, thickness = 1 },
                },
                coverage = 20,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 0.1 },
                    { id = "rubber", coverage = 100, thickness = 3.0 },
                },
                coverage = 100,
            },
        },
    },
}

-- Denim part is 10 oz.
ccb.content.define_item {
    id = "shoes_denim",
    name = ccb.content.plural_text("denim sneakers (pair)", "denim sneakers (pair)"),
    description = ccb.content.text("A pair of denim shoes.  They are cool and that's about it."),
    mass = "340 g",
    volume = "1500 ml",
    price = "50 USD",
    survival_price = "3 USD 50 cent",
    materials = { "rubber", "cotton", "denim" },
    symbol = "[",
    color = "light_blue",
    looks_like = "sneakers",
    flags = { "VARSIZE" },
    armor = {
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_heel_r",
                    "foot_heel_l",
                    "foot_arch_r",
                    "foot_arch_l",
                    "foot_toes_r",
                    "foot_toes_l",
                },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 0.5 },
                    { id = "denim", coverage = 100, thickness = 0.65 },
                },
                encumbrance = 5,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_r", "foot_ankle_l" },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 0.5 },
                    { id = "denim", coverage = 100, thickness = 0.65 },
                },
                coverage = 60,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 0.1 },
                    { id = "rubber", coverage = 100, thickness = 3.0 },
                },
                coverage = 100,
            },
        },
        warmth = 25,
    },
}

ccb.content.define_item {
    id = "slippers",
    name = ccb.content.plural_text("slippers (pair)", "slippers (pair)"),
    description = ccb.content.text("Soft shoes that keep your feet warm.  Not suitable for running."),
    mass = "70 g",
    volume = "250 ml",
    price = "6 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "socks_wool",
    color = "brown",
    flags = { "VARSIZE" },
    armor = {
        warmth = 25,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_toes_r", "foot_toes_l" },
                materials = { { id = "cotton", coverage = 100, thickness = 0.5 } },
                encumbrance = 30,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_arch_r", "foot_arch_l" },
                materials = { { id = "cotton", coverage = 100, thickness = 0.5 } },
                coverage = 90,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_heel_r", "foot_heel_l" },
                materials = { { id = "cotton", coverage = 100, thickness = 0.5 } },
                coverage = 10,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 1.5 },
                    { id = "rubber", coverage = 100, thickness = 2.0 },
                },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "sneakers",
    name = ccb.content.plural_text("sneakers (pair)", "sneakers (pair)"),
    description = ccb.content.text("Guaranteed to make you run faster and jump higher!"),
    mass = "454 g",
    volume = "1500 ml",
    price = "100 USD",
    survival_price = "2 USD 50 cent",
    materials = { "cotton", "rubber" },
    symbol = "[",
    looks_like = "shoes_bowling",
    color = "light_blue",
    flags = { "VARSIZE" },
    armor = {
        warmth = 20,
        thickness = 1,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_heel_r",
                    "foot_heel_l",
                    "foot_arch_r",
                    "foot_arch_l",
                    "foot_toes_r",
                    "foot_toes_l",
                },
                materials = { { id = "cotton", coverage = 100, thickness = 1 } },
                encumbrance = 4,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_r", "foot_ankle_l" },
                materials = { { id = "cotton", coverage = 100, thickness = 1.0 } },
                coverage = 60,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "cotton", coverage = 100, thickness = 0.1 },
                    { id = "rubber", coverage = 100, thickness = 4.0 },
                },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "straw_sandals",
    name = ccb.content.plural_text("straw sandals (pair)", "straw sandals (pair)"),
    description = ccb.content.text("Sandals made from straw rope.  Not very comfortable, but can keep your feet safe."),
    mass = "70 g",
    volume = "500 ml",
    price = "20 USD",
    survival_price = "50 cent",
    symbol = "[",
    looks_like = "leathersandals",
    color = "light_gray",
    flags = { "VARSIZE", "WATER_FRIENDLY", "ALLOWS_NATURAL_ATTACKS", "ALLOWS_TALONS" },
    armor = {
        thickness = 1,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_ankle_r", "foot_ankle_l", "foot_heel_r",
                    "foot_heel_l", "foot_arch_r", "foot_arch_l",
                },
                materials = { { id = "paper", coverage = 100, thickness = 1.0 } },
                encumbrance = 10,
                coverage = 30,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = { { id = "paper", coverage = 100, thickness = 1.0 } },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "thigh_high_boots",
    name = ccb.content.plural_text("thigh-high boots (pair)", "thigh-high boots (pair)"),
    description = ccb.content.text("Very long leather boots that reach past the knees, they are cumbersome to wear."),
    mass = "1540 g",
    volume = "4250 ml",
    price = "80 USD",
    survival_price = "5 USD",
    accuracy = { grip = "none", length = "short", surface = "any", balance = "clumsy" },
    materials = { "leather" },
    symbol = "[",
    looks_like = "boots_larmor",
    color = "dark_gray",
    flags = { "VARSIZE", "WATERPROOF" },
    melee_damage = { bash = 1 },
    armor = {
        warmth = 20,
        thickness = 2,
        environmental_protection = 2,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_heel_r", "foot_heel_l", "foot_arch_r", "foot_arch_l", "foot_toes_r",
                    "foot_toes_l", "foot_ankle_r", "foot_ankle_l",
                },
                materials = { { id = "leather", coverage = 100, thickness = 2 } },
                encumbrance = 20,
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
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_lower_l", "leg_lower_r", "leg_knee_l", "leg_knee_r" },
                coverage = 100,
                encumbrance = 20,
            },
            {
                encumbrance = 0,
                coverage = 50,
                covers = { "leg_r", "leg_l" },
                subparts = { "leg_upper_l", "leg_upper_r" },
            },
        },
    },
}
