local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_GODCO_Julian_Leave", "TALK_GODCO_Julian_2", "TALK_GODCO_Julian_Story", "TALK_GODCO_Julian_Leader", "TALK_GODCO_Julian_Mood" },
    replies = {
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_GODCO_Julian_Story",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("How are things here?"),
            next_topic = "TALK_GODCO_Julian_Mood",
        },
        {
            text = ccb.content.text("What are the advantages of being a dorm leader?"),
            next_topic = "TALK_GODCO_Julian_Leader",
        },
        {
            text = ccb.content.text("Heard you and Olwen were some kind of lovebirds?"),
            next_topic = "TALK_GODCO_Julian_Love0",
            when = predicates.handler("dlg_p_dda_f99453b5c14d"),
        },
        {
            text = ccb.content.text("How did Olwen receive the rings?"),
            next_topic = "TALK_GODCO_Julian_Love1",
            when = predicates.handler("dlg_p_dda_e994ba98f6c9"),
        },
        {
            text = ccb.content.text("Did Olwen like the dress?"),
            next_topic = "TALK_GODCO_Julian_Love2",
            when = predicates.handler("dlg_p_dda_1ef53835301b"),
        },
        {
            text = ccb.content.text("Why did you join the Church?"),
            next_topic = "TALK_GODCO_Julian_Church",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("I want to join the community."),
            next_topic = "TALK_GODCO_Julian_Join",
            when = predicates.handler("dlg_p_dda_4a3f3f2c8c2b"),
        },
        {
            text = ccb.content.text("I want to join the community."),
            next_topic = "TALK_GODCO_Julian_Mutant_Join",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_julian" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_godco_joinee" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }) }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Julian_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }),
        yes = ccb.content.text("Hey…  I'm Julian, the guy in charge of this room.  Are you… planning on sticking around or somethin'?"),
        no = {
            when = predicates.handler("dlg_p_dda_3ae720d7aecb"),
            yes = ccb.content.text("Why are you still around, don't you have someone else to bother?"),
            no = {
                when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_julian" } }),
                yes = {
                    choices = {
                        ccb.content.text("Praise the Lord."),
                        ccb.content.text("Hey, <name_g>."),
                        ccb.content.text("Good to see you again <u_name>."),
                    },
                },
                no = ccb.content.text("Hey, a new face.  I'm Julian, the guy in charge of this room.  You're planning on sticking around or somethin'?"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you, Julian.  I'm just passing through."),
            next_topic = "TALK_GODCO_Julian_Leave",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_julian" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_godco_joinee" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_julian", "yes") },
        },
        {
            text = ccb.content.text("Nice to meet you, Julian.  I'm seeking asylum."),
            next_topic = "TALK_GODCO_Julian_Join",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_julian" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_godco_joinee" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_julian", "yes") },
        },
        {
            text = ccb.content.text("I'm a joinee actually.  Nice to meet you."),
            next_topic = "TALK_GODCO_Julian_2",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_julian" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_godco_joinee" } }) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_julian", "yes") },
        },
        {
            text = ccb.content.text("Nice to meet you, Julian.  I'm seeking asylum."),
            next_topic = "TALK_GODCO_Julian_Mutant_Join",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_julian" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_godco_joinee" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_julian", "yes") },
        },
        {
            text = ccb.content.text("Hey, good to see you again."),
            next_topic = "TALK_GODCO_Julian_2",
            when = predicates.handler("dlg_p_dda_ed54f56716f3"),
        },
        {
            text = ccb.content.text("Nope, just me and you pal.  What's the attitude about?"),
            next_topic = "TALK_GODCO_Julian_Angry",
            when = predicates.handler("dlg_p_dda_84616cfc7457"),
        },
        {
            text = ccb.content.text("Hello, Julian.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
