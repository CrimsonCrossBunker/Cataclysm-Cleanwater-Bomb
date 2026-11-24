local ccb = require("ccb")

-- sci-fantasy extradimensional gadget = pricey
-- because nobody would have that amount after the world ends, it's worth $1000 in barter
ccb.content.define_item {
    id = "afs_bag_of_holding",
    name = ccb.content.plural_text("bag of holding", "bags of holding"),
    description = ccb.content.text("A sleek, unfathomably-complicated machine covered in dozens of blinking lights, worn on the back by sturdy faux-leather straps.  An electrode dangles from the back, attaching to your forehead.  How it operates without annihilating spacetime isn't quite clear, but a localized portal allows things to be stored in an extradimensional space."),
    mass = "3401 g",
    volume = "3 L",
    price = "10000 kUSD",
    survival_price = "1 kUSD",
    materials = { "glass", "superalloy", "platinum" },
    symbol = "[",
    color = "cyan",
    looks_like = "molle_pack",
    pockets = { { kind = "CONTAINER", capacity = "100 L", mass_limit = "500 kg", moves = 300 } },
    flags = { "BELTED", "LEAK_DAM" },
    max_worn = 1,
    armor = {
        warmth = 5,
        thickness = 1,
        portions = { { encumbrance = { 5, 10 }, coverage = 30, covers = { "torso" } } },
    },
}

ccb.content.define_item {
    id = "afs_titanium_vest",
    name = ccb.content.text("titanium vest"),
    description = ccb.content.text("A lightweight armor vest made of pieces of titanium sewn together, with cloth padding for comfort.  Its not particularly effective in a real fight."),
    mass = "939 g",
    volume = "500 ml",
    price = "10 USD",
    accuracy = -3,
    materials = { "titanium", "cotton" },
    symbol = "[",
    looks_like = "armor_scrapsuit",
    color = "white",
    flags = { "STURDY", "OUTER" },
    armor = { thickness = 1, portions = { { encumbrance = 4, coverage = 80, covers = { "torso" } } } },
}

-- Change charges and charge_regen only
ccb.content.define_item {
    id = "afs_holo_cloak_mk2",
    copy_from = "afs_sentinel_cloak",
    name = ccb.content.plural_text("hologram cloak Mk. II", "hologram cloaks Mk. II"),
    description = ccb.content.text("When activated, creates a holographic decoy of its wearer.  Powered by an experimental n-space energy generator, it slowly recharges itself for free, probably by siphoning excess energy from some unknown hyperdimensional space."),
    pockets = { { kind = "MAGAZINE", ammunition = { battery = 15 } } },
    flags = { "OVERSIZE", "HOOD", "WATERPROOF", "STURDY", "OUTER", "NO_UNLOAD", "NO_RELOAD" },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1 },
    armor = {},
    artifact = { charge = { recharge_type = "periodic", interval = "1 h", regenerate_ammo = true } },
    use_actions = { "DIRECTIONAL_HOLOGRAM" },
}

