local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_30x200mm",
    name = ccb.content.text("30x200mm FSAP"),
    description = ccb.content.text("Conventional anti-spacecraft kinetic penetration rounds, each containing a depleted uranium slug within a steel launch armature.  It's better to never be on the receiving end of one of these."),
    mass = "2200 g",
    length = "20 cm",
    volume = "1 L",
    price = "2 kUSD",
    survival_price = "2 kUSD",
    materials = { "lc_steel" },
    symbol = "=",
    color = "light_gray",
    melee_damage = { bash = 10 },
    ammunition = {
        casing = "afs_30x200mm_armature",
        count = 1,
        type = "30x200mm",
        range = 200,
        damage = { type = "bullet", amount = 800, penetration = 90 },
        dispersion = 10,
        effects = { "NON_FOULING" },
    },
}
