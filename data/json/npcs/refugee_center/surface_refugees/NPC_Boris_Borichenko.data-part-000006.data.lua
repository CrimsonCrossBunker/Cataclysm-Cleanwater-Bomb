local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_NoTeach",
    line = ccb.content.text("I am afraid I cannot teach you right now.  Not only do I have no shop, but I do not think I am in a good place for anything so taxing."),
    replies = {
        {
            text = ccb.content.text("Is there anything I can do to help?"),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_Boris_mission_1" } })),
            next_topic = "TALK_REFUGEE_Boris_Work1",
        },
        {
            text = ccb.content.text("Is there anything more I can do to help?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_Boris_mission_1" } }),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
