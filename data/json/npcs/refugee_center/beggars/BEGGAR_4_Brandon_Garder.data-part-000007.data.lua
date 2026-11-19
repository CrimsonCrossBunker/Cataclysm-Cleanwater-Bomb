local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_4_RECRUIT1",
    line = ccb.content.text("That's awful nice of you.  Tell you what: if you can help Dave get himself sorted out, so I don't feel like I've gotta stay here keeping an eye on the poor fella, then I'll come along."),
    replies = {
        {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_recruit_dave_happy" } }),
            text = ccb.content.text("I think I've sorted Dave out pretty well, don't you?  Would you consider coming with me now?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_RECRUIT2",
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
