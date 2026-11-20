local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_toxic_grenade",
    copy_from = "grenade_canister",
    looks_like = "grenade",
    name = ccb.content.plural_text("neurotoxin grenade", "neurotoxin grenades"),
    price = "650 USD",
    mass = "300 g",
    volume = "250 ml",
    description = ccb.content.text("A neurotoxic device that deploys thick swathes of toxic foam upon detonation.  Exposure proves fatal within seconds.  Use against human targets is considered in breach of the Ganymede Accords."),
    flags = { "RADIO_MODABLE", "RADIO_INVOKE_PROC", "BOMB", "GRENADE" },
    tool = {},
    use_actions = {
        {
            kind = "transform",
            need_wielding = true,
            target = "afs_toxic_grenade_act",
            message = ccb.content.text("You pull the pin on the %s."),
            target_timer = "5 seconds",
            menu_text = ccb.content.text("Pull pin"),
        },
    },
}
