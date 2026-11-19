local ccb = require("ccb")

ccb.content.define_item {
    id = "arm_warmers",
    name = ccb.content.plural_text("arm warmers (pair)", "arm warmers (pair)"),
    description = ccb.content.text("Snug, soft cloth sleeves to keep your arms warm."),
    mass = "32 g",
    volume = "250 ml",
    price = "10 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "armguard_larmor",
    color = "light_gray",
    faults = { { group = "fabric_cotton" } },
    flags = { "SKINTIGHT" },
    armor = {
        warmth = 20,
        thickness = 0.5,
        portions = {
            {
                encumbrance = 1,
                coverage = 100,
                covers = { "arm_l", "arm_r" },
                subparts = {
                    "arm_lower_l",
                    "arm_lower_r",
                    "arm_elbow_l",
                    "arm_elbow_r",
                    "arm_upper_l",
                    "arm_upper_r",
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_arm_warmers",
    name = ccb.content.plural_text("arm warmers (pair)", "arm warmers (pair)"),
    mass = "49 g",
    volume = "350 ml",
    copy_from = "arm_warmers",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } } },
}

ccb.content.define_item {
    id = "xs_arm_warmers",
    copy_from = "arm_warmers",
    name = ccb.content.plural_text("arm warmers (pair)", "arm warmers (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "bellyband",
    name = ccb.content.text("belly band"),
    description = ccb.content.text("A piece of clothing designed to be worn around the belly, called Haramaki in Japan.  This one is made from wool, comfortable and warm."),
    mass = "150 g",
    volume = "750 ml",
    looks_like = "chestwrap",
    price = "7 USD",
    survival_price = "50 cent",
    materials = { "wool" },
    symbol = "[",
    color = "blue",
    flags = { "SKINTIGHT", "OVERSIZE" },
    armor = {
        warmth = 10,
        thickness = 0.2,
        portions = { { coverage = 100, covers = { "torso" }, subparts = { "torso_lower" } } },
    },
}

ccb.content.define_item {
    id = "bellywrap",
    name = ccb.content.text("belly wrap"),
    description = ccb.content.text("Rags wrapped around the belly.  Usually worn in combination with a chestwrap.  Provides negligible protection against punches to your stomach."),
    mass = "120 g",
    volume = "500 ml",
    looks_like = "bellyband",
    price = "7 USD",
    survival_price = "10 cent",
    materials = { "cotton" },
    symbol = "[",
    color = "white",
    flags = { "SKINTIGHT", "OVERSIZE" },
    armor = {
        warmth = 3,
        thickness = 0.2,
        portions = { { coverage = 100, covers = { "torso" }, subparts = { "torso_lower" } } },
    },
}

ccb.content.define_item {
    id = "bellywrap_fur",
    name = ccb.content.text("fur belly wrap"),
    description = ccb.content.text("Fur pelts wrapped around the belly.  Usually worn in combination with a chestwrap.  Provides negligible protection against punches to your stomach."),
    copy_from = "bellywrap",
    mass = "1104 g",
    volume = "750 ml",
    price = "7 USD",
    materials = { "fur" },
    color = "brown",
    armor = {
        warmth = 12,
        thickness = 0.2,
        portions = { { encumbrance = 5, coverage = 100, covers = { "torso" }, subparts = { "torso_lower" } } },
    },
}

ccb.content.define_item {
    id = "bellywrap_leather",
    name = ccb.content.text("leather belly wrap"),
    description = ccb.content.text("Leather patches wrapped around the belly.  Usually worn in combination with a chestwrap.  Provides weak protection against punches to your stomach."),
    copy_from = "bellywrap",
    mass = "888 g",
    volume = "750 ml",
    price = "5 USD 25 cent",
    materials = { "leather" },
    color = "brown",
    armor = {
        warmth = 6,
        thickness = 0.5,
        portions = { { encumbrance = 5, coverage = 100, covers = { "torso" }, subparts = { "torso_lower" } } },
    },
}

ccb.content.define_item {
    id = "bellywrap_wool",
    name = ccb.content.text("wool belly wrap"),
    description = ccb.content.text("Felt patches wrapped around the belly.  Usually worn in combination with a chestwrap.  Provides negligible protection against punches to your stomach."),
    copy_from = "bellywrap",
    price = "5 USD",
    materials = { "wool" },
    color = "blue",
    armor = {
        warmth = 8,
        thickness = 0.2,
        portions = { { encumbrance = 5, coverage = 100, covers = { "torso" }, subparts = { "torso_lower" } } },
    },
}

ccb.content.define_item {
    id = "bikini_top_fur",
    name = ccb.content.text("fur bikini top"),
    description = ccb.content.text("A simple fur bikini top."),
    mass = "200 g",
    volume = "250 ml",
    price = "49 USD",
    survival_price = "1 USD",
    materials = { "fur" },
    symbol = "[",
    looks_like = "bikini_top",
    color = "brown",
    flags = { "VARSIZE", "SKINTIGHT" },
    armor = {
        warmth = 10,
        thickness = 0.5,
        portions = { { coverage = 20, covers = { "torso" }, subparts = { "torso_upper" } } },
    },
}

ccb.content.define_item {
    id = "bikini_top_leather",
    name = ccb.content.text("leather bikini top"),
    description = ccb.content.text("A simple leather bikini top."),
    mass = "200 g",
    volume = "250 ml",
    price = "35 USD",
    survival_price = "50 cent",
    materials = { "leather" },
    symbol = "[",
    looks_like = "bikini_top",
    color = "dark_gray",
    flags = { "VARSIZE", "SKINTIGHT" },
    armor = {
        warmth = 5,
        thickness = 0.5,
        portions = { { coverage = 20, covers = { "torso" }, subparts = { "torso_upper" } } },
    },
}

ccb.content.define_item {
    id = "binder_top",
    name = ccb.content.text("binder"),
    description = ccb.content.text("A binder, meant to bind the chest close to the body to keep a persons chest flat."),
    mass = "110 g",
    volume = "250 ml",
    price = "35 USD",
    survival_price = "1 USD 50 cent",
    materials = { "lycra", "cotton" },
    symbol = "[",
    looks_like = "bikini_top",
    color = "dark_gray",
    flags = { "SKINTIGHT" },
    variant_kind = "generic",
    variants = {
        {
            id = "binder_top_black",
            name = ccb.content.text("black binder"),
            description = ccb.content.text("This one is black."),
            weight = 140,
            append = true,
        },
        {
            id = "binder_top_gray",
            name = ccb.content.text("gray binder"),
            description = ccb.content.text("This one is gray."),
            weight = 90,
            append = true,
        },
        {
            id = "binder_top_white",
            name = ccb.content.text("white binder"),
            description = ccb.content.text("This one is white."),
            weight = 70,
            append = true,
        },
        {
            id = "binder_top_blue",
            name = ccb.content.text("blue binder"),
            description = ccb.content.text("This one is blue."),
            weight = 25,
            append = true,
        },
        {
            id = "binder_top_green",
            name = ccb.content.text("green binder"),
            description = ccb.content.text("This one is green."),
            weight = 25,
            append = true,
        },
        {
            id = "binder_top_red",
            name = ccb.content.text("red binder"),
            description = ccb.content.text("This one is red."),
            weight = 12,
            append = true,
        },
        {
            id = "binder_top_orange",
            name = ccb.content.text("orange binder"),
            description = ccb.content.text("This one is orange."),
            weight = 12,
            append = true,
        },
        {
            id = "binder_top_pink",
            name = ccb.content.text("pink binder"),
            description = ccb.content.text("This one is pink."),
            weight = 4,
            append = true,
        },
        {
            id = "binder_top_american",
            name = ccb.content.text("American binder"),
            description = ccb.content.text("This one is painted with the star spangled banner, the red white and blue, old glory, the American flag."),
            append = true,
        },
        {
            id = "binder_top_ribcage",
            name = ccb.content.text("ribcage binder"),
            description = ccb.content.text("This one is black, with white rib bones."),
            weight = 12,
            append = true,
        },
        {
            id = "binder_top_mushroom",
            name = ccb.content.text("mushroom binder"),
            description = ccb.content.text("This one has a row of mushrooms on it."),
            weight = 10,
            append = true,
        },
        {
            id = "binder_top_floral",
            name = ccb.content.text("floral binder"),
            description = ccb.content.text("This one has a floral pattern."),
            weight = 10,
            append = true,
        },
        {
            id = "binder_top_dinos",
            name = ccb.content.text("dinosaur binder"),
            description = ccb.content.text("This one has a cartoon rendition of a stegosaurus on it."),
            weight = 8,
            append = true,
        },
        {
            id = "binder_top_meme",
            name = ccb.content.text("meme binder"),
            description = ccb.content.text("This one has an image of a stuffed rat chef, looking up with arms spread to the heavens, with text above reading \"I don't want to cook anymore\", and the bottom text reading \"I want to DIE\" all in a comic sans font."),
            weight = 4,
            append = true,
        },
    },
    armor = {
        warmth = 5,
        thickness = 0.5,
        portions = { { encumbrance = 10, coverage = 20, covers = { "torso" }, subparts = { "torso_upper" } } },
    },
}

-- delete binder variants, this is survivor made
ccb.content.define_item {
    id = "xl_binder_top",
    copy_from = "binder_top",
    name = ccb.content.text("binder"),
    variants = {},
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.5, volume = 1.5, price = 1.25 },
    },
}

