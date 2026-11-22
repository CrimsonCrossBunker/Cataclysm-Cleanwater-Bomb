local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_GODCO_Helena_2", "TALK_GODCO_Helena_Story", "TALK_GODCO_Helena_Uncle", "TALK_GODCO_Helena_Mood", "TALK_GODCO_Helena_Community" },
    replies = {
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_GODCO_Helena_Story",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("How are things around here?"),
            next_topic = "TALK_GODCO_Helena_Mood",
        },
        {
            text = ccb.content.text("Could you tell me about the community?"),
            next_topic = "TALK_GODCO_Helena_Community",
        },
        {
            text = ccb.content.text("Can I help you with anything?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_helena" } }),
        },
        {
            text = ccb.content.text("I want to join the community."),
            next_topic = "TALK_GODCO_Helena_Join",
            when = predicates.handler("dlg_p_dda_e12a216748aa"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Helena_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }),
        yes = ccb.content.gendered_line("Get away from here, sinner, we don't want your kind here.", { "speaker" }),
        no = {
            when = predicates.handler("dlg_p_dda_3ae720d7aecb"),
            yes = ccb.content.text("What brings you here <name_b>?  You know we don't want anything to do with you."),
            no = {
                when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_helena" } }),
                yes = {
                    choices = {
                        ccb.content.text("Praise the Lord."),
                        ccb.content.text("Blessings to you."),
                        ccb.content.text("Bless you, <u_name>."),
                    },
                },
                no = ccb.content.text("Stranger, what brings you to our holy home?"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Who are you?"),
            next_topic = "TALK_GODCO_Helena_Firstmeet",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_helena" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_helena", "yes") },
        },
        {
            text = ccb.content.text("Good to see you again."),
            next_topic = "TALK_GODCO_Helena_2",
            when = predicates.handler("dlg_p_dda_e67b4a947328"),
        },
        {
            text = ccb.content.text("Why might that be?"),
            next_topic = "TALK_GODCO_Helena_Angry",
            when = predicates.handler("dlg_p_dda_3b94acd27179"),
        },
        {
            text = ccb.content.text("I can't talk right now."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_449f69e62f09"),
        },
        {
            text = ccb.content.text("Fine then."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_40d168d78a5b"),
        },
    },
}
