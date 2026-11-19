local ccb = require("ccb")

ccb.content.define_item {
    id = "bunker_coat",
    category = "armor",
    name = ccb.content.text("turnout coat"),
    description = ccb.content.text("A heavy protective coat worn by firefighters, highly resistant to heat and flame."),
    mass = "1930 g",
    volume = "5 L",
    price = "910 USD",
    survival_price = "15 USD",
    materials = { "nomex", "kevlar", "lycra" },
    symbol = "[",
    looks_like = "coat_winter",
    color = "yellow",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "900 ml",
            mass_limit = "3 kg",
            max_item_length = "24 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "3250 ml",
            mass_limit = "5 kg",
            max_item_length = "30 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "3250 ml",
            mass_limit = "5 kg",
            max_item_length = "30 cm",
            moves = 80,
        },
    },
    flags = { "VARSIZE", "POCKETS", "STURDY", "RAINPROOF", "OUTER" },
    armor = {
        portions = {
            { covers = { "torso" }, coverage = 100, encumbrance = { 22, 26 } },
            { covers = { "arm_l", "arm_r" }, coverage = 100, encumbrance = { 22, 22 } },
        },
        warmth = 30,
        thickness = 2,
        environmental_protection = 6,
    },
}

ccb.content.define_item {
    id = "cassock",
    name = ccb.content.text("cassock"),
    description = ccb.content.text("A piece of clerical clothing, usually worn by Christian priests."),
    mass = "1200 g",
    volume = "5 L",
    price = "200 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "robe",
    color = "dark_gray",
    flags = { "VARSIZE", "ALLOWS_GASTROPOD_FOOT", "ALLOWS_LEG_TENTACLES" },
    armor = {
        warmth = 20,
        thickness = 1,
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_upper", "torso_lower" },
                coverage = 100,
                encumbrance = 10,
            },
            {
                covers = { "leg_l", "leg_r" },
                coverage = 95,
                encumbrance = 10,
                subparts = { "leg_draped_l", "leg_draped_r" },
                layers = { "BELTED" },
            },
            {
                covers = { "gastropod_foot" },
                coverage = 100,
                encumbrance = 10,
                subparts = { "leg_hip_gastropod_l", "leg_hip_gastropod_r" },
                layers = { "BELTED" },
            },
            {
                covers = { "gastropod_foot" },
                coverage = 67,
                encumbrance = 10,
                subparts = { "leg_upper_gastropod" },
                layers = { "BELTED" },
            },
            {
                covers = {
                    "tentacle_lower_front_l", "tentacle_lower_middle_l", "tentacle_lower_rear_l",
                    "tentacle_lower_front_r", "tentacle_lower_middle_r", "tentacle_lower_rear_r",
                },
                coverage = 55,
                encumbrance = 4,
                subparts = {
                    "tentacle_draped_lower_front_l", "tentacle_draped_lower_middle_l",
                    "tentacle_draped_lower_rear_l", "tentacle_draped_lower_front_r",
                    "tentacle_draped_lower_middle_r", "tentacle_draped_lower_rear_r",
                },
                layers = { "BELTED" },
            },
            { covers = { "arm_l", "arm_r" }, coverage = 100, encumbrance = 10 },
            {
                covers = { "tail_long", "tail_fluffy", "tail_bovine", "tail_rat" },
                coverage = 85,
                encumbrance = 11,
                layers = { "BELTED" },
            },
            {
                covers = { "tail_thick", "tail_club" },
                coverage = 65,
                encumbrance = 13,
                layers = { "BELTED" },
            },
        },
    },
}

