local ccb = require("ccb")

ccb.content.define_item {
    id = "belt308",
    copy_from = "magazine_belt",
    name = ccb.content.text("7.62x51mm ammo belt"),
    pockets = { { kind = "MAGAZINE", rigid = false, ammunition = { ["308"] = 500 } } },
    magazine = { ammunition = { "308" }, capacity = 500, default_ammo = "762_51", linkage = "ammolink308" },
}

-- Audited
ccb.content.define_item {
    id = "falbigmag",
    looks_like = "stanag30",
    name = ccb.content.text("heavy automatic rifle 30-round magazine"),
    description = ccb.content.text("An extended 30-round steel box magazine for the heavy automatic rifle."),
    variant_kind = "gun",
    variants = {
        {
            id = "falbigmag",
            name = ccb.content.text("FAL 30-round magazine"),
            description = ccb.content.text("An extended 30-round steel box magazine for the FN FAL rifle."),
        },
    },
    mass = "340 g",
    volume = "412 ml",
    length = "21 cm",
    price = "21 USD",
    survival_price = "5 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["308"] = 30 } } },
    magazine = { ammunition = { "308" } },
}

-- Audited
ccb.content.define_item {
    id = "falmag",
    looks_like = "stanag30",
    name = ccb.content.text("heavy automatic rifle 20-round magazine"),
    description = ccb.content.text("A military issue 20-round steel box magazine for the heavy automatic rifle."),
    variant_kind = "gun",
    variants = {
        {
            id = "falmag",
            name = ccb.content.text("FAL 20-round magazine"),
            description = ccb.content.text("A military issue 20-round steel box magazine for the FN FAL rifle."),
        },
    },
    mass = "240 g",
    volume = "285 ml",
    length = "145 mm",
    price = "12 USD",
    survival_price = "2 USD 50 cent",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["308"] = 20 } } },
    magazine = { ammunition = { "308" } },
}

-- Audited
ccb.content.define_item {
    id = "fal_makeshiftmag",
    looks_like = "stanag30",
    name = ccb.content.text("FAL 5-round makeshift magazine"),
    description = ccb.content.text("An improvised 5-round straight single-stack box magazine consisting of little more than a bent sheet of steel held together by duct tape and hope, for use with the FN FAL rifle."),
    mass = "115 g",
    volume = "137 ml",
    length = "78 mm",
    price = "12 USD",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["308"] = 5 } } },
    magazine = { ammunition = { "308" }, reload_time = 150 },
}

-- Audited
ccb.content.define_item {
    id = "g3bigmag",
    looks_like = "stanag30",
    name = ccb.content.text("G3 50-round drum magazine"),
    description = ccb.content.text("A 50-round drum magazine for the H&K G3 rifle."),
    mass = "975 g",
    volume = "1124 ml",
    length = "175 mm",
    price = "79 USD",
    survival_price = "5 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_BULKY" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["308"] = 50 } } },
    magazine = { ammunition = { "308" }, reload_time = 160, jam_multiplier = 2 },
}

-- Audited
ccb.content.define_item {
    id = "g3mag",
    looks_like = "stanag30",
    name = ccb.content.text("G3 20-round magazine"),
    description = ccb.content.text("A steel box magazine for the H&K G3 rifle."),
    mass = "268 g",
    volume = "295 ml",
    length = "14 cm",
    price = "12 USD",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["308"] = 20 } } },
    magazine = { ammunition = { "308" } },
}

ccb.content.define_item {
    id = "g3_makeshiftmag",
    copy_from = "fal_makeshiftmag",
    name = ccb.content.text("G3 5-round makeshift magazine"),
    description = ccb.content.text("An improvised 5-round straight single-stack box magazine consisting of little more than a bent sheet of steel held together by duct tape and hope, for use with G3 rifle."),
    magazine = {},
}

-- Audited
-- length 6.1 in, width 1.012 in, height 3.1 in, raw 313.6 ml, trim 1%
ccb.content.define_item {
    id = "m14mag",
    looks_like = "stanag30",
    name = ccb.content.text("M14 20-round magazine"),
    description = ccb.content.text("A military issue 20-round steel box magazine compatible with M14 pattern rifles."),
    mass = "231 g",
    volume = "311 ml",
    length = "155 mm",
    price = "59 USD",
    survival_price = "250 cent",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["308"] = 20 } } },
    magazine = { ammunition = { "308" } },
}

-- Audited
ccb.content.define_item {
    id = "m14smallmag",
    looks_like = "stanag30",
    name = ccb.content.text("M14 5-round magazine"),
    description = ccb.content.text("A compact aftermarket 5-round steel box magazine compatible with M14 pattern rifles.  Although it has a low capacity, it is easy to store and quick to reload."),
    mass = "97 g",
    volume = "131 ml",
    length = "79 mm",
    price = "29 USD",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["308"] = 5 } } },
    magazine = { ammunition = { "308" }, reload_time = 50 },
}

