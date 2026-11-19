local ccb = require("ccb")

-- Either Rivtech or milspec would make it Expensive.  Combined, you could buy a half-decent car for the price.
ccb.content.define_item {
    id = "fcl_rm802",
    copy_from = "launcher_base",
    looks_like = "m79",
    name = ccb.content.text("RM802 grenade launcher"),
    description = ccb.content.text("The Rivtech RM802 pump-action 40mm grenade launcher was designed to be a step ahead of single-shot grenade launchers by allowing sustained heavy firepower.  However, its capacity is fairly limited so it must be used with careful planning."),
    mass = "3120 g",
    volume = "2500 ml",
    length = "820 mm",
    price = "29200 USD",
    survival_price = "80 USD",
    accuracy = -1,
    melee_damage = { bash = 8 },
    materials = { "superalloy", "ceramic" },
    flags = { "RELOAD_ONE", "WATERPROOF_GUN", "NEVER_JAMS" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["40x46mm"] = 4 } } },
    gun = {
        ammunition = { "40x46mm" },
        dispersion = 140,
        durability = 9,
        blackpowder_tolerance = 60,
        clip_size = 4,
        mod_locations = {
            { id = "accessories", count = 4 },
            { id = "brass catcher", count = 1 },
            { id = "grip", count = 1 },
            { id = "mechanism", count = 4 },
            { id = "rail", count = 1 },
            { id = "sights", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock", count = 1 },
            { id = "stock accessory", count = 2 },
            { id = "underbarrel", count = 1 },
        },
    },
}