ccb.content.define_item {
    id = "coat_fur",
    name = ccb.content.text("fur coat"),
    description = ccb.content.text("A fur coat with a couple small pockets.  Extremely warm."),
    mass = "1677 g",
    volume = "5750 ml",
    price = "5 kUSD",
    survival_price = "5 USD",
    materials = { "fur", "cotton" },
    symbol = "[",
    looks_like = "coat_winter",
    color = "brown",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "700 ml",
            mass_limit = "3 kg",
            max_item_length = "16 cm",
            moves = 80,
            description = ccb.content.text("side pocket."),
        },
        {
            kind = "CONTAINER",
            capacity = "700 ml",
            mass_limit = "3 kg",
            max_item_length = "16 cm",
            moves = 80,
            description = ccb.content.text("side pocket."),
        },
    },
    flags = { "VARSIZE", "POCKETS", "OUTER", "ALLOWS_GASTROPOD_FOOT", "ALLOWS_LEG_TENTACLES" },
    variant_kind = "generic",
    variants = {
        {
            id = "coat_mink_fur",
            name = ccb.content.text("mink coat"),
            description = ccb.content.text("A classic status symbol for the rich and famous, this is a heavy and expensive coat made from luxuriously thick, soft, and rather short fur, with a color palette consisting of rich, deep brown.  One of the most popular types of fur coats produced and traded, this jacket is incredibly warm and comes with two modest pockets."),
            color = "brown",
            weight = 10,
        },
        {
            id = "coat_fox_arctic_fur",
            name = ccb.content.text("arctic fox jacket"),
            description = ccb.content.text("Fluffy and insulating, this expensive fur coat is composed of a small battalion's worth of snowy-white arctic fox pelts with silver tips.  A straight section forms the back and lower sweep, while triangularly cut furs are sown in an inverse pattern to form the rest of the jacket."),
            color = "white",
            weight = 10,
        },
        {
            id = "coat_fox_frost_fur",
            name = ccb.content.text("frost fox overcoat"),
            description = ccb.content.text("A straight-cut, classically stylish jacket crafted from soft and voluminous gray fox fur with a blue undercoat, this article of winter apparel comes kitted out with a tall collar and two modest pockets."),
            color = "light_gray",
            weight = 8,
        },
        {
            id = "bomber_fox_fur",
            name = ccb.content.text("fox fur bomber jacket"),
            description = ccb.content.text("What was once a rugged piece of military clothing has metamorphosed into a fashion icon within this slim-cut and insulated jacket, with wide, cinchable sleeves and a broad collar.  Composed of sewn-together fox pelts and fastened with a zipper at the front, the inside of this jacket is lined with plush, reddish orange fur."),
            color = "light_red",
            weight = 8,
        },
        {
            id = "coat_chinchilla _fur",
            name = ccb.content.text("chinchilla jacket"),
            description = ccb.content.text("Luxuriously velvety and ridiculously extra, this warm, gray-hued coat is ribbed with patterns of black and white highlights.  Composed of a small army's worth of dead chinchilla pelts and naturally hypoallergenic, the world might be going to hell, but at least you'll look like a celebrity while enveloped within this dreamily soft, timelessly stylish coat."),
            color = "light_gray",
            weight = 8,
        },
        {
            id = "coat_rabbit_fur",
            name = ccb.content.text("rabbit overcoat"),
            description = ccb.content.text("Prey and predator are brought together within this luxurious fur coat, sewn from panels of velvety, snowy-white rabbit pelts and accentuated by a beige layer of fox fur trimming the collar and cuffs.  With a tapered waist and two side pockets, the jacket is both comfortable to wear and stylish."),
            color = "white",
            weight = 6,
        },
        {
            id = "bomber_beaver_fur",
            name = ccb.content.text("beaver skin bomber jacket"),
            description = ccb.content.text("The skins of what used to be several beavers have taken to the skies within the composition of this sleek-fitting flight jacket, or, rather, they would if the coat were in any way designed to be a practical piece of kit.  With a soft spread of brown fur lining the inside of this wide-necked overcoat and its exterior finished in a bold, glossy black color, it's safe to say that this garment belongs more within a ski chalet than the cockpit of a fighter craft."),
            color = "dark_gray",
            weight = 6,
        },
        {
            id = "coat_albino_mink_fur",
            name = ccb.content.text("albino mink coat"),
            description = ccb.content.text("Even more prized than regular mink jackets, this coat is exclusively composed of plush white fur with no markings or color in its undercoat.  Extremely warm and equipped with dual pockets, this expensive fashion statement would certainly turn some heads if anyone left alive could still care about aesthetics."),
            color = "white",
            weight = 5,
        },
        {
            id = "coat_lynx_fur",
            name = ccb.content.text("lynx coat"),
            description = ccb.content.text("Possessing bell-bottom sleeves, a tapered waist, and a snowy-white fox fur trim around the collar, hem, and cuffs, this pure white fur coat dappled with striking spots would make any self-respecting aristocrat's heart swell in admiration.  Sown from sections of long and silky abdominal lynx fur and featuring two side pockets, the coat is extremely warm, elegant, and, thanks to the Cataclysm, completely free."),
            color = "white",
            weight = 4,
        },
        {
            id = "coat_sable_fur",
            name = ccb.content.text("sable coat"),
            description = ccb.content.text("The favorite coat of old European royalty, this extravagant jacket of Russian sable is composed of stitched panels of cinnamon brown fur with a pale yellow undercoat and silver tips.  Possessing a tall collar and flaring hips that just might require you to walk sideways through narrower door frames, the coat is impractical, swelteringly warm, and incredibly stylish."),
            color = "yellow",
            weight = 4,
        },
        {
            id = "coat_coyote_fur",
            name = ccb.content.text("coyote jacket"),
            description = ccb.content.text("Before the Cataclysm, this fur coat would have likely been termed \"ruggedly handsome,\" a nice way of saying that, while it's not as nice or as luxurious as other fur garments, its price was the same.  Regardless, the jacket's cinnamon brown fur and rust-red undercoat give it a pleasing aesthetic, while its long hairs are also both dense and durable."),
            color = "brown",
            weight = 2,
        },
        {
            id = "coat_tiger_fur",
            name = ccb.content.text("tiger-skin overcoat"),
            description = ccb.content.text("This is a vintage tiger skin jacket smelling distinctly of mothballs, possessing an alternating blend of orange, white, and black striations ribbing its shaggy exterior, broadly flaring hips, and an interior lining of velvety chinchilla fur.  Illegal, before the Cataclysm, to either produce or sell, this coat is almost certainly one of the last of its kind and would make for a killer fashion statement, if you don't mind wearing the skin of a murdered, endangered animal, that is."),
            color = "red",
        },
    },
    armor = {
        portions = {
            { covers = { "torso" }, coverage = 100, encumbrance = { 26, 30 } },
            { covers = { "arm_l", "arm_r" }, coverage = 100, encumbrance = { 26, 26 } },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
                coverage = 90,
                encumbrance = { 4, 5 },
            },
            {
                covers = { "gastropod_foot" },
                coverage = 90,
                encumbrance = { 4, 5 },
                subparts = { "leg_hip_gastropod_l", "leg_hip_gastropod_r" },
            },
            {
                covers = {
                    "tentacle_lower_front_l", "tentacle_lower_middle_l", "tentacle_lower_rear_l",
                    "tentacle_lower_front_r", "tentacle_lower_middle_r", "tentacle_lower_rear_r",
                },
                coverage = 90,
                encumbrance = { 4, 5 },
                subparts = {
                    "tentacle_lower_front_base_l", "tentacle_lower_middle_base_l",
                    "tentacle_lower_rear_base_l", "tentacle_lower_middle_base_r",
                    "tentacle_lower_middle_base_r", "tentacle_lower_rear_base_r",
                },
            },
        },
        warmth = 80,
        thickness = 2,
        environmental_protection = 2,
    },
}

-- delete fur coat variants, this is survivor made
ccb.content.define_item {
    id = "xl_coat_fur",
    name = ccb.content.text("fur coat"),
    variants = {},
    copy_from = "coat_fur",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

-- delete fur coat variants, this is survivor made
ccb.content.define_item {
    id = "xs_coat_fur",
    copy_from = "coat_fur",
    name = ccb.content.text("fur coat"),
    variants = {},
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- delete fur coat variants
ccb.content.define_item {
    id = "coat_faux_fur",
    copy_from = "coat_fur",
    looks_like = "coat_fur",
    name = ccb.content.text("faux fur coat"),
    description = ccb.content.text("A garishly-colored faux fur coat with a couple small pockets.  Although not as warm as natural fur, it gives you some of that unique flair."),
    variants = {},
    materials = { "faux_fur", "cotton" },
    color = "pink",
    flags = { "VARSIZE", "POCKETS", "OUTER" },
    armor = { warmth = 70 },
}

ccb.content.define_item {
    id = "xl_coat_faux_fur",
    name = ccb.content.text("faux fur coat"),
    copy_from = "coat_faux_fur",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_coat_faux_fur",
    copy_from = "coat_faux_fur",
    name = ccb.content.text("faux fur coat"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "coat_lab",
    name = ccb.content.text("lab coat"),
    description = ccb.content.text("A long white coat with several large pockets.  Comes with a very nice pocket protector."),
    mass = "580 g",
    volume = "2250 ml",
    price = "25 USD",
    survival_price = "1 USD",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "coat_winter",
    color = "white",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1600 ml",
            mass_limit = "3 kg",
            max_item_length = "21 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1600 ml",
            mass_limit = "3 kg",
            max_item_length = "21 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "900 ml",
            mass_limit = "1 kg",
            max_item_length = "13 cm",
            moves = 80,
        },
    },
    flags = { "VARSIZE", "POCKETS", "OUTER" },
    armor = {
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_lower" },
                coverage = 100,
                encumbrance = { 2, 5 },
            },
            {
                covers = { "torso" },
                subparts = { "torso_upper" },
                coverage = 95,
                encumbrance = { 0, 0 },
            },
            { covers = { "arm_l", "arm_r" }, coverage = 100, encumbrance = { 2, 2 } },
        },
        warmth = 15,
        thickness = 0.25,
    },
}

