local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_BARBER_JOB",
    line = ccb.content.text("What?  I'm a barber… I cut hair.  There's demand for cheap cuts and a shave out here."),
    replies = { { text = ccb.content.text("Sorry."), next_topic = "TALK_RANCH_BARBER" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_BARBER_HIRE",
    line = ccb.content.text("I can't imagine what I'd need your assistance with."),
    replies = { { text = ccb.content.text("Fine."), next_topic = "TALK_RANCH_BARBER" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_BARBER_CUT",
    line = ccb.content.text("Stand still while I get my clippers…"),
    replies = { { text = ccb.content.text("Thanks…"), next_topic = "TALK_DONE" } },
}
