local ccb = require("ccb")

ccb.content.define_item {
    id = "acidic_bore",
    price = "100 USD",
    survival_price = "5 USD",
    name = ccb.content.text("acidic bore"),
    symbol = "=",
    color = "red",
    description = ccb.content.text("This wriggling nodule of resin and flesh appears to be secreting a pungent fluid.  You'd probably best feed it into the bioblaster."),
    materials = { "alien_resin" },
    volume = "250 ml",
    mass = "1 g",
    stack_size = 80,
    ammunition = {
        type = "acidic_bore",
        damage = { type = "stab", amount = 5 },
        dispersion = 100,
        count = 80,
        loudness = 9,
    },
}

-- High quality energy extracted by our advanced forbearers. Gives lasers extra damage and range. Don't think too much about how it works.
ccb.content.define_item {
    id = "afs_shuttle_beacon",
    copy_from = "battery",
    category = "spare_parts",
    name = ccb.content.plural_text("signaling payload", "signaling payload"),
    symbol = "=",
    color = "blue",
    description = ccb.content.text("Single use software package that can be used to send encrypted communications."),
    ammunition = { type = "afs_shuttle_beacon", range_multiplier = 1.5 },
}

ccb.content.define_item {
    id = "xray_laser_barrel",
    price = "100 USD",
    survival_price = "5 USD",
    name = ccb.content.text("x-ray laser barrel"),
    symbol = "=",
    color = "green",
    description = ccb.content.text("Your very own Project Excalibur.  Better get to defending America with it."),
    materials = { "steel" },
    volume = "250 ml",
    mass = "1 g",
    stack_size = 3,
    ammunition = {
        type = "xray_laser_barrel",
        damage = { type = "heat", amount = 20 },
        dispersion = 100,
        count = 1,
        loudness = 9,
    },
}

ccb.content.define_item {
    id = "arrow_nano",
    price = "20 USD",
    name = ccb.content.text("nano printed combat arrow"),
    symbol = "=",
    color = "green",
    looks_like = "arrow_fire_hardened_fletched",
    description = ccb.content.text("Arrows made from nanoprinted materials where each layer of the arrow is designed for improved efficiency.  A layer that provides the least possible air resistance, followed by a layer of armor piercing, then followed by a frangible layer.  However, this makes each arrow single use."),
    materials = { "superalloy" },
    volume = "250 ml",
    survival_price = "100 USD",
    mass = "20 g",
    length = "76 cm",
    stack_size = 10,
    melee_damage = { bash = 1 },
    ammunition = {
        type = "arrow",
        damage = { type = "stab", constant_damage_multiplier = 3.75 },
        range = 6,
        dispersion = 20,
        loudness = 0,
        count = 10,
        critical_multiplier = 13,
    },
}
