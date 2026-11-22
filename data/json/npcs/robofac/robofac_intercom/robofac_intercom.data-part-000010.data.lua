local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_ABOUT_EXODII_2",
    line = ccb.content.text("Inter-dimensional travellers you say?  What kind of tech do these beings operate?  And how were you able to communicate with them?"),
    on_enter = {
        { actions = { actions.set_actor_value("speaker", "u_informed_robofac_of_exodii", "yes"), actions.handler("dlg_a_dda_419b707aa4cf"), actions.add_effect("speaker", "robofac_surveillance", { turns = 2592000 }), actions.adjust_faction_trust(1) } },
    },
    replies = {
        {
            text = ccb.content.text("Alright listen up."),
            next_topic = "TALK_GIVE_ROBOFAC_EXODII_INFO",
        },
        {
            text = ccb.content.text("Information doesn't come cheap my friend."),
            next_topic = "TALK_ROBOFAC_EXODII_INFO_REWARD",
        },
        {
            text = ccb.content.text("I've said more than I ought to have.  I'm leaving."),
            next_topic = "TALK_DONE",
            actions = { actions.adjust_faction_trust(-1) },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GIVE_ROBOFAC_EXODII_INFO",
    line = ccb.content.text("Well?"),
    on_enter = {
        { actions = { actions.set_actor_value("speaker", "u_give_robofac_exodii_info", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("They are a race of inter-dimensional beings who call themselves the Exodii.  These guys are more metal than man in my opinion and use automated machinery to do their fighting and heavy lifting.  They do understand English to a certain extent and when talking they use a strange dialect they like to call Anglic."),
            next_topic = "TALK_FINISH_ROBOFAC_EXODII_DISCUSSION",
            actions = { actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_6174ecbde742") },
        },
        {
            text = ccb.content.text("They are a race of inter-dimensional beings who call themselves the Exodii and they use a mix of futuristic and ancient technology the latter being mostly due to their last landing place being an ancient battlefield of some sort.  These guys are more metal than man in my opinion and use automated machinery to do their fighting and heavy lifting.  While their choice for personal defense was more along the lines of ancient gear like spears and swords.  They do understand English to a certain extent and when talking they use a strange dialect they like to call Anglic."),
            next_topic = "TALK_FINISH_ROBOFAC_EXODII_DISCUSSION",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_talk_exodii_about_medieval_stock" } }),
            actions = { actions.adjust_faction_trust(2), actions.handler("dlg_a_dda_6174ecbde742") },
        },
        {
            text = ccb.content.text("They are a race of inter-dimensional beings who call themselves the Exodii.  These guys are more metal than man in my opinion and use automated machinery to do their fighting and heavy lifting.  They do understand English to a certain extent and when talking they use a strange dialect they like to call Anglic.  They are here to mine this place of any useful metal, gather any tech they deem worth saving and maybe even grab a couple of survivors to join their ranks before they move out."),
            next_topic = "TALK_FINISH_ROBOFAC_EXODII_DISCUSSION",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_know_exodii_purpose2" } }),
            actions = { actions.adjust_faction_trust(2), actions.handler("dlg_a_dda_6174ecbde742") },
        },
        {
            text = ccb.content.text("They are a race of inter-dimensional beings who call themselves the Exodii and they use a mix of futuristic and ancient technology the latter being mostly due to their last landing place being an ancient battlefield of some sort.  These guys are more metal than man in my opinion and use automated machinery to do their fighting and heavy lifting.  However their choice for personal defense was more along the lines of ancient gear like spears and swords.  They do understand English to a certain extent and when talking they use a strange dialect they like to call Anglic.  They are here to mine this place of any useful metal, gather any tech they deem worth saving and maybe even grab a couple of survivors to join their ranks before they move out."),
            next_topic = "TALK_FINISH_ROBOFAC_EXODII_DISCUSSION",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "u_know_exodii_purpose2" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "u_talk_exodii_about_medieval_stock" } }) }),
            actions = { actions.adjust_faction_trust(3), actions.handler("dlg_a_dda_6174ecbde742") },
        },
    },
}
