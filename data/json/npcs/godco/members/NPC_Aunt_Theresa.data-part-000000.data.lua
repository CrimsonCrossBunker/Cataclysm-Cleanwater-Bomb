local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_GODCO_Theresa_2", "TALK_GODCO_Theresa_Mood", "TALK_GODCO_Theresa_Story", "TALK_GODCO_Theresa_Help", "TALK_GODCO_Theresa_Husband", "TALK_GODCO_Theresa_Community", "TALK_GODCO_Theresa_Vision", "TALK_GODCO_Theresa_Firstmeet" },
    replies = {
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_GODCO_Theresa_Story",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("What's it like living here?"),
            next_topic = "TALK_GODCO_Theresa_Mood",
        },
        {
            text = ccb.content.text("Is there anything I can help you with?"),
            next_topic = "TALK_GODCO_Theresa_Help",
        },
        {
            text = ccb.content.text("How've things been since <the_cataclysm>?"),
            next_topic = "TALK_GODCO_Theresa_Cataclysm",
            when = predicates.handler("dlg_p_dda_d637ce500b4a"),
        },
        {
            text = ccb.content.text("Do you knit at all?  I noticed you have sewing needles."),
            next_topic = "TALK_GODCO_Theresa_Knit",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Theresa_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }),
        yes = ccb.content.text("I have no interest in dealing with you, unnatural abomination.  Keep away from me."),
        no = {
            when = predicates.handler("dlg_p_dda_3ae720d7aecb"),
            yes = ccb.content.text("What are you doing around here?  I don't want to talk to you."),
            no = {
                when = predicates.handler("dlg_p_dda_f98058ef3692"),
                yes = ccb.content.text("&Theresa looks up from her knitting, with a sparkle in her eyes.  \"Come on in, <granny_name_g>.  I'm glad to see you again, have a seat.\""),
                no = {
                    when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_theresa" } }),
                    yes = ccb.content.text("Praise the Lord.  It's good to see you're still around, <granny_name_g>."),
                    no = ccb.content.text("Welcome, <granny_name_g>.  I don't think I recognize you, I'm Theresa."),
                },
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you, Theresa.  I'm <u_name>."),
            next_topic = "TALK_GODCO_Theresa_Firstmeet",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_theresa" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_theresa", "yes") },
        },
        {
            text = ccb.content.text("Hello, Theresa.  How are you doing?"),
            next_topic = "TALK_GODCO_Theresa_2",
            when = predicates.handler("dlg_p_dda_651c5ad5121f"),
        },
        {
            text = ccb.content.text("Hello, Theresa.  How are you doing?"),
            next_topic = "TALK_GODCO_Theresa_Anger",
            when = predicates.handler("dlg_p_dda_470036d03c11"),
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_b39f59d33e4f"),
        },
        {
            text = ccb.content.text("What's the insults for?"),
            next_topic = "TALK_GODCO_Theresa_You_Mutant",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }),
        },
        {
            text = ccb.content.text("Fuck you then, I'm leaving."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_af294cdc5175"),
        },
    },
}
