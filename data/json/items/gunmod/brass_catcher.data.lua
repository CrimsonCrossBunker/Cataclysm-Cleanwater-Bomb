local ccb = require("ccb")

ccb.content.define_item {
    id = "brass_catcher",
    name = ccb.content.plural_text("brass catcher", "brass catchers"),
    description = ccb.content.text("A bag that hangs off the side of your gun and catches ejected casings so you don't have to pick them up."),
    mass = "114 g",
    volume = "250 ml",
    price = "20 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = ":",
    color = "light_gray",
    pockets = { { kind = "CONTAINER", rigid = true, capacity = "249 ml", mass_limit = "1 kg" } },
    flags = { "BRASS_CATCHER" },
    gunmod = {
        install_time = "30 s",
        location = ccb.content.text("brass catcher"),
        targets = {
            ccb.content.text("shotgun", "gun_type_type"),
            ccb.content.text("smg", "gun_type_type"),
            ccb.content.text("rifle", "gun_type_type"),
            ccb.content.text("pistol", "gun_type_type"),
            ccb.content.text("launcher", "gun_type_type"),
        },
    },
    minimum_skills = { { id = "weapon", count = 1 } },
}

ccb.content.define_item {
    id = "big_brass_catcher",
    name = ccb.content.plural_text("big brass catcher", "big brass catchers"),
    description = ccb.content.text("A bag that hangs off the side of your gun and catches ejected casings so you don't have to pick them up.  This one is larger and made of canvas, so it can catch more casings before needing to be emptied.  Though the added convenience comes at the cost of being bulkier."),
    mass = "228 g",
    volume = "300 ml",
    price = "40 USD",
    survival_price = "1 USD",
    materials = { "canvas" },
    symbol = ":",
    color = "light_gray",
    pockets = { { kind = "CONTAINER", rigid = false, capacity = "500 ml", mass_limit = "2 kg" } },
    flags = { "BRASS_CATCHER" },
    gunmod = {
        install_time = "45 s",
        location = ccb.content.text("brass catcher"),
        targets = {
            ccb.content.text("shotgun", "gun_type_type"),
            ccb.content.text("smg", "gun_type_type"),
            ccb.content.text("rifle", "gun_type_type"),
            ccb.content.text("pistol", "gun_type_type"),
            ccb.content.text("launcher", "gun_type_type"),
        },
    },
    minimum_skills = { { id = "gun", count = 1 } },
}
