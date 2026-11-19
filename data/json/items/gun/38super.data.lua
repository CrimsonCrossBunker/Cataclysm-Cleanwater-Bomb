local ccb = require("ccb")

ccb.content.define_item {
    id = "m1911a1_38super",
    copy_from = "gun_base_handgun_semi",
    looks_like = "glock_17",
    name = ccb.content.text("M1911A1"),
    description = ccb.content.text("The M1911A1 is an extremely popular pistol known for its reliability.  This one is chambered for .38 Super."),
    mass = "1157 g",
    volume = "462 ml",
    length = "247 mm",
    price = "784 USD",
    survival_price = "20 USD",
    materials = { "steel", "plastic" },
    pockets = {
        {
            magazine_well = "250 ml",
            kind = "MAGAZINE_WELL",
            allowed_items = { "m1911mag_10rd_38super" },
        },
    },
    gun = {
        barrel_length = "127 mm",
        ammunition = { "38super" },
        dispersion = 480,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}
