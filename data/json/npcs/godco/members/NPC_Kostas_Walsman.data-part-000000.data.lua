local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_GODCO_Kostas_2", "TALK_GODCO_Kostas_Story", "TALK_GODCO_Kostas_Mood", "TALK_GODCO_Kostas_Task", "TALK_GODCO_Kostas_Herbalism" },
    replies = {
        {
            text = ccb.content.text("I have the pine needles you asked me for."),
            next_topic = "TALK_GODCO_Kostas_Tea_2",
            when = predicates.all({ predicates.any_equal({ "in-progress", { scope = "interlocutor", key = "knowledge_completed_godco_kostas_tea" } }), predicates.has_inventory("speaker", "pine_bough", 12) }),
            actions = { actions.set_actor_value("interlocutor", "knowledge_completed_godco_kostas_tea", "yes"), actions.handler("dlg_a_dda_517739bde778") },
        },
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_GODCO_Kostas_Story",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("How are things here?"),
            next_topic = "TALK_GODCO_Kostas_Mood",
        },
        {
            text = ccb.content.text("What do you do around here?"),
            next_topic = "TALK_GODCO_Kostas_Task",
        },
        {
            text = ccb.content.text("Care to trade?"),
            next_topic = "TALK_GODCO_Kostas_2",
            actions = { "start_trade" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Kostas_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }),
        yes = ccb.content.text("A sin against God, did you know that's what you are?  Get away from me."),
        no = {
            when = predicates.handler("dlg_p_dda_3ae720d7aecb"),
            yes = ccb.content.text("&Kostas looks up at you and scorns.  \"I'm rather busy right now with an important project, go away please.\""),
            no = {
                when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_kostas" } }),
                yes = {
                    choices = {
                        ccb.content.text("Praise the Lord."),
                        ccb.content.text("<u_name>, how can I help you?"),
                    },
                },
                no = ccb.content.gendered_line("You must be new here, nice to meet you.  They call me Kostas, I'm the local herbalist.", { "speaker" }),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you too, Kostas."),
            next_topic = "TALK_GODCO_Kostas_2",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_kostas" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_kostas", "yes") },
        },
        {
            text = ccb.content.text("Hey, good to see you again."),
            next_topic = "TALK_GODCO_Kostas_2",
            when = predicates.handler("dlg_p_dda_8b79c1f17396"),
        },
        {
            text = ccb.content.text("I heard Jeremiah wanted to learn a few things from you."),
            next_topic = "TALK_GODCO_Kostas_Jeremiah",
            when = predicates.all({ predicates.negate(predicates.has_effect("interlocutor", "failed_persuade")), predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_kostas" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "general_mission_convince_kostas" } }) }),
        },
        {
            text = ccb.content.text("Hi, Kostas.  Care to trade?"),
            next_topic = "TALK_GODCO_Kostas_2",
            when = predicates.handler("dlg_p_dda_5fe76c7704cf"),
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Hey, I think we've got some time to chat, don't you?"),
            next_topic = "TALK_GODCO_Kostas_Angry",
            when = predicates.handler("dlg_p_dda_447ecf8e75e4"),
        },
        {
            text = ccb.content.text("Hi, Kostas.  Care to trade?"),
            next_topic = "TALK_GODCO_Kostas_Angry",
            when = predicates.handler("dlg_p_dda_ca7e572fd51b"),
        },
        {
            text = ccb.content.text("Hey Kostas, find something interesting lately?"),
            next_topic = "TALK_GODCO_Kostas_Interval",
            when = predicates.handler("dlg_p_dda_17ef1b259c2c"),
        },
        {
            text = ccb.content.text("Hey, Kostas.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_b39f59d33e4f"),
        },
        {
            text = ccb.content.text("What the hell are you talking about?"),
            next_topic = "TALK_GODCO_Kostas_You_Mutant",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }),
        },
        {
            text = ccb.content.text("Alright then."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_5ebd062782a3"),
        },
    },
}
