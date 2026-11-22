local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_GODCO_Katherine_Joinees", "TALK_GODCO_Katherine_Job", "TALK_GODCO_Katherine_Arturo", "TALK_GODCO_Katherine_Corrie", "TALK_GODCO_Katherine_Jane", "TALK_GODCO_Katherine_Sonia", "TALK_GODCO_Katherine_Zachary", "TALK_GODCO_Katherine_Simon", "TALK_GODCO_Katherine_Jeremiah" },
    replies = {
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_GODCO_Katherine_Story",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("How are things here?"),
            next_topic = "TALK_GODCO_Katherine_Mood",
        },
        {
            text = ccb.content.text("Can you tell me about Arturo?"),
            next_topic = "TALK_GODCO_Katherine_Arturo",
            when = predicates.handler("dlg_p_dda_8a1122999849"),
        },
        {
            text = ccb.content.text("Can you tell me about Corrie?"),
            next_topic = "TALK_GODCO_Katherine_Corrie",
            when = predicates.handler("dlg_p_dda_8a1122999849"),
        },
        {
            text = ccb.content.text("Can you tell me about Jane?"),
            next_topic = "TALK_GODCO_Katherine_Jane",
            when = predicates.handler("dlg_p_dda_8a1122999849"),
        },
        {
            text = ccb.content.text("Can you tell me about Sonia?"),
            next_topic = "TALK_GODCO_Katherine_Sonia",
            when = predicates.handler("dlg_p_dda_8a1122999849"),
        },
        {
            text = ccb.content.text("Can you tell me about Zachary?"),
            next_topic = "TALK_GODCO_Katherine_Zachary",
            when = predicates.handler("dlg_p_dda_8a1122999849"),
        },
        {
            text = ccb.content.text("Can you tell me about Simon?"),
            next_topic = "TALK_GODCO_Katherine_Simon",
            when = predicates.handler("dlg_p_dda_8a1122999849"),
        },
        {
            text = ccb.content.text("Can you tell me about Jeremiah?"),
            next_topic = "TALK_GODCO_Katherine_Jeremiah",
            when = predicates.handler("dlg_p_dda_8a1122999849"),
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_GODCO_Katherine_2a", "TALK_GODCO_Katherine_2", "TALK_GODCO_Katherine_Mood", "TALK_GODCO_Katherine_Story", "TALK_GODCO_Katherine_Family", "TALK_GODCO_Katherine_Community", "TALK_GODCO_Katherine_Founder", "TALK_GODCO_Katherine_Joinee_Opinion" },
    replies = {
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_GODCO_Katherine_Story",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "TALK_GODCO_Katherine_Job",
        },
        {
            text = ccb.content.text("You don't seem to like the joinees very much.  Why is that?"),
            next_topic = "TALK_GODCO_Katherine_Joinee_Opinion",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("Do you know where I could find some work?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text("How are things here?"),
            next_topic = "TALK_GODCO_Katherine_Mood",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Katherine_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }),
        yes = ccb.content.gendered_line("Oh well, yet another sinner.  Don't talk to me.", { "speaker" }),
        no = {
            when = predicates.handler("dlg_p_dda_3ae720d7aecb"),
            yes = ccb.content.text("Please go away, I'm not in the mood to talk right now."),
            no = {
                when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_katherine" } }),
                yes = {
                    choices = {
                        ccb.content.text("Praise the Lord."),
                        ccb.content.text("<u_name>, bless you."),
                    },
                },
                no = ccb.content.gendered_line("Oh well, yet another survivor.  Welcome to our group, I'm Katherine.", { "speaker" }),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Hi, Katherine.  How's it going?"),
            next_topic = "TALK_GODCO_Katherine_2a",
            when = predicates.handler("dlg_p_dda_de17284a0857"),
        },
        {
            text = ccb.content.text("Nice to meet you, Katherine."),
            next_topic = "TALK_GODCO_Katherine_Firstmeet",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_katherine" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_katherine", "yes") },
        },
        {
            text = ccb.content.text("You sure, I've got plenty of time."),
            next_topic = "TALK_GODCO_Katherine_Angry",
            when = predicates.handler("dlg_p_dda_a5ec6d0947e2"),
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_b39f59d33e4f"),
        },
        {
            text = ccb.content.text("Okay, I'll see you later."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_a5ec6d0947e2"),
        },
        {
            text = ccb.content.text("Alright, fuck you then."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_5ebd062782a3"),
        },
    },
}
