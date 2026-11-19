local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ISHERWOOD_CLAIRE_2",
    line = ccb.content.text("Bee bombs!  Kaboom!\"  He mimes an explosion with his hands.  \"Seriously though it's a very versatile plant, we should get some seeds for ourselves."),
    replies = {
        {
            text = ccb.content.text("I'll see what I can do.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ISHERWOOD_CLAIRE_3",
    line = ccb.content.text("*laughs.  \"I was going to make a joke about herding cats, but yours is better.  I was always more of a dog man myself, I don't know anything about catching a feral cat.  Maybe we open a can of tuna?  Or is that a cliché?\""),
    replies = {
        {
            text = ccb.content.text("I'm still… 'feline' it out myself.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}
