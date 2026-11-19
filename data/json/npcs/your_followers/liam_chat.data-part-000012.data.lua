local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_EVAC_SMOKER_GET_CIGARETTES",
    line = ccb.content.text("How about it?  Seems like a nice enough thing to do I guess.  I bet plenty of zombies are carrying smokes, and there's probably tons in people's abandoned cars."),
    replies = {
        {
            text = ccb.content.text("Yeah.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}
