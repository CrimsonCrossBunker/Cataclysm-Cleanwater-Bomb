local ccb = require("ccb")

ccb.content.define_item {
    id = "glock_19",
    copy_from = "gun_base_9mm_semi_pistol",
    looks_like = "glock_17",
    name = ccb.content.text("Glock carry pistol"),
    description = ccb.content.text("A common 9x19mm pistol of modest proportions, produced by the popular Glock gun company and mainly built from plastic polymers.  Making use of aptly-named Glock magazines and being a decades-long popular concealed carry option for civilians due to its small size, it is a tried, tested, and reliable design."),
    variant_kind = "gun",
    variants = {
        {
            id = "glock_19",
            name = ccb.content.text("Glock 19 pistol"),
            description = ccb.content.text("Possibly the most popular pistol in existence, the Glock 19 can be summed up as being fundamentally a more compact brother to the full-sized Glock 17 pistol.  Sporting a mainly polymer-based design, the Glock 19 is often derided for its plastic construction which lends the handgun a deceptively flimsy feel.  Even so, the Glock 19 remains both a remarkably reliable firearm and a quite shootable gun in its own right."),
            weight = 100,
        },
        {
            id = "glock_19_cop",
            name = ccb.content.text("Glock 19M"),
            description = ccb.content.text("A Glock 19 developed specially for the FBI, with all black internals and match grade components.  It was nearly impossible to find on the civilian market before the Cataclysm, now it is completely irreplaceable."),
            weight = 0,
        },
        {
            id = "glock_45",
            name = ccb.content.text("Glock 45 pistol"),
            description = ccb.content.text("The Glock 45 is practically identical to the Glock 19, the main difference being that the grip is styled to be closer to that of the Glock 17."),
            weight = 77,
        },
    },
    ascii_picture = "glock_19",
    mass = "600 g",
    volume = "386 ml",
    length = "211 mm",
    price = "690 USD",
    materials = { "plastic", "steel" },
    pockets = {
        {
            magazine_well = "250 ml",
            kind = "MAGAZINE_WELL",
            allowed_items = {
                "glockmag_10", "glock17_10", "glockmag", "glockbigmag", "glock17_17", "glock17_22",
                "glock_drum_50rd", "glock_drum_100rd",
            },
        },
    },
    gun = {
        barrel_length = "102 mm",
        dispersion = 480,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "glock_26",
    copy_from = "gun_base_9mm_semi_pistol",
    looks_like = "glock_19",
    name = ccb.content.text("Glock 26 pistol"),
    description = ccb.content.text("A Glock subcompact pistol chambered in 9mm Luger.  Despite its tiny size, it can fit the magazines of its larger brothers."),
    mass = "550 g",
    volume = "348 ml",
    length = "165 mm",
    price = "690 USD",
    materials = { "plastic", "steel" },
    pockets = {
        {
            magazine_well = "250 ml",
            kind = "MAGAZINE_WELL",
            allowed_items = {
                "glockmag_10", "glock17_10", "glockmag", "glockbigmag", "glock17_17", "glock17_22",
                "glock_drum_50rd", "glock_drum_100rd",
            },
        },
    },
    gun = {
        barrel_length = "87 mm",
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
        dispersion = 480,
    },
}

ccb.content.define_item {
    id = "glock_34",
    copy_from = "gun_base_9mm_semi_pistol",
    name = ccb.content.text("Glock 34 pistol"),
    description = ccb.content.text("A large, stylish Glock chambered in 9mm.  Developed for accuracy, this pistol is used by competition shooters, law enforcement, and even the Baba Yaga."),
    mass = "655 g",
    volume = "427 ml",
    length = "224 mm",
    price = "630 USD",
    materials = { "plastic", "steel" },
    pockets = {
        {
            magazine_well = "250 ml",
            kind = "MAGAZINE_WELL",
            allowed_items = {
                "glock17_10",
                "glock17_17",
                "glock17_22",
                "glock_drum_50rd",
                "glock_drum_100rd",
                "glockbigmag",
            },
        },
    },
    gun = {
        barrel_length = "135 mm",
        dispersion = 380,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "glock_43",
    copy_from = "gun_base_9mm_semi_pistol",
    looks_like = "glock_19",
    name = ccb.content.text("Glock 43 pistol"),
    description = ccb.content.text("A 9x19mm Glock of diminutive proportions.  Unfortunately it is incompatible with other 9mm Glock magazines."),
    mass = "460 g",
    volume = "279 ml",
    length = "159 mm",
    price = "570 USD",
    materials = { "plastic", "steel" },
    pockets = { { magazine_well = "250 ml", kind = "MAGAZINE_WELL", allowed_items = { "glock43_mag" } } },
    gun = { barrel_length = "87 mm", dispersion = 480 },
}

-- This one uses 10 round doublestack mags, which are incompatible with the standard variant
ccb.content.define_item {
    id = "glock_43x",
    copy_from = "gun_base_9mm_semi_pistol",
    looks_like = "glock_19",
    name = ccb.content.text("Glock 43X pistol"),
    description = ccb.content.text("A 9mm compact Glock.  Despite its name, it does not accept the magazines of the Glock 43."),
    mass = "461 g",
    volume = "279 ml",
    length = "165 mm",
    price = "570 USD",
    materials = { "plastic", "steel" },
    pockets = { { magazine_well = "250 ml", kind = "MAGAZINE_WELL", allowed_items = { "glock43x/48_mag" } } },
    gun = {
        barrel_length = "87 mm",
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
        dispersion = 480,
    },
}

ccb.content.define_item {
    id = "glock_48",
    copy_from = "gun_base_9mm_semi_pistol",
    looks_like = "glock_19",
    name = ccb.content.text("Glock 48 pistol"),
    description = ccb.content.text("A 9mm, slimline Glock.  Designed for concealed carry, and accepts the magazine from a Glock 43x, but not the base 43."),
    mass = "524 g",
    volume = "331 ml",
    length = "185 mm",
    price = "570 USD",
    materials = { "plastic", "steel" },
    pockets = { { magazine_well = "250 ml", kind = "MAGAZINE_WELL", allowed_items = { "glock43x/48_mag" } } },
    gun = {
        barrel_length = "106 mm",
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
        dispersion = 480,
    },
}

-- Tileset whitelist for SMGs
ccb.content.define_item {
    id = "hk_mp5",
    copy_from = "gun_base_9mm_semi_rifle",
    name = ccb.content.text("H&K MP5A2 submachine gun"),
    description = ccb.content.text("The Heckler & Koch MP5 is one of the most widely-used submachine guns in the world, and has been adopted by special police forces and militaries alike.  Its high degree of accuracy and low recoil are universally praised."),
    ascii_picture = "hk_mp5a2",
    mass = "2726 g",
    volume = "3932 ml",
    length = "682 mm",
    price = "2 kUSD 800 USD",
    survival_price = "35 USD",
    materials = { "steel", "plastic" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_items = {
                "mp5mag", "mp5mag_10rd", "mp5mag_15rd", "mp5mag_20rd", "mp5mag_38rd", "mp5mag_40rd",
                "mp5bigmag", "mp5mag_100rd",
            },
        },
    },
    gun = {
        reload_noise_volume = 10,
        barrel_length = "225 mm",
        skill = "smg",
        range = 4,
        dispersion = 240,
        modes = {
            { id = "DEFAULT", label = ccb.content.text("semi-auto"), quantity = 1 },
            { rpm = 800, quantity = 3 },
            { id = "AUTO", label = ccb.content.text("auto-rpm"), rpm = 800 },
        },
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "muzzle", count = 1 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 1 },
            { id = "stock", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "hk_mp5sd",
    copy_from = "hk_mp5",
    name = ccb.content.text("H&K MP5SD submachine gun"),
    description = ccb.content.text("The H&K MP5SD offers subsonic performance in almost the same footprint as the H&K MP5, retaining its handiness.  The large suppressor cuts down on muzzle flash greatly, aiding in night operations.  It has also seen some popularity with SWAT teams, as it lowers the risk of fire and explosions in illegal laboratories.  With body armor in more common use, the MP5SD has waned in popularity among special forces due to its decreased terminal performance."),
    ascii_picture = "hk_mp5sd",
    mass = "3230 g",
    volume = "3499 ml",
    length = "666 mm",
    price = "30 kUSD",
    survival_price = "140 USD",
    gun = {
        range = 1,
        barrel_length = "146 mm",
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 1 },
            { id = "stock", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
        built_in_mods = { "mp5sd_suppressor" },
    },
}

-- Forward grip's 68g & 119ml deducted
ccb.content.define_item {
    id = "hk_mp5k",
    copy_from = "hk_mp5",
    name = ccb.content.text("H&K MP5K-PDW submachine gun"),
    description = ccb.content.text("The Heckler & Koch MP5 is one of the most widely-used submachine guns in the world, and has been adopted by special police forces and militaries alike.  Its high degree of accuracy and low recoil are universally praised.  The MP5K-PDW model features a shorter barrel, a built-in foregrip, and a side folding stock for vehicle or aircraft crew use."),
    ascii_picture = "hk_mp5-pdw",
    mass = "2292 g",
    volume = "2601 ml",
    length = "377 mm",
    survival_price = "35 USD",
    melee_damage = { bash = 8 },
    gun = {
        barrel_length = "115 mm",
        dispersion = 270,
        range = 1,
        built_in_mods = { "folding_stock", "grip" },
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "muzzle", count = 1 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 1 },
            { id = "stock mount", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "hk_mp5_semi_pistol",
    copy_from = "hk_mp5",
    name = ccb.content.text("MP5 pistol"),
    description = ccb.content.text("A semi-automatic copy of the famous MP5 series, domestically produced for the US market.  Like the MP5, its roller delayed blowback action offers smooth shooting and precision, setting it apart from other submachine guns and pistol caliber carbines.  This model is configured as a pistol to avoid inconvenient and costly NFA regulations.  A welded-on section of M1913 rail offers convenient mounting for aftermarket optics, but precludes the use of claw mounts."),
    variant_kind = "gun",
    variants = {
        {
            id = "ptr_603",
            name = ccb.content.text("PTR 9KT"),
            description = ccb.content.text("The PTR 9KT is a semi-automatic copy of the famous MP5 series, domestically produced for the US market on original Heckler & Koch tooling by PTR Industries.  Like the MP5, its roller delayed blowback action offers smooth shooting and precision, setting it apart from other submachine guns and pistol caliber carbines.  This model is configured as a pistol to avoid inconvenient and costly NFA regulations.  A welded-on section of M1913 rail offers convenient mounting for aftermarket optics, but precludes the use of claw mounts."),
        },
    },
    mass = "2177 g",
    volume = "2110 ml",
    length = "377 mm",
    melee_damage = { bash = 7 },
    gun = {
        barrel_length = "116 mm",
        skill = "pistol",
        range = 1,
        modes = { { id = "DEFAULT", label = ccb.content.text("semi-auto"), quantity = 1 } },
        dispersion = 270,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "muzzle", count = 1 },
            { id = "rail mount", count = 1 },
            { id = "sights", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 1 },
            { id = "stock mount", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
    },
}
