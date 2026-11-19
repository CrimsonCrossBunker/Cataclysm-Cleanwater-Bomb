local ccb = require("ccb")

ccb.content.define_item {
    id = "dreamforged_helmet_berserker",
    copy_from = "dreamforged_helmet",
    category = "armor",
    name = ccb.content.plural_text("berserk helmet", "berserk helmets"),
    description = ccb.content.text("Thin, smooth helmet, that cover your head, with a wide, sharp two-teeth blade from the forehead.  Fueled by damage of berserk knuckles, your feel the helmet pump the tension right into your veins."),
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 5,
        thickness = 0.7,
        portions = { { encumbrance_modifiers = { "NONE" }, coverage = 85, covers = { "head" } } },
    },
    artifact = { enchantments = { "BERSERKER_REGEN_STAMINA" } },
}

ccb.content.define_item {
    id = "dreamforged_armguard_plate_berserk",
    copy_from = "dreamforged_armguard_plate",
    name = ccb.content.plural_text("pair of dreamforged berserk guards", "pairs of dreamforged berserk guards"),
    description = ccb.content.text("Pair of fiery red armguards, they glow red the more damage you deal, using berserk knuckles, and your physical strength grows respectively."),
    subtype_order = { "armor", "artifact" },
    armor = { thickness = 0.6 },
    artifact = { enchantments = { "BERSERKER_STR" } },
}

ccb.content.define_item {
    id = "dreamforged_boots_berserk",
    copy_from = "dreamforged_boots",
    name = ccb.content.plural_text("pair of berserker boots", "pairs of berserker boots"),
    description = ccb.content.text("Pair of fiery red boots, they are fueled by damage you deal with berserk knuckles, and increase your speed respectively."),
    subtype_order = { "armor", "artifact" },
    armor = {
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_heel_r", "foot_heel_l", "foot_arch_r",
                    "foot_arch_l", "foot_sole_r", "foot_sole_l",
                },
                materials = { { id = "forged_dreamstuff", coverage = 100, thickness = 0.5 } },
                encumbrance = 10,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_r", "foot_ankle_l" },
                materials = { { id = "forged_dreamstuff", coverage = 100, thickness = 1 } },
                coverage = 100,
            },
        },
    },
    artifact = { enchantments = { "BERSERKER_SPEED" } },
}

ccb.content.define_item {
    id = "dreamforged_fullhelmet_arcane",
    copy_from = "dreamforged_fullhelmet",
    category = "armor",
    name = ccb.content.plural_text("arcane helmet", "arcane helmets"),
    description = ccb.content.text("Dreamforged helmet with side protection, and carved runes outside.  It grant you an ability to understand more, and with better world investigation your mana regeneration grows.  Runes are just decorations actually."),
    mass = "581 g",
    color = "dark_gray",
    techniques = { "WBLOCK_1" },
    flags = { "MORPHIC", "WATERPROOF", "STURDY", "PADDED" },
    subtype_order = { "armor", "artifact" },
    armor = {
        portions = {
            {
                covers = { "head" },
                coverage = 80,
                encumbrance_modifiers = { "WELL_SUPPORTED", "RESTRICTS_NECK" },
            },
        },
        warmth = 5,
        thickness = 0.7,
    },
    artifact = { enchantments = { "DEDUCTION_REGEN_MANA" } },
}

ccb.content.define_item {
    id = "dreamforged_armguard_plate_gunslinger",
    copy_from = "dreamforged_armguard_plate",
    name = ccb.content.plural_text("\"Gunslinger\"", "\"Gunslinger\""),
    description = ccb.content.text("Pair of flat armguards, fully carved with numbers and crosses.  Inside the left guard there is a text, cut with something sharp, that starts from \"Sent onto those that escaped limbo's clutches, and unleash the rage of all hell…\"."),
    subtype_order = { "armor", "artifact" },
    armor = { thickness = 0.1 },
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_dreamforged_armguard_plate_gunslinger_0" } },
}

