local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_Background",
    line = ccb.content.text("I was a carpenter.  I like to keep my hands busy, especially when I am stressed.  Now, here I am, picking my nose and stuck thinking about my problems and all that I've lost."),
    replies = {
        {
            text = ccb.content.text("What have you lost, if it's okay for me to ask?"),
            next_topic = "TALK_REFUGEE_Boris_Background_loss",
        },
        {
            text = ccb.content.text("It seems like carpentry work would be something the Free Merchants need.  Why are you so bored?"),
            next_topic = "TALK_REFUGEE_Boris_Work1",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_Boris_mission_1" } })),
        },
        {
            text = ccb.content.text("Could you teach me something about carpentry?"),
            next_topic = "TALK_REFUGEE_Boris_NoTeach",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_Boris_mission_2" } })),
        },
        {
            text = ccb.content.text("Could you teach me something about carpentry?"),
            next_topic = "TALK_REFUGEE_Boris_Teach",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_Boris_mission_2" } }),
        },
        {
            text = ccb.content.text("Now that things are cleaned up in the back, is there anything holding you back from working?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_Boris_mission_1" } }),
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
