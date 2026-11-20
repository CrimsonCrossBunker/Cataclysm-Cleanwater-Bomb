local ccb = require("ccb")

ccb.content.define_item {
    id = "smart_phone_locked_flashlight",
    copy_from = "smart_phone_locked",
    name = ccb.content.plural_text("smartphone (locked) - Flashlight", "smartphones (locked) - Flashlight"),
    revert_to = "smart_phone_locked",
    light = 20,
    inheritance = { add = { flags = { "CHARGEDIM", "TRADER_AVOID", "SPAWN_ACTIVE" } } },
    tool = { power_draw = "1500 mW" },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            target = "smart_phone_locked",
            message = ccb.content.text("You deactivate the flashlight app."),
            menu_text = ccb.content.text("Turn off flashlight"),
        },
        { kind = "link_up", cable_length = 3, charge_rate = "20 W" },
    },
}
