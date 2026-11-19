local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Alonso_2",
    replies = {
        {
            text = ccb.content.text("What can you tell me about the dinosaurs?"),
            next_topic = "TALK_REFUGEE_Alonso_DINOSAURS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Alonso_DINOSAURS",
    line = ccb.content.text("It could be a mighty challenge, but Alonso knows there are some that are into this, no?  I think they call themselves escalier, which is Italian for the scaly banana.  Or staircase.  It is not important, I mean to say that people love who they love, and the dinosaur, she does the same, and there is no shame in what two people or dinosaurs do in the escalier.  Alonso does not judge you.  You do you.  And maybe Alonso as well when you are done with the you doing."),
    replies = { { text = ccb.content.text("Thank you so much."), next_topic = "TALK_NONE" } },
}
