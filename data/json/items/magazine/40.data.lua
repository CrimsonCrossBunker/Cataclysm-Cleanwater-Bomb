local ccb = require("ccb")

-- Audited with ImageJ.  Weight from 15rd mag ratio.
ccb.content.define_item {
    id = "glock40bigmag",
    looks_like = "glock17_17",
    name = ccb.content.text("Glock .40 S&W 22-round magazine"),
    description = ccb.content.text("An extended 22-round magazine for use with Glock pistols chambered for .40 S&W."),
    mass = "97 g",
    volume = "113 ml",
    length = "15 cm",
    price = "59 USD",
    survival_price = "2 USD 50 cent",
    materials = { "plastic" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["40"] = 22 } } },
    magazine = { ammunition = { "40" }, reload_time = 140 },
}

-- Audited with ImageJ.  Weight from manufacturer.
ccb.content.define_item {
    id = "glock40mag",
    looks_like = "glock17_17",
    name = ccb.content.text("Glock .40 S&W 15-round magazine"),
    description = ccb.content.text("A compact, light-weight polymer magazine for use with Glock pistols chambered for .40 S&W."),
    mass = "78 g",
    volume = "91 ml",
    length = "12 cm",
    price = "32 USD",
    survival_price = "1 USD",
    materials = { "plastic" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["40"] = 15 } } },
    magazine = { ammunition = { "40" } },
}

ccb.content.define_item {
    id = "glock40mag_10",
    name = ccb.content.text("Glock .40 S&W 10-round magazine"),
    description = ccb.content.text("A compact, light-weight polymer magazine for use with Glock pistols chambered for .40 S&W.  It has been limited to 10 rounds to comply with firearm laws."),
    copy_from = "glock40mag",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["40"] = 10 } } },
    magazine = {},
}

ccb.content.define_item {
    id = "glock40mag_9",
    name = ccb.content.text("Glock 27 magazine"),
    description = ccb.content.text("A compact, light-weight polymer magazine with a 9 round capacity for use with Glock pistols chambered for .40 S&W."),
    mass = "55 g",
    volume = "85 ml",
    length = "11 cm",
    price = "32 USD",
    survival_price = "1 USD",
    materials = { "plastic" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["40"] = 9 } } },
    magazine = { ammunition = { "40" } },
}

-- Audited with ImageJ.  Weight from Beretta 12rd ratio.
ccb.content.define_item {
    id = "px4_40mag",
    looks_like = "glock17_17",
    name = ccb.content.text("Px4 .40 S&W 14-round magazine"),
    description = ccb.content.text("A magazine for the Px4 Storm chambered for .40 S&W.  It holds 14 rounds."),
    mass = "100 g",
    volume = "81 ml",
    length = "12 cm",
    price = "32 USD",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["40"] = 14 } } },
    magazine = { ammunition = { "40" }, reload_time = 140 },
}

-- Audited with ImageJ.  Weight from Beretta 12rd ratio.
ccb.content.define_item {
    id = "px4_40mag_10",
    looks_like = "glock17_17",
    name = ccb.content.text("Px4 .40 S&W 10-round magazine"),
    description = ccb.content.text("A magazine for the Px4 Storm chambered for .40 S&W.  It holds 10 rounds."),
    copy_from = "px4_40mag",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["40"] = 10 } } },
    magazine = {},
}

-- Values copied from Beretta 12rd magazine.
ccb.content.define_item {
    id = "sig40mag",
    looks_like = "glock17_17",
    name = ccb.content.text("SIG Pro .40 12-round magazine"),
    description = ccb.content.text("A compact and reliable magazine for use with the SIG Pro .40 pistol."),
    mass = "95 g",
    volume = "77 ml",
    length = "12 cm",
    price = "39 USD",
    survival_price = "1 USD",
    materials = { "plastic", "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["40"] = 12 } } },
    magazine = { ammunition = { "40" } },
}

-- Used 22rds of .40 as the basis for dimensions.
ccb.content.define_item {
    id = "smg_40_mag",
    looks_like = "mp5mag",
    variant_kind = "gun",
    name = ccb.content.text("Luty .40 20-round magazine"),
    description = ccb.content.text("An improvised magazine that is mostly compatible with a homemade 'Luty' submachine gun, with a simplified feed system.  It looks like it might feed 20 rounds of .40 S&W."),
    variants = {
        {
            id = "smg_40_mag",
            name = ccb.content.text(".40 20-round makeshift magazine"),
            description = ccb.content.text("An improvised magazine that is mostly compatible with a homemade 'Luty' submachine gun, with a simplified feed system.  It looks like it might feed 20 rounds of .40 S&W."),
        },
    },
    mass = "207 g",
    volume = "172 ml",
    length = "24 cm",
    price = "40 USD",
    survival_price = "50 cent",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["40"] = 20 } } },
    magazine = { ammunition = { "40" }, reload_time = 160 },
}

-- Copied from .45 magazine.
ccb.content.define_item {
    id = "ump40mag",
    looks_like = "mp5mag",
    name = ccb.content.text("UMP-40 30-round magazine"),
    description = ccb.content.text("A straight, double-stack plastic box magazine for the UMP sub-machine gun in .40 S&W.  Holds 30 rounds."),
    mass = "150 g",
    volume = "206 ml",
    length = "22 cm",
    price = "40 USD",
    survival_price = "50 cent",
    materials = { "plastic", "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["40"] = 30 } } },
    magazine = { ammunition = { "40" } },
}

-- Audited with ImageJ.  Weight estimated.
ccb.content.define_item {
    id = "bhp40mag",
    looks_like = "glock17_17",
    name = ccb.content.text("Hi-Power .40 S&W 10-round magazine"),
    description = ccb.content.text("A 10-round steel box magazine for the Browning Hi-Power .40 S&W."),
    mass = "100 g",
    volume = "74 ml",
    length = "10 cm",
    price = "40 USD",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["40"] = 10 } } },
    magazine = { ammunition = { "40" } },
}

-- Copied from .45 High-Point JHP magazine.
ccb.content.define_item {
    id = "hptjcpmag",
    looks_like = "glock17_17",
    name = ccb.content.text("Model JCP 10-round magazine"),
    description = ccb.content.text("A 10-round steel box magazine for use with the Hi-Point Model JCP."),
    mass = "110 g",
    volume = "92 ml",
    length = "132 mm",
    price = "25 USD",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["40"] = 10 } } },
    magazine = { ammunition = { "40" } },
}
