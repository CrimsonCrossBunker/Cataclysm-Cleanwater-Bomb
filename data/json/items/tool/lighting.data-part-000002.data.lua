local ccb = require("ccb")

-- Open flame or effectively so. ~5 seconds to transfer flame assuming optimal conditions, a minute at worst.
ccb.content.define_item {
    id = "oil_lamp_on",
    copy_from = "oil_lamp",
    name = ccb.content.plural_text("kerosene lamp", "kerosene lamps"),
    description = ccb.content.text("A kerosene-fueled lamp.  It does not provide much light, but it lasts a long time.  It is turned on.  Use it to turn it off."),
    revert_to = "oil_lamp",
    light = 10,
    flags = {
        "TRADER_AVOID",
        "FIRE",
        "ALLOWS_REMOTE_USE",
        "WATER_EXTINGUISH",
        "FIRESTARTER",
        "SPAWN_ACTIVE",
    },
    tool = { turns_per_charge = 240 },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            target = "oil_lamp",
            message = ccb.content.text("The lamp is extinguished."),
            menu_text = ccb.content.text("Turn off"),
        },
        { kind = "firestarter", moves = 500, slow_moves = 6000 },
    },
}
