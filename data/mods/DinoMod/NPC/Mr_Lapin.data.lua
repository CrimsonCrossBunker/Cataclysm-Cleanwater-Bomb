local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_WARRENER",
    replies = {
        {
            text = ccb.content.text("What can you tell me about the dinosaurs?"),
            next_topic = "TALK_WARRENER_DINOSAURS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_WARRENER_DINOSAURS",
    line = ccb.content.text("I am afraid that is drifting far out of my area of expertise, but I would be willing to bet some of the little ones might be worth something to you if you tamed them and raised them.  No fur to speak of, but feathers might be of some use, and meat and eggs could help.  I'm not sure what they eat, but I hope it isn't rabbits or people on the more rabbit adjacent end of things."),
    replies = {
        {
            text = ccb.content.text("Maybe dinosaurs and rabbits aren't so different."),
            next_topic = "TALK_WARRENER",
        },
    },
}
