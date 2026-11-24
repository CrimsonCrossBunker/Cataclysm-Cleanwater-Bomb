local ccb = require("ccb")

-- Based on US Army SPCS. Used weight of size M cummerband configuration, data from: https://ciehub.info/ref/TM/10-8470-209-10_2013.pdf
-- inherit name from item
-- Should fit a medium ESAPI plate snugly
ccb.content.define_item {
    id = "ballistic_vest_esapi",
    category = "armor",
    name = ccb.content.plural_text("US ballistic vest", "US ballistic vests"),
    description = ccb.content.text("A ballistic vest with specialized pockets on the front, back, and sides to hold armor plates.  While this plate carrier is still protective even without inserts, it's too soft to effectively stop high-energy projectiles on its own."),
    mass = "3533 g",
    volume = "6 L",
    variant_kind = "generic",
    variants = {
        {
            id = "us_ballistic_vest",
            description = ccb.content.text("This version is patterned in multi-environment camouflage, and was standard-issue for the US Army."),
            append = true,
        },
        {
            id = "swat_ballistic_vest",
            name = ccb.content.plural_text("SWAT ballistic vest", "SWAT ballistic vests"),
            description = ccb.content.text("This version is colored black, and was once used by specialized police forces.  \"SWAT\" is emblazoned on the back."),
            color = "dark_gray",
            append = true,
        },
    },
    price = "1600 USD",
    survival_price = "10 USD",
    symbol = "[",
    materials = { "nylon", "kevlar_layered" },
    color = "light_gray",
    flags = { "STURDY", "OUTER", "WATER_FRIENDLY" },
    pockets = {
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "2000 ml",
            mass_limit = "5 kg",
            max_item_length = "33 cm",
            moves = 800,
            description = ccb.content.text("Pocket for a large armor plate."),
            allowed_flags = { "ABLATIVE_LARGE" },
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "2000 ml",
            mass_limit = "5 kg",
            max_item_length = "33 cm",
            moves = 800,
            description = ccb.content.text("Pocket for a large armor plate."),
            allowed_flags = { "ABLATIVE_LARGE" },
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "800 ml",
            mass_limit = "2 kg",
            max_item_length = "21 cm",
            moves = 800,
            description = ccb.content.text("Pocket for a medium armor plate."),
            allowed_flags = { "ABLATIVE_MEDIUM" },
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "800 ml",
            mass_limit = "2 kg",
            max_item_length = "21 cm",
            moves = 800,
            description = ccb.content.text("Pocket for a medium armor plate."),
            allowed_flags = { "ABLATIVE_MEDIUM" },
        },
    },
    armor = {
        warmth = 15,
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "kevlar_layered", coverage = 95, thickness = 4.4 },
                },
                encumbrance = 6,
                coverage = 100,
                vitals_coverage = 90,
                covers = { "torso" },
                subparts = { "torso_upper" },
                volume_encumbrance = 0.3,
            },
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "kevlar_layered", coverage = 95, thickness = 4.4 },
                },
                encumbrance = 0,
                coverage = 80,
                vitals_coverage = 90,
                covers = { "torso" },
                subparts = { "torso_lower" },
                volume_encumbrance = 0,
            },
        },
    },
    use_actions = { { kind = "attach_molle", size = 10 }, { kind = "detach_molle" } },
}

-- Based on the Med-Eng EOD 9 and EOD 10 suits.
ccb.content.define_item {
    id = "jacket_eod",
    category = "armor",
    name = ccb.content.plural_text("EOD jacket", "EOD jackets"),
    description = ccb.content.text("A thick armored jacket constructed from Kevlar, Nomex, and foam padding, for use by explosive ordnance disposal technicians.  It features a central pocket for a large plate, and near complete coverage in fragmentation resistant materials.  Aside from the plate, it offers insufficient protection from ballistic threats."),
    mass = "13500 g",
    volume = "15 L",
    price = "15 kUSD 90 USD",
    survival_price = "180 USD",
    materials = { "kevlar", "plastic_pad", "nomex" },
    symbol = "[",
    color = "light_green",
    flags = { "STURDY", "OUTER", "RAINPROOF" },
    max_worn = 1,
    pockets = {
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "3000 ml",
            mass_limit = "7 kg",
            max_item_length = "46 cm",
            moves = 1100,
            description = ccb.content.text("Pocket for a huge armor plate."),
            allowed_flags = { "ABLATIVE_LARGE" },
        },
    },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        warmth = 65,
        environmental_protection = 2,
        thickness = 15,
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "kevlar", coverage = 100, thickness = 7.4 },
                    { id = "plastic_pad", coverage = 100, thickness = 2.0 },
                },
                coverage = 100,
                vitals_coverage = 100,
                covers = { "torso", "arm_l", "arm_r" },
                encumbrance = { 71, 80 },
            },
        },
    },
    use_actions = { { kind = "attach_molle", size = 15 }, { kind = "detach_molle" } },
}

-- min. length really just a hack to avoid adding a flag.
ccb.content.define_item {
    id = "jacket_eod_light",
    category = "armor",
    name = ccb.content.plural_text("tactical EOD jacket", "tactical EOD jackets"),
    description = ccb.content.text("An armored jacket constructed from Kevlar, Nomex, and foam padding, for use by explosive ordnance disposal technicians in 'non-permissive environments'.  It is lighter than normal EOD armor to allow for wearing a plate carrier beneath it.  It features two pockets in the arms covering the deltoids for additional optional protection."),
    mass = "7000 g",
    volume = "15 L",
    price = "4 kUSD 101 USD 60 cent",
    survival_price = "59 USD",
    materials = { "kevlar", "plastic_pad", "nomex" },
    symbol = "[",
    color = "light_gray",
    flags = { "STURDY", "OUTER", "RAINPROOF" },
    max_worn = 1,
    pockets = {
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "3000 ml",
            mass_limit = "7 kg",
            max_item_length = "46 cm",
            moves = 1100,
            description = ccb.content.text("Pocket for a huge armor plate."),
            allowed_flags = { "ABLATIVE_LARGE" },
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "1558 ml",
            mass_limit = "1600 kg",
            max_item_length = "21 cm",
            min_item_length = "21 cm",
            moves = 800,
            description = ccb.content.text("Pockets for deltoid armor plates."),
            allowed_flags = { "ABLATIVE_MEDIUM" },
        },
    },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        warmth = 40,
        environmental_protection = 2,
        thickness = 7,
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "kevlar", coverage = 100, thickness = 4.4 },
                    { id = "plastic_pad", coverage = 100, thickness = 2 },
                },
                coverage = 100,
                vitals_coverage = 100,
                covers = { "torso", "arm_l", "arm_r" },
                encumbrance = { 31, 55 },
            },
        },
    },
    use_actions = { { kind = "attach_molle", size = 15 }, { kind = "detach_molle" } },
}

