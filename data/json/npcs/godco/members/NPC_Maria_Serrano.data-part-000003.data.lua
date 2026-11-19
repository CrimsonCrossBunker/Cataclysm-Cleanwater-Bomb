local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Maria_Godco",
    line = ccb.content.text("Yeah, they are.  I just wish my work was more appreciated."),
    replies = {
        {
            text = ccb.content.text("Could you sew something for me?"),
            actions = { actions.set_actor_value("interlocutor", "general_trade_can_sew_for_u", "yes") },
            next_topic = "TALK_GODCO_Maria_Tailor_What",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Maria_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
