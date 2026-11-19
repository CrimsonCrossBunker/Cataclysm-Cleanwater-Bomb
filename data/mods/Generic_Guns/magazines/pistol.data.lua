local ccb = require("ccb")

ccb.content.define_item {
    id = "pistol_mag",
    copy_from = "glockmag",
    name = ccb.content.text("pistol magazine"),
    description = ccb.content.text("A flush fitting magazine for use with pistols and submachine guns.  Holds 15 rounds of standard pistol ammo."),
    pockets = { { kind = "MAGAZINE", ammunition = { ammo_pistol = 15 }, rigid = true } },
    magazine = { ammunition = { "ammo_pistol" } },
}

ccb.content.define_item {
    id = "pistol_smg_mag",
    copy_from = "glockbigmag",
    name = ccb.content.text("SMG magazine"),
    description = ccb.content.text("A long stick magazine for use with pistols and submachine guns.  Holds 30 rounds of standard pistol ammo."),
    pockets = { { kind = "MAGAZINE", ammunition = { ammo_pistol = 30 }, rigid = true } },
    magazine = { ammunition = { "ammo_pistol" } },
}

ccb.content.define_item {
    id = "pistol_speedloader",
    copy_from = "44_speedloader6",
    name = ccb.content.text("revolver speedloader"),
    description = ccb.content.text("A 'speedloader', a metal block capable of holding and releasing ammunition to aid in loading revolvers.  Accepts 6 standard or magnum pistol cartridges."),
    pockets = {
        {
            kind = "MAGAZINE",
            ammunition = { ammo_pistol = 6, ammo_pistol_magnum = 6 },
            rigid = true,
        },
    },
    magazine = { ammunition = { "ammo_pistol", "ammo_pistol_magnum" } },
}
