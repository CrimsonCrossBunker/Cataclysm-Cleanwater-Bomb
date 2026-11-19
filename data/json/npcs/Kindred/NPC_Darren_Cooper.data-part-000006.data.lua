local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_COOPER_FIGHT",
    line = {
        when = predicates.has_trait("speaker", "seer_mark"),
        yes = ccb.content.text("I knew a Kindred would not understand.  But I can't allow you to stop me.  If you try, I'll have no option but to fight you.  But know that should you win, you'll be ridding the world of the only hope it has."),
        no = ccb.content.text("I can't allow you to stop me.  If you try, I'll have no option but to fight you.  Maybe I'll die, or maybe you will.  But know that should you win, you'll be ridding the world of the only hope it has."),
    },
    replies = {
        {
            text = ccb.content.text("All I'm ridding the world of is a dangerous madman.  Now die."),
            next_topic = "TALK_DONE",
            actions = {
                "hostile",
                actions.set_actor_value("speaker", "dialogue_cooper_fought_cooper", "yes"),
            },
        },
        {
            text = ccb.content.text("This is a waste of time not worth the risk.  I'm out of here."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COOPER_AGREE",
    line = {
        when = predicates.has_trait("speaker", "seer_mark"),
        yes = ccb.content.gendered_line("You're like me then, Kindred.  I'm glad I'm not the only one who realizes what's necessary.  Perhaps one day, we'll be able to work together, but what I do now, I must do alone.", { "speaker" }),
        no = ccb.content.text("I'm glad you realize the necessity of the burden I bear.  Maybe someday we'll even join our forces, but for now, I have to do this alone."),
    },
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "dialogue_cooper_cooper_friendly", "yes") },
        },
    },
    replies = {
        { text = ccb.content.text("I won't delay you then.  Good luck."), next_topic = "TALK_DONE" },
        {
            text = ccb.content.text("That being said, I need to know why you do it - what purpose it fills."),
            next_topic = "TALK_COOPER_GOAL",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_cooper_goal_k" } })),
        },
    },
}
