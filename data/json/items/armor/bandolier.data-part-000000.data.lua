local ccb = require("ccb")

ccb.content.define_item {
    id = "bandolier_pistol",
    name = ccb.content.text("pistol bandolier"),
    description = ccb.content.text("An embroidered leather bandolier for keeping pistol cartridges close to hand.  If this doesn't make you feel like a cowboy, nothing will."),
    mass = "140 g",
    volume = "250 ml",
    price = "19 USD",
    survival_price = "15 USD",
    materials = { "leather" },
    symbol = "[",
    looks_like = "leather_belt",
    color = "dark_gray",
    pockets = {
        {
            ammunition = {
                ["32"] = 18,
                ["762x25"] = 18,
                ["38"] = 18,
                ["357mag"] = 18,
                ["357sig"] = 18,
                ["380"] = 18,
                ["38super"] = 18,
                ["40"] = 18,
                ["10mm"] = 18,
                ["44"] = 18,
                ["45"] = 18,
                ["45colt"] = 18,
                ["57"] = 18,
                ["9x18"] = 18,
                ["9mm"] = 18,
                ["454"] = 18,
                ["500"] = 18,
            },
            moves = 20,
            volume_encumbrance = 0.3,
        },
    },
    flags = { "WATER_FRIENDLY", "BELTED", "OVERSIZE", "PALS_SMALL" },
    armor = {
        thickness = 1,
        portions = { { encumbrance = 1, coverage = 10, covers = { "torso" }, subparts = { "torso_upper" } } },
    },
}

ccb.content.define_item {
    id = "bandolier_rifle",
    name = ccb.content.text("rifle bandolier"),
    description = ccb.content.text("A leather bandolier for keeping rifle cartridges close to hand."),
    mass = "140 g",
    volume = "250 ml",
    price = "19 USD",
    survival_price = "15 USD",
    materials = { "leather" },
    symbol = "[",
    looks_like = "leather_belt",
    color = "dark_gray",
    pockets = {
        {
            ammunition = {
                ["22"] = 16,
                ["223"] = 16,
                ["270win"] = 16,
                ["300blk"] = 16,
                ["545x39"] = 16,
                ["3006"] = 16,
                ["123ln"] = 16,
                ["303"] = 16,
                ["77mm_arisaka"] = 16,
                ["308"] = 16,
                ["300"] = 16,
                ["762"] = 16,
                ["762R"] = 16,
                ["8x40mm"] = 16,
                ["4570"] = 16,
                ["50beowulf"] = 16,
                ["450"] = 16,
                ["338lapua"] = 16,
                ["50"] = 16,
                ["458wm"] = 16,
            },
            moves = 20,
            volume_encumbrance = 0.3,
        },
    },
    flags = { "WATER_FRIENDLY", "BELTED", "OVERSIZE", "PALS_MEDIUM" },
    armor = {
        thickness = 1,
        portions = { { encumbrance = 1, coverage = 10, covers = { "torso" }, subparts = { "torso_upper" } } },
    },
}

ccb.content.define_item {
    id = "bandolier_shotgun",
    name = ccb.content.text("waist shotgun bandolier"),
    description = ccb.content.text("A leather bandolier worn around the waist for keeping shotgun shells close to hand."),
    mass = "140 g",
    volume = "500 ml",
    price = "19 USD",
    survival_price = "15 USD",
    materials = { "leather" },
    symbol = "[",
    looks_like = "leather_belt",
    color = "dark_gray",
    pockets = {
        {
            ammunition = { ["410shot"] = 25, shot = 25, signal_flare = 25 },
            moves = 25,
            volume_encumbrance = 0.3,
        },
    },
    flags = { "WATER_FRIENDLY", "BELTED", "OVERSIZE" },
    armor = {
        thickness = 1,
        portions = { { encumbrance = 2, coverage = 100, covers = { "torso" }, subparts = { "torso_waist" } } },
    },
}

-- It's very much similar to the torso shotgun bandolier I'm patterning this off of, so I'm keeping the data the same.
-- The image I found when I went looking showed Arnie carrying six grenades in a bandolier.
ccb.content.define_item {
    id = "torso_bandolier_grenade",
    copy_from = "bandolier_shotgun",
    name = ccb.content.text("torso grenade bandolier"),
    description = ccb.content.text("A leather bandolier strapped around the torso for keeping 40mm grenades close to hand.  For some reason, wearing this makes you feel Austrian."),
    pockets = { { ammunition = { ["40x46mm"] = 6, ["40x53mm"] = 6 }, moves = 20, volume_encumbrance = 0.3 } },
    flags = { "WATER_FRIENDLY", "BELTED", "OVERSIZE" },
    armor = {},
}

ccb.content.define_item {
    id = "torso_bandolier_shotgun",
    name = ccb.content.text("torso shotgun bandolier"),
    description = ccb.content.text("A leather bandolier strapped around the torso for keeping shotgun shells close to hand."),
    mass = "200 g",
    volume = "1 L",
    price = "39 USD",
    survival_price = "25 USD",
    materials = { "leather" },
    symbol = "[",
    looks_like = "leather_belt",
    color = "dark_gray",
    pockets = {
        {
            ammunition = { ["410shot"] = 50, shot = 50, signal_flare = 50 },
            moves = 35,
            volume_encumbrance = 0.3,
        },
    },
    flags = { "WATER_FRIENDLY", "OVERSIZE", "BELTED" },
    armor = {
        thickness = 1,
        portions = { { encumbrance = 3, coverage = 20, covers = { "torso" }, subparts = { "torso_upper" } } },
    },
}

