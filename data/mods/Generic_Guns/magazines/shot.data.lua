local ccb = require("ccb")

ccb.content.define_item {
    id = "shot_mag",
    copy_from = "saiga10mag",
    name = ccb.content.text("shotgun box magazine"),
    materials = { "plastic" },
    description = ccb.content.text("An 8 round box magazine for tactical shotguns.  Shotshells tend to not work well in box magazines due to their plastic hulls and the compression from the magazine spring."),
    pockets = { { kind = "MAGAZINE", ammunition = { ammo_shot = 8 }, rigid = true } },
    magazine = { capacity = 8, ammunition = { "ammo_shot" } },
}

ccb.content.define_item {
    id = "shot_speedloader",
    copy_from = "shot_speedloader6",
    name = ccb.content.text("shotgun speedloader"),
    description = ccb.content.text("A shotshell 'speedloader', a long plastic tube with a prominent plastic follower.  You can feed 6 shotshells into an appropriately modified shotgun by pushing the follower against the shotgun's loading port.  Bulky, but sees use in competition occasionally."),
    pockets = { { kind = "MAGAZINE", ammunition = { ammo_shot = 6 }, rigid = true } },
    magazine = { ammunition = { "ammo_shot" } },
}
