local ccb = require("ccb")

-- Comparatively audited from 7.62x54R clips.
ccb.content.define_item {
    id = "clip_77mm_arisaka",
    looks_like = "stanag30",
    category = "ammo",
    name = ccb.content.text("7.7x58mm 5-round stripper clip"),
    description = ccb.content.text("A tiny piece of grooved metal designed to allow a shooter to quickly load five 7.7x58mm rounds into a compatible firearm."),
    mass = "9 g",
    volume = "3 ml",
    length = "65 mm",
    price = "3 USD 99 cent",
    survival_price = "50 cent",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "SPEEDLOADER" },
    pockets = { { kind = "MAGAZINE", ammunition = { ["77mm_arisaka"] = 5 } } },
    magazine = { ammunition = { "77mm_arisaka" } },
}
