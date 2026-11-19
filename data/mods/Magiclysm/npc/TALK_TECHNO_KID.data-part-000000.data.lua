local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_TECHNO_KID",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_techno_kid_talked_to_techno_kid" } }),
        yes = ccb.content.text("Ah, hello again."),
        no = ccb.content.text("Do you seek power as well?"),
    },
    replies = {
        {
            text = ccb.content.text("Hey <name_g>."),
            next_topic = "TALK_TECHNO_KID_INTRO",
            actions = {
                actions.set_actor_value("speaker", "dialogue_techno_kid_talked_to_techno_kid", "yes"),
            },
        },
        { text = ccb.content.text("Wanna get outta here?"), next_topic = "TALK_SUGGEST_FOLLOW" },
        {
            text = ccb.content.text("Let's trade items."),
            next_topic = "TALK_TECHNO_KID",
            actions = { "start_trade" },
        },
        { text = ccb.content.text("Can I do anything for you?"), next_topic = "TALK_MISSION_LIST" },
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
