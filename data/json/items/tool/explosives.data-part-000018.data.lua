local ccb = require("ccb")

ccb.content.define_item {
    id = "gelled_molotov_lit",
    copy_from = "gelled_molotov",
    looks_like = "molotov_lit",
    light = 15,
    flags = {
        "DANGEROUS", "NO_REPAIR", "WATER_EXTINGUISH", "DESTROY_ON_CHARGE_USE", "SPAWN_ACTIVE",
        "ACT_ON_RANGED_HIT", "NO_MANUAL_ACTIVATION",
    },
    tool = {},
    use_actions = { { kind = "explosion", ammo_effects = { "GELLED_MOLOTOV" }, blast = { power = 0 } } },
    tick_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            target = "gelled_molotov",
            chance = 2,
            message = ccb.content.text("Your lit gelled Molotov goes out."),
        },
    },
}
