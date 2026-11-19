local ccb = require("ccb")

ccb.content.define_item {
    id = "remington700_270",
    copy_from = "gun_base_rifle_manual",
    looks_like = "modular_ar15",
    name = ccb.content.text("bolt-action hunting rifle"),
    description = ccb.content.text("Featuring a handsome set of wooden furnishings, a classic design, and a no nonsense .270 caliber chambering, this is a powerful hunting rifle.  With a tried and proven pedigree dating back over 60 years, millions of such rugged arms have been made, exported, and used throughout the United States and the world at large.  Where hunting is concerned, this is a highly capable and well proven weapon in all respects.  Fortunate, given that your prey in these dark days may turn out to be a little bit more feisty than typical White-Tailed deer, moose, and black bears."),
    variant_kind = "gun",
    variants = {
        {
            id = "remington700_270",
            name = ccb.content.text("Remington 700 .270 Win rifle"),
            description = ccb.content.text("A classic bolt-action rifle chambered for .270 Winchester, very popular among hunters.  This is a CDL SF model with a forged, fluted, 416 stainless steel barrel threaded into the receiver and a recessed bolt face.  It has checkered walnut furniture and a recoil pad to reduce perceived recoil."),
        },
    },
    ascii_picture = "rem700",
    mass = "3410 g",
    volume = "2202 ml",
    length = "1135 mm",
    price = "1 kUSD 126 USD",
    survival_price = "27 USD 50 cent",
    materials = { "steel", "wood" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["270win"] = 4 } } },
    inheritance = { add = { flags = { "BOLT_ACTION" } } },
    gun = {
        ammunition = { "270win" },
        dispersion = 70,
        clip_size = 4,
        barrel_volume = "750 ml",
        barrel_length = "610 mm",
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 1 },
            { id = "stock mount", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
    },
}
