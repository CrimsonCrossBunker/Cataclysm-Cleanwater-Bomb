local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_4_HAPPY",
    line = ccb.content.text("What's the alternative?  You take the hand you're dealt.  I've given eulogies for two of the people I love most on this earth, and the third wrote me off.  I've already been through the end of the world.  Came out the other side with my bits intact.  And you know, I've been pretty lonely since my wife passed.  Here I've got friends.  We might be hungry but we're close.  Reena's been teaching me math and science, Luo is one of the smartest folks I've ever met - she's got a doctorate you know - and Yusuke is the only one here that can beat me at poker.  And Dave, well, he's Dave.  There's more goin' on under the surface there, mark my words.  We may be unfit, but we aren't worthless."),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "general_conversation_luo_doctorate", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_LIFEBEFORE1",
        },
        {
            text = ccb.content.text("You seem awfully happy considering the situation."),
            next_topic = "TALK_REFUGEE_BEGGAR_4_HAPPY",
        },
        {
            text = ccb.content.text("They won't let you in because you're sick?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_SICKLY",
        },
        {
            text = ccb.content.text("How did you even get here if you're so sick?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_ARRIVAL",
        },
        {
            text = ccb.content.text("Why are you camped out here if they won't let you in?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_CAMPOUT",
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