-- Based on the plate from the MED-ENG EOD 9N.  People don't seem willing to buy the EOD 10 to shoot at and MED-ENG ain't telling us how not-bullet proof the suit is.
ccb.content.define_item {
    id = "eod_plate",
    category = "armor",
    name = ccb.content.text("EOD fragmentation plate"),
    description = ccb.content.text("A polygonal fragmentation plate with a slightly concave profile, made of thin layers of steel, UHMW polyethylene, foam, and Kevlar.  Though certified to provide protection from fragmentation, it will not provide much protection from firearms.  This is intended to be inserted into an EOD suit, and can't be worn on its own."),
    mass = "2800 g",
    volume = "2950 ml",
    length = "46 cm",
    price = "3 kUSD 613 USD",
    survival_price = "20 USD",
    materials = { "kevlar", "plastic_pad", "thermo_resin", "qt_steel" },
    symbol = ",",
    color = "dark_gray",
    flags = { "ABLATIVE_LARGE", "CANT_WEAR", "NO_SALVAGE" },
    armor = {
        thickness = 5,
        portions = {
            {
                materials = {
                    { id = "qt_steel", coverage = 100, thickness = 0.3 },
                    { id = "kevlar", coverage = 100, thickness = 3.6 },
                    { id = "plastic_pad", coverage = 100, thickness = 3.0 },
                    { id = "thermo_resin", coverage = 100, thickness = 2.4 },
                },
                encumbrance = 0,
                coverage = 45,
                vitals_coverage = 100,
                covers = { "torso" },
                subparts = { "torso_upper", "torso_lower" },
            },
        },
    },
}

-- ESAPI Medium are 24.13cm x 31.75cm and 2.5cm thick
ccb.content.define_item {
    id = "esapi_plate",
    category = "armor",
    name = ccb.content.text("ESAPI ballistic plate"),
    description = ccb.content.text("A polygonal ballistic plate with a slightly concave profile, made of ceramic.  Its inner surface is coated with UHMW polyethylene and is labeled \"TOP\", while the outer surface is labeled \"STRIKE FACE\".  This is intended to be worn in a ballistic vest, and can withstand several high-energy rifle rounds before breaking."),
    mass = "2500 g",
    volume = "1915 ml",
    length = "32 cm",
    price = "600 USD",
    survival_price = "1 USD",
    materials = { "ceramic" },
    symbol = ",",
    color = "dark_gray",
    flags = { "ABLATIVE_LARGE", "CANT_WEAR", "NO_SALVAGE" },
    armor = {
        thickness = 25,
        broken_item = "destroyed_large_ceramic_plate",
        damage_verb = ccb.content.text("makes a crunch, something has shifted"),
        portions = { { encumbrance = 2, coverage = 45, covers = { "torso" }, subparts = { "torso_upper" } } },
    },
}

-- based on https://www.highcomarmor.com/product/trooper-hcspike3/
ccb.content.define_item {
    id = "stab_plate",
    category = "armor",
    name = ccb.content.text("soft stab panel"),
    description = ccb.content.text("A soft armor insert designed to protect against stab wounds.  While it's not great protection, it incurs no additional encumbrance.  This is intended to be inserted into a ballistic vest, and can't be worn on its own."),
    mass = "500 g",
    volume = "300 ml",
    length = "16 cm",
    price = "600 USD",
    survival_price = "1 USD",
    materials = { "kevlar", "nylon" },
    symbol = ",",
    color = "dark_gray",
    flags = { "ABLATIVE_LARGE", "CANT_WEAR", "STURDY", "NO_SALVAGE" },
    armor = {
        thickness = 3,
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "kevlar", coverage = 100, thickness = 2.3 },
                },
                encumbrance = 0,
                coverage = 45,
                covers = { "torso" },
                subparts = { "torso_upper" },
            },
        },
    },
}

-- based on 3a plates. Discuss high temp quenching so gonna assume tempered steel
-- link like: https://www.shindn.com/products/nij-iiia?variant=35614363582627&currency=USD&utm_medium=product_sync&utm_source=google&utm_content=sag_organic&utm_campaign=sag_organic&utm_campaign=gs-2019-08-03&utm_source=google&utm_medium=smart_campaign&gclid=Cj0KCQjw5-WRBhCKARIsAAId9FlGQAManRGZ0qpV9AIkD23FZfpm4aPDI4PHE9qPktZ2bdQY2NmcIVkaAs2pEALw_wcB
-- 30cm x 25cm x .35cm
ccb.content.define_item {
    id = "steel_ballistic_plate",
    category = "armor",
    name = ccb.content.text("steel ballistic plate"),
    description = ccb.content.text("A concave ballistic plate made of hard steel, designed to stop small-caliber rounds.  \"NIJ III A PROTECTION\" is etched into the back of the plate.  This is intended to be inserted into a ballistic vest, and can't be worn on its own."),
    mass = "1400 g",
    volume = "262 ml",
    price = "600 USD",
    length = "30 cm",
    survival_price = "1 USD",
    materials = { "qt_steel", "nylon" },
    repair_materials = { "qt_steel" },
    symbol = ",",
    color = "dark_gray",
    flags = { "ABLATIVE_LARGE", "CANT_WEAR", "STURDY", "NO_SALVAGE" },
    armor = {
        thickness = 3,
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "qt_steel", coverage = 100, thickness = 2.5 },
                },
                encumbrance = 1,
                coverage = 45,
                covers = { "torso" },
                subparts = { "torso_upper" },
            },
        },
    },
}

-- based on level 3 plates. Discuss high temp quenching so gonna assume tempered steel
-- link like: https://www.spartanarmorsystems.com/spartan-omega-ar500-body-armor-single-plate/
-- 25.4cm x 30.48cm x 0.635cm plate measurements (thin plate!)
ccb.content.define_item {
    id = "heavy_steel_ballistic_plate",
    category = "armor",
    name = ccb.content.text("heavy steel ballistic plate"),
    description = ccb.content.text("A heavy concave ballistic plate made of tempered steel, designed to stop small-caliber rounds.  \"NIJ III PROTECTION\" is etched into the back of the plate.  This is intended to be inserted into a ballistic vest, and can't be worn on its own."),
    mass = "3912 g",
    volume = "194 ml",
    length = "30 cm",
    price = "600 USD",
    survival_price = "1 USD",
    materials = { "qt_steel", "nylon" },
    repair_materials = { "qt_steel" },
    symbol = ",",
    color = "dark_gray",
    flags = { "ABLATIVE_LARGE", "CANT_WEAR", "STURDY", "NO_SALVAGE" },
    armor = {
        thickness = 6.35,
        portions = {
            {
                materials = { { id = "qt_steel", coverage = 100, thickness = 6.35 } },
                encumbrance = 3,
                coverage = 45,
                covers = { "torso" },
                subparts = { "torso_upper" },
            },
        },
    },
}

