local ccb = require("ccb")

ccb.content.define_item {
    id = "1895sbl",
    copy_from = "gun_base_rifle_manual",
    looks_like = "modular_ar15",
    name = ccb.content.text("lever-action hunting rifle"),
    description = ccb.content.text("A handy but powerful lever-action rifle chambered for .45-70 Government.  Designed for wilderness guides for defense against large predators such as grizzly bears, moose, and dinosaurs."),
    variant_kind = "gun",
    variants = {
        {
            id = "1895sbl",
            name = ccb.content.text("Marlin 1895 SBL"),
            description = ccb.content.text("A handy but powerful lever-action rifle chambered for .45-70 Government, the Marlin 1895 SBL was designed as a guide rifle, a rifle designed to defend against animals such as bears in the wilderness.  While advertised as capable of defending against T-Rex, there has yet been any testing against actual T-Rexes, and hopefully remains that way."),
        },
    },
    mass = "3629 g",
    volume = "1829 ml",
    length = "943 mm",
    price = "1 kUSD",
    survival_price = "25 USD",
    materials = { "steel", "wood" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["4570"] = 6 } } },
    inheritance = { add = { flags = { "LEVER_ACTION" } } },
    gun = {
        barrel_length = "485 mm",
        ammunition = { "4570" },
        damage = { type = "bullet", amount = 3 },
        dispersion = 200,
        clip_size = 6,
        mod_locations = {
            { id = "barrel", count = 1 },
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

-- This is the 7.5in barrel model
-- 190.5 + 64.8mm max OAL for 45-70. Revolvers just built different.
ccb.content.define_item {
    id = "bfr",
    copy_from = "gun_base_handgun_manual",
    looks_like = "sw_619",
    name = ccb.content.text("hunting hand cannon"),
    description = ccb.content.text("A massive single-action revolver.  While the .45-70 rifle round loses significant velocity in its short pistol barrel, it still competes with other large magnum handguns in terms of power."),
    variant_kind = "gun",
    variants = {
        {
            id = "bfr",
            name = ccb.content.text("Magnum Research BFR"),
            description = ccb.content.text("The Magnum Research BFR (Biggest, Finest Revolver) are a series of single action revolvers chambered in calibers from anywhere from .357 Magnum, to rifle calibers such as 45-70.  While rifle caliber chamberings for pistols are no doubt uncomfortable to shoot, they do see some use in the sport of handgun hunting, or rarely as range toys.  Due to its loading gate, it prevents the use of speedloaders and can make for lengthy reload times, so it's best to make every shot count."),
        },
    },
    mass = "1950 g",
    volume = "734 ml",
    length = "382 mm",
    price = "1 kUSD 50 USD",
    survival_price = "27 USD 50 cent",
    materials = { "steel", "plastic" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["4570"] = 5 } } },
    inheritance = { add = { flags = { "SINGLE_ACTION" } } },
    gun = {
        barrel_length = "255 mm",
        ammunition = { "4570" },
        damage = { type = "bullet", amount = -7 },
        dispersion = 180,
        clip_size = 5,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}

-- Specs from Uberti 32in barrel Special
ccb.content.define_item {
    id = "sharps",
    copy_from = "gun_base_rifle_manual",
    looks_like = "modular_ar15",
    name = ccb.content.text("breech-loading reproduction rifle"),
    description = ccb.content.text("A reproduction of an antique single-shot .45-70 rifle once used to hunt buffalo and other large game in the late 19th Century.  Highly accurate and powerful for the time, this one is made to handle modern smokeless ammunition."),
    variant_kind = "gun",
    variants = {
        {
            id = "sharps",
            name = ccb.content.plural_text("1874 Sharps", "1874 Sharpses"),
            description = ccb.content.text("The Sharps rifle series are antique, falling block rifles that saw service far back as the American Civil War.  The 1874 Sharps is one of the first rifles to utilize metallic cartridges, a revolutionary technology back in those days.  While they were chambered in 45-70, modern day smokeless loads would blow up older versions.  Thankfully, this reproduction from Uberti can handle modern day 45-70 loads."),
        },
    },
    mass = "4819 g",
    volume = "2936 ml",
    length = "1278 mm",
    price = "2 kUSD 100 USD",
    survival_price = "27 USD 50 cent",
    materials = { "steel", "wood" },
    flags = { "NEVER_JAMS", "RELOAD_EJECT", "EASY_CLEAN", "NO_TURRET" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["4570"] = 1 } } },
    gun = {
        barrel_length = "813 mm",
        ammunition = { "4570" },
        damage = { type = "bullet", amount = 12 },
        dispersion = 100,
        clip_size = 1,
        built_in_mods = { "match_trigger" },
        mod_locations = {
            { id = "barrel", count = 1 },
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
