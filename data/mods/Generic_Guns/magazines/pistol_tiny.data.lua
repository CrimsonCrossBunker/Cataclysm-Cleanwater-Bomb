local ccb = require("ccb")

ccb.content.define_item {
    id = "pistol_tiny_mag",
    copy_from = "ruger_mk4_mag",
    name = ccb.content.text("target pistol magazine"),
    description = ccb.content.text("A flush fitting magazine for use with target pistols, capable of feeding 10 tiny pistol cartridges."),
    pockets = { { kind = "MAGAZINE", ammunition = { ammo_pistol_tiny = 10 }, rigid = true } },
    magazine = { ammunition = { "ammo_pistol_tiny" } },
}
