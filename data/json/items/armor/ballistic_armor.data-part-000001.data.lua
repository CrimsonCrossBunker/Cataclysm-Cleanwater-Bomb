local ccb = require("ccb")

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