ccb.content.define_item {
    id = "m14_makeshiftmag",
    copy_from = "fal_makeshiftmag",
    survival_price = "50 cent",
    name = ccb.content.text("M14 5-round makeshift magazine"),
    description = ccb.content.text("An improvised 5-round straight single-stack box magazine consisting of little more than a bent sheet of steel held together by duct tape and hope, for use with M14 pattern rifles."),
    magazine = {},
}

-- Audited
ccb.content.define_item {
    id = "papm77mag",
    looks_like = "stanag30",
    name = ccb.content.text("PAP M77 20-round magazine"),
    description = ccb.content.text("A 20-round steel box magazine for the PAP M77 rifle."),
    mass = "229 g",
    volume = "309 ml",
    length = "158 mm",
    price = "12 USD",
    survival_price = "2 USD 50 cent",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["308"] = 20 } } },
    magazine = { ammunition = { "308" } },
}

-- Audited
ccb.content.define_item {
    id = "papm77mag_10rd",
    looks_like = "stanag30",
    name = ccb.content.text("PAP M77 10-round magazine"),
    description = ccb.content.text("A 10-round steel box magazine for the PAP M77 rifle."),
    mass = "129 g",
    volume = "174 ml",
    length = "89 mm",
    price = "50 USD",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["308"] = 10 } } },
    magazine = { ammunition = { "308" } },
}

-- Audited
ccb.content.define_item {
    id = "scarhbigmag",
    looks_like = "stanag30",
    name = ccb.content.text("SCAR-H 50-round drum magazine"),
    description = ccb.content.text("A 50-round drum magazine for the FN SCAR-H rifle."),
    mass = "1390 g",
    volume = "2200 ml",
    length = "220 mm",
    price = "89 USD",
    survival_price = "7 USD 50 cent",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_BULKY" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["308"] = 50 } } },
    magazine = { ammunition = { "308" }, reload_time = 160, jam_multiplier = 2 },
}

ccb.content.define_item {
    id = "scarhmag_30rd",
    copy_from = "falbigmag",
    survival_price = "2 USD 50 cent",
    name = ccb.content.text("SCAR-H 30-round modified magazine"),
    description = ccb.content.text("A 30-round steel box magazine for the FN SCAR-H rifle.  This one actually seems to be a modified FN FAL magazine."),
    magazine = {},
}

-- Audited
ccb.content.define_item {
    id = "scarhmag",
    looks_like = "stanag30",
    name = ccb.content.text("SCAR-H 20-round magazine"),
    description = ccb.content.text("A military issue 20-round steel box magazine for the FN SCAR-H rifle."),
    mass = "242 g",
    volume = "354 ml",
    length = "165 mm",
    price = "56 USD",
    survival_price = "2 USD 50 cent",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["308"] = 20 } } },
    magazine = { ammunition = { "308" } },
}

ccb.content.define_item {
    id = "scarhmag_10",
    looks_like = "stanag30",
    name = ccb.content.text("SCAR-H 10-round magazine"),
    description = ccb.content.text("A 10-round magazine for the FN SCAR-H or 17S rifle."),
    mass = "142 g",
    volume = "208 ml",
    length = "160 mm",
    price = "61 USD 99 cent",
    survival_price = "6 USD 50 cent",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["308"] = 10 } } },
    magazine = { ammunition = { "308" } },
}

ccb.content.define_item {
    id = "scarh_makeshiftmag",
    copy_from = "fal_makeshiftmag",
    survival_price = "50 cent",
    name = ccb.content.text("SCAR-H 5-round makeshift magazine"),
    description = ccb.content.text("An improvised 5-round straight single-stack box magazine consisting of little more than a bent sheet of steel held together by duct tape and hope, for use with the FN SCAR-H rifle."),
    magazine = {},
}

-- Audited
ccb.content.define_item {
    id = "hk417mag_20rd",
    looks_like = "stanag30",
    name = ccb.content.text("HK417 20-round magazine"),
    description = ccb.content.text("A 20-round double stack box magazine for the HK417 rifle."),
    mass = "220 g",
    volume = "343 ml",
    length = "162 mm",
    price = "56 USD",
    survival_price = "2 USD 50 cent",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["308"] = 20 } } },
    magazine = { ammunition = { "308" } },
}

-- Audited
ccb.content.define_item {
    id = "hk417mag_10rd",
    looks_like = "stanag30",
    name = ccb.content.text("HK417 10-round magazine"),
    description = ccb.content.text("A 10-round double stack box magazine for the HK417 rifle."),
    mass = "112 g",
    volume = "206 ml",
    length = "97 mm",
    price = "50 USD",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["308"] = 10 } } },
    magazine = { ammunition = { "308" } },
}

ccb.content.define_item {
    id = "hk417_makeshiftmag",
    copy_from = "fal_makeshiftmag",
    survival_price = "50 cent",
    name = ccb.content.text("HK417 5-round makeshift magazine"),
    description = ccb.content.text("An improvised 5-round straight single-stack box magazine consisting of little more than a bent sheet of steel held together by duct tape and hope, for use with the HK417 rifle."),
    magazine = {},
}

