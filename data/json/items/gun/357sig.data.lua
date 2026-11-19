local ccb = require("ccb")

ccb.content.define_item {
    id = "p226_357sig",
    copy_from = "gun_base_357sig_semi_pistol",
    looks_like = "glock_17",
    name = ccb.content.text("SIG P226"),
    description = ccb.content.text("A SIG Sauer P226 chambered for .357 SIG.  The P226 is a DA/SA, short-recoil operated semi-automatic pistol."),
    mass = "964 g",
    volume = "549 ml",
    length = "232 mm",
    price = "500 USD",
    materials = { "steel", "aluminum", "plastic" },
    pockets = {
        {
            magazine_well = "250 ml",
            kind = "MAGAZINE_WELL",
            allowed_items = { "p226mag_12rd_357sig" },
        },
    },
    gun = {
        barrel_length = "112 mm",
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

ccb.content.define_item {
    id = "p320_357sig",
    copy_from = "gun_base_357sig_semi_pistol",
    looks_like = "glock_17",
    name = ccb.content.text("SIG P320 Compact"),
    description = ccb.content.text("The P320 Compact is a semi-automatic, short recoil operated pistol.  This one is chambered for .357 SIG."),
    ascii_picture = "sig_p320",
    mass = "731 g",
    volume = "462 ml",
    length = "217 mm",
    price = "690 USD",
    materials = { "plastic", "steel" },
    pockets = {
        {
            magazine_well = "250 ml",
            kind = "MAGAZINE_WELL",
            allowed_items = { "p320mag_13rd_357sig" },
        },
    },
    gun = {
        barrel_length = "99 mm",
        dispersion = 480,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail", count = 1 },
            { id = "sights", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}
