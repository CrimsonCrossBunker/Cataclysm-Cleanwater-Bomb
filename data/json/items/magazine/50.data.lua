local ccb = require("ccb")

ccb.content.define_item {
    id = "belt50",
    looks_like = "stanag30",
    copy_from = "magazine_belt",
    name = ccb.content.text(".50 BMG ammo belt"),
    pockets = { { kind = "MAGAZINE", rigid = false, ammunition = { ["50"] = 100 } } },
    magazine = { ammunition = { "50" }, capacity = 100, linkage = "ammolink50" },
}

-- Audited with ImageJ.  Weight from previous PR.
-- Fully loaded 10 magazine, presumably loaded with the 114.7 gram M33 Ball cartridge, weighs 1868.801 grams. Source inetres.com
ccb.content.define_item {
    id = "m107a1mag",
    looks_like = "stanag30",
    name = ccb.content.text(".50 semi-automatic rifle 10-round magazine"),
    description = ccb.content.text("A stout, 10-round box magazine for semi-automatic anti-materiel rifles."),
    variant_kind = "gun",
    variants = {
        {
            id = "m107a1mag",
            name = ccb.content.text("Barrett 10-round magazine"),
            description = ccb.content.text("A standard 10-round box magazine for the Barrett M107A1 anti-materiel rifle."),
        },
    },
    mass = "727 g",
    volume = "858 ml",
    length = "15 cm",
    price = "100 USD",
    survival_price = "2 USD 50 cent",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_BULKY" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["50"] = 10 } } },
    magazine = { ammunition = { "50" }, reload_time = 130 },
}

-- Audited with ImageJ.  Weight compared with M107A1.
ccb.content.define_item {
    id = "as50mag",
    looks_like = "stanag30",
    name = ccb.content.text(".50 precision rifle 5-round magazine"),
    description = ccb.content.text("A 5-round box magazine for .50-caliber precision rifles."),
    variant_kind = "gun",
    variants = {
        {
            id = "as50mag",
            name = ccb.content.text("AS50 5-round magazine"),
            description = ccb.content.text("A 5-round box magazine for the Accuracy International AS50 anti-materiel rifle."),
        },
    },
    mass = "386 g",
    volume = "455 ml",
    length = "133 mm",
    price = "120 USD",
    survival_price = "2 USD 50 cent",
    materials = { "steel" },
    symbol = "#",
    color = "dark_gray",
    flags = { "MAG_BULKY" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["50"] = 5 } } },
    magazine = { ammunition = { "50" }, reload_time = 110 },
}

-- No audit, just copied AS-50 magazine.
ccb.content.define_item {
    id = "tac50mag",
    looks_like = "stanag30",
    name = ccb.content.text(".50 bolt-action rifle 5-round magazine"),
    description = ccb.content.text("A 5-round box magazine for .50-caliber bolt-action anti-materiel rifles."),
    variant_kind = "gun",
    variants = {
        {
            id = "tac50mag",
            name = ccb.content.text("TAC-50 5-round magazine"),
            description = ccb.content.text("A 5-round box magazine for the McMillan TAC-50 anti-materiel rifle."),
        },
    },
    mass = "386 g",
    volume = "455 ml",
    length = "133 mm",
    price = "150 USD",
    survival_price = "2 USD 50 cent",
    materials = { "steel" },
    symbol = "#",
    color = "dark_gray",
    flags = { "MAG_BULKY" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["50"] = 5 } } },
    magazine = { ammunition = { "50" }, reload_time = 200 },
}
