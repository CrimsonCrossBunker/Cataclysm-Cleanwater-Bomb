local ccb = require("ccb")

ccb.content.define_item {
    id = "marlin_9a",
    looks_like = "modular_ar15",
    copy_from = "gun_base_rifle_manual",
    name = ccb.content.text("high capacity small game lever-action rifle"),
    description = ccb.content.text("A venerable .22 caliber lever-action rifle, with a 19-round tube magazine and a classic design that dates back over a century.  Generally used for the hunting of small game like rabbits, the strict taxonomic classification of zombies as 'small game' is debatable, but this decades-old weapon can still be counted upon to help manage the undead population."),
    variant_kind = "gun",
    variants = {
        {
            id = "marlin_9a",
            name = ccb.content.text("Marlin 39A rifle"),
            description = ccb.content.text("The oldest and longest-produced shoulder firearm in the world.  Though it only fires the weak .22 round, it is still highly accurate and has essentially no recoil."),
        },
    },
    ascii_picture = "marlin_39a",
    mass = "2948 g",
    volume = "2180 ml",
    length = "1029 mm",
    price = "230 USD",
    survival_price = "20 USD",
    materials = { "iron", "wood" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            ammunition = { ["22"] = 19 },
            allowed_speedloaders = { "marlin_tubeloader" },
        },
    },
    inheritance = { add = { flags = { "LEVER_ACTION" } } },
    gun = {
        barrel_length = "609 mm",
        range = 7,
        ammunition = { "22" },
        dispersion = 90,
        clip_size = 19,
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

ccb.content.define_item {
    id = "rifle_22",
    looks_like = "modular_ar15",
    copy_from = "gun_base_rifle_manual",
    name = ccb.content.text(".22 pipe rifle"),
    description = ccb.content.text("A homemade rifle.  While it is simply a pipe attached to a stock, with a hammer to strike the single round it holds, this single-shot rifle can still kill."),
    ascii_picture = "sm_pipe_gun",
    mass = "1953 g",
    volume = "1610 ml",
    length = "1000 mm",
    price = "100 USD",
    survival_price = "5 USD",
    materials = { "steel", "wood" },
    flags = { "RELOAD_EJECT", "EASY_CLEAN" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["22"] = 1 } } },
    gun = {
        barrel_length = "610 mm",
        ammunition = { "22" },
        dispersion = 550,
        durability = 6,
        blackpowder_tolerance = 60,
        loudness = 25,
        clip_size = 1,
        reload_time = 200,
        barrel_volume = "360 ml",
        mod_locations = { { id = "sling", count = 1 }, { id = "sights mount", count = 1 } },
    },
}

