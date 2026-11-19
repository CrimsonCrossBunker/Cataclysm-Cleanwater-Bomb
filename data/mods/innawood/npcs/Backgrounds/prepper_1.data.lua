local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_LMOE",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_BGSS_prepper_1_started_quest" } }),
        yes = ccb.content.text("The shelter's in your hands, at this point."),
        no = ccb.content.text("I still haven't made it there.  Every time I've tried I've been headed off by the <zombies>.  Who knows, maybe someday."),
    },
    replies = {
        {
            text = ccb.content.text("Could you tell me that story again?"),
            next_topic = "BGSS_PREPPER_1_STORY1",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
