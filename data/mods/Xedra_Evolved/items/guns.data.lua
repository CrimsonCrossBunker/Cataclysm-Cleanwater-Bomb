local ccb = require("ccb")

ccb.content.define_item {
    id = "fn57_sup",
    copy_from = "fn57",
    name = ccb.content.text("FN Five-seveN suppressed"),
    length = "194 mm",
    volume = "600 ml",
    description = ccb.content.text("Designed to work with FN's proprietary 5.7x28mm round and with a built in suppressor, the Five-seveN is a lightweight integrally suppressed pistol with a very high capacity, best used against armored opponents."),
    gun = {
        reload_noise_volume = 6,
        min_cycle_recoil = 40,
        damage = { type = "bullet", amount = 0 },
        built_in_mods = { "integrated_fn_suppressor" },
    },
}

ccb.content.define_item {
    id = "sr1vektor_9x21mm",
    copy_from = "gun_base_handgun_semi",
    name = ccb.content.plural_text("SR-1 Vektor Gyurza", "SR-1 Vektor Gyurza"),
    description = ccb.content.text("The SR-1 Vektor also known as the Gyurza (Гюрза, Russian for 'blunt-nosed viper') or Serdyukov SPS is a 9×21mm Gyurza semi-automatic pistol designed for the Russian military.  It fires 9x21mm ammunition, which is rare in the States."),
    mass = "950 g",
    volume = "505 ml",
    length = "195 mm",
    price = "950 USD",
    survival_price = "30 USD",
    materials = { "plastic", "lc_steel" },
    pockets = {
        {
            magazine_well = "250 ml",
            kind = "MAGAZINE_WELL",
            allowed_items = { "sr1vektor_mag_18rd" },
        },
    },
    gun = { ammunition = { "9x21mm" }, dispersion = 480, durability = 7, min_cycle_recoil = 450 },
}

ccb.content.define_item {
    id = "aa_12",
    copy_from = "gun_base_shotgun_semi",
    looks_like = "remington_870",
    name = ccb.content.text("Auto Assault-12"),
    description = ccb.content.text("The Atchisson Assault Shotgun, is an automatic combat shotgun developed in 1972 by Maxwell Atchisson.  The most prominent feature is reduced recoil."),
    mass = "5200 g",
    volume = "3064 ml",
    length = "966 mm",
    price = "1 kUSD 890 USD",
    survival_price = "85 USD",
    materials = { "lc_steel" },
    pockets = { { kind = "MAGAZINE_WELL", allowed_items = { "aa12_box_mag", "aa12_drum_mag" } } },
    gun = {
        dispersion = 358,
        durability = 7,
        modes = {
            { id = "DEFAULT", label = ccb.content.text("semi-auto"), quantity = 1 },
            { rpm = 300, quantity = 3 },
            { id = "AUTO", label = ccb.content.text("auto-rpm"), rpm = 300 },
        },
        default_mods = { "bars" },
        barrel_volume = "81 ml",
        mod_locations = {
            { id = "sling", count = 1 },
            { id = "stock mount", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "barrel", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "grip mount", count = 1 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "hammer_turret_system",
    copy_from = "aa_12",
    looks_like = "remington_870",
    name = ccb.content.text("HAMMER dual AA-12 turret system"),
    description = ccb.content.text("An electrically driven dual AA-12s mounted together to match to a turret."),
    mass = "15 kg",
    volume = "9 L",
    length = "100 cm",
    price = "1 kUSD 800 USD",
    survival_price = "175 USD 50 cent",
    materials = { "lc_steel" },
    flags = { "MOUNTED_GUN" },
    pockets = { { kind = "MAGAZINE_WELL", allowed_items = { "aa12_vehicle_drum" } } },
    melee_damage = { bash = 9 },
    gun = {
        dispersion = 358,
        durability = 8,
        modes = { { id = "DEFAULT", label = ccb.content.text("auto-rpm"), rpm = 600 } },
        energy_drain = "1 kJ",
        reload_time = 200,
        default_mods = { "bars" },
        mod_locations = { { id = "sights", count = 1 }, { id = "rail mount", count = 1 } },
    },
}
