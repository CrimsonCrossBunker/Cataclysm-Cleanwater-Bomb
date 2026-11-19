local ccb = require("ccb")

ccb.content.define_item {
    id = "belt223",
    copy_from = "magazine_belt",
    looks_like = "stanag30",
    name = ccb.content.text("5.56x45mm ammo belt"),
    pockets = { { kind = "MAGAZINE", rigid = false, ammunition = { ["223"] = 500 } } },
    magazine = { ammunition = { "223" }, capacity = 500, default_ammo = "556", linkage = "ammolink223" },
}

ccb.content.define_item {
    id = "ruger5",
    looks_like = "stanag30",
    name = ccb.content.text("Mini-14 5-round magazine"),
    description = ccb.content.text("A 10-round Mini-14 magazine that has been modified to only hold 5 rounds, commonly used to comply with hunting regulations."),
    copy_from = "stanag5",
    magazine = {},
}

-- Audited with real-life measurements of a 10rd PMAG.
ccb.content.define_item {
    id = "stanag10",
    looks_like = "stanag30",
    name = ccb.content.text("STANAG 10-round magazine"),
    description = ccb.content.text("A compact 10-round box magazine for use with STANAG compatible rifles."),
    mass = "84 g",
    volume = "134 ml",
    length = "91 mm",
    price = "50 USD",
    survival_price = "1 USD",
    materials = { "plastic" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            allowed_speedloaders = { "clip223_10rd" },
            ammunition = { ["223"] = 10, ["300blk"] = 10 },
        },
    },
    magazine = { ammunition = { "223", "300blk" } },
}

-- Audited with real-life measurements of a 10rd PMAG, ranger plates all set to add 1.5cm of length and 20grams of weight.
ccb.content.define_item {
    id = "stanag10ranger",
    looks_like = "stanag30",
    name = ccb.content.plural_text("STANAG 10-round magazine with ranger plate", "STANAG 10-round magazines with ranger plates"),
    description = ccb.content.text("A compact 10-round box magazine for use with STANAG compatible rifles.  The bottom has been modified with a ranger plate attachment to allow it to clip to carabiners."),
    mass = "104 g",
    volume = "156 ml",
    length = "106 mm",
    price = "51 USD",
    survival_price = "1 USD 10 cent",
    materials = { "plastic" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT", "BELT_CLIP" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            allowed_speedloaders = { "clip223_10rd" },
            ammunition = { ["223"] = 10, ["300blk"] = 10 },
        },
    },
    magazine = { ammunition = { "223", "300blk" } },
}

ccb.content.define_item {
    id = "ruger10",
    copy_from = "stanag10",
    looks_like = "stanag30",
    name = ccb.content.text("Mini-14 10-round magazine"),
    description = ccb.content.text("A compact 10-round box magazine used with the Ruger Mini-14 rifle."),
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["223"] = 10 } } },
    magazine = { ammunition = { "223" } },
}

ccb.content.define_item {
    id = "ruger20",
    copy_from = "stanag20",
    looks_like = "stanag30",
    name = ccb.content.text("Mini-14 20-round magazine"),
    description = ccb.content.text("A 20-round box magazine used with the Ruger Mini-14 rifle."),
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["223"] = 20 } } },
    magazine = { ammunition = { "223" } },
}

ccb.content.define_item {
    id = "ruger30",
    looks_like = "stanag30",
    name = ccb.content.text("Mini-14 30-round magazine"),
    description = ccb.content.text("A high-capacity box magazine for use with the Ruger Mini-14 rifle."),
    copy_from = "stanag30",
    magazine = {},
}

ccb.content.define_item {
    id = "ruger90",
    copy_from = "stanag90",
    looks_like = "stanag30",
    name = ccb.content.text("Mini-14 90-round snail drum magazine"),
    description = ccb.content.text("A bulky 90-round snail drum magazine for use with the Ruger Mini-14 rifle."),
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["223"] = 90 } } },
    magazine = { ammunition = { "223" } },
}

