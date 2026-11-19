local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3_RECRUIT1",
    line = ccb.content.text("Tempting offer, but I don't know how much I trust a random stranger offering me a place to live.  Call me crazy."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "general_recruit_luo_attempt_recruit", "yes"),
            },
        },
    },
    replies = {
        {
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_recruit_luo_owed" } }),
            text = ccb.content.text("Oh, come on.  I'm not a random stranger anymore, I brought you that crazy mushroom didn't I?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_RECRUITED1",
        },
        {
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_recruit_luo_owed" } })),
            text = ccb.content.text("What better choice do you have?  It's not like it would be just you and me, the others out here can come too."),
            next_topic = "TALK_REFUGEE_BEGGAR_3_RECRUIT2",
        },
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
