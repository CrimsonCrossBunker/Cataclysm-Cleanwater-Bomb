local ccb = require("ccb")

-- Crudely audited with ImageJ with online references.  These AK mags are difficult due to irregular shapes.
ccb.content.define_item {
    id = "ak74mag",
    looks_like = "stanag30",
    name = ccb.content.text("5.45mm 30-round AK magazine"),
    description = ccb.content.text("A standard magazine made for 5.45x39mm rifles, made mostly of polymer with steel reinforcements."),
    variant_kind = "gun",
    variants = {
        {
            id = "ak74mag",
            name = ccb.content.text("AK-74 30-round magazine"),
            description = ccb.content.text("A 30-round, curved box magazine for Kalashnikov AK-74 pattern firearms chambered in 5.45x39mm Soviet.  Generally made from steel-reinforced polymer, surplus examples found most utility within the contemporary United States in feeding semi-automatic examples of eastern bloc AK-74 rifles."),
        },
    },
    mass = "170 g",
    volume = "388 ml",
    length = "210 mm",
    price = "15 USD",
    survival_price = "1 USD",
    materials = { "steel", "plastic" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["545x39"] = 30 } } },
    magazine = { ammunition = { "545x39" } },
}

-- Compared to 30rd and used online references.
ccb.content.define_item {
    id = "rpk74mag",
    looks_like = "stanag30",
    name = ccb.content.text("5.45mm 45-round AK magazine"),
    description = ccb.content.text("A 45-round polymer magazine compatible with 5.45x39mm rifles, though originally designed for use with Soviet light machine guns built upon similar design pattens."),
    variant_kind = "gun",
    variants = {
        {
            id = "rpk74mag",
            name = ccb.content.text("AK-74 45-round magazine"),
            description = ccb.content.text("Originally built to feed Soviet RPK-74 light machine guns, this curved 45-round box magazine possesses an aggressive waffle texture pattern and also fits other Kalashnikov-based long guns, namely the AK-74 and modern civilian legal variants."),
        },
    },
    mass = "230 g",
    volume = "528 ml",
    length = "285 mm",
    price = "85 USD",
    survival_price = "2 USD 50 cent",
    materials = { "steel", "plastic" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_BULKY" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["545x39"] = 45 } } },
    magazine = { ammunition = { "545x39" }, reload_time = 130 },
}

-- Compared to 30rd and used online references.
ccb.content.define_item {
    id = "casket74mag",
    looks_like = "stanag30",
    name = ccb.content.text("5.45mm 60-round AK magazine"),
    description = ccb.content.text("A 60-round polymer magazine compatible with 5.45x39mm rifles."),
    variant_kind = "gun",
    variants = {
        {
            id = "casket74mag",
            name = ccb.content.text("AK-74 60-round casket magazine"),
            description = ccb.content.text("A casket magazine that combines four stacks of 5.45x39mm Soviet ammunition into a solid brick of plastic, built for interfacing with the magazine wells of Kalashnikov-pattern firearms, namely the AK-74 assault rifle and subsequent derivatives."),
        },
    },
    mass = "264 g",
    volume = "924 ml",
    length = "250 mm",
    price = "85 USD",
    survival_price = "2 USD 50 cent",
    materials = { "steel", "plastic" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["545x39"] = 60 } } },
    magazine = { ammunition = { "545x39" }, reload_time = 130 },
}