-- Audited
ccb.content.define_item {
    id = "ar10mag_10rd",
    looks_like = "stanag30",
    name = ccb.content.text("AR-10 10-round magazine"),
    description = ccb.content.text("A compact 10-round double stack box magazine for AR-10-based rifles."),
    mass = "108 g",
    volume = "221 ml",
    length = "104 mm",
    price = "30 USD",
    survival_price = "2 USD 50 cent",
    materials = { "plastic" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["308"] = 10 } } },
    magazine = { ammunition = { "308" }, capacity = 10 },
}

-- Audited
ccb.content.define_item {
    id = "ar10mag_20rd",
    looks_like = "stanag30",
    name = ccb.content.text("AR-10 20-round magazine"),
    description = ccb.content.text("A 20-round double stack box magazine for AR-10-based rifles."),
    mass = "162 g",
    volume = "350 ml",
    length = "165 mm",
    price = "30 USD",
    survival_price = "2 USD 50 cent",
    materials = { "plastic" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["308"] = 20 } } },
    magazine = { ammunition = { "308" }, capacity = 20 },
}

-- Audited
ccb.content.define_item {
    id = "ar10mag_25rd",
    looks_like = "stanag30",
    name = ccb.content.text("AR-10 25-round magazine"),
    description = ccb.content.text("An extended 25-round double stack box magazine for AR-10-based rifles."),
    mass = "184 g",
    volume = "417 ml",
    length = "197 mm",
    price = "30 USD",
    survival_price = "2 USD 50 cent",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["308"] = 25 } } },
    magazine = { ammunition = { "308" }, capacity = 25 },
}

-- Audited
ccb.content.define_item {
    id = "ar10mag_50rd",
    looks_like = "stanag30",
    name = ccb.content.text("AR-10 50-round drum magazine"),
    description = ccb.content.text("A large 50-round drum magazine for AR-10-based rifles, marked 'D-50'."),
    mass = "771 g",
    volume = "1211 ml",
    length = "211 mm",
    price = "154 USD",
    survival_price = "7 USD 50 cent",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_BULKY" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["308"] = 50 } } },
    magazine = { ammunition = { "308" }, capacity = 50, jam_multiplier = 2 },
}

ccb.content.define_item {
    id = "ar10_makeshiftmag",
    copy_from = "fal_makeshiftmag",
    survival_price = "50 cent",
    name = ccb.content.text("AR-10 5-round makeshift magazine"),
    description = ccb.content.text("An improvised 5-round straight single-stack box magazine consisting of little more than a bent sheet of steel held together by duct tape and hope, for use with the AR-10 rifle."),
    magazine = {},
}

-- Audited
ccb.content.define_item {
    id = "ai_308mag_10",
    looks_like = "stanag30",
    name = ccb.content.text("AI .308 10-round magazine"),
    description = ccb.content.text("A single-stack, 10-round steel box magazine, produced by the British precision rifle company, Accuracy International.  Magazines such as this one have been regarded as the gold standard for marksman rifle magazines, with this particular one being compatible with the .308 Winchester cartridge."),
    mass = "125 g",
    volume = "247 ml",
    length = "130 mm",
    price = "92 USD 53 cent",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["308"] = 10 } } },
    magazine = { ammunition = { "308" } },
}

-- Audited
ccb.content.define_item {
    id = "steyr_scout_mag",
    looks_like = "exodiiminimag",
    name = ccb.content.text("scout rifle 5-round magazine"),
    description = ccb.content.text("A proprietary 5-round steel box magazine for the scouting rifle."),
    variant_kind = "gun",
    variants = {
        {
            id = "steyr_scout_mag",
            name = ccb.content.text("Steyr Scout 5-round magazine"),
            description = ccb.content.text("A proprietary 5-round steel box magazine for the Steyr Scout rifle."),
        },
    },
    mass = "60 g",
    volume = "90 ml",
    length = "79 mm",
    price = "12 USD",
    survival_price = "2 USD 50 cent",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["308"] = 5 } } },
    magazine = { ammunition = { "308" } },
}

ccb.content.define_item {
    id = "steyr_scout_mag_makeshift",
    copy_from = "steyr_scout_mag",
    name = ccb.content.text("Scout rifle 3-round makeshift magazine"),
    description = ccb.content.text("A improvised 3-round steel box magazine held together by duct tape and hope, for use with the scouting rifle.  You could probably fit this inside its stock!"),
    variant_kind = "gun",
    variants = {
        {
            id = "steyr_scout_mag_makeshift",
            name = ccb.content.text("Steyr Scout 3-round makeshift magazine"),
            description = ccb.content.text("A improvised 3-round steel box magazine held together by duct tape and hope, for use with the Steyr Scout rifle.  You could probably fit this inside its stock!"),
        },
    },
    mass = "50 g",
    volume = "90 ml",
    length = "79 mm",
    price = "50 cent",
    survival_price = "50 cent",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["308"] = 3 } } },
    magazine = {},
}