ccb.content.define_item {
    id = "afs_sentinel_cloak",
    copy_from = "jedi_cloak",
    name = ccb.content.plural_text("Sentinel-lx cloak", "Sentinel-lx cloaks"),
    description = ccb.content.text("The vantablack cloak of Sentinel-lx hangs around ones shoulders as a solid, unnatural shadow.  Made from woven graphene, it's lightweight and resistant, but cannot be repaired."),
    price = "15 kUSD",
    materials = { "graphene_weave" },
    symbol = "[",
    color = "dark_gray",
    flags = { "OVERSIZE", "HOOD", "OUTER", "NO_REPAIR", "STURDY", "COSPLAY_COSTUME" },
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 30,
        thickness = 1,
        portions = {
            {
                encumbrance = 4,
                coverage = 85,
                covers = { "torso", "head", "arm_l", "arm_r", "leg_l", "leg_r" },
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_aftershock_exoplanet_afs_sentinel_cloak_0" } },
}

-- generic name and description
ccb.content.define_item {
    id = "afs_wrist_computer",
    category = "armor",
    name = ccb.content.plural_text("IX-2110 computer", "IX-2110 computers"),
    description = ccb.content.text("The original Imagos IX-2110, a general use wrist computer originally designed to support operations within hazardous environments.  Among the most successful pieces of technology ever created, millions of these were produced and sold to the explorers that first tamed the stars during the early Hyperspace Era.  The slow attrition of technological prowess since the Discontinuity has left slightly slower than its modern counterparts."),
    variant_kind = "generic",
    variants = {
        { id = "old" },
        {
            id = "standard",
            name = ccb.content.plural_text("IX-2330S computer", "IX-2330S computers"),
            weight = 0,
            description = ccb.content.text("A rugged and radiation shielded wirst computer specifically designed to support salvage operations.  It can perform general computing tasks and might be used to interface with most ancient computer systems."),
            color = "dark_gray",
        },
    },
    mass = "315 g",
    volume = "1200 ml",
    price = "260 USD",
    accuracy = -1,
    materials = { "steel", "plastic" },
    symbol = "[",
    color = "light_gray",
    flags = { "WATCH", "BELTED", "STURDY", "WATER_FRIENDLY" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_MEDIUM" },
            default_magazine = "medium_battery_cell",
        },
        {
            kind = "E_FILE_STORAGE",
            rigid = true,
            capacity = "1 ml",
            mass_limit = "1 g",
            weight_multiplier = 0.0,
            memory_capacity = "1 TB",
        },
    },
    qualities = { { id = "HACK", level = 1 } },
    subtype_order = { "tool", "armor" },
    tool = { transfer_rate = "45 MB", charges_per_use = 1, ammo_types = { "battery" } },
    armor = {
        sided = true,
        portions = { { encumbrance = 2, coverage = 14, covers = { "arm_l", "arm_r" } } },
        warmth = 10,
        thickness = 2,
    },
    use_actions = {
        "E_FILE_DEVICE",
        "EBOOKSAVE",
        "PORTABLE_GAME",
        { kind = "link_up", cable_length = 5, charge_rate = "140 W" },
    },
}

ccb.content.define_item {
    id = "q_solarpack",
    name = ccb.content.plural_text("quantum solar backpack (folded)", "quantum solar backpacks (folded)"),
    description = ccb.content.text("Personal portable charging system consisting of an array of quantum solar panels neatly folded in the form of a large backpack.  It can be worn as one, and has an integrated cable to plug it into a cable charger system.  Cutting edge technology."),
    mass = "7500 g",
    volume = "5 L",
    price = "15 kUSD",
    accuracy = -1,
    materials = { "glass", "steel" },
    symbol = "[",
    color = "light_gray",
    flags = { "FRAGILE", "BELTED", "OVERSIZE", "SOLARPACK" },
    max_worn = 1,
    melee_damage = { bash = 10 },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = { thickness = 3, portions = { { encumbrance = 12, coverage = 40, covers = { "torso" } } } },
    use_actions = { "SOLARPACK" },
}

ccb.content.define_item {
    id = "xlboots_combat",
    copy_from = "boots_combat",
    mass = "1460 g",
    volume = "5 L",
    survival_price = "140 USD",
    armor = {
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_ankle_r", "foot_ankle_l", "foot_heel_r",
                    "foot_heel_l", "foot_arch_r", "foot_arch_l",
                },
                materials = {
                    { id = "leather", coverage = 100, thickness = 2.5 },
                    { id = "kevlar", coverage = 100, thickness = 2.5 },
                },
                encumbrance = 12,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "leather", coverage = 100, thickness = 0.1 },
                    { id = "rubber", coverage = 100, thickness = 6.0 },
                },
                coverage = 100,
            },
        },
    },
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } } },
}

ccb.content.define_item {
    id = "xlgloves_tactical",
    copy_from = "gloves_tactical",
    mass = "1 kg",
    volume = "750 ml",
    armor = { thickness = 5 },
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } } },
}

ccb.content.define_item {
    id = "tripaw_xlgloves_tactical",
    category = "armor",
    name = ccb.content.plural_text("Killophant gloves (pair)", "Killophant gloves (pair)"),
    description = ccb.content.text("A pair of reinforced Kevlar tactical gloves, specifically designed to accommodate three-fingered Killophants.  Thinner than regular oversized tactical gloves."),
    mass = "320 g",
    volume = "750 ml",
    price = "52 USD",
    materials = { "afs_kevlar" },
    symbol = "[",
    looks_like = "fire_gauntlets",
    color = "dark_gray",
    flags = { "OVERSIZE", "VARSIZE", "STURDY" },
    armor = {
        warmth = 20,
        thickness = 1,
        portions = { { encumbrance = 5, coverage = 100, covers = { "hand_l", "hand_r" } } },
    },
}

ccb.content.define_item {
    id = "xltac_fullhelmet",
    copy_from = "tac_fullhelmet",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25, survival_price = 1.25 },
    },
}

ccb.content.define_item {
    id = "wetsuit_cecalia",
    name = ccb.content.text("Cecaelia wetsuit"),
    description = ccb.content.text("A wetsuit designed for the Octopus Uplifts known as Cecaelia.  This is the explorer suit with no head or tentacle protection."),
    mass = "1320 g",
    volume = "4 L",
    price = "120 USD",
    survival_price = "5 USD",
    accuracy = -3,
    materials = { "neoprene", "cotton" },
    symbol = "[",
    looks_like = "wetsuit",
    color = "light_gray",
    pockets = {
        { kind = "CONTAINER", capacity = "350 ml", mass_limit = "1 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "350 ml", mass_limit = "1 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "250 ml", mass_limit = "1 kg", moves = 100 },
        { kind = "CONTAINER", capacity = "250 ml", mass_limit = "1 kg", moves = 100 },
    },
    flags = { "VARSIZE", "WATER_FRIENDLY", "SKINTIGHT" },
    armor = {
        warmth = 30,
        thickness = 1,
        environmental_protection = 2,
        portions = { { encumbrance = { 2, 5 }, coverage = 90, covers = { "torso", "arm_l", "arm_r" } } },
    },
}

