local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- Lovely!  Benzete (this is a name) is going to be beside themselves, that's for sure.  I mean, they'll be really happy.  This is their first jump, and it's a lucky one.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Talk_Intro2",
    line = ccb.content.text("Lovely!  Benzete's gonna be a pair, that's a track!  I mean, they'll be right happy.  This is their first jump, and it's a flappin' duck."),
    on_enter = { { actions = { actions.set_actor_value("speaker", "dialogue_midpoint_rubik_intro", "yes") } } },
    replies = {
        {
            text = ccb.content.text("What makes it such a good jump?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk_Intro3",
        },
        {
            text = ccb.content.text("Who is Benzete?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk_IntroBenzete1",
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
