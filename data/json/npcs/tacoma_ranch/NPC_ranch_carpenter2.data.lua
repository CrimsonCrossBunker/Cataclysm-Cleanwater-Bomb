local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_CONSTRUCTION_2_JOB",
    line = ccb.content.gendered_line("I was among one of the first groups of immigrants sent here to fortify the outpost.  I might have exaggerated my construction skills to get the hell out of the refugee center.  Unless you are a trader, there isn't much work there and food was really becoming scarce when I left.", { "interlocutor" }),
    replies = { { text = ccb.content.text("I see."), next_topic = "TALK_RANCH_CONSTRUCTION_2" } },
}
