local ccb = require("ccb")

ccb.content.define_item {
    id = "hk_g80",
    copy_from = "gun_base_rifle_semi",
    looks_like = "modular_ar15",
    name = ccb.content.text("H&K G80 railgun"),
    description = ccb.content.text("A highly advanced infantry weapon that magnetically propels a ferromagnetic projectile using an alternating current.  Markings and serials imply it was manufactured by Heckler & Koch, but the maturity of the implemented technologies makes such a claim suspect.  Powered by UPS."),
    mass = "3914 g",
    volume = "4958 ml",
    length = "1005 mm",
    price = "19 kUSD 200 USD",
    survival_price = "120 USD",
    materials = { "steel" },
    flags = { "NEVER_JAMS", "NON_FOULING", "NEEDS_NO_LUBE", "USE_UPS" },
    pockets = { { kind = "MAGAZINE_WELL", magazine_well = "250 ml", allowed_items = { "hk_g80mag" } } },
    faults = {},
    gun = {
        ammunition = { "12mm" },
        range = 60,
        dispersion = 45,
        energy_drain = "5 kJ",
        mod_locations = {
            { id = "mechanism", count = 2 },
            { id = "rail", count = 1 },
            { id = "sights", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock", count = 1 },
            { id = "stock accessory", count = 2 },
            { id = "underbarrel", count = 1 },
        },
    },
}
