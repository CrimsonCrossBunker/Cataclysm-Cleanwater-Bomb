local ccb = require("ccb")

-- Based on the Truvelo CMS.  No rifle grenades since it has a magazine.
ccb.content.define_item {
    id = "sapra",
    looks_like = "smle_mk3",
    name = ccb.content.text("Exodii Sapra grenade launcher"),
    description = ccb.content.text("The Sapra '36 is a short smoothbore bolt-action grenade launcher, fitted with a 5-round box magazine and a large, efficient muzzle brake.  Designed in the interwar period following the proliferation of Brogyeki '23, the Sapra was intended to assist in riots, ambushes and assaulting in urban operations, where explosives applied in quick succession could make short work of targets.  To further assist in riot operations, the Sapra can be fitted with a bayonet, a frivolity that the Exodii almost immediately discarded.  Unlike the Brogyeki, the Sapra is incapable of chambering the longer 27.3x110 Diyua shells.  The Exodii have replaced the stock with an aluminum alloy chassis, leaving behind the original wood ones as they became damaged."),
    mass = "5900 g",
    volume = "1930 ml",
    length = "980 mm",
    price = "13 kUSD 200 USD",
    survival_price = "100 USD",
    variant_kind = "gun",
    variants = {
        {
            id = "sapra",
            name = ccb.content.text("Sapra '36 grenade launcher"),
            description = ccb.content.text("The Sapra '36 is a short smoothbore bolt-action grenade launcher, fitted with a 5-round box magazine and a large, efficient muzzle brake.  Designed in the interwar period following the proliferation of Brogyeki '23, the Sapra was intended to assist in riots, ambushes and assaulting in urban operations, where explosives applied in quick succession could make short work of targets.  To further assist in riot operations, the Sapra can be fitted with a bayonet, a frivolity that the Exodii almost immediately discarded.  Unlike the Brogyeki, the Sapra is incapable of chambering the longer 27.3x110 Diyua shells.  The Exodii have replaced the stock with an aluminum alloy chassis, leaving behind the original wood ones as they became damaged."),
            weight = 1,
        },
    },
    accuracy = -1,
    materials = { "qt_steel", "aluminum" },
    symbol = "(",
    color = "dark_gray",
    pockets = { { magazine_well = "82 ml", kind = "MAGAZINE_WELL", allowed_items = { "exodiisapramag5" } } },
    flags = { "NEVER_JAMS", "EASY_CLEAN" },
    melee_damage = { bash = 8 },
    gun = {
        ammunition = { "273x44" },
        skill = "launcher",
        dispersion = 300,
        durability = 7,
        blackpowder_tolerance = 110,
        barrel_length = "380 mm",
        default_mods = { "muzzle_brake" },
        mod_locations = {
            { id = "muzzle", count = 1 },
            { id = "rail_mount", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock", count = 1 },
            { id = "stock accessory", count = 2 },
            { id = "underbarrel", count = 1 },
        },
    },
}

-- barrel should be a bit shorter than the pamd71z as it's less accurate
ccb.content.define_item {
    id = "pamd68",
    copy_from = "gun_base_rifle_semi",
    looks_like = "modular_ar15",
    name = ccb.content.text("Exodii battle rifle"),
    description = ccb.content.text("The most popular gun to use the 12.3ln cartridge was, of course, the PA md. 71.  Its predecessor, the md. 68, was viewed by many as a sort of failure: although it was reliable and powerful, it was too heavy to be used as a good infantry weapon, and not really heavy enough to be a good support gun.  Enough were made, though, that during the zombie apocalypse, it gained a great deal of resurgent popularity as a light emplacement gun that used readily available ammunition.  It perfectly served the purposes of the Exodii, who had far less concern about its unwieldiness."),
    mass = "9480 g",
    volume = "2800 ml",
    length = "1000 mm",
    price = "3 kUSD 500 USD",
    survival_price = "40 USD",
    variant_kind = "gun",
    variants = {
        {
            id = "pamd68",
            name = ccb.content.text("PA md. 68 rifle"),
            description = ccb.content.text("The most popular gun to use the 12.3ln cartridge was, of course, the PA md. 71.  Its predecessor, the md. 68, was viewed by many as a sort of failure: although it was reliable and powerful, it was too heavy to be used as a good infantry weapon, and not really heavy enough to be a good support gun.  Enough were made, though, that during the zombie apocalypse, it gained a great deal of resurgent popularity as a light emplacement gun that used readily available ammunition.  It perfectly served the purposes of the Exodii, who had far less concern about its unwieldiness."),
        },
    },
    materials = { "qt_steel", "aluminum" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_items = { "exodiiBRmag", "exodiiBRmag_153", "exodiiBRmag_26" },
        },
    },
    gun = {
        barrel_length = "508 mm",
        ammunition = { "123ln" },
        dispersion = 190,
        durability = 9,
        modes = {
            { id = "DEFAULT", label = ccb.content.text("burst"), quantity = 2 },
            { id = "SEMI", label = ccb.content.text("semi-auto"), quantity = 1 },
            { id = "AUTO", label = ccb.content.text("auto-rpm"), rpm = 1500 },
        },
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "bayonet lug", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "muzzle", count = 1 },
            { id = "rail", count = 1 },
            { id = "sights", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock", count = 1 },
            { id = "stock accessory", count = 2 },
            { id = "underbarrel", count = 1 },
        },
        barrel_volume = "1200 ml",
    },
}

