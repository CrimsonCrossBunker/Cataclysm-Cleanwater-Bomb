local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3_RECRUITED1",
    line = ccb.content.text("Aw damn, I was worried you'd say that.  Okay, listen: you've got yourself a deal.  I'll come to your base, but you've gotta get me hooked up with a microscope as soon as you can.  This could be the beginning of something really cool.  Oh, and it should go without saying that I'm not coming unless you can find a place for my friends here in your base.  I'm sure you anticipated that.  Talk them into going and I'm in.  It should be easy, they're a bunch of sweet hearted saps."),
    on_enter = { { actions = { actions.set_actor_value("speaker", "general_recruit_luo_recruited", "yes") } } },
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

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3_EXPERTISE",
    line = ccb.content.text("Well, before <the_cataclysm> ended I was working at a university bookstore.  I know a little bit about a lot of things, I guess you could say.  I kinda loved the job, to be honest."),
    replies = {
        {
            when = predicates.all({ predicates.any({ predicates.minimum_attribute("speaker", "perception", 9), predicates.minimum_attribute("speaker", "intelligence", 9) }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_conversation_luo_doctorate" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_recruit_luo_recruited" } })) }),
            text = ccb.content.text("What had you working at the university bookstore in the first place?  Are you an academic yourself?"),
            actions = { actions.set_actor_value("speaker", "general_conversation_luo_doctorate", "yes") },
            next_topic = "TALK_REFUGEE_BEGGAR_3_DOCTORATE",
        },
        {
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_conversation_luo_doctorate" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_recruit_luo_recruited" } })) }),
            text = ccb.content.text("What's this I hear about you having a doctorate?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_DOCTORATE1",
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