-- some crude metal chopped and bent to fit into a plate carrier. not great, but better than nothing. added the cotton component cause i'd imagine a jagged piece of metal would cut through a ballistic vest and this is based on the existing scrap armor
-- requested in https://github.com/CleverRaven/Cataclysm-DDA/issues/49477
-- 30cm x 25cm x 0.2cm
ccb.content.define_item {
    id = "scrap_esapi_plate",
    category = "armor",
    name = ccb.content.text("scrap ESAPI plate"),
    description = ccb.content.text("A flat piece of salvaged steel, crudely cut and bent into the shape of an ESAPI ballistic plate.  It's wrapped in rags to cover the sharp edges.  Better than nothing, but it's heavier than the real thing, and not very strong.  This is intended to be inserted into a ballistic vest, and can't be worn on its own."),
    mass = "1181 g",
    length = "30 cm",
    volume = "150 ml",
    price = "50 USD",
    survival_price = "1 USD",
    materials = { "budget_steel" },
    symbol = ",",
    color = "dark_gray",
    flags = { "ABLATIVE_LARGE", "CANT_WEAR" },
    armor = {
        thickness = 3,
        portions = {
            {
                materials = {
                    { id = "budget_steel", coverage = 90, thickness = 2 },
                    { id = "cotton", coverage = 100, thickness = 1 },
                },
                encumbrance = 3,
                coverage = 45,
                covers = { "torso" },
                subparts = { "torso_upper" },
            },
        },
    },
}

-- Similar to scrap plates, except made with higher quality steel. A goal for blacksmithing.
ccb.content.define_item {
    id = "lc_esapi_plate",
    copy_from = "scrap_esapi_plate",
    looks_like = "scrap_esapi_plate",
    repair_like = "hsurvivor_jumpsuit",
    name = ccb.content.text("mild ESAPI plate"),
    description = ccb.content.text("Mild steel forged into a ballistic plate.  While it is more professionally done than scrap plates, it still has a fair amount of jerry-rigging."),
    mass = "1300 g",
    volume = "262 ml",
    length = "30 cm",
    materials = { { id = "lc_steel", portions = 4 }, { id = "nylon" } },
    repair_materials = { "lc_steel" },
    flags = { "ABLATIVE_LARGE", "CANT_WEAR", "STURDY", "NO_SALVAGE" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "lc_steel", coverage = 100, thickness = 2.3 },
                    { id = "nylon", coverage = 100, thickness = 1.2 },
                },
                encumbrance = 1,
                coverage = 45,
                covers = { "torso" },
                subparts = { "torso_upper" },
            },
        },
    },
}

ccb.content.define_item {
    id = "mc_esapi_plate",
    copy_from = "lc_esapi_plate",
    looks_like = "scrap_esapi_plate",
    name = ccb.content.text("medium ESAPI plate"),
    description = ccb.content.text("Medium steel forged into a ballistic plate.  While it is more professionally done than scrap plates, it still has a fair amount of jerry-rigging."),
    replace_materials = { lc_steel = "mc_steel" },
    repair_materials = { "mc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "hc_esapi_plate",
    copy_from = "lc_esapi_plate",
    looks_like = "scrap_esapi_plate",
    name = ccb.content.text("high ESAPI plate"),
    description = ccb.content.text("High steel forged into a ballistic plate.  While it is more professionally done than most scrap plates, it still has a fair amount of jerry-rigging."),
    replace_materials = { lc_steel = "hc_steel" },
    repair_materials = { "hc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "ch_esapi_plate",
    copy_from = "lc_esapi_plate",
    looks_like = "scrap_esapi_plate",
    name = ccb.content.text("hard ESAPI plate"),
    description = ccb.content.text("Hardened steel forged into a ballistic plate.  While it is more professionally done than most scrap plates, it still has a fair amount of jerry-rigging."),
    replace_materials = { lc_steel = "ch_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "qt_esapi_plate",
    copy_from = "lc_esapi_plate",
    looks_like = "scrap_esapi_plate",
    name = ccb.content.text("tempered ESAPI plate"),
    description = ccb.content.text("Tempered steel forged into a ballistic plate.  While it is more professionally done than most scrap plates, it still has a fair amount of jerry-rigging."),
    replace_materials = { lc_steel = "qt_steel" },
    repair_materials = { "mc_steel" },
    armor = {},
}

-- 2x 20.5cm x 13.0cm x 3.0cm
ccb.content.define_item {
    id = "deltoid_plates",
    category = "armor",
    name = ccb.content.plural_text("deltoid ballistic plates", "deltoid ballistic plates"),
    description = ccb.content.text("A pair of NIJ Level III ballistic plates with a concave profile, made of UHMW polyethylene.  \"STRIKE FACE\" is printed on its outer surface.  These plates are designed to be worn in the shoulder pockets of suitable plate carriers or combat shirts, and can resist several high-energy rifle rounds before breaking.  Deltoid plates such as these are very infrequently worn due to their marginal utility in improving survivability."),
    mass = "1551 g",
    volume = "1599 ml",
    length = "21 cm",
    price = "944 USD",
    survival_price = "8 USD",
    materials = { "thermo_resin" },
    symbol = ",",
    color = "light_gray",
    flags = { "ABLATIVE_MEDIUM", "CANT_WEAR", "NO_SALVAGE" },
    armor = {
        thickness = 14,
        damage_verb = ccb.content.text("makes a crunch, something has shifted"),
        portions = {
            {
                encumbrance = 8,
                coverage = 35,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_shoulder_r" },
            },
        },
    },
}

-- 20.32cm x 15.24cm x 2.5cm
ccb.content.define_item {
    id = "esbi_plate",
    category = "armor",
    name = ccb.content.text("ESBI ballistic plate"),
    description = ccb.content.text("A polygonal ballistic plate with a slightly concave profile, made of ceramic.  \"STRIKE FACE\" is printed on its outer surface.  This is designed to be worn in the sides of a plate carrier, and can withstand several high-energy rifle rounds before breaking."),
    mass = "993 g",
    volume = "774 ml",
    length = "20 cm",
    price = "600 USD",
    survival_price = "1 USD",
    materials = { "ceramic" },
    symbol = ",",
    color = "dark_gray",
    flags = { "ABLATIVE_MEDIUM", "CANT_WEAR", "NO_SALVAGE" },
    armor = {
        thickness = 25,
        broken_item = "destroyed_medium_ceramic_plate",
        damage_verb = ccb.content.text("makes a crunch, something has shifted"),
        portions = { { encumbrance = 1, coverage = 35, covers = { "torso" }, subparts = { "torso_lower" } } },
    },
}

-- some crude metal chopped and bent to fit into a plate carrier. not great, but better than nothing. added the cotton component cause i'd imagine a jagged piece of metal would cut through a ballistic vest and this is based on the existing scrap armor
-- requested in https://github.com/CleverRaven/Cataclysm-DDA/issues/49477
-- 15.24cm x 20.32cm x 0.2cm
ccb.content.define_item {
    id = "scrap_esbi_plate",
    category = "armor",
    name = ccb.content.text("scrap ESBI plate"),
    description = ccb.content.text("A flat piece of salvaged steel, crudely cut and bent into the shape of an ESBI ballistic plate.  It's wrapped in rags to cover the sharp edges.  Better than nothing, but it's heavy, and not very strong.  This is intended to be inserted into a ballistic vest, and can't be worn on its own."),
    mass = "488 g",
    volume = "62 ml",
    length = "20 cm",
    price = "30 USD",
    survival_price = "1 USD",
    materials = { "budget_steel" },
    symbol = ",",
    color = "dark_gray",
    flags = { "ABLATIVE_MEDIUM", "CANT_WEAR" },
    armor = {
        thickness = 3,
        portions = {
            {
                materials = {
                    { id = "budget_steel", coverage = 90, thickness = 2 },
                    { id = "cotton", coverage = 100, thickness = 1 },
                },
                encumbrance = 1,
                coverage = 35,
                covers = { "torso" },
                subparts = { "torso_lower" },
            },
        },
    },
}

-- These will probably be in higher demand since there is no steel version of ESBI plates.
ccb.content.define_item {
    id = "lc_esbi_plate",
    copy_from = "scrap_esbi_plate",
    looks_like = "scrap_esbi_plate",
    repair_like = "hsurvivor_jumpsuit",
    name = ccb.content.text("mild ESBI plate"),
    description = ccb.content.text("A hexagonal piece of mild steel forged into a side plate and padded with synthetic fabric.  While it is more professionally done than scrap plates, it still has a fair amount of jerry-rigging."),
    mass = "1300 g",
    volume = "262 ml",
    length = "20 cm",
    materials = { { id = "lc_steel", portions = 4 }, { id = "nylon" } },
    repair_materials = { "lc_steel" },
    flags = { "ABLATIVE_MEDIUM", "CANT_WEAR", "STURDY", "NO_SALVAGE" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "lc_steel", coverage = 100, thickness = 2.3 },
                    { id = "nylon", coverage = 100, thickness = 1.2 },
                },
                encumbrance = 1,
                coverage = 35,
                covers = { "torso" },
                subparts = { "torso_lower" },
            },
        },
    },
}

