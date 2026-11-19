local ccb = require("ccb")

-- This is just a Rheinmetall Hydra.
ccb.content.define_item {
    id = "robofac_gun_40mm",
    copy_from = "launcher_base",
    looks_like = "mark19",
    name = ccb.content.plural_text("Hub 01 FSP", "Hub 01 FSP"),
    description = ccb.content.text("The Hub 01 Fire Support Platform, or just the FSP.  Like the Hybrid Weapons Platform, it combines black-finished aluminum, blue polymer furniture, and a number of proprietary bolts and fasteners for a sci-fi aesthetic.  The barrel is stamped with \"40x46mm LV\", and the magwell looks like it accepts some truly MASSIVE magazines, which the gun appears to be capable of emptying in semi-automatic or fully-automatic fashion."),
    mass = "4082 g",
    volume = "5822 ml",
    length = "83 cm",
    price = "30 kUSD",
    survival_price = "75 USD",
    materials = { "aluminum", "plastic" },
    symbol = "(",
    color = "blue",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_items = { "robofac_gun_40mm_3rd", "robofac_gun_40mm_5rd", "robofac_gun_40mm_10rd" },
        },
    },
    melee_damage = { bash = 14 },
    inheritance = { add = { flags = { "NO_TURRET" } } },
    gun = {
        barrel_length = "254 mm",
        modes = {
            { id = "DEFAULT", label = ccb.content.text("semi-auto"), quantity = 1 },
            { rpm = 900, quantity = 3 },
        },
        ammunition = { "40x46mm" },
        dispersion = 120,
        durability = 9,
        blackpowder_tolerance = 40,
        min_cycle_recoil = 1400,
        built_in_mods = { "robofac_handguard", "hybrid_sight_4x", "holo_sight", "robofac_laser_sight" },
        mod_locations = {
            { id = "underbarrel", count = 1 },
            { id = "rail", count = 1 },
            { id = "sling", count = 1 },
            { id = "bore", count = 1 },
            { id = "sights", count = 2 },
            { id = "stock", count = 1 },
            { id = "stock accessory", count = 1 },
        },
    },
}
