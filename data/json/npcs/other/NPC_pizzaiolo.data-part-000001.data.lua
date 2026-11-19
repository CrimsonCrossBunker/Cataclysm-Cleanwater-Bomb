local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_pizzaiolo_1", "TALK_pizzaiolo_Background" },
    line = ccb.content.text_without_extraction("<greet>"),
    replies = {
        {
            text = ccb.content.text("I got the cake.  Shall we move, <name_g>?"),
            when = predicates.all({ predicates.has_item("speaker", "cake2"), predicates.has_mission("MISSION_pizzaiolo_4") }),
            next_topic = "TALK_pizzaiolo_go",
        },
        {
            text = ccb.content.text("About that job…"),
            when = predicates.actor_state("interlocutor", "mission_complete"),
            next_topic = "TALK_MISSION_INQUIRE",
        },
        {
            text = ccb.content.text_without_extraction("<BGSS_intro_question>"),
            next_topic = "TALK_pizzaiolo_Background",
        },
        { text = ccb.content.text("Do you need any help?"), next_topic = "TALK_MISSION_LIST" },
        {
            text = ccb.content.text("If you still want to travel with me, let's go."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_pizzaiolo_u_helped_pizzaiolo" } }),
            actions = {
                "follow",
                actions.clear_actor_value("interlocutor", "dialogue_pizzaiolo_u_helped_pizzaiolo"),
            },
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_pizzaiolo_go",
    line = ccb.content.text("Lead the way, <name_g>."),
    replies = {
        {
            text = ccb.content.text("…"),
            next_topic = "TALK_DONE",
            actions = { "follow_only", actions.set_first_topic("TALK_pizzaiolo_following") },
        },
    },
}
