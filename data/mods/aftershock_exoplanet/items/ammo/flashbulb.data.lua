local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_82mm_flashbulb",
    price = "1600 USD",
    survival_price = "1600 USD",
    name = ccb.content.text("82x225mm flashbulb"),
    symbol = "=",
    color = "dark_gray",
    description = ccb.content.text("Pyrotechnic flash lamps designed to emit and focus a millisecond pulse laser through controlled detonation."),
    materials = { "steel", "powder" },
    volume = "1250 ml",
    length = "246 mm",
    mass = "3200 g",
    stack_size = 1,
    ammunition = {
        type = "afs_82mm_flashbulb",
        damage = { { type = "afs_laser", amount = 300, penetration = 50 } },
        range = 120,
        dispersion = 15,
        recoil = 45,
        count = 4,
        effects = { "COOKOFF", "LASER", "IGNITE", "DAZZLE_BEAM", "PUMP_LASER", "PLASMA_BUBBLE" },
    },
}
