local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_LUKE2",
    line = {
        joined = {
            ccb.content.text("*gestures around at the worn down shed surrounding you.  \"I've been cleaning up this old building to make it into a workshop.  I want to put up a pottery kiln and forge.  My dad doesn't want me leaving the farm to find some things"),
            {
                when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_saved_barry_isherwood" } }),
                yes = ccb.content.text(", says it is too dangerous.  After what happened with Barry, well, I tend to agree with him.\"  He smiles thinly.  \"Don't want you to have to run out saving another one of us, right?\""),
                no = ccb.content.text(", says it's too dangerous.  I used to think he was being a pain in the butt, but lately…\" he stops abruptly, and says nothing more."),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Maybe I can help out.  What do you need?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_LUKE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
