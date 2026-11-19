local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3_RECRUIT2",
    line = ccb.content.text("Like I said, sorry, it's just not happening.  It's not that I don't trust you, it's just that I don't really trust you."),
    replies = {
        {
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_conversation_luo_doctorate" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_recruit_luo_recruited" } })) }),
            text = ccb.content.text("So, about that doctorate of yours…"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_DOCTORATE1",
        },
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_EXPERTISE",
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
