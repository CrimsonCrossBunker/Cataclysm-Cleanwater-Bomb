local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_HE_grenade",
    copy_from = "grenade_canister",
    looks_like = "grenade",
    name = ccb.content.plural_text("HE grenade", "HE grenades"),
    price = "450 USD",
    mass = "300 g",
    volume = "250 ml",
    description = ccb.content.text("A high explosive grenade that deals most of its damage through a powerful shockwave.  Reduced shrapnel makes it much safer to use in open spaces."),
    flags = { "RADIO_MODABLE", "RADIO_INVOKE_PROC", "BOMB", "GRENADE" },
    tool = {},
    use_actions = {
        {
            kind = "transform",
            need_wielding = true,
            target = "afs_HE_grenade_act",
            message = ccb.content.text("You pull the pin on the %s."),
            target_timer = "5 seconds",
            menu_text = ccb.content.text("Pull pin"),
        },
    },
}