ccb.content.define_item {
    id = "mc_esbi_plate",
    copy_from = "lc_esbi_plate",
    looks_like = "scrap_esbi_plate",
    name = ccb.content.text("medium ESBI plate"),
    description = ccb.content.text("A hexagonal piece of medium steel forged into a side plate and padded with synthetic fabric.  While it is more professionally done than scrap plates, it still has a fair amount of jerry-rigging."),
    replace_materials = { lc_steel = "mc_steel" },
    repair_materials = { "mc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "hc_esbi_plate",
    copy_from = "lc_esbi_plate",
    looks_like = "scrap_esbi_plate",
    name = ccb.content.text("high ESBI plate"),
    description = ccb.content.text("A hexagonal piece of high steel forged into a side plate and padded with synthetic fabric.  While it is more professionally done than scrap plates, it still has a fair amount of jerry-rigging."),
    replace_materials = { lc_steel = "hc_steel" },
    repair_materials = { "hc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "ch_esbi_plate",
    copy_from = "lc_esbi_plate",
    looks_like = "scrap_esbi_plate",
    name = ccb.content.text("hard ESBI plate"),
    description = ccb.content.text("A hexagonal piece of hardened steel forged into a side plate and padded with synthetic fabric.  While it is more professionally done than scrap plates, it still has a fair amount of jerry-rigging."),
    replace_materials = { lc_steel = "ch_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "qt_esbi_plate",
    copy_from = "lc_esbi_plate",
    looks_like = "scrap_esbi_plate",
    name = ccb.content.text("tempered ESBI plate"),
    description = ccb.content.text("A hexagonal piece of tempered steel forged into a side plate and padded with synthetic fabric.  While it is more professionally done than scrap plates, it still has a fair amount of jerry-rigging."),
    replace_materials = { lc_steel = "qt_steel" },
    repair_materials = { "mc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "destroyed_large_ceramic_plate",
    copy_from = "esapi_plate",
    name = ccb.content.text("compromised ceramic front plate"),
    description = ccb.content.text("A large ballistic plate that has been cracked by damage.  It no longer provides reliable protection, but it's still just as heavy."),
    price = "0 cent",
    survival_price = "1 cent",
    looks_like = "esapi_plate",
    materials = { "damaged_ceramic" },
    armor = {},
}

ccb.content.define_item {
    id = "destroyed_medium_ceramic_plate",
    copy_from = "esbi_plate",
    name = ccb.content.text("compromised ceramic side plate"),
    description = ccb.content.text("A medium-sized ballistic plate that has been cracked by damage.  It no longer provides reliable protection, but it's still just as heavy."),
    price = "0 cent",
    survival_price = "1 cent",
    looks_like = "esbi_plate",
    materials = { "damaged_ceramic" },
    armor = {},
}

-- Based on US Army IOTV. Weight from size M base piece plus lower back protector, data from: https://www.moore.army.mil/tenant/lrc/content/pdf/IOTV%20GEN%20III%20TM%2010-8470-210-10.pdf
-- Should fit a medium ESAPI plate snugly
ccb.content.define_item {
    id = "ballistic_vest_heavy",
    category = "armor",
    name = ccb.content.plural_text("US heavy ballistic vest", "US heavy ballistic vests"),
    description = ccb.content.text("Heavier ballistic armor used by the US Army, known as the IOTV.  It has pockets on the front, back, and sides for armor plates; additional protection for the lower back; and attachment points for optional shoulder, groin, and neck protection."),
    mass = "4976 g",
    volume = "6 L",
    variant_kind = "generic",
    looks_like = "ballistic_vest_esapi",
    variants = {
        {
            id = "ballistic_vest_heavy_military",
            name = ccb.content.plural_text("heavy ballistic vest", "heavy ballistic vests"),
            description = ccb.content.text("It's a dark olive color."),
            color = "light_green",
            weight = 4,
            append = true,
        },
        {
            id = "ballistic_vest_heavy_xedra",
            name = ccb.content.plural_text("XEDRA containment armor", "XEDRA containment armors"),
            description = ccb.content.text("It's black with IR reflective markings and a large XE on the right shoulder."),
            color = "light_green",
            weight = 0,
            append = true,
        },
    },
    price = "1600 USD",
    survival_price = "10 USD",
    symbol = "[",
    materials = { "nylon", "kevlar_layered" },
    color = "light_gray",
    flags = { "STURDY", "OUTER", "WATER_FRIENDLY", "PADDED" },
    pockets = {
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "2000 ml",
            mass_limit = "5 kg",
            max_item_length = "33 cm",
            moves = 800,
            description = ccb.content.text("Pocket for a large armor plate."),
            allowed_flags = { "ABLATIVE_LARGE" },
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "2000 ml",
            mass_limit = "5 kg",
            max_item_length = "33 cm",
            moves = 800,
            description = ccb.content.text("Pocket for a large armor plate."),
            allowed_flags = { "ABLATIVE_LARGE" },
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "800 ml",
            mass_limit = "2 kg",
            max_item_length = "21 cm",
            moves = 800,
            description = ccb.content.text("Pocket for a medium armor plate."),
            allowed_flags = { "ABLATIVE_MEDIUM" },
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "800 ml",
            mass_limit = "2 kg",
            max_item_length = "21 cm",
            moves = 800,
            description = ccb.content.text("Pocket for a medium armor plate."),
            allowed_flags = { "ABLATIVE_MEDIUM" },
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "1000 ml",
            mass_limit = "1200 kg",
            max_item_length = "21 cm",
            moves = 800,
            description = ccb.content.text("Attachment for shoulder protectors."),
            allowed_items = { "iotv_shoulder_plate" },
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "800 ml",
            mass_limit = "800 g",
            max_item_length = "21 cm",
            moves = 800,
            description = ccb.content.text("Attachment for a groin protector."),
            allowed_items = { "iotv_groin_plate" },
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "800 ml",
            mass_limit = "800 g",
            max_item_length = "21 cm",
            moves = 800,
            description = ccb.content.text("Attachment for a collar."),
            allowed_items = { "iotv_neck_plate" },
        },
    },
    armor = {
        warmth = 15,
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "kevlar_layered", coverage = 95, thickness = 4.4 },
                },
                encumbrance = 6,
                coverage = 100,
                vitals_coverage = 90,
                covers = { "torso" },
                subparts = { "torso_upper" },
                volume_encumbrance = 0.3,
            },
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "kevlar_layered", coverage = 95, thickness = 4.4 },
                },
                encumbrance = 0,
                coverage = 90,
                vitals_coverage = 90,
                covers = { "torso" },
                subparts = { "torso_lower" },
                volume_encumbrance = 0,
            },
        },
    },
    use_actions = { { kind = "attach_molle", size = 10 }, { kind = "detach_molle" } },
}