ccb.content.define_item {
    id = "ruger100",
    copy_from = "stanag100drum",
    looks_like = "stanag30",
    name = ccb.content.text("Mini-14 100-round double drum magazine"),
    description = ccb.content.text("A bulky 100-round double drum magazine for use with the Ruger Mini-14 rifle."),
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["223"] = 100 } } },
    magazine = { ammunition = { "223" } },
}

-- Represented as a more commonly seen pinned 10rd magazine, copied values from that.
ccb.content.define_item {
    id = "stanag5",
    looks_like = "stanag30",
    name = ccb.content.text("STANAG 5-round magazine"),
    description = ccb.content.text("A 10-round STANAG magazine that has been modified to only hold 5 rounds, commonly used to comply with hunting regulations."),
    mass = "84 g",
    volume = "134 ml",
    length = "91 mm",
    price = "40 USD",
    survival_price = "50 cent",
    materials = { "plastic" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["223"] = 5, ["300blk"] = 5 } } },
    magazine = { ammunition = { "223", "300blk" } },
}

-- Represented as a more commonly seen pinned 10rd magazine, copied values from that, then added ranger plate.
ccb.content.define_item {
    id = "stanag5ranger",
    looks_like = "stanag30",
    name = ccb.content.plural_text("STANAG 5-round magazine with ranger plate", "STANAG 5-round magazines with ranger plates"),
    description = ccb.content.text("A 10-round STANAG magazine that has been modified to only hold 5 rounds, commonly used to comply with hunting regulations.  The bottom has been modified with a ranger plate attachment to allow it to clip to carabiners."),
    mass = "104 g",
    volume = "156 ml",
    length = "106 mm",
    price = "41 USD",
    survival_price = "60 cent",
    materials = { "plastic" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT", "BELT_CLIP" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["223"] = 5, ["300blk"] = 5 } } },
    magazine = { ammunition = { "223", "300blk" } },
}

-- Dimensions and weight are from Magpul.
ccb.content.define_item {
    id = "stanag20",
    looks_like = "stanag30",
    name = ccb.content.text("STANAG 20-round magazine"),
    description = ccb.content.text("A compact 20-round box magazine for use with STANAG compatible rifles."),
    mass = "113 g",
    volume = "191 ml",
    length = "130 mm",
    price = "40 USD",
    survival_price = "1 USD 70 cent",
    materials = { "plastic" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            allowed_speedloaders = { "clip223_10rd" },
            ammunition = { ["223"] = 20, ["300blk"] = 20 },
        },
    },
    magazine = { ammunition = { "223", "300blk" } },
}

ccb.content.define_item {
    id = "stanag20ranger",
    looks_like = "stanag30",
    name = ccb.content.plural_text("STANAG 20-round magazine with ranger plate", "STANAG 20-round magazines with ranger plates"),
    description = ccb.content.text("A compact 20-round box magazine for use with STANAG compatible rifles.  The bottom has been modified with a ranger plate attachment to allow it to clip to carabiners."),
    mass = "133 g",
    volume = "213 ml",
    length = "145 mm",
    price = "41 USD",
    survival_price = "1 USD 80 cent",
    materials = { "plastic" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT", "BELT_CLIP" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            allowed_speedloaders = { "clip223_10rd" },
            ammunition = { ["223"] = 20, ["300blk"] = 20 },
        },
    },
    magazine = { ammunition = { "223", "300blk" } },
}

-- Tileset whitelist for rifle magazines
-- Audit based on Magpul 30rd magazine, dimensions measured and weight from Magpul.
ccb.content.define_item {
    id = "stanag30",
    name = ccb.content.text("STANAG 30-round magazine"),
    description = ccb.content.text("A standard capacity 30-round box magazine for use with STANAG compatible rifles."),
    mass = "141 g",
    volume = "283 ml",
    length = "192 mm",
    price = "80 USD",
    survival_price = "2 USD 50 cent",
    materials = { "plastic" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            allowed_speedloaders = { "clip223_10rd" },
            ammunition = { ["223"] = 30, ["300blk"] = 30 },
        },
    },
    magazine = { ammunition = { "223", "300blk" } },
}

