local ccb = require("ccb")

ccb.content.define_item {
    id = "vr_laptop_holosuite",
    copy_from = "vr_laptop",
    name = ccb.content.plural_text("VR rig - holosuite deployed", "VR rigs - holosuite deployed"),
    revert_to = "vr_laptop",
    flags = { "WATCH", "TRADER_AVOID", "SPAWN_ACTIVE" },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { power_draw = "1 W" },
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_aftershock_exoplanet_vr_laptop_holosuite_0" } },
    use_actions = {
        {
            kind = "transform",
            target = "vr_laptop",
            message = ccb.content.text("You power down the virtual overlay."),
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
        },
    },
}

ccb.content.define_item {
    id = "afs_shuttle_radiobeacon",
    name = "drone shuttle beacon",
    description = "A portable high-power radiobeacon.  Signals a drone shuttle from Port Augustmoon, which will make landfall in about 30 minutes and leave 4 hours later, whether you board it or not.  Single use, all expenses paid in advance, and non refundable.",
    symbol = ";",
    color = "yellow",
    category = "tools",
    mass = "340 g",
    volume = "1 L",
    price = "55 kUSD",
    survival_price = "55 kUSD",
    flags = { "NO_UNLOAD", "NO_RELOAD" },
    materials = { "plastic", "aluminum" },
    melee_damage = { bash = 6 },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            ammunition = { afs_shuttle_beacon = 1 },
        },
    },
    accuracy = -1,
    tool = { ammo_types = "afs_shuttle_beacon" },
}
