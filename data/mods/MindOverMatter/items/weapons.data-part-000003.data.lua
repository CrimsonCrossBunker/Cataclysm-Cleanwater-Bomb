local ccb = require("ccb")

ccb.content.define_item {
    id = "grenade_inferno_makeshift_act",
    category = "weapons",
    name = ccb.content.plural_text("active makeshift inferno grenade", "active makeshift inferno grenades"),
    description = ccb.content.text("This is an active makeshift inferno grenade.  Better throw it!"),
    mass = "230 g",
    volume = "270 ml",
    price = "0 cent",
    survival_price = "0 cent",
    accuracy = -1,
    melee_damage = { bash = 6 },
    materials = { "steel", "nether_crystal" },
    symbol = "*",
    color = "red",
    revert_to = "canister_empty",
    flags = { "ACT_IN_FIRE", "BOMB", "TRADER_AVOID", "DANGEROUS", "SPAWN_ACTIVE" },
    tool = {},
    countdown_action = {
        kind = "explosion",
        field_radius = 3,
        flash = true,
        field = "fd_fire",
        field_minimum = 2,
        field_maximum = 3,
    },
    countdown_interval = "5 seconds",
}