-- around the length of other long 30-06 rifles and heavier AR's
ccb.content.define_item {
    id = "pamd71z",
    copy_from = "gun_base_rifle_semi",
    looks_like = "modular_ar15",
    name = ccb.content.text("Exodii zombie hunting rifle"),
    description = ccb.content.text("This extremely popular Romanian rifle, made famous in the third Carpathian War, has been redesigned slightly by the Exodii for precision shots against high-priority targets.  In a pinch this modified design can fire a 2-shot burst, with the goal of shredding the target and preventing revivification.  However, the recoil is much greater for a human than it would be for a cyborg or giant quadruped, causing the burst to more often miss than hit."),
    mass = "3910 g",
    volume = "3 L",
    length = "1100 mm",
    price = "800 USD",
    survival_price = "32 USD 50 cent",
    variant_kind = "gun",
    variants = {
        {
            id = "pamd71z",
            name = ccb.content.text("PS md. 71z rifle"),
            description = ccb.content.text("This extremely popular Romanian rifle, made famous in the third Carpathian War, has been redesigned slightly by the Exodii for precision shots against high-priority targets.  In a pinch this modified design can fire a 2-shot burst, with the goal of shredding the target and preventing revivification.  However, the recoil is much greater for a human than it would be for a cyborg or giant quadruped, causing the burst to more often miss than hit."),
        },
    },
    materials = { "qt_steel", "aluminum" },
    pockets = { { kind = "MAGAZINE_WELL", allowed_items = { "exodiiminimag" } } },
    gun = {
        barrel_length = "610 mm",
        ammunition = { "123ln" },
        dispersion = 100,
        modes = {
            { id = "DEFAULT", label = ccb.content.text("semi-auto"), quantity = 1 },
            { id = "AUTO", label = ccb.content.text("burst"), quantity = 2 },
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
            { id = "stock accessory", count = 2 },
            { id = "stock mount", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
        barrel_volume = "250 ml",
    },
}

ccb.content.define_item {
    id = "pamd68mountable",
    copy_from = "pamd68",
    name = ccb.content.text("mountable Exodii battle rifle"),
    description = ccb.content.text("The most popular gun to use the 12.3ln cartridge was, of course, the PA md. 71.  Its predecessor, the md. 68, was viewed by many as a sort of failure: although it was reliable and powerful, it was too heavy to be used as a good infantry weapon, and not really heavy enough to be a good support gun.  Enough were made, though, that during the zombie apocalypse, it gained a great deal of resurgent popularity as a light emplacement gun that used readily available ammunition.  It perfectly served the purposes of the Exodii, who had far less concern about its unwieldiness.  This one has been modified for use in vehicle turrets on Earth."),
    mass = "9630 g",
    volume = "2865 ml",
    variant_kind = "gun",
    variants = {
        {
            id = "pamd68mountable",
            name = ccb.content.text("mountable PA md. 68 rifle"),
            description = ccb.content.text("The most popular gun to use the 12.3ln cartridge was, of course, the PA md. 71.  Its predecessor, the md. 68, was viewed by many as a sort of failure: although it was reliable and powerful, it was too heavy to be used as a good infantry weapon, and not really heavy enough to be a good support gun.  Enough were made, though, that during the zombie apocalypse, it gained a great deal of resurgent popularity as a light emplacement gun that used readily available ammunition.  It perfectly served the purposes of the Exodii, who had far less concern about its unwieldiness.  This one has been modified for use in vehicle turrets on Earth."),
        },
    },
    gun = {},
}