ccb.content.define_item {
    id = "coat_lab_xedra_mark",
    name = ccb.content.text("shielded lab coat"),
    description = ccb.content.text("A long white coat modified for some unknown purpose.  A synthetic x-ray protection apron has been integrated as a liner, with open pockets to accommodate torso plates.  The coat itself also has a layer of shiny metallized polyethylene terephthalate carefully sewn into it, including along the sleeves - the tag for the emergency blanket it was taken from is still attached.  The small breast pocket is embroidered in blue with the name \"Mark Cavaliere, PhD.\""),
    mass = "580 g",
    volume = "2250 ml",
    price = "25 USD",
    survival_price = "1 USD",
    materials = { "cotton", "nylon", "plastic", "aluminum" },
    symbol = "[",
    looks_like = "coat_winter",
    color = "white",
    pockets = {
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "2000 ml",
            mass_limit = "13 kg",
            max_item_length = "46 cm",
            moves = 800,
            description = ccb.content.text("Pocket for a large plate."),
            allowed_flags = { "ABLATIVE_LARGE" },
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "2000 ml",
            mass_limit = "13 kg",
            max_item_length = "46 cm",
            moves = 800,
            description = ccb.content.text("Pocket for a large plate."),
            allowed_flags = { "ABLATIVE_LARGE" },
        },
        {
            kind = "CONTAINER",
            capacity = "1600 ml",
            mass_limit = "3 kg",
            max_item_length = "21 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1600 ml",
            mass_limit = "3 kg",
            max_item_length = "21 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "900 ml",
            mass_limit = "1 kg",
            max_item_length = "13 cm",
            moves = 80,
        },
    },
    flags = { "VARSIZE", "POCKETS", "OUTER" },
    armor = {
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_lower" },
                coverage = 100,
                encumbrance = 4,
                materials = {
                    { id = "cotton", coverage = 100, thickness = 0.25 },
                    { id = "nylon", coverage = 100, thickness = 0.74 },
                    { id = "aluminum", coverage = 100, thickness = 0.01 },
                },
            },
            {
                covers = { "torso" },
                subparts = { "torso_upper" },
                coverage = 95,
                encumbrance = 4,
                materials = {
                    { id = "cotton", coverage = 100, thickness = 0.25 },
                    { id = "nylon", coverage = 100, thickness = 0.74 },
                    { id = "aluminum", coverage = 100, thickness = 0.01 },
                },
            },
            {
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 3,
                materials = {
                    { id = "cotton", coverage = 100, thickness = 0.25 },
                    { id = "aluminum", coverage = 100, thickness = 0.01 },
                },
            },
        },
        warmth = 30,
        thickness = 1,
    },
}

ccb.content.define_item {
    id = "coat_rain",
    name = ccb.content.text("rain coat"),
    description = ccb.content.text("A vinyl coat with a hood and two very large pockets, meant to provide protection from rain."),
    mass = "960 g",
    volume = "1750 ml",
    price = "79 USD",
    survival_price = "50 cent",
    symbol = "[",
    looks_like = "coat_winter",
    color = "yellow",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1500 ml",
            mass_limit = "4 kg",
            max_item_length = "21 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1500 ml",
            mass_limit = "4 kg",
            max_item_length = "21 cm",
            moves = 80,
        },
    },
    flags = { "VARSIZE", "POCKETS", "RAINPROOF", "HOOD", "OUTER" },
    armor = {
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_upper", "torso_lower" },
                coverage = 100,
                encumbrance = { 7, 15 },
                materials = {
                    { id = "vinyl", coverage = 100, thickness = 0.3 },
                    { id = "nylon", coverage = 100, thickness = 0.1 },
                },
            },
            {
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = { 7, 7 },
                materials = {
                    { id = "vinyl", coverage = 100, thickness = 0.3 },
                    { id = "nylon", coverage = 100, thickness = 0.1 },
                },
            },
        },
        warmth = 10,
        environmental_protection = 3,
    },
}

ccb.content.define_item {
    id = "coat_gut",
    name = ccb.content.text("gutskin parka"),
    description = ccb.content.text("An intricately sewn coat of treated and split intestines, prized for its light weight and waterproof qualities among the indigenous peoples of the arctic."),
    mass = "200 g",
    volume = "1250 ml",
    price = "130 USD",
    survival_price = "7 USD 50 cent",
    materials = { "gutskin" },
    symbol = "[",
    looks_like = "coat_rain",
    color = "light_gray",
    flags = { "VARSIZE", "RAINPROOF", "HOOD", "OUTER" },
    armor = {
        warmth = 10,
        thickness = 0.2,
        environmental_protection = 3,
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_upper", "torso_lower" },
                coverage = 100,
                encumbrance = 12,
            },
            {
                covers = { "arm_l", "arm_r" },
                subparts = {
                    "arm_shoulder_l",
                    "arm_shoulder_r",
                    "arm_upper_r",
                    "arm_upper_l",
                    "arm_elbow_r",
                    "arm_elbow_l",
                },
                coverage = 100,
            },
            {
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_lower_l", "arm_lower_r" },
                coverage = 90,
            },
        },
    },
}

