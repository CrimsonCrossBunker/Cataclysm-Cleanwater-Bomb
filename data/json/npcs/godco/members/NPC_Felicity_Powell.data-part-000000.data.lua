local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_GODCO_Felicity_2", "TALK_GODCO_Felicity_3", "TALK_GODCO_Felicity_Firstmeet", "TALK_GODCO_Felicity_Firstmeet2", "TALK_GODCO_Felicity_Community" },
    replies = {
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_GODCO_Felicity_Story",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("What's it like living here?"),
            next_topic = "TALK_GODCO_Felicity_Mood",
        },
        {
            text = ccb.content.text("How's your family?"),
            next_topic = "TALK_GODCO_Felicity_Family",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("Is there anything I can do for you?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text("How's the manuscript coming?"),
            next_topic = "TALK_GODCO_Felicity_Manuscript_InProgress",
            when = predicates.handler("dlg_p_dda_4b170013d58b"),
        },
        {
            text = ccb.content.text("How's the manuscript coming?"),
            next_topic = "TALK_GODCO_Felicity_Manuscript",
            when = predicates.handler("dlg_p_dda_d71ced0bb43b"),
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Felicity_3",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Felicity_1",
    line = {
        when = predicates.handler("dlg_p_dda_3ae720d7aecb"),
        yes = ccb.content.text("Please, go away.  I don't want to talk to you right now."),
        no = {
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_felicity" } }),
            yes = {
                choices = {
                    ccb.content.text("Oh, hi."),
                    ccb.content.text("Hey, good to see you're still around."),
                    ccb.content.text("Hey <u_name>, nice to see you."),
                },
            },
            no = ccb.content.text("Oh, hi there.  My name's Felicity, nice to see a new face."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Felicity?  Nice to meet you.  How are things here?"),
            next_topic = "TALK_GODCO_Felicity_Firstmeet",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_felicity" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_felicity", "yes") },
        },
        {
            text = ccb.content.text("Felicity?  Nice to meet you.  How are things here?"),
            next_topic = "TALK_GODCO_Felicity_Firstmeet2",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_felicity" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_felicity", "yes") },
        },
        {
            text = ccb.content.text("Hi Felicity.  Got a minute?"),
            next_topic = "TALK_GODCO_Felicity_2",
            when = predicates.handler("dlg_p_dda_f9d159e20386"),
        },
        {
            text = ccb.content.text("What's all that about?"),
            next_topic = "TALK_GODCO_Felicity_2",
            when = predicates.handler("dlg_p_dda_3b46a78bb7af"),
        },
        {
            text = ccb.content.text("Hi Felicity.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
