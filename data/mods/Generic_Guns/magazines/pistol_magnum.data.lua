local ccb = require("ccb")

ccb.content.define_item {
    id = "pistol_magnum_mag",
    copy_from = "deaglemag",
    name = ccb.content.text("magnum pistol magazine"),
    description = ccb.content.text("An 8 round magazine for use with semi-automatic magnum pistols."),
    pockets = { { kind = "MAGAZINE", ammunition = { ammo_pistol_magnum = 8 }, rigid = true } },
    magazine = { ammunition = { "ammo_pistol_magnum" } },
}
