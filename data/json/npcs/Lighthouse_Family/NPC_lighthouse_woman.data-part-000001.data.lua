local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

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
