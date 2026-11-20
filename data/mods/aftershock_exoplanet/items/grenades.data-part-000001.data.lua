local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_kaburaya_bomb_act",
    copy_from = "grenade_canister",
    looks_like = "c4",
    name = ccb.content.plural_text("armed Kabura-ya antipersonnel device", "armed Kabura-ya antipersonnel devices"),
    description = ccb.content.text("A tiny plastic explosive meant to be installed within a Kabura-ya drone.  It is on the verge of exploding."),
    flags = { "BOMB", "TRADER_AVOID" },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already pulled the pin, try throwing it instead."),
            menu_text = ccb.content.text_without_extraction("Pull pin"),
        },
    },
    countdown_action = {
        kind = "explosion",
        blast = {
            power = 100,
            max_noise = 25,
            distance_factor = 0.2,
            shrapnel = { casing_mass = 217, fragment_mass = 0.125 },
        },
    },
}
