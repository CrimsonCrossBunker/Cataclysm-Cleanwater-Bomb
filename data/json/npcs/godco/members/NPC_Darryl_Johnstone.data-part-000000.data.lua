local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_GODCO_Darryl_2", "TALK_GODCO_Darryl_Mood", "TALK_GODCO_Darryl_Story", "TALK_GODCO_Darryl_Farm", "TALK_GODCO_Darryl_BarterSuccess" },
    replies = {
        {
            text = ccb.content.text("About that well…"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.any_equal({ "in-progress", { scope = "interlocutor", key = "mission_completed_godco_darryl_mission1" } }),
        },
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_GODCO_Darryl_Story",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("How are things here?"),
            next_topic = "TALK_GODCO_Darryl_Mood",
        },
        {
            text = ccb.content.text("Nice farm you have here."),
            next_topic = "TALK_GODCO_Darryl_Farm",
        },
        {
            text = ccb.content.text("Care to trade?"),
            next_topic = "TALK_GODCO_Darryl_Trade",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Darryl_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }),
        yes = ccb.content.gendered_line("What the hell are you, sinner?  Get away from me.", { "speaker" }),
        no = {
            when = predicates.handler("dlg_p_dda_3ae720d7aecb"),
            yes = ccb.content.text("Shove off, we've got no good words for each other."),
            no = {
                when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_darryl" } }),
                yes = {
                    choices = {
                        ccb.content.text("Praise the Lord."),
                        ccb.content.text("Welcome back."),
                        ccb.content.gendered_line("Nice to see you again, survivor.", { "speaker" }),
                    },
                },
                no = ccb.content.gendered_line("Well I'll be damned, a fellow survivor!  I'm Darryl, nice to meet you.", { "speaker" }),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("About that well…"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.handler("dlg_p_dda_46b33dcc78ef"),
        },
        {
            text = ccb.content.text("Nice to meet you too, Darryl.  Neat farm you have here."),
            next_topic = "TALK_GODCO_Darryl_Farm",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_darryl" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_darryl", "yes") },
        },
        {
            text = ccb.content.text("Hey Darryl.  Got a minute?"),
            next_topic = "TALK_GODCO_Darryl_2",
            when = predicates.handler("dlg_p_dda_66dc1578f526"),
        },
        {
            text = ccb.content.text("Hey Darryl.  Got a minute?"),
            next_topic = "TALK_GODCO_Darryl_Angry",
            when = predicates.handler("dlg_p_dda_146b37bb9c95"),
        },
        {
            text = ccb.content.text("Hey Darryl.  Care to trade?"),
            next_topic = "TALK_GODCO_Darryl_Trade",
            when = predicates.handler("dlg_p_dda_66dc1578f526"),
        },
        {
            text = ccb.content.text("Hey Darryl.  Care to trade?"),
            next_topic = "TALK_GODCO_Darryl_Angry",
            when = predicates.handler("dlg_p_dda_146b37bb9c95"),
        },
        {
            text = ccb.content.text("How are the chickens?"),
            next_topic = "TALK_GODCO_Darryl_Trade_Eggs",
            when = predicates.handler("dlg_p_dda_d20fc79f5ca2"),
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_b39f59d33e4f"),
        },
        {
            text = ccb.content.text("What's the poor attitude about?"),
            next_topic = "TALK_GODCO_Darryl_You_Mutant",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }),
        },
        {
            text = ccb.content.text("Fuck you <name_b>, I'm outta here."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_5ebd062782a3"),
        },
    },
}
