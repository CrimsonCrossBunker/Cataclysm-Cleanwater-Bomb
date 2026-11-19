local ccb = require("ccb")

ccb.content.define_item {
    id = "iso_sorcerers_robe",
    name = ccb.content.text("robe of the gloaming tower"),
    copy_from = "robe_wizard",
    looks_like = "robe_wizard",
    description = ccb.content.text("A black robe fading into dark blue at the hem, indicating your status as one of the Arch-wizards of the Dreaming City."),
    armor = {},
}
