local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_SCAVENGER_ASK_RESTOCK",
    line = ccb.content.text("Nope, current run hasn't returned yet.  Come back after <restock_time_point>.  You might find something you like."),
    replies = { { text = ccb.content.text("Alright, thanks."), next_topic = "TALK_RANCH_SCAVENGER_1" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_SCAVENGER_1_JOB",
    line = ccb.content.gendered_line("I organize scavenging runs to bring in supplies that we can't produce ourselves.  I try and provide incentives to get migrants to join one of the teams… it's dangerous work, but keeps our outpost alive.  Selling anything we can't use helps keep us afloat with the traders.  If you wanted to drop off a companion or two to assist in one of the runs, I'd appreciate it.", { "interlocutor" }),
    replies = { { text = ccb.content.text("I'll think about it."), next_topic = "TALK_RANCH_SCAVENGER_1" } },
}
