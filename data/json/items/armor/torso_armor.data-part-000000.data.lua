local ccb = require("ccb")

ccb.content.define_item {
    id = "armor_cuirass",
    name = ccb.content.plural_text("bell cuirass", "bell cuirasses"),
    category = "armor",
    description = ccb.content.text("An ancient Greek breastplate made of bronze."),
    mass = "5896 g",
    volume = "6 L",
    price = "500 USD",
    survival_price = "30 USD",
    accuracy = { grip = "none", length = "short", surface = "any", balance = "clumsy" },
    materials = { "bronze" },
    symbol = "[",
    looks_like = "cuirass_lightplate",
    color = "yellow",
    length = "60 cm",
    flags = { "VARSIZE", "OUTER", "STURDY" },
    melee_damage = { bash = 6 },
    armor = {
        warmth = 15,
        thickness = 3,
        portions = { { encumbrance = 15, coverage = 90, covers = { "torso" } } },
    },
}

ccb.content.define_item {
    id = "xl_armor_cuirass",
    name = ccb.content.plural_text("bell cuirass", "bell cuirasses"),
    copy_from = "armor_cuirass",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_armor_cuirass",
    copy_from = "armor_cuirass",
    name = ccb.content.plural_text("bell cuirass", "bell cuirasses"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "cuirass_bronze",
    name = ccb.content.plural_text("bronze cuirass", "bronze cuirasses"),
    category = "armor",
    description = ccb.content.text("A solid, single-piece cuirass made from bronze.  It isn't particularly well designed, but it does its job."),
    mass = "4896 g",
    volume = "6 L",
    price = "400 USD",
    survival_price = "20 USD",
    accuracy = { grip = "none", length = "short", surface = "any", balance = "clumsy" },
    materials = { "bronze" },
    symbol = "[",
    looks_like = "armor_cuirass",
    color = "yellow",
    length = "60 cm",
    flags = { "OUTER", "STURDY" },
    melee_damage = { bash = 6 },
    armor = {
        warmth = 15,
        thickness = 2,
        portions = { { encumbrance = 10, coverage = 85, covers = { "torso" } } },
    },
}

ccb.content.define_item {
    id = "xl_cuirass_bronze",
    name = ccb.content.plural_text("bronze cuirass", "bronze cuirasses"),
    copy_from = "cuirass_bronze",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_cuirass_bronze",
    name = ccb.content.plural_text("bronze cuirass", "bronze cuirasses"),
    copy_from = "cuirass_bronze",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- Human surface area is roughly 18600 cm^2, based off of rules of 9 the torso is 36% leaving us with 6696 cm^2, and arms are 18% leaving us with 3348 cm^2.
-- Leather has a density of 1.1g/cm^3, thickness of 0.4 cm, coverage of 100% leaves us with 3 741 grams.
-- Leather has a density of 1.1g/cm^3, thickness of 0.4 cm, coverage of 54% leaves us with 795 grams.
-- Totalled up this is 4 537 grams with some rounding
ccb.content.define_item {
    id = "armor_lamellar",
    name = ccb.content.plural_text("leather lamellar cuirass", "leather lamellar cuirasses"),
    description = ccb.content.text("A cuirass made of multiple pieces of tough leather, laced together for durable yet flexible protection."),
    mass = "4537 g",
    volume = "9250 ml",
    price = "260 USD",
    survival_price = "25 USD",
    materials = { "leather" },
    symbol = "[",
    looks_like = "vest_leather",
    color = "brown",
    length = "60 cm",
    flags = { "VARSIZE", "STURDY", "OUTER", "ABLATIVE_CHAINMAIL_TORSO" },
    armor = {
        warmth = 20,
        thickness = 3,
        portions = {
            {
                materials = { { id = "leather", coverage = 100, thickness = 4.0 } },
                encumbrance = 8,
                coverage = 100,
                ranged_coverage = 95,
                vitals_coverage = 70,
                covers = { "torso" },
            },
            {
                materials = { { id = "leather", coverage = 100, thickness = 4.0 } },
                encumbrance = 4,
                coverage = 90,
                ranged_coverage = 95,
                vitals_coverage = 70,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_upper_l", "arm_shoulder_l", "arm_upper_r", "arm_shoulder_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_armor_lamellar",
    name = ccb.content.plural_text("leather lamellar cuirass", "leather lamellar cuirasses"),
    copy_from = "armor_lamellar",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_armor_lamellar",
    copy_from = "armor_lamellar",
    name = ccb.content.plural_text("leather lamellar cuirass", "leather lamellar cuirasses"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "armor_lamellar_lc",
    name = ccb.content.plural_text("mild steel lamellar cuirass", "mild steel lamellar cuirasses"),
    description = ccb.content.text("A cuirass made of small strips of sheet metal laced together, something of an intermediary between chain mail and plate armor.  It's less Mad Max and more Garage Mongolian, but the classics are classic for a reason."),
    mass = "14000 g",
    volume = "9250 ml",
    price = "260 USD",
    survival_price = "25 USD",
    materials = { "lc_steel" },
    symbol = "[",
    looks_like = "armor_lorica",
    color = "light_gray",
    length = "60 cm",
    flags = { "VARSIZE", "OUTER", "NO_REPAIR", "ABLATIVE_CHAINMAIL_TORSO" },
    armor = {
        warmth = 20,
        thickness = 3,
        portions = {
            {
                materials = { { id = "lc_steel", coverage = 100, thickness = 2.0 } },
                encumbrance = 22,
                coverage = 95,
                ranged_coverage = 95,
                vitals_coverage = 70,
                covers = { "torso" },
            },
            {
                materials = { { id = "lc_steel", coverage = 100, thickness = 2.0 } },
                encumbrance = 16,
                coverage = 90,
                ranged_coverage = 95,
                vitals_coverage = 70,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_upper_l", "arm_shoulder_l", "arm_upper_r", "arm_shoulder_r" },
            },
            {
                materials = { { id = "lc_steel", coverage = 100, thickness = 2.0 } },
                encumbrance = 22,
                coverage = 90,
                ranged_coverage = 95,
                vitals_coverage = 70,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_hip_l", "leg_upper_r", "leg_hip_r" },
            },
            {
                materials = { { id = "lc_steel", coverage = 100, thickness = 2.0 } },
                encumbrance = 22,
                coverage = 90,
                ranged_coverage = 95,
                vitals_coverage = 70,
                covers = { "gastropod_foot" },
                subparts = { "leg_hip_gastropod_l", "leg_hip_gastropod_r" },
            },
            {
                materials = { { id = "lc_steel", coverage = 100, thickness = 2.0 } },
                encumbrance = 22,
                coverage = 50,
                ranged_coverage = 55,
                vitals_coverage = 40,
                covers = { "gastropod_foot" },
                subparts = { "leg_upper_gastropod" },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_armor_lamellar_lc",
    name = ccb.content.plural_text("mild steel lamellar cuirass", "mild steel lamellar cuirasses"),
    description = ccb.content.text("A cuirass made of small strips of sheet metal laced together, something of an intermediary between chain mail and plate armor.  The perfect size for an orc or bipedal grizzly bear."),
    copy_from = "armor_lamellar_lc",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_armor_lamellar_lc",
    copy_from = "armor_lamellar_lc",
    name = ccb.content.plural_text("mild steel lamellar cuirass", "mild steel lamellar cuirasses"),
    description = ccb.content.text("A cuirass made of small strips of sheet metal laced together, something of an intermediary between chain mail and plate armor.  Perfectly sized for a particularly angry rat-person, yes-yes."),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "armor_lamellar_ch",
    copy_from = "armor_lamellar_lc",
    name = ccb.content.plural_text("hardened steel lamellar cuirass", "hardened steel lamellar cuirasses"),
    description = ccb.content.text("A cuirass made of small strips of sheet metal laced together, something of an intermediary between chain mail and plate armor.  This one has been hardened for extra protection."),
    replace_materials = { lc_steel = "ch_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_lamellar_ch",
    name = ccb.content.plural_text("hardened steel lamellar cuirass", "hardened steel lamellar cuirasses"),
    description = ccb.content.text("A hardened cuirass made of small strips of sheet metal laced together, something of an intermediary between chain mail and plate armor.  Built larger for a minotaur guarding their labyrinth."),
    copy_from = "armor_lamellar_ch",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_armor_lamellar_ch",
    copy_from = "armor_lamellar_ch",
    name = ccb.content.plural_text("hardened steel lamellar cuirass", "hardened steel lamellar cuirasses"),
    description = ccb.content.text("A hardened cuirass made of small strips of sheet metal laced together, something of an intermediary between chain mail and plate armor.  Just the right size for a fantasy dwarf."),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "armor_pipe_vest",
    name = ccb.content.text("pipe vest"),
    description = ccb.content.text("A cuirass made of pipe sections tied firmly together.  Very ugly, not that protective, but beats having no armor at all.  Probably."),
    mass = "15300 g",
    volume = "9 L",
    price = "260 USD",
    survival_price = "25 USD",
    materials = { "lc_steel" },
    symbol = "[",
    looks_like = "armor_lorica",
    color = "light_gray",
    length = "60 cm",
    flags = { "OUTER" },
    armor = {
        warmth = 10,
        portions = {
            {
                materials = {
                    { id = "lc_steel", coverage = 100, thickness = 3.0 },
                    { id = "cotton", coverage = 7, thickness = 3.0 },
                },
                encumbrance = 25,
                coverage = 70,
                ranged_coverage = 70,
                vitals_coverage = 90,
                covers = { "torso" },
            },
        },
    },
}

ccb.content.define_item {
    id = "makeshift_metal_plate_vest",
    name = ccb.content.text("makeshift metal plate vest"),
    description = ccb.content.text("This very crude armor is made from two pairs of jeans, filled with metal plates that are sewn in place.  One pair wraps around your waist, and the other over your shoulders.  It's very uncomfortable to wear, very ugly, but works kinda."),
    mass = "3700 g",
    volume = "9 L",
    price = "260 USD",
    survival_price = "25 USD",
    materials = { "lc_steel" },
    symbol = "[",
    looks_like = "armor_lorica",
    color = "light_gray",
    length = "45 cm",
    flags = { "OUTER" },
    armor = {
        warmth = 10,
        portions = {
            {
                materials = {
                    { id = "lc_steel", coverage = 67, thickness = 0.8 },
                    { id = "denim", coverage = 100, thickness = 1.4 },
                },
                encumbrance = 19,
                coverage = 90,
                ranged_coverage = 70,
                vitals_coverage = 100,
                covers = { "torso" },
            },
        },
    },
}

-- Human torso is 6 700cm^2, 80% coverage is 5357cm^2.  Thickness of 0.31cm, plastic density of 1g/cm^3 leaves us with 1 661 grams. 288g of cordage leaves us with 1 949 total, rounded up to 2 kg for error.
ccb.content.define_item {
    id = "crude_plastic_vest",
    name = ccb.content.text("crude plastic armor vest"),
    description = ccb.content.text("This plastic vest is made from pieces of a large trash can, held together with string."),
    mass = "2000 g",
    volume = "3 L",
    price = "10 USD",
    survival_price = "5 USD",
    materials = { "plastic" },
    symbol = "[",
    looks_like = "apron_plastic",
    color = "light_gray",
    length = "45 cm",
    flags = { "OUTER" },
    armor = {
        warmth = 10,
        portions = {
            {
                materials = { { id = "plastic", coverage = 100, thickness = 3.1 } },
                encumbrance = 16,
                coverage = 80,
                ranged_coverage = 70,
                vitals_coverage = 100,
                covers = { "torso" },
            },
        },
    },
}

-- Assuming roughly 1m^2 at a density of 1.4 lbs/ft^2
ccb.content.define_item {
    id = "carpet_cuirass",
    name = ccb.content.plural_text("carpet cuirass", "carpet cuirasses"),
    description = ccb.content.text("A rectangular length of tough carpet with a hole cut out for your head and tied around the waist.  It's decently protective for its weight and quite the fashion statement."),
    mass = "6800 g",
    volume = "9250 ml",
    price = "1 USD 20 cent",
    survival_price = "50 cent",
    materials = { "plastic", "carpet_pilling" },
    symbol = "[",
    looks_like = "tunic_rag",
    color = "red",
    length = "60 cm",
    flags = { "OUTER", "NO_REPAIR", "ALLOWS_GASTROPOD_FOOT", "ALLOWS_LEG_TENTACLES" },
    armor = {
        warmth = 15,
        thickness = 4,
        portions = {
            {
                materials = {
                    { id = "plastic", coverage = 100, thickness = 1.0 },
                    { id = "carpet_pilling", coverage = 100, thickness = 3.0 },
                },
                encumbrance = 10,
                coverage = 85,
                ranged_coverage = 95,
                vitals_coverage = 70,
                covers = { "torso" },
            },
            {
                materials = {
                    { id = "plastic", coverage = 100, thickness = 1.0 },
                    { id = "carpet_pilling", coverage = 100, thickness = 3.0 },
                },
                encumbrance = 5,
                coverage = 85,
                ranged_coverage = 95,
                vitals_coverage = 70,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_shoulder_r" },
            },
            {
                materials = {
                    { id = "plastic", coverage = 100, thickness = 1.0 },
                    { id = "carpet_pilling", coverage = 100, thickness = 3.0 },
                },
                encumbrance = 5,
                coverage = 85,
                ranged_coverage = 95,
                vitals_coverage = 70,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
            },
            {
                materials = {
                    { id = "plastic", coverage = 100, thickness = 1.0 },
                    { id = "carpet_pilling", coverage = 100, thickness = 3.0 },
                },
                encumbrance = 5,
                coverage = 85,
                ranged_coverage = 95,
                vitals_coverage = 70,
                covers = { "gastropod_foot" },
                subparts = { "leg_hip_gastropod_l", "leg_hip_gastropod_r" },
            },
            {
                covers = {
                    "tentacle_lower_front_l", "tentacle_lower_middle_l", "tentacle_lower_rear_l",
                    "tentacle_lower_front_r", "tentacle_lower_middle_r", "tentacle_lower_rear_r",
                },
                encumbrance = 5,
                coverage = 85,
                ranged_coverage = 95,
                vitals_coverage = 70,
                subparts = {
                    "tentacle_lower_front_base_l", "tentacle_lower_middle_base_l",
                    "tentacle_lower_rear_base_l", "tentacle_lower_middle_base_r",
                    "tentacle_lower_middle_base_r", "tentacle_lower_rear_base_r",
                },
            },
        },
    },
}

-- Reasoning for weight and volume parts are within the recipe.
ccb.content.define_item {
    id = "armor_aztec",
    category = "armor",
    name = ccb.content.text("ichcahuipilli"),
    description = ccb.content.text("A Mesoamerican armor of Nahuatl origin, somewhat similar to a European gambeson.  It is made of unspun cotton between two layers of quilted cotton crystallized by brine, edged with leather around its holes.  It is extremely thick and offers superb protection, but is also heavy.  This bad boy once stopped Spanish bullets and Aztec missiles alike, now its time has come to stop zombie bites."),
    mass = "8150 g",
    volume = "16300 ml",
    symbol = "[",
    color = "light_gray",
    looks_like = "gambeson",
    price = "200 USD",
    survival_price = "25 USD",
    materials = { "cotton" },
    flags = { "VARSIZE", "STURDY", "NORMAL", "RAINPROOF", "NO_REPAIR", "BLOCK_WHILE_WORN" },
    max_worn = 1,
    armor = {
        warmth = 80,
        environmental_protection = 4,
        portions = {
            {
                materials = {
                    { id = "cotton_quilted_salted", coverage = 100, thickness = 2.5 },
                    { id = "cotton", coverage = 95, thickness = 20 },
                    { id = "cotton_quilted_salted", coverage = 100, thickness = 2.5 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 40,
            },
        },
    },
}

ccb.content.define_item {
    id = "armor_lorica",
    name = ccb.content.plural_text("lorica segmentata", "lorica segmentata"),
    description = ccb.content.text("An ancient Roman laminar armor, made of overlapping metal strips connected to internal leather straps."),
    mass = "5286 g",
    volume = "6 L",
    price = "500 USD",
    survival_price = "35 USD",
    materials = { "iron", "leather" },
    symbol = "[",
    length = "60 cm",
    looks_like = "armor_lamellar",
    category = "armor",
    color = "light_gray",
    flags = { "VARSIZE", "OUTER", "STURDY" },
    armor = {
        warmth = 15,
        thickness = 4,
        portions = {
            { encumbrance = 15, coverage = 90, covers = { "torso" } },
            {
                encumbrance = 3,
                coverage = 90,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_r", "arm_shoulder_l" },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_armor_lorica",
    name = ccb.content.plural_text("lorica segmentata", "lorica segmentata"),
    copy_from = "armor_lorica",
    flags = { "VARSIZE", "STURDY", "OVERSIZE", "PREFIX_XL", "OUTER" },
    armor = {},
    inheritance = { scale = { mass = 1.125, volume = 1.13, price = 1.25 } },
}

ccb.content.define_item {
    id = "xs_armor_lorica",
    copy_from = "armor_lorica",
    name = ccb.content.plural_text("lorica segmentata", "lorica segmentata"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "armor_thessalonian",
    category = "armor",
    name = ccb.content.plural_text("cataphract armor", "suits of cataphract armor"),
    description = ccb.content.text("This armor, made of interlocking plates of burnished bronze, appears to be either a high-quality recreation or a genuine artifact.  Despite having an ancient design, it is in mint condition aside from some battle damage.  It covers from the shoulders to the hips and is of extremely high quality."),
    mass = "7286 g",
    volume = "6 L",
    price = "500 USD",
    survival_price = "70 USD",
    accuracy = { grip = "none", length = "short", surface = "any", balance = "clumsy" },
    materials = { "fancy_bronze", "leather" },
    symbol = "[",
    length = "60 cm",
    looks_like = "armor_lorica",
    color = "brown",
    flags = { "VARSIZE", "OUTER", "STURDY", "ALLOWS_GASTROPOD_FOOT", "ALLOWS_LEG_TENTACLES" },
    melee_damage = { bash = 6 },
    armor = {
        warmth = 18,
        thickness = 5,
        portions = {
            {
                encumbrance = 17,
                coverage = 93,
                melee_coverage = 95,
                ranged_coverage = 90,
                vitals_coverage = 100,
                covers = { "torso" },
            },
            {
                encumbrance = 17,
                coverage = 93,
                melee_coverage = 95,
                ranged_coverage = 90,
                vitals_coverage = 100,
                covers = { "arm_l", "arm_r" },
            },
            {
                encumbrance = 4,
                coverage = 93,
                melee_coverage = 95,
                ranged_coverage = 90,
                vitals_coverage = 100,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
            },
            {
                encumbrance = 4,
                coverage = 93,
                melee_coverage = 95,
                ranged_coverage = 90,
                vitals_coverage = 100,
                covers = { "gastropod_foot" },
                subparts = { "leg_hip_gastropod_l", "leg_hip_gastropod_r" },
            },
            {
                covers = {
                    "tentacle_lower_front_l", "tentacle_lower_middle_l", "tentacle_lower_rear_l",
                    "tentacle_lower_front_r", "tentacle_lower_middle_r", "tentacle_lower_rear_r",
                },
                encumbrance = 4,
                coverage = 93,
                melee_coverage = 95,
                ranged_coverage = 90,
                vitals_coverage = 100,
                subparts = {
                    "tentacle_lower_front_base_l", "tentacle_lower_middle_base_l",
                    "tentacle_lower_rear_base_l", "tentacle_lower_middle_base_r",
                    "tentacle_lower_middle_base_r", "tentacle_lower_rear_base_r",
                },
            },
        },
    },
}

-- The weight assumes the sheet metal is 75cm x 50cm x 1.5mm.
ccb.content.define_item {
    id = "chestguard_metal_sheets",
    category = "armor",
    name = ccb.content.text("sheet metal chest guard"),
    description = ccb.content.text("Two sheets of metal hammered to fit your torso and riveted to leather belts to act as straps.  Heavy, uncomfortable, and difficult to move in, but it should help keep your blood inside your body."),
    mass = "8800 g",
    volume = "4 L",
    price = "5 USD",
    survival_price = "4 USD",
    materials = { "lc_steel" },
    symbol = "H",
    looks_like = "cuirass_lightplate",
    color = "light_gray",
    length = "75 cm",
    flags = { "OUTER", "WATER_FRIENDLY" },
    armor = {
        warmth = 10,
        thickness = 1.5,
        environmental_protection = 2,
        portions = { { encumbrance = 18, coverage = 95, covers = { "torso" } } },
    },
}

ccb.content.define_item {
    id = "ch_chestguard_metal_sheets",
    copy_from = "chestguard_metal_sheets",
    name = ccb.content.text("hardened sheet metal chest guard"),
    description = ccb.content.text("A chest guard made of hammered sheet metal, hardened for added protection.  It's not any easier to move in, but it is much sturdier now."),
    replace_materials = { lc_steel = "ch_steel" },
    armor = {},
    inheritance = { add = { flags = { "STURDY" } } },
}

-- The weight assumes the sheet metal is 75cm x 50cm x 1.5mm, doubled.
ccb.content.define_item {
    id = "chestguard_metal_sheets_heavy",
    category = "armor",
    name = ccb.content.text("heavy sheet metal chest guard"),
    description = ccb.content.text("A double-decker chest guard made from two sheets of metal layered over each other and hammered to fit your torso.  Monstrously heavy, but it's quite protective and the thicker material makes it sturdier."),
    mass = "17600 g",
    volume = "4 L",
    price = "10 USD",
    survival_price = "4 USD",
    accuracy = { grip = "none", length = "short", surface = "any", balance = "clumsy" },
    materials = { "lc_steel" },
    repair_materials = { "steel" },
    symbol = "H",
    looks_like = "cuirass_lightplate",
    color = "light_gray",
    length = "75 cm",
    flags = { "OUTER", "WATER_FRIENDLY", "STURDY" },
    armor = {
        warmth = 10,
        thickness = 3,
        environmental_protection = 2,
        portions = { { encumbrance = 30, coverage = 95, covers = { "torso" } } },
    },
}

ccb.content.define_item {
    id = "ch_chestguard_metal_sheets_heavy",
    copy_from = "chestguard_metal_sheets_heavy",
    name = ccb.content.text("hardened heavy sheet metal chest guard"),
    description = ccb.content.text("Double-thick, hardened sheet metal hammered to fit your torso.  Offers the best protection a junkyard knight could ask for."),
    materials = { "ch_steel" },
    armor = {},
}

-- The weight assumes the sheets are 35cm x 50cm x 1.5mm.
ccb.content.define_item {
    id = "chestguard_metal_sheets_light",
    category = "armor",
    name = ccb.content.text("light sheet metal chest guard"),
    description = ccb.content.text("One sheet of metal, cut in half to only cover your upper torso and back and riveted to leather belts to act as straps.  It's heavy and uncomfortable, but at least you can bend at the waist."),
    mass = "4400 g",
    volume = "2 L",
    price = "5 USD",
    survival_price = "4 USD",
    materials = { "lc_steel" },
    repair_materials = { "steel" },
    symbol = "H",
    looks_like = "chestguard_metal",
    color = "light_gray",
    length = "50 cm",
    flags = { "OUTER", "WATER_FRIENDLY" },
    armor = {
        warmth = 5,
        thickness = 1.5,
        environmental_protection = 1,
        portions = {
            {
                covers = { "torso" },
                encumbrance = 4,
                coverage = 95,
                melee_coverage = 95,
                ranged_coverage = 90,
                vitals_coverage = 90,
                subparts = { "torso_upper" },
            },
        },
    },
}

ccb.content.define_item {
    id = "ch_chestguard_metal_sheets_light",
    copy_from = "chestguard_metal_sheets_light",
    name = ccb.content.text("hardened light sheet metal chest guard"),
    description = ccb.content.text("Sheet metal cut to only cover your upper torso and hardened for extra protection.  Provides a decent compromise between protection and being able to move."),
    materials = { "ch_steel" },
    armor = {},
    inheritance = { add = { flags = { "STURDY" } } },
}

ccb.content.define_item {
    id = "bookplate",
    category = "armor",
    name = ccb.content.text("bookplate"),
    description = ccb.content.text("A crude form of armor made from thickly-stacked paper and rolls of duct tape."),
    mass = "5790 g",
    volume = "9500 ml",
    price = "42 USD",
    survival_price = "1 USD",
    materials = { "paper" },
    symbol = "O",
    looks_like = "armor_scrapsuit",
    color = "light_gray",
    length = "60 cm",
    flags = { "OUTER" },
    armor = {
        warmth = 10,
        thickness = 12,
        portions = { { encumbrance = 20, coverage = 80, covers = { "torso" } } },
    },
}

ccb.content.define_item {
    id = "tireplate",
    category = "armor",
    name = ccb.content.text("tireplate"),
    description = ccb.content.text("Armor fashioned from overlapping chunks of tire and rolls of duct tape, covering the shoulders and torso."),
    mass = "5790 g",
    volume = "9500 ml",
    price = "42 USD",
    survival_price = "1 USD",
    materials = { "rubber" },
    symbol = "O",
    looks_like = "armor_scrapsuit",
    color = "light_gray",
    length = "40 cm",
    flags = { "OUTER", "NONCONDUCTIVE" },
    armor = {
        warmth = 10,
        thickness = 4,
        portions = { { encumbrance = 20, coverage = 80, covers = { "torso" } } },
    },
}
