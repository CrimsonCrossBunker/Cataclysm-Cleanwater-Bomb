local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_hydraulic_gauntlet",
    name = ccb.content.text("hydraulic gauntlet"),
    description = ccb.content.text("A huge, heavy metal gauntlet lined with tubing and gauges.  Slow and unwieldy, it uses internal pressure to deliver devastating blows, but takes tremendous strength to use effectively.  Thanks to an internal microreactor, it doesn't require power of its own."),
    mass = "3778 g",
    volume = "2 L",
    price = "100 kUSD",
    survival_price = "200 USD",
    materials = { "qt_steel" },
    symbol = "[",
    looks_like = "gauntlets_chitin",
    color = "light_gray",
    flags = { "NO_REPAIR", "NONCONDUCTIVE", "SLOW_WIELD", "DURABLE_MELEE", "LEAK_DAM" },
    techniques = { "BRUTAL", "AFS_PRESSURE_CRUNCH" },
    melee_damage = { bash = 50 },
    armor = { portions = { { encumbrance = 5, coverage = 100, covers = { "hand_r" } } } },
}