-- delete binder variants, this is survivor made
ccb.content.define_item {
    id = "xs_binder_top",
    copy_from = "binder_top",
    name = ccb.content.text("binder"),
    variants = {},
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- inherit name and description from item
ccb.content.define_item {
    id = "boxer_briefs",
    name = ccb.content.plural_text("boxer briefs", "boxer briefs"),
    description = ccb.content.text("The age-old question, boxers or briefs?  Your answer?  Yes."),
    mass = "37 g",
    volume = "250 ml",
    price = "10 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "shorts",
    color = "light_gray",
    faults = { { group = "fabric_cotton" } },
    flags = { "VARSIZE", "SKINTIGHT" },
    variants = {
        { id = "boxer_brief_basic", expand_snippets = true, weight = 100 },
        {
            id = "boxer_brief_makeshift",
            name = ccb.content.plural_text("homemade boxer briefs", "homemade boxer briefs"),
            description = ccb.content.text("A pair of homemade boxer briefs, a marvel of basic sewing skills."),
            expand_snippets = true,
            weight = 0,
        },
        {
            id = "boxer_brief_color",
            name = ccb.content.plural_text("solid boxer briefs", "solid boxer briefs"),
            description = ccb.content.text("A pair of boxer briefs, these are a solid <color> color."),
            expand_snippets = true,
            weight = 300,
        },
        {
            id = "boxer_brief_hearts",
            name = ccb.content.plural_text("heart boxer briefs", "heart boxer briefs"),
            description = ccb.content.text("A pair of boxer briefs, adorned with little <color> hearts."),
            expand_snippets = true,
            weight = 100,
        },
        {
            id = "boxer_brief_day",
            name = ccb.content.plural_text("day boxer briefs", "day boxer briefs"),
            description = ccb.content.text("A pair of boxer briefs.  Printed across the bottom, in bubble letters, is the word \"<day>.\""),
            expand_snippets = true,
            weight = 30,
        },
    },
    armor = {
        warmth = 5,
        thickness = 0.1,
        portions = {
            {
                coverage = 100,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
            },
        },
    },
}

-- delete boxer variants, this is survivor made
ccb.content.define_item {
    id = "xlboxer_briefs",
    name = ccb.content.plural_text("boxer briefs", "boxer briefs"),
    variants = {},
    mass = "50 g",
    volume = "350 ml",
    copy_from = "boxer_briefs",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } } },
}

