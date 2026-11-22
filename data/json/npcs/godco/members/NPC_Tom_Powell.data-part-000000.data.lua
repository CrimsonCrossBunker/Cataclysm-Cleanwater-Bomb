local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_GODCO_Tom_Firstmeet4", "TALK_GODCO_Tom_2", "TALK_GODCO_Tom_Goal", "TALK_GODCO_Tom_Goal1", "TALK_GODCO_Tom_Help" },
    replies = {
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_GODCO_Tom_Story",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("Let's talk about your goals."),
            next_topic = "TALK_GODCO_Tom_Goal",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_GODCO_Tom_Story", "TALK_GODCO_Tom_Background", "TALK_GODCO_Tom_Family", "TALK_GODCO_Tom_Community" },
    replies = {
        {
            text = ccb.content.text("Tell me about yourself."),
            next_topic = "TALK_GODCO_Tom_Background",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("Tell me about your family."),
            next_topic = "TALK_GODCO_Tom_Family",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("Tell me about the community."),
            next_topic = "TALK_GODCO_Tom_Community",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_GODCO_Tom_Story",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("Let's talk about your goals."),
            next_topic = "TALK_GODCO_Tom_Goal",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Tom_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }),
        yes = ccb.content.text("What the hell are you?  Get away from me!"),
        no = {
            when = predicates.handler("dlg_p_dda_3ae720d7aecb"),
            yes = ccb.content.text("It's you again <u_name>, you have some nerve coming around after what you've done."),
            no = {
                when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_tom" } }),
                yes = ccb.content.text("Hey, it's you again <u_name>!  Any news from the outside world?"),
                no = ccb.content.gendered_line("Ah, another survivor!  I hope you come in peace.  I'm Tom, nice to meet you.", { "speaker" }),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you, Tom."),
            next_topic = "TALK_GODCO_Tom_Firstmeet",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_tom" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_tom", "yes") },
        },
        {
            text = ccb.content.text("Hi Tom, got a minute?"),
            next_topic = "TALK_GODCO_Tom_2",
            when = predicates.handler("dlg_p_dda_bff6e448efd8"),
        },
        {
            text = ccb.content.text("Hi Tom, got a minute?"),
            next_topic = "TALK_GODCO_Tom_Angry",
            when = predicates.handler("dlg_p_dda_21271b12063e"),
        },
        {
            text = ccb.content.text("Hey, Tom.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_b39f59d33e4f"),
        },
        {
            text = ccb.content.text("Alright, alright, I'll leave you be."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_a5ec6d0947e2"),
        },
        {
            text = ccb.content.text("Alright, alright, chill out, I'm leaving!"),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }),
        },
    },
}
