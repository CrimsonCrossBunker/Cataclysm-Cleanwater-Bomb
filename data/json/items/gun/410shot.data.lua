local ccb = require("ccb")

-- Based on https://www.mossberg.com/500-bantam-50112.html
ccb.content.define_item {
    id = "mossberg_500_410",
    copy_from = "gun_base_shotgun_manual",
    looks_like = "mossberg_500",
    name = ccb.content.text("5-round small game shotgun"),
    description = ccb.content.text("This shotgun is a bit leaner and smaller than the others, being in .410 instead of the usual 12 gauge.  While the small caliber is more intended for small game, it will still kill zombies a-okay."),
    variant_kind = "gun",
    variants = {
        {
            id = "mossberg_500_410",
            name = ccb.content.text("Mossberg 500"),
            description = ccb.content.text("This Mossberg 500 is a bit slimmer and smaller than the others, being in .410 instead of the more common 12 gauge.  Still features a reliable pump-action, and despite the smaller caliber it will still no doubt kill."),
        },
    },
    ascii_picture = "mossberg590",
    mass = "2722 g",
    volume = "2191 ml",
    length = "1086 mm",
    price = "910 USD",
    materials = { "steel", "aluminum", "plastic" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["410shot"] = 5 } } },
    inheritance = { add = { flags = { "PUMP_ACTION" } } },
    gun = {
        barrel_length = "610 mm",
        dispersion = 320,
        clip_size = 5,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "loading port", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "muzzle", count = 1 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 1 },
            { id = "stock mount", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
        ammunition = { "410shot" },
    },
}
