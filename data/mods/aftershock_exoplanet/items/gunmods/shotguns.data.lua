local ccb = require("ccb")

-- Yes lead isn't magnetic, no I don't care.
ccb.content.define_item {
    id = "afs_magnetic_choke",
    name = ccb.content.plural_text("magnetic choke", "magnetic chokes"),
    description = ccb.content.text("A choke that uses a powerful cross-shaped electromagnet to pull the shot cloud together, greatly reducing the spread of shot.  Prevents the use of slugs."),
    mass = "300 g",
    volume = "150 ml",
    length = "4 cm",
    integral_length = "1 cm",
    price = "780 USD",
    survival_price = "15 USD",
    materials = { "steel" },
    symbol = ":",
    color = "dark_gray",
    flags = { "CHOKE" },
    gunmod = {
        location = ccb.content.text("muzzle"),
        targets = { ccb.content.text("shotgun", "gun_type_type") },
        install_time = "3 m",
        shot_spread_modifier = -0.8,
    },
}

-- Flechettes should be made a distinct ammo type, but that would break other vanilla shotguns. Change should happen when aftershock becomes total conversion.
ccb.content.define_item {
    id = "afs_shotgun_gauss",
    name = ccb.content.plural_text("shotgun gauss array", "shotgun gauss arrays"),
    description = ccb.content.text("A tuned set of electromagnets that accelerate projectiles to a much higher velocity than normal, increasing range and damage.  The required modifications are invasive and cannot be removed once installed."),
    mass = "1610 g",
    integral_mass = "410 g",
    volume = "1500 ml",
    integral_volume = "310 ml",
    price = "720 USD",
    survival_price = "5 USD",
    materials = { "steel" },
    symbol = ":",
    color = "light_gray",
    flags = { "IRREMOVABLE", "USE_UPS" },
    gunmod = {
        install_time = "5 m",
        location = ccb.content.text("barrel"),
        targets = { ccb.content.text("shotgun", "gun_type_type") },
        damage_modifier = { type = "electric", amount = 3, penetration = 7 },
        energy_drain_modifier = "20 kJ",
        effects = { "SMALL_ELECTRIC_BURST" },
        dispersion_modifier = 15,
        range_modifier = 5,
        handling_modifier = -2,
    },
    minimum_skills = { { id = "electronics", count = 6 } },
}
