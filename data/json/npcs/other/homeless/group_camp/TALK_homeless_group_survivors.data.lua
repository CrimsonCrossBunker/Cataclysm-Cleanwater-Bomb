local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_HOMELESS_GROUP_SURVIVOR_FRIENDS",
    line = ccb.content.text("Oh, they're right over there, and one of us is in that tent over there.  They handle any stuff we manage to scavenge, so feel free to trade for what you want."),
    replies = { { text = ccb.content.text("Alright."), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_HOMELESS_GROUP_SURVIVOR_NOTRADE",
    line = ccb.content.text("Thanks for the offer, but I don't have anything to spare right now.  One of my buddies over in that tent handles stuff like this, though.  You might find something."),
    replies = { { text = ccb.content.text("Alright."), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_HOMELESS_GROUP_SURVIVOR_BROKER",
    line = ccb.content.text("Well, they were the brightest of us when all hell broke loose.  They managed to get us some food and weapons early on.  I guess that just kinda made them the leader."),
    replies = { { text = ccb.content.text("Hmm."), next_topic = "TALK_NONE" } },
}
