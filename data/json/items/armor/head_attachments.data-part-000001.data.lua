local ccb = require("ccb")

ccb.content.define_item {
    id = "ballistic_mandible_guard",
    category = "armor",
    name = ccb.content.plural_text("ballistic mandible guard", "ballistic mandible guard"),
    description = ccb.content.text("A ballistic jaw guard designed to be attached on a military helmet, but easily adjustable to helmets with any kind of rail system installed."),
    mass = "250 g",
    volume = "250 ml",
    price = "60 USD",
    survival_price = "2 USD 50 cent",
    materials = { "thermo_resin" },
    symbol = "[",
    color = "dark_gray",
    flags = { "HELMET_MANDIBLE_GUARD", "CANT_WEAR" },
    armor = { thickness = 1, portions = { { encumbrance = 12, coverage = 100, covers = { "mouth" } } } },
}

ccb.content.define_item {
    id = "plastic_mandible_guard",
    category = "armor",
    name = ccb.content.plural_text("plastic mandible guard", "plastic mandible guard"),
    description = ccb.content.text("A plastic jaw guard designed to be strapped to any common hard hat or helmet, it was probably part of some costume before the world ended."),
    mass = "250 g",
    volume = "200 ml",
    price = "40 USD",
    survival_price = "50 cent",
    materials = { "plastic" },
    symbol = "[",
    color = "light_blue",
    flags = { "HELMET_MANDIBLE_GUARD_STRAPPED", "CANT_WEAR" },
    armor = { thickness = 1, portions = { { encumbrance = 10, coverage = 95, covers = { "mouth" } } } },
}

ccb.content.define_item {
    id = "plastic_chin_guard",
    category = "armor",
    name = ccb.content.plural_text("plastic chin guard", "plastic chin guard"),
    description = ccb.content.text("A common plastic chin guard designed to be attached to the straps of any common hard hat or helmet."),
    mass = "5 g",
    volume = "10 ml",
    price = "1 USD",
    survival_price = "1 cent",
    materials = { "plastic" },
    symbol = "[",
    color = "light_gray",
    flags = { "HELMET_MANDIBLE_GUARD_STRAPPED", "CANT_WEAR" },
    armor = {
        thickness = 0.1,
        portions = { { coverage = 60, covers = { "mouth" }, subparts = { "mouth_chin" } } },
    },
}

ccb.content.define_item {
    id = "counterweight_pouch",
    category = "armor",
    name = ccb.content.plural_text("counterweight pouch", "counterweight pouch"),
    description = ccb.content.text("A counterweight pouch attachable to the back of a hard hat or helmet to balance the weight on your head.  You can store batteries or some other very small items in it."),
    mass = "150 g",
    volume = "150 ml",
    price = "4 USD",
    survival_price = "10 cent",
    materials = { "nylon" },
    symbol = "[",
    color = "green",
    flags = { "HELMET_BACK_POUCH", "CANT_WEAR" },
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "250 ml",
            mass_limit = "250 g",
            max_item_length = "4 cm",
            moves = 250,
        },
    },
    armor = {
        thickness = 0.1,
        portions = { { encumbrance_modifiers = { "NONE" }, coverage = 10, covers = { "head" } } },
    },
}

ccb.content.define_item {
    id = "sun_shield",
    category = "armor",
    name = ccb.content.text("sun shield"),
    description = ccb.content.text("A common sun shield intended to be put over a hard hat to protect the user from the sun."),
    mass = "98 g",
    volume = "250 ml",
    price = "2 USD",
    survival_price = "10 cent",
    materials = { "plastic" },
    symbol = "[",
    color = "light_gray",
    flags = { "CANT_WEAR" },
    armor = {},
}

ccb.content.define_item {
    id = "shield_visor",
    category = "armor",
    name = ccb.content.text("shield visor"),
    description = ccb.content.text("A common shield visor intended to be attached on a hard hat or helmet."),
    mass = "40 g",
    volume = "150 ml",
    price = "6 USD",
    survival_price = "50 cent",
    materials = { "plastic" },
    symbol = "[",
    color = "light_blue",
    flags = { "HELMET_FACE_SHIELD", "CANT_WEAR" },
    armor = { thickness = 1, portions = { { encumbrance = 2, coverage = 90, covers = { "eyes" } } } },
}

ccb.content.define_item {
    id = "face_shield",
    category = "armor",
    name = ccb.content.text("face shield"),
    description = ccb.content.text("A thermoplastic face shield with a mounting bracket intended to be attached over a hard hat or helmet."),
    mass = "170 g",
    volume = "250 ml",
    price = "8 USD",
    survival_price = "1 USD",
    materials = { "thermo_resin" },
    symbol = "[",
    color = "light_blue",
    flags = { "HELMET_FACE_SHIELD", "CANT_WEAR", "OUTER" },
    armor = {
        thickness = 1.5,
        portions = { { encumbrance = 4, coverage = 100, covers = { "eyes", "mouth" } } },
    },
}

ccb.content.define_item {
    id = "face_shield_eod",
    category = "armor",
    name = ccb.content.text("EOD face shield"),
    description = ccb.content.text("A thick polycarbonate and plexiglass face shield with a mounting bracket intended to be attached to a ballistic helmet for protection from blast and fragmentation in 'non-permissive environments'."),
    mass = "229 g",
    volume = "250 ml",
    price = "836 USD",
    survival_price = "24 USD",
    materials = { "thermo_resin" },
    symbol = "[",
    color = "light_gray",
    flags = { "HELMET_FACE_SHIELD", "CANT_WEAR", "OUTER" },
    armor = {
        thickness = 4.5,
        portions = { { encumbrance = 14, coverage = 100, covers = { "eyes", "mouth" } } },
    },
}

ccb.content.define_item {
    id = "face_shield_plastic",
    category = "armor",
    name = ccb.content.text("plastic face shield"),
    description = ccb.content.text("A plastic face shield with a mounting bracket intended to be attached over a hard hat or helmet.  It doesn't protects you as much as one made from thermoplastic, but it's cheaper and more common."),
    mass = "120 g",
    volume = "250 ml",
    price = "6 USD 50 cent",
    survival_price = "50 cent",
    materials = { "plastic" },
    symbol = "[",
    color = "light_blue",
    flags = { "HELMET_FACE_SHIELD", "CANT_WEAR", "OUTER" },
    armor = {
        thickness = 1,
        portions = { { encumbrance = 4, coverage = 100, covers = { "eyes", "mouth" } } },
    },
}
