local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_TRUEVAMP" },
    line = ccb.content.text("I am overjoyed that a new person decided to take their place as a new ruler of the night!  Soon, you'll be ready for the final step, the one that will allow you to fully walk the path!"),
    replies = {
        {
            text = ccb.content.text("I want to talk."),
            next_topic = "TALK_VAMPIRE_MENTOR_TALK",
        },
        {
            text = ccb.content.text("Before, you said there was more that I needed to learn?"),
            next_topic = "TALK_VAMPIRE_MENTOR_BLOOD_GIFT_RESEARCH",
            when = predicates.handler("dlg_p_xedra_evolved_69ebfe42166c"),
        },
        {
            text = ccb.content.text("Can you help me walk that path?"),
            next_topic = "TALK_VAMPIRE_MENTOR_BECOME_MORE_STRONGER",
        },
        {
            text = ccb.content.text("I just wanted to share the news.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_BLOOD_GIFT_RESEARCH" },
    line = ccb.content.text("Yes.  The gifts of the blood are somewhat random, as are its curses.  But now that you have come into your true power, there are ways to expand your talents and to modify your weaknesses.  It will require a great deal of blood and time, but I can show you the way."),
    replies = {
        {
            text = ccb.content.text("Yes.  I want more power."),
            next_topic = "TALK_VAMPIRE_MENTOR_BLOOD_GIFT_RESEARCH_LEARNED",
            actions = { actions.handler("dlg_a_xedra_evolved_644c819c1395") },
        },
        {
            text = ccb.content.text("Maybe later, but not now."),
            next_topic = "TALK_VAMPIRE_MENTOR_TALK",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_BLOOD_GIFT_RESEARCH_LEARNED" },
    line = ccb.content.text("Concentrate on the blood and watch closely."),
    replies = {
        {
            text = ccb.content.text("…"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_xedra_evolved_14594555e665") },
        },
    },
}
