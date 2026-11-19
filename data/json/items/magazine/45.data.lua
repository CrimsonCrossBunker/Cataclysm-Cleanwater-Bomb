local ccb = require("ccb")

-- Audited with ImageJ. Weight from ratio 1.2g/ml.
ccb.content.define_item {
    id = "mac10mag",
    looks_like = "mp5mag",
    name = ccb.content.text("MAC-10 30-round magazine"),
    description = ccb.content.text("A cheap 30-round steel box magazine for use with the MAC-10 SMG."),
    mass = "221 g",
    volume = "184 ml",
    length = "21 cm",
    price = "18 USD",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["45"] = 30 } } },
    magazine = { ammunition = { "45" } },
}

-- Not a real magazine. Weight from ratio 1.2g/ml.
ccb.content.define_item {
    id = "smg_45_mag",
    looks_like = "mp5mag",
    name = ccb.content.text("MAC-10 20-round makeshift magazine"),
    description = ccb.content.text("An improvised 20-round straight single-stack box magazine consisting of little more than a bent sheet of steel held together by duct tape and hope, for use with the MAC-10 SMG."),
    mass = "269 g",
    volume = "224 ml",
    price = "40 USD",
    survival_price = "50 cent",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["45"] = 20 } } },
    magazine = { ammunition = { "45" }, reload_time = 160 },
}

-- Dimensions via ImageJ.  Weight from vendor.
ccb.content.define_item {
    id = "tdi_mag",
    looks_like = "mp5mag",
    name = ccb.content.text("Glock SMG 30-round magazine"),
    description = ccb.content.text("An aftermarket 30-round polymer and steel box magazine designed for use with the Glock pistol."),
    variant_kind = "gun",
    variants = {
        {
            id = "tdi_mag",
            name = ccb.content.text("Vector SMG 30-round magazine"),
            description = ccb.content.text("A 30-round polymer and steel box magazine for use with the KRISS Vector."),
        },
    },
    mass = "124 g",
    volume = "211 ml",
    length = "23 cm",
    price = "18 USD",
    survival_price = "1 USD",
    materials = { "plastic", "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["45"] = 30 } } },
    magazine = { ammunition = { "45" } },
}

-- Audited with ImageJ.  Weight from book.
ccb.content.define_item {
    id = "thompson_bigmag",
    looks_like = "mp5mag",
    name = ccb.content.text("Thompson 30-round magazine"),
    description = ccb.content.text("An extended 30-round magazine for the Thompson submachine gun."),
    mass = "226 g",
    volume = "209 ml",
    length = "21 cm",
    price = "40 USD",
    survival_price = "2 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["45"] = 30 } } },
    magazine = { ammunition = { "45" }, reload_time = 120 },
}

-- Audited with ImageJ.
ccb.content.define_item {
    id = "thompson_drum",
    looks_like = "mp5mag",
    name = ccb.content.text("Thompson 50-round drum magazine"),
    description = ccb.content.text("A 50-round drum magazine for the Thompson submachine gun.  Made famous by gangsters, but the military preferred standard 20 and 30-round magazines due to greater reliability."),
    mass = "1110 g",
    volume = "1385 ml",
    length = "21 cm",
    price = "80 USD",
    survival_price = "5 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_BULKY" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["45"] = 50 } } },
    magazine = { ammunition = { "45" }, reload_time = 150, jam_multiplier = 2 },
}

-- Audited with ImageJ. Weight from 1.2g/ml ratio.
ccb.content.define_item {
    id = "thompson_mag",
    looks_like = "mp5mag",
    name = ccb.content.text("Thompson 20-round magazine"),
    description = ccb.content.text("A standard 20-round magazine for the Thompson submachine gun."),
    mass = "182 g",
    volume = "152 ml",
    length = "154 mm",
    price = "30 USD",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["45"] = 20 } } },
    magazine = { ammunition = { "45" } },
}

-- Not a real magazine. Weight from 1.2g/ml ratio.
ccb.content.define_item {
    id = "thompson_makeshiftmag",
    looks_like = "mp5mag",
    name = ccb.content.text("Thompson 20-round makeshift magazine"),
    description = ccb.content.text("An improvised 20-round straight single-stack box magazine consisting of little more than a bent sheet of steel held together by duct tape and hope, for use with the Thompson SMG."),
    mass = "322 g",
    volume = "268 ml",
    length = "268 mm",
    price = "30 USD",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["45"] = 20 } } },
    magazine = { ammunition = { "45" } },
}

