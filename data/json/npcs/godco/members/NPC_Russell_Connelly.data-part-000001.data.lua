local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Russell_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }),
        yes = ccb.content.text("Get away from me, demon.  I shoot crazy sinners like you on a regular basis, and my rifle's right here."),
        no = {
            when = predicates.handler("dlg_p_dda_3ae720d7aecb"),
            yes = ccb.content.text("Get away from me <name_b>.  I'm not interested in whatever <freaking> thing you have to say right now."),
            no = {
                when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_russell" } }),
                yes = {
                    choices = {
                        ccb.content.text("Praise the Lord, <name_g>."),
                        ccb.content.text("Praise the Lord, <u_name>."),
                        ccb.content.text("Greetings, <name_g><punc>  You okay?"),
                    },
                },
                no = ccb.content.text("Huh, so it was you over there.  It's always great to see a new face.  Name's Russell, Russell Connelly."),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Russell, hey?  Nice to meet you."),
            next_topic = "TALK_GODCO_Russell_Firstmeet",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_russell" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_russell", "yes") },
        },
        {
            text = ccb.content.text("Hi, Russell.  Got a minute?"),
            next_topic = "TALK_GODCO_Russell_2",
            when = predicates.handler("dlg_p_dda_1edc8717c0eb"),
        },
        {
            text = ccb.content.text("Hey, Russell.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_b39f59d33e4f"),
        },
        {
            text = ccb.content.text("Chill out man, I'll leave you alone."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_5ebd062782a3"),
        },
    },
}
