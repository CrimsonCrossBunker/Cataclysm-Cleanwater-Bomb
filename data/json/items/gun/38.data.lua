local ccb = require("ccb")

-- Volume+barrel length based off a Bond Arms derringer. with extra length in the barrel.
ccb.content.define_item {
    id = "2_shot_special",
    copy_from = "gun_base_handgun_manual",
    looks_like = "glock_17",
    name = ccb.content.text("double barrel .38 pistol"),
    description = ccb.content.text("A crudely made double barrel pistol firing .38 Special ammo.  Unfortunately, the name is less about the double barrels and more about the number of shots you'll get before it breaks down on you."),
    ascii_picture = "2_shot_special",
    mass = "750 g",
    volume = "414 ml",
    length = "475 mm",
    price = "20 USD",
    survival_price = "5 USD",
    materials = { "steel" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["38"] = 2 } } },
    inheritance = { add = { flags = { "SINGLE_ACTION" } } },
    gun = {
        barrel_length = "168 mm",
        ammunition = { "38" },
        damage = { type = "bullet", amount = -1 },
        dispersion = 620,
        mod_locations = { { id = "stock mount", count = 1 } },
        durability = 3,
        clip_size = 2,
        reload_time = 200,
    },
}

-- 101.6mm + 39.4mm max OAL for 38spl. Revolvers just built different.
ccb.content.define_item {
    id = "model_10_revolver",
    copy_from = "gun_base_handgun_manual",
    looks_like = "sw_619",
    name = ccb.content.text("six-shooter"),
    description = ccb.content.text("A six-shot revolver, produced since 1899 and known as the most popular handgun of the 20th century.  It has a swing-out cylinder for ease of reloading."),
    variant_kind = "gun",
    variants = {
        {
            id = "model_10_revolver",
            name = ccb.content.text("S&W Model 10 revolver"),
            description = ccb.content.text("The Model 10 is one of the oldest firearm models still in production, and most produced handguns, with production dating back to 1899.  Starting life as the Model 1899 Hand Ejector, it only picked up the current name of Model 10 in the 1950s.  Despite .38 Special and .357 Magnum being the same caliber, Model 10s were produced to handle blackpowder loads, and while modern smokeless loads of .38 Special work fine, .357 Magnum could cause the Model 10 to catastrophically fail."),
        },
    },
    mass = "975 g",
    volume = "402 ml",
    length = "252 mm",
    price = "424 USD",
    survival_price = "10 USD",
    materials = { "steel", "wood" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            ammunition = { ["38"] = 6 },
            allowed_speedloaders = { "38_speedloader6" },
        },
    },
    gun = {
        barrel_length = "141 mm",
        ammunition = { "38" },
        dispersion = 480,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
        clip_size = 6,
    },
}

ccb.content.define_item {
    id = "rifle_38",
    copy_from = "gun_base_rifle_manual",
    looks_like = "modular_ar15",
    name = ccb.content.text(".38 Special pipe rifle"),
    description = ccb.content.text("A home-made rifle.  It is simply a pipe attached to a stock, with a hammer to strike the single round it holds."),
    ascii_picture = "ps_pipe_gun",
    mass = "2114 g",
    volume = "1610 ml",
    length = "100 cm",
    price = "100 USD",
    survival_price = "5 USD",
    materials = { "steel", "wood" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["38"] = 1 } } },
    gun = {
        ammunition = { "38" },
        dispersion = 550,
        durability = 6,
        loudness = 25,
        clip_size = 1,
        reload_time = 200,
        barrel_volume = "360 ml",
        barrel_length = "600 mm",
        mod_locations = { { id = "sling", count = 1 }, { id = "sights mount", count = 1 } },
    },
}

