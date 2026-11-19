local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_demo_charge",
    copy_from = "grenade_canister",
    looks_like = "c4",
    name = ccb.content.plural_text("demolition charge", "demolition charges"),
    price = "450 USD",
    description = ccb.content.text("A powerful explosive with a highly focused blast radius, often used for mining or demolition work.  It's configured to work alongside a radio detonator, and will explode immediately after activation."),
    flags = { "RADIO_ACTIVATION", "RADIO_INVOKE_PROC", "RADIOSIGNAL_1", "BOMB" },
    tool = {},
    use_actions = {
        {
            kind = "transform",
            need_wielding = true,
            target = "afs_demo_charge_act",
            message = ccb.content.text("You activate the demolition charge."),
            target_timer = "1 seconds",
            menu_text = ccb.content.text("Activate"),
        },
    },
}
