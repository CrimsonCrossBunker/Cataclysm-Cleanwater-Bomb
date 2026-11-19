local ccb = require("ccb")

ccb.content.define_item {
    id = "plasma",
    copy_from = "plasma",
    name = ccb.content.text("solid hydrogen canister"),
    description = ccb.content.text("A canister of pressurized hydrogen so heavily compressed it has turned solid.  With proper equipment, it could be heated into plasma."),
    ammunition = { type = "plasma", damage = { type = "fcl_plasma", amount = 35, penetration = 14 } },
}

ccb.content.define_item {
    id = "fcl_fusion_pellet",
    name = ccb.content.text("fusion pellet"),
    symbol = "=",
    color = "light_green",
    description = ccb.content.text("A millimeter-scale fusion target pellet. The core contains compressed, frozen fusion material, encased in a stabilizing shell of energetic nanocompound. When subjected to high-voltage discharge, the nanocompound lattice implodes, producing an effect analogous to intense electromagnetic compression and laser ignition, it undergoes micro-inertial confinement fusion."),
    materials = { "steel", "superalloy" },
    mass = "5 g",
    volume = "5 ml",
    price = "8 kUSD",
    survival_price = "50 USD",
    flags = { "LEAK_DAM", "RADIOACTIVE", "UNRECOVERABLE" },
    ammunition = { type = "fcl_fusion_pellet", range = 0, count = 50, effects = { "NEVER_MISFIRES" } },
}

ccb.content.define_item {
    id = "fcl_fusion_pack",
    looks_like = "light_battery_cell",
    name = ccb.content.text("fusion pack"),
    description = ccb.content.text("A specialized, high-density magazine designed to hold and align micro-fusion target pellets. It contains the necessary capacitive contacts and magnetic shielding to safely transfer the rifle's high-voltage discharge to the pellets without premature detonation."),
    mass = "50 g",
    volume = "250 ml",
    price = "500 USD",
    survival_price = "10 USD",
    materials = { "steel", "superalloy" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { fcl_fusion_pellet = 3 } } },
    magazine = { ammunition = { "fcl_fusion_pellet" }, capacity = 3, reload_time = 600 },
}

ccb.content.define_item {
    id = "fcl_fusion_10_mag",
    looks_like = "stanag30",
    name = ccb.content.text("fusion 10-round extended magazine"),
    description = ccb.content.text("A modified high-density magazine designed to hold and align micro-fusion target pellets. Its original capacitive contacts and magnetic shielding have been weakened and expanded using nanomaterials, making it unstable and unsafe for use in propellant-reaction microfusion firearms. However, it's perfect for energy laser-type microfusion firearms."),
    copy_from = "fcl_fusion_pack",
    mass = "168 g",
    volume = "250 ml",
    price = "500 USD",
    survival_price = "10 USD",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { fcl_fusion_pellet = 10 } } },
    magazine = { capacity = 10, reload_time = 600 },
}

ccb.content.define_item {
    id = "fcl_fusion_20_mag",
    looks_like = "stanag30",
    name = ccb.content.text("fusion 20-round extended magazine"),
    description = ccb.content.text("A modified high-density magazine designed to hold and align micro-fusion target pellets. Its original capacitive contacts and magnetic shielding have been weakened and expanded using nanomaterials, making it unstable and unsafe for use in propellant-reaction microfusion firearms. However, it's perfect for energy laser-type microfusion firearms."),
    copy_from = "fcl_fusion_pack",
    mass = "198 g",
    volume = "300 ml",
    price = "500 USD",
    survival_price = "10 USD",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { fcl_fusion_pellet = 20 } } },
    magazine = { capacity = 20, reload_time = 600 },
}

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