-- 47mm + 39.4mm max OAL for 38spl. Revolvers just built different.
ccb.content.define_item {
    id = "ruger_lcr_38",
    copy_from = "gun_base_handgun_manual",
    looks_like = "sw_619",
    name = ccb.content.text("conceal-carry five-shooter"),
    description = ccb.content.text("A compact, double-action-only revolver designed for easy concealment, with a stainless steel cylinder and aluminum frame."),
    variant_kind = "gun",
    variants = {
        {
            id = "ruger_lcr_38",
            name = ccb.content.text("Ruger LCR"),
            description = ccb.content.text("The Ruger LCR (Lightweight Compact Revolver) is a modern revolver, starting production in just 2010.  It's a lightweight, aluminum-framed revolver, designed for conceal carry with its double-action-only trigger and compact size.  Due to the double-action trigger, it is more possible to carry it in your pocket instead of a holster due to the heavy trigger, but still ill-advised."),
        },
    },
    mass = "382 g",
    volume = "321 ml",
    length = "192 mm",
    price = "545 USD",
    survival_price = "10 USD",
    materials = { "steel", "aluminum", "plastic" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            ammunition = { ["38"] = 5 },
            allowed_speedloaders = { "38_speedloader5" },
        },
    },
    gun = {
        barrel_length = "86 mm",
        ammunition = { "38" },
        dispersion = 480,
        clip_size = 5,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}

-- This looks like a classic revolver, from a western
-- This is the Colt Python 2020 6-inch version.
-- omg twd reference :O
-- Price of one according to colt's own website. Goddamn.
ccb.content.define_item {
    id = "colt_python",
    copy_from = "gun_base_handgun_manual",
    looks_like = "sw_619",
    name = ccb.content.plural_text("classic .357 revolver", "classic .357 revolver"),
    description = ccb.content.text("A six inch revolver chambered in .357 Magnum/.38 Special.  Favorite of sheriffs and post-Cataclysm survivor group leaders."),
    mass = "1300 g",
    volume = "703 ml",
    length = "292 mm",
    price = "1 kUSD 599 USD",
    survival_price = "20 USD",
    materials = { "steel", "wood" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            ammunition = { ["357mag"] = 6, ["38"] = 6 },
            allowed_speedloaders = { "38_speedloader6" },
        },
    },
    variant_kind = "gun",
    variants = {
        {
            id = "colt_python",
            name = ccb.content.plural_text("Colt Python", "Colt Python"),
            description = ccb.content.text("Made by Colt, this six inch six-shooter is one of the most lauded revolvers ever produced.  Can fire .38 Special and .357 Magnum."),
        },
    },
    gun = {
        barrel_length = "152 mm",
        ammunition = { "357mag", "38" },
        dispersion = 280,
        clip_size = 6,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}

-- took 5mm off `longest_side` so it can fit regular holsters
-- barrel length (152mm) + cylinder length (40mm)
ccb.content.define_item {
    id = "sw_619",
    copy_from = "gun_base_handgun_manual",
    name = ccb.content.plural_text("7-shot .357 revolver", "7-shot .357 revolver"),
    description = ccb.content.text("A revolver chambered in .357, with a 6 inch barrel and 7 shots."),
    ascii_picture = "sw_610",
    mass = "1280 g",
    volume = "760 ml",
    length = "300 mm",
    price = "980 USD",
    survival_price = "12 USD 50 cent",
    materials = { "steel", "plastic" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            ammunition = { ["357mag"] = 7, ["38"] = 7 },
            allowed_speedloaders = { "38_speedloader" },
        },
    },
    variant_kind = "gun",
    variants = {
        {
            id = "sw_619",
            name = ccb.content.plural_text("S&W 686 Plus revolver", "S&W 686 Plus revolver"),
            description = ccb.content.text("Introduced in the 90's, Smith & Wesson's model 686 'Plus' features a robust stainless steel frame, an adjustable front sight and a seventh shot that's sure to save your life."),
        },
    },
    gun = {
        barrel_length = "192  mm",
        ammunition = { "357mag", "38" },
        dispersion = 320,
        clip_size = 7,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "chiappa_rhino",
    copy_from = "gun_base_handgun_manual",
    name = ccb.content.plural_text(".357 revolver", ".357 revolver"),
    description = ccb.content.text("A revolver chambered in .357, with a 6 inch barrel and 6 shots."),
    looks_like = "sw_619",
    price = "1 kUSD 800 USD",
    survival_price = "80 USD",
    materials = { "steel", "wood" },
    mass = "936 g",
    volume = "700 ml",
    length = "267 mm",
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            ammunition = { ["357mag"] = 6, ["38"] = 6 },
            allowed_speedloaders = { "38_speedloader6" },
        },
    },
    variant_kind = "gun",
    variants = {
        {
            id = "chiappa_rhino",
            name = ccb.content.text("Chiappa Rhino"),
            description = ccb.content.text("An innovative, futuristic looking revolver designed by Emilio Ghisoni after developing the Mateba, its most distinctive feature is its barrel, aligned with the bottom chamber of its hexagonal cylinder to alleviate muzzle flip."),
        },
    },
    gun = {
        ammunition = { "357mag", "38" },
        barrel_length = "152 mm",
        dispersion = 300,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
        clip_size = 6,
    },
}