-- based on smaller thorax only plate carriers
ccb.content.define_item {
    id = "ballistic_vest_light",
    copy_from = "ballistic_vest_esapi",
    name = ccb.content.plural_text("light ballistic vest (mag pouches)", "light ballistic vests (mag pouches)"),
    description = ccb.content.text("A simple plate carrier covering the thorax, with front and back pockets for armor plates.  Designed to keep your organs from being perforated by small-arms fire.  This version has a MOLLE cummerbund that you can tuck a few magazines into."),
    variant_kind = "generic",
    variants = {
        {
            id = "ballistic_vest_light_olive",
            name = ccb.content.plural_text("olive light ballistic vest (mag pouches)", "olive light ballistic vests (mag pouches)"),
            description = ccb.content.text("It's styled in a dark olive color."),
            color = "light_green",
            weight = 4,
            append = true,
        },
        {
            id = "ballistic_vest_light_tan",
            name = ccb.content.plural_text("tan light ballistic vest (mag pouches)", "tan light ballistic vests (mag pouches)"),
            description = ccb.content.text("It's styled in a tan color."),
            color = "brown",
            weight = 4,
            append = true,
        },
        {
            id = "ballistic_vest_light_black",
            name = ccb.content.plural_text("black light ballistic vest (mag pouches)", "black light ballistic vests (mag pouches)"),
            description = ccb.content.text("It's colored dark gray, like something a contractor might wear."),
            color = "dark_gray",
            weight = 4,
            append = true,
        },
        {
            id = "ballistic_vest_light_future",
            name = ccb.content.plural_text("hexagonal light ballistic vest (mag pouches)", "hexagonal light ballistic vests (mag pouches)"),
            description = ccb.content.text("It's decorated in a pattern of spiraling hexagons that screams style over substance."),
            symbol = "O",
            append = true,
        },
        {
            id = "ballistic_vest_light_punisher",
            name = ccb.content.plural_text("skull light ballistic vest (mag pouches)", "skull light ballistic vests (mag pouches)"),
            description = ccb.content.text("Someone has spray-painted a large white skull on the front."),
            symbol = "S",
            color = "white",
            append = true,
        },
        {
            id = "ballistic_vest_light_meme",
            name = ccb.content.plural_text("gaudy light ballistic vest (mag pouches)", "gaudy light ballistic vests (mag pouches)"),
            description = ccb.content.text("The original owner has decorated this thing with an excessive number of patches; inane slogans, political punch lines, and cartoon characters making bedroom eyes are plastered all over the front."),
            symbol = "#",
            color = "light_red",
            append = true,
        },
    },
    mass = "900 g",
    volume = "4 L",
    materials = { "nylon", "kevlar_layered" },
    pockets = {
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "2000 ml",
            mass_limit = "5 kg",
            max_item_length = "33 cm",
            moves = 800,
            description = ccb.content.text("Pocket for a large armor plate."),
            allowed_flags = { "ABLATIVE_LARGE" },
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "2000 ml",
            mass_limit = "5 kg",
            max_item_length = "33 cm",
            moves = 800,
            description = ccb.content.text("Pocket for a large armor plate."),
            allowed_flags = { "ABLATIVE_LARGE" },
        },
        {
            kind = "CONTAINER",
            capacity = "900 ml",
            mass_limit = "3 kg",
            max_item_length = "25 cm",
            moves = 50,
            description = ccb.content.text("Low-profile magazine storage."),
            allowed_flags = { "MAG_COMPACT" },
        },
    },
    armor = {
        warmth = 0,
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "kevlar_layered", coverage = 100, thickness = 4.4 },
                },
                encumbrance = 1,
                coverage = 90,
                covers = { "torso" },
                subparts = { "torso_upper" },
                volume_encumbrance = 0.3,
            },
        },
    },
    use_actions = { { kind = "attach_molle", size = 6 }, { kind = "detach_molle" } },
}

-- based on smaller thorax only plate carriers
ccb.content.define_item {
    id = "ballistic_vest_light_pouches",
    copy_from = "ballistic_vest_light",
    name = ccb.content.plural_text("light ballistic vest (storage pouch)", "light ballistic vests (storage pouch)"),
    description = ccb.content.text("A simple plate carrier covering the thorax, with front and back pockets for armor plates.  Designed to keep your organs from being perforated by small-arms fire.  This version has a small pouch on the front to store stuff."),
    variant_kind = "generic",
    variants = {
        {
            id = "ballistic_vest_light_olive",
            name = ccb.content.plural_text("olive light ballistic vest (storage pouch)", "olive light ballistic vests (storage pouch)"),
            description = ccb.content.text("It's styled in a dark olive color."),
            color = "light_green",
            weight = 4,
            append = true,
        },
        {
            id = "ballistic_vest_light_tan",
            name = ccb.content.plural_text("tan light ballistic vest (storage pouch)", "tan light ballistic vests (storage pouch)"),
            description = ccb.content.text("It's styled in a tan color."),
            color = "brown",
            weight = 4,
            append = true,
        },
        {
            id = "ballistic_vest_light_black",
            name = ccb.content.plural_text("black light ballistic vest (storage pouch)", "black light ballistic vests (storage pouch)"),
            description = ccb.content.text("It's colored dark gray, like something a contractor might wear."),
            color = "dark_gray",
            weight = 4,
            append = true,
        },
        {
            id = "ballistic_vest_light_future",
            name = ccb.content.plural_text("hexagonal light ballistic vest (storage pouch)", "hexagonal light ballistic vests (storage pouch)"),
            description = ccb.content.text("It's decorated in a pattern of spiraling hexagons that screams style over substance."),
            symbol = "O",
            append = true,
        },
        {
            id = "ballistic_vest_light_punisher",
            name = ccb.content.plural_text("skull light ballistic vest (storage pouch)", "skull light ballistic vests (storage pouch)"),
            description = ccb.content.text("Someone has spray-painted a large white skull on the front."),
            symbol = "S",
            color = "white",
            append = true,
        },
        {
            id = "ballistic_vest_light_meme",
            name = ccb.content.plural_text("gaudy light ballistic vest (storage pouch)", "gaudy light ballistic vests (storage pouch)"),
            description = ccb.content.text("The original owner has decorated this thing with an excessive number of patches; inane slogans, political punch lines, and cartoon characters making bedroom eyes are plastered all over the front."),
            symbol = "#",
            color = "light_red",
            append = true,
        },
    },
    pockets = {
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "2000 ml",
            mass_limit = "5 kg",
            max_item_length = "33 cm",
            moves = 800,
            description = ccb.content.text("Pocket for a large armor plate."),
            allowed_flags = { "ABLATIVE_LARGE" },
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "2000 ml",
            mass_limit = "5 kg",
            max_item_length = "33 cm",
            moves = 800,
            description = ccb.content.text("Pocket for a large armor plate."),
            allowed_flags = { "ABLATIVE_LARGE" },
        },
        {
            kind = "CONTAINER",
            capacity = "900 ml",
            mass_limit = "3 kg",
            max_item_length = "25 cm",
            moves = 50,
            description = ccb.content.text("Low-profile zipper storage pouch."),
            volume_encumbrance = 0.4,
        },
    },
    armor = {},
}

