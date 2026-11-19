local ccb = require("ccb")

-- 212.725 + 45mm max OAL for 454. Revolvers just built different.
ccb.content.define_item {
    id = "raging_bull",
    copy_from = "gun_base_handgun_manual",
    looks_like = "sw_619",
    name = ccb.content.plural_text("Taurus Raging Bull", "Taurus Raging Bull"),
    description = ccb.content.text("The Taurus Raging Bull is a 5-shot revolver chambered in .454 Casull.  It has impressive stopping power."),
    mass = "1502 g",
    volume = "565 ml",
    length = "332 mm",
    price = "641 USD",
    survival_price = "25 USD",
    materials = { "steel", "plastic" },
    pockets = {
        {
            kind = "MAGAZINE",
            ammunition = { ["454"] = 5, ["410shot"] = 5, ["45colt"] = 5 },
            allowed_speedloaders = { "454_speedloader5" },
        },
    },
    gun = {
        barrel_length = "258 mm",
        ammunition = { "454", "410shot", "45colt" },
        dispersion = 280,
        clip_size = 5,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}