-- 72.6mm + 39.4mm max OAL for 38spl. Revolvers just built different.
-- Dimensions are 19.3x13.3x3.7 cm, with the final result trimmed by 35% to account for the inherent empty spaces.
-- Yes, the revolver is actually 193 mm long rather than 19 cm, but I deemed not having it fit in a standard-sized pocket because of a 3 mm difference to be silly.
-- 3 to 3.5-inch groups at 10 yards shooting off-handed: https://www.shootingillustrated.com/content/review-rossi-rp-63-revolver/
ccb.content.define_item {
    id = "rp63",
    copy_from = "gun_base_handgun_manual",
    looks_like = "sw_619",
    name = ccb.content.plural_text(".357 snub-nosed revolver", ".357 snub-nosed revolver"),
    description = ccb.content.text("Short, stout, and compact, this stainless steel revolver is a handy dispenser of .357-magnum, or lower-power .38-caliber, cartridges.  Six rounds fit within the weapon, though its small stature and short barrel ensure that each pull of the trigger is all but a pyrotechnic spectacle: flashy, loud, and jumpy."),
    variant_kind = "gun",
    variants = {
        {
            id = "rp63",
            name = ccb.content.text("Rossi RP63 revolver"),
            description = ccb.content.text("A small frame, stainless-steel Brazilian wheel gun with rubberized grips, a serrated front sight, and a satin finish, boasting a 6-round cylinder of .357-magnum persuasion.  Affordable, before the world collapsed, and confidently asserted by Rossi themselves to be the ideal carry gun for its rounded butt and 3-inch barrel, you aren't wholly sure that such assertions accounted for zombies."),
        },
    },
    mass = "774 g",
    volume = "614 ml",
    length = "19 cm",
    price = "469 USD 99 cent",
    survival_price = "10 USD 40 cent",
    materials = { "steel", "plastic" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            ammunition = { ["357mag"] = 6, ["38"] = 6 },
            allowed_speedloaders = { "38_speedloader6" },
        },
    },
    gun = {
        barrel_length = "116 mm",
        ammunition = { "357mag", "38" },
        dispersion = 350,
        clip_size = 6,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}

-- Stats from the .357 Short Rifle https://www.uberti-usa.com/cartridge-rifles/1873-rifle-and-carbine
ccb.content.define_item {
    id = "uberti_1873",
    copy_from = "gun_base_rifle_manual",
    looks_like = "modular_ar15",
    name = ccb.content.text("reproduction .357 lever-action rifle"),
    description = ccb.content.text("This fine lever-action rifle is chambered in the powerful .357 Magnum cartridge, with an 20\" barrel with a tube-fed magazine.  Go get 'em cowboy!"),
    variant_kind = "gun",
    variants = {
        {
            id = "uberti_1873",
            name = ccb.content.text("Uberti 1873"),
            description = ccb.content.text("The 1873 is a rifle platform developed all the way in, unsurprisingly, 1873.  This one is a fairly faithful Uberti reproduction, although the original 1873s pre-dated .357 Magnum, and even .38 Special.  This one has a case-hardened finish, wood furniture, and octagonal barrel."),
        },
    },
    mass = "3719 g",
    volume = "2718 ml",
    length = "1117 mm",
    price = "1429 USD",
    survival_price = "15 USD",
    materials = { "steel", "wood" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["357mag"] = 10, ["38"] = 10 } } },
    inheritance = { add = { flags = { "LEVER_ACTION" } } },
    gun = {
        barrel_length = "508 mm",
        range = 7,
        ammunition = { "357mag", "38" },
        dispersion = 140,
        clip_size = 10,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock mount", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
    },
}