ccb.content.define_item {
    id = "coat_winter",
    name = ccb.content.text("puffer jacket"),
    description = ccb.content.text("A down-filled jacket with deep pockets and a hood.  Very warm."),
    mass = "1340 g",
    volume = "6750 ml",
    price = "140 USD",
    survival_price = "7 USD 50 cent",
    materials = { "nylon", "down_feathers" },
    symbol = "[",
    looks_like = "coat_rain",
    color = "light_red",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "3 kg",
            max_item_length = "21 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "3 kg",
            max_item_length = "21 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "900 ml",
            mass_limit = "1 kg",
            max_item_length = "13 cm",
            moves = 120,
        },
        {
            kind = "CONTAINER",
            capacity = "900 ml",
            mass_limit = "1 kg",
            max_item_length = "13 cm",
            moves = 120,
        },
    },
    flags = { "VARSIZE", "POCKETS", "HOOD", "COLLAR", "OUTER" },
    armor = {
        portions = {
            {
                covers = { "torso" },
                coverage = 100,
                encumbrance = { 16, 25 },
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.2 },
                    { id = "down_feathers", coverage = 100, thickness = 4 },
                },
            },
            {
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = { 16, 16 },
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.2 },
                    { id = "down_feathers", coverage = 100, thickness = 4 },
                },
            },
        },
        warmth = 70,
        thickness = 2,
        environmental_protection = 1,
    },
}

ccb.content.define_item {
    id = "duster",
    name = ccb.content.text("duster"),
    description = ccb.content.text("A rugged full-length duster coat.  Has many pockets for storage."),
    mass = "2800 g",
    volume = "5750 ml",
    price = "155 USD",
    survival_price = "10 USD",
    materials = { "canvas" },
    symbol = "[",
    looks_like = "trenchcoat",
    color = "dark_gray",
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
    flags = { "VARSIZE", "POCKETS", "OUTER", "RAINPROOF", "ALLOWS_GASTROPOD_FOOT", "ALLOWS_LEG_TENTACLES" },
    armor = {
        portions = {
            { covers = { "torso" }, coverage = 100, encumbrance = { 7, 13 } },
            {
                covers = { "leg_l", "leg_r" },
                coverage = 86,
                encumbrance = { 4, 5 },
                subparts = { "leg_draped_l", "leg_draped_r" },
                layers = { "BELTED" },
            },
            {
                covers = {
                    "tentacle_lower_front_l", "tentacle_lower_middle_l", "tentacle_lower_rear_l",
                    "tentacle_lower_front_r", "tentacle_lower_middle_r", "tentacle_lower_rear_r",
                },
                coverage = 86,
                encumbrance = { 4, 5 },
                subparts = {
                    "tentacle_draped_lower_front_l", "tentacle_draped_lower_middle_l",
                    "tentacle_draped_lower_rear_l", "tentacle_draped_lower_front_r",
                    "tentacle_draped_lower_middle_r", "tentacle_draped_lower_rear_r",
                },
                layers = { "BELTED" },
            },
            {
                covers = { "gastropod_foot" },
                coverage = 100,
                encumbrance = { 4, 5 },
                subparts = { "leg_hip_gastropod_l", "leg_hip_gastropod_r" },
                layers = { "BELTED" },
            },
            {
                covers = { "gastropod_foot" },
                coverage = 60,
                encumbrance = { 4, 5 },
                subparts = { "leg_upper_gastropod" },
                layers = { "BELTED" },
            },
            { covers = { "arm_l", "arm_r" }, coverage = 100, encumbrance = { 7, 7 } },
            {
                covers = { "tail_long", "tail_fluffy", "tail_bovine", "tail_rat" },
                coverage = 85,
                encumbrance = { 5, 5 },
                layers = { "BELTED" },
            },
            {
                covers = { "tail_thick", "tail_club" },
                coverage = 65,
                encumbrance = { 5, 5 },
                layers = { "BELTED" },
            },
        },
        warmth = 15,
        thickness = 1.5,
        environmental_protection = 2,
    },
}

ccb.content.define_item {
    id = "duster_fur",
    name = ccb.content.text("fur duster"),
    description = ccb.content.text("A thick fur full-length duster.  Has many pockets for storage."),
    mass = "2362 g",
    volume = "9750 ml",
    price = "979 USD",
    survival_price = "10 USD",
    materials = { "fur" },
    symbol = "[",
    looks_like = "duster_leather",
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
    flags = { "VARSIZE", "POCKETS", "OUTER", "RAINPROOF", "ALLOWS_GASTROPOD_FOOT", "ALLOWS_LEG_TENTACLES" },
    armor = {
        portions = {
            { covers = { "torso" }, coverage = 100, encumbrance = { 9, 13 } },
            {
                covers = { "leg_l", "leg_r" },
                coverage = 86,
                encumbrance = { 4, 5 },
                subparts = { "leg_draped_l", "leg_draped_r" },
                layers = { "BELTED" },
            },
            {
                covers = { "gastropod_foot" },
                coverage = 100,
                encumbrance = { 4, 5 },
                subparts = { "leg_hip_gastropod_l", "leg_hip_gastropod_r" },
                layers = { "BELTED" },
            },
            {
                covers = { "gastropod_foot" },
                coverage = 60,
                encumbrance = { 4, 5 },
                subparts = { "leg_upper_gastropod" },
                layers = { "BELTED" },
            },
            {
                covers = {
                    "tentacle_lower_front_l", "tentacle_lower_middle_l", "tentacle_lower_rear_l",
                    "tentacle_lower_front_r", "tentacle_lower_middle_r", "tentacle_lower_rear_r",
                },
                coverage = 75,
                encumbrance = { 4, 5 },
                subparts = {
                    "tentacle_draped_lower_front_l", "tentacle_draped_lower_middle_l",
                    "tentacle_draped_lower_rear_l", "tentacle_draped_lower_front_r",
                    "tentacle_draped_lower_middle_r", "tentacle_draped_lower_rear_r",
                },
                layers = { "BELTED" },
            },
            { covers = { "arm_l", "arm_r" }, coverage = 100, encumbrance = { 13, 13 } },
            {
                covers = { "tail_long", "tail_fluffy", "tail_bovine", "tail_rat" },
                coverage = 85,
                encumbrance = { 5, 5 },
                layers = { "BELTED" },
            },
            {
                covers = { "tail_thick", "tail_club" },
                coverage = 65,
                encumbrance = { 5, 5 },
                layers = { "BELTED" },
            },
        },
        warmth = 50,
        thickness = 3,
        environmental_protection = 1,
    },
}

