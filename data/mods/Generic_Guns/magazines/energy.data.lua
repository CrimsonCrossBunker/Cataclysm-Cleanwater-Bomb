local ccb = require("ccb")

ccb.content.define_item {
    id = "gg_plasma_mag",
    copy_from = "caotel_plasma_ring",
    name = ccb.content.text("plasma condenser"),
    description = ccb.content.text("A bulky magazine that holds a dozen plasma cells.  It will be automatically expelled by the weapon once the ammo inside has been fired."),
    magazine = {},
}

ccb.content.define_item {
    id = "gg_nl_chem_thrower_mag",
    copy_from = "nl_chem_thrower_mag",
    name = ccb.content.text("odd charge pack"),
    description = ccb.content.text("Some kind of blocky battery pack made of unnaturally dense bone.  The connection-points look like stubby, fleshy gums, but despite their shape, otherwise appear to be copper."),
    magazine = {},
}
