local ccb = require("ccb")

ccb.content.define_item {
    id = "glock_31",
    copy_from = "glock_22",
    name = ccb.content.text("Glock 31"),
    description = ccb.content.text("A full size .357 SIG Glock pistol.  It is extremely similar to the Glock 22, and could be converted to fire .40 S&W by switching the barrel."),
    ascii_picture = "glock_20",
    mass = "660 g",
    volume = "443 ml",
    length = "234 mm",
    survival_price = "22 USD 50 cent",
    flags = { "NO_TURRET" },
    gun = { barrel_length = "114 mm", min_cycle_recoil = 450 },
}
