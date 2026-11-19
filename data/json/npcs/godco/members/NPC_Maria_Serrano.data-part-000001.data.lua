local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Maria_2",
    line = ccb.content.text("What can I do for you?"),
    replies = {
        {
            text = ccb.content.text("Is there anything I can do for you?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text("Could you sew something for me?"),
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_trade_can_sew_for_u" } }),
            next_topic = "TALK_GODCO_Maria_Tailor_Something",
        },
        {
            text = ccb.content.text("How's my order going?"),
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_trade_can_sew_for_u" } }),
            next_topic = "TALK_GODCO_Maria_Retrieve_Order",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
