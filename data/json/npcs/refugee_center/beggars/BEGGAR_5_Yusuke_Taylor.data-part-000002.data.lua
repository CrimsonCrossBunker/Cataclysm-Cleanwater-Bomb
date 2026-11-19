local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_5_TRAVEL1",
    line = ccb.content.gendered_line("Well now, that's quite a kind offer, and I appreciate you looking past my full-body pubic hair.  Sorry though.  I've come to feel sort of responsible for this little gaggle of squatters.  As long as I'm the only one providing for them, I don't think I can leave.", { "speaker" }),
    replies = {
        {
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_recruit_reena_recruited" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "general_recruit_luo_recruited" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "general_recruit_brendan_recruited" } }) }),
            text = ccb.content.text("I've spoken to all your friends, and except for Dave, they're good to go.  Dave wants to stay here.  How about you?"),
            next_topic = "TALK_REFUGEE_BEGGAR_5_TRAVEL2",
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