ccb.content.define_item {
    id = "xl_duster_fur",
    name = ccb.content.text("fur duster"),
    copy_from = "duster_fur",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_duster_fur",
    copy_from = "duster_fur",
    name = ccb.content.text("fur duster"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "xl_duster",
    name = ccb.content.text("duster"),
    copy_from = "duster",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_duster",
    copy_from = "duster",
    name = ccb.content.text("duster"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "duster_faux_fur",
    copy_from = "duster_fur",
    looks_like = "duster_fur",
    name = ccb.content.text("faux fur duster"),
    description = ccb.content.text("A thick faux fur duster, falling below your knees.  Has many pockets for storing things."),
    materials = { "faux_fur", "cotton" },
    flags = { "VARSIZE", "POCKETS", "OUTER", "ALLOWS_GASTROPOD_FOOT", "ALLOWS_LEG_TENTACLES" },
    armor = { warmth = 40 },
}

ccb.content.define_item {
    id = "xl_duster_faux_fur",
    name = ccb.content.text("faux fur duster"),
    copy_from = "duster_faux_fur",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_duster_faux_fur",
    copy_from = "duster_faux_fur",
    name = ccb.content.text("faux fur duster"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "duster_leather",
    name = ccb.content.text("leather duster"),
    description = ccb.content.text("A thick leather full-length duster.  Has many pockets for storage."),
    mass = "2655 g",
    volume = "7 L",
    price = "245 USD",
    survival_price = "12 USD 50 cent",
    materials = { "leather" },
    symbol = "[",
    looks_like = "duster",
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
    flags = { "VARSIZE", "POCKETS", "OUTER", "RAINPROOF", "ALLOWS_GASTROPOD_FOOT", "ALLOWS_LEG_TENTACLES" },
    armor = {
        portions = {
            { covers = { "torso" }, coverage = 100, encumbrance = { 10, 15 } },
            {
                covers = { "leg_l", "leg_r" },
                coverage = 86,
                encumbrance = { 4, 5 },
                subparts = { "leg_draped_l", "leg_draped_r" },
                layers = { "BELTED" },
            },
            {
                covers = { "gastropod_foot" },
                coverage = 100,
                encumbrance = { 4, 5 },
                subparts = { "leg_hip_gastropod_l", "leg_hip_gastropod_r" },
                layers = { "BELTED" },
            },
            {
                covers = { "gastropod_foot" },
                coverage = 60,
                encumbrance = { 4, 5 },
                subparts = { "leg_upper_gastropod" },
                layers = { "BELTED" },
            },
            {
                covers = {
                    "tentacle_lower_front_l", "tentacle_lower_middle_l", "tentacle_lower_rear_l",
                    "tentacle_lower_front_r", "tentacle_lower_middle_r", "tentacle_lower_rear_r",
                },
                coverage = 75,
                encumbrance = { 4, 5 },
                subparts = {
                    "tentacle_draped_lower_front_l", "tentacle_draped_lower_middle_l",
                    "tentacle_draped_lower_rear_l", "tentacle_draped_lower_front_r",
                    "tentacle_draped_lower_middle_r", "tentacle_draped_lower_rear_r",
                },
                layers = { "BELTED" },
            },
            { covers = { "arm_l", "arm_r" }, coverage = 100, encumbrance = { 15, 15 } },
            {
                covers = { "tail_long", "tail_fluffy", "tail_bovine", "tail_rat" },
                coverage = 85,
                encumbrance = { 5, 5 },
                layers = { "BELTED" },
            },
            {
                covers = { "tail_thick", "tail_club" },
                coverage = 65,
                encumbrance = { 5, 5 },
                layers = { "BELTED" },
            },
        },
        warmth = 30,
        thickness = 1.5,
        environmental_protection = 1,
    },
}

ccb.content.define_item {
    id = "xl_duster_leather",
    name = ccb.content.text("leather duster"),
    copy_from = "duster_leather",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_duster_leather",
    copy_from = "duster_leather",
    name = ccb.content.text("leather duster"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "greatcoat",
    name = ccb.content.text("greatcoat"),
    description = ccb.content.text("A heavy, full-length wool coat.  Cumbersome, but warm and with deep pockets."),
    mass = "2428 g",
    volume = "8 L",
    price = "180 USD",
    survival_price = "5 USD",
    materials = { "wool" },
    symbol = "[",
    looks_like = "coat_winter",
    color = "blue",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1750 ml",
            mass_limit = "4 kg",
            max_item_length = "24 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1750 ml",
            mass_limit = "4 kg",
            max_item_length = "24 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "900 ml",
            mass_limit = "2 kg",
            max_item_length = "13 cm",
            moves = 120,
        },
        {
            kind = "CONTAINER",
            capacity = "900 ml",
            mass_limit = "2 kg",
            max_item_length = "13 cm",
            moves = 120,
        },
    },
    flags = { "VARSIZE", "POCKETS", "COLLAR", "OUTER", "ALLOWS_GASTROPOD_FOOT", "ALLOWS_LEG_TENTACLES" },
    armor = {
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_lower" },
                coverage = 100,
                encumbrance = { 11, 20 },
            },
            {
                covers = { "torso" },
                subparts = { "torso_upper" },
                coverage = 95,
                encumbrance = { 0, 0 },
            },
            {
                covers = { "leg_l", "leg_r" },
                coverage = 79,
                encumbrance = { 11, 13 },
                subparts = { "leg_draped_l", "leg_draped_r" },
                layers = { "BELTED" },
            },
            {
                covers = { "gastropod_foot" },
                coverage = 100,
                encumbrance = { 11, 13 },
                subparts = { "leg_hip_gastropod_l", "leg_hip_gastropod_r" },
                layers = { "BELTED" },
            },
            {
                covers = { "gastropod_foot" },
                coverage = 55,
                encumbrance = { 11, 13 },
                subparts = { "leg_upper_gastropod" },
                layers = { "BELTED" },
            },
            {
                covers = {
                    "tentacle_lower_front_l", "tentacle_lower_middle_l", "tentacle_lower_rear_l",
                    "tentacle_lower_front_r", "tentacle_lower_middle_r", "tentacle_lower_rear_r",
                },
                coverage = 75,
                encumbrance = { 11, 13 },
                subparts = {
                    "tentacle_draped_lower_front_l", "tentacle_draped_lower_middle_l",
                    "tentacle_draped_lower_rear_l", "tentacle_draped_lower_front_r",
                    "tentacle_draped_lower_middle_r", "tentacle_draped_lower_rear_r",
                },
            },
            { covers = { "arm_l", "arm_r" }, coverage = 100, encumbrance = { 11, 11 } },
            {
                covers = { "tail_long", "tail_fluffy", "tail_bovine", "tail_rat" },
                coverage = 85,
                encumbrance = { 8, 9 },
                layers = { "BELTED" },
            },
            {
                covers = { "tail_thick", "tail_club" },
                coverage = 65,
                encumbrance = { 8, 9 },
                layers = { "BELTED" },
            },
        },
        warmth = 50,
        thickness = 4,
        environmental_protection = 1,
    },
}