-- based on smaller thorax only plate carriers
ccb.content.define_item {
    id = "ballistic_vest_light_operator",
    copy_from = "ballistic_vest_light",
    name = ccb.content.plural_text("light ballistic vest (shoulder pouch)", "light ballistic vests (shoulder pouch)"),
    description = ccb.content.text("A simple plate carrier covering the thorax, with front and back pockets for armor plates.  Designed to keep your organs from being perforated by small-arms fire.  This version has a shoulder-mounted pouch for a radio and a hook on the front for a glowstick."),
    variant_kind = "generic",
    variants = {
        {
            id = "ballistic_vest_light_olive",
            name = ccb.content.plural_text("olive light ballistic vest (shoulder pouch)", "olive light ballistic vests (shoulder pouch)"),
            description = ccb.content.text("It's styled in a dark olive color."),
            color = "light_green",
            weight = 4,
            append = true,
        },
        {
            id = "ballistic_vest_light_tan",
            name = ccb.content.plural_text("tan light ballistic vest (shoulder pouch)", "tan light ballistic vests (shoulder pouch)"),
            description = ccb.content.text("It's styled in a tan color."),
            color = "brown",
            weight = 4,
            append = true,
        },
        {
            id = "ballistic_vest_light_black",
            name = ccb.content.plural_text("black light ballistic vest (shoulder pouch)", "black light ballistic vests (shoulder pouch)"),
            description = ccb.content.text("It's colored dark gray, like something a contractor might wear."),
            color = "dark_gray",
            weight = 4,
            append = true,
        },
        {
            id = "ballistic_vest_light_future",
            name = ccb.content.plural_text("hexagonal light ballistic vest (shoulder pouch)", "hexagonal light ballistic vests (shoulder pouch)"),
            description = ccb.content.text("It's decorated in a pattern of spiraling hexagons that screams style over substance."),
            symbol = "O",
            append = true,
        },
        {
            id = "ballistic_vest_light_punisher",
            name = ccb.content.plural_text("skull light ballistic vest (shoulder pouch)", "skull light ballistic vests (shoulder pouch)"),
            description = ccb.content.text("Someone has spray-painted a large white skull on the front."),
            symbol = "S",
            color = "white",
            append = true,
        },
        {
            id = "ballistic_vest_light_meme",
            name = ccb.content.plural_text("gaudy light ballistic vest (shoulder pouch)", "gaudy light ballistic vests (shoulder pouch)"),
            description = ccb.content.text("The original owner has decorated this thing with an excessive number of patches; inane slogans, political punch lines, and cartoon characters making bedroom eyes are plastered all over the front."),
            symbol = "#",
            color = "light_red",
            append = true,
        },
    },
    pockets = {
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "2000 ml",
            mass_limit = "5 kg",
            max_item_length = "33 cm",
            moves = 800,
            description = ccb.content.text("Pocket for a large armor plate."),
            allowed_flags = { "ABLATIVE_LARGE" },
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "2000 ml",
            mass_limit = "5 kg",
            max_item_length = "33 cm",
            moves = 800,
            description = ccb.content.text("Pocket for a large armor plate."),
            allowed_flags = { "ABLATIVE_LARGE" },
        },
        {
            kind = "CONTAINER",
            capacity = "500 ml",
            mass_limit = "500 g",
            max_item_length = "13 cm",
            moves = 40,
            description = ccb.content.text("Shoulder-mounted radio pouch."),
            volume_encumbrance = 0.4,
        },
        {
            kind = "CONTAINER",
            capacity = "30 ml",
            mass_limit = "40 g",
            max_item_length = "15 cm",
            holster = true,
            moves = 20,
            description = ccb.content.text("Hook for a glowstick."),
            volume_encumbrance = 0.4,
        },
    },
    armor = {},
}

-- Based on security vests like https://www.bodyarmourcanada.com/shop-bullet-resistant-or-stab-resistant/vector-nij-ii-security-bullet-resistant-vest
ccb.content.define_item {
    id = "stab_vest",
    category = "armor",
    looks_like = "kevlar",
    name = ccb.content.text("stab vest"),
    variant_kind = "generic",
    variants = {
        {
            id = "security_stab_vest",
            name = ccb.content.text("security stab vest"),
            description = ccb.content.text("A slim security vest used by mall cops.  Its protection is mostly meant to extend to knives and not actual bullets, but at least it kept insurance costs down.  It has \"SECURITY\" written on the front lapel and across the back, and features a pocket for a notebook and pen."),
        },
        {
            id = "airsoft_stab_vest",
            name = ccb.content.text("airsoft vest"),
            description = ccb.content.text("A low-cost tactical vest styled in black camouflage, used in cosplay and airsoft.  It'll let you shrug off airsoft pellets like a badass, but its protection is mediocre against anything that's actually dangerous.  It sports several small pouches, and includes touch fasteners to attach identifying patches."),
            color = "dark_gray",
        },
    },
    description = ccb.content.text("A simple Level II protection vest."),
    mass = "1814 g",
    volume = "6 L",
    price = "470 USD",
    survival_price = "4 USD",
    symbol = "[",
    materials = { "nylon", "kevlar" },
    color = "light_gray",
    flags = { "STURDY", "OUTER", "WATER_FRIENDLY" },
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "500 ml",
            mass_limit = "1 kg",
            max_item_length = "13 cm",
            moves = 120,
            volume_encumbrance = 0.4,
        },
        {
            kind = "CONTAINER",
            capacity = "500 ml",
            mass_limit = "1 kg",
            max_item_length = "13 cm",
            moves = 120,
            volume_encumbrance = 0.4,
        },
        {
            kind = "CONTAINER",
            capacity = "10 ml",
            mass_limit = "50 g",
            max_item_length = "13 cm",
            moves = 120,
            volume_encumbrance = 0,
        },
    },
    armor = {
        warmth = 10,
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "kevlar", coverage = 95, thickness = 2 },
                },
                encumbrance = 4,
                coverage = 100,
                vitals_coverage = 70,
                covers = { "torso" },
            },
        },
    },
}

