local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_FARMER_2_JOB",
    line = ccb.content.text("I'm just a lucky guy that went from being chased by the undead to the noble life of a dirt farmer.  We get room and board, but won't see a share of our labor unless the crop is a success."),
    replies = { { text = ccb.content.text("It could be worse…"), next_topic = "TALK_RANCH_FARMER_2" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_FARMER_2_HIRE",
    line = ccb.content.text("I've got no time for you.  If you want to make a trade or need a job, look for the foreman or crop overseer."),
    replies = { { text = ccb.content.text("I'll talk with them then…"), next_topic = "TALK_RANCH_FARMER_2" } },
}
