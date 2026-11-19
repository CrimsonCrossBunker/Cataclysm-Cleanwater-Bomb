local ccb = require("ccb")

-- Remainder of this topic is stored in npcs/surface_refugees/NPC_Dana_Nunez.json with her other refugee talk_topics.
ccb.content.define_dialogue_topic {
    id = "TALK_TACOMA_Dana_Baking",
    replies = {
        {
            text = ccb.content.text("I'll look into that.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("I'll look into that.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
