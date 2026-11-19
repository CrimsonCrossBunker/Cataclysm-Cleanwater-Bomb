local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_WOODCUTTER_JOB",
    line = ccb.content.gendered_line("I'm one of the migrants that got diverted to this outpost when I arrived at the refugee center.  They said I was big enough to swing an axe, so my profession became lumberjack… didn't have any say in it.  If I want to eat, then I'll be cutting wood from now till kingdom come.", { "interlocutor" }),
    replies = { { text = ccb.content.text("Oh."), next_topic = "TALK_RANCH_WOODCUTTER" } },
}
