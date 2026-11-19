local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_Situation",
    line = {
        joined = {
            ccb.content.text("Everyone agrees this is bad.  Sleeping on a cot on the floor, crowded in with strangers"),
            {
                when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_Boris_mission_1" } }),
                yes = ccb.content.text(", but it is a bit better since we cleaned up our dead"),
                no = ccb.content.text(", woken by zombies in the night"),
            },
            ccb.content.text(".  To me, though, that is all just a drop in the bucket"),
            {
                when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_Boris_mission_3" } }),
                yes = ccb.content.text(".  What is killing me is being forced to sit with nothing but my thoughts of what I've lost."),
                no = ccb.content.text(".  I have spent so much time, just regretting what I have lost.  Thank you for bringing back what little you could."),
            },
        },
    },
    replies = {
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
