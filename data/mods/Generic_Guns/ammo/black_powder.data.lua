local ccb = require("ccb")

ccb.content.define_item {
    id = "black_powder_ball",
    copy_from = "flintlock_ammo",
    name = ccb.content.text("paper cartridge"),
    description = ccb.content.text("A paper cartridge containing black powder and a lead ball.  Historically used to reload muzzleloaders in a more reasonable time."),
    ammunition = { type = "ammo_black_powder" },
}

ccb.content.define_item {
    id = "black_powder_shot",
    copy_from = "flintlock_shot",
    name = ccb.content.text("paper shot cartridge"),
    description = ccb.content.text("A paper cartridge containing black powder and metallic shot.  Historically used to reload muzzleloaders in a more reasonable time."),
    ammunition = { type = "ammo_black_powder" },
}
