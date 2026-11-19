local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_freeze_gauntlet",
    name = ccb.content.plural_text("psychrophile handling gloves", "psychrophile handling gloves"),
    description = ccb.content.text("These gloves are designed for handling organisms that live in extremely cold temperatures.  They can also be used to freeze your foes to death."),
    mass = "3778 g",
    volume = "2 L",
    price = "100 kUSD",
    survival_price = "200 USD",
    materials = { "superalloy" },
    symbol = "[",
    looks_like = "gauntlets_chitin",
    color = "light_cyan",
    accuracy = 0,
    flags = { "NO_REPAIR", "NONCONDUCTIVE", "SLOW_WIELD", "DURABLE_MELEE" },
    techniques = { "WBLOCK_1" },
    melee_damage = { bash = 3 },
    subtype_order = { "armor", "artifact" },
    armor = {
        thickness = 1,
        portions = { { encumbrance = 5, coverage = 100, covers = { "hand_l", "hand_r" } } },
    },
    artifact = { enchantments = { "ITEM_ENCH_aftershock_exoplanet_afs_freeze_gauntlet_0" } },
}
