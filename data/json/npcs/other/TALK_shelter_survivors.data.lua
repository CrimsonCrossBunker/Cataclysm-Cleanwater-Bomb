local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_EVAC_SURVIVOR_STORY",
    line = ccb.content.gendered_line("I found this emergency shelter when I was running from the chaos back in the cities.  Fortunately, the place hadn't been looted yet and there weren't any <zombies> lurking around; just the spot to stay 'till who knows when.", { "interlocutor" }),
    replies = { { text = ccb.content.text("Wow."), next_topic = "TALK_NONE" } },
}
