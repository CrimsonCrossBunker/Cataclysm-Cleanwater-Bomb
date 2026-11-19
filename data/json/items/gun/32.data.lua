local ccb = require("ccb")

ccb.content.define_item {
    id = "walther_ppk",
    copy_from = "gun_base_32_semi_pistol",
    looks_like = "glock_17",
    name = ccb.content.plural_text("Walther PPK pistol", "Walther PPK pistol"),
    description = ccb.content.text("One of the most famous handguns of the 20th century.  Your name is not Bond, but you might find this little gun still useful."),
    ascii_picture = "ppk",
    mass = "540 g",
    volume = "216 ml",
    length = "173 mm",
    price = "450 USD",
    materials = { "steel", "wood" },
    pockets = { { magazine_well = "250 ml", kind = "MAGAZINE_WELL", allowed_items = { "ppkmag" } } },
    gun = {
        barrel_length = "89 mm",
        dispersion = 480,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "lws32",
    looks_like = "glock_17",
    copy_from = "gun_base_32_semi_pistol",
    name = ccb.content.text("micro conceal carry pistol"),
    description = ccb.content.text("A very small pistol chambered in .32 ACP.  Due to its intended role, it lacks any sights."),
    variant_kind = "gun",
    variants = {
        {
            id = "lws32",
            name = ccb.content.text("Seecamp LWS 32"),
            description = ccb.content.text("A very small pistol chambered in .32 ACP.  It lacks any sort of sights as it's designed for very close engagement distances."),
        },
    },
    mass = "296 g",
    volume = "105 ml",
    length = "127 mm",
    price = "579 USD",
    survival_price = "1 USD",
    materials = { "steel", "plastic", "aluminum" },
    melee_damage = { bash = 3 },
    pockets = { { magazine_well = "41 ml", kind = "MAGAZINE_WELL", allowed_items = { "lws32mag" } } },
    gun = {
        barrel_length = "51 mm",
        dispersion = 480,
        sight_dispersion = 1200,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}
