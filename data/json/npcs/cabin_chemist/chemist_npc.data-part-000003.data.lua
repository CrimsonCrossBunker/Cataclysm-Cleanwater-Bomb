local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_CABIN_CHEMIST_HOME",
    line = ccb.content.gendered_line("Not my place, just somewhere I ended up.  Some old shack, maybe a hunting cabin or something more… criminal, at least judging by some of what I found on the shelves.  You certainly wouldn't attract much attention synthesizing illegal substances all the way out here, that's all I'm saying.  I found it while I was trying to escape all the <zombies> in the city, and I decided to stay.", { "interlocutor" }),
    replies = { { text = ccb.content.text("Hmm."), next_topic = "TALK_NONE" } },
}
