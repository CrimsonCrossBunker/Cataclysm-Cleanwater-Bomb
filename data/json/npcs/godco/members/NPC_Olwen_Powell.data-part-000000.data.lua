local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_GODCO_Olwen_2", "TALK_GODCO_Olwen_Mood", "TALK_GODCO_Olwen_Story", "TALK_GODCO_Olwen_Skills" },
    replies = {
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_GODCO_Olwen_Story",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("How are things, living here?"),
            next_topic = "TALK_GODCO_Olwen_Mood",
        },
        {
            text = ccb.content.text("How's your family?"),
            next_topic = "TALK_GODCO_Olwen_Family",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("How is your love life going in here?"),
            next_topic = "TALK_GODCO_Olwen_Love0",
            when = predicates.handler("dlg_p_dda_f99453b5c14d"),
        },
        {
            text = ccb.content.text("How is your love life going in here?"),
            next_topic = "TALK_GODCO_Olwen_Love1",
            when = predicates.handler("dlg_p_dda_e994ba98f6c9"),
        },
        {
            text = ccb.content.text("How is your love life going in here?"),
            next_topic = "TALK_GODCO_Olwen_Love2",
            when = predicates.handler("dlg_p_dda_1ef53835301b"),
        },
        {
            text = ccb.content.text("I heard you were handy with computers."),
            next_topic = "TALK_GODCO_Olwen_Skills",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Olwen_1",
    line = {
        when = predicates.handler("dlg_p_dda_3ae720d7aecb"),
        yes = ccb.content.text("What in the world are you still doing around here, come back to screw me over?"),
        no = {
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_olwen" } }),
            yes = {
                choices = {
                    ccb.content.text("Hey, <name_g>."),
                    ccb.content.text("Good to see you again."),
                    ccb.content.text("What can I do for you?"),
                    ccb.content.text("You don't look too shabby, <u_name>."),
                },
            },
            no = ccb.content.text("I definitely haven't met you yet.  Nice to meet you, I'm Olwen."),
        },
    },
    replies = {
        {
            text = ccb.content.text("I'm just a traveler."),
            next_topic = "TALK_GODCO_Olwen_Firstmeet",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_olwen" } })),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_olwen", "yes") },
        },
        {
            text = ccb.content.text("Hi, Olwen.  What's up?"),
            next_topic = "TALK_GODCO_Olwen_2",
            when = predicates.handler("dlg_p_dda_8c6148cf7b57"),
        },
        {
            text = ccb.content.text("Hey, Olwen.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_17ef1b259c2c"),
        },
        {
            text = ccb.content.text("What's with the attitude?"),
            next_topic = "TALK_GODCO_Olwen_Angry",
            when = predicates.handler("dlg_p_dda_1811b3ed1781"),
        },
        {
            text = ccb.content.text("No, I'll be on my way."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_3ae720d7aecb"),
        },
    },
}
