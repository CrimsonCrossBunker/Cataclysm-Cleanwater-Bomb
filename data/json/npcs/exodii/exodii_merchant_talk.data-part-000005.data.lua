local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- You can surely try.  I'm not the greatest speaker, and I won't just chat forever for free, you know.
-- Hey, can I ask you something first?
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Talk",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_started_rubik_intro" } }),
        yes = ccb.content.text("Sure as you c'n try.  Us're not the greatest yarker, nor do it all for gratis, kennit."),
        no = ccb.content.text("Oy, c'n I bark you summat first?"),
    },
    on_enter = { { actions = { actions.set_actor_value("speaker", "dialogue_started_rubik_intro", "yes") } } },
    replies = {
        {
            text = ccb.content.text("Like, ask me a question?  Sure, I guess."),
            next_topic = "TALK_EXODII_MERCHANT_Talk_Intro1a",
        },
        {
            text = ccb.content.text("Know where I can find any work?"),
            next_topic = "TALK_EXODII_MERCHANT_Jobs",
        },
        {
            text = ccb.content.text("No.  I'm too busy to answer your questions, you're supposed to answer mine.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
