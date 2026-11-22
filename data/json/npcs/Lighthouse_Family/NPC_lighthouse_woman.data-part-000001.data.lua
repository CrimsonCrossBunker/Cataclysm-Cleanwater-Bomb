local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_lighthouse_woman_start",
    line = ccb.content.text("I'm scared.  Where is my husband?"),
    on_enter = {
        { once = "met", actions = { "follow_only", actions.offer_mission("MISSION_lighthouse_woman_0") } },
    },
    replies = {
        {
            text = ccb.content.text("I want you to use this item."),
            next_topic = "TALK_lighthouse_woman_start",
            when = predicates.actor_state("interlocutor", "following"),
            actions = { "npc_gets_item_to_use" },
        },
        {
            text = ccb.content.text("We're here."),
            next_topic = "TALK_lighthouse_woman_safe",
            when = predicates.handler("dlg_p_dda_f7417ddd0af4"),
            actions = { "mission_success", "clear_mission", "stop_following", actions.set_first_topic("TALK_lighthouse_woman_safe"), actions.set_actor_value("speaker", "flag_safe_lighthouse_woman", "yes") },
        },
        {
            text = ccb.content.text("<lets_go>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_lighthouse_woman_safe",
    line = {
        when = predicates.has_mission("MISSION_lighthouse_man_3"),
        yes = {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "flag_death_lighthouse_girl_dead" } }),
            yes = ccb.content.text("Thank you for saving me.  It's a shame my Angelina didn't make it… you did everything you could, and I don't blame you for it…"),
            no = ccb.content.text("Thank you!"),
        },
        no = {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "flag_death_lighthouse_girl_dead" } }),
            yes = ccb.content.text("Poor, poor Angelina…"),
            no = ccb.content.text("Hello."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Hi."),
            next_topic = "TALK_lighthouse_woman_1",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "flag_help_lighthouse_family_safe" } }),
            actions = { actions.set_first_topic("TALK_lighthouse_woman_1") },
            switch = true,
        },
        {
            text = ccb.content.text("I'm sorry…"),
            false_text = ccb.content.text("…"),
            text_when = predicates.any_equal({ "yes", { scope = "speaker", key = "flag_death_lighthouse_girl_dead" } }),
            next_topic = "TALK_DONE",
            switch = true,
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_lighthouse_woman_1", "TALK_lighthouse_woman_Background" },
    line = ccb.content.text("How are you today?"),
    replies = {
        {
            text = ccb.content.text("About that job…"),
            when = predicates.assigned_missions(1, 1),
            next_topic = "TALK_MISSION_INQUIRE",
        },
        {
            text = ccb.content.text_without_extraction("<BGSS_intro_question>"),
            next_topic = "TALK_lighthouse_woman_Background",
        },
        { text = ccb.content.text("Do you need any help?"), next_topic = "TALK_MISSION_LIST" },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
