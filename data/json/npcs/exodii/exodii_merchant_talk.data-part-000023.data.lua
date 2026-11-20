local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Aliens",
    line = ccb.content.text(
        --~ Yeah, you could say that.  We're from otherlands, most of the time.  Not otherworlds though.  Too risky bringing those monsters into our safe haven.
        "Yeah, you could call us as it.  Us're from otherlands mostlike.  Not otherworlds though.  Too risky bringin' them squelchies into the fold."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "knowledge_exodii_transdimensional_u_knows_exodiilore", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("I don't know the difference between otherlands and otherworlds."),
            next_topic = "TALK_EXODII_MERCHANT_Aliens2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
