local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3_RACISM",
    line = ccb.content.text("Sure.  My grandparents were from China.  That means I'm obviously personally responsible for all this.  Do you think there's some other reason they let hundreds of other educated people in and I'm sitting out here?"),
    replies = {
        {
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_recruit_luo_recruited" } })),
            text = ccb.content.text("I don't care if you're Chinese.  You can travel with me if you want."),
            next_topic = "TALK_REFUGEE_BEGGAR_3_JOIN",
        },
        {
            when = predicates.all({ predicates.minimum_attribute("speaker", "perception", 9), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_recruit_luo_recruited" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_conversation_dont_insult_luo" } })) }),
            text = ccb.content.text("I mean, racism could definitely be a part of it… but you are visibly in poor shape.  They need strong survivor material."),
            next_topic = "TALK_REFUGEE_BEGGAR_3_INSULTED",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