ccb.content.define_item {
    id = "flintlock_pouch",
    name = ccb.content.plural_text("paper cartridge pouch", "paper cartridge pouches"),
    description = ccb.content.text("A covered leather pouch, worn at the waist to store and protect prepared blackpowder cartridges."),
    mass = "160 g",
    volume = "500 ml",
    price = "49 USD",
    survival_price = "10 USD",
    materials = { "leather" },
    symbol = "[",
    looks_like = "ammo_pouch",
    color = "dark_gray",
    pockets = {
        {
            ammunition = { flintlock = 14, ["36paper"] = 14, ["44paper"] = 14, blunderbuss = 14 },
            moves = 20,
            volume_encumbrance = 0.3,
        },
    },
    flags = { "WATER_FRIENDLY", "BELTED", "PALS_LARGE", "OVERSIZE" },
    armor = {
        thickness = 1,
        portions = { { encumbrance = 2, coverage = 100, covers = { "torso" }, subparts = { "torso_waist" } } },
    },
}

ccb.content.define_item {
    id = "bandolier_wrist",
    name = ccb.content.text("wrist bandolier"),
    description = ccb.content.text("A small fabric bandolier for rifle cartridges, designed to be worn around the wrist."),
    mass = "30 g",
    volume = "250 ml",
    price = "29 USD",
    survival_price = "5 USD",
    materials = { "canvas" },
    symbol = "[",
    looks_like = "leather_belt",
    color = "dark_gray",
    pockets = {
        {
            ammunition = {
                ["22"] = 4,
                ["223"] = 4,
                ["270win"] = 4,
                ["300blk"] = 4,
                ["545x39"] = 4,
                ["3006"] = 4,
                ["303"] = 4,
                ["77mm_arisaka"] = 4,
                ["308"] = 4,
                ["300"] = 4,
                ["762"] = 4,
                ["762R"] = 4,
                ["8x40mm"] = 4,
                ["4570"] = 4,
                ["50beowulf"] = 4,
                ["450"] = 4,
                ["338lapua"] = 4,
                ["50"] = 4,
                ["458wm"] = 4,
            },
            moves = 20,
            volume_encumbrance = 0.3,
        },
    },
    flags = { "WATER_FRIENDLY", "BELTED", "PALS_SMALL", "ALLOWS_NATURAL_ATTACKS" },
    armor = {
        sided = true,
        thickness = 1,
        portions = { { encumbrance = 1, coverage = 5, covers = { "hand_l", "hand_r" } } },
    },
}

ccb.content.define_item {
    id = "grenade_pouch",
    name = ccb.content.plural_text("grenade pouch", "grenade pouches"),
    description = ccb.content.text("A small pouch for storing cartridge grenades, with straps for attaching it to your belt or other webbing."),
    mass = "90 g",
    volume = "250 ml",
    price = "59 USD",
    survival_price = "7 USD 50 cent",
    materials = { "nylon", "plastic" },
    symbol = "[",
    looks_like = "ammo_satchel",
    color = "dark_gray",
    pockets = { { ammunition = { ["40x46mm"] = 4, ["40x53mm"] = 4 }, moves = 20, volume_encumbrance = 0.3 } },
    flags = { "WATER_FRIENDLY", "BELTED", "OVERSIZE", "PALS_MEDIUM" },
    armor = {
        sided = true,
        thickness = 1,
        portions = {
            {
                encumbrance = 4,
                coverage = 25,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_r", "leg_upper_l" },
            },
        },
    },
}

ccb.content.define_item {
    id = "stone_pouch",
    name = ccb.content.plural_text("stone pouch", "stone pouches"),
    description = ccb.content.text("A medium-sized pouch for storing rocks, with straps for attaching it to your belt or other webbing."),
    mass = "180 g",
    volume = "500 ml",
    price = "59 USD",
    survival_price = "7 USD 50 cent",
    materials = { "cotton", "leather" },
    symbol = "[",
    looks_like = "ammo_satchel",
    color = "dark_gray",
    pockets = { { ammunition = { rock = 10, pebble = 80 }, moves = 20, volume_encumbrance = 0.3 } },
    flags = { "WATER_FRIENDLY", "BELTED", "OVERSIZE", "PALS_LARGE" },
    armor = {
        sided = true,
        thickness = 1,
        portions = {
            {
                encumbrance = 4,
                coverage = 25,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_r", "leg_upper_l" },
            },
        },
    },
}

ccb.content.define_item {
    id = "leather_stone_pouch",
    name = ccb.content.plural_text("leather stone pouch", "leather stone pouches"),
    description = ccb.content.text("A medium-sized pouch for storing rocks, made of heavy leather, with straps for attaching it to your belt or other webbing."),
    mass = "380 g",
    volume = "500 ml",
    price = "59 USD",
    survival_price = "7 USD 50 cent",
    materials = { "leather" },
    symbol = "[",
    looks_like = "ammo_satchel",
    color = "dark_gray",
    pockets = { { ammunition = { rock = 10, pebble = 80 }, moves = 20, volume_encumbrance = 0.3 } },
    flags = { "WATER_FRIENDLY", "BELTED", "OVERSIZE", "PALS_LARGE" },
    armor = {
        sided = true,
        thickness = 1,
        portions = {
            {
                encumbrance = 4,
                coverage = 25,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_r", "leg_upper_l" },
            },
        },
    },
}