-- delete boxer variants, this is survivor made
ccb.content.define_item {
    id = "xsboxer_briefs",
    copy_from = "boxer_briefs",
    name = ccb.content.plural_text("boxer briefs", "boxer briefs"),
    variants = {},
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- inherit name and description from item
ccb.content.define_item {
    id = "boxer_shorts",
    name = ccb.content.plural_text("boxer shorts", "boxer shorts"),
    description = ccb.content.text("Men's boxer shorts.  More fashionable than briefs and just as comfortable."),
    variant_kind = "generic",
    variants = {
        { id = "generic_boxer_shorts", weight = 30 },
        {
            id = "flag_boxer_shorts",
            name = ccb.content.plural_text("star-spangled boxer shorts", "star-spangled boxer shorts"),
            description = ccb.content.text("This pair has been printed with the pattern of an American flag, with stars and miniature eagles embroidered at strategic positions."),
            append = true,
            weight = 100,
        },
        {
            id = "boxer_shorts_makeshift",
            name = ccb.content.plural_text("homemade boxer shorts", "homemade boxer shorts"),
            description = ccb.content.text("A pair of homemade boxer shorts, a marvel of basic sewing skills."),
            expand_snippets = true,
            weight = 0,
        },
        {
            id = "boxer_shorts_color",
            name = ccb.content.plural_text("solid boxer shorts", "solid boxer shorts"),
            description = ccb.content.text("A pair of boxer shorts, these are a solid <color> color."),
            expand_snippets = true,
            weight = 400,
        },
        {
            id = "boxer_shorts_hearts",
            name = ccb.content.plural_text("heart boxer shorts", "heart boxer shorts"),
            description = ccb.content.text("A pair of boxer shorts, adorned with little <color> hearts."),
            expand_snippets = true,
            weight = 200,
        },
        {
            id = "boxer_shorts_day",
            name = ccb.content.plural_text("day boxer shorts", "day boxer shorts"),
            description = ccb.content.text("A pair of boxer shorts.  Printed across the bottom, in bubble letters, is the word \"<day>.\""),
            expand_snippets = true,
            weight = 30,
        },
        {
            id = "boxer_shorts_money",
            name = ccb.content.plural_text("money boxer shorts", "money boxer shorts"),
            description = ccb.content.text("A pair of boxer shorts adorned with images of hundred dollar bills."),
            expand_snippets = true,
            weight = 70,
        },
        {
            id = "boxer_shorts_animal",
            name = ccb.content.plural_text("animal boxer shorts", "animal boxer shorts"),
            description = ccb.content.text("A pair of boxer shorts, these are adorned with little <animals> in a pattern across the entire garment."),
            expand_snippets = true,
            weight = 70,
        },
        {
            id = "boxer_shorts_cartoon",
            name = ccb.content.plural_text("cartoon boxer shorts", "cartoon boxer shorts"),
            description = ccb.content.text("A pair of boxer shorts, merchandise for a famous cartoon.  It features <cartoon_blanket>."),
            expand_snippets = true,
            weight = 70,
        },
    },
    mass = "42 g",
    volume = "250 ml",
    price = "10 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "boxer_briefs",
    color = "light_gray",
    faults = { { group = "fabric_cotton" } },
    flags = { "VARSIZE", "SKINTIGHT" },
    armor = {
        warmth = 5,
        thickness = 0.1,
        portions = {
            {
                coverage = 100,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
            },
            {
                coverage = 20,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
            },
        },
    },
}

-- delete boxer variants, this is survivor made
ccb.content.define_item {
    id = "xlboxer_shorts",
    name = ccb.content.plural_text("boxer shorts", "boxer shorts"),
    variants = {},
    mass = "72 g",
    volume = "500 ml",
    copy_from = "boxer_shorts",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } } },
}