-- Audited with ImageJ. Weight estimated.
ccb.content.define_item {
    id = "ump45mag",
    looks_like = "mp5mag",
    name = ccb.content.text("UMP-45 25-round magazine"),
    description = ccb.content.text("A straight, double-stack plastic box magazine for the UMP sub-machine gun in .45 ACP.  Holds 25 rounds."),
    mass = "150 g",
    volume = "206 ml",
    length = "22 cm",
    price = "49 USD 50 cent",
    survival_price = "1 USD",
    materials = { "plastic", "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["45"] = 25 } } },
    magazine = { ammunition = { "45" } },
}

-- Not a real magazine. Weight from 1.2g/ml ratio.
ccb.content.define_item {
    id = "ump45_makeshiftmag",
    looks_like = "mp5mag",
    name = ccb.content.text("UMP-45 20-round makeshift magazine"),
    description = ccb.content.text("An improvised 20-round straight single-stack box magazine consisting of little more than a bent sheet of steel held together by duct tape and hope, for use with the H&K UMP-45 SMG."),
    mass = "302 g",
    volume = "252 ml",
    length = "268 mm",
    price = "49 USD 50 cent",
    survival_price = "50 cent",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["45"] = 20 } } },
    magazine = { ammunition = { "45" } },
}

-- length 5.13 in, width 1.38 in, height 0.978 in, raw 113.46 ml, trim 2.5%
ccb.content.define_item {
    id = "usp45mag",
    looks_like = "glock17_17",
    name = ccb.content.text("USP .45 pistol 12-round magazine"),
    description = ccb.content.text("A 12-round magazine for use with the USP pistol."),
    variant_kind = "gun",
    variants = {
        {
            id = "usp45mag",
            name = ccb.content.text("USP .45 12-round magazine"),
            description = ccb.content.text("A standard capacity magazine for use with the H&K USP handgun."),
        },
    },
    mass = "99 g",
    volume = "116 ml",
    length = "130 mm",
    price = "49 USD",
    survival_price = "1 USD",
    materials = { "plastic" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["45"] = 12 } } },
    magazine = { ammunition = { "45" } },
}

-- Audited with ImageJ.  Weight from UMP mag ratio.
ccb.content.define_item {
    id = "usc10mag",
    looks_like = "stanag30",
    name = ccb.content.text("H&K USC 45 Carbine 10-round magazine"),
    description = ccb.content.text("A 10-round magazine for use with the H&K USC 45 Carbine."),
    mass = "123 g",
    volume = "169 ml",
    length = "18 cm",
    price = "33 USD 99 cent",
    survival_price = "1 USD",
    materials = { "plastic", "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["45"] = 10 } } },
    magazine = { ammunition = { "45" } },
}

ccb.content.define_item {
    id = "usc15mag",
    looks_like = "stanag30",
    name = ccb.content.text("H&K USC 45 Carbine 15-round magazine"),
    description = ccb.content.text("A 15-round magazine for use with the H&K USC 45 Carbine."),
    mass = "217 g",
    volume = "240 ml",
    length = "18 cm",
    price = "36 USD 99 cent",
    survival_price = "1 USD 50 cent",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["45"] = 15 } } },
    magazine = { ammunition = { "45" } },
}

ccb.content.define_item {
    id = "usc20mag",
    looks_like = "stanag30",
    name = ccb.content.text("H&K USC 45 Carbine 20-round magazine"),
    description = ccb.content.text("A 20-round magazine for use with the H&K USC 45 Carbine."),
    mass = "290 g",
    volume = "320 ml",
    length = "18 cm",
    price = "39 USD 99 cent",
    survival_price = "2 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["45"] = 20 } } },
    magazine = { ammunition = { "45" } },
}

-- Audited with ImageJ.  Weight from Vendor.
ccb.content.define_item {
    id = "ppq45mag",
    looks_like = "glock17_17",
    name = ccb.content.text("PPQ .45 12-round magazine"),
    description = ccb.content.text("A 12-round steel box magazine for the PPQ pistol."),
    variant_kind = "gun",
    variants = {
        {
            id = "ppq45mag",
            name = ccb.content.text("PPQ 45 ACP 12-round magazine"),
            description = ccb.content.text("A 12-round steel box magazine for the Walther PPQ 45 ACP."),
        },
    },
    mass = "80 g",
    volume = "105 ml",
    length = "128 mm",
    price = "50 USD",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["45"] = 12 } } },
    magazine = { ammunition = { "45" } },
}

-- Audited with ImageJ.  Weight estimated.
ccb.content.define_item {
    id = "hptjhpmag",
    looks_like = "glock17_17",
    name = ccb.content.text("Model JHP 9-round magazine"),
    description = ccb.content.text("A 9-round steel box magazine for use with the Hi-Point Model JHP."),
    mass = "110 g",
    volume = "92 ml",
    length = "132 mm",
    price = "25 USD",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["45"] = 9 } } },
    magazine = { ammunition = { "45" } },
}

