local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_ABOUT_EXODII_1",
    line = ccb.content.text("I see and do you have more information regarding these interested parties?"),
    on_enter = {
        { actions = { actions.set_actor_value("speaker", "u_informed_robofac_of_exodii", "yes"), actions.handler("dlg_a_dda_419b707aa4cf"), actions.add_effect("speaker", "robofac_surveillance", { turns = 2592000 }), actions.adjust_faction_trust(1) } },
    },
    replies = {
        {
            text = ccb.content.text("Not really."),
            next_topic = "TALK_ROBOFAC_EXODII_MORE_INFO",
        },
        {
            text = ccb.content.text("Not much actually but I do know they have pretty sweet looking technology as I saw them having advanced machinery everywhere.  Nothing like I've ever seen."),
            next_topic = "TALK_ROBOFAC_EXODII_MORE_INFO",
        },
    },
}
