local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_meteorologist_1" },
    line = {
        when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "flag_mission_u_helped_meteorologist" } }),
        yes = ccb.content.text("Run, I need to run, where to run…"),
        no = {
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_meteorologist" } }),
            yes = ccb.content.gendered_line("Air temperature, precipitation, but what about… oh, I'm sorry, I didn't notice you.  Hello.", { "interlocutor" }),
            no = ccb.content.gendered_line("I have not seen living people for a long time.  Glad to see another survivor.  Greetings, <name_g>.", { "interlocutor" }),
        },
    },
    on_enter = {
        { once = "u_met_meteorologist", actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_meteorologist", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("About that job…"),
            next_topic = "TALK_MISSION_INQUIRE",
            when = predicates.assigned_missions(1, 1),
        },
        {
            text = ccb.content.text("<BGSS_intro_question>"),
            next_topic = "TALK_meteorologist_Background",
        },
        {
            text = ccb.content.text("Maybe I can help you with your problem?"),
            next_topic = "TALK_meteorologist_safety",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "flag_mission_u_helped_meteorologist" } }),
            switch = true,
        },
        {
            text = ccb.content.text("Do you need any help?"),
            switch = true,
            trial = { kind = "condition", when = predicates.handler("dlg_p_dda_f855db4d8b27") },
            success = { next_topic = "TALK_MISSION_LIST", actions = { actions.clear_actor_value("interlocutor", "time_mission_meteorologist_wait") } },
            failure = { next_topic = "TALK_meteorologist_wait" },
        },
        {
            text = ccb.content.text("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_meteorologist_wait",
    line = ccb.content.text("I need more time.  Come back later."),
    replies = { { text = ccb.content.text("No problem."), next_topic = "TALK_DONE" } },
}
