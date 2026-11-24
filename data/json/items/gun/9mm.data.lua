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

ccb.content.define_item {
    id = "p08",
    copy_from = "gun_base_9mm_semi_pistol",
    looks_like = "glock_17",
    name = ccb.content.text("Luger P08 pistol"),
    description = ccb.content.text("A semi-automatic 9x19mm military issued pistol with an unusual toggle-lock action.  Well-known for its use by the Germans during both World Wars, it's a notably accurate handgun even by modern standards, and this example of a P08 was more than likely either brought back state-side as a war trophy by a veteran, or imported."),
    mass = "871 g",
    volume = "465 ml",
    length = "248 mm",
    price = "1 kUSD",
    materials = { "steel" },
    pockets = {
        {
            magazine_well = "55 ml",
            kind = "MAGAZINE_WELL",
            allowed_items = { "p08mag_8rd", "p08mag_32rd" },
        },
    },
    gun = {
        barrel_length = "100 mm",
        dispersion = 420,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "mauser_c96",
    copy_from = "gun_base_9mm_semi_pistol",
    looks_like = "glock_17",
    name = ccb.content.text("Mauser pistol"),
    description = ccb.content.text("A semi-automatic German pistol developed prior to 1900, the firearm features a burned and painted number '9' on its broom handle-shaped grip to signify its chambering, 9x19mm parabellum, and makes use of appropriate stripper clips or single round loading.  Quite possibly the most aesthetically steampunk weapon that one could ever possibly get their hands on, this example likely found its way into the US via early import or as a holdover from the Great War."),
    variant_kind = "gun",
    variants = {
        {
            id = "mauser_c96",
            name = ccb.content.text("Mauser C96 Broomhandle pistol"),
            description = ccb.content.text("A late 19th century semi-automatic German pistol with an integral magazine loaded from the top via stripper clips, and quite possibly the most steampunk gun one could ever possibly lay their hands on.  A red number '9' burned and painted into the weapon's broom handle-shaped grip marks it as a variant chambered for 9x19mm rounds.  Both exported for commercial use and produced for the German military during the First World War to make up for production shortages of the standard Luger, this example likely entered the US as a holdover from the Great War.  You suppose that it's only fitting that one of the globe's first produced and oldest semi-automatic handguns gets reinstated into service now that the planet's facing its end."),
        },
    },
    ascii_picture = "mauser_c96",
    mass = "1134 g",
    volume = "640 ml",
    length = "312 mm",
    price = "1 kUSD 300 USD",
    materials = { "steel" },
    flags = { "RELOAD_ONE" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            ammunition = { ["9mm"] = 10 },
            allowed_speedloaders = { "clip9mm_10rd" },
        },
    },
    gun = {
        barrel_length = "140 mm",
        dispersion = 450,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "mp40",
    copy_from = "gun_base_9mm_semi_rifle",
    looks_like = "hk_mp5",
    name = ccb.content.text("MP 40 submachine gun"),
    description = ccb.content.text("An antique German-issued submachine gun from the Second World War, likely having entered the United States as a personal holdover by a veteran.  Chambered in 9x19mm and utilizing proprietary box magazines, the firearm has an integrated under folding wire stock."),
    variant_kind = "gun",
    variants = {
        {
            id = "mp40",
            name = ccb.content.text("Vollmer MP 40 submachine gun"),
            description = ccb.content.text("A simple and renowned 9x19mm submachine gun developed by Heinrich Vollmer for the German army.  Adopted in 1940, it saw extensive service on both fronts of the Second World War and was much regarded by soldiers who fielded the weapon in combat, being praised for its reliability and relatively modern design.  Featuring an integral folding wire butt stock, this weapon more than likely entered the United States as a war trophy by a returning veteran.  It was often called \"Schmeisser\" by the Allies, after Hugo Schmeisser, who designed the MP 18, although he was not involved in the design or production of the MP 40."),
        },
    },
    mass = "3969 g",
    volume = "2320 ml",
    length = "648 mm",
    price = "15 kUSD",
    materials = { "steel" },
    pockets = { { magazine_well = "40 ml", kind = "MAGAZINE_WELL", allowed_items = { "mp40mag_32rd" } } },
    gun = {
        barrel_length = "251 mm",
        skill = "smg",
        range = 4,
        dispersion = 360,
        durability = 6,
        built_in_mods = { "under_folding_stock" },
        modes = { { id = "DEFAULT", label = ccb.content.text("auto-rpm"), rpm = 500 } },
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock mount", count = 1 },
            { id = "stock", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "mp40semi",
    copy_from = "gun_base_9mm_semi_pistol",
    name = ccb.content.text("Semi Automatic MP 40 submachine gun"),
    description = ccb.content.text("A modern semi-automatic replica of the MP 40 submachine gun, which lacks a butt stock to make it legally be considered a pistol.  It actually bears only a visual resemblance to the original, differing substantially from originally manufactured MP 40 submachine guns in its internal operations."),
    mass = "3722 g",
    volume = "2020 ml",
    length = "671 mm",
    price = "900 USD",
    materials = { "steel" },
    pockets = { { magazine_well = "40 ml", kind = "MAGAZINE_WELL", allowed_items = { "mp40mag_32rd" } } },
    melee_damage = { bash = 10 },
    gun = {
        barrel_length = "274 mm",
        range = 4,
        dispersion = 360,
        mod_locations = {
            { id = "brass catcher", count = 1 },
            { id = "stock mount", count = 1 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
        },
    },
}

-- The actual gun is around 30 cm longer than what's depicted here, but the inbuilt accessory adds 35 cm, which ends up totalling to the same length. IRL the SUB-2000 folds literally in half, which is a greatly smaller size than what our folding stocks can collapse to, so like this the length stays the same as far as the player can see, and you still get the same largely folded effect as you'd have on the real gun.
-- Assuming gen 3 to allow sights to be mounted and folded
ccb.content.define_item {
    id = "ksub2000",
    copy_from = "gun_base_9mm_semi_rifle",
    looks_like = "hk_mp5",
    name = ccb.content.text("folding Glock carbine"),
    description = ccb.content.text("With its claim to fame being its ease of portability when compared to other conventional rifles and carbines, this is a uniquely-designed pistol caliber carbine sporting an integral folding mechanism and chambered for 9x19mm cartridges, making use of regular Glock compatible magazines.  With its mechanism engaged, the barrel assembly swings rearwards and causes the firearm to fold to half its regular length, packing up into a very compact package with ergonomics unfortunately having to take a backseat to allow for the weapon's extreme portability.  With a mainly polymer constructed receiver, the carbine is relatively light and incredibly transportable when fully folded."),
    variant_kind = "gun",
    variants = {
        {
            id = "ksub2000",
            name = ccb.content.text("Kel-Tec SUB-2000 carbine"),
            description = ccb.content.text("With its claim to fame being its ease of portability when compared to other conventional rifles and carbines, the Kel-Tec SUB-2000 is a uniquely-designed pistol caliber carbine sporting an integral folding mechanism and chambered for 9x19mm cartridges, making use of regular Glock compatible magazines.  With its mechanism engaged, the barrel assembly swings rearwards and causes the firearm to fold to half its regular length, packing up into a very compact package with ergonomics unfortunately having to take a backseat to allow for the weapon's extreme portability.  With a mainly polymer constructed receiver, the carbine is relatively light and incredibly transportable when fully folded."),
        },
    },
    mass = "1930 g",
    volume = "1240 ml",
    length = "410 mm",
    price = "750 USD",
    materials = { "steel", "plastic" },
    pockets = {
        {
            magazine_well = "250 ml",
            kind = "MAGAZINE_WELL",
            allowed_items = {
                "glockmag", "glockbigmag", "glock17_17", "glock17_22", "glock_drum_50rd",
                "glock_drum_100rd", "glockmag_10", "glock17_10",
            },
        },
    },
    gun = {
        barrel_length = "274 mm",
        range = 6,
        dispersion = 180,
        durability = 7,
        built_in_mods = { "sub2000_folding_mechanism" },
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "muzzle", count = 1 },
            { id = "rail", count = 1 },
            { id = "sights", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock", count = 1 },
            { id = "underbarrel", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "m9",
    copy_from = "gun_base_9mm_semi_pistol",
    looks_like = "glock_17",
    name = ccb.content.text("M9 combat pistol"),
    description = ccb.content.text("A rugged, iconic, and long-serving 9mm handgun, the M9 is a sleek pistol that has enjoyed fame in military, law enforcement, and civilian circles ever since its inception.  Adopted as the primary service sidearm across all United States armed branches from the early eighties until the late two thousand and tens, the weapon has seen a great deal of popular media coverage in both video games and television alike."),
    mass = "961 g",
    volume = "570 ml",
    length = "249 mm",
    price = "650 USD",
    variant_kind = "gun",
    variants = {
        {
            id = "m9",
            name = ccb.content.text("Beretta M9A1 pistol"),
            description = ccb.content.text("An iconic 9x19mm pistol, the M9 was the standard issue sidearm of the US armed forces from 1985 until only recently.  It was formerly popular among law enforcement before the advent of commercially available polymer-framed handguns and the FBI's adoption of .40 S&W."),
        },
        {
            id = "90two",
            name = ccb.content.text("Beretta 90-two pistol"),
            description = ccb.content.text("A more modern version of Beretta's popular 92 series of handguns, the 90-two performs largely the same.  The main difference is a sleeker, almost futuristic-looking design owed in large part to the polymer underbarrel rail cover."),
        },
    },
    ascii_picture = "beretta_m9",
    materials = { "steel", "aluminum" },
    pockets = {
        {
            magazine_well = "250 ml",
            kind = "MAGAZINE_WELL",
            allowed_items = {
                "m9mag",
                "m9mag_10rd",
                "m9mag_17rd",
                "m9mag_18rd",
                "m9mag_20rd",
                "m9bigmag",
                "m9mag_32rd",
                "m9mag_35rd",
            },
        },
    },
    gun = {
        barrel_length = "125 mm",
        dispersion = 480,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "px4",
    copy_from = "gun_base_9mm_semi_pistol",
    looks_like = "glock_17",
    name = ccb.content.text("Beretta Px4 Storm pistol"),
    description = ccb.content.text("Lighter than Beretta's iconic 92 series of guns, the Px4 Storm was built by utilizing light-weight polymer construction with steel inserts.  Its shape was also optimized for concealed carry, while maintaining the reliability that the 92 series is known for."),
    mass = "785 g",
    volume = "520 ml",
    length = "231 mm",
    price = "650 USD",
    materials = { "plastic", "steel" },
    pockets = {
        {
            magazine_well = "250 ml",
            kind = "MAGAZINE_WELL",
            allowed_items = { "px4mag", "px4mag_10rd", "px4mag_15rd", "px4mag_20rd" },
        },
    },
    gun = {
        barrel_length = "102 mm",
        dispersion = 440,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}

-- Crafting recipe must make use of angle grinder, bench grinder, set square and vise, which don't yet exist in game.
ccb.content.define_item {
    id = "smg_9mm",
    copy_from = "gun_base_9mm_semi_rifle",
    looks_like = "hk_mp5",
    name = ccb.content.text("STEN Luty submachine gun"),
    description = ccb.content.text("A Luty pattern makeshift smoothbore SMG crudely constructed out of various steel parts using advanced powered hand tools; likely one of the most complex guns that is feasible to make outside of a machine shop, but still very unreliable.  This one is chambered for 9x19mm cartridges and accepts STEN-compatible magazines."),
    mass = "3520 g",
    volume = "1110 ml",
    length = "538 mm",
    price = "200 USD",
    materials = { "steel" },
    pockets = { { kind = "MAGAZINE_WELL", allowed_items = { "survivor9mm_mag", "stenmag" } } },
    gun = {
        barrel_length = "229 mm",
        skill = "smg",
        dispersion = 590,
        durability = 4,
        modes = { { id = "DEFAULT", label = ccb.content.text("auto-rpm"), rpm = 600 } },
        loudness = 25,
        barrel_volume = "250 ml",
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "sling", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "sten",
    copy_from = "gun_base_9mm_semi_rifle",
    looks_like = "hk_mp5",
    name = ccb.content.text("STEN Mk II submachine gun"),
    description = ccb.content.text("The standard issue 9mm submachine gun of the British military throughout most of the Second World War.  The STEN is aesthetically far from pretty.  Featuring an iconic side mounted magazine well and a design optimized for mass production using unskilled labor, the STEN was developed to make up for drastic supply shortages during the early days of the war.  Likely entering the US prior to the 1960s, either as a war time holdover or a museum purchase; you suppose that if you were to try and defend your nation, whatever the cost may be, and fight the undead 'on the beaches, fight on the landing grounds, fight in the fields and in the streets, fight in the hills; and never surrender', then it might be the time for the STEN to come back into frontline service."),
    mass = "3200 g",
    volume = "1240 ml",
    length = "765 mm",
    price = "400 USD",
    materials = { "steel" },
    pockets = { { kind = "MAGAZINE_WELL", allowed_items = { "stenmag", "survivor9mm_mag" } } },
    gun = {
        reload_noise_volume = 10,
        barrel_length = "198 mm",
        skill = "smg",
        range = 2,
        dispersion = 360,
        durability = 5,
        modes = { { id = "DEFAULT", label = ccb.content.text("auto-rpm"), rpm = 550 } },
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock mount", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "usp_9mm",
    copy_from = "gun_base_9mm_semi_pistol",
    looks_like = "glock_17",
    name = ccb.content.text("USP 9x19mm pistol"),
    description = ccb.content.text("A popular pistol, widely used among law enforcement.  Extensively tested for durability, it has been found to stay accurate even after being subjected to extreme abuse."),
    mass = "771 g",
    volume = "460 ml",
    length = "230 mm",
    price = "680 USD",
    materials = { "steel", "plastic" },
    pockets = {
        {
            magazine_well = "250 ml",
            kind = "MAGAZINE_WELL",
            allowed_items = { "usp9mag", "usp9mag_10rd", "usp9mag_18rd", "usp9mag_20rd", "usp9mag_32rd" },
        },
    },
    gun = {
        barrel_length = "108 mm",
        dispersion = 400,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
        durability = 9,
    },
}

-- SMGs aren't as commercially traded as rifles/handguns/SGs, so no cite for price points.  Total weight of gun 3500 grams.  Current weight of folding stock 200 grams.
ccb.content.define_item {
    id = "uzi",
    copy_from = "gun_base_9mm_semi_rifle",
    looks_like = "hk_mp5",
    name = ccb.content.text("Uzi 9x19mm submachine gun"),
    description = ccb.content.text("The Uzi 9x19mm has enjoyed immense popularity, selling more units than any other submachine gun.  It is widely used as a personal defense weapon, or as a primary weapon by elite frontline forces."),
    mass = "3500 g",
    volume = "2150 ml",
    length = "480 mm",
    price = "2 kUSD 80 USD",
    materials = { "steel" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_items = { "uzimag", "uzimag_20rd", "uzimag_25rd", "uzimag_40rd", "uzimag_50rd", "uzimag_100rd" },
        },
    },
    gun = {
        barrel_length = "260 mm",
        skill = "smg",
        range = 7,
        dispersion = 360,
        modes = {
            { id = "DEFAULT", label = ccb.content.text("semi-auto"), quantity = 1 },
            { id = "AUTO", label = ccb.content.text("auto-rpm"), rpm = 600 },
        },
        built_in_mods = { "wire_stock" },
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "bayonet lug", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
    },
}

-- Tilelist whitelist for pistols.
-- Glock 17s cannot load magazines shorter than the standard 17rd magazine.
ccb.content.define_item {
    id = "glock_17",
    copy_from = "gun_base_9mm_semi_pistol",
    name = ccb.content.text("Glock duty pistol"),
    description = ccb.content.text("Designed for all shooters, this offering from the Glock gun company is a full-sized 9x19mm pistol marketed towards law-enforcement and military users.  Because of the long magazine well, it can't fit magazines shorter than the standard 17-round ones."),
    variant_kind = "gun",
    variants = {
        {
            id = "glock_17",
            name = ccb.content.text("Glock 17 pistol"),
            description = ccb.content.text("Commonly seen tucked away in the holsters of police officers, certain military professionals, and civilian shooters, this is a larger, older, service-oriented version of the popular Glock 19.  Similarly firing the 9x19mm cartridge and using higher capacity magazines, it performs largely the same, but due to the longer magazine well, it can't fit magazines shorter than the standard 17-round ones."),
        },
    },
    ascii_picture = "glock_17",
    mass = "630 g",
    volume = "427 ml",
    length = "233 mm",
    price = "690 USD",
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
        barrel_length = "114 mm",
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
    id = "glock_18c",
    copy_from = "glock_17",
    name = ccb.content.text("Glock machine pistol"),
    description = ccb.content.text("A military, fully automatic capable version of the popular 9x19mm handguns produced by the Glock arms company, this machine pistol makes use of Glock magazines.  The weapon has had its barrel modified to lessen recoil, a useful feature considering its high rate of fire and lack of a default buttstock."),
    variant_kind = "gun",
    variants = {
        {
            id = "glock_18c",
            name = ccb.content.text("Glock 18C pistol"),
            description = ccb.content.text("A selective-fire variation on the Glock 17, originally designed for Austria's EKO Cobra unit.  It has compensator cuts along its barrel to make recoil more manageable."),
        },
    },
    ascii_picture = "glock_18c",
    mass = "620 g",
    price = "1 kUSD",
    survival_price = "25 USD",
    gun = {
        modes = {
            { id = "DEFAULT", label = ccb.content.text("semi-auto"), quantity = 1 },
            { id = "AUTO", label = ccb.content.text("auto-rpm"), rpm = 1200 },
        },
        built_in_mods = { "barrel_ported" },
    },
}

ccb.content.define_item {
    id = "m11",
    copy_from = "gun_base_9mm_semi_pistol",
    name = ccb.content.text("M11 pistol"),
    description = ccb.content.text("Made by SIG Sauer, the M11 is a compact semi-automatic, short recoil operated pistol, also known as the P228."),
    mass = "825 g",
    volume = "505 ml",
    length = "216 mm",
    price = "950 USD",
    materials = { "plastic", "steel" },
    pockets = {
        {
            magazine_well = "250 ml",
            kind = "MAGAZINE_WELL",
            allowed_items = { "p228mag_13rd_9x19mm" },
        },
    },
    gun = {
        barrel_length = "99 mm",
        dispersion = 480,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "m17",
    copy_from = "gun_base_9mm_semi_pistol",
    looks_like = "glock_17",
    name = ccb.content.text("service handgun"),
    description = ccb.content.text("The general-issue military handgun of the United States army before the Cataclysm, this is a sizable pistol that fires 9x19mm cartridges.  Based off successful civilian designs and capable of taking magazines of various round capacities, the gun features a plastic polymer frame which helps to reduce overall weight."),
    variant_kind = "gun",
    variants = {
        {
            id = "m17",
            name = ccb.content.text("M17 pistol"),
            description = ccb.content.text("The M17 is an army issued semi-automatic, short recoil operated pistol derived from the SIG Sauer P320."),
        },
    },
    mass = "840 g",
    volume = "470 ml",
    length = "238 mm",
    price = "690 USD",
    materials = { "plastic", "steel" },
    pockets = {
        {
            magazine_well = "250 ml",
            kind = "MAGAZINE_WELL",
            allowed_items = { "p320mag_17rd_9x19mm", "p320mag_21rd_9x19mm", "p320mag_10rd_9x19mm" },
        },
    },
    gun = {
        barrel_length = "120 mm",
        dispersion = 480,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail", count = 1 },
            { id = "sights", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "m18",
    copy_from = "m17",
    name = ccb.content.text("compact service handgun"),
    description = ccb.content.text("A more petite version of the United States army's general issue sidearm, this is a modestly-sized pistol firing 9x19mm rounds.  Making use of the same magazines as its larger brother, the weapon features a shorter barrel and frame which helps to reduce its overall profile and make it more concealable as a result."),
    variant_kind = "gun",
    variants = {
        {
            id = "m18",
            name = ccb.content.text("M18 pistol"),
            description = ccb.content.text("The M18 is a compact, semi-automatic, short recoil operated pistol derived from the SIG Sauer P320 Carry, used by US Armed Forces.  Practically the same as its big brother, the M17, in every respect, the M18 features a moderately shorter slide and barrel which terminates at the end of the frame rather than extending partway beyond it like the M17."),
        },
    },
    mass = "737 g",
    volume = "457 ml",
    length = "221 mm",
    gun = { barrel_length = "98 mm" },
}

ccb.content.define_item {
    id = "p226_9mm",
    copy_from = "gun_base_9mm_semi_pistol",
    name = ccb.content.text("SIG P226 MK25 pistol"),
    description = ccb.content.text("The P226 MK25 is a full-size semi-automatic DA/SA, short-recoil operated pistol with corrosion-resistant internal coating and an engraved anchor on the side of the slide."),
    mass = "804 g",
    volume = "570 ml",
    length = "237 mm",
    price = "1 kUSD",
    materials = { "steel", "aluminum", "plastic" },
    pockets = {
        {
            magazine_well = "250 ml",
            kind = "MAGAZINE_WELL",
            allowed_items = { "p226mag_10rd_9x19mm", "p226mag_15rd_9x19mm" },
        },
    },
    gun = {
        barrel_length = "112 mm",
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
    id = "sp2022",
    copy_from = "gun_base_9mm_semi_pistol",
    name = ccb.content.text("SIG Pro SP2022 9mm pistol"),
    description = ccb.content.text("A polymer-frame, semi-automatic, DA/SA operated pistol, featuring a Picatinny rail and a Nitron stainless steel slide."),
    mass = "822 g",
    volume = "514 ml",
    length = "221 mm",
    price = "500 USD",
    materials = { "plastic", "steel" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_items = { "sp2022mag_10rd_9mm", "sp2022mag_12rd_9mm", "sp2022mag_15rd_9mm" },
        },
    },
    gun = {
        barrel_length = "99 mm",
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
    id = "hi_power_9mm",
    copy_from = "gun_base_9mm_semi_pistol",
    looks_like = "glock_17",
    name = ccb.content.text("Browning Hi-Power 9x19mm handgun"),
    description = ccb.content.text("The Browning Hi-Power is a semi-automatic handgun developed shortly before the Second World War.  Widely issued since then, it remains in use by India, Canada, and Australia.  This is a commercial variant produced by Browning Arms in 9x19mm Parabellum."),
    mass = "900 g",
    volume = "274 ml",
    length = "228 mm",
    price = "320 USD",
    materials = { "plastic", "steel" },
    pockets = {
        {
            magazine_well = "191 ml",
            kind = "MAGAZINE_WELL",
            allowed_items = { "bhp9mag_13rd", "bhp9mag_15rd" },
        },
    },
    gun = {
        barrel_length = "119 mm",
        dispersion = 480,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "walther_p38",
    copy_from = "gun_base_9mm_semi_pistol",
    looks_like = "glock_17",
    name = ccb.content.text("Walther P38 handgun"),
    description = ccb.content.text("The Walther P38 is a semi-automatic handgun adopted shortly before the Second World War.  Developed due to the high production costs of its predecessor, the Luger P08, the P38 is also chambered in 9mm Parabellum.  This early DA/SA locked-breech design would introduce features later seen on more modern firearms such as the Beretta 92 series, and served Germany until 2004."),
    mass = "800 g",
    volume = "480 ml",
    length = "244 mm",
    price = "390 USD",
    materials = { "plastic", "steel" },
    pockets = { { magazine_well = "228 ml", kind = "MAGAZINE_WELL", allowed_items = { "p38mag" } } },
    gun = {
        barrel_length = "125 mm",
        dispersion = 480,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "walther_ppq_9mm",
    copy_from = "gun_base_9mm_semi_pistol",
    looks_like = "glock_17",
    name = ccb.content.text("Walther PPQ 9mm pistol"),
    description = ccb.content.text("The Walther PPQ is a semi-automatic pistol originating from the Walther P99QA, and maintains compatibility with some of its predecessor's accessories.  This model is chambered in 9x19mm Parabellum."),
    mass = "615 g",
    volume = "454 ml",
    length = "209 mm",
    price = "650 USD",
    materials = { "plastic", "steel" },
    pockets = {
        {
            magazine_well = "207 ml",
            kind = "MAGAZINE_WELL",
            allowed_items = { "ppq9mag_10rd", "ppq9mag_15rd", "ppq9mag_17rd" },
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
    id = "hptc9",
    copy_from = "gun_base_9mm_semi_pistol",
    looks_like = "glock_17",
    name = ccb.content.text("Hi-Point C-9 pistol"),
    description = ccb.content.text("The Hi-Point C-9 is a blowback operated semi-automatic pistol designed by Hi-Point Firearms, which is known for making inexpensive firearms, and for making said firearms bulky and uncomfortable.  Hi-Points have slides made with a zinc pot-metal which is relatively fragile compared to steel slides."),
    mass = "820 g",
    volume = "471 ml",
    length = "199 mm",
    price = "75 USD",
    materials = { "plastic", "steel", "zinc" },
    pockets = {
        {
            magazine_well = "284 ml",
            kind = "MAGAZINE_WELL",
            allowed_items = { "hptc9mag_8rd", "hptc9mag_10rd", "hptc9mag_15rd" },
        },
    },
    gun = {
        barrel_length = "89 mm",
        dispersion = 480,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
        durability = 7,
    },
}

ccb.content.define_item {
    id = "cz75",
    copy_from = "gun_base_9mm_semi_pistol",
    looks_like = "glock_17",
    name = ccb.content.text("CZ 75 B pistol"),
    description = ccb.content.text("The CZ 75 B is a semi-automatic pistol developed in Czechoslovakia, and is one of the original wonder nines.  Though designed for export to western countries, it was declared a state secret; lack of international patent protection meant that many clones and variants were produced and distributed around the world, with Česká zbrojovka only joining in the 90's.  This pistol remains wildly popular among competition shooters."),
    mass = "998 g",
    volume = "476 ml",
    length = "238 mm",
    price = "100 USD",
    materials = { "plastic", "steel" },
    pockets = {
        {
            magazine_well = "230 ml",
            kind = "MAGAZINE_WELL",
            allowed_items = { "cz75mag_10rd", "cz75mag_16rd", "cz75mag_20rd", "cz75mag_26rd" },
        },
    },
    gun = {
        barrel_length = "120 mm",
        dispersion = 480,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "walther_ccp",
    copy_from = "gun_base_9mm_semi_pistol",
    looks_like = "glock_17",
    name = ccb.content.text("Walther CCP pistol"),
    description = ccb.content.text("The Walther CCP is a gas-delayed blowback semi-automatic pistol intended for the concealed carry consumer market.  Internally, it is nearly identical to the cult classic H&K P7.  Its fixed barrel design makes it potentially more accurate than many other pistols, though this may be difficult to realize with its average trigger and short sight radius."),
    mass = "567 g",
    volume = "334 ml",
    length = "194 mm",
    price = "125 USD",
    materials = { "plastic", "steel" },
    pockets = {
        {
            magazine_well = "176 ml",
            kind = "MAGAZINE_WELL",
            allowed_items = { "ccpmag", "ccpmag_9rd" },
        },
    },
    gun = {
        barrel_length = "90 mm",
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
    id = "colt_ro635",
    copy_from = "gun_base_9mm_semi_rifle",
    looks_like = "modular_ar15",
    name = ccb.content.plural_text("Colt submachine gun (Uzi)", "Colt submachine guns (Uzi)"),
    description = ccb.content.text("A 9x19mm submachine gun based on the M16 rifle design, it is a closed bolt, blowback operated firearm.  There is a large plastic brass deflector mounted by the ejection port, and no forward assist.  It looks very similar to an M4 carbine, except for the magazine well that accepts Uzi-style magazines."),
    variant_kind = "gun",
    variants = {
        {
            id = "colt_ro635",
            name = ccb.content.text("Colt Model 635 submachine gun"),
            description = ccb.content.text("A 9x19mm submachine gun based on the M16 rifle design, it is a closed bolt, blowback operated firearm.  There is a large plastic brass deflector mounted by the ejection port, and no forward assist.  It looks very similar to an M4 carbine, except for the magazine well that accepts Uzi-style magazines."),
        },
    },
    mass = "2690 g",
    volume = "3450 ml",
    length = "655 mm",
    price = "1 kUSD",
    materials = { "steel", "plastic" },
    color = "dark_gray",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_items = { "uzimag", "uzimag_20rd", "uzimag_25rd", "uzimag_40rd", "uzimag_50rd", "uzimag_100rd" },
        },
    },
    gun = {
        barrel_length = "267 mm",
        ammunition = { "9mm" },
        skill = "smg",
        range = 5,
        dispersion = 240,
        modes = {
            { id = "DEFAULT", label = ccb.content.text("semi-auto"), quantity = 1 },
            { id = "AUTO", label = ccb.content.text("auto-rpm"), rpm = 850 },
        },
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "bayonet lug", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "muzzle", count = 1 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "bt_apc9k",
    copy_from = "gun_base_9mm_semi_rifle",
    looks_like = "modular_ar15",
    name = ccb.content.text("B&T APC9 PRO K submachine gun"),
    description = ccb.content.text("The Brügger & Thomet APC9 PRO K is a closed bolt blowback submachine gun in 9x19mm Parabellum.  It has a collapsible shoulder stock and a red dot sight."),
    mass = "2400 g",
    volume = "1890 ml",
    length = "525 mm",
    price = "5 kUSD",
    materials = { "steel", "plastic" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_items = {
                "btmp9mag_9x19mm_15", "btmp9mag_9x19mm_10rd", "btmp9mag_9x19mm_20", "btmp9mag_9x19mm_25",
                "btmp9mag_9x19mm_30", "btmp9mag_9x19mm_50rd",
            },
        },
    },
    gun = {
        barrel_length = "175 mm",
        range = 1,
        skill = "smg",
        dispersion = 300,
        modes = {
            { id = "DEFAULT", label = ccb.content.text("semi-auto"), quantity = 1 },
            { id = "AUTO", label = ccb.content.text("auto-rpm"), rpm = 1000 },
        },
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "muzzle", count = 1 },
            { id = "rail", count = 1 },
            { id = "sights", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock", count = 1 },
            { id = "underbarrel", count = 1 },
        },
        default_mods = { "wire_stock", "red_dot_sight" },
    },
}

-- Assuming glock magwell, the other magwell for Ruger magazines can be added with the ruger pistol
ccb.content.define_item {
    id = "rugerpcc",
    copy_from = "gun_base_9mm_semi_rifle",
    looks_like = "modular_ar15",
    name = ccb.content.text("Glock carbine"),
    description = ccb.content.text("A lightweight pistol caliber carbine, chambered in 9mm and accepting Glock magazines."),
    variant_kind = "gun",
    variants = {
        {
            id = "rugerpcc",
            name = ccb.content.text("Ruger PCC"),
            description = ccb.content.text("The Ruger PCC is a pistol caliber carbine, made by Ruger.  It's quite commonplace, thanks to its low recoil, reliability, and use of readily available magazines."),
        },
    },
    mass = "3084 g",
    volume = "2264 ml",
    length = "879 mm",
    price = "779 USD",
    materials = { "steel", "plastic", "aluminum" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_items = {
                "glockmag_10", "glock17_10", "glockmag", "glockbigmag", "glock17_17", "glock17_22",
                "glock_drum_50rd", "glock_drum_100rd",
            },
        },
    },
    gun = {
        barrel_length = "409 mm",
        range = 6,
        dispersion = 180,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "muzzle", count = 1 },
            { id = "rail", count = 1 },
            { id = "sights", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
    },
}

-- Based off of https://www.sigsauer.com/p365-xl.html
ccb.content.define_item {
    id = "p365",
    copy_from = "gun_base_9mm_semi_pistol",
    looks_like = "glock_17",
    name = ccb.content.text("P365 handgun"),
    description = ccb.content.text("A 9mm conceal carry pistol."),
    variant_kind = "gun",
    variants = {
        {
            id = "p365",
            name = ccb.content.text("SIG P365"),
            description = ccb.content.text("The SIG P365 is a modern compact 9mm pistol made by SIG.  Even though SIG promises to offer a lifetime warranty, you suspect that isn't true anymore."),
        },
    },
    mass = "588 g",
    volume = "293 ml",
    length = "208 mm",
    price = "679 USD 99 cent",
    materials = { "steel", "plastic" },
    pockets = { { magazine_well = "66 ml", kind = "MAGAZINE_WELL", allowed_items = { "p365_mag" } } },
    gun = {
        barrel_length = "94 mm",
        dispersion = 300,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail", count = 1 },
            { id = "sights", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "briefcase_smg",
    copy_from = "hk_mp5k",
    name = "MP5 operational briefcase",
    description = "A hard-sided briefcase with a trigger in the handle and a concealed hole in the side.  To fire the internally mounted MP5K-PDW, one braces the briefcase at the waist, ensures the hole is pointed at the enemy, and squeezes the trigger.  Precision and handling are severely hampered by the shape of the briefcase, but if you need to 'hand over the goods' or look low profile while bodyguarding, this is your gun.  When the briefcase is open, the MP5 may be reloaded or dismounted.",
    looks_like = "hk_briefcase",
    variant_kind = "gun",
    mass = "3800 g",
    volume = "15232 ml",
    length = "544 mm",
    price = "4 kUSD 800 USD",
    survival_price = "50 USD",
    flags = { "OVERSIZE", "RELOAD_EJECT", "BELTED", "RESTRICT_HANDS", "NO_TURRET" },
    melee_damage = { bash = 15 },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_items = { "mp5mag", "mp5mag_10rd", "mp5mag_15rd", "mp5mag_20rd" },
        },
    },
    variants = {
        {
            id = "briefcase_smg",
            name = "H&K operational briefcase",
            description = "A hard-sided briefcase with a trigger in the handle and a concealed hole in the side.  To fire the internally mounted MP5K-PDW, one braces the briefcase at the waist, ensures the hole is pointed at the enemy, and squeezes the trigger.  Precision and handling are severely hampered by the shape of the briefcase, but if you need to 'hand over the goods' or look low profile while bodyguarding, this is your gun.  When the briefcase is open, the MP5 may be reloaded or dismounted.",
        },
    },
    armor = {
        sided = true,
        portions = {
            {
                covers = { "arm_l", "arm_r", "hand_l", "hand_r" },
                coverage = 10,
                encumbrance = 30,
                materials = {
                    { id = "steel", thickness = 2.0, coverage = 100 },
                    { id = "plastic", thickness = 2.0, coverage = 100 },
                },
            },
        },
    },
    gun = {
        dispersion = 520,
        sight_dispersion = 520,
        mod_locations = {},
    },
    subtype_order = { "armor", "gun" },
}
