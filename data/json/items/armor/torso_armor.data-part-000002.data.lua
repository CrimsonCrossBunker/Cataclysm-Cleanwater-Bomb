local ccb = require("ccb")

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