ccb.content.define_item {
    id = "hakama_gi",
    name = ccb.content.plural_text("hakama", "hakama"),
    description = ccb.content.text("Plain black hakama for use in kendo and other martial arts."),
    mass = "350 g",
    volume = "1 L",
    price = "25 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "skirt",
    color = "dark_gray",
    flags = { "VARSIZE", "STURDY" },
    armor = {
        warmth = 10,
        thickness = 0.3,
        portions = {
            {
                covers = { "leg_l", "leg_r" },
                coverage = 97,
                encumbrance = 6,
                subparts = { "leg_draped_l", "leg_draped_r" },
                layers = { "BELTED" },
            },
        },
    },
}

ccb.content.define_item {
    id = "hakama",
    name = ccb.content.plural_text("hakama", "hakama"),
    description = ccb.content.text("A flowing, pleated garment which can be worn over a kimono."),
    mass = "500 g",
    volume = "1500 ml",
    price = "30 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "skirt",
    color = "blue",
    flags = { "VARSIZE", "OUTER" },
    armor = {
        warmth = 15,
        thickness = 0.3,
        portions = {
            {
                covers = { "leg_l", "leg_r" },
                coverage = 86,
                encumbrance = 6,
                subparts = { "leg_draped_l", "leg_draped_r" },
                layers = { "BELTED" },
            },
        },
    },
}

ccb.content.define_item {
    id = "house_coat",
    name = ccb.content.text("bathrobe"),
    description = ccb.content.text("An outer garment of absorbent, towel-like material traditionally worn to cover one's nakedness to and from the bath.  It makes you wish you had running water to bathe with."),
    mass = "580 g",
    volume = "2 L",
    price = "22 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "coat_lab",
    color = "blue",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "750 ml",
            mass_limit = "2 kg",
            max_item_length = "13 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "750 ml",
            mass_limit = "2 kg",
            max_item_length = "13 cm",
            moves = 80,
        },
    },
    flags = { "OUTER" },
    armor = {
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_lower" },
                coverage = 100,
                encumbrance = { 0, 0 },
            },
            {
                covers = { "torso" },
                subparts = { "torso_upper" },
                coverage = 95,
                encumbrance = { 5, 10 },
            },
            {
                covers = { "leg_l", "leg_r" },
                coverage = 75,
                encumbrance = { 5, 5 },
                subparts = { "leg_draped_l", "leg_draped_r" },
                layers = { "BELTED" },
            },
            { covers = { "arm_l", "arm_r" }, coverage = 100, encumbrance = { 5, 5 } },
        },
        warmth = 20,
        thickness = 0.8,
        environmental_protection = 1,
    },
}