-- Tileset whitelist for rifle magazines
-- Audit based on Magpul 30rd magazine, dimensions measured and weight from Magpul + Ranger Plate.
ccb.content.define_item {
    id = "stanag30ranger",
    name = ccb.content.plural_text("STANAG 30-round magazine with ranger plate", "STANAG 30-round magazines with ranger plates"),
    description = ccb.content.text("A standard capacity 30-round box magazine for use with STANAG compatible rifles.  The bottom has been modified with a ranger plate attachment to allow it to clip to carabiners."),
    mass = "161 g",
    volume = "305 ml",
    length = "207 mm",
    price = "81 USD",
    survival_price = "2 USD 60 cent",
    materials = { "plastic" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT", "BELT_CLIP" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            allowed_speedloaders = { "clip223_10rd" },
            ammunition = { ["223"] = 30, ["300blk"] = 30 },
        },
    },
    magazine = { ammunition = { "223", "300blk" } },
}

-- Dimensions and weight from Magpul.
ccb.content.define_item {
    id = "stanag40",
    looks_like = "stanag30",
    name = ccb.content.text("STANAG 40-round magazine"),
    description = ccb.content.text("An increased-capacity 40-round box magazine for use with STANAG compatible rifles."),
    mass = "187 g",
    volume = "363 ml",
    length = "246 mm",
    price = "85 USD",
    survival_price = "3 USD 60 cent",
    materials = { "plastic", "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            allowed_speedloaders = { "clip223_10rd" },
            ammunition = { ["223"] = 40, ["300blk"] = 40 },
        },
    },
    magazine = { ammunition = { "223", "300blk" } },
}

-- Dimensions and weight from Magpul + Ranger Plate.
ccb.content.define_item {
    id = "stanag40ranger",
    looks_like = "stanag30",
    name = ccb.content.plural_text("STANAG 40-round magazine with ranger plate", "STANAG 40-round magazines with ranger plates"),
    description = ccb.content.text("An increased-capacity 40-round box magazine for use with STANAG compatible rifles.  The bottom has been modified with a ranger plate attachment to allow it to clip to carabiners."),
    mass = "207 g",
    volume = "385 ml",
    length = "261 mm",
    price = "86 USD",
    survival_price = "3 USD 70 cent",
    materials = { "plastic", "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT", "BELT_CLIP" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            allowed_speedloaders = { "clip223_10rd" },
            ammunition = { ["223"] = 40, ["300blk"] = 40 },
        },
    },
    magazine = { ammunition = { "223", "300blk" } },
}

-- Dimensions from ImageJ, weight from a reviewer.
ccb.content.define_item {
    id = "stanag50",
    looks_like = "stanag30",
    name = ccb.content.text("STANAG 50-round drum magazine"),
    description = ccb.content.text("A bulky 50-round drum magazine for use with STANAG compatible rifles, known as the X-15."),
    mass = "725 g",
    volume = "663 ml",
    length = "175 mm",
    price = "90 USD",
    survival_price = "3 USD 60 cent",
    materials = { "aluminum", "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_BULKY" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            allowed_speedloaders = { "clip223_10rd" },
            ammunition = { ["223"] = 50, ["300blk"] = 50 },
        },
    },
    melee_damage = { bash = 4 },
    magazine = { ammunition = { "223", "300blk" }, reload_time = 200, jam_multiplier = 2 },
}

-- Dimensions from vendor.
ccb.content.define_item {
    id = "stanag60",
    looks_like = "stanag30",
    name = ccb.content.text("STANAG 60-round magazine"),
    description = ccb.content.text("A high-capacity 60-round casket magazine for use with STANAG compatible rifles.  It is thicker, rather than longer."),
    mass = "181 g",
    volume = "535 ml",
    length = "221 mm",
    price = "120 USD",
    survival_price = "7 USD 50 cent",
    materials = { "aluminum" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            allowed_speedloaders = { "clip223_10rd" },
            ammunition = { ["223"] = 60, ["300blk"] = 60 },
        },
    },
    magazine = { ammunition = { "223", "300blk" } },
}