-- Audited with ImageJ.  Weight from Manufacturer.
ccb.content.define_item {
    id = "glock_21mag",
    looks_like = "glock17_17",
    name = ccb.content.text("Glock .45 13-round magazine"),
    description = ccb.content.text("A 13-round magazine for use with Glock firearms chambered in .45 ACP."),
    variant_kind = "gun",
    variants = {
        {
            id = "glock_21mag",
            name = ccb.content.text("Glock 21 13-round magazine"),
            description = ccb.content.text("A standard capacity magazine for use with the Glock 21."),
        },
    },
    mass = "85 g",
    volume = "114 ml",
    length = "125 mm",
    price = "40 USD",
    survival_price = "1 USD",
    materials = { "plastic" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["45"] = 13 } } },
    magazine = { ammunition = { "45" } },
}

-- Audited with ImageJ.  Weight from Manufacturer.
ccb.content.define_item {
    id = "glock_21mag_10",
    looks_like = "glock17_17",
    name = ccb.content.text("Glock .45 10-round magazine"),
    description = ccb.content.text("A 10-round magazine for use with Glock firearms chambered in .45 ACP."),
    variant_kind = "gun",
    variants = {
        {
            id = "glock_21mag_10",
            name = ccb.content.text("Glock 21 10-round magazine"),
            description = ccb.content.text("A 10-round magazine for use with the Glock 21."),
        },
    },
    copy_from = "glock_21mag",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["45"] = 10 } } },
    magazine = {},
}

-- Audited with ImageJ.  Weight from Vendor.
ccb.content.define_item {
    id = "glock_21mag26",
    looks_like = "glock17_17",
    name = ccb.content.text("Glock .45 26-round magazine"),
    description = ccb.content.text("A 26-round magazine for use with Glock firearms chambered in .45 ACP."),
    variant_kind = "gun",
    variants = {
        {
            id = "glock_21mag26",
            name = ccb.content.text("Glock 21 26-round magazine"),
            description = ccb.content.text("A double-capacity magazine for use with the Glock 21."),
        },
    },
    mass = "159 g",
    volume = "205 ml",
    length = "225 mm",
    price = "40 USD",
    survival_price = "1 USD",
    materials = { "plastic" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["45"] = 26 } } },
    magazine = { ammunition = { "45" } },
}

-- delete variants from glock 21 mag
ccb.content.define_item {
    id = "glock36_mag",
    looks_like = "glock17_17",
    name = ccb.content.text("Glock 36 magazine"),
    description = ccb.content.text("A 6-round magazine for the Glock 36.  Incompatible with other .45 Glocks."),
    variants = {},
    mass = "70 g",
    volume = "72 ml",
    copy_from = "glock_21mag",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["45"] = 6 } } },
    magazine = {},
}

ccb.content.define_item {
    id = "greasegun30mag",
    looks_like = "mp5mag",
    name = ccb.content.text(".45 WWII SMG 30-round magazine"),
    description = ccb.content.text("A standard 30-round magazine for the .45 WWII submachine gun."),
    variant_kind = "gun",
    variants = {
        {
            id = "greasegun30mag",
            name = ccb.content.text("M3 SMG 30-round magazine"),
            description = ccb.content.text("A standard 30-round magazine for the M3 submachine gun."),
        },
    },
    mass = "340 g",
    volume = "227 ml",
    length = "235 mm",
    price = "30 USD",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["45"] = 30 } } },
    magazine = { ammunition = { "45" } },
}

-- Audited from IRL measurements.
ccb.content.define_item {
    id = "m1911bigmag",
    name = ccb.content.text("M1911 10-round magazine"),
    description = ccb.content.text("An extended 10-round magazine for use with the M1911 handgun."),
    mass = "79 g",
    volume = "74 ml",
    length = "155 mm",
    price = "37 USD 20 cent",
    survival_price = "2 USD 50 cent",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["45"] = 10 } } },
    magazine = { ammunition = { "45" } },
}

-- Previous PR, looks good.
ccb.content.define_item {
    id = "m1911mag",
    name = ccb.content.text("M1911 7-round magazine"),
    description = ccb.content.text("A military issue 7-round magazine for use with the M1911 handgun."),
    mass = "70 g",
    volume = "61 ml",
    length = "132 mm",
    price = "29 USD 80 cent",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["45"] = 7 } } },
    magazine = { ammunition = { "45" } },
}
