local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_TACOMA_Dana_Trailer2",
    line = ccb.content.text("It's all propane!\"  She grins.  \"The oven, especially.  We don't need electric, which means we don't need to run the gennie and attract attention."),
    replies = {
        {
            text = ccb.content.text("Seems like a tiny kitchen for a bakery."),
            next_topic = "TALK_TACOMA_Dana_Trailer3",
        },
        {
            text = ccb.content.text("Won't you run out of propane?"),
            next_topic = "TALK_TACOMA_Dana_TrailerPropane",
            when = predicates.negate(predicates.any_equal({ "knows", { scope = "speaker", key = "knowledge_propane_scavenging" } })),
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
