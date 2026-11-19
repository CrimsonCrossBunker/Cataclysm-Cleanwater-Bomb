local ccb = require("ccb")

ccb.content.define_item {
    id = "shotcestus",
    copy_from = "gun_base_shotgun_manual",
    name = ccb.content.plural_text("shotcestus", "shotcestuses"),
    description = ccb.content.text("A sawn-off double-barrel shotgun mounted on a metal cestus.  The lack of a stock to absorb recoil means some strength is required to fire."),
    mass = "1566 g",
    volume = "1500 ml",
    price = "200 USD",
    materials = { "steel" },
    techniques = { "WBLOCK_1", "BRUTAL" },
    min_strength = 7,
    flags = { "DURABLE_MELEE", "NEVER_JAMS", "RELOAD_EJECT", "RELOAD_ONE", "OBSOLETE" },
    pockets = { { kind = "MAGAZINE", ammunition = { shot = 2 } } },
    melee_damage = { bash = 12 },
    armor = { portions = { { encumbrance = 5, coverage = 20, covers = { "hand_r" } } } },
}