-- delete boxer variants, this is survivor made
ccb.content.define_item {
    id = "xsboxer_shorts",
    copy_from = "boxer_shorts",
    name = ccb.content.plural_text("boxer shorts", "boxer shorts"),
    variants = {},
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- inherit name and description from item
ccb.content.define_item {
    id = "boy_shorts",
    name = ccb.content.plural_text("boy shorts", "boy shorts"),
    description = ccb.content.text("Female underwear similar to men's boxer shorts, but much more close-fitting."),
    variant_kind = "generic",
    variants = {
        { id = "generic_boy_shorts", weight = 30 },
        {
            id = "flag_boy_shorts",
            name = ccb.content.plural_text("star-spangled boy shorts", "star-spangled boy shorts"),
            description = ccb.content.text("This pair has been printed with the pattern of an American flag, with stars and miniature eagles embroidered at strategic positions."),
            append = true,
        },
    },
    mass = "42 g",
    volume = "250 ml",
    price = "10 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "boxer_briefs",
    color = "light_gray",
    faults = { { group = "fabric_cotton" } },
    flags = { "VARSIZE", "SKINTIGHT" },
    armor = {
        warmth = 5,
        thickness = 0.1,
        portions = {
            {
                coverage = 100,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
            },
            {
                coverage = 20,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
            },
        },
    },
}

-- delete boy shorts variants, this is survivor made
ccb.content.define_item {
    id = "xlboy_shorts",
    name = ccb.content.plural_text("boy shorts", "boy shorts"),
    variants = {},
    mass = "72 g",
    volume = "500 ml",
    copy_from = "boy_shorts",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } } },
}

