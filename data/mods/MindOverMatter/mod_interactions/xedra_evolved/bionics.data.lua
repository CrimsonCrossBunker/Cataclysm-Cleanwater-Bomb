local ccb = require("ccb")

ccb.content.define_item {
    id = "bio_psi_range_increaser",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Noetic Range Booster CBM", "Noetic Range Booster CBMs"),
    description = ccb.content.text("Taken from another reality, this CBM enables much more distant channeling of psionic powers at the cost of occasional crippling headaches."),
    price = "7 kUSD 500 USD",
    mass = "500 g",
    bionic = { difficulty = 9 },
}
