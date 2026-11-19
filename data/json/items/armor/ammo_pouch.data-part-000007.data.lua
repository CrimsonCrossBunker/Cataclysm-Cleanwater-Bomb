local ccb = require("ccb")

ccb.content.define_item {
    id = "light_load_bearing_vest",
    name = ccb.content.plural_text("light load bearing vest", "light load bearing vests"),
    description = ccb.content.text("This lightweight harness covered in MOLLE webbing is designed to attach a few pouches, holsters and other PALS compatible accessories.  Preferred by some soldiers over directly attaching accessories to a ballistic vest as they can then be easily separated."),
    mass = "500 g",
    volume = "500 ml",
    looks_like = "vest",
    price = "47 USD",
    survival_price = "20 USD",
    materials = { "nylon" },
    symbol = "[",
    color = "dark_gray",
    flags = { "WATER_FRIENDLY", "BELTED", "STURDY" },
    armor = {
        thickness = 1.5,
        portions = {
            {
                encumbrance = 1,
                coverage = 55,
                covers = { "torso" },
                subparts = { "torso_upper" },
                volume_encumbrance = 0.3,
            },
        },
    },
    use_actions = { { kind = "attach_molle", size = 4 }, { kind = "detach_molle" } },
}

ccb.content.define_item {
    id = "load_bearing_vest",
    name = ccb.content.plural_text("load bearing vest", "load bearing vests"),
    description = ccb.content.text("This vest covered in MOLLE webbing is designed to attach pouches, holsters and other PALS compatible accessories.  Preferred by some soldiers over directly attaching accessories to a ballistic vest as they can then be easily separated."),
    mass = "1250 g",
    volume = "1000 ml",
    looks_like = "vest",
    price = "74 USD",
    survival_price = "30 USD",
    materials = { "nylon" },
    symbol = "[",
    color = "dark_gray",
    flags = { "WATER_FRIENDLY", "BELTED", "STURDY" },
    armor = {
        thickness = 1.5,
        portions = {
            {
                encumbrance = 2,
                coverage = 85,
                covers = { "torso" },
                subparts = { "torso_upper" },
                volume_encumbrance = 0.25,
            },
        },
    },
    use_actions = { { kind = "attach_molle", size = 8 }, { kind = "detach_molle" } },
}

-- volume encumber set high since the whole vest is already scaled. This equals .4 overall
ccb.content.define_item {
    id = "load_bearing_vest_sling",
    copy_from = "load_bearing_vest",
    name = ccb.content.plural_text("load bearing vest with sling", "load bearing vests with slings"),
    description = ccb.content.text("This vest covered in MOLLE webbing is designed to attach pouches, holsters and other PALS compatible accessories.  Preferred by some soldiers over directly attaching accessories to a ballistic vest as they can then be easily separated.  This one has a single point sling wrapped around the shoulders using a system to keep your weapon extra secure."),
    mass = "1500 g",
    pockets = {
        {
            description = ccb.content.text("Rifle sling."),
            kind = "CONTAINER",
            holster = true,
            min_item_volume = "1000 ml",
            capacity = "8 L",
            mass_limit = "8200 g",
            max_item_length = "120 cm",
            volume_encumbrance = 1.6,
            moves = 30,
        },
    },
    armor = {
        portions = {
            {
                encumbrance = 2,
                coverage = 85,
                covers = { "torso" },
                subparts = { "torso_upper", "torso_hanging_front" },
                volume_encumbrance = 0.25,
            },
        },
    },
    use_actions = { { kind = "holster" }, { kind = "attach_molle", size = 8 }, { kind = "detach_molle" } },
}

