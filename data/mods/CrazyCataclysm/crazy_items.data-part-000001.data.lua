local ccb = require("ccb")

ccb.content.define_item {
    id = "granade_act",
    category = "weapons",
    name = ccb.content.plural_text("active Granade", "active Granades"),
    description = ccb.content.text("Attached to this grenade is a name tag with the name Maya written on it.  Does not seem to work like a grenade, handle with care.  Better throw it!"),
    mass = "180 g",
    volume = "250 ml",
    price = "0 cent",
    materials = { "steel", "plastic" },
    symbol = "*",
    color = "green",
    flags = { "TRADER_AVOID" },
    melee_damage = { bash = 6 },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already pulled the pin, try throwing it instead."),
            menu_text = ccb.content.text_without_extraction("Pull pin"),
        },
    },
    tick_actions = {
        {
            kind = "sound",
            message = ccb.content.text("Merged!"),
            volume = 0,
            sound_id = "speech",
            sound_variant = "granade_act",
        },
    },
    countdown_action = "GRANADE_ACT",
}
