local ccb = require("ccb")

ccb.content.define_item {
    id = "gg_plasma_cell",
    copy_from = "caotel_cell",
    name = ccb.content.text("plasma cell"),
    description = ccb.content.text("A small energy cell used to power plasma weapons."),
    ammunition = {},
}

ccb.content.define_item {
    id = "gg_nl_chem_thrower_ammo",
    copy_from = "nl_chem_thrower_ammo",
    name = ccb.content.text("chem charge"),
    description = ccb.content.text("Charges for an otherworldly chem rifle."),
    ammunition = {},
}
