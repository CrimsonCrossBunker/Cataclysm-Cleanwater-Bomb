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