-- Derived from chitinous helmet
ccb.content.define_item {
    id = "helmet_verdant",
    category = "armor",
    name = ccb.content.plural_text("verdant helmet", "verdant helmets"),
    description = ccb.content.text("A helmet made from the of living plant matter, with bark covering the outer surface.  This is definitely not anything that could have existed before the Cataclysm."),
    mass = "1447 g",
    volume = "2500 ml",
    price = "380 USD",
    survival_price = "12 USD 50 cent",
    materials = { "mut_wood", "veggy" },
    symbol = "[",
    looks_like = "helmet_larmor",
    color = "green",
    flags = { "WATERPROOF", "STURDY", "NONCONDUCTIVE", "PADDED", "NO_REPAIR" },
    melee_damage = { bash = 1 },
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 20,
        thickness = 4,
        environmental_protection = 4,
        portions = {
            {
                covers = { "head" },
                breathability = "AVERAGE",
                materials = {
                    { id = "mut_wood", coverage = 100, thickness = 2.5 },
                    { id = "veggy", coverage = 100, thickness = 1.5 },
                },
                coverage = 100,
                subparts = { "head_crown", "head_forehead", "head_ear_l", "head_ear_r" },
                encumbrance_modifiers = { "WELL_SUPPORTED" },
            },
            {
                covers = { "mouth" },
                breathability = "AVERAGE",
                materials = {
                    { id = "mut_wood", coverage = 50, thickness = 1.5 },
                    { id = "veggy", coverage = 100, thickness = 1.0 },
                },
                coverage = 50,
                rigid_only = true,
                subparts = { "mouth_lips", "mouth_nose" },
                encumbrance = 5,
            },
            {
                covers = { "mouth" },
                breathability = "AVERAGE",
                materials = {
                    { id = "mut_wood", coverage = 100, thickness = 1.5 },
                    { id = "veggy", coverage = 100, thickness = 1.0 },
                },
                coverage = 80,
                rigid_only = true,
                subparts = { "mouth_cheeks", "mouth_chin" },
            },
            { covers = { "head" }, subparts = { "head_nape", "head_throat" }, coverage = 60 },
            { covers = { "eyes" }, rigid_only = true, coverage = 60, encumbrance = 5 },
        },
    },
    artifact = { enchantments = { "ench_verdant_helmet" } },
}

-- Derived from chitinous armor
-- The idea for this is that it's basically plate-and-mail, but with bark and a kind of mossy, viney connective tissue
ccb.content.define_item {
    id = "armor_verdant_cuirass",
    name = ccb.content.plural_text("verdant cuirass", "verdant cuirasses"),
    description = ccb.content.text("A cuirass made of living plant matter, with bark covering the outer surface.  This is definitely not anything that could have existed before the Cataclysm."),
    mass = "2632 g",
    volume = "17500 ml",
    price = "1 kUSD 200 USD",
    survival_price = "30 USD",
    materials = { "mut_wood", "veggy" },
    symbol = "[",
    looks_like = "armor_larmor",
    color = "green",
    length = "60 cm",
    flags = { "STURDY", "OUTER", "WATERPROOF", "NONCONDUCTIVE", "PADDED", "NO_REPAIR" },
    melee_damage = { bash = 2 },
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 10,
        thickness = 4,
        portions = {
            {
                breathability = "AVERAGE",
                materials = {
                    { id = "mut_wood", coverage = 95, thickness = 3 },
                    { id = "veggy", coverage = 100, thickness = 1.0 },
                },
                coverage = 100,
                covers = { "torso" },
                encumbrance = 10,
            },
            {
                breathability = "AVERAGE",
                materials = {
                    { id = "mut_wood", coverage = 95, thickness = 3 },
                    { id = "veggy", coverage = 100, thickness = 1.0 },
                },
                coverage = 100,
                covers = { "arm_r", "arm_l" },
                subparts = { "arm_shoulder_r", "arm_shoulder_l" },
                encumbrance = 6,
            },
            {
                breathability = "AVERAGE",
                covers = { "leg_l", "leg_r" },
                materials = {
                    { id = "mut_wood", coverage = 90, thickness = 3 },
                    { id = "veggy", coverage = 100, thickness = 1.0 },
                },
                coverage = 95,
                encumbrance = { 5, 5 },
                subparts = { "leg_upper_r", "leg_upper_l", "leg_hip_r", "leg_hip_l" },
            },
        },
    },
    artifact = { enchantments = { "ench_verdant_body" } },
}

-- Derived from chitinous gauntlets
ccb.content.define_item {
    id = "gauntlets_verdant",
    category = "armor",
    name = ccb.content.plural_text("pair of verdant gauntlets", "pairs of verdant gauntlets"),
    description = ccb.content.text("A pair of fingerless gauntlets made from living plant matter, with bark covering the outer surface.  This is definitely not anything that could have existed before the Cataclysm."),
    mass = "760 g",
    volume = "1750 ml",
    price = "380 USD",
    survival_price = "12 USD 50 cent",
    materials = { "mut_wood", "veggy" },
    symbol = "[",
    looks_like = "gauntlets_larmor",
    color = "green",
    flags = {
        "STURDY",
        "DURABLE_MELEE",
        "WATERPROOF",
        "NONCONDUCTIVE",
        "PADDED",
        "NO_REPAIR",
        "ALLOWS_NATURAL_ATTACKS",
    },
    melee_damage = { bash = 2 },
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 20,
        thickness = 3.5,
        environmental_protection = 4,
        portions = {
            {
                breathability = "AVERAGE",
                materials = {
                    { id = "mut_wood", coverage = 95, thickness = 2.5 },
                    { id = "veggy", coverage = 100, thickness = 1.0 },
                },
                encumbrance = 8,
                coverage = 95,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_lower_r", "arm_lower_l" },
            },
            {
                breathability = "AVERAGE",
                materials = {
                    { id = "mut_wood", coverage = 95, thickness = 2 },
                    { id = "veggy", coverage = 100, thickness = 1.5 },
                },
                encumbrance = 8,
                coverage = 95,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_back_l", "hand_back_r", "hand_wrist_l", "hand_wrist_r" },
            },
            {
                breathability = "AVERAGE",
                materials = {
                    { id = "mut_wood", coverage = 80, thickness = 1.5 },
                    { id = "veggy", coverage = 100, thickness = 1.0 },
                },
                coverage = 70,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_palm_l", "hand_palm_r" },
            },
            {
                breathability = "AVERAGE",
                materials = {
                    { id = "mut_wood", coverage = 80, thickness = 1.5 },
                    { id = "veggy", coverage = 100, thickness = 1.0 },
                },
                coverage = 50,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
            },
        },
    },
    artifact = { enchantments = { "ench_verdant_gauntlets" } },
}

