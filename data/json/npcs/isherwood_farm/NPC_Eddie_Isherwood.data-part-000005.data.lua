local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_EDDIE_MarshalOff_Convince",
    line = ccb.content.text("*grimaces.  \"Fine, I'll give you a chance, but you don't mess with me or my family, you understand?  This is our land, not yours.  Or theirs.\""),
    on_enter = { { actions = { actions.set_first_topic("TALK_ISHERWOOD_EDDIE_ConvincedMarshal") } } },
    replies = {
        {
            text = ccb.content.text("Thanks for hearing me out."),
            next_topic = "TALK_ISHERWOOD_EDDIE_TOPICS",
        },
        {
            text = ccb.content.text("Thanks.  I'll give you space for now."),
            next_topic = "TALK_DONE",
        },
    },
}
