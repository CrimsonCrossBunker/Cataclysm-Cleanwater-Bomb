local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_MAGUS",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_old_magus_talked_to_old_magus" } }),
        yes = ccb.content.text("Oh, you again."),
        no = ccb.content.text("Huh?  *mumble mumble* …Who are you?"),
    },
    replies = {
        {
            text = ccb.content.text("Hello <name_g>."),
            next_topic = "TALK_OLD_MAGUS_INTRO",
            actions = { actions.set_actor_value("speaker", "dialogue_old_magus_talked_to_old_magus", "yes") },
        },
        { text = ccb.content.text("Wanna get outta here?"), next_topic = "TALK_SUGGEST_FOLLOW" },
        {
            text = ccb.content.text("Let's trade items."),
            next_topic = "TALK_OLD_MAGUS",
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Can I do anything for you?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.all({ predicates.negate(predicates.assigned_missions(1, 1)), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_old_magus_npc_magus_book_done" } })) }),
        },
        {
            text = ccb.content.text("About the mission…"),
            next_topic = "TALK_MISSION_INQUIRE",
            when = predicates.assigned_missions(1, 1),
        },
        {
            text = ccb.content.text("About one of those missions…"),
            next_topic = "TALK_MISSION_LIST_ASSIGNED",
            when = predicates.assigned_missions(2),
        },
        { text = ccb.content.text("Goodbye."), next_topic = "TALK_DONE" },
    },
}
