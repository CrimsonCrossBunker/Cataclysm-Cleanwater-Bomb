local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_GODCO_Corrie_FirstmeetA", "TALK_GODCO_Corrie_FirstmeetB", "TALK_GODCO_Corrie_FirstmeetC", "TALK_GODCO_Corrie_2", "TALK_GODCO_Corrie_Story", "TALK_GODCO_Corrie_Mission", "TALK_GODCO_Corrie_Mood" },
    replies = {
        {
            text = ccb.content.text("How did you get here?"),
            next_topic = "TALK_GODCO_Corrie_Story",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("How are things, living here?"),
            next_topic = "TALK_GODCO_Corrie_Mood",
        },
        {
            text = ccb.content.text("Are the non-joinees treating you fairly?"),
            next_topic = "TALK_GODCO_Corrie_Community",
        },
        {
            text = ccb.content.text("Want to come with me?"),
            next_topic = "TALK_GODCO_Corrie_Recruit",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_completed_godco_corrie_machine" } }),
        },
        {
            text = ccb.content.text("What needs to be done?"),
            next_topic = "TALK_GODCO_Corrie_Mission",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "in-progress", { scope = "interlocutor", key = "mission_completed_godco_corrie_machine" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_completed_godco_corrie_machine" } })) }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Corrie_1",
    line = {
        when = predicates.handler("dlg_p_dda_3ae720d7aecb"),
        yes = ccb.content.text("&Corrie briefly glances at you and shoots a glare.  \"What do you want?\""),
        no = ccb.content.text("Hey there, <name_g>.  Welcome to the losers club."),
    },
    replies = {
        {
            text = ccb.content.text("I'm just passing through."),
            next_topic = "TALK_GODCO_Corrie_FirstmeetA",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_corrie" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_godco_joinee" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_corrie", "yes") },
        },
        {
            text = ccb.content.text("Nice to meet you."),
            next_topic = "TALK_GODCO_Corrie_FirstmeetB",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_corrie" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_godco_joinee" } }) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_corrie", "yes") },
        },
        {
            text = ccb.content.text("Nice to meet you."),
            next_topic = "TALK_GODCO_Corrie_FirstmeetC",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_corrie" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_corrie", "yes") },
        },
        {
            text = ccb.content.text("Hey Corrie, you free?"),
            next_topic = "TALK_GODCO_Corrie_2",
            when = predicates.handler("dlg_p_dda_06a93d0b5574"),
        },
        {
            text = ccb.content.text("Hey Corrie, you free?"),
            next_topic = "TALK_GODCO_Corrie_Angry",
            when = predicates.handler("dlg_p_dda_7dcd2efc660f"),
        },
        {
            text = ccb.content.text("Hey Corrie.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_corrie" } }),
        },
    },
}