ccb.content.define_item {
    id = "q_solarpack_on",
    copy_from = "q_solarpack",
    name = ccb.content.plural_text("quantum solar backpack (unfolded)", "quantum solar backpacks (unfolded)"),
    description = "Unfolded array of portable quantum solar panels ready to push some power into an active cable charger system.",
    color = "blue",
    volume = "15 L",
    solar_efficiency = 0.3,
    flags = { "FRAGILE", "BELTED", "OVERSIZE", "SOLARPACK_ON" },
    melee_damage = { bash = 4 },
    use_actions = { "SOLARPACK_OFF" },
    tool = {},
    armor = {
        thickness = 1,
        portions = {
            {
                covers = { "torso" },
                coverage = 40,
                encumbrance = 20,
            },
        },
    },
    subtype_order = { "tool", "armor" },
}

ccb.content.define_item {
    id = "combat_wetsuit_cecalia",
    name = ccb.content.plural_text("combat wetsuit", "combat wetsuits"),
    description = ccb.content.text("The combat version of the Cecaelia wetsuit; made of neoprene and Kevlar, it will provide some level of protection for deep dwellers."),
    mass = "1720 g",
    volume = "4 L",
    price = "120 USD",
    survival_price = "5 USD",
    accuracy = -3,
    materials = { "neoprene", "afs_kevlar" },
    symbol = "[",
    looks_like = "wetsuit",
    color = "light_gray",
    pockets = {
        { kind = "CONTAINER", capacity = "350 ml", mass_limit = "1 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "350 ml", mass_limit = "1 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "250 ml", mass_limit = "1 kg", moves = 100 },
        { kind = "CONTAINER", capacity = "250 ml", mass_limit = "1 kg", moves = 100 },
        {
            capacity = "2 L",
            mass_limit = "6 kg",
            max_item_length = "90 cm",
            moves = 40,
            allowed_flags = { "BELT_CLIP" },
            rigid = true,
            holster = true,
            transparent = true,
        },
        {
            kind = "CONTAINER",
            min_item_volume = "2 L",
            capacity = "3 L",
            mass_limit = "30 kg",
            allowed_flags = { "MAG_BULKY" },
            moves = 60,
        },
        {
            kind = "CONTAINER",
            min_item_volume = "2 L",
            capacity = "3 L",
            mass_limit = "30 kg",
            allowed_flags = { "MAG_BULKY" },
            moves = 60,
        },
    },
    flags = { "VARSIZE", "WATER_FRIENDLY", "SKINTIGHT" },
    armor = {
        warmth = 30,
        thickness = 1,
        environmental_protection = 3,
        portions = {
            {
                materials = {
                    { id = "neoprene", coverage = 100, thickness = 1.2 },
                    { id = "kevlar", coverage = 100, thickness = 0.3 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 5,
            },
            {
                materials = {
                    { id = "kevlar", coverage = 100, thickness = 0.3 },
                    { id = "neoprene", coverage = 100, thickness = 0.7 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 2,
            },
        },
    },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Stash ammo"),
            message = ccb.content.text("You stash your %s."),
        },
    },
}

ccb.content.define_item {
    id = "nanomesh_vest",
    category = "armor",
    name = ccb.content.text("nanomesh vest"),
    description = ccb.content.text("A lightweight nanomesh vest designed to face down many of the perils of space travel.  These vests are mass produced and often stacked in starship lockers."),
    mass = "6953 g",
    volume = "1 L",
    price = "160 USD",
    survival_price = "160 USD",
    accuracy = -1,
    materials = { "nanoprinted_alloy" },
    symbol = "[",
    looks_like = "mt_chainmail_vest",
    color = "light_red",
    flags = { "VARSIZE", "OUTER" },
    armor = {
        portions = {
            {
                materials = { { id = "nanoprinted_alloy", coverage = 100, thickness = 1 } },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 12,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_nanomesh_vest",
    copy_from = "nanomesh_vest",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25, survival_price = 1.25 },
    },
}

ccb.content.define_item {
    id = "carbide_cuirass",
    category = "armor",
    looks_like = "cuirass_lightplate",
    name = ccb.content.plural_text("carbide cuirass", "carbide cuirasses"),
    description = ccb.content.text("This piece of armor hearkens back to renaissance designs.  It differs in that it is cast as a single piece in deep space installations where conditions can be controlled absolutely.  Not quite bulletproof, but it will stop most small arms fire."),
    mass = "4200 g",
    volume = "6 L",
    price = "3 kUSD",
    survival_price = "3 kUSD",
    accuracy = -1,
    materials = { "vacuum_carbide" },
    symbol = "[",
    color = "light_gray",
    length = "60 cm",
    flags = { "VARSIZE", "OUTER", "STURDY" },
    armor = {
        warmth = 20,
        thickness = 1,
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
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_carbide_cuirass",
    copy_from = "carbide_cuirass",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25, survival_price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_carbide_cuirass",
    copy_from = "carbide_cuirass",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5, survival_price = 0.5 },
    },
}
