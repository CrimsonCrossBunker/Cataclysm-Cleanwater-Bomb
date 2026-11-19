local ccb = require("ccb")

ccb.content.define_item {
    id = "offset_sights",
    copy_from = "improve_sights",
    name = ccb.content.plural_text("offset iron sights", "offset iron sights"),
    description = ccb.content.text("An alternative set of iron sights mounted at 45° for use when a scope or other modification prevents use of the primary sights."),
    inheritance = { remove = { flags = { "DISABLE_SIGHTS" } }, scale = { sight_dispersion = 1.25 } },
    gunmod = {
        location = ccb.content.text("rail"),
        targets = {
            ccb.content.text("pistol", "gun_type_type"),
            ccb.content.text("smg", "gun_type_type"),
            ccb.content.text("rifle", "gun_type_type"),
            ccb.content.text("shotgun", "gun_type_type"),
            ccb.content.text("launcher", "gun_type_type"),
        },
    },
    minimum_skills = { { id = "weapon", count = 3 }, { id = "gun", count = 4 } },
}
