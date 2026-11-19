local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Dana_Background",
    line = ccb.content.text("I was working in a nice restaurant as a baker, until <the_cataclysm>.  I was pregnant, and it was getting close to time to go on mat leave; lots of time on my feet, getting up stupid-early to make pastries, you know.  Because of the pregnancy we were evacuated early and shipped out this way, but our bus was attacked in the chaos.  We managed to escape, but had to hike the rest of the way, with the Singhs and a few other refugees that didn't make it.  I lost the baby.  It wasn't a good time."),
    on_enter = { { actions = { actions.set_actor_value("speaker", "knowledge_dana_pregnancy", "knows") } } },
    replies = {
        {
            text = ccb.content.text("Have you done any baking lately?"),
            next_topic = "TALK_REFUGEE_Dana_Background_baking",
        },
        {
            text = ccb.content.text("I'm sorry for your loss."),
            next_topic = "TALK_REFUGEE_Dana_Background_sorry",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("<end_talking_leave>  Bye, Dana."), next_topic = "TALK_DONE" },
    },
}
