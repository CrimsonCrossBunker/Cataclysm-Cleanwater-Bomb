local ccb = require("ccb")

ccb.content.define_item {
    id = "bond_410",
    copy_from = "gun_base_handgun_manual",
    looks_like = "glock_17",
    name = ccb.content.text("double-barrel derringer"),
    description = ccb.content.text("The Bond Arms Derringer is a series of multi-barrel compact pistols.  Most commonly chambered for .45 Colt, with chambers long enough to accept .410 shotgun shells."),
    variant_kind = "gun",
    variants = {
        {
            id = "bond_410",
            name = ccb.content.text("Bond Arms Derringer"),
            description = ccb.content.text("Derringers are old-fashioned conceal carry weapons, usually sporting one or two barrels.  The Bond Arms Derringer is a modern series of multi-barrel compact pistols.  Most commonly chambered for .45 Colt, with chambers long enough to accept .410 shotgun shells.  Though, with modern handguns, derringers have become less and less practical as a conceal carry option."),
        },
    },
    mass = "566 g",
    volume = "79 ml",
    length = "158 mm",
    price = "415 USD",
    survival_price = "22 USD 50 cent",
    materials = { { id = "steel", portions = 9 }, { id = "rubber", portions = 1 } },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["45colt"] = 2, ["410shot"] = 2 } } },
    inheritance = { add = { flags = { "SINGLE_ACTION" } } },
    gun = {
        barrel_length = "76 mm",
        ammunition = { "45colt", "410shot" },
        dispersion = 520,
        clip_size = 2,
    },
}

-- 190.5mm + 40.6mm max OAL for 45LC. Revolvers just built different.
ccb.content.define_item {
    id = "colt_saa",
    copy_from = "gun_base_handgun_manual",
    looks_like = "sw_619",
    name = ccb.content.text("cowboy six-shooter"),
    description = ccb.content.text("A reproduction of an antique firearm, chambered in .45 Colt.  Due to the lack of a swing-out cylinder, each cartridge must be reloaded and ejected manually."),
    variant_kind = "gun",
    variants = {
        {
            id = "colt_saa",
            name = ccb.content.plural_text("Colt Single Action Army", "Colt Single Action Armies"),
            description = ccb.content.text("A famous revolver for many westerns, the Colt Single Action Army has seen plenty of military service, production ends, and production restarts.  While originally in a large amount of chamberings, it is mostly found in .45 Colt chamberings today.  While reloading is slow due to the lack of a swing-out cylinder, it was still much faster than earlier revolvers of the time thanks to using metallic cartridges.  It's also sometimes referred to as the Peacemaker, Model P, M1873 or shortened to SAA."),
            weight = 1,
        },
        {
            id = "colt_saa_repro",
            name = ccb.content.text("Uberti 1873 Cattleman"),
            description = ccb.content.text("This 7.5\" barreled Uberti Cattleman is a modern reproduction of the legendary Colt Single Action Army, or Colt Peacemaker, one of the first revolvers to use a modern self-contained cartridge.  Made famous by Westerns, it is still in demand for Cowboy Action Shooting, reenactors, and collectors.  Unlike modern revolvers, the cylinder cannot swing out for loading, and spent brass must be ejected one at a time."),
            weight = 10,
        },
    },
    mass = "1048 g",
    volume = "324 ml",
    length = "208 mm",
    price = "479 USD",
    survival_price = "25 USD",
    materials = { "steel", "wood" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["45colt"] = 6 } } },
    inheritance = { add = { flags = { "SINGLE_ACTION" } } },
    gun = {
        barrel_length = "231 mm",
        ammunition = { "45colt" },
        dispersion = 360,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "stock mount", count = 1 },
        },
        clip_size = 6,
    },
}

-- 76.2 + 63.5 for barrel length and chamber length, revolvers just built different
ccb.content.define_item {
    id = "taurus_judge",
    copy_from = "gun_base_handgun_manual",
    looks_like = "sw_619",
    name = ccb.content.text(".45/.410 shotshell revolver"),
    description = ccb.content.text("A stainless steel 5 shot revolver, capable of firing .410 shells or 45 Colt cartridges."),
    variant_kind = "gun",
    variants = {
        {
            id = "taurus_judge",
            name = ccb.content.text("Taurus Judge"),
            description = ccb.content.text("Marketed for home defense, the Taurus Judge is a 5 shot cylinder revolver, capable of firing .410 shotshells or .45 Colt cartridges out of it's 3 inch barrel.  While it doesn't compete ballistically with a proper rifle, or even a full length revolver, it's still a handy handgun against the undead and soon to be."),
        },
    },
    mass = "822 g",
    volume = "563 ml",
    length = "274 mm",
    price = "564 USD",
    survival_price = "20 USD",
    materials = { { id = "steel", portions = 9 }, { id = "rubber", portions = 1 } },
    pockets = {
        {
            kind = "MAGAZINE",
            ammunition = { ["410shot"] = 5, ["45colt"] = 5 },
            allowed_speedloaders = { "454_speedloader5" },
        },
    },
    gun = {
        barrel_length = "140 mm",
        ammunition = { "45colt", "410shot" },
        dispersion = 280,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
        clip_size = 5,
    },
}

ccb.content.define_item {
    id = "rifle_45_410",
    looks_like = "modular_ar15",
    copy_from = "gun_base_rifle_manual",
    name = ccb.content.text(".45 Colt/410 pipe rifle"),
    description = ccb.content.text("A home-made rifle.  It is simply a pipe attached to a stock, with a hammer to strike the single round it holds."),
    ascii_picture = "sm_pipe_gun",
    mass = "3200 g",
    volume = "1610 ml",
    length = "1000 mm",
    price = "100 USD",
    survival_price = "5 USD",
    materials = { "steel", "wood" },
    flags = { "RELOAD_EJECT", "EASY_CLEAN" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["45colt"] = 1, ["410shot"] = 1 } } },
    gun = {
        barrel_length = "610 mm",
        ammunition = { "45colt", "410shot" },
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