-- Based on security vests like https://canarmor.ca/product/lifeguard-black-nij-iii-a/
-- encumbrance handled above
ccb.content.define_item {
    id = "soft_3a_vest",
    category = "armor",
    name = ccb.content.text("soft armor vest"),
    looks_like = "kevlar",
    variants = {
        {
            id = "security_armor_vest",
            name = ccb.content.text("security ballistic vest"),
            description = ccb.content.text("A lightweight black vest used by private security, covering the chest and most of the abdomen.  Soft armor plates sealed inside the fabric provide solid defense against shrapnel and small-caliber rounds.  \"SECURITY\" is emblazoned on the front lapel and across the back, and it features a pocket for a notebook and pen."),
        },
        {
            id = "press_armor_vest",
            name = ccb.content.text("press ballistic vest"),
            description = ccb.content.text("Colored a distinctive navy blue and with a flared collar extending up to the chin, this soft body armor was once used by news crews reporting from combat zones.  It provides good protection from shrapnel, and to a lesser degree, low-caliber bullets.  \"PRESS\" is emblazoned prominently on the front lapel and across the back, and it features a pocket for a notebook and pen."),
            color = "blue",
        },
    },
    variant_kind = "generic",
    description = ccb.content.text("A simple soft armor ballistic vest."),
    mass = "2650 g",
    volume = "6 L",
    price = "700 USD",
    survival_price = "5 USD",
    symbol = "[",
    materials = { "nylon", "kevlar_layered" },
    color = "light_gray",
    flags = { "STURDY", "OUTER", "WATER_FRIENDLY" },
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "500 ml",
            mass_limit = "1 kg",
            max_item_length = "13 cm",
            moves = 120,
            volume_encumbrance = 0.4,
        },
        {
            kind = "CONTAINER",
            capacity = "500 ml",
            mass_limit = "1 kg",
            max_item_length = "13 cm",
            moves = 120,
            volume_encumbrance = 0.4,
        },
        {
            kind = "CONTAINER",
            capacity = "10 ml",
            mass_limit = "50 g",
            max_item_length = "13 cm",
            moves = 120,
            volume_encumbrance = 0,
        },
    },
    armor = {
        warmth = 15,
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "kevlar_layered", coverage = 95, thickness = 4.4 },
                },
                encumbrance = 4,
                coverage = 100,
                vitals_coverage = 70,
                covers = { "torso" },
                subparts = { "torso_upper" },
            },
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "kevlar_layered", coverage = 95, thickness = 4.4 },
                },
                encumbrance = 0,
                coverage = 80,
                covers = { "torso" },
                subparts = { "torso_lower" },
            },
        },
    },
}

-- delete security vest variants
-- Based on the exact model; https://www.tyrtactical.com/shop/tyr-tactical-male-epic-federal-outer-carrier/
ccb.content.define_item {
    id = "fbi_armor_vest",
    copy_from = "soft_3a_vest",
    name = ccb.content.plural_text("FBI ballistic vest", "FBI ballistic vests"),
    variants = {},
    description = ccb.content.text("A ranger green soft ballistic vest with MOLLE rigging used by federal law enforcement agencies.  Soft armor plates inside the vest provide solid defense against shrapnel and small-caliber rounds.  \"FBI\" is emblazoned across the front and back in large, yellow lettering, and it includes a pocket for storing evidence.  Use it to attach or detach pouches."),
    armor = {},
    use_actions = { { kind = "attach_molle", size = 6 }, { kind = "detach_molle" } },
}

-- Based on security vests like https://www.masadagear.com/p/masada_armour_%E2%80%8Bun_bullet_proof_vest
-- encumbrance handled above
ccb.content.define_item {
    id = "level_3_vest",
    category = "armor",
    name = ccb.content.text("hard armor vest"),
    looks_like = "ballistic_vest_esapi",
    variants = {
        {
            id = "fema_armor_vest",
            name = ccb.content.text("humanitarian ballistic vest"),
            description = ccb.content.text("Bright blue in color, this slim armor vest was used by volunteers and officials from humanitarian groups during the first days of the Cataclysm before order broke down completely.  \"FEMA\" is written on the front lapel and across the back."),
            color = "blue",
        },
        {
            id = "police_armor_vest",
            name = ccb.content.text("police ballistic vest"),
            description = ccb.content.text("This charcoal-colored body armor was once a common sight on police officers, and it provides adequate protection against small-caliber firearms in addition to featuring pouches to hold armor inserts.  \"POLICE\" is written on the front lapel and across the back."),
        },
        {
            id = "national_guard_armor_vest",
            name = ccb.content.text("National Guard ballistic vest"),
            description = ccb.content.text("Styled in urban camo, this ballistic vest was issued to soldiers, and as things got worse, to volunteers as well.  It was designed to stand out after the chaos of the riots; \"US ARMY\" is emblazoned on the front lapel next to a patch of the United States flag, and \"NATIONAL GUARD\" is written across the back."),
        },
    },
    variant_kind = "generic",
    description = ccb.content.text("Armored panels give this vest solid defense against small caliber firearms, and front and back pockets for hard armor panels give protection from higher calibers."),
    mass = "2650 g",
    volume = "6 L",
    price = "700 USD",
    survival_price = "5 USD",
    symbol = "[",
    materials = { "nylon", "kevlar_layered" },
    color = "light_gray",
    flags = { "STURDY", "OUTER", "WATER_FRIENDLY" },
    pockets = {
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "2000 ml",
            mass_limit = "5 kg",
            max_item_length = "33 cm",
            moves = 800,
            description = ccb.content.text("Pocket for a large armor plate."),
            allowed_flags = { "ABLATIVE_LARGE" },
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "2000 ml",
            mass_limit = "5 kg",
            max_item_length = "33 cm",
            moves = 800,
            description = ccb.content.text("Pocket for a large armor plate."),
            allowed_flags = { "ABLATIVE_LARGE" },
        },
    },
    armor = {
        warmth = 15,
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "kevlar_layered", coverage = 95, thickness = 4.4 },
                },
                encumbrance = 4,
                coverage = 100,
                vitals_coverage = 90,
                covers = { "torso" },
                subparts = { "torso_upper" },
            },
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "kevlar_layered", coverage = 95, thickness = 4.4 },
                },
                encumbrance = 0,
                coverage = 80,
                covers = { "torso" },
                subparts = { "torso_lower" },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_ballistic_vest",
    category = "armor",
    name = ccb.content.plural_text("ballistic vest", "ballistic vests"),
    description = ccb.content.text("An enormous handmade ballistic vest built with of lots of salvaged ballistic Kevlar panels.  It's bulkier than a factory made US Army vest, but it is customized for the benefit of an abnormally large mutant who couldn't wear such armors otherwise.  Coated in MOLLE webbing to support modular loadouts for the tacticool mutant.  It could be outfitted with steel plates for further protection."),
    mass = "4500 g",
    volume = "9 L",
    price = "1600 USD",
    survival_price = "10 USD",
    symbol = "[",
    materials = { "nylon", "kevlar_layered" },
    color = "light_gray",
    flags = { "STURDY", "OUTER", "WATER_FRIENDLY", "OVERSIZE", "PREFIX_XL" },
    looks_like = "ballistic_vest_esapi",
    armor = {
        warmth = 15,
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "kevlar_layered", coverage = 95, thickness = 4.4 },
                },
                encumbrance = 8,
                coverage = 100,
                vitals_coverage = 90,
                covers = { "torso" },
                volume_encumbrance = 0.25,
            },
        },
    },
    use_actions = { { kind = "attach_molle", size = 12 }, { kind = "detach_molle" } },
}

