local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GUNSMITH_SHOP_ABOUT_MORE",
    line = ccb.content.text("Pretty simple stuff, bud.  I barter in pre-shitshow ammo, and to stimulate the growing economy, I print and issue more.  I take your goods - Cody would call it labor - and exchange it for the new universal currency.  If you want to convert currency I'm happy to facilitate, but it'll take a few days and there is a service charge."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "dialogue_artisans_gunsmith_knows_about_conversion", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("So you're really going all in on this bank thing?"),
            next_topic = "TALK_GUNSMITH_SERVICES",
        },
        {
            text = ccb.content.text("So you'll exchange bullets for other bullets directly?"),
            next_topic = "TALK_BULLET_EXCHANGE_INFO",
        },
        { text = ccb.content.text("…"), next_topic = "TALK_GUNSMITH_SERVICES" },
    },
}