-- Derived from chitin leg guards
ccb.content.define_item {
    id = "leg_guards_verdant",
    category = "armor",
    name = ccb.content.plural_text("pair of verdant leg guards", "pairs of verdant leg guards"),
    description = ccb.content.text("A pair of leg guards made from living plant matter, with bark covering the outer surface.  This is definitely not anything that could have existed before the Cataclysm."),
    mass = "510 g",
    volume = "5000 ml",
    price = "250 USD",
    survival_price = "7 USD 50 cent",
    materials = { "mut_wood", "veggy" },
    symbol = "[",
    looks_like = "legguard_hard",
    color = "green",
    flags = { "STURDY", "OUTER", "BLOCK_WHILE_WORN", "WATER_FRIENDLY", "PADDED" },
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 20,
        thickness = 4,
        environmental_protection = 2,
        portions = {
            {
                breathability = "AVERAGE",
                materials = {
                    { id = "mut_wood", coverage = 95, thickness = 3 },
                    { id = "veggy", coverage = 100, thickness = 1.0 },
                },
                coverage = 100,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_lower_r", "leg_lower_l", "leg_knee_r", "leg_knee_l" },
                encumbrance = 3,
            },
        },
    },
    artifact = { enchantments = { "ench_verdant_legs" } },
}

-- Derived from chitinous boots
ccb.content.define_item {
    id = "boots_verdant",
    category = "armor",
    name = ccb.content.plural_text("pair of verdant boots", "pairs of verdant boots"),
    description = ccb.content.text("Boots made from living plant matter, with bark covering the outer surface.  This is definitely not anything that could have existed before the Cataclysm."),
    mass = "950 g",
    volume = "4250 ml",
    price = "135 USD",
    survival_price = "12 USD 50 cent",
    materials = { "mut_wood", "veggy" },
    symbol = "[",
    looks_like = "boots_bone",
    color = "green",
    flags = { "STURDY", "WATERPROOF", "NONCONDUCTIVE", "PADDED", "NO_REPAIR" },
    melee_damage = { bash = 4 },
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 20,
        thickness = 4,
        environmental_protection = 3,
        portions = {
            {
                breathability = "AVERAGE",
                materials = {
                    { id = "mut_wood", coverage = 85, thickness = 2 },
                    { id = "veggy", coverage = 100, thickness = 2 },
                },
                coverage = 95,
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_heel_r", "foot_heel_l", "foot_arch_r", "foot_arch_l", "foot_toes_l",
                    "foot_toes_r", "foot_sole_l", "foot_sole_r",
                },
                encumbrance = 12,
            },
            {
                breathability = "AVERAGE",
                materials = {
                    { id = "mut_wood", coverage = 75, thickness = 2.5 },
                    { id = "veggy", coverage = 100, thickness = 1.5 },
                },
                coverage = 100,
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_l", "foot_ankle_r" },
            },
        },
    },
    artifact = { enchantments = { "ench_verdant_boots" } },
}

ccb.content.define_item {
    id = "sevenoclock_coat",
    name = ccb.content.plural_text("coat of the timely sleeper", "coat of the timely sleepers"),
    description = ccb.content.text("A old-fashioned padded coat with deep pockets.  As you touch it, you feel that this coat could allow you to fall asleep whenever and wherever you want."),
    mass = "1340 g",
    volume = "6750 ml",
    price = "14000 USD",
    survival_price = "70 USD 50 cent",
    materials = { "cotton" },
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
    flags = { "VARSIZE", "POCKETS", "COLLAR", "ALARMCLOCK", "OUTER", "ALLOWS_WINGS", "NO_WING_GLIDING" },
    subtype_order = { "armor", "artifact" },
    armor = {
        portions = {
            { covers = { "torso", "wing_l", "wing_r" }, coverage = 100, encumbrance = { 8, 17 } },
            { covers = { "arm_l", "arm_r" }, coverage = 100, encumbrance = { 8, 11 } },
        },
        warmth = 70,
        thickness = 2,
        environmental_protection = 1,
    },
    artifact = { enchantments = { "ench_sevenoclock_coat", "ench_sevenoclock_coat_climate_control" } },
}
