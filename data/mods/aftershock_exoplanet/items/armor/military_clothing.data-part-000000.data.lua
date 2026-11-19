local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_jumpsuit_military",
    copy_from = "jumpsuit",
    looks_like = "jumpsuit",
    name = ccb.content.plural_text("military overalls", "military overalls"),
    description = ccb.content.text("A sturdy Nomex jumpsuit, normally worn by armed forces during transit or beneath combat armor while in the field."),
    materials = { { id = "nylon", portions = 7 }, { id = "nomex", portions = 3 } },
    variants = {},
    color = "light_gray",
    armor = { thickness = 0.4 },
}
