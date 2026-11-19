local ccb = require("ccb")

-- And it's therefore expensive.
ccb.content.define_item {
    id = "tokarev",
    copy_from = "gun_base_handgun_semi",
    looks_like = "glock_17",
    name = ccb.content.text("Tokarev handgun"),
    description = ccb.content.text("A symbol of Soviet pride and favored sidearm of Red Army officers, this is a compact pistol firing the punchy 7.62x25mm cartridge.  featuring an uncomfortable grip angle reminiscent of brandishing an unusually irate capital L at one's opponents, it is nevertheless a commendably accurate and durable handgun."),
    variant_kind = "gun",
    variants = {
        {
            id = "tokarev",
            name = ccb.content.text("Tokarev TT-33 pistol"),
            description = ccb.content.text("The Tokarev TT-33 is an antique Russian semiautomatic pistol, famous for its durability, accuracy, and uncomfortable grip angle.  It was chambered for the 7.62x25mm due to the popularity of the C96 pistol among Russian revolutionaries."),
        },
    },
    mass = "870 g",
    volume = "251 ml",
    length = "220 mm",
    price = "1 kUSD",
    survival_price = "12 USD 50 cent",
    materials = { "steel", "plastic" },
    pockets = { { magazine_well = "250 ml", kind = "MAGAZINE_WELL", allowed_items = { "tokarevmag" } } },
    gun = {
        barrel_length = "116 mm",
        ammunition = { "762x25" },
        dispersion = 225,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
        min_cycle_recoil = 270,
    },
}