-- It is a blowback action, like most non-target, sporting rifles of this caliber.
ccb.content.define_item {
    id = "ruger_1022",
    looks_like = "modular_ar15",
    copy_from = "gun_base_22_semi_rifle",
    name = ccb.content.text("varmint rifle"),
    description = ccb.content.text("A lightweight and modular pistol caliber hunting carbine, firing the low power .22 LR cartridge.  Before the Cataclysm, a mix of high customizability, cheap ammunition, and low recoil made this a very popular rifle among civilian shooters."),
    variant_kind = "gun",
    variants = {
        {
            id = "ruger_1022",
            name = ccb.content.text("Ruger 10/22 rifle"),
            description = ccb.content.text("A combination of negligible recoil, high customization, and inexpensive ammunition made the Ruger 10/22 a popular choice among enthusiasts and small game hunters.  Even though it fires the weak .22 round, it's still perfectly capable of killing."),
        },
    },
    ascii_picture = "ruger1022",
    mass = "2270 g",
    volume = "2120 ml",
    length = "942 mm",
    price = "270 USD",
    materials = { "steel", "wood" },
    pockets = {
        {
            magazine_well = "34 ml",
            kind = "MAGAZINE_WELL",
            allowed_items = {
                "ruger1022mag", "ruger1022mag_15", "ruger1022bigmag", "ruger1022mag_30",
                "ruger1022mag_32", "ruger1022mag_55", "ruger1022mag_70", "ruger1022mag_110",
            },
        },
    },
    gun = {
        barrel_length = "470 mm",
        range = 6,
        dispersion = 110,
        barrel_volume = "500 ml",
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
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
    id = "ruger_1022_auto",
    copy_from = "ruger_1022",
    name = ccb.content.text("full-auto varmint rifle"),
    description = ccb.content.text("A handy and lightweight rifle, modified to fire semi and full auto."),
    variant_kind = "gun",
    variants = {
        {
            id = "ruger_1022_auto",
            name = ccb.content.text("full-auto Ruger 10/22 rifle"),
            description = ccb.content.text("A Ruger 10/22 modified post-Cataclysm to selective fire.  While the .22 round isn't very powerful, full auto makes it a lot more effective while still being controllable."),
        },
    },
    survival_price = "15 USD",
    gun = {
        modes = {
            { id = "DEFAULT", label = ccb.content.text("semi-auto"), quantity = 1 },
            { id = "AUTO", label = ccb.content.text("auto-rpm"), rpm = 1200 },
        },
    },
}

-- 47.498mm + 25.4mm max OAL for 22LR. Revolvers just built different.
ccb.content.define_item {
    id = "ruger_lcr_22",
    looks_like = "sw_619",
    copy_from = "gun_base_handgun_manual",
    name = ccb.content.text(".22 caliber revolver"),
    description = ccb.content.text("A comparatively dainty revolver, chambered for 8 tiny rounds of .22 LR."),
    variant_kind = "gun",
    variants = {
        {
            id = "ruger_lcr_22",
            name = ccb.content.text("Ruger LCR .22 revolver"),
            description = ccb.content.text("A compact, double-action-only revolver designed for easy concealment, with a stainless steel cylinder and aluminum frame."),
        },
    },
    mass = "422 g",
    volume = "301 ml",
    length = "192 mm",
    price = "545 USD",
    survival_price = "10 USD",
    materials = { "steel", "aluminum", "plastic" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            ammunition = { ["22"] = 8 },
            allowed_speedloaders = { "22_speedloader8" },
        },
    },
    gun = {
        barrel_length = "73 mm",
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
        ammunition = { "22" },
        clip_size = 8,
    },
}

