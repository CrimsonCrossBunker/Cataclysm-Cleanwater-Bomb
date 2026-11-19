local ccb = require("ccb")

ccb.content.define_item {
    id = "rifle_assault",
    copy_from = "hk417_13",
    name = ccb.content.text("assault rifle"),
    description = ccb.content.text("The products of decades of improvement, rifle such as this are handy, reliable, and adaptable.  An 'assault rifle', it is capable of providing both accurate semi-automatic fire and bursts of automatic fire.  Short of large creatures and light vehicles, this should take care of most of your problems out to several hundred meters."),
    variants = {},
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            holster = true,
            capacity = "20 L",
            mass_limit = "20 kg",
            allowed_items = { "rifle_mag", "rifle_sniper_mag" },
            rigid = true,
        },
    },
    gun = { ammunition = { "ammo_rifle" } },
}

ccb.content.define_item {
    id = "rifle_lmg",
    copy_from = "m240",
    name = ccb.content.text("light machine gun"),
    description = ccb.content.text("The light machine gun is a formidable implement for suppressive fire, an important part of squad tactics.  Its belt feed allows for hundreds of rounds to be loaded, and its heavy components can withstand long bursts of fire.  While perhaps not as precise as a service rifle, a light machinegun does allow for a considerable amount of energy to be sent down range.  Slow to reload."),
    variants = {},
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            holster = true,
            capacity = "20 L",
            mass_limit = "20 kg",
            allowed_items = { "rifle_belt" },
            rigid = true,
        },
    },
    gun = { ammunition = { "ammo_rifle" } },
}

ccb.content.define_item {
    id = "rifle_sniper",
    copy_from = "m2010",
    name = ccb.content.text("sniper rifle"),
    description = ccb.content.text("Sniper rifles fill military, police and civilian needs for precise, accurate fire.  Modern examples feature detachable magazines and various mounting interfaces for optics and supports.  With care and practice, all should be quite capable of eliminating bipedal threats from very safe ranges."),
    variants = {},
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            holster = true,
            capacity = "20 L",
            mass_limit = "20 kg",
            allowed_items = { "rifle_sniper_mag", "rifle_mag" },
            rigid = true,
        },
    },
    gun = { ammunition = { "ammo_rifle" } },
}

ccb.content.define_item {
    id = "rifle_sporter",
    copy_from = "ar10",
    name = ccb.content.text("sporter carbine"),
    description = ccb.content.text("Though often mislabeled an assault rifle, this common, cheap magazine fed carbine isn't capable of automatic fire.  While almost as effective as a proper rifle, the wider variety of components and varying levels of maintenance make these less reliable than their military brethren.  These rifles are just as adequate for taking on anything smaller than large game, however."),
    variants = {},
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            holster = true,
            capacity = "20 L",
            mass_limit = "20 kg",
            allowed_items = { "rifle_mag", "rifle_sniper_mag" },
            rigid = true,
        },
    },
    gun = { ammunition = { "ammo_rifle" } },
}

ccb.content.define_item {
    id = "rifle_assault_foreign",
    copy_from = "pamd68",
    name = ccb.content.text("foreign assault rifle"),
    description = ccb.content.text("A battle rifle popular among the Exodii.  Reliable and powerful, though slightly unwieldy to use as an infantry weapon.  Just different enough from local weaponry that the same ammunition cannot be shared between them."),
    variants = {},
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            holster = true,
            capacity = "20 L",
            mass_limit = "20 kg",
            allowed_items = { "rifle_mag_foreign", "rifle_sniper_mag_foreign" },
        },
    },
    gun = { ammunition = { "ammo_rifle_foreign" } },
}

ccb.content.define_item {
    id = "rifle_sniper_foreign",
    copy_from = "m2010",
    name = ccb.content.text("foreign sniper rifle"),
    description = ccb.content.text("A sniper rifle popular among the Exodii.  Just different enough from local weaponry that the same ammunition cannot be shared between them."),
    variants = {},
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            holster = true,
            capacity = "20 L",
            mass_limit = "20 kg",
            allowed_items = { "rifle_sniper_mag_foreign" },
        },
    },
    gun = { ammunition = { "ammo_rifle_foreign" } },
}

ccb.content.define_item {
    id = "rifle_cannon_foreign",
    copy_from = "ree_33",
    name = ccb.content.text("foreign cannon rifle"),
    description = ccb.content.text("A powerful Exodii rifle, reserved for the later stage of cataclysm.  It should be considered an anti-tank rifle in modern world, but the round is bigger than any anti-tank round on Earth."),
    variants = {},
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            holster = true,
            capacity = "200 L",
            mass_limit = "200 kg",
            allowed_items = { "rifle_mag_cannon", "rifle_mag_cannon_big" },
        },
    },
    gun = { ammunition = { "ammo_rifle_cannon" } },
}

ccb.content.define_item {
    id = "rifle_rail",
    copy_from = "hk_g80",
    name = ccb.content.text("railgun rifle"),
    description = ccb.content.text("A handheld railgun which magnetically propels a ferromagnetic projectile using an alternating current.  Powered by UPS."),
    variants = {},
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            holster = true,
            magazine_well = "250 ml",
            capacity = "20 L",
            mass_limit = "20 kg",
            allowed_items = { "rifle_rail_mag" },
        },
    },
    gun = { ammunition = { "ammo_railgun" } },
}

ccb.content.define_item {
    id = "rifle_shotgun_combination",
    copy_from = "combination_gun",
    name = ccb.content.text("combination rifle shotgun"),
    description = ccb.content.text("A break action firearm comprised of a rifle barrel over two smooth bore shotgun barrels.  Historically used by egomaniac hunters in Africa, now used by their egomaniac descendants in New England."),
    variants = {},
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ammo_rifle = 1 } } },
    gun = { built_in_mods = { "rifle_shotgun_combination_shotgun" } },
}
