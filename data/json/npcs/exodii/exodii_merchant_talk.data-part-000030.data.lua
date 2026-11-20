local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- In the future, Rubik should be able to sell the player a robot.  This is a placeholder until that time arrives.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Robot_Buy",
    line = ccb.content.text(
        --~ I don't know about that.  Each one we make is very important to our operations here, and they're extremely expensive.  I might be able to sell you one later, but not right now.
        "*sounds thoughtful.  \"This'n can't make a call o' the quarter.  The stompers be a king's necklace, and the manufactory don't run on dreams.  Mayhap when us'n be more on the solid, but for the tick and tumble, no.\""),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "dialogue_exodii_rubik_offered_robosell", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
