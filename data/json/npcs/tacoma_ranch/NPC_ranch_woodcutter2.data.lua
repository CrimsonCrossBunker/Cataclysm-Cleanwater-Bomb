local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_WOODCUTTER_2_JOB",
    line = ccb.content.text("I turn the logs that laborers bring in into lumber to expand the outpost.  Maintaining the saw is a chore, but breaks the monotony."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_RANCH_WOODCUTTER_2" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_WOODCUTTER_2_HIRE",
    line = ccb.content.text("Bringing in logs is one of the few tasks we can give to the unskilled, so I'd be hurting them if I outsourced it.  Ask around though, I'm sure most people could use a hand."),
    replies = { { text = ccb.content.text("Oh."), next_topic = "TALK_RANCH_WOODCUTTER_2" } },
}
