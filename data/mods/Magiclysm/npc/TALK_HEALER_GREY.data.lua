local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_HEALER_GREY",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_healer_grey_talked_to_healer_grey" } }),
        yes = ccb.content.text("Blessed be."),
        no = ccb.content.text("I must purge this land of its curse.  Will you help or hinder our mission?"),
    },
    replies = {
        {
            text = ccb.content.text("Hello <name_g>."),
            next_topic = "TALK_HEALER_GREY_INTRO",
            actions = {
                actions.set_actor_value("speaker", "dialogue_healer_grey_talked_to_HEALER_GREY", "yes"),
            },
        },
        { text = ccb.content.text("Wanna get outta here?"), next_topic = "TALK_SUGGEST_FOLLOW" },
        {
            text = ccb.content.text("Let's trade items."),
            next_topic = "TALK_HEALER_GREY",
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

ccb.content.define_dialogue_topic {
    id = "TALK_HEALER_GREY_INTRO",
    line = ccb.content.text("Blessed be.  May you purge that which opposes the calm."),
    replies = {
        {
            text = ccb.content.text("Why don't you go somewhere else?"),
            next_topic = "TALK_HEALER_GREY_LEAVE",
        },
        {
            text = ccb.content.text("Let's trade then."),
            native_actions = { "start_trade" },
            next_topic = "TALK_HEALER_GREY",
        },
        { text = ccb.content.text("I'm sorry, I gotta go."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_HEALER_GREY_LEAVE",
    line = ccb.content.text("I must purge this place before I can move on."),
    replies = {
        { text = ccb.content.text("Wanna get outta here?"), next_topic = "TALK_SUGGEST_FOLLOW" },
        {
            text = ccb.content.text("What can you sell me?"),
            next_topic = "TALK_HEALER_GREY",
            native_actions = { "start_trade" },
        },
        { text = ccb.content.text("I'm sorry, I gotta go."), next_topic = "TALK_DONE" },
    },
}