-- Stats from https://rossiusa.com/rifles/lever-action-rifles/373-r92-traditional-hardwood-stock-black-357-mag-38-special-p-20-in
ccb.content.define_item {
    id = "rossi_r92_357_20",
    copy_from = "gun_base_rifle_manual",
    looks_like = "modular_ar15",
    name = ccb.content.text("long-barreled .357 lever-action rifle"),
    description = ccb.content.text("This lever-action rifle is chambered in the powerful .357 Magnum cartridge, with an 20\" barrel with a tube-fed magazine.  Go get 'em cowboy!"),
    variant_kind = "gun",
    variants = {
        {
            id = "rossi_r92_357_20",
            name = ccb.content.plural_text("Rossi R92 20\"", "Rossi R92s 20\""),
            description = ccb.content.text("The R92 is a widely successful line of lever-action rifles from Rossi, featuring a wide array of different calibers and barrel lengths.  These aim to be less reproductions of old rifles, but rather modern takes on the lever-action formula.  This particular one features wooden furniture, a 20\" barrel, and 10 rounds of .357 Magnum or .38 Special."),
        },
    },
    mass = "2804 g",
    volume = "1986 ml",
    length = "946 mm",
    price = "840 USD 99 cent",
    survival_price = "15 USD",
    materials = { "steel", "wood" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["357mag"] = 10, ["38"] = 10 } } },
    inheritance = { add = { flags = { "LEVER_ACTION" } } },
    gun = {
        barrel_length = "508 mm",
        range = 7,
        ammunition = { "357mag", "38" },
        dispersion = 140,
        clip_size = 10,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock mount", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
    },
}

-- Stats from https://rossiusa.com/rifles/lever-action-rifles/372-r92-hardwood-357-mag-38-special-p-polished-black-oxide-16-in
ccb.content.define_item {
    id = "rossi_r92_357_16",
    copy_from = "gun_base_rifle_manual",
    looks_like = "modular_ar15",
    name = ccb.content.text(".357 lever-action rifle"),
    description = ccb.content.text("This fine lever-action rifle is chambered in the powerful .357 Magnum cartridge, with an 16\" barrel with a tube-fed magazine.  Go get 'em cowboy!"),
    variant_kind = "gun",
    variants = {
        {
            id = "rossi_r92_357_16",
            name = ccb.content.plural_text("Rossi R92 16\"", "Rossi R92s 16\""),
            description = ccb.content.text("The R92 is a widely successful line of lever-action rifles from Rossi, featuring a wide array of different calibers and barrel lengths.  These aim to be less reproductions of old rifles, but rather modern takes on the lever-action formula.  This particular one features wooden furniture, a 16\" barrel, and 8 rounds of .357 Magnum or .38 Special."),
        },
    },
    mass = "2662 g",
    volume = "1909 ml",
    length = "843 mm",
    price = "833 USD 99 cent",
    survival_price = "15 USD",
    materials = { "steel", "wood" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["357mag"] = 8, ["38"] = 8 } } },
    inheritance = { add = { flags = { "LEVER_ACTION" } } },
    gun = {
        barrel_length = "406 mm",
        range = 5,
        ammunition = { "357mag", "38" },
        dispersion = 140,
        clip_size = 8,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock mount", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
    },
}

-- 47.8mm + 30.5mm max OAL for 38spl. Revolvers just built different.
ccb.content.define_item {
    id = "sw642",
    copy_from = "gun_base_handgun_manual",
    looks_like = "sw_619",
    name = ccb.content.plural_text(".38 conceal carry revolver", ".38 conceal carry revolver"),
    description = ccb.content.text("This .38 revolver is quite small and lightweight, due to its short barrel and aluminum material."),
    variant_kind = "gun",
    variants = {
        {
            id = "sw642",
            name = ccb.content.text("S&W 642 revolver"),
            description = ccb.content.text("A modern version of the Airweight, the 642 is a lightweight .38 caliber revolver, made with an aluminum frame."),
        },
    },
    mass = "414 g",
    volume = "301 ml",
    length = "194 mm",
    price = "539 USD",
    survival_price = "10 USD",
    materials = { "steel", "plastic", "aluminum" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            ammunition = { ["38"] = 5 },
            allowed_speedloaders = { "38_speedloader5" },
        },
    },
    gun = {
        barrel_length = "78 mm",
        ammunition = { "38" },
        dispersion = 350,
        clip_size = 5,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}
