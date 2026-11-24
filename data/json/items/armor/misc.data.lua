local ccb = require("ccb")

ccb.content.define_item {
    id = "clown_wig",
    name = ccb.content.text("clown wig"),
    description = ccb.content.text("A colorful and ridiculous wig fit for a clown."),
    mass = "125 g",
    volume = "1 L",
    price = "25 USD",
    survival_price = "10 cent",
    materials = { "cotton" },
    symbol = "[",
    color = "pink",
    flags = { "VARSIZE" },
    armor = {
        warmth = 20,
        thickness = 0.2,
        environmental_protection = 1,
        portions = { { encumbrance = 5, coverage = 60, covers = { "head" } } },
    },
}

ccb.content.define_item {
    id = "clown_nose",
    name = ccb.content.plural_text("clown nose", "clown noses"),
    description = ccb.content.text("A red latex nose often worn by clowns.  Squeezing the nose makes it honk."),
    mass = "100 g",
    volume = "100 ml",
    price = "8 USD",
    survival_price = "10 cent",
    materials = { "plastic" },
    symbol = ".",
    color = "red",
    armor = {},
    use_actions = {
        {
            kind = "manualnoise",
            message = ccb.content.text("You honk the clown nose."),
            sound_message = ccb.content.text("Honk!"),
            sound_id = "misc",
            sound_variant = "default",
            volume = 10,
            moves = 100,
        },
    },
}

ccb.content.define_item {
    id = "crown_golden",
    name = ccb.content.text("golden crown"),
    description = ccb.content.text("A delicate golden crown featuring flowering trees."),
    mass = "1000 g",
    volume = "1 L",
    price = "300 USD",
    survival_price = "1 USD",
    materials = { "gold" },
    symbol = "[",
    looks_like = "hat_cotton",
    color = "yellow",
    armor = { thickness = 2, portions = { { encumbrance = 20, coverage = 30, covers = { "head" } } } },
}

ccb.content.define_item {
    id = "crown_golden_survivor",
    name = ccb.content.text("golden crown"),
    description = ccb.content.text("A golden crown for the monarch of survivors."),
    mass = "1000 g",
    volume = "1 L",
    price = "300 USD",
    survival_price = "1 USD 50 cent",
    materials = { "gold" },
    symbol = "[",
    looks_like = "crown_golden",
    color = "yellow",
    armor = { thickness = 2, portions = { { encumbrance = 20, coverage = 30, covers = { "head" } } } },
}

ccb.content.define_item {
    id = "mouthpiece",
    category = "armor",
    name = ccb.content.text("protective mouthpiece"),
    description = ccb.content.text("A protective piece of equipment commonly used by athletes, worn inside the mouth to protect your teeth."),
    mass = "20 g",
    volume = "430 ml",
    price = "8 USD",
    survival_price = "50 cent",
    materials = { "plastic" },
    symbol = "[",
    color = "yellow",
    flags = { "VARSIZE", "STURDY", "WATER_FRIENDLY", "SKINTIGHT", "POWERARMOR_COMPATIBLE", "PADDED" },
    melee_damage = { bash = 2 },
    armor = { thickness = 1, portions = { { coverage = 50, covers = { "mouth" }, rigid_only = true } } },
}

ccb.content.define_item {
    id = "tie_skinny",
    name = ccb.content.text("skinny tie"),
    description = ccb.content.text("A skinny black and white checkered necktie."),
    mass = "12 g",
    volume = "50 ml",
    price = "7 USD 50 cent",
    survival_price = "10 cent",
    materials = { "cotton" },
    symbol = "[",
    color = "dark_gray",
    armor = {},
}

