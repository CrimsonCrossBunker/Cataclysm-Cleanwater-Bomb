local ccb = require("ccb")

--  stats taken from: https://condoroutdoor.com/ma11.html
-- Dimensions: 10.5x6.75x4 inches.
ccb.content.define_item {
    id = "gas_mask_pouch",
    looks_like = "holster",
    name = ccb.content.plural_text("gas mask pouch", "gas mask pouches"),
    description = ccb.content.text("A large pouch capable of holding a gas mask and an additional filter, keeping both accessible and secure.  Has MOLLE straps for attaching to a belt or vest."),
    mass = "300 g",
    volume = "250 ml",
    price = "19 USD 95 cent",
    survival_price = "1 USD 90 cent",
    materials = { "nylon" },
    symbol = "[",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "3546 ml",
            mass_limit = "3 kg",
            max_item_length = "27 cm",
            description = ccb.content.text("The main compartment for a respirator."),
            moves = 80,
            volume_encumbrance = 0.3,
        },
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "950 ml",
            mass_limit = "500 g",
            max_item_length = "12 cm",
            description = ccb.content.text("A side pocket for a single spare filter."),
            moves = 80,
            volume_encumbrance = 0.3,
        },
        {
            kind = "CONTAINER",
            capacity = "150 ml",
            mass_limit = "250 g",
            max_item_length = "17 cm",
            description = ccb.content.text("An internal divider pocket for some small accessories."),
            moves = 80,
            volume_encumbrance = 0,
        },
    },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY", "PALS_MEDIUM" },
    armor = {
        sided = true,
        portions = {
            {
                materials = { { id = "nylon", coverage = 100, thickness = 1.0 } },
                encumbrance = { 3, 4 },
                coverage = 25,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_r", "leg_hip_l" },
            },
        },
        thickness = 0.5,
    },
}

ccb.content.define_item {
    id = "modular_papr_strap",
    looks_like = "holster",
    name = ccb.content.text("modular PAPR strap"),
    description = ccb.content.text("A patch of velcro and MOLLE straps for attaching a modular PAPR blower to a compatible MOLLE unit.  It can also be strapped to the hip."),
    mass = "300 g",
    volume = "300 ml",
    price = "19 USD 95 cent",
    survival_price = "1 USD 90 cent",
    materials = { "nylon" },
    symbol = "[",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            allowed_items = { "molle_papr_blower_off", "molle_papr_blower_on" },
            capacity = "4000 ml",
            mass_limit = "2 kg",
            max_item_length = "16 cm",
            description = ccb.content.text("A MOLLE harness for a modular PAPR blower."),
            moves = 300,
            volume_encumbrance = 0.3,
        },
    },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY", "PALS_LARGE" },
    armor = {
        sided = true,
        portions = {
            {
                materials = { { id = "nylon", coverage = 100, thickness = 1.0 } },
                encumbrance = { 3, 4 },
                coverage = 25,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_r", "leg_hip_l" },
            },
        },
        thickness = 0.5,
    },
}

--  stats taken from: https://www.tacticalassaultgearstore.com/molle-frag-grenade-pouch.html
ccb.content.define_item {
    id = "tactical_grenade_pouch",
    name = ccb.content.plural_text("tactical grenade pouch", "tactical grenade pouches"),
    description = ccb.content.text("A pouch designed to hold one military grenade, keeping it both accessible and secure.  Has MOLLE straps for attaching to a belt or vest."),
    mass = "200 g",
    volume = "100 ml",
    price = "20 USD",
    survival_price = "2 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "holster",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "750 ml",
            mass_limit = "2 kg",
            moves = 30,
            allowed_flags = { "GRENADE" },
            volume_encumbrance = 0.3,
        },
    },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY", "PALS_SMALL" },
    armor = {
        thickness = 0.5,
        portions = { { encumbrance = 1, coverage = 100, covers = { "torso" }, subparts = { "torso_waist" } } },
    },
}