-- Dimensions from vendor, audited with ImageJ.
ccb.content.define_item {
    id = "stanag60drum",
    looks_like = "stanag30",
    name = ccb.content.text("STANAG 60-round drum magazine"),
    description = ccb.content.text("A bulky 60-round drum magazine for use with STANAG compatible rifles, known as the D-60."),
    mass = "581 g",
    volume = "850 ml",
    length = "188 mm",
    price = "92 USD 50 cent",
    survival_price = "5 USD",
    materials = { "plastic" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_BULKY" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            allowed_speedloaders = { "clip223_10rd" },
            ammunition = { ["223"] = 60, ["300blk"] = 60 },
        },
    },
    melee_damage = { bash = 4 },
    magazine = { ammunition = { "223", "300blk" }, reload_time = 200, jam_multiplier = 2 },
}

-- Audit by comparison, very few good pictures of this magazine.
ccb.content.define_item {
    id = "stanag90",
    looks_like = "stanag30",
    name = ccb.content.text("STANAG 90-round snail drum magazine"),
    description = ccb.content.text("A bulky 90-round snail drum magazine for use with STANAG compatible rifles."),
    mass = "800 g",
    volume = "2000 ml",
    length = "197 mm",
    price = "95 USD",
    survival_price = "10 USD",
    materials = { "plastic", "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_BULKY" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            allowed_speedloaders = { "clip223_10rd" },
            ammunition = { ["223"] = 90, ["300blk"] = 90 },
        },
    },
    melee_damage = { bash = 4 },
    magazine = { ammunition = { "223", "300blk" }, reload_time = 200, jam_multiplier = 2 },
}

-- Dimensions from vendor.
ccb.content.define_item {
    id = "stanag100",
    looks_like = "stanag30",
    name = ccb.content.text("STANAG 100-round magazine"),
    description = ccb.content.text("A high-capacity 100-round casket magazine for use with STANAG compatible rifles."),
    mass = "272 g",
    volume = "795 ml",
    length = "310 mm",
    price = "150 USD",
    survival_price = "12 USD 50 cent",
    materials = { "aluminum" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_BULKY" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            allowed_speedloaders = { "clip223_10rd" },
            ammunition = { ["223"] = 100, ["300blk"] = 100 },
        },
    },
    magazine = { ammunition = { "223", "300blk" } },
}

-- Values from manufacturer.
ccb.content.define_item {
    id = "stanag100drum",
    looks_like = "stanag30",
    name = ccb.content.text("STANAG 100-round double drum magazine"),
    description = ccb.content.text("A bulky 100-round double drum magazine for use with STANAG compatible rifles, known as the Beta-C Mag."),
    mass = "1000 g",
    volume = "2340 ml",
    length = "25 cm",
    price = "140 USD",
    survival_price = "10 USD",
    materials = { "plastic", "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_BULKY" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            allowed_speedloaders = { "clip223_10rd" },
            ammunition = { ["223"] = 100, ["300blk"] = 100 },
        },
    },
    magazine = { ammunition = { "223", "300blk" }, reload_time = 200, jam_multiplier = 2 },
}

ccb.content.define_item {
    id = "stanag150",
    looks_like = "stanag30",
    name = ccb.content.text("STANAG 150-round double drum magazine"),
    description = ccb.content.text("A bulky 150-round double drum magazine for use with STANAG compatible rifles, known as the SAW-MAG."),
    mass = "2223 g",
    volume = "4675 ml",
    length = "343 mm",
    price = "180 USD",
    survival_price = "12 USD 50 cent",
    materials = { "plastic", "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_BULKY" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            allowed_speedloaders = { "clip223_10rd" },
            ammunition = { ["223"] = 150, ["300blk"] = 150 },
        },
    },
    magazine = { ammunition = { "223", "300blk" }, reload_time = 200, jam_multiplier = 2 },
}

ccb.content.define_item {
    id = "sl8mag",
    looks_like = "stanag10",
    name = ccb.content.text("10 round SL8 magazine"),
    description = ccb.content.text("A single stack magazine for the SL8 rifle, holding 10 rounds."),
    mass = "70 g",
    volume = "132 ml",
    length = "58 mm",
    price = "60 USD",
    survival_price = "2 USD",
    materials = { "plastic", "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["223"] = 10 } } },
    magazine = { ammunition = { "223" }, reload_time = 120 },
}

ccb.content.define_item {
    id = "augmag_10rd",
    copy_from = "stanag10",
    looks_like = "stanag30",
    name = ccb.content.text("AUG 10-round magazine"),
    description = ccb.content.text("A compact 10-round box magazine for use with the Steyr AUG assault rifle."),
    materials = { "steel", "plastic" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["223"] = 10 } } },
    magazine = { ammunition = { "223" } },
}