-- delete boy shorts variants, this is survivor made
ccb.content.define_item {
    id = "xsboy_shorts",
    copy_from = "boy_shorts",
    name = ccb.content.plural_text("boy shorts", "boy shorts"),
    variants = {},
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "bra",
    name = ccb.content.text("bra"),
    description = ccb.content.text("A simple bra.  For protecting those bits you don't want zombies to look at."),
    mass = "32 g",
    volume = "250 ml",
    price = "10 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "tank_top",
    color = "white",
    faults = { { group = "fabric_cotton" } },
    flags = { "VARSIZE", "SKINTIGHT" },
    armor = {
        warmth = 5,
        thickness = 0.1,
        portions = { { coverage = 25, covers = { "torso" }, subparts = { "torso_upper" } } },
    },
}

ccb.content.define_item {
    id = "xl_bra",
    copy_from = "bra",
    name = ccb.content.text("bra"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.5, volume = 1.5, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_bra",
    copy_from = "bra",
    name = ccb.content.text("bra"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "briefs",
    name = ccb.content.plural_text("briefs", "briefs"),
    description = ccb.content.text("A pair of briefs.  Comfortable underwear worn by men."),
    mass = "32 g",
    volume = "250 ml",
    price = "10 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "boxer_briefs",
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
    id = "camisole",
    name = ccb.content.text("camisole"),
    description = ccb.content.text("A small camisole made from silk.  Typically used as an undergarment, it is light and easy to wear."),
    mass = "42 g",
    volume = "500 ml",
    price = "20 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "tank_top",
    color = "light_blue",
    faults = { { group = "fabric_cotton" } },
    flags = { "VARSIZE", "SKINTIGHT" },
    armor = {
        thickness = 0.1,
        portions = {
            { covers = { "torso" }, subparts = { "torso_upper" }, coverage = 70 },
            { covers = { "torso" }, subparts = { "torso_lower" }, coverage = 100 },
        },
    },
}

ccb.content.define_item {
    id = "chestwrap",
    name = ccb.content.text("chestwrap"),
    description = ccb.content.text("Rags wrapped around the chest.  Preserves your modesty and keeps things out of the way, but not good for much else."),
    mass = "100 g",
    volume = "500 ml",
    price = "5 USD",
    survival_price = "10 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "tshirt",
    color = "white",
    faults = { { group = "fabric_cotton" } },
    flags = { "SKINTIGHT", "OVERSIZE" },
    armor = {
        warmth = 2,
        thickness = 0.2,
        portions = { { coverage = 40, covers = { "torso" }, subparts = { "torso_upper" } } },
    },
}

ccb.content.define_item {
    id = "chestwrap_fur",
    name = ccb.content.text("fur chestwrap"),
    description = ccb.content.text("Fur pelts wrapped around the chest.  Preserves your modesty and keeps things out of the way, but not good for much else."),
    mass = "372 g",
    volume = "750 ml",
    price = "7 USD",
    survival_price = "10 cent",
    materials = { "fur" },
    symbol = "[",
    looks_like = "chestwrap_leather",
    color = "brown",
    flags = { "SKINTIGHT", "OVERSIZE" },
    armor = {
        warmth = 10,
        thickness = 0.2,
        portions = { { encumbrance = 5, coverage = 40, covers = { "torso" }, subparts = { "torso_upper" } } },
    },
}

ccb.content.define_item {
    id = "chestwrap_leather",
    name = ccb.content.text("leather chestwrap"),
    description = ccb.content.text("Leather patches wrapped around the chest.  Preserves your modesty and keeps things out of the way, but not good for much else."),
    mass = "296 g",
    volume = "750 ml",
    price = "5 USD 25 cent",
    survival_price = "10 cent",
    materials = { "leather" },
    symbol = "[",
    looks_like = "chestwrap",
    color = "brown",
    flags = { "SKINTIGHT", "OVERSIZE" },
    armor = {
        warmth = 5,
        thickness = 0.5,
        portions = { { encumbrance = 5, coverage = 40, covers = { "torso" }, subparts = { "torso_upper" } } },
    },
}

ccb.content.define_item {
    id = "chestwrap_wool",
    name = ccb.content.text("wool chestwrap"),
    description = ccb.content.text("Felt patches wrapped around the chest.  Preserves your modesty and keeps things out of the way, but not good for much else."),
    mass = "110 g",
    volume = "500 ml",
    price = "5 USD",
    survival_price = "10 cent",
    materials = { "wool" },
    symbol = "[",
    looks_like = "chestwrap",
    color = "blue",
    flags = { "SKINTIGHT", "OVERSIZE" },
    armor = {
        warmth = 7,
        thickness = 0.2,
        portions = { { encumbrance = 5, coverage = 40, covers = { "torso" }, subparts = { "torso_upper" } } },
    },
}