--  stats taken from: https://www.patriotoutfitters.com/condor-triple-stacker-open-top-m4-mag-pouch?PMSRCH=MOLLE%20GEAR
ccb.content.define_item {
    id = "triple_stacker_pouch",
    name = ccb.content.plural_text("triple stacker ammo pouch", "triple stacker ammo pouches"),
    description = ccb.content.text("A collection of 6 pockets, 3 wide and 2 deep, designed to hold rifle magazines and keep them accessible and secure.  Has MOLLE straps for attaching to a vest or can be strapped directly to your chest."),
    mass = "500 g",
    volume = "500 ml",
    price = "20 USD",
    survival_price = "6 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "holster",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            max_item_length = "200 mm",
            capacity = "300 ml",
            mass_limit = "2 kg",
            moves = 40,
            allowed_flags = { "MAG_COMPACT" },
            volume_encumbrance = 0.3,
        },
        {
            kind = "CONTAINER",
            max_item_length = "200 mm",
            capacity = "300 ml",
            mass_limit = "2 kg",
            moves = 40,
            allowed_flags = { "MAG_COMPACT" },
            volume_encumbrance = 0.3,
        },
        {
            kind = "CONTAINER",
            max_item_length = "200 mm",
            capacity = "300 ml",
            mass_limit = "2 kg",
            moves = 40,
            allowed_flags = { "MAG_COMPACT" },
            volume_encumbrance = 0.3,
        },
        {
            kind = "CONTAINER",
            max_item_length = "240 mm",
            capacity = "400 ml",
            mass_limit = "2 kg",
            moves = 40,
            allowed_flags = { "MAG_COMPACT" },
            volume_encumbrance = 0.3,
        },
        {
            kind = "CONTAINER",
            max_item_length = "240 mm",
            capacity = "400 ml",
            mass_limit = "2 kg",
            moves = 40,
            allowed_flags = { "MAG_COMPACT" },
            volume_encumbrance = 0.3,
        },
        {
            kind = "CONTAINER",
            max_item_length = "240 mm",
            capacity = "400 ml",
            mass_limit = "2 kg",
            moves = 40,
            allowed_flags = { "MAG_COMPACT" },
            volume_encumbrance = 0.3,
        },
    },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY", "PALS_LARGE" },
    armor = {
        thickness = 0.5,
        portions = { { encumbrance = 2, coverage = 10, covers = { "torso" }, subparts = { "torso_upper" } } },
    },
}

--  stats taken from: https://condoroutdoor.com/ma12-shotgun-ammo-pouch.html
ccb.content.define_item {
    id = "tactical_shotshell_pouch",
    name = ccb.content.plural_text("tactical shotshell pouch", "tactical shotshell pouches"),
    description = ccb.content.text("A pouch designed to hold shotgun shells or .308 rounds, keeping them accessible and secure.  Has MOLLE straps for attaching to a belt or vest."),
    mass = "300 g",
    volume = "250 ml",
    price = "20 USD",
    survival_price = "4 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "holster",
    color = "dark_gray",
    pockets = {
        {
            ammunition = { ["410shot"] = 12, shot = 12, signal_flare = 12, ["308"] = 20 },
            moves = 30,
        },
    },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY", "PALS_MEDIUM" },
    armor = {
        thickness = 0.5,
        portions = { { encumbrance = 2, coverage = 100, covers = { "torso" }, subparts = { "torso_waist" } } },
    },
}

-- encumbrance handled above
ccb.content.define_item {
    id = "xlkevlar",
    category = "armor",
    name = ccb.content.text("Kevlar vest"),
    description = ccb.content.text("A massive handmade imitation of a proper ballistic vest for abnormally large folks.  Large and heavy, but will still fit under an abnormally large coat."),
    mass = "4210 g",
    volume = "8 L",
    survival_price = "25 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "neutral" },
    materials = { "kevlar_layered", "nylon" },
    symbol = "[",
    looks_like = "kevlar",
    color = "light_gray",
    flags = { "STURDY", "OVERSIZE", "PREFIX_XL" },
    melee_damage = { bash = 4 },
    armor = {
        warmth = 20,
        thickness = 5,
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "kevlar_layered", coverage = 95, thickness = 4.4 },
                },
                encumbrance = 6,
                coverage = 98,
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
                coverage = 92,
                vitals_coverage = 60,
                covers = { "torso" },
                subparts = { "torso_lower" },
            },
        },
    },
}