-- Was the sig mosquito, has been renamed to the more common GSG firefly
ccb.content.define_item {
    id = "sig_mosquito",
    looks_like = "glock_17",
    copy_from = "gun_base_22_semi_pistol",
    name = ccb.content.text("Firefly training pistol"),
    description = ccb.content.text("A medium sized, .22 caliber semi-automatic pistol, for training with a pistol similar to more powerful pistols.  Built from aluminum and polymer components, the weapon is lightweight and concealable, but its chambering is not very powerful."),
    variant_kind = "gun",
    variants = {
        {
            id = "sig_mosquito",
            name = ccb.content.plural_text("GSG Firefly", "GSG Fireflies"),
            description = ccb.content.text("The GSG firefly is a .22 semi-automatic handgun.  While the GSG Firefly started off as the SIG Mosquito, after the Mosquito ceased production, German Sport Guns picked it up and renamed it to the Firefly."),
        },
    },
    ascii_picture = "sig_mosquito",
    mass = "720 g",
    volume = "467 ml",
    length = "214 mm",
    price = "360 USD",
    materials = { "aluminum", "steel", "plastic" },
    pockets = { { magazine_well = "250 ml", kind = "MAGAZINE_WELL", allowed_items = { "mosquitomag" } } },
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
    id = "walther_p22",
    copy_from = "gun_base_22_semi_pistol",
    looks_like = "glock_17",
    name = ccb.content.text("Walther training pistol"),
    description = ccb.content.text("A dainty training pistol offered by the Walther Arms company, making use of the .22 LR cartridge, for training on a pistol very similar to more powerful pistols."),
    variant_kind = "gun",
    variants = {
        {
            id = "walther_p22",
            name = ccb.content.text("Walther P22 pistol"),
            description = ccb.content.text("The Walther P22 is a blowback operated semi-automatic pistol intended for training with a platform very similar to more defensive handguns.  It is about half the size of most Walthers.  It is made mostly with plastic, with the slide and key components (other than the barrel) being made of die-cast zinc alloy."),
        },
    },
    mass = "480 g",
    volume = "290 ml",
    length = "183 mm",
    price = "85 USD",
    materials = { "plastic", "zinc", "steel" },
    pockets = { { magazine_well = "126 ml", kind = "MAGAZINE_WELL", allowed_items = { "wp22mag" } } },
    gun = {
        barrel_length = "87 mm",
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

-- Stats are from the 5.5 inch target version https://ruger.com/products/markIVTarget/specSheets/40101.html
ccb.content.define_item {
    id = "ruger_mk4",
    copy_from = "gun_base_22_semi_pistol",
    looks_like = "glock_17",
    name = ccb.content.text("Ruger target pistol"),
    description = ccb.content.text("A light and handy .22 LR handgun from Ruger, this handgun is one of the most popular .22 handguns ever created."),
    variant_kind = "gun",
    variants = {
        {
            id = "ruger_mk2",
            name = ccb.content.text("Ruger Mark II"),
            description = ccb.content.text("The 2nd version of the Ruger Standard, which replaced production of the Standard in 1982 and continued until 2005 with the main feature of having adjustable sights.  Features a 5.5 inch barrel and feeds from a 10 round magazine."),
            weight = 17,
        },
        {
            id = "ruger_mk3",
            name = ccb.content.text("Ruger Mark III"),
            description = ccb.content.text("The 3rd version of the Ruger Standard, which replaced production of the Mark II in 2005 and continued until 2016.  Features a 5.5 inch barrel and feeds from a 10 round magazine."),
            weight = 19,
        },
        {
            id = "ruger_mk4",
            name = ccb.content.text("Ruger Mark IV"),
            description = ccb.content.text("The 4th, and most modern version of the Ruger Standard.  Still in production since 2016, and has a simplified disassembly feature.  Has a 5.5 inch barrel and feeds from a 10 round magazine."),
            weight = 135,
        },
    },
    mass = "1001 g",
    volume = "392 ml",
    price = "679 USD",
    length = "266 mm",
    materials = { "steel", "plastic", "aluminum" },
    pockets = {
        {
            rigid = false,
            magazine_well = "96 ml",
            kind = "MAGAZINE_WELL",
            allowed_items = { "ruger_mk4_mag" },
        },
    },
    gun = {
        barrel_length = "140 mm",
        dispersion = 400,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "rossi_gallery",
    looks_like = "modular_ar15",
    copy_from = "gun_base_rifle_manual",
    name = ccb.content.text("pump action varmint rifle"),
    description = ccb.content.text("A lightweight, wood framed pump action rifle, holding 15 rounds of .22 with an 18 inch barrel.  While pump actions tend to be largely shotguns, they can be made in calibers such as .22 LR."),
    variant_kind = "gun",
    variants = {
        {
            id = "rossi_gallery",
            name = ccb.content.plural_text("Rossi Gallery", "Rossi Galleries"),
            description = ccb.content.text("A modern take on the Winchester 1890, the Rossi Gallery is a .22 LR rifle, notably using a pump action.  Much like a pump action shotgun, the magazine tube is below its 18 inch barrel and can hold 15 rounds.  While pump actions are quite often associated with shotguns, the mechanism can be applied to rifles as well, though in practice it's limited to .22 LR."),
        },
    },
    mass = "2344 g",
    volume = "2054 ml",
    length = "913 mm",
    price = "394 USD",
    survival_price = "10 USD",
    materials = { "steel", "wood", "aluminum" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["22"] = 15 } } },
    inheritance = { add = { flags = { "PUMP_ACTION" } } },
    gun = {
        barrel_length = "457 mm",
        range = 7,
        ammunition = { "22" },
        dispersion = 140,
        clip_size = 15,
        mod_locations = {
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "sights mount", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock mount", count = 1 },
            { id = "stock accessory", count = 2 },
        },
    },
}

-- barrel length (165mm) + cylinder length (25mm)
ccb.content.define_item {
    id = "rough_rider_pistol",
    copy_from = "gun_base_handgun_manual",
    name = ccb.content.text(".22 six-shooter"),
    description = ccb.content.text("A revolver chambered in .22 LR, with 6 shots and a 6.5 inch barrel."),
    ascii_picture = "redhawk",
    mass = "947 g",
    volume = "442 ml",
    length = "318 mm",
    price = "165 USD 99 cent",
    survival_price = "10 USD",
    materials = { "steel" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["22"] = 6 } } },
    variant_kind = "gun",
    variants = {
        {
            id = "rough_rider_pistol",
            name = ccb.content.plural_text("Heritage Rough Rider 6.5\"", "Heritage Rough Riders 6.5\""),
            description = ccb.content.text("A cheap, single action revolver chambered in .22 LR.  While it makes for a handy plinking gun, the single action mechanism, size of the firearm, combined with the lack of a swing out cylinder makes for a less than ideal zombie fighting handgun."),
        },
    },
    inheritance = { add = { flags = { "SINGLE_ACTION" } } },
    gun = {
        barrel_length = "190 mm",
        ammunition = { "22" },
        dispersion = 380,
        reload_time = 250,
        clip_size = 6,
        mod_locations = {
            { id = "mechanism", count = 2 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}

-- barrel length (229mm) + cylinder length (25mm)
ccb.content.define_item {
    id = "rough_rider_pistol_9",
    copy_from = "rough_rider_pistol",
    name = ccb.content.text("large .22 six-shooter"),
    description = ccb.content.text("A revolver chambered in .22 LR, with 6 shots and a 9 inch barrel."),
    mass = "1046 g",
    volume = "456 ml",
    length = "386 mm",
    price = "288 USD 99 cent",
    variant_kind = "gun",
    variants = {
        {
            id = "rough_rider_pistol",
            name = ccb.content.plural_text("Heritage Rough Rider 9\"", "Heritage Rough Riders 9\""),
            description = ccb.content.text("A cheap, single action revolver chambered in .22 LR.  While it makes for a handy plinking gun, the single action mechanism, size of the firearm, combined with the lack of a swing out cylinder makes for a less than ideal zombie fighting handgun, even with the slightly increased performance from the longer barrel."),
        },
    },
    gun = { barrel_length = "254 mm", range = 2, dispersion = 340 },
}

-- Based on https://www.browning.com/products/firearms/pistols/1911-22/1911-22-a1.html
ccb.content.define_item {
    id = "1911_22",
    copy_from = "gun_base_22_semi_pistol",
    looks_like = "1911",
    name = ccb.content.text(".22 1911 pistol"),
    description = ccb.content.text("A 1911 in .22 LR, with a 4 1/4\" barrel, and feeding from 10 round magazines."),
    ascii_picture = "m1911",
    mass = "425 g",
    volume = "369 ml",
    length = "212 mm",
    price = "749 USD 99 cent",
    survival_price = "10 USD",
    materials = { "steel" },
    pockets = { { magazine_well = "40 ml", kind = "MAGAZINE_WELL", allowed_items = { "1911_22_mag" } } },
    variant_kind = "gun",
    variants = {
        {
            id = "1911_22",
            name = ccb.content.text("1911-22"),
            description = ccb.content.text("A 1911 handgun with \"1911-22\" stamped on the slide.  While .22 LR 1911s were first devised as a training aid for US soldiers, it found large civilian use from concealed carry to plinking thanks to the readily available ammunition and familiar platform."),
        },
    },
    gun = {
        barrel_length = "108 mm",
        dispersion = 320,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}

-- Stats from https://rossiusa.com/rifles/lever-action-rifles/313-rio-bravo-wood-matte-black-22-lr-18-in
ccb.content.define_item {
    id = "rio_bravo",
    copy_from = "gun_base_rifle_manual",
    looks_like = "marlin_9a",
    name = ccb.content.text("small game lever-action rifle"),
    description = ccb.content.text("A .22 Long Rifle lever-action rifle, which holds 15 rounds of ammo.  While quite useful against small game, its effectiveness isn't as great against the undead."),
    variant_kind = "gun",
    variants = {
        {
            id = "rio_bravo",
            name = ccb.content.text("Rossi Rio Bravo"),
            description = ccb.content.text("A modern .22 LR lever-action rifle, the Rio Bravo features an 18\" barrel with 15 rounds of ammo in its tube magazine, which is loaded from the front of the rifle.  The mechanical origins date back decades, being based off of Rossi's R92 series of rifles which themselves were based off of the Winchester 1892."),
        },
    },
    ascii_picture = "marlin_39a",
    mass = "2345 g",
    volume = "2101 ml",
    length = "931 mm",
    price = "404 USD 99 cent",
    survival_price = "10 USD",
    materials = { "steel", "wood", "aluminum" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["22"] = 15 } } },
    inheritance = { add = { flags = { "LEVER_ACTION" } } },
    gun = {
        barrel_length = "457 mm",
        range = 5,
        ammunition = { "22" },
        dispersion = 110,
        clip_size = 15,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 1 },
            { id = "stock mount", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
    },
}

-- Stats from https://www.henryusa.com/rifles/golden-boy/
ccb.content.define_item {
    id = "henry_golden_boy",
    copy_from = "gun_base_rifle_manual",
    looks_like = "marlin_9a",
    name = ccb.content.text("small game lever-action rifle"),
    description = ccb.content.text("A .22 Long Rifle lever-action rifle, which holds 16 rounds of ammo.  While quite useful against small game, its effectiveness isn't as great against the undead."),
    variant_kind = "gun",
    variants = {
        {
            id = "henry_golden_boy",
            name = ccb.content.text("Henry Golden Boy"),
            description = ccb.content.text("A modern .22 LR lever-action rifle, the Henry Golden Boy features an 20\" octagonal barrel with 16 rounds of ammo in its tube magazine, which is loaded from the front of the rifle.  It fairly resembles the original Henry Model 1860 with its brass colored receiver, though with wooden furniture at the front, and without a doubt using modern manufacturing."),
        },
    },
    ascii_picture = "marlin_39a",
    mass = "3062 g",
    volume = "2116 ml",
    length = "979 mm",
    price = "648 USD",
    survival_price = "11 USD",
    materials = { "steel", "wood", "aluminum", "brass" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["22"] = 16 } } },
    inheritance = { add = { flags = { "LEVER_ACTION" } } },
    gun = {
        barrel_length = "580 mm",
        range = 6,
        ammunition = { "22" },
        dispersion = 100,
        clip_size = 16,
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
    },
}

