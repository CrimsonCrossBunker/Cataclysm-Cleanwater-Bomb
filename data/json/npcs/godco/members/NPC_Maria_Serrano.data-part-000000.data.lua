local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_GODCO_Maria_2", "TALK_GODCO_Maria_Story", "TALK_GODCO_Maria_Feeling", "TALK_GODCO_Maria_Past", "TALK_GODCO_Maria_Godco", "TALK_GODCO_Maria_Theresa" },
    replies = {
        {
            text = ccb.content.text("How did you get here?"),
            next_topic = "TALK_GODCO_Maria_Story",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("Could you tell me about yourself?"),
            next_topic = "TALK_GODCO_Maria_Past",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("How are things around here?"),
            next_topic = "TALK_GODCO_Maria_Feeling",
        },
        {
            text = ccb.content.text("Is everyone treating you fairly?"),
            next_topic = "TALK_GODCO_Maria_Godco",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Maria",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }),
        yes = ccb.content.text("Ahh!  What the hell are you?  Get the freaking away from me!"),
        no = {
            when = predicates.handler("dlg_p_dda_3ae720d7aecb"),
            yes = ccb.content.text("Buzz off <name_b>, I'm not interested in <freaking> chatting with you."),
            no = {
                when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_maria" } }),
                yes = {
                    choices = {
                        ccb.content.text("Hey <name_g>!  Nice to see you again!"),
                        ccb.content.text("Hey <u_name>!  Nice to see you again!"),
                    },
                },
                no = ccb.content.text("I don't think I've met you before, have I?  I'm Maria Serrano, it's nice to see an new face."),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("It's a pleasure to meet you, Maria."),
            next_topic = "TALK_GODCO_Maria_Feeling",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_maria" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_maria", "yes") },
        },
        {
            text = ccb.content.text("Hey Maria.  What's up?"),
            next_topic = "TALK_GODCO_Maria_2",
            when = predicates.handler("dlg_p_dda_71af41b625da"),
        },
        {
            text = ccb.content.text("Maria, why the sudden hostility?"),
            next_topic = "TALK_GODCO_Maria_Angry",
            when = predicates.handler("dlg_p_dda_7d65e3e31354"),
        },
        {
            text = ccb.content.text("Hey Maria.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_b39f59d33e4f"),
        },
        {
            text = ccb.content.text("Alright, alright, chill out, I'm leaving!"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_5ebd062782a3"),
        },
    },
}