-- Intended to be, and modeled off of, an M65 combat jacket.
-- Considering that this is a stand-in for both original and reproduction M65 jackets, we're basing our overall dimensions and price on: https://www.helikon-tex.com/en_eur/ku-c65-dc-covert-m-65-jacket.html
-- The price of a surplus jacket would be much, much cheaper, but such is the compromise when you're simulating new and old in the same basket.
-- The shell is made from a midweight NyCo blend wind resistant sateen, fully lined with a lightweight NyCo blend wind resistant poplin: https://omegamilitaria.com/blogs/reference-guides/the-ultimate-visual-buyers-guide-to-the-m65-field-jacket
-- M65 jackets have a quilted liner of cotton that's generally removable. Considering that the player isn't able to extract the liner from this garment, we're assuming that the liner is in all the time, hence the quilted cotten material.
-- 6 inches tall, 4 inches wide, and 1.5 inches deep.
-- 6 inches tall, 4 inches wide, and 1.5 inches deep.
-- 7 inches tall, 3 inches wide, and 1 inch deep.
-- 7 inches tall, 3 inches wide, and 1 inch deep.
-- 4 inches tall, 2 inches wide, and 1 inch deep.
-- Intended to be US M81 woodland camo.
-- Intended to be US DCU camo.
-- Either original Vietnam M65 jackets, before M81 camo, or modern reproductions.
-- Intended to be US military UCP camo.
-- Intended to be Swedish M90 camo. This is a civilian variant, and, yes, for some reason, out of all camo patterns, this exists: https://www.epicmilitaria.com/brandit-m65-giant-jacket-swedish-camo.html
-- Only used as a cosmetic variant for player professions that start with army jackets: currently the old veteran.
ccb.content.define_item {
    id = "jacket_army",
    looks_like = "coat_winter",
    name = ccb.content.text("army jacket"),
    description = ccb.content.text("A vintage article of military surplus with an adjustable waist drawstring, or at least a civilian reproduction of one — it's resplendent with a cotton liner, an integral hood tucked away in a zip-up pouch in the collar, and epaulettes upon the shoulders."),
    mass = "1400 g",
    volume = "3 L",
    price = "141 USD 47 cent",
    survival_price = "4 USD 25 cent",
    materials = { { id = "nylon", portions = 3 }, { id = "cotton_quilted", portions = 1 } },
    symbol = "[",
    color = "green",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "590 ml",
            mass_limit = "2 kg",
            max_item_length = "15 cm",
            description = ccb.content.text("Button-fastened hip pocket."),
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "590 ml",
            mass_limit = "2 kg",
            max_item_length = "15 cm",
            description = ccb.content.text("Button-fastened hip pocket."),
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "361 ml",
            mass_limit = "1500 g",
            max_item_length = "18 cm",
            description = ccb.content.text("Button-fastened chest pocket."),
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "361 ml",
            mass_limit = "1500 g",
            max_item_length = "18 cm",
            description = ccb.content.text("Button-fastened chest pocket."),
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "131 ml",
            mass_limit = "1 kg",
            max_item_length = "13 cm",
            description = ccb.content.text("Velcro-fastened internal pocket."),
            moves = 150,
        },
    },
    flags = { "VARSIZE", "POCKETS", "OUTER", "ALLOWS_GASTROPOD_FOOT", "ALLOWS_LEG_TENTACLES" },
    variant_kind = "generic",
    variants = {
        {
            id = "m65_woodland",
            name = ccb.content.text("woodland-camo combat jacket"),
            description = ccb.content.text("Tried and true, the US military's antiquated 4-tone woodland camouflage pattern covers this particular jacket: large, high-contrast patches of green, black, brown, and sand hues, all rather faded from years and ware."),
            color = "green",
            weight = 25,
            append = true,
        },
        {
            id = "m65_desert",
            name = ccb.content.text("desert-camo combat jacket"),
            description = ccb.content.text("This jacket's brass zipper runs from collar to hem, a river of metallic brown knitting together the coat's arid-hued lapels, printed with a 3-tone mix of pale green, dark brown, and beige.  Looking at it, you wonder how many zombies are wandering about the gulf right now."),
            color = "brown",
            weight = 20,
            append = true,
        },
        {
            id = "m65_olive",
            name = ccb.content.text("olive-drab combat jacket"),
            description = ccb.content.text("Lacking much frills and fanfare, this simple, traditional jacket is dyed a solid shade of olive green with a brass zipper and buttons."),
            color = "green",
            weight = 35,
            append = true,
        },
        {
            id = "m65_flecktarn",
            name = ccb.content.text("mottled-camo combat jacket"),
            description = ccb.content.text("This particular garment has a base hue of dark tan, coated by myriad spots, blobs, and splotches of green, reddish brown, black, and grayish green to form a mottled, disruptive camouflage pattern."),
            color = "green",
            weight = 15,
            append = true,
        },
        {
            id = "m65_ocean",
            name = ccb.content.text("ocean-camouflage combat jacket"),
            description = ccb.content.text("This jacket's exterior shell is dyed a mix of blue and gray hues, with extra patches and disruptive striations, flipping between black and dark gray, covering the garment from collar to hem.  Chrome buttons, zips, and other fixtures glint from their home upon the coat."),
            color = "blue",
            weight = 10,
            append = true,
        },
        {
            id = "m65_digital",
            name = ccb.content.text("digital-camo combat jacket"),
            description = ccb.content.text("The fabric of this particular jacket is coated in the pixelized camouflage pattern of the United States Army's former combat uniform, combining a sand-brown base with disruptive patterns of urban gray and sage green, as well as plastic zips and buttons."),
            color = "green",
            weight = 5,
            append = true,
        },
        {
            id = "m65_black",
            name = ccb.content.text("urban black combat jacket"),
            description = ccb.content.text("Fitted with a brass main zip and corresponding buttons, this entire jacket forgoes frivolities and is, instead, dyed a solid shade of midnight black."),
            color = "dark_gray",
            weight = 25,
            append = true,
        },
        {
            id = "m65_swedish",
            name = ccb.content.text("splinter-camo combat jacket"),
            description = ccb.content.text("This particular jacket is sown from fabric dyed a base color of stoney gray with notes of brown, sprinkled through with large, splinter-like geometric shapes of green, gray, and hues of deep naval blue."),
            color = "dark_gray",
            weight = 10,
            append = true,
        },
        {
            id = "m65_coyote",
            name = ccb.content.text("coyote combat jacket"),
            description = ccb.content.text("Dyed in a solid shade of rugged, earthen brown with a brass main zip and press-studs, this is a relatively handsome coat, so far as reproduction military equipment goes.  Obviously, the would-be soldier, prepper, and general wearer would most appreciate its utility in going undercover among the insurgent coyote population."),
            color = "brown",
            weight = 20,
            append = true,
        },
        {
            id = "m65_player",
            name = ccb.content.text("woodland-camo combat jacket"),
            description = ccb.content.text("Dyed in a 4-tone blend of worn green, black, sand, and brown hues, this particular overcoat had been your own issued service jacket when you'd still been in the forces, with your name stitched upon the right lapel and insignia pinned to the appropriate shoulder board."),
            color = "green",
            weight = 0,
            append = true,
        },
    },
    armor = {
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.5 },
                    { id = "cotton_quilted", coverage = 60, thickness = 0.4 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = { 8, 12 },
            },
            {
                materials = { { id = "nylon", coverage = 100, thickness = 0.4 } },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = { 7, 7 },
            },
            {
                materials = { { id = "nylon", coverage = 100, thickness = 0.5 } },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
                coverage = 100,
                encumbrance = { 7, 7 },
            },
            {
                covers = { "gastropod_foot" },
                coverage = 100,
                encumbrance = { 7, 7 },
                subparts = { "leg_hip_gastropod_l", "leg_hip_gastropod_r" },
            },
            {
                covers = {
                    "tentacle_lower_front_l", "tentacle_lower_middle_l", "tentacle_lower_rear_l",
                    "tentacle_lower_front_r", "tentacle_lower_middle_r", "tentacle_lower_rear_r",
                },
                coverage = 100,
                encumbrance = { 7, 7 },
                subparts = {
                    "tentacle_lower_front_base_l", "tentacle_lower_middle_base_l",
                    "tentacle_lower_rear_base_l", "tentacle_lower_middle_base_r",
                    "tentacle_lower_middle_base_r", "tentacle_lower_rear_base_r",
                },
            },
        },
        warmth = 20,
        thickness = 0.4,
    },
}

