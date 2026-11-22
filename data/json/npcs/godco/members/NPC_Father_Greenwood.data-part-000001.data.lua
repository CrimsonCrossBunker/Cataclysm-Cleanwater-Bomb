local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Greenwood_1",
    line = {
        when = predicates.handler("dlg_p_dda_085a734e2c49"),
        yes = ccb.content.text("What brings you back here?  Come to exploit me again?"),
        no = {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }),
            yes = ccb.content.text("The Lord be with you…  You don't seem all too well, I pray for you."),
            no = {
                when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_greenwood" } }),
                yes = {
                    when = predicates.actor_state("speaker", "male"),
                    yes = {
                        choices = {
                            ccb.content.text("The Lord be with you, brother."),
                            ccb.content.text("Good to see you're still around, <u_name>."),
                        },
                    },
                    no = {
                        choices = {
                            ccb.content.text("The Lord be with you, sister."),
                            ccb.content.text("Good to see you're still around, <u_name>."),
                        },
                    },
                },
                no = {
                    when = predicates.actor_state("speaker", "male"),
                    yes = ccb.content.text("The Lord be with you, brother.  You seem new, nice to meet you.  Welcome, and welcome aboard!"),
                    no = ccb.content.text("The Lord be with you, sister.  You seem new, nice to meet you.  Welcome, and welcome aboard!"),
                },
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you too, Reverend."),
            next_topic = "TALK_GODCO_Greenwood_Firstmeet",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_greenwood" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_greenwood", "yes") },
        },
        {
            text = ccb.content.text("Good to see you again, Reverend.  I wanted to talk."),
            next_topic = "TALK_GODCO_Greenwood_2",
            when = predicates.handler("dlg_p_dda_5646b391242e"),
        },
        {
            text = ccb.content.text("I'm looking for work.  Can I do anything for your congregation?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.handler("dlg_p_dda_9632f2278fb1"),
        },
        {
            text = ccb.content.text("Nice meeting you, Reverend.  I'd best get going though."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_9632f2278fb1"),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_greenwood", "yes") },
        },
        {
            text = ccb.content.text("What's wrong with me, if you could say?"),
            next_topic = "TALK_GODCO_Greenwood_You_Mutant",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_greenwood" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_greenwood", "yes") },
        },
        {
            text = ccb.content.text("What are you talking about?"),
            next_topic = "TALK_GODCO_Greenwood_Angry",
            when = predicates.handler("dlg_p_dda_085a734e2c49"),
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