ccb.content.define_item {
    id = "sleeping_bag_roll",
    copy_from = "sleeping_bag",
    name = ccb.content.plural_text("rolled sleeping bag", "rolled sleeping bags"),
    description = ccb.content.text("A large sleeping bag that covers you head to toe, with a strap for carrying it on your back when not in use.  This one is medium weight.  Activate it to unroll it so you can use it for warmth."),
    looks_like = "sleeping_bag",
    flags = { "OVERSIZE", "BELTED" },
    armor = {
        thickness = 4,
        portions = {
            {
                encumbrance = 4,
                coverage = 20,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Unroll"),
            target = "sleeping_bag",
            message = ccb.content.text("You unroll the sleeping bag."),
        },
    },
}

ccb.content.define_item {
    id = "sleeping_bag_fur",
    name = ccb.content.plural_text("fur sleeping bag", "fur sleeping bags"),
    description = ccb.content.text("A large sleeping bag lined with fur, with a strap for carrying it on your back when not in use.  Who needs a tent?  It is currently unrolled; activate it roll it up for easy storage."),
    mass = "1175 g",
    volume = "2 L",
    price = "325 USD",
    survival_price = "20 USD",
    materials = { "cotton", "fur" },
    symbol = "[",
    looks_like = "sleeping_bag",
    color = "brown",
    flags = { "OVERSIZE", "OUTER" },
    armor = {
        warmth = 100,
        thickness = 5,
        environmental_protection = 1,
        portions = {
            {
                encumbrance = 80,
                coverage = 100,
                covers = {
                    "torso",
                    "head",
                    "mouth",
                    "arm_l",
                    "arm_r",
                    "hand_l",
                    "hand_r",
                    "leg_l",
                    "leg_r",
                    "foot_l",
                    "foot_r",
                },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Roll up"),
            target = "sleeping_bag_fur_roll",
            message = ccb.content.text("You roll up the sleeping bag, preparing it for transport."),
        },
    },
}

ccb.content.define_item {
    id = "sleeping_bag_fur_roll",
    copy_from = "sleeping_bag_fur",
    name = ccb.content.plural_text("rolled fur sleeping bag", "rolled fur sleeping bags"),
    description = ccb.content.text("A large sleeping bag lined with fur, with a strap for carrying it on your back when not in use.  Who needs a tent?  Activate it to unroll it so you can use it for warmth."),
    looks_like = "sleeping_bag_roll",
    flags = { "OVERSIZE", "BELTED" },
    armor = {
        portions = {
            {
                encumbrance = 5,
                coverage = 20,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Unroll"),
            target = "sleeping_bag_fur",
            message = ccb.content.text("You unroll the sleeping bag."),
        },
    },
}

ccb.content.define_item {
    id = "tie_bow",
    name = ccb.content.text("bow tie"),
    description = ccb.content.text("A simple black bow tie.  Best worn with a suit."),
    mass = "250 mg",
    volume = "5 ml",
    price = "10 USD",
    survival_price = "10 cent",
    materials = { "cotton" },
    symbol = "[",
    color = "dark_gray",
    armor = {},
}

ccb.content.define_item {
    id = "tie_clipon",
    name = ccb.content.text("clip-on tie"),
    description = ccb.content.text("A clip-on necktie with blue and silver stripes.  It's quick and easy to put on, and really, who's going to know the difference?"),
    mass = "10 g",
    volume = "20 ml",
    price = "5 USD",
    survival_price = "10 cent",
    materials = { "cotton" },
    symbol = "[",
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "tie_necktie",
    name = ccb.content.text("necktie"),
    description = ccb.content.text("An ordinary green necktie.  Knowing how to properly tie it takes some practice, but it's an important skill to learn.  Clip-ons are for children."),
    mass = "750 mg",
    volume = "25 ml",
    price = "10 USD",
    survival_price = "10 cent",
    materials = { "cotton" },
    symbol = "[",
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "vampire_fangs",
    name = ccb.content.plural_text("vampire fangs", "vampire fangs"),
    description = ccb.content.text("A pair of white vampire fangs made of plastic."),
    mass = "23 g",
    volume = "250 ml",
    price = "5 USD",
    survival_price = "10 cent",
    materials = { "plastic" },
    symbol = "[",
    looks_like = "mouthpiece",
    color = "white",
    flags = { "SKINTIGHT", "NO_WEAR_EFFECT" },
    armor = { thickness = 0.01, portions = { { encumbrance = 5, coverage = 10, covers = { "mouth" } } } },
}

ccb.content.define_item {
    id = "veil_wedding",
    name = ccb.content.text("wedding veil"),
    description = ccb.content.text("A lacy white wedding veil."),
    mass = "78 g",
    volume = "750 ml",
    price = "80 USD",
    survival_price = "10 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "scarf",
    color = "white",
    flags = { "OUTER", "OVERSIZE" },
    armor = {
        thickness = 0.01,
        environmental_protection = 1,
        portions = { { encumbrance = 5, coverage = 100, covers = { "eyes", "mouth" } } },
    },
}

ccb.content.define_item {
    id = "tarp",
    name = ccb.content.text("tarpaulin"),
    description = ccb.content.text("A plastic sheet with several grommets for securing it with rope or cord.  Useful for improvised rain protection."),
    mass = "1244 g",
    volume = "2 L",
    price = "50 USD",
    survival_price = "1 USD",
    materials = { "plastic" },
    symbol = "[",
    looks_like = "blanket",
    color = "light_blue",
    flags = { "OVERSIZE", "OUTER", "WATERPROOF", "ALLOWS_NATURAL_ATTACKS" },
    armor = {
        warmth = 10,
        thickness = 0.1,
        environmental_protection = 1,
        portions = {
            {
                encumbrance = 30,
                coverage = 90,
                covers = {
                    "torso",
                    "arm_l",
                    "arm_r",
                    "hand_l",
                    "hand_r",
                    "leg_l",
                    "leg_r",
                    "foot_l",
                    "foot_r",
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "tefillin_hand_l",
    name = ccb.content.plural_text("tefillin (left arm)", "sets of tefillin (left arm)"),
    description = ccb.content.text("A set of leather straps attached to a wooden box, to fulfill the commandment written in Deuteronomy that states \"And you shall set these words of Mine upon your heart and upon your soul, and bind them for a sign upon your hand and they shall be for ornaments between your eyes.\"  This one is for the left arm."),
    mass = "250 g",
    volume = "250 ml",
    price = "64 USD",
    survival_price = "2 USD 50 cent",
    materials = { "leather" },
    symbol = "[",
    color = "light_gray",
    flags = { "OVERSIZE", "RESTRICT_HANDS", "ALLOWS_NATURAL_ATTACKS" },
    armor = {
        warmth = 0,
        thickness = 1.0,
        environmental_protection = 0,
        portions = { { encumbrance = 15, coverage = 10, covers = { "hand_l", "arm_l" } } },
    },
}

ccb.content.define_item {
    id = "tefillin_hand_r",
    name = ccb.content.plural_text("tefillin (right arm)", "sets of tefillin (right arm)"),
    description = ccb.content.text("A set of leather straps attached to a wooden box, to fulfill the commandment written in Deuteronomy that states \"And you shall set these words of Mine upon your heart and upon your soul, and bind them for a sign upon your hand and they shall be for ornaments between your eyes.\"  This one is for the right arm."),
    mass = "250 g",
    volume = "250 ml",
    price = "64 USD",
    survival_price = "2 USD 50 cent",
    materials = { "leather" },
    symbol = "[",
    color = "light_gray",
    flags = { "OVERSIZE", "RESTRICT_HANDS", "ALLOWS_NATURAL_ATTACKS" },
    armor = {
        warmth = 0,
        thickness = 1.0,
        environmental_protection = 0,
        portions = { { encumbrance = 15, coverage = 10, covers = { "hand_l", "arm_l" } } },
    },
}

ccb.content.define_item {
    id = "tefillin_head",
    name = ccb.content.plural_text("tefillin (head)", "sets of tefillin (head)"),
    description = ccb.content.text("A set of leather straps attached to a wooden box, to fulfill the commandment written in Deuteronomy that states \"And you shall set these words of Mine upon your heart and upon your soul, and bind them for a sign upon your hand and they shall be for ornaments between your eyes.\"  This one is for the forehead."),
    mass = "200 g",
    volume = "250 ml",
    price = "64 USD",
    survival_price = "2 USD 50 cent",
    materials = { "leather" },
    symbol = "[",
    color = "light_gray",
    armor = {
        warmth = 0,
        thickness = 1.0,
        environmental_protection = 0,
        portions = { { encumbrance = 15, coverage = 10, covers = { "head" } } },
    },
}

ccb.content.define_item {
    id = "bostonchan_wig",
    name = ccb.content.text("Boston-Chan wig"),
    description = ccb.content.text("A long blue hair wig for the Boston-Chan costume."),
    mass = "125 g",
    volume = "750 ml",
    price = "25 USD",
    survival_price = "10 cent",
    materials = { "cotton" },
    symbol = "[",
    color = "blue",
    flags = { "VARSIZE" },
    armor = {
        warmth = 10,
        thickness = 0.2,
        environmental_protection = 1,
        portions = { { encumbrance = 5, coverage = 60, covers = { "head" } } },
    },
}

-- inherit name from item
-- dog tags are roughly 50mm x 28mm x 0.4mm, or 0.56 ml, but that's so small I needed to round up to 1 ml
ccb.content.define_item {
    id = "dog_tag",
    name = ccb.content.plural_text("dog tag", "dog tag"),
    description = ccb.content.text("Two oval disks attached to a chain, worn by military personnel for identification."),
    variants = {
        {
            id = "dog_tag_id",
            description = ccb.content.text("They have inscribed:\n<family_name>\n<given_name_army>\n<number><number><number><number><number><number><number><number><number><number>\n<blood_type_caps>\n<religion_caps>"),
            expand_snippets = true,
            append = true,
            weight = 1,
        },
    },
    mass = "5 g",
    volume = "1 ml",
    price = "10 cent",
    survival_price = "1 cent",
    materials = { "steel" },
    symbol = "[",
    color = "light_gray",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}