ccb.content.define_item {
    id = "xl_ballistic_vest_lc",
    category = "armor",
    name = ccb.content.plural_text("ballistic vest (mild steel plates)", "ballistic vests (mild steel plates)"),
    description = ccb.content.text("An enormous handmade ballistic vest built with lots of salvaged ballistic Kevlar panels and homemade \"ballistic inserts\" made of mild steel.  The thin metal isn't the most protective, but it's probably better than just plain Kevlar."),
    mass = "12500 g",
    volume = "9 L",
    survival_price = "15 USD",
    symbol = "[",
    materials = { "nylon", "kevlar_layered", "lc_steel" },
    color = "light_gray",
    flags = { "STURDY", "OUTER", "WATER_FRIENDLY", "OVERSIZE", "PREFIX_XL" },
    looks_like = "ballistic_vest_esapi",
    armor = {
        warmth = 20,
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "kevlar_layered", coverage = 95, thickness = 4.4 },
                    { id = "lc_steel", coverage = 85, thickness = 1.5 },
                },
                encumbrance = 14,
                coverage = 100,
                vitals_coverage = 95,
                covers = { "torso" },
                volume_encumbrance = 0.25,
            },
        },
    },
    use_actions = { { kind = "attach_molle", size = 12 }, { kind = "detach_molle" } },
}

ccb.content.define_item {
    id = "xl_ballistic_vest_qt",
    category = "armor",
    name = ccb.content.plural_text("ballistic vest (tempered steel plates)", "ballistic vests (tempered steel plates)"),
    description = ccb.content.text("An enormous handmade ballistic vest made of lots of salvaged ballistic Kevlar panels and ten NIJ IIIA plates inserted into custom-made pockets - four each for your front and back and one each for your sides.  Monstrously heavy but extremely protective."),
    mass = "18000 g",
    volume = "9 L",
    price = "1600 USD",
    survival_price = "30 USD",
    symbol = "[",
    materials = { "nylon", "kevlar_layered", "qt_steel" },
    color = "light_gray",
    flags = { "STURDY", "OUTER", "WATER_FRIENDLY", "OVERSIZE", "PREFIX_XL" },
    looks_like = "ballistic_vest_esapi",
    armor = {
        warmth = 20,
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "kevlar_layered", coverage = 95, thickness = 4.4 },
                    { id = "qt_steel", coverage = 90, thickness = 2.5 },
                },
                encumbrance = 20,
                coverage = 100,
                vitals_coverage = 95,
                covers = { "torso" },
                volume_encumbrance = 0.25,
            },
        },
    },
    use_actions = { { kind = "attach_molle", size = 12 }, { kind = "detach_molle" } },
}

-- Density test expects 1.275, so volume derived from this
ccb.content.define_item {
    id = "iotv_shoulder_plate",
    category = "armor",
    name = ccb.content.plural_text("ballistic shoulder protectors (pair)", "ballistic shoulder protectors (pair)"),
    description = ccb.content.text("Nylon armor with soft armor inserts protecting the deltoid and upper arm.  Designed to be attached to heavy military body armor."),
    mass = "1034 g",
    volume = "812 ml",
    price = "600 USD",
    survival_price = "1 USD",
    symbol = ",",
    materials = { "kevlar_layered", "nylon" },
    color = "dark_gray",
    flags = { "STURDY", "OUTER", "WATER_FRIENDLY", "CANT_WEAR" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "kevlar_layered", coverage = 100, thickness = 4.4 },
                },
                encumbrance = 3,
                coverage = 80,
                ranged_coverage = 95,
                vitals_coverage = 100,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_shoulder_r", "arm_upper_l", "arm_upper_r" },
                volume_encumbrance = 0,
            },
        },
    },
}

-- 33cm x 22cm x 5.4mm
ccb.content.define_item {
    id = "iotv_groin_plate",
    category = "armor",
    name = ccb.content.text("ballistic groin protector"),
    description = ccb.content.text("Front and back nylon armor with soft armor inserts for groin and butt protection.  Designed to be attached to heavy military body armor."),
    mass = "417 g",
    volume = "392 ml",
    price = "600 USD",
    survival_price = "1 USD",
    symbol = ",",
    materials = { "kevlar_layered", "nylon" },
    color = "dark_gray",
    flags = { "STURDY", "OUTER", "WATER_FRIENDLY", "CANT_WEAR" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "kevlar_layered", coverage = 100, thickness = 4.4 },
                },
                encumbrance = 2,
                coverage = 75,
                vitals_coverage = 100,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
                volume_encumbrance = 0,
            },
        },
    },
}

ccb.content.define_item {
    id = "iotv_neck_plate",
    category = "armor",
    name = ccb.content.text("ballistic collar"),
    description = ccb.content.text("Front and back nylon collar assemblies with soft armor inserts for neck protection.  Designed to be attached to heavy military body armor."),
    mass = "621 g",
    volume = "488 ml",
    price = "600 USD",
    survival_price = "1 USD",
    symbol = ",",
    materials = { "kevlar_layered", "nylon" },
    color = "dark_gray",
    flags = { "STURDY", "OUTER", "WATER_FRIENDLY", "CANT_WEAR" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "kevlar_layered", coverage = 100, thickness = 4.4 },
                },
                encumbrance = 0,
                coverage = 90,
                covers = { "head" },
                subparts = { "head_throat", "head_nape" },
                volume_encumbrance = 0,
            },
        },
    },
}

ccb.content.define_item {
    id = "lead_plate_xedra_mark",
    category = "armor",
    name = ccb.content.text("lead plate"),
    description = ccb.content.text("An lead plate like those found in most medical x-ray protection vests, affixed to a steel backing plate.  This is clearly intended to be inserted into the pocket of a protective vest, and can't be worn on its own."),
    mass = "10545 g",
    volume = "1110 ml",
    length = "46 cm",
    price = "400 USD",
    survival_price = "1 USD",
    materials = { "lead", "qt_steel" },
    symbol = ",",
    color = "dark_gray",
    flags = { "ABLATIVE_LARGE", "CANT_WEAR", "STURDY" },
    armor = {
        thickness = 1,
        portions = {
            {
                encumbrance = 6,
                coverage = 45,
                covers = { "torso" },
                subparts = { "torso_upper", "torso_lower" },
            },
        },
    },
}
