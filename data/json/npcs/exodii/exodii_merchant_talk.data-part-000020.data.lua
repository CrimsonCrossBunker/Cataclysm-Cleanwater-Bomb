local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Talk_Intro6",
    line = ccb.content.text(
        --~ Great, I'll put that in the dictionary.  Here's a token of my gratitude for your explanation.
        "Right so, us'n'll write it in the dicky.  Here, a shiny brass farthing for crossin' the nation."),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "dialogue_completed_rubik_intro", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("Now that we've sorted that out, I have to ask.  You're from a place where this happened before, and you escaped to our world?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodus3",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("<end_talking_leave>  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}
