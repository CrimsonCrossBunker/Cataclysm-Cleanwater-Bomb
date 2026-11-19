local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Corrie_Mission",
    line = ccb.content.text("Basic repairs and upkeep, mostly.  The generator in the basement is on its last legs, so I've been thinking about building a solar array for this place.  Helena's against it, but I want to change her mind.  All I need are a few spare parts."),
    replies = {
        {
            text = ccb.content.text("I can help you get the items you need."),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
