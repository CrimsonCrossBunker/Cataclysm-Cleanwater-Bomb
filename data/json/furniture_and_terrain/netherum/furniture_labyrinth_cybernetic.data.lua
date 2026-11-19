local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_nl_exodii_lamp",
    copy_from = "f_exodii_lamp",
    looks_like = "f_exodii_lamp",
    name = ccb.content.text("strange utility light"),
    description = ccb.content.text("Parts of this utility light have a curved appearance, as though the metal were grown in a lab.  The round bulb emits an eerie greenish glow."),
}
