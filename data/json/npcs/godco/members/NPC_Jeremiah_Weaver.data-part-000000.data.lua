local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_GODCO_Jeremiah_2", "TALK_GODCO_Jeremiah_Mood", "TALK_GODCO_Jeremiah_Story", "TALK_GODCO_Jeremiah_Parents", "TALK_GODCO_Jeremiah_Dnd" },
    replies = {
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_GODCO_Jeremiah_Story",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("What's your take on the situation here?"),
            next_topic = "TALK_GODCO_Jeremiah_Mood",
        },
        {
            text = ccb.content.text("What are your parents like?"),
            next_topic = "TALK_GODCO_Jeremiah_Parents",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("What are your plans after <the_cataclysm>?"),
            next_topic = "TALK_GODCO_Jeremiah_Plans",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("Were could I find work around here?"),
            next_topic = "TALK_GODCO_Jeremiah_Work",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Jeremiah_1",
    line = {
        when = predicates.handler("dlg_p_dda_3ae720d7aecb"),
        yes = ccb.content.text("What are you doing around here <name_b>?  Get lost."),
        no = {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_godco_jeremiah" } }),
            yes = {
                choices = {
                    ccb.content.text("Hey, look who's back."),
                    ccb.content.text("Hey again."),
                    ccb.content.text("Hey again <u_name>."),
                    ccb.content.text("Oh, hey, it's you again."),
                },
            },
            no = ccb.content.text("Oh, uh… you look new.  Didn't think we'd see new people here.  Hey."),
        },
    },
    replies = {
        {
            text = ccb.content.text("I'm just a traveler, kid.  I won't be staying here for long."),
            next_topic = "TALK_GODCO_Jeremiah_Firstmeet",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_godco_jeremiah" } })), predicates.negate(predicates.has_effect("speaker", "godco_joinee")) }),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_godco_jeremiah", "yes") },
        },
        {
            text = ccb.content.text("I'm not exactly new here, kid."),
            next_topic = "TALK_GODCO_Jeremiah_Firstmeet",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_godco_jeremiah" } })), predicates.has_effect("speaker", "godco_joinee") }),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_godco_jeremiah", "yes") },
        },
        {
            text = ccb.content.text("Hey, Jerry.  What's up?"),
            next_topic = "TALK_GODCO_Jeremiah_2",
            when = predicates.handler("dlg_p_dda_6a5418e02494"),
        },
        {
            text = ccb.content.text("What's with the attitude?"),
            next_topic = "TALK_GODCO_Jeremiah_Angry",
            when = predicates.handler("dlg_p_dda_6c9f3c8e5e82"),
        },
        {
            text = ccb.content.text("Hey, kid.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_17ef1b259c2c"),
        },
    },
}
