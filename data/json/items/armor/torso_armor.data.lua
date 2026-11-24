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

-- NO_I18N
ccb.content.define_item {
    id = "base_chainmail_vest",
    abstract = true,
    category = "armor",
    name = ccb.content.text_without_extraction("base chainmail vest"),
    description = ccb.content.text("A customized mild steel chainmail vest.  It's a sleeveless piece of chainmail with small straps designed to better distribute the weight."),
    mass = "6894 g",
    volume = "1 L",
    length = "10 cm",
    price = "100 USD",
    survival_price = "20 USD",
    materials = { "steel" },
    symbol = "[",
    looks_like = "vest_leather",
    color = "light_red",
    flags = { "VARSIZE", "STURDY", "OUTER", "ALLOWS_GASTROPOD_FOOT", "ALLOWS_LEG_TENTACLES" },
    pockets = {
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "9350 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_TORSO" },
        },
    },
    armor = {
        warmth = 0,
        portions = {
            {
                materials = { { id = "steel", coverage = 100, thickness = 1.2 } },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 14,
            },
            {
                materials = { { id = "steel", coverage = 100, thickness = 1.2 } },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
                coverage = 50,
                encumbrance = 0,
            },
            {
                materials = { { id = "steel", coverage = 100, thickness = 1.2 } },
                covers = { "gastropod_foot" },
                coverage = 50,
                encumbrance = 0,
                subparts = { "leg_hip_gastropod_l", "leg_hip_gastropod_r" },
            },
            {
                covers = {
                    "tentacle_lower_front_l", "tentacle_lower_middle_l", "tentacle_lower_rear_l",
                    "tentacle_lower_front_r", "tentacle_lower_middle_r", "tentacle_lower_rear_r",
                },
                materials = { { id = "steel", coverage = 100, thickness = 1.2 } },
                encumbrance = 0,
                coverage = 50,
                subparts = {
                    "tentacle_lower_front_base_l", "tentacle_lower_middle_base_l",
                    "tentacle_lower_rear_base_l", "tentacle_lower_middle_base_r",
                    "tentacle_lower_middle_base_r", "tentacle_lower_rear_base_r",
                },
            },
            {
                materials = { { id = "steel", coverage = 100, thickness = 1.2 } },
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_shoulder_r" },
                coverage = 50,
                encumbrance = 0,
            },
        },
    },
}

-- NO_I18N
ccb.content.define_item {
    id = "xl_chainmail_vest",
    abstract = true,
    name = ccb.content.text_without_extraction("chainmail vest"),
    copy_from = "base_chainmail_vest",
    pockets = {
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "10500 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_TORSO" },
        },
    },
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
}

-- NO_I18N
ccb.content.define_item {
    id = "xs_chainmail_vest",
    abstract = true,
    copy_from = "base_chainmail_vest",
    name = ccb.content.text_without_extraction("chainmail vest"),
    pockets = {
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "7000 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_TORSO" },
        },
    },
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
    armor = {},
}

ccb.content.define_item {
    id = "chainmail_junk_vest",
    copy_from = "base_chainmail_vest",
    replace_materials = { steel = "budget_steel_chain" },
    name = ccb.content.text("chainmail vest"),
    description = ccb.content.text("A customized chainmail vest.  The metal shows signs of rust and corrosion.  It's a sleeveless piece of chainmail with small straps designed to better distribute the weight."),
    armor = {},
}