ccb.content.define_item {
    id = "marlin60",
    copy_from = "gun_base_22_semi_rifle",
    looks_like = "ruger1022",
    name = ccb.content.text("tube fed varmint rifle"),
    description = ccb.content.text("A lightweight and modular pistol caliber hunting carbine, firing the low power .22 LR cartridge.  Before the Cataclysm, a mix of high customizability, cheap ammunition, and low recoil made this a very popular varmint rifle among civilian shooters."),
    variant_kind = "gun",
    variants = {
        {
            id = "marlin60",
            name = ccb.content.text("Marlin Model 60"),
            description = ccb.content.text("The Model 60 is a semi-automatic rifle chambered in .22 LR, and looks awfully familiar to a 10/22.  However, instead of a detachable magazine, it features a tubular magazine below the barrel.  While out of production, a large number of them have been made since the 60s, making it a very commonplace rifle."),
        },
    },
    ascii_picture = "ruger1022",
    mass = "2500 g",
    volume = "2100 ml",
    length = "953 mm",
    price = "250 USD",
    materials = { "steel", "wood" },
    flags = { "RELOAD_ONE" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["22"] = 14 } } },
    gun = {
        barrel_length = "483 mm",
        range = 6,
        dispersion = 110,
        clip_size = 14,
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
    },
}

