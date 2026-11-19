local ccb = require("ccb")

ccb.content.define_item {
    id = "black_powder_pistol",
    copy_from = "pistol_flintlock",
    name = ccb.content.text("antique pistol"),
    description = ccb.content.text("This antiquated single shot pistol would complete a pirate's outfit nicely.  While its loading may be slow, it does not require brass casings to fire, and is theoretically sustainable.  Range and accuracy are hampered by lack of rifling, but this old design is still plenty lethal."),
    pockets = { { kind = "MAGAZINE", ammunition = { ammo_black_powder = 1 }, rigid = true } },
    gun = { ammunition = { "ammo_black_powder" }, clip_size = 1 },
}

ccb.content.define_item {
    id = "black_powder_revolver",
    copy_from = "colt_army",
    name = ccb.content.text("antique revolver"),
    description = ccb.content.text("This is an old revolver designed during the period of westward expansion.  Black powder paper cartridges must be loaded for each shot, which is a fairly lengthy process.  Despite its age, this type of weapon would perform adequately against most two-legged threats."),
    pockets = { { kind = "MAGAZINE", ammunition = { ammo_black_powder = 6 }, rigid = true } },
    gun = { ammunition = { "ammo_black_powder" }, clip_size = 6 },
}

ccb.content.define_item {
    id = "black_powder_rifle",
    copy_from = "rifle_flintlock",
    name = ccb.content.text("antique musket"),
    description = ccb.content.text("An antique design, this smoothbore long arm would look more at home on a pre-1850's battlefield than in your hands in the Cataclysm.  Its loading may be slow, but it does not require brass casings to fire, and is theoretically sustainable to fire.  Range and accuracy are hampered by lack of rifling, but this time-tested design is plenty lethal."),
    pockets = { { kind = "MAGAZINE", ammunition = { ammo_black_powder = 1 }, rigid = true } },
    gun = { ammunition = { "ammo_black_powder" }, clip_size = 1 },
}