ccb.content.define_item {
    id = "jacket_army_modern",
    name = ccb.content.text("combat blouse"),
    description = ccb.content.text("A sleek blouse in a camouflage pattern with angled breast pockets and lots of loop velcro for affixing patches.  You might call it a jacket but it's really a blouse.  It has a pocket for your pen!"),
    mass = "650 g",
    volume = "3 L",
    price = "64 USD",
    survival_price = "7 USD 50 cent",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "jacket_army",
    color = "green",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "900 ml",
            mass_limit = "2 kg",
            max_item_length = "15 cm",
            moves = 70,
        },
        {
            kind = "CONTAINER",
            capacity = "900 ml",
            mass_limit = "2 kg",
            max_item_length = "15 cm",
            moves = 70,
        },
        {
            kind = "CONTAINER",
            capacity = "500 ml",
            mass_limit = "1 kg",
            max_item_length = "13 cm",
            moves = 120,
        },
        {
            kind = "CONTAINER",
            capacity = "500 ml",
            mass_limit = "1 kg",
            max_item_length = "13 cm",
            moves = 120,
        },
        {
            kind = "CONTAINER",
            capacity = "10 ml",
            mass_limit = "50 g",
            max_item_length = "13 cm",
            moves = 120,
        },
    },
    flags = { "VARSIZE", "POCKETS", "OUTER" },
    armor = {
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_upper" },
                coverage = 95,
                encumbrance = { 7, 9 },
            },
            { covers = { "torso" }, subparts = { "torso_lower" }, coverage = 100 },
            { covers = { "arm_l", "arm_r" }, coverage = 100, encumbrance = { 7, 9 } },
        },
        warmth = 20,
        thickness = 0.4,
    },
}

ccb.content.define_item {
    id = "jacket_chef",
    name = ccb.content.text("chef's jacket"),
    description = ccb.content.text("A double-breasted uniform to protect against the heat of the kitchen."),
    mass = "720 g",
    volume = "1750 ml",
    price = "70 USD",
    survival_price = "2 USD 50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "coat_lab",
    color = "white",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "2 kg",
            max_item_length = "13 cm",
            moves = 80,
        },
    },
    flags = { "OUTER", "VARSIZE" },
    variant_kind = "generic",
    variants = {
        {
            id = "white_jacket_chef",
            name = ccb.content.text("white chef's jacket"),
            description = ccb.content.text("It's colored white, the most common color for chef's jackets."),
            weight = 60,
            append = true,
        },
        {
            id = "black_jacket_chef",
            name = ccb.content.text("black chef's jacket"),
            description = ccb.content.text("It's colored black, commonly used by chefs working in the night or who just want to look cool."),
            color = "dark_gray",
            weight = 25,
            append = true,
        },
        {
            id = "blue_jacket_chef",
            name = ccb.content.text("blue chef's jacket"),
            description = ccb.content.text("It's a royal blue color."),
            color = "blue",
            weight = 10,
            append = true,
        },
        {
            id = "red_jacket_chef",
            name = ccb.content.text("red chef's jacket"),
            description = ccb.content.text("It's colored red."),
            color = "red",
            weight = 10,
            append = true,
        },
        {
            id = "pink_jacket_chef",
            name = ccb.content.text("pink chef's jacket"),
            description = ccb.content.text("It's colored pink, commonly used by women chefs or men who like pink."),
            color = "pink",
            weight = 10,
            append = true,
        },
        {
            id = "yellow_jacket_chef",
            name = ccb.content.text("yellow chef's jacket"),
            description = ccb.content.text("It's colored yellow."),
            color = "yellow",
            weight = 5,
            append = true,
        },
        {
            id = "camo_jacket_chef",
            name = ccb.content.text("camo chef's jacket"),
            description = ccb.content.text("It has a camouflage pattern, perfect for chefs that want to hide in the wild."),
            color = "green",
            weight = 2,
            append = true,
        },
        {
            id = "skull_jacket_chef",
            name = ccb.content.text("skull chef's jacket"),
            description = ccb.content.text("It's colored white, and the front and back are printed with a giant skull between crossed kitchen knives.  Perfect for the apocalyptic chef."),
            symbol = "S",
            append = true,
        },
    },
    armor = {
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_upper", "torso_lower" },
                coverage = 100,
                encumbrance = { 8, 13 },
            },
            {
                covers = { "arm_l", "arm_r" },
                subparts = {
                    "arm_shoulder_l",
                    "arm_shoulder_r",
                    "arm_upper_r",
                    "arm_upper_l",
                    "arm_elbow_r",
                    "arm_elbow_l",
                },
                coverage = 100,
            },
            {
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_lower_l", "arm_lower_r" },
                coverage = 60,
            },
        },
        warmth = 25,
        thickness = 0.4,
    },
}

ccb.content.define_item {
    id = "jacket_evac",
    name = ccb.content.text("emergency jacket"),
    description = ccb.content.text("A bright, cheaply made FEMA-issue windbreaker jacket with a hood.  One size, fits none.  Helps keep you unfrozen & visible for rescuers."),
    mass = "197 g",
    volume = "2250 ml",
    price = "10 USD",
    survival_price = "50 cent",
    symbol = "[",
    looks_like = "jacket_leather",
    color = "cyan",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "800 ml",
            mass_limit = "1 kg",
            max_item_length = "13 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "800 ml",
            mass_limit = "1 kg",
            max_item_length = "13 cm",
            moves = 80,
        },
    },
    flags = { "POCKETS", "HOOD", "OUTER", "RAINPROOF" },
    armor = {
        portions = {
            {
                covers = { "torso" },
                coverage = 100,
                encumbrance = { 13, 15 },
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.25 },
                    { id = "vinyl", coverage = 60, thickness = 0.3 },
                },
            },
            {
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = { 13, 13 },
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.25 },
                    { id = "vinyl", coverage = 60, thickness = 0.3 },
                },
            },
        },
        warmth = 25,
        thickness = 0.15,
    },
}

ccb.content.define_item {
    id = "jacket_flannel",
    name = ccb.content.text("flannel jacket"),
    description = ccb.content.text("A jacket made from flannel, favored by outdoorsy types."),
    mass = "958 g",
    volume = "4250 ml",
    price = "60 USD",
    survival_price = "2 USD 50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "coat_winter",
    color = "light_red",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "800 ml",
            mass_limit = "2 kg",
            max_item_length = "13 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "800 ml",
            mass_limit = "2 kg",
            max_item_length = "13 cm",
            moves = 80,
        },
    },
    flags = { "VARSIZE", "POCKETS", "OUTER" },
    armor = {
        portions = {
            { covers = { "torso" }, coverage = 100, encumbrance = { 9, 11 } },
            { covers = { "arm_l", "arm_r" }, coverage = 100, encumbrance = { 9, 9 } },
        },
        warmth = 35,
        thickness = 0.7,
    },
}
