local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_GODCO_Gemma_Firstmeet", "TALK_GODCO_Gemma_2", "TALK_GODCO_Gemma_Story", "TALK_GODCO_Gemma_Leader", "TALK_GODCO_Gemma_Mood", "TALK_GODCO_Gemma_Ref", "TALK_GODCO_Gemma_Leave", "TALK_GODCO_Gemma_Joinee" },
    replies = {
        {
            text = ccb.content.text("About that job…"),
            next_topic = "TALK_MISSION_INQUIRE",
            when = predicates.assigned_missions(1, 1),
        },
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_GODCO_Gemma_Story",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("How are things here?"),
            next_topic = "TALK_GODCO_Gemma_Mood",
        },
        {
            text = ccb.content.text("What does a dorm leader do exactly?"),
            next_topic = "TALK_GODCO_Gemma_Leader",
        },
        {
            text = ccb.content.text("Can I help you with anything?"),
            next_topic = "TALK_GODCO_Gemma_Help",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_gemma" } }),
        },
        {
            text = ccb.content.text("I want to join the community."),
            next_topic = "TALK_GODCO_Gemma_Join",
            when = predicates.handler("dlg_p_dda_b0d2ab06f9d5"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Gemma_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }),
        yes = ccb.content.gendered_line("The Lord isn't with you, and that's obvious.  Get out of my sight, sinner.", { "speaker" }),
        no = {
            when = predicates.handler("dlg_p_dda_3ae720d7aecb"),
            yes = ccb.content.text("I'm rather busy at the moment, I don't have the time to talk right now."),
            no = {
                when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_gemma" } }),
                yes = {
                    choices = {
                        ccb.content.text("Praise the Lord."),
                        ccb.content.text("Good to see you're still around, <granny_name_g>."),
                        ccb.content.text("Hey <u_name>.  How can I help you?"),
                    },
                },
                no = ccb.content.text("Great to see a new face.  I'm Gemma.  Will you be staying here with us?"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you, Gemma.  I'm just passing through."),
            next_topic = "TALK_GODCO_Gemma_Leave",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_gemma" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_godco_joinee" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_gemma", "yes") },
        },
        {
            text = ccb.content.text("Nice to meet you, Gemma.  I'm seeking asylum."),
            next_topic = "TALK_GODCO_Gemma_Join",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_godco_joinee" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_gemma", "yes") },
        },
        {
            text = ccb.content.text("I'm already staying here.  Nice to meet you."),
            next_topic = "TALK_GODCO_Gemma_Firstmeet",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_gemma" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_godco_joinee" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_gemma", "yes") },
        },
        {
            text = ccb.content.text("Hi, Gemma.  How're you doing?"),
            next_topic = "TALK_GODCO_Gemma_Mood",
            when = predicates.handler("dlg_p_dda_812ec78644bd"),
        },
        {
            text = ccb.content.text("Hello, Gemma.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_b39f59d33e4f"),
        },
        {
            text = ccb.content.text("Are you sure?  I've got all the time in the world."),
            next_topic = "TALK_GODCO_Gemma_Angry",
            when = predicates.handler("dlg_p_dda_b25b2ee6efa9"),
        },
        {
            text = ccb.content.text("What's the harsh reception about?"),
            next_topic = "TALK_GODCO_Gemma_You_Mutant",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }),
        },
        {
            text = ccb.content.text("Fine then, screw you."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }),
        },
    },
}
