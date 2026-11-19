local ccb = require("ccb")

ccb.content.define_item {
    id = "glock_29",
    copy_from = "gun_base_10mm_semi_pistol",
    looks_like = "glock_19",
    name = ccb.content.text("compact Glock pistol"),
    description = ccb.content.text("A small pistol accepting Glock magazines and chambered in 10mm.  Because of its size, it is easy to carry, but it has rather fierce recoil."),
    variant_kind = "gun",
    variants = {
        {
            id = "glock_29",
            name = ccb.content.text("Glock 29 pistol"),
            description = ccb.content.text("A modestly sized version of the highly successful Glock, chambered in hard-hitting 10mm Auto.  It is easy to carry because of its small size, but also has fierce recoil."),
        },
    },
    ascii_picture = "glock_19",
    mass = "690 g",
    volume = "410 ml",
    length = "177 mm",
    price = "605 USD",
    materials = { "plastic", "steel" },
    pockets = {
        {
            magazine_well = "99 ml",
            kind = "MAGAZINE_WELL",
            allowed_items = { "glock_20mag_10", "glock_29mag", "glock_20mag", "tdi_10mm_mag" },
        },
    },
    gun = {
        barrel_length = "96 mm",
        dispersion = 510,
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
    id = "glock_20",
    copy_from = "gun_base_10mm_semi_pistol",
    looks_like = "glock_17",
    name = ccb.content.text("Glock pistol"),
    description = ccb.content.text("A semi-automatic pistol chambered in 10mm which accepts Glock magazines."),
    variant_kind = "gun",
    variants = {
        {
            id = "glock_20",
            name = ccb.content.text("Glock 20 pistol"),
            description = ccb.content.text("A full-sized version of the highly successful Glock, chambered in hard-hitting 10mm Auto.  The third model of Glock designed, all other full-sized, large framed Glocks are adaptations of this one."),
        },
    },
    ascii_picture = "glock_20",
    mass = "780 g",
    volume = "480 ml",
    length = "205 mm",
    price = "592 USD",
    materials = { "plastic", "steel" },
    pockets = {
        {
            magazine_well = "103 ml",
            kind = "MAGAZINE_WELL",
            allowed_items = { "glock_20mag_10", "glock_20mag", "tdi_10mm_mag" },
        },
    },
    gun = {
        barrel_length = "117 mm",
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
    id = "glock_40",
    copy_from = "glock_20",
    looks_like = "glock_20",
    name = ccb.content.text("hunter Glock pistol"),
    description = ccb.content.text("A full-sized, long-slide version of the highly successful Glock, chambered in hard-hitting 10mm Auto.  The extra barrel length makes for slightly more accurate and powerful shots, and the extra slide length means the sights are a little easier to use.  It also features Glock's Modular Optic System, making aftermarket optics much easier to mount."),
    variant_kind = "gun",
    variants = {
        {
            id = "glock_40",
            name = ccb.content.text("Glock 40 pistol"),
            description = ccb.content.text("A full-sized, long-slide version of the highly successful Glock, chambered in hard-hitting 10mm Auto.  The extra barrel length makes for slightly more accurate and powerful shots, and the extra slide length means the sights are a little easier to use."),
        },
    },
    ascii_picture = "glock_40mos",
    mass = "915 g",
    volume = "410 ml",
    length = "213 mm",
    price = "655 USD",
    gun = { barrel_length = "153 mm", dispersion = 500 },
}

ccb.content.define_item {
    id = "m1911_10",
    copy_from = "gun_base_10mm_semi_pistol",
    looks_like = "m1911",
    name = ccb.content.text("Colt Delta Elite pistol"),
    description = ccb.content.text("A semi-automatic pistol chambered in 10mm.  It accepts Colt Delta Elite magazines."),
    variant_kind = "gun",
    variants = {
        {
            id = "m1911_10",
            name = ccb.content.text("Colt Delta Elite pistol"),
            description = ccb.content.text("A modernized, match-grade variant of the venerable M1911 chambered in hard-hitting 10mm Auto.  Early variants were known to crack frames; modern 1911s, like this one, are slotted to prevent such crack formation."),
        },
    },
    mass = "1077 g",
    volume = "413 ml",
    length = "210 mm",
    price = "1 kUSD 50 USD",
    materials = { "steel" },
    pockets = { { magazine_well = "60 ml", kind = "MAGAZINE_WELL", allowed_items = { "m1911_10mag" } } },
    gun = {
        barrel_length = "127 mm",
        dispersion = 480,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
        built_in_mods = { "match_trigger" },
    },
}

ccb.content.define_item {
    id = "witness_10",
    copy_from = "gun_base_10mm_semi_pistol",
    looks_like = "cz75",
    name = ccb.content.text("EAA Witness pistol"),
    description = ccb.content.text("A semi-automatic pistol chambered in 10mm and accepting EAA Witness magazines."),
    variant_kind = "gun",
    variants = {
        {
            id = "witness_10",
            name = ccb.content.text("EAA Witness 10mm pistol"),
            description = ccb.content.text("The EAA Witness is a modified variant of the CZ-75, produced in Italy by Tanfoglio.  This is the standard steel framed version chambered in 10mm Auto."),
        },
    },
    mass = "936 g",
    volume = "459 ml",
    length = "203 mm",
    price = "649 USD",
    materials = { "steel" },
    pockets = { { magazine_well = "84 ml", kind = "MAGAZINE_WELL", allowed_items = { "witness_mag_10" } } },
    gun = {
        barrel_length = "114 mm",
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
    id = "p220_10",
    copy_from = "gun_base_10mm_semi_pistol",
    looks_like = "p226_357sig",
    name = ccb.content.text("SIG pistol"),
    description = ccb.content.text("A semi-automatic pistol chambered in 10mm and accepting SIG magazines."),
    variant_kind = "gun",
    variants = {
        {
            id = "p220_10",
            name = ccb.content.text("SIG P220 10mm pistol"),
            description = ccb.content.text("The SIG Sauer P220 was developed for the Swiss military in 1975, and its simplified action was later used in most other SIG Sauer designs, including the P226.  The all-steel construction adds heft to this model, which is chambered in hard-hitting 10mm Auto."),
        },
    },
    mass = "964 g",
    volume = "549 ml",
    length = "224 mm",
    price = "500 USD",
    materials = { "steel" },
    pockets = { { magazine_well = "60 ml", kind = "MAGAZINE_WELL", allowed_items = { "p220_10_mag" } } },
    gun = {
        barrel_length = "127 mm",
        dispersion = 410,
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
    id = "xd_10",
    copy_from = "gun_base_10mm_semi_pistol",
    looks_like = "glock_19",
    name = ccb.content.text("XD-M pistol"),
    description = ccb.content.text("A semi-automatic pistol chambered in 10mm and accepting XD-M magazines."),
    variant_kind = "gun",
    variants = {
        {
            id = "xd_10",
            name = ccb.content.text("XD-M Competition 10mm pistol"),
            description = ccb.content.text("Designed by HS Produkt in Croatia, the HS2000 has become a commercial success for Springfield Armory, who imports and markets it as the eXtreme Duty.  The XD has since been offered in a variety of chamberings and sizes, including this full-sized match grade variant in 10mm Auto."),
        },
    },
    mass = "930 g",
    volume = "549 ml",
    length = "211 mm",
    price = "500 USD",
    materials = { "steel", "plastic" },
    pockets = { { magazine_well = "81 ml", kind = "MAGAZINE_WELL", allowed_items = { "xd_10_mag" } } },
    gun = {
        barrel_length = "133 mm",
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