ccb.content.define_item {
    id = "augmag_30rd",
    copy_from = "stanag30",
    looks_like = "stanag30",
    name = ccb.content.text("AUG 30-round magazine"),
    description = ccb.content.text("A standard capacity 30-round box magazine for use with the Steyr AUG assault rifle."),
    materials = { "steel", "plastic" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["223"] = 30 } } },
    magazine = { ammunition = { "223" } },
}

ccb.content.define_item {
    id = "augmag_42rd",
    looks_like = "stanag30",
    name = ccb.content.text("AUG 42-round magazine"),
    description = ccb.content.text("An increased-capacity 42-round box magazine for use with the Steyr AUG assault rifle."),
    copy_from = "stanag40",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["223"] = 42 } } },
    magazine = {},
}

ccb.content.define_item {
    id = "augmag_100rd",
    copy_from = "stanag100drum",
    looks_like = "stanag30",
    name = ccb.content.text("AUG 100-round double drum magazine"),
    description = ccb.content.text("A bulky 100-round double drum magazine for use with the Steyr AUG assault rifle."),
    materials = { "steel", "plastic" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["223"] = 100 } } },
    magazine = { ammunition = { "223" }, jam_multiplier = 2 },
}

-- Values copied from a STANAG magazine.
ccb.content.define_item {
    id = "zpap85mag",
    name = ccb.content.text("ZPAP M90 30-round magazine"),
    description = ccb.content.text("A 30-round box magazine for use with the ZPAP M90 rifles."),
    copy_from = "stanag30",
    magazine = {},
}

-- Values copied from a STANAG magazine.
ccb.content.define_item {
    id = "zpap85mag_10rd",
    name = ccb.content.text("ZPAP M90 10-round magazine"),
    description = ccb.content.text("A 10-round box magazine for use with the ZPAP M90 rifles."),
    copy_from = "stanag10",
    magazine = {},
}

-- Not a real magazine, copied 10rd STANAG and increased weight.
ccb.content.define_item {
    id = "survivor223mag",
    looks_like = "stanag30",
    name = ccb.content.text("STANAG 5-round makeshift magazine"),
    description = ccb.content.text("An improvised 5-round straight single-stack box magazine consisting of little more than a bent sheet of steel held together by duct tape and hope, for use with STANAG compatible rifles."),
    mass = "120 g",
    volume = "134 ml",
    length = "91 mm",
    price = "12 USD",
    survival_price = "50 cent",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["223"] = 5, ["300blk"] = 5 } } },
    magazine = { ammunition = { "223", "300blk" }, reload_time = 150 },
}

ccb.content.define_item {
    id = "ruger_makeshiftmag",
    copy_from = "survivor223mag",
    survival_price = "50 cent",
    name = ccb.content.text("Mini-14 5-round makeshift magazine"),
    description = ccb.content.text("An improvised 5-round straight single-stack box magazine consisting of little more than a bent sheet of steel held together by duct tape and hope, for use with the Ruger Mini-14 rifle."),
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["223"] = 5 } } },
    magazine = { ammunition = { "223" } },
}

-- Copied values of 7.62x39 clip.
ccb.content.define_item {
    id = "clip223_10rd",
    looks_like = "stanag30",
    category = "ammo",
    name = ccb.content.text("5.56x45mm/.300BLK 10-round clip"),
    description = ccb.content.text("A tiny piece of grooved metal designed to allow a shooter to quickly load ten 5.56x45mm or .300 AAC Blackout rounds into a magazine."),
    mass = "11 g",
    volume = "4 ml",
    length = "90 mm",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "SPEEDLOADER_CLIP" },
    pockets = { { kind = "MAGAZINE", ammunition = { ["223"] = 10, ["300blk"] = 10 } } },
    magazine = { ammunition = { "223" } },
}
