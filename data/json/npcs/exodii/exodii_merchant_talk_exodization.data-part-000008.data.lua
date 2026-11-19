local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- Yes, of course.  I'll go back to the shop.  Find me if you reconsider.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_back_out",
    line = ccb.content.text("&Rubik lets out a mechanical chuckle.  \"Aye, 'course.  Escolt this'n out if ya' reconsider.\"\n\nWith that, Rubik gets up and leaves, offering a backward wave on his way out."),
    replies = {
        {
            text = ccb.content.text("…"),
            actions = { actions.set_actor_value("speaker", "Rubik_promised_cyberframe", "yes") },
            next_topic = "TALK_DONE",
        },
    },
}
