local ccb = require("ccb")

-- Dimensions from Royal Armory blueprints, weight from vendor.
ccb.content.define_item {
    id = "enfield_303mag",
    looks_like = "stanag30",
    name = ccb.content.text("10-round Enfield magazine"),
    description = ccb.content.text("A steel 10-round magazine, for use in .303 caliber Enfield rifles."),
    mass = "160 g",
    volume = "138 ml",
    length = "85 mm",
    price = "64 USD 45 cent",
    survival_price = "5 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            allowed_speedloaders = { "clip303_5rd" },
            ammunition = { ["303"] = 10 },
        },
    },
    magazine = { ammunition = { "303" } },
}

-- Copied from 7.62x54R Clip.
ccb.content.define_item {
    id = "clip303_5rd",
    looks_like = "stanag30",
    category = "ammo",
    name = ccb.content.text(".303 5-round charger clip"),
    description = ccb.content.text("A tiny piece of grooved metal designed to allow a shooter to quickly load five .303 British rounds into a magazine."),
    mass = "9 g",
    volume = "3 ml",
    length = "74 mm",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "SPEEDLOADER" },
    pockets = { { kind = "MAGAZINE", ammunition = { ["303"] = 5 } } },
    magazine = { ammunition = { "303" } },
}
