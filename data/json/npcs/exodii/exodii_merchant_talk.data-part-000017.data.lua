local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Talk_Intro4a",
    line = ccb.content.text(
        --~ That's a part of it, sure, but this is nice for other reasons, and much better than our last jump.  Otherlands with fusillies and mobbings are really useful to us.
        "That be a part an' switch, but this be'n nice for all, overtop the last jump by heads.  Otherlands with fusillies and mobbings, us'n gets a fine change on that."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "knowledge_exodii_transdimensional_u_knows_exodiilore", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("I don't know what fusillies and mobbings are."),
            next_topic = "TALK_EXODII_MERCHANT_Talk_Intro5",
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