-- barrel length (153mm) + cylinder length (25mm)
ccb.content.define_item {
    id = "sw617",
    copy_from = "gun_base_handgun_manual",
    name = ccb.content.text("high capacity revolver"),
    description = ccb.content.text("A revolver chambered in .22 LR, with 10 shots and a 6 inch barrel."),
    ascii_picture = "redhawk",
    mass = "1307 g",
    volume = "638 ml",
    length = "325 mm",
    price = "979 USD",
    survival_price = "7 USD 50 cent",
    materials = { "steel" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["22"] = 10 } } },
    variant_kind = "gun",
    variants = {
        {
            id = "sw617",
            name = ccb.content.text("S&W 617 revolver"),
            description = ccb.content.text("The S&W 617 is a fine revolver, chambered in .22 LR.  However, instead of more common 6 rounds revolvers come in, this revolver has a 10 round capacity cylinder.  While still a revolver, and to boot a revolver in .22 LR, 10 is still bigger than 6."),
        },
    },
    gun = {
        barrel_length = "178 mm",
        ammunition = { "22" },
        dispersion = 300,
        clip_size = 10,
        mod_locations = {
            { id = "mechanism", count = 2 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}

-- Based on https://ruger.com/products/sr22Pistol/specSheets/3600.html
ccb.content.define_item {
    id = "sr22",
    copy_from = "gun_base_22_semi_pistol",
    name = ccb.content.text(".22 plinking handgun"),
    description = ccb.content.text("A small handgun with a short barrel.  Feeds from 10 round magazines."),
    mass = "496 g",
    volume = "369 ml",
    length = "205 mm",
    price = "559 USD",
    materials = { "steel" },
    pockets = { { magazine_well = "40 ml", kind = "MAGAZINE_WELL", allowed_items = { "sr22_mag" } } },
    variant_kind = "gun",
    variants = {
        {
            id = "sr22",
            name = ccb.content.text("Ruger SR22"),
            description = ccb.content.text("A very popular handgun, the SR22 is a more conventional pistol than Ruger's other famous .22 LR handguns, the Ruger Standards.  While .22 LR is still capable of killing, the very short barrel brings that into question."),
        },
    },
    gun = {
        barrel_length = "89 mm",
        dispersion = 320,
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
    id = "glock_44",
    copy_from = "gun_base_22_semi_pistol",
    looks_like = "glock19",
    name = ccb.content.text("Glock 44 pistol"),
    description = ccb.content.text("A Glock chambered in .22 LR.  While effective against paper targets and rodents, it will struggle against the walking dead."),
    mass = "358 g",
    volume = "398 ml",
    length = "212 mm",
    price = "380 USD",
    survival_price = "10 USD",
    materials = { "steel", "plastic" },
    pockets = { { magazine_well = "40 ml", kind = "MAGAZINE_WELL", allowed_items = { "glock44_mag" } } },
    gun = {
        barrel_length = "108 mm",
        dispersion = 580,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}

-- Stats from https://savagearms.com/firearms/sku/13775
ccb.content.define_item {
    id = "savage_rascal",
    copy_from = "gun_base_rifle_manual",
    looks_like = "marlin_9a",
    name = ccb.content.text("small game single shot rifle"),
    description = ccb.content.text("A .22 Long Rifle rifle that chambers just one shot.  Its main use is for the youth, and not much else.  God help you if you hope to use this thing to a meaningful effect."),
    variant_kind = "gun",
    variants = {
        {
            id = "savage_rascal",
            name = ccb.content.text("Savage Rascal"),
            description = ccb.content.text("A .22 Long Rifle rifle that chambers just one shot.  Its main use is for the youth, and not much else.  God help you if you hope to use this thing to a meaningful effect."),
        },
    },
    mass = "1230 g",
    volume = "1284 ml",
    length = "783 mm",
    price = "169 USD",
    survival_price = "1 USD",
    materials = { "steel", "plastic" },
    melee_damage = { bash = 7 },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["22"] = 1 } } },
    gun = {
        barrel_length = "410 mm",
        range = 4,
        ammunition = { "22" },
        dispersion = 100,
        clip_size = 1,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 1 },
            { id = "stock", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
    },
}

-- Based on https://www.smith-wesson.com/product/performance-center-m-p-15-22-sport-compliant
ccb.content.define_item {
    id = "mp_15_22",
    looks_like = "modular_ar15",
    copy_from = "gun_base_22_semi_rifle",
    name = ccb.content.text("modern varmint rifle"),
    description = ccb.content.text("Resembling a military rifle, this firearm is made from polymer.  Despite its looks, it only shoots .22 LR in a semi-automatic fashion."),
    variant_kind = "gun",
    variants = {
        {
            id = "mp_15_22",
            name = ccb.content.text("M&P 15-22"),
            description = ccb.content.text("A .22 LR version of the M&P 15, this rifle resembles an AR-15 in form and function, but does not have the ability for compatible uppers or lowers."),
        },
    },
    mass = "2540 g",
    volume = "3318 ml",
    length = "942 mm",
    price = "779 USD",
    materials = { "steel", "plastic" },
    pockets = { { magazine_well = "34 ml", kind = "MAGAZINE_WELL", allowed_items = { "mp1522_mag" } } },
    gun = {
        barrel_length = "406 mm",
        dispersion = 110,
        barrel_volume = "500 ml",
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail", count = 1 },
            { id = "sights", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
    },
}