ccb.content.define_item {
    id = "lc_chainmail_vest",
    copy_from = "base_chainmail_vest",
    replace_materials = { steel = "lc_steel_chain" },
    name = ccb.content.text("mild steel chainmail vest"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_lc_chainmail_vest",
    copy_from = "xl_chainmail_vest",
    replace_materials = { steel = "lc_steel_chain" },
    name = ccb.content.text("mild steel chainmail vest"),
    armor = {},
}

ccb.content.define_item {
    id = "xs_lc_chainmail_vest",
    copy_from = "xs_chainmail_vest",
    replace_materials = { steel = "lc_steel_chain" },
    name = ccb.content.text("mild steel chainmail vest"),
    armor = {},
}

ccb.content.define_item {
    id = "mc_chainmail_vest",
    copy_from = "base_chainmail_vest",
    replace_materials = { steel = "mc_steel_chain" },
    name = ccb.content.text("medium steel chainmail vest"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_mc_chainmail_vest",
    copy_from = "xl_chainmail_vest",
    replace_materials = { steel = "mc_steel_chain" },
    name = ccb.content.text("medium steel chainmail vest"),
    armor = {},
}

ccb.content.define_item {
    id = "xs_mc_chainmail_vest",
    copy_from = "xs_chainmail_vest",
    replace_materials = { steel = "mc_steel_chain" },
    name = ccb.content.text("medium steel chainmail vest"),
    armor = {},
}

ccb.content.define_item {
    id = "hc_chainmail_vest",
    copy_from = "base_chainmail_vest",
    replace_materials = { steel = "hc_steel_chain" },
    name = ccb.content.text("high steel chainmail vest"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_hc_chainmail_vest",
    copy_from = "xl_chainmail_vest",
    replace_materials = { steel = "hc_steel_chain" },
    name = ccb.content.text("high steel chainmail vest"),
    armor = {},
}

ccb.content.define_item {
    id = "xs_hc_chainmail_vest",
    copy_from = "xs_chainmail_vest",
    replace_materials = { steel = "hc_steel_chain" },
    name = ccb.content.text("high steel chainmail vest"),
    armor = {},
}

ccb.content.define_item {
    id = "ch_chainmail_vest",
    copy_from = "base_chainmail_vest",
    replace_materials = { steel = "ch_steel_chain" },
    name = ccb.content.text("hardened steel chainmail vest"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_ch_chainmail_vest",
    copy_from = "xl_chainmail_vest",
    replace_materials = { steel = "ch_steel_chain" },
    name = ccb.content.text("hardened steel chainmail vest"),
    armor = {},
}

ccb.content.define_item {
    id = "xs_ch_chainmail_vest",
    copy_from = "xs_chainmail_vest",
    replace_materials = { steel = "ch_steel_chain" },
    name = ccb.content.text("hardened steel chainmail vest"),
    armor = {},
}

ccb.content.define_item {
    id = "qt_chainmail_vest",
    copy_from = "base_chainmail_vest",
    replace_materials = { steel = "qt_steel_chain" },
    name = ccb.content.text("tempered steel chainmail vest"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_qt_chainmail_vest",
    copy_from = "xl_chainmail_vest",
    replace_materials = { steel = "qt_steel_chain" },
    name = ccb.content.text("tempered steel chainmail vest"),
    armor = {},
}

ccb.content.define_item {
    id = "xs_qt_chainmail_vest",
    copy_from = "xs_chainmail_vest",
    replace_materials = { steel = "qt_steel_chain" },
    name = ccb.content.text("tempered steel chainmail vest"),
    armor = {},
}

ccb.content.define_item {
    id = "cloth_shirt_padded",
    category = "armor",
    name = ccb.content.text("cloth-padded shirt"),
    description = ccb.content.text("A thick cotton sweatshirt that an amateur tailor sewed ever-increasing amounts of cloth onto, providing noticeable, if haphazard padding."),
    mass = "1000 g",
    volume = "3500 ml",
    survival_price = "2 USD",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "sweatshirt",
    color = "light_gray",
    flags = { "VARSIZE" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "cotton", coverage = 100, thickness = 1.0 },
                    { id = "cotton", coverage = 90, thickness = 1.0 },
                    { id = "cotton", coverage = 90, thickness = 1.0 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 8,
            },
            {
                materials = {
                    { id = "cotton", coverage = 100, thickness = 1.0 },
                    { id = "cotton", coverage = 90, thickness = 1.0 },
                    { id = "cotton", coverage = 90, thickness = 1.0 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 8,
            },
        },
        warmth = 35,
        thickness = 3,
        environmental_protection = 2,
    },
}

ccb.content.define_item {
    id = "cloth_vest_padded",
    category = "armor",
    name = ccb.content.text("cloth-padded sleeveless shirt"),
    description = ccb.content.text("A thick cotton shirt with the sleeves cut off and large amounts of cloth sewn in to make a padded vest.  It would be fashionable, if not for all the disparate colors from the patchwork cotton cannibalized from other random clothes."),
    mass = "600 g",
    volume = "2000 ml",
    survival_price = "1 USD",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "tank_top",
    color = "light_gray",
    flags = { "VARSIZE" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "cotton", coverage = 100, thickness = 1.0 },
                    { id = "cotton", coverage = 90, thickness = 1.0 },
                    { id = "cotton", coverage = 90, thickness = 1.0 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 8,
            },
        },
        warmth = 35,
        thickness = 3,
        environmental_protection = 2,
    },
}

ccb.content.define_item {
    id = "chestguard_hard",
    category = "armor",
    name = ccb.content.text("hard chest guard"),
    description = ccb.content.text("A solid vest of plastic padding protecting your torso."),
    mass = "1000 g",
    volume = "7 L",
    price = "600 USD",
    survival_price = "5 USD",
    materials = { "plastic", "neoprene" },
    symbol = "H",
    looks_like = "cuirass_lightplate",
    color = "dark_gray",
    length = "20 cm",
    flags = { "WATER_FRIENDLY", "STURDY", "OUTER" },
    armor = {
        warmth = 15,
        thickness = 4,
        environmental_protection = 1,
        portions = { { encumbrance = 4, coverage = 90, covers = { "torso" } } },
    },
}

ccb.content.define_item {
    id = "cuirass_lightplate",
    category = "armor",
    name = ccb.content.plural_text("cuirass", "cuirasses"),
    description = ccb.content.text("A steel breastplate, and a vital part of plate armor.  Even as full armor went into decline, cuirasses remained in use among cavalry in Europe."),
    mass = "4200 g",
    volume = "6 L",
    price = "200 USD",
    survival_price = "40 USD",
    accuracy = { grip = "none", length = "short", surface = "any", balance = "clumsy" },
    materials = { "steel", "leather" },
    symbol = "[",
    looks_like = "chestguard_hard",
    color = "light_gray",
    length = "60 cm",
    flags = { "VARSIZE", "OUTER", "STURDY", "ALLOWS_GASTROPOD_FOOT", "ALLOWS_LEG_TENTACLES" },
    armor = {
        warmth = 20,
        thickness = 4,
        portions = {
            { encumbrance = 20, coverage = 95, covers = { "torso" } },
            {
                encumbrance = 4,
                coverage = 95,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_shoulder_r" },
            },
            {
                encumbrance = 4,
                coverage = 95,
                covers = { "leg_l", "leg_r", "gastropod_foot" },
                subparts = { "leg_hip_l", "leg_hip_r", "leg_hip_gastropod_l", "leg_hip_gastropod_r" },
            },
            {
                covers = {
                    "tentacle_lower_front_l", "tentacle_lower_middle_l", "tentacle_lower_rear_l",
                    "tentacle_lower_front_r", "tentacle_lower_middle_r", "tentacle_lower_rear_r",
                },
                coverage = 95,
                encumbrance = 3,
                subparts = {
                    "tentacle_lower_front_base_l", "tentacle_lower_middle_base_l",
                    "tentacle_lower_rear_base_l", "tentacle_lower_middle_base_r",
                    "tentacle_lower_middle_base_r", "tentacle_lower_rear_base_r",
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_cuirass_lightplate",
    name = ccb.content.plural_text("cuirass", "cuirasses"),
    copy_from = "cuirass_lightplate",
    flags = { "VARSIZE", "STURDY", "OVERSIZE", "PREFIX_XL", "OUTER" },
    armor = {},
    inheritance = { scale = { mass = 1.125, volume = 1.13, price = 1.25 } },
}

ccb.content.define_item {
    id = "xs_cuirass_lightplate",
    copy_from = "cuirass_lightplate",
    name = ccb.content.plural_text("cuirass", "cuirasses"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "cuirass_scrap",
    category = "armor",
    name = ccb.content.plural_text("scrap cuirass", "scrap cuirasses"),
    description = ccb.content.text("Jagged metal scraps crudely lashed to your torso with frayed cords.  Gaps leave skin exposed and movement feels really awkward."),
    mass = "6200 g",
    volume = "5750 ml",
    price = "4 USD",
    survival_price = "2 USD",
    accuracy = { grip = "none", length = "short", surface = "any", balance = "clumsy" },
    materials = { "budget_steel", "cotton" },
    repair_materials = { "budget_steel" },
    symbol = "[",
    looks_like = "cuirass_lightplate",
    color = "light_gray",
    length = "40 cm",
    flags = { "OUTER" },
    melee_damage = { bash = 2, cut = 3 },
    armor = {
        warmth = 10,
        portions = {
            {
                materials = {
                    { id = "budget_steel", coverage = 60, thickness = 2.2 },
                    { id = "cotton", coverage = 100, thickness = 1.0 },
                },
                covers = { "torso" },
                coverage = 70,
                encumbrance = 22,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_cuirass_scrap",
    name = ccb.content.plural_text("scrap cuirass", "scrap cuirasses"),
    copy_from = "cuirass_scrap",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_cuirass_scrap",
    copy_from = "cuirass_scrap",
    name = ccb.content.plural_text("scrap cuirass", "scrap cuirasses"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "cuirass_tire",
    category = "armor",
    name = ccb.content.plural_text("tire cuirass", "tire cuirasses"),
    description = ccb.content.text("A cuirass made from thick chunks of tire secured by simple strings; the loose collection of rubber plates provides decent but not the most convenient protection."),
    mass = "4800 g",
    volume = "5750 ml",
    price = "200 USD",
    survival_price = "50 cent",
    materials = { "rubber" },
    symbol = "[",
    looks_like = "cuirass_lightplate",
    color = "light_gray",
    length = "40 cm",
    flags = { "OUTER", "NONCONDUCTIVE" },
    armor = {
        warmth = 10,
        thickness = 4,
        portions = { { encumbrance = 18, coverage = 80, covers = { "torso" } } },
    },
}

ccb.content.define_item {
    id = "xl_cuirass_tire",
    name = ccb.content.plural_text("tire cuirass", "tire cuirasses"),
    copy_from = "cuirass_scrap",
    flags = { "OVERSIZE", "PREFIX_XL", "OUTER", "NONCONDUCTIVE" },
    armor = {},
    inheritance = { scale = { mass = 1.125, volume = 1.13, price = 1.25 } },
}

ccb.content.define_item {
    id = "xs_cuirass_tire",
    copy_from = "cuirass_tire",
    name = ccb.content.plural_text("tire cuirass", "tire cuirasses"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "fencing_jacket",
    category = "armor",
    name = ccb.content.text("fencing jacket"),
    description = ccb.content.text("A padded jacket with a zipper on the back, used by fencers to prevent accidents."),
    mass = "800 g",
    volume = "2500 ml",
    price = "30 USD",
    survival_price = "1 USD",
    materials = { "cotton", "nylon" },
    symbol = "[",
    looks_like = "coat_lab",
    color = "white",
    flags = { "STURDY" },
    armor = {
        warmth = 20,
        thickness = 3,
        valid_mods = { "steel_padded" },
        portions = { { encumbrance = 5, coverage = 100, covers = { "torso", "arm_l", "arm_r" } } },
    },
}

ccb.content.define_item {
    id = "jacket_leather_mod",
    category = "armor",
    name = ccb.content.text("armored motorcycle jacket"),
    description = ccb.content.text("A thick motorcycle jacket with metal plates drilled onto various areas for increased protection."),
    mass = "7500 g",
    volume = "4500 ml",
    price = "179 USD",
    survival_price = "25 USD",
    materials = { "leather", "lc_steel" },
    symbol = "[",
    looks_like = "jacket_leather",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "500 ml",
            mass_limit = "2 kg",
            moves = 80,
            max_item_length = "10 cm",
        },
        {
            kind = "CONTAINER",
            capacity = "500 ml",
            mass_limit = "2 kg",
            moves = 80,
            max_item_length = "10 cm",
        },
    },
    flags = { "VARSIZE", "POCKETS", "OUTER", "STURDY" },
    armor = {
        portions = {
            {
                covers = { "torso" },
                coverage = 100,
                encumbrance = { 20, 21 },
                materials = {
                    { id = "leather", coverage = 100, thickness = 1.5 },
                    { id = "lc_steel", coverage = 80, thickness = 1.5 },
                },
            },
            {
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = { 20, 20 },
                materials = {
                    { id = "leather", coverage = 100, thickness = 1.5 },
                    { id = "lc_steel", coverage = 75, thickness = 1.5 },
                },
            },
        },
        warmth = 35,
        environmental_protection = 3,
    },
}

ccb.content.define_item {
    id = "jacket_jean_mod",
    category = "armor",
    name = ccb.content.text("armored jean jacket"),
    description = ccb.content.text("A denim jacket reinforced with metal plates.  Adequately protective, but not very sturdy."),
    mass = "6350 g",
    volume = "5750 ml",
    price = "150 USD",
    survival_price = "20 USD",
    materials = { "denim", "lc_steel" },
    symbol = "[",
    looks_like = "jacket_jean",
    color = "light_blue",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1500 ml",
            mass_limit = "2 kg",
            max_item_length = "15 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1500 ml",
            mass_limit = "2 kg",
            max_item_length = "15 cm",
            moves = 80,
        },
    },
    flags = { "VARSIZE", "POCKETS", "OUTER" },
    armor = {
        portions = {
            {
                covers = { "torso" },
                coverage = 100,
                encumbrance = { 15, 16 },
                materials = {
                    { id = "denim", coverage = 100, thickness = 0.95 },
                    { id = "lc_steel", coverage = 80, thickness = 1.5 },
                },
            },
            {
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = { 15, 15 },
                materials = {
                    { id = "denim", coverage = 100, thickness = 0.95 },
                    { id = "lc_steel", coverage = 75, thickness = 1.5 },
                },
            },
        },
        warmth = 25,
        environmental_protection = 1,
    },
}

ccb.content.define_item {
    id = "vest_jean_mod",
    category = "armor",
    name = ccb.content.text("armored jean vest"),
    description = ccb.content.text("A denim vest reinforced with metal plates.  Adequately protective, but not very sturdy."),
    mass = "4100 g",
    volume = "4100 ml",
    price = "130 USD",
    survival_price = "18 USD",
    materials = { "denim", "lc_steel" },
    symbol = "[",
    looks_like = "jacket_jean",
    color = "light_blue",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1500 ml",
            mass_limit = "2 kg",
            max_item_length = "15 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1500 ml",
            mass_limit = "2 kg",
            max_item_length = "15 cm",
            moves = 80,
        },
    },
    flags = { "VARSIZE", "POCKETS", "OUTER" },
    armor = {
        portions = {
            {
                covers = { "torso" },
                coverage = 100,
                encumbrance = { 15, 16 },
                materials = {
                    { id = "denim", coverage = 100, thickness = 0.55 },
                    { id = "lc_steel", coverage = 80, thickness = 1.5 },
                },
            },
        },
        warmth = 20,
        environmental_protection = 1,
    },
}

ccb.content.define_item {
    id = "jacket_leather_mod_ch",
    name = ccb.content.text("hardened armored motorcycle jacket"),
    description = ccb.content.text("A thick motorcycle jacket with hardened metal plates drilled onto various areas for highly increased protection."),
    copy_from = "jacket_leather_mod",
    survival_price = "35 USD",
    materials = { "leather", "ch_steel" },
    looks_like = "jacket_leather_mod",
    armor = {
        portions = {
            {
                covers = { "torso" },
                coverage = 100,
                encumbrance = { 20, 21 },
                materials = {
                    { id = "leather", coverage = 100, thickness = 1.5 },
                    { id = "ch_steel", coverage = 80, thickness = 1.5 },
                },
            },
            {
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = { 20, 20 },
                materials = {
                    { id = "leather", coverage = 100, thickness = 1.5 },
                    { id = "ch_steel", coverage = 75, thickness = 1.5 },
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "jacket_jean_mod_ch",
    name = ccb.content.text("hardened armored jean jacket"),
    description = ccb.content.text("A denim jacket reinforced with hardened steel plates.  Highly protective, but not very sturdy."),
    copy_from = "jacket_jean_mod",
    survival_price = "30 USD",
    materials = { "denim", "ch_steel" },
    looks_like = "jacket_jean_mod",
    armor = {
        portions = {
            {
                covers = { "torso" },
                coverage = 100,
                encumbrance = { 15, 16 },
                materials = {
                    { id = "denim", coverage = 100, thickness = 0.95 },
                    { id = "ch_steel", coverage = 80, thickness = 1.5 },
                },
            },
            {
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = { 15, 15 },
                materials = {
                    { id = "denim", coverage = 100, thickness = 0.95 },
                    { id = "ch_steel", coverage = 75, thickness = 1.5 },
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "vest_jean_mod_ch",
    name = ccb.content.text("hardened armored jean vest"),
    description = ccb.content.text("A denim vest reinforced with hardened steel plates.  Highly protective, but not very sturdy."),
    copy_from = "vest_jean_mod",
    survival_price = "28 USD",
    materials = { "denim", "ch_steel" },
    looks_like = "jacket_jean_mod",
    armor = {
        portions = {
            {
                covers = { "torso" },
                coverage = 100,
                encumbrance = { 15, 16 },
                materials = {
                    { id = "denim", coverage = 100, thickness = 0.95 },
                    { id = "ch_steel", coverage = 80, thickness = 1.5 },
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "jacket_leather_bone",
    name = ccb.content.text("occult bone armor"),
    description = ccb.content.text("A black jacket made from thick leather and covered with intricately carved bones.  You've never seen patterns like those before, each time you look at them you spot a new one as if they were changing on their own."),
    copy_from = "jacket_leather_mod",
    mass = "5000 g",
    volume = "6000 ml",
    survival_price = "20 USD",
    materials = { "leather", "bone" },
    armor = {
        portions = {
            {
                covers = { "torso" },
                coverage = 100,
                encumbrance = { 20, 21 },
                materials = {
                    { id = "leather", coverage = 100, thickness = 1.5 },
                    { id = "bone", coverage = 80, thickness = 2.5 },
                },
            },
            {
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = { 20, 20 },
                materials = {
                    { id = "leather", coverage = 100, thickness = 1.5 },
                    { id = "bone", coverage = 75, thickness = 2.5 },
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "jacket_leather_tire",
    category = "armor",
    name = ccb.content.plural_text("tire motorcycle jacket", "tire motorcycle jacket"),
    description = ccb.content.text("A motorcycle jacket reinforced with chunks of thick rubber tire.  Thick and highly resistant to blunt force."),
    mass = "5800 g",
    volume = "6 L",
    survival_price = "25 USD",
    materials = { "rubber", "leather" },
    copy_from = "jacket_leather_mod",
    color = "light_gray",
    armor = {
        portions = {
            {
                covers = { "torso" },
                coverage = 100,
                encumbrance = { 20, 21 },
                materials = {
                    { id = "leather", coverage = 100, thickness = 1.5 },
                    { id = "rubber", coverage = 80, thickness = 3.0 },
                },
            },
            {
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = { 20, 20 },
                materials = {
                    { id = "leather", coverage = 100, thickness = 1.5 },
                    { id = "rubber", coverage = 75, thickness = 3.0 },
                },
            },
        },
        warmth = 40,
        environmental_protection = 5,
    },
}

ccb.content.define_item {
    id = "lame_foil",
    category = "armor",
    name = ccb.content.plural_text("lamé (foil)", "lamés (foil)"),
    description = ccb.content.text("A thin, lightweight conductive vest with the zipper on the back used by fencers for electronic scoring.  Its outer layer is a woven mix of sturdy cotton and stainless steel strands."),
    mass = "843 g",
    volume = "2500 ml",
    price = "30 USD",
    survival_price = "2 USD 50 cent",
    materials = { "cotton", "budget_steel" },
    symbol = "[",
    color = "light_gray",
    flags = { "VARSIZE", "OUTER" },
    armor = {
        warmth = 10,
        thickness = 1,
        portions = { { encumbrance = 8, coverage = 100, covers = { "torso" } } },
    },
}

ccb.content.define_item {
    id = "lame_saber",
    category = "armor",
    name = ccb.content.plural_text("lamé (saber)", "lamés (saber)"),
    description = ccb.content.text("A thin, lightweight conductive jacket used by fencers for electronic scoring.  Its outer layer is a woven mix of sturdy cotton and stainless steel strands."),
    mass = "1043 g",
    volume = "2500 ml",
    price = "85 USD",
    survival_price = "2 USD 50 cent",
    materials = { "cotton", "budget_steel" },
    symbol = "[",
    color = "light_gray",
    flags = { "VARSIZE", "OUTER" },
    armor = {
        warmth = 10,
        thickness = 1,
        portions = { { encumbrance = 8, coverage = 100, covers = { "torso", "arm_l", "arm_r" } } },
    },
}

ccb.content.define_item {
    id = "football_armor",
    category = "armor",
    name = ccb.content.text("football armor"),
    description = ccb.content.text("Heavy polycarbonate armor for your upper torso.  Normally worn by football players."),
    mass = "2810 g",
    volume = "7 L",
    price = "110 USD",
    survival_price = "2 USD 50 cent",
    materials = { "thermo_resin", "cotton", "plastic_pad" },
    symbol = "[",
    looks_like = "chestguard_hard",
    color = "light_gray",
    flags = { "OUTER" },
    armor = {
        warmth = 5,
        portions = {
            {
                encumbrance = 5,
                coverage = 90,
                covers = { "torso" },
                subparts = { "torso_upper" },
                materials = {
                    { id = "thermo_resin", coverage = 90, thickness = 1.0 },
                    { id = "cotton", coverage = 100, thickness = 0.5 },
                    { id = "plastic_pad", coverage = 100, thickness = 8.0 },
                },
            },
            {
                encumbrance = 4,
                coverage = 100,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_shoulder_r" },
                materials = {
                    { id = "plastic_pad", coverage = 100, thickness = 8.0 },
                    { id = "thermo_resin", coverage = 80, thickness = 1.0 },
                    { id = "thermo_resin", coverage = 80, thickness = 1.0 },
                },
            },
        },
    },
}

-- encumbrance handled above
ccb.content.define_item {
    id = "kevlar",
    category = "armor",
    name = ccb.content.text("Kevlar vest"),
    description = ccb.content.text("A lightweight level II ballistic vest, suitable for wearing under a coat or other outer wear."),
    mass = "1960 g",
    volume = "4 L",
    price = "350 USD",
    survival_price = "12 USD 50 cent",
    materials = { "kevlar_layered", "nylon" },
    symbol = "[",
    looks_like = "vest_leather",
    color = "light_gray",
    flags = { "STURDY" },
    armor = {
        warmth = 15,
        thickness = 4,
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.5 },
                    {
                        id = "kevlar_layered",
                        coverage = 95,
                        thickness = 3.3,
                        ignore_sheet_thickness = true,
                    },
                },
                encumbrance = 3,
                coverage = 94,
                vitals_coverage = 70,
                covers = { "torso" },
                subparts = { "torso_upper" },
            },
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.5 },
                    {
                        id = "kevlar_layered",
                        coverage = 95,
                        thickness = 3.3,
                        ignore_sheet_thickness = true,
                    },
                },
                encumbrance = 0,
                coverage = 85,
                vitals_coverage = 60,
                covers = { "torso" },
                subparts = { "torso_lower" },
            },
        },
    },
}

ccb.content.define_item {
    id = "motorbike_armor",
    category = "armor",
    name = ccb.content.text("motorcycle armor"),
    description = ccb.content.text("A light jacket made of a stretch mesh covered in plastic pads meant for motorcyclists.  Made to be much more comfortable to wear than leather alternatives, but the underlying Lycra isn't protective at all."),
    mass = "1066 g",
    volume = "2 L",
    price = "150 USD",
    survival_price = "10 USD",
    materials = { "plastic_pad", "lycra" },
    symbol = "[",
    looks_like = "jacket_leather",
    color = "dark_gray",
    flags = { "VARSIZE", "WATERPROOF", "OUTER", "BLOCK_WHILE_WORN" },
    melee_damage = { bash = 2 },
    armor = {
        portions = {
            {
                materials = {
                    { id = "lycra", coverage = 100, thickness = 0.25 },
                    { id = "plastic_pad", coverage = 90, thickness = 12 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 10,
            },
            {
                materials = {
                    { id = "lycra", coverage = 100, thickness = 0.25 },
                    { id = "plastic_pad", coverage = 85, thickness = 12 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 10,
            },
        },
        warmth = 15,
        thickness = 4,
        environmental_protection = 1,
    },
}

ccb.content.define_item {
    id = "plastron_cotton",
    category = "armor",
    name = ccb.content.text("underarm protector"),
    description = ccb.content.text("A sturdy cotton plastron that protects much of the torso, the dominant shoulder, and underarm while fencing."),
    mass = "110 g",
    volume = "500 ml",
    price = "16 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    color = "white",
    flags = { "SKINTIGHT" },
    armor = { warmth = 5, thickness = 3, portions = { { coverage = 65, covers = { "torso" } } } },
}

ccb.content.define_item {
    id = "plastron_plastic",
    category = "armor",
    name = ccb.content.text("plastic chest protector"),
    description = ccb.content.text("A rigid plastic plastron with molded cups to be worn by female fencers for protection while fencing."),
    mass = "194 g",
    volume = "850 ml",
    price = "30 USD",
    survival_price = "50 cent",
    materials = { "plastic" },
    symbol = "[",
    color = "white",
    flags = { "SKINTIGHT" },
    armor = {
        warmth = 5,
        thickness = 3,
        portions = { { encumbrance = 2, coverage = 60, covers = { "torso" }, subparts = { "torso_upper" } } },
    },
}

ccb.content.define_item {
    id = "vest_leather_mod",
    category = "armor",
    name = ccb.content.text("armored leather vest"),
    description = ccb.content.text("An armored vest made from thick leather and metal plates."),
    mass = "4000 g",
    volume = "3 L",
    price = "179 USD",
    survival_price = "12 USD",
    materials = { "leather", "lc_steel" },
    symbol = "[",
    looks_like = "vest_leather",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "800 ml",
            mass_limit = "3 kg",
            max_item_length = "15 cm",
            moves = 120,
        },
        {
            kind = "CONTAINER",
            capacity = "800 ml",
            mass_limit = "3 kg",
            max_item_length = "15 cm",
            moves = 120,
        },
    },
    flags = { "VARSIZE", "POCKETS", "OUTER", "STURDY" },
    armor = {
        warmth = 20,
        environmental_protection = 2,
        portions = {
            {
                encumbrance = { 12, 15 },
                coverage = 90,
                covers = { "torso" },
                materials = {
                    { id = "leather", coverage = 100, thickness = 1.5 },
                    { id = "lc_steel", coverage = 90, thickness = 1.5 },
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "vest_leather_mod_ch",
    name = ccb.content.text("hardened armored leather vest"),
    description = ccb.content.text("An armored vest made from thick leather and metal plates which have been hardened for superb protection."),
    survival_price = "20 USD",
    copy_from = "vest_leather_mod",
    replace_materials = { lc_steel = "ch_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "armor_lc_light_chestplate",
    category = "armor",
    name = ccb.content.text("mild steel light chestplate"),
    description = ccb.content.text("A light chestplate, 2 mm thick.  This one has been made with mild steel."),
    mass = "7500 g",
    volume = "8750 ml",
    price = "600 USD",
    survival_price = "120 USD",
    accuracy = { grip = "none", length = "short", surface = "any", balance = "clumsy" },
    materials = { "leather", "lc_steel" },
    symbol = "[",
    looks_like = "cuirass_lightplate",
    color = "light_gray",
    length = "60 cm",
    flags = { "OUTER", "STURDY", "CONDUCTIVE", "ALLOWS_GASTROPOD_FOOT", "ALLOWS_LEG_TENTACLES" },
    max_worn = 1,
    melee_damage = { bash = 8 },
    armor = {
        warmth = 20,
        thickness = 2,
        portions = {
            {
                materials = {
                    { id = "lc_steel", coverage = 92, thickness = 1.5 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "torso" },
                subparts = { "torso_upper" },
                coverage = 100,
                encumbrance = 12,
                vitals_coverage = 92,
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 95, thickness = 1.45 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "torso" },
                subparts = { "torso_lower" },
                coverage = 100,
                vitals_coverage = 100,
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 90, thickness = 1.4 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "leg_l", "leg_r", "gastropod_foot" },
                subparts = { "leg_hip_l", "leg_hip_r", "leg_hip_gastropod_l", "leg_hip_gastropod_r" },
                coverage = 100,
                encumbrance = 3,
                vitals_coverage = 85,
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 90, thickness = 1.4 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = {
                    "tentacle_lower_front_l", "tentacle_lower_middle_l", "tentacle_lower_rear_l",
                    "tentacle_lower_front_r", "tentacle_lower_middle_r", "tentacle_lower_rear_r",
                },
                coverage = 100,
                encumbrance = 3,
                vitals_coverage = 85,
                subparts = {
                    "tentacle_lower_front_base_l", "tentacle_lower_middle_base_l",
                    "tentacle_lower_rear_base_l", "tentacle_lower_middle_base_r",
                    "tentacle_lower_middle_base_r", "tentacle_lower_rear_base_r",
                },
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 88, thickness = 0.75 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_r", "arm_shoulder_l" },
                coverage = 100,
                vitals_coverage = 85,
                encumbrance = 2,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_armor_lc_light_chestplate",
    name = ccb.content.text("mild steel light chestplate"),
    copy_from = "armor_lc_light_chestplate",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_mc_light_chestplate",
    copy_from = "armor_lc_light_chestplate",
    name = ccb.content.text("medium steel light chestplate"),
    description = ccb.content.text("A light chestplate, 2 mm thick.  Made with tougher medium steel, offering solid protection."),
    replace_materials = { lc_steel = "mc_steel", lc_steel_chain = "mc_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_mc_light_chestplate",
    name = ccb.content.text("medium steel light chestplate"),
    copy_from = "armor_mc_light_chestplate",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_hc_light_chestplate",
    copy_from = "armor_lc_light_chestplate",
    name = ccb.content.text("high steel light chestplate"),
    description = ccb.content.text("A light chestplate, 2 mm thick.  Made with high steel, offering excellent protection."),
    replace_materials = { lc_steel = "hc_steel", lc_steel_chain = "hc_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_hc_light_chestplate",
    name = ccb.content.text("high steel light chestplate"),
    copy_from = "armor_hc_light_chestplate",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_ch_light_chestplate",
    copy_from = "armor_lc_light_chestplate",
    name = ccb.content.text("hardened light chestplate"),
    description = ccb.content.text("A light chestplate, 2 mm thick.  The mild steel has been hardened, offering superior protection."),
    replace_materials = { lc_steel = "ch_steel", lc_steel_chain = "ch_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_ch_light_chestplate",
    name = ccb.content.text("hardened light chestplate"),
    copy_from = "armor_ch_light_chestplate",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_qt_light_chestplate",
    copy_from = "armor_lc_light_chestplate",
    name = ccb.content.text("tempered light chestplate"),
    description = ccb.content.text("A light chestplate, 2 mm thick.  The medium steel has been quenched and tempered, offering top-of-the-line protection."),
    replace_materials = { lc_steel = "qt_steel", lc_steel_chain = "qt_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_qt_light_chestplate",
    name = ccb.content.text("tempered light chestplate"),
    copy_from = "armor_qt_light_chestplate",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_lc_chestplate",
    category = "armor",
    name = ccb.content.text("mild steel chestplate"),
    description = ccb.content.text("A chestplate, 4 mm thick.  This one has been made with mild steel."),
    mass = "10 kg",
    volume = "17500 ml",
    price = "600 USD",
    survival_price = "120 USD",
    accuracy = { grip = "none", length = "short", surface = "any", balance = "clumsy" },
    materials = { "leather", "lc_steel" },
    symbol = "[",
    looks_like = "armor_larmor",
    color = "light_gray",
    length = "60 cm",
    flags = { "OUTER", "STURDY", "CONDUCTIVE", "ALLOWS_GASTROPOD_FOOT", "ALLOWS_LEG_TENTACLES" },
    max_worn = 1,
    melee_damage = { bash = 8 },
    armor = {
        warmth = 20,
        thickness = 4,
        portions = {
            {
                materials = {
                    { id = "lc_steel", coverage = 95, thickness = 3.1 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "torso" },
                subparts = { "torso_upper" },
                coverage = 100,
                vitals_coverage = 98,
                encumbrance = 18,
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 98, thickness = 2.5 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "torso" },
                subparts = { "torso_lower" },
                vitals_coverage = 100,
                coverage = 100,
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 95, thickness = 3 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "leg_l", "leg_r", "gastropod_foot" },
                subparts = { "leg_hip_l", "leg_hip_r", "leg_hip_gastropod_l", "leg_hip_gastropod_r" },
                coverage = 100,
                encumbrance = 6,
                vitals_coverage = 90,
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 95, thickness = 3 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = {
                    "tentacle_lower_front_l", "tentacle_lower_middle_l", "tentacle_lower_rear_l",
                    "tentacle_lower_front_r", "tentacle_lower_middle_r", "tentacle_lower_rear_r",
                },
                coverage = 100,
                encumbrance = 6,
                vitals_coverage = 90,
                subparts = {
                    "tentacle_lower_front_base_l", "tentacle_lower_middle_base_l",
                    "tentacle_lower_rear_base_l", "tentacle_lower_middle_base_r",
                    "tentacle_lower_middle_base_r", "tentacle_lower_rear_base_r",
                },
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 92, thickness = 3 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_r", "arm_shoulder_l" },
                coverage = 100,
                encumbrance = 4,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_armor_lc_chestplate",
    name = ccb.content.text("mild steel chestplate"),
    copy_from = "armor_lc_chestplate",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_mc_chestplate",
    copy_from = "armor_lc_chestplate",
    name = ccb.content.text("medium steel chestplate"),
    description = ccb.content.text("A chestplate, 4 mm thick.  Made with tougher medium steel, offering solid protection."),
    replace_materials = { lc_steel = "mc_steel", lc_steel_chain = "mc_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_mc_chestplate",
    name = ccb.content.text("medium steel chestplate"),
    copy_from = "armor_mc_chestplate",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_hc_chestplate",
    copy_from = "armor_lc_chestplate",
    name = ccb.content.text("high steel chestplate"),
    description = ccb.content.text("A chestplate, 4 mm thick.  Made with high steel, offering excellent protection."),
    replace_materials = { lc_steel = "hc_steel", lc_steel_chain = "hc_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_hc_chestplate",
    name = ccb.content.text("high steel chestplate"),
    copy_from = "armor_hc_chestplate",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_ch_chestplate",
    copy_from = "armor_lc_chestplate",
    name = ccb.content.text("hardened chestplate"),
    description = ccb.content.text("A chestplate, 4 mm thick.  The mild steel has been hardened, offering superior protection."),
    replace_materials = { lc_steel = "ch_steel", lc_steel_chain = "ch_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_ch_chestplate",
    name = ccb.content.text("hardened chestplate"),
    copy_from = "armor_ch_chestplate",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_qt_chestplate",
    copy_from = "armor_lc_chestplate",
    name = ccb.content.text("tempered chestplate"),
    description = ccb.content.text("A chestplate, 4 mm thick.  The medium steel has been quenched and tempered, offering top-of-the-line protection."),
    replace_materials = { lc_steel = "qt_steel", lc_steel_chain = "qt_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_qt_chestplate",
    name = ccb.content.text("tempered chestplate"),
    copy_from = "armor_qt_chestplate",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

-- This version would have a comprehensive fauld over the groin and butt, which is why coverage is at 100
ccb.content.define_item {
    id = "armor_lc_heavy_chestplate",
    category = "armor",
    name = ccb.content.text("mild steel heavy chestplate"),
    description = ccb.content.text("A heavy chestplate, 6 mm thick.  This one has been made with mild steel."),
    mass = "17500 g",
    volume = "17500 ml",
    price = "600 USD",
    survival_price = "120 USD",
    accuracy = { grip = "none", length = "short", surface = "any", balance = "clumsy" },
    materials = { "leather", "lc_steel" },
    symbol = "[",
    looks_like = "armor_larmor",
    color = "light_gray",
    length = "60 cm",
    flags = { "OUTER", "STURDY", "CONDUCTIVE" },
    max_worn = 1,
    melee_damage = { bash = 8 },
    armor = {
        warmth = 20,
        thickness = 6,
        portions = {
            {
                materials = {
                    { id = "lc_steel", coverage = 97, thickness = 4.1 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "torso" },
                vitals_coverage = 100,
                subparts = { "torso_upper" },
                coverage = 100,
                encumbrance = 23,
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 100, thickness = 3.4 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "torso" },
                subparts = { "torso_lower" },
                vitals_coverage = 100,
                coverage = 100,
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 100, thickness = 3.4 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "leg_l", "leg_r", "gastropod_foot" },
                subparts = { "leg_hip_l", "leg_hip_r", "leg_hip_gastropod_l", "leg_hip_gastropod_r" },
                coverage = 100,
                vitals_coverage = 100,
                encumbrance = 8,
            },
            {
                materials = {
                    { id = "lc_steel", coverage = 96, thickness = 3.4 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "leather", coverage = 1, thickness = 1.0 },
                },
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_shoulder_r" },
                coverage = 100,
                vitals_coverage = 100,
                encumbrance = 5,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_armor_lc_heavy_chestplate",
    name = ccb.content.text("mild steel heavy chestplate"),
    copy_from = "armor_lc_heavy_chestplate",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_mc_heavy_chestplate",
    copy_from = "armor_lc_heavy_chestplate",
    name = ccb.content.text("medium steel heavy chestplate"),
    description = ccb.content.text("A heavy chestplate, 6 mm thick.  Made with tougher medium steel, offering solid protection."),
    replace_materials = { lc_steel = "mc_steel", lc_steel_chain = "mc_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_mc_heavy_chestplate",
    name = ccb.content.text("medium steel heavy chestplate"),
    copy_from = "armor_mc_heavy_chestplate",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_hc_heavy_chestplate",
    copy_from = "armor_lc_heavy_chestplate",
    name = ccb.content.text("high steel heavy chestplate"),
    description = ccb.content.text("A heavy chestplate, 6 mm thick.  Made with high steel, offering excellent protection."),
    replace_materials = { lc_steel = "hc_steel", lc_steel_chain = "hc_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_hc_heavy_chestplate",
    name = ccb.content.text("high steel heavy chestplate"),
    copy_from = "armor_hc_heavy_chestplate",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_ch_heavy_chestplate",
    copy_from = "armor_lc_heavy_chestplate",
    name = ccb.content.text("hardened heavy chestplate"),
    description = ccb.content.text("A heavy chestplate, 6 mm thick.  The mild steel has been hardened, offering superior protection."),
    replace_materials = { lc_steel = "ch_steel", lc_steel_chain = "ch_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_ch_heavy_chestplate",
    name = ccb.content.text("hardened heavy chestplate"),
    copy_from = "armor_ch_heavy_chestplate",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_qt_heavy_chestplate",
    copy_from = "armor_lc_heavy_chestplate",
    name = ccb.content.text("tempered heavy chestplate"),
    description = ccb.content.text("A heavy chestplate, 6 mm thick.  The medium steel has been quenched and tempered, offering top-of-the-line protection."),
    replace_materials = { lc_steel = "qt_steel", lc_steel_chain = "qt_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_armor_qt_heavy_chestplate",
    name = ccb.content.text("tempered heavy chestplate"),
    copy_from = "armor_qt_heavy_chestplate",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "survivor_adhoc_leather_shirt",
    category = "armor",
    name = ccb.content.text("leather-padded shirt"),
    description = ccb.content.text("Armor made of combined pre-Cataclysm clothing.  Sections from leather clothing are tightened and affixed to a thick cotton shirt, excluding the joints."),
    mass = "2000 g",
    volume = "2500 ml",
    survival_price = "35 USD",
    materials = { "cotton", "leather" },
    symbol = "[",
    looks_like = "sweatshirt",
    color = "light_red",
    flags = { "VARSIZE", "WATER_FRIENDLY" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "cotton", coverage = 100, thickness = 1.0 },
                    { id = "leather", coverage = 90, thickness = 1.5 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 8,
            },
            {
                materials = { { id = "cotton", coverage = 100, thickness = 1.0 } },
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_elbow_l", "arm_elbow_r", "arm_shoulder_l", "arm_shoulder_r" },
                coverage = 100,
                encumbrance = 0,
            },
            {
                materials = {
                    { id = "cotton", coverage = 100, thickness = 1.0 },
                    { id = "leather", coverage = 95, thickness = 1.5 },
                },
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_upper_l", "arm_lower_l", "arm_upper_r", "arm_lower_r" },
                coverage = 100,
                encumbrance = 8,
            },
        },
        warmth = 35,
        thickness = 2.5,
        environmental_protection = 2,
    },
}

ccb.content.define_item {
    id = "survivor_adhoc_leather_torso",
    category = "armor",
    name = ccb.content.text("leather-padded sleeveless shirt"),
    description = ccb.content.text("Armor made of combined pre-Cataclysm clothing.  Sections from leather clothing are tightened and affixed to a thick cotton shirt.  The sleeves have been cut off."),
    mass = "1500 g",
    volume = "2000 ml",
    survival_price = "20 USD",
    materials = { "cotton", "leather" },
    symbol = "[",
    looks_like = "sleeveless_tunic",
    color = "light_red",
    flags = { "VARSIZE", "WATER_FRIENDLY" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "cotton", coverage = 100, thickness = 1.0 },
                    { id = "leather", coverage = 90, thickness = 1.5 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 8,
            },
        },
        warmth = 35,
        thickness = 2.5,
        environmental_protection = 2,
    },
}

ccb.content.define_item {
    id = "armor_riot_torso",
    category = "armor",
    name = ccb.content.plural_text("riot chest guard", "riot chest guards"),
    description = ccb.content.text("A hard chest protector, attached to thigh and upper arm guards.  Used by riot police officers.  MOLLE webbing is attached to the torso and the word POLICE is emblazoned across the front."),
    mass = "2 kg",
    volume = "10 L",
    price = "400 USD",
    survival_price = "25 USD",
    materials = { "thermo_resin", "plastic_pad" },
    symbol = "[",
    looks_like = "chestguard_hard",
    color = "dark_gray",
    length = "60 cm",
    flags = {
        "STURDY",
        "OUTER",
        "WATER_FRIENDLY",
        "PADDED",
        "ALLOWS_GASTROPOD_FOOT",
        "ALLOWS_LEG_TENTACLES",
    },
    armor = {
        warmth = 20,
        portions = {
            {
                encumbrance = 6,
                coverage = 75,
                covers = { "torso" },
                volume_encumbrance = 0.3,
                materials = {
                    { id = "plastic_pad", coverage = 100, thickness = 7 },
                    { id = "thermo_resin", coverage = 90, thickness = 2 },
                },
            },
            {
                covers = { "arm_l", "arm_r", "leg_l", "leg_r" },
                volume_encumbrance = 0,
                encumbrance = 2,
                coverage = 65,
                materials = {
                    { id = "plastic_pad", coverage = 100, thickness = 6 },
                    { id = "thermo_resin", coverage = 90, thickness = 1.5 },
                },
                subparts = {
                    "arm_shoulder_l",
                    "arm_shoulder_r",
                    "arm_upper_l",
                    "arm_upper_r",
                    "leg_upper_l",
                    "leg_upper_r",
                },
            },
            {
                covers = { "leg_l", "leg_r" },
                volume_encumbrance = 0,
                coverage = 30,
                materials = { { id = "plastic_pad", coverage = 100, thickness = 7 } },
                subparts = { "leg_hip_l", "leg_hip_r" },
            },
            {
                volume_encumbrance = 0,
                coverage = 30,
                materials = { { id = "plastic_pad", coverage = 100, thickness = 7 } },
                covers = { "gastropod_foot" },
                subparts = { "leg_hip_gastropod_l", "leg_hip_gastropod_r" },
            },
            {
                volume_encumbrance = 0,
                coverage = 30,
                materials = { { id = "plastic_pad", coverage = 100, thickness = 7 } },
                covers = {
                    "tentacle_lower_front_l", "tentacle_lower_middle_l", "tentacle_lower_rear_l",
                    "tentacle_lower_front_r", "tentacle_lower_middle_r", "tentacle_lower_rear_r",
                },
                subparts = {
                    "tentacle_lower_front_base_l", "tentacle_lower_middle_base_l",
                    "tentacle_lower_rear_base_l", "tentacle_lower_middle_base_r",
                    "tentacle_lower_middle_base_r", "tentacle_lower_rear_base_r",
                },
            },
        },
    },
    use_actions = { { kind = "attach_molle", size = 6 }, { kind = "detach_molle" } },
}

-- Human surface area is roughly 18600 cm^2, based off of rules of 9 the torso is 36% leaving us with 6696 cm^2, and arms are 18% leaving us with 3348 cm^2.
-- Leather has a density of 1.1g/cm^3, thickness of 0.45 cm, coverage of 95% leaves us with 3 149 grams.
-- Leather has a density of 1.1g/cm^3, thickness of 0.4 cm, coverage of 18% leaves us with 265 grams.
-- Totalled up this is 3 414 grams with some rounding
ccb.content.define_item {
    id = "armor_larmor_chest",
    category = "armor",
    name = ccb.content.plural_text("leather armor cuirass", "leather armor cuirasses"),
    description = ccb.content.text("A leather chest plate with attached shoulder guards."),
    mass = "3414 g",
    volume = "3500 ml",
    price = "60 USD",
    survival_price = "12 USD 50 cent",
    materials = { "leather" },
    symbol = "[",
    length = "60 cm",
    looks_like = "cuirass_bronze",
    color = "brown",
    flags = { "VARSIZE", "STURDY", "OUTER" },
    armor = {
        portions = {
            {
                covers = { "torso" },
                coverage = 95,
                encumbrance = 17,
                materials = { { id = "leather", coverage = 100, thickness = 4.5 } },
            },
            {
                covers = { "arm_l", "arm_r" },
                coverage = 90,
                encumbrance = 4,
                subparts = { "arm_shoulder_l", "arm_shoulder_r" },
            },
        },
        warmth = 25,
        thickness = 4,
        valid_mods = { "steel_padded" },
    },
}

ccb.content.define_item {
    id = "xl_armor_larmor_chest",
    name = ccb.content.plural_text("leather armor cuirass", "leather armor cuirasses"),
    copy_from = "armor_larmor_chest",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_larmor_chest_xs",
    copy_from = "armor_larmor_chest",
    name = ccb.content.plural_text("leather armor cuirass", "leather armor cuirasses"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "lc_mirror_armor",
    category = "armor",
    name = ccb.content.plural_text("mild steel mirror armor", "sets of mild steel mirror armor"),
    description = ccb.content.text("Mirror armor earns its name from its distinct shape and polished sheen.  Round and rectangular steel plates are fastened together to protect all four sides of the torso.  It can be worn on top of other armor like chainmail and brigandines.  This set is crudely put together with square plates of mild steel."),
    mass = "1000 g",
    volume = "2 L",
    price = "200 USD",
    survival_price = "40 USD",
    materials = { "lc_steel", "leather" },
    symbol = "[",
    looks_like = "chestguard_hard",
    color = "light_gray",
    length = "60 cm",
    flags = { "VARSIZE", "OUTER", "STURDY", "ABLATIVE_CHAINMAIL_TORSO", "EXTRA_PLATING" },
    armor = {
        warmth = 20,
        portions = {
            {
                encumbrance = 5,
                coverage = 60,
                vitals_coverage = 50,
                covers = { "torso" },
                materials = {
                    { id = "leather", coverage = 10, thickness = 0.5 },
                    { id = "lc_steel", coverage = 100, thickness = 1.5 },
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_lc_mirror_armor",
    name = ccb.content.plural_text("mild steel mirror armor", "sets of mild steel mirror armor"),
    copy_from = "cuirass_lightplate",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_lc_mirror_armor",
    copy_from = "lc_mirror_armor",
    name = ccb.content.plural_text("mild steel mirror armor", "sets of mild steel mirror armor"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "mc_mirror_armor",
    copy_from = "lc_mirror_armor",
    name = ccb.content.plural_text("medium steel mirror armor", "sets of medium steel mirror armor"),
    description = ccb.content.text("Mirror armor earns its name from its distinct shape and polished sheen.  Round and rectangular steel plates are fastened together to protect all four sides of the torso.  It can be worn on top of other armor like chainmail and brigandines.  This set is made with rectangular plates of medium steel."),
    replace_materials = { lc_steel = "mc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_mc_mirror_armor",
    name = ccb.content.plural_text("medium steel mirror armor", "sets of medium steel mirror armor"),
    copy_from = "mc_mirror_armor",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_mc_mirror_armor",
    copy_from = "mc_mirror_armor",
    name = ccb.content.plural_text("medium steel mirror armor", "sets of medium steel mirror armor"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "hc_mirror_armor",
    copy_from = "lc_mirror_armor",
    name = ccb.content.plural_text("high steel mirror armor", "sets of high steel mirror armor"),
    description = ccb.content.text("Mirror armor earns its name from its distinct shape and polished sheen.  Round and rectangular steel plates are fastened together to protect all four sides of the torso.  It can be worn on top of other armor like chainmail and brigandines.  Made of high steel plates, this set is well-formed and lightly polished for a neat finish."),
    replace_materials = { lc_steel = "hc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_hc_mirror_armor",
    name = ccb.content.plural_text("high steel mirror armor", "sets of high steel mirror armor"),
    copy_from = "hc_mirror_armor",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_hc_mirror_armor",
    copy_from = "hc_mirror_armor",
    name = ccb.content.plural_text("high steel mirror armor", "sets of high steel mirror armor"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "ch_mirror_armor",
    copy_from = "lc_mirror_armor",
    name = ccb.content.plural_text("hardened steel mirror armor", "sets of hardened steel mirror armor"),
    description = ccb.content.text("Mirror armor earns its name from its distinct shape and polished sheen.  Round and rectangular steel plates are fastened together to protect all four sides of the torso.  It can be worn on top of other armor like chainmail and brigandines.  Made of hardened steel, this set was created with an array of rectangular and circular plates, polished and lightly decorated.  Tough, durable, and made to protect."),
    replace_materials = { lc_steel = "ch_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_ch_mirror_armor",
    name = ccb.content.plural_text("hardened steel mirror armor", "sets of hardened steel mirror armor"),
    copy_from = "ch_mirror_armor",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_ch_mirror_armor",
    copy_from = "ch_mirror_armor",
    name = ccb.content.plural_text("hardened steel mirror armor", "sets of hardened steel mirror armor"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "qt_mirror_armor",
    copy_from = "lc_mirror_armor",
    name = ccb.content.plural_text("tempered steel mirror armor", "sets of tempered steel mirror armor"),
    description = ccb.content.text("Mirror armor earns its name from its distinct shape and polished sheen.  Round and rectangular steel plates are fastened together to protect all four sides of the torso.  It can be worn on top of other armor like chainmail and brigandines.  Masterfully crafted with tempered steel, this set features a prominent circular plate on the front that has been polished to a mirror-like sheen, flanked with supporting plates intricately joined to fit the body, all meticulously decorated.  Will protect you from serious harm, as well as the evil gazes of the undead."),
    replace_materials = { lc_steel = "qt_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_qt_mirror_armor",
    name = ccb.content.plural_text("tempered steel mirror armor", "sets of tempered steel mirror armor"),
    copy_from = "qt_mirror_armor",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_qt_mirror_armor",
    copy_from = "qt_mirror_armor",
    name = ccb.content.plural_text("tempered steel mirror armor", "sets of tempered steel mirror armor"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- Human surface area is roughly 18600 cm^2, based off of rules of 9 the torso is 36% leaving us with 6696 cm^2.
-- Chitin has a density of 1.45g/cm^3, thickness of 0.32 cm, coverage of 80% leaves us with 3 107 grams.
-- Leather has a density of 1.1g/cm^3, thickness of 0.07 cm, coverage of 100% leaves us with 516 grams.
-- Totalled up this is 3 624 grams with some rounding
ccb.content.define_item {
    id = "armor_chitin_vest",
    category = "armor",
    name = ccb.content.text("chitinous scale mail vest"),
    description = ccb.content.text("A vest of chitin sections overlapping with each other, secured to a leather backing.  The odd irregular shapes make full coverage impossible, not helped by how poor of a material chitin is.  Seems to be made more out of desperation than anything, and would benefit greatly from some underlying armor."),
    mass = "3624 g",
    volume = "4 L",
    price = "460 USD",
    survival_price = "2 USD",
    materials = { { id = "chitin", portions = 35 }, { id = "leather", portions = 1 } },
    symbol = "[",
    looks_like = "armor_larmor",
    color = "green",
    length = "30 cm",
    flags = { "OUTER" },
    armor = {
        warmth = 20,
        portions = {
            {
                materials = {
                    { id = "chitin", coverage = 80, thickness = 3.2 },
                    { id = "leather", coverage = 100, thickness = 0.7 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 13,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_armor_chitin_vest",
    name = ccb.content.text("chitinous scale mail vest"),
    copy_from = "armor_chitin_vest",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_armor_chitin_vest",
    copy_from = "armor_chitin_vest",
    looks_like = "armor_chitin_vest",
    name = ccb.content.text("chitinous scale mail vest"),
    flags = { "STURDY", "OUTER", "UNDERSIZE", "PREFIX_XS" },
    armor = {},
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
}

-- An other-Earth interpretation of mirror armor, but made of 2 thick plates instead of 4 earth-thickness plates.
ccb.content.define_item {
    id = "string_dimension_mirror_cuirass",
    category = "armor",
    name = ccb.content.plural_text("do-āyneh cuirass", "do-āyneh cuirasses"),
    description = ccb.content.text("Somewhat resembling your Earth's mirror armor, this otherworldly cuirass is made up of two round metal plates on the chest and back, lashed together by steel chains around the torso and shoulder.  It covers less than Earth's ancient cuirass, but is notably thicker."),
    mass = "1200 g",
    volume = "2 L",
    price = "200 USD",
    survival_price = "40 USD",
    materials = { "qt_steel" },
    symbol = "[",
    looks_like = "chestguard_hard",
    color = "white",
    length = "60 cm",
    flags = { "VARSIZE", "OUTER", "STURDY", "ABLATIVE_CHAINMAIL_TORSO", "EXTRA_PLATING" },
    armor = {
        warmth = 15,
        portions = {
            {
                encumbrance = 4,
                coverage = 50,
                vitals_coverage = 50,
                covers = { "torso" },
                materials = { { id = "qt_steel", coverage = 100, thickness = 3 } },
            },
        },
    },
}