ccb.content.define_item {
    id = "heavy_load_bearing_vest",
    name = ccb.content.plural_text("heavy load bearing vest", "heavy load bearing vests"),
    description = ccb.content.text("This massive vest covered in MOLLE webbing is designed to attach a large number of pouches, holsters and other PALS compatible accessories.  Preferred by some soldiers over directly attaching accessories to a ballistic vest as they can then be easily separated."),
    mass = "2000 g",
    volume = "1750 ml",
    looks_like = "vest",
    price = "130 USD",
    survival_price = "40 USD",
    materials = { "nylon" },
    symbol = "[",
    color = "dark_gray",
    flags = { "WATER_FRIENDLY", "BELTED", "STURDY" },
    armor = {
        thickness = 1.5,
        portions = {
            {
                encumbrance = 4,
                coverage = 85,
                covers = { "torso" },
                subparts = { "torso_upper", "torso_lower", "torso_waist" },
                volume_encumbrance = 0.2,
            },
        },
    },
    use_actions = { { kind = "attach_molle", size = 14 }, { kind = "detach_molle" } },
}

-- volume encumber set high since the whole vest is already scaled. This equals .4 overall
ccb.content.define_item {
    id = "heavy_load_bearing_vest_sling",
    copy_from = "heavy_load_bearing_vest",
    name = ccb.content.plural_text("heavy load bearing vest with sling", "heavy load bearing vests with slings"),
    description = ccb.content.text("This massive vest covered in MOLLE webbing is designed to attach a large number of pouches, holsters and other PALS compatible accessories.  Preferred by some soldiers over directly attaching accessories to a ballistic vest as they can then be easily separated.  This one has a single point sling wrapped around the shoulders using a system to keep your weapon extra secure."),
    mass = "2300 g",
    pockets = {
        {
            description = ccb.content.text("Rifle sling."),
            kind = "CONTAINER",
            holster = true,
            min_item_volume = "1000 ml",
            capacity = "8 L",
            mass_limit = "8200 g",
            max_item_length = "120 cm",
            volume_encumbrance = 2,
            moves = 30,
        },
    },
    armor = {
        portions = {
            {
                encumbrance = 4,
                coverage = 85,
                covers = { "torso" },
                subparts = { "torso_upper", "torso_lower", "torso_hanging_front", "torso_waist" },
                volume_encumbrance = 0.2,
            },
        },
    },
    use_actions = { { kind = "holster" }, { kind = "attach_molle", size = 14 }, { kind = "detach_molle" } },
}

-- volume encumber set high since the whole vest is already scaled. This equals .4 overall
-- volume encumber set high since the whole vest is already scaled. This equals .4 overall
ccb.content.define_item {
    id = "heavy_load_bearing_vest_breacher",
    copy_from = "heavy_load_bearing_vest",
    name = ccb.content.plural_text("breacher load bearing vest", "breacher load bearing vests"),
    description = ccb.content.text("This massive vest covered in MOLLE webbing is designed to attach a large number of pouches, holsters and other PALS compatible accessories.  This one has a single point sling wrapped around the shoulders using a system to keep your weapon extra secure, as well as a set of strong magnets attached to the torso and waist to hold an extra medium-sized firearm - normally a short-barrel shotgun for breaching."),
    mass = "2900 g",
    pockets = {
        {
            description = ccb.content.text("Rifle sling."),
            kind = "CONTAINER",
            holster = true,
            min_item_volume = "1000 ml",
            capacity = "8 L",
            mass_limit = "8200 g",
            max_item_length = "120 cm",
            volume_encumbrance = 2,
            moves = 30,
        },
        {
            description = ccb.content.text("Breaching shotgun magnets."),
            kind = "CONTAINER",
            holster = true,
            min_item_volume = "1 L",
            capacity = "4 L",
            mass_limit = "8200 g",
            min_item_length = "45 cm",
            max_item_length = "80 cm",
            volume_encumbrance = 2,
            moves = 60,
        },
    },
    armor = {
        portions = {
            {
                encumbrance = 4,
                coverage = 85,
                covers = { "torso" },
                subparts = { "torso_upper", "torso_lower", "torso_hanging_front", "torso_waist" },
                volume_encumbrance = 0.2,
            },
        },
    },
    use_actions = { { kind = "holster" }, { kind = "attach_molle", size = 8 }, { kind = "detach_molle" } },
}
